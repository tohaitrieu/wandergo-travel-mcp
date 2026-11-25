---
name: wandergo
description: Find and act on WanderGo travel content in Vietnam through the WanderGo MCP connector (https://mcp.wandergo.vn/mcp) - cultural events (sự kiện), open meetups (kèo - cafe, beer, trà đá, photo walks), group trips and itinerary templates (lịch trình mẫu), destinations, local guides (thổ địa), community posts and travel guides (cẩm nang). Use when the user asks what is on, who to meet, where to go or how to plan a trip somewhere in Vietnam, or wants to host a meetup (lên kèo), join or RSVP, create a trip (from scratch or a template), check in, review a place, or save an event on WanderGo, in Vietnamese or English.
---

# WanderGo

WanderGo (wandergo.vn) is a Vietnamese travel-companion app. Its MCP connector requires the user to sign in to WanderGo (OAuth) for every tool: read-only discovery tools and account tools that act as the user. Exact parameters: [reference/tools.md](reference/tools.md).

## Pick the tool

| User wants | Call |
| --- | --- |
| Not sure what kind of thing ("Đà Lạt có gì?") | `search_wandergo` → then the specific get/search tool |
| Events in a place / on dates ("cuối tuần này Hà Nội có gì?") | `search_events` → `get_event` |
| People to hang out with near X ("kèo cafe tối nay quanh Hồ Gươm") | `search_meetups` → `get_meetup` |
| A ready-made itinerary ("lịch trình 3 ngày Đà Lạt") | `search_trip_templates` → `get_trip` |
| Plan a trip from a template | `search_trip_templates` → user picks → `create_trip_from_template` |
| Plan a trip from scratch | `create_trip` |
| When to go / what a place is like | `search_destinations` → `get_destination` (best months, climate, rating) |
| A local host | `search_local_guides` |
| A trip leader for an area ("trưởng đoàn hay dẫn Hà Giang") | `search_trip_leads` → join one of their `upcomingTrips` or open the profile `url` (no direct contact) |
| Real experiences / tips | `search_posts` (community) · `search_guides` (WanderGo articles) |
| Go to an event with others | `get_event` → its `meetups[]`; none fit → offer `create_meetup` with `eventSlug` |
| Host / join / RSVP a meetup | `create_meetup` · `join_meetup` · `rsvp_next` |
| Check in · review · save | `check_in` · `post_review` · `save_event` |
| "What am I going to?" | `my_upcoming_meetups` |
| Log a trip expense ("Ghi 350k ăn trưa chuyến Đà Lạt") | `my_trips` if unsure → confirm → `add_trip_expense` |
| Trip money summary ("ai còn nợ ai?") | `get_trip_report` (or `get_trip_expenses` for the list) |
| My numbers ("tháng này check-in bao nhiêu nơi?") | `my_stats {period}` · host's meetup numbers → `my_meetup_stats` |

Search first, act second: take slugs and ids from search results instead of guessing them. Ids may also be wandergo.vn URLs.

### Template → trip (the most common plan flow)

1. `search_trip_templates {place:"Đà Lạt", days:3, language}` and show 2–3 options (title, days, style, budget, link).
2. If the user wants details, `get_trip {slug}` for the day-by-day itinerary.
3. The user picks one → confirm → `create_trip_from_template {templateSlug}` → share the returned `url` and tell them to set their own dates and group size there (the copy starts from the template's sample dates).

## Before any account tool

Account tools publish under the user's name (or their meetup alias) and are visible to others.

1. Collect the required fields (see reference). Ask for missing ones in one short question; never invent times, places or prices.
2. Show a one-line summary and get an explicit yes — vi: "Lên kèo «Cafe sáng» 9:00 thứ Bảy 28/11 tại Cafe Giảng, tối đa 4 người — mình đăng nhé?" · en: "Create the meetup "Morning coffee" at Cafe Giảng, Sat 28 Nov 9:00, up to 4 people — shall I post it?"
3. Call once. `status: "already_done"` means the same request was already applied; do not repeat it.
4. Every tool needs a WanderGo sign-in. If a call returns 401 or the connector asks to connect, let the user finish sign-in, then retry.

Errors are readable text (plan limits, moderation, daily limits for AI-created content, "already checked in today"). Relay them plainly; suggest the app or web when a limit is hit; never retry around a limit.

**Photos:** the connector cannot attach images yet. Post text through the tool and tell the user to add photos in the WanderGo app (the usual size, count-per-post and plan limits apply there).

## Money

- Amounts are whole numbers: "350k" → 350000, "1,2tr" / "1.2 triệu" → 1200000, "2 củ" → 2000000. Default currency VND.
- Expenses go into the trip's budget in the app; the split follows the trip's settlement (equal or custom), so there is no `paidBy` / `splitAmong` field — explain that if asked, and point to the trip page to adjust the settlement.
- Categories: food, transport, accommodation, sightseeing, shopping, other.

## Dates, places, language

- Vietnam time (UTC+7). `startsAt` is ISO 8601 with offset (`2026-11-28T09:00:00+07:00`); dates are `YYYY-MM-DD`. Resolve "tối nay", "cuối tuần", "this weekend" against today in Vietnam; `when` accepts `today | weekend | month | upcoming`.
- Places are Vietnamese names ("Hà Nội", "Đà Lạt", "Phố cổ Hội An"); a chain branch works for meetups and check-ins ("Highlands Coffee Nhà Thờ Lớn"). Not found → ask for a landmark or the city.
- `language: "vi"` when the user writes Vietnamese, otherwise `"en"`. Reply in the user's language; keep names as returned.

## Links, privacy, etiquette

- Every result has a wandergo.vn `url`; give it as-is (opens the app if installed). Use it for what tools don't cover: chat, editing, paying, cancelling.
- Results never contain people's contacts or locations; don't try to infer them. Hosts may use an alias; posts show a display name only.
- Don't create, check in or review anything the user didn't ask for; reviews use the user's own words and experience. Suggest public venues for meetups with strangers.

## Examples

- "Có lễ hội gì ở Huế tháng 12 không?" → `search_events {place:"Huế", from:"2026-12-01", to:"2026-12-31", language:"vi"}`.
- "Find me a photo walk in Saigon this weekend" → `search_meetups {place:"Hồ Chí Minh", kind:"photo", when:"weekend", language:"en"}`; none → offer to host one.
- "Gợi ý lịch trình 3 ngày Đà Lạt cho nhóm 4 người tháng 12" → `search_trip_templates {place:"Đà Lạt", days:3, month:12}` → user picks → confirm → `create_trip_from_template {templateSlug}`.
- "Lên kèo trà đá 8h tối mai ở Nhà Thờ Lớn, 5 người" → confirm → `create_meetup {kind:"tra_da", title:"Trà đá Nhà Thờ Lớn", place:"Nhà Thờ Lớn Hà Nội", startsAt:"<tomorrow>T20:00:00+07:00", capacity:5}`.
- "When is the best time to visit Sa Pa?" → `search_destinations {query:"Sa Pa"}` → `get_destination {id}`.
