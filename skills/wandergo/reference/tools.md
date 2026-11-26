# WanderGo MCP tools — parameters

Server: `https://mcp.wandergo.vn/mcp` (Streamable HTTP). All tools accept `language: "vi" | "en"` (default `vi`). `?` = optional. Every result includes `url` (wandergo.vn page).

## Discovery (read-only; WanderGo sign-in required like every tool)

**search_events** — upcoming cultural events.
`place?` (2–80 chars; filters to that province), `type?` (`culture_arts | exhibition | sports | community`), `when?` (`today | weekend | month | upcoming`), `from?`/`to?` (`YYYY-MM-DD`, override `when`), `limit?` (1–20, default 10).
Returns `{ place, total, events[{ slug, title, typeLabel, startDate, endDate, ongoing, place, address, organizer, isFree, imageUrl, openMeetupCount, url }], listUrl }`.

**get_event** — `slug` (or event URL). Adds `description` (≤1500 chars), `audience`, `officialLink` (organizer/ticket page), `meetups[{ title, nextAt, memberCount, url }]`.

**search_meetups** — open, upcoming meetups near a place.
`place?` or `lat?`+`lng?` (one is required), `radiusKm?` (1–150, default 25), `kind?` (`cafe | beer | tra_da | photo | food | walk | cinema | event | other`), `when?`, `limit?`.
Returns `meetups[{ id, title, kind, kindLabel, placeName, area, nextAt, recurrence, memberCount, capacity, seatsLeft, isOfficial, rating{average,count}, url }]`.

**get_meetup** — `id` (or meetup URL). Adds `status`, `note`, `endsOn`, `interestedCount`.

**search_trip_templates** — itinerary templates (lịch trình mẫu). `place?`, `days?` (±1), `style?` (keyword), `month?` (1–12, matched with the destination's best months), `limit?`.
Returns `templates[{ slug, title, days, destination, province, from, styles, budgetPerPerson, copies, url }]` — pass `slug` to `create_trip_from_template`.

**get_trip** — `slug` (trip or template, or URL). Returns `{ slug, title, isTemplate, startDate, endDate, days, from, destination, seatsLeft, budgetPerPerson, styles, description, itinerary[{ day, items[{ time, name, place }] }], url }`. Public trips only; members never listed.

**search_trip_leads** — trip leaders (trưởng đoàn) in an area. `place` (required), `style?`, `limit?` (≤10) → `leads[{ name, avatar, tagline, specialties, isLocalHost, rating{average,count}, tripsLedHere, upcomingTrips[{ slug, title, startDate, url }], url }]`, ranked by host rating × trips led there. Public profiles and public trips only; no contact data — users contact a leader by joining a trip or following on WanderGo.

**search_posts** — community posts / check-ins. `query?`, `place?`, `limit?` → `posts[{ excerpt, author (display name), place, trip, postedAt, reactions, url }]`.

**search_destinations** — `query` → `destinations[{ id, name, url }]`. **get_destination** — `id` → `{ summary, bestMonths, elevationM, population, wikipediaUrl, rating, sources }`.

**search_local_guides** — `province?`, `limit?` → `guides[{ name, tagline, specialties, areas, verified, rating, url }]` (no contact details).

**search_guides** — `query` → WanderGo travel articles (cẩm nang) `guides[{ title, meta, url }]`. **search_wandergo** — `query` → grouped hits: meetups, events, trips, places, localGuides, posts, guides, help.

**search_help** — `query` (optional; a general one like "hướng dẫn sử dụng WanderGo" or empty → `overview: true` + every article), `limit` → user-guide articles `articles[{ section, sectionTitle, slug, title, summary, url }]`. **get_help_article** — `url` or `section` + `slug` → `{ title, summary, url, content }` (full article as light markdown: steps, tips, FAQ).

## Account (OAuth sign-in; acts as the user)

Each returns `{ status: "created" | "already_done" | "updated", id, url, message }` except `my_upcoming_meetups`.

| Tool | Scope | Required | Optional |
| --- | --- | --- | --- |
| `create_meetup` | meetups:write | `kind`, `title` (3–80), `place` (venue/landmark, searched like the app), `startsAt` (ISO 8601 with offset, future) | `near{lat,lng}`, `recurrence` (`none` default, `daily`, `weekly`, `monthly`, `quarterly`), `endsOn` (`YYYY-MM-DD`), `capacity` (2–100000; one-off meetups count the host), `note` (≤300), `eventSlug` |
| `join_meetup` | meetups:write | `id` | — |
| `rsvp_next` | meetups:write | `id`, `going` (boolean) | — |
| `create_trip` | trips:write | `title` (5–200), `destination`, `from` (departure city), `startDate`, `endDate` (`YYYY-MM-DD`) | `maxMembers` (1–50), `budgetPerPerson` (VND), `visibility` (`public` default, `unlisted`, `private`), `description` (≤2000) |
| `create_trip_from_template` | trips:write | `templateSlug` (or template URL) | — |
| `post_review` | reviews:write | `target` (`location` or `meetup`), `stars` (1–5) | `place` or `locationId` (location), `meetupId` (meetup the user attended), `comment` (≤280). Posting again updates the user's review |
| `check_in` | checkins:write | `place` or `locationId` | `near{lat,lng}`, `caption` (≤500). One check-in per place per day |
| `save_event` | saves:write | `slug` | — |
| `my_trips` | trips.read.mine | — | returns `trips[{ slug, title, destination, startDate, endDate, phase, members, url }]` |
| `add_trip_expense` | trips.expenses.write | `trip` (name, slug or URL), `amount` (whole number), `category` (food · transport · accommodation · sightseeing · shopping · other) | `currency` (VND), `note` (≤300), `date` (YYYY-MM-DD). Members only; 30/day (Premium 90) |
| `get_trip_expenses` | trips.read.mine | `trip` | returns total, byCategory, byDay, byLoggedBy, recent |
| `get_trip_report` | trips.read.mine | `trip` | returns expenses, fund (contributed/spent/left), budget vs actual, settlement members + transfers (who pays whom), itinerary progress, summary |
| `my_stats` | account.stats.read | — | `period` (7d · 30d · all) → trips by phase, meetups hosted/joined, check-ins (places, provinces), posts, saves, followers; content views not available yet |
| `my_meetup_stats` | account.stats.read | `meetup` (id/URL, you host) | members, capacity, goingNextSession, interested, dateVotes, rating |
| `my_upcoming_meetups` | meetups:read | — | returns `meetups[{ id, title, nextAt, placeName, role: host|member, goingNext, url }]` |

Notes:
- Identical create requests within 10 minutes return `already_done` with the first result instead of duplicating.
- Free/Premium plan limits, moderation and per-day limits for AI-created content apply exactly as in the app; their messages come back as tool errors.
- Daily limits for AI-created content: Free — 5 meetups, 3 trips, 10 reviews, 10 check-ins, 20 joins, 60 place searches; Premium (Pro/Ultimate) — 3×.
- **Images:** not supported yet. When added, uploads will go through WanderGo's normal upload path with its limits (per-file size, 5 MB request body, images per post/review, plan limits) — never a separate path.
- Revoking the assistant (app: Settings → AI connections · web: account menu → AI connections) takes effect on the next call. Action logs are kept 3 months. Support: hello@wandergo.vn.
- Not available through the connector: chat, editing or deleting content, payments, profile changes.
