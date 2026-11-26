# Changelog

## 0.6.0 — 2026-11-26

- New tools `search_help` and `get_help_article`: the official WanderGo user guide (hướng dẫn sử dụng) — accounts, meetups, events, trips, travel buddies, safety, connecting AI assistants, FAQ. `search_wandergo` also returns `help` hits. Skill routes "how do I…" questions to them.

## 0.5.0 — 2026-11-25

- The connector now requires WanderGo sign-in (OAuth) for every tool, including search; docs and skill updated. Also listed in Claude's directory: https://claude.ai/directory/wandergo.

## 0.4.0 — 2026-11-25

- Plugin renamed `wandergo-travel` (install: `claude plugin install wandergo-travel@wandergo-travel-mcp`).
- Remote MCP server declared in `plugin.json` (`mcpServers.wandergo`, HTTP, OAuth).
- Plugin icon added; build scripts removed (zip `skills/wandergo` by hand for Claude.ai upload).

## 0.3.0 — 2026-11-24

- Plugin `wandergo` (marketplace `wandergo-travel-mcp`) with the remote MCP server `https://mcp.wandergo.vn/mcp`.
- Skill `wandergo`: intent → tool map, template → trip flow, confirmation before account actions, Vietnam time, vi/en, links, privacy.
- Tools covered: search_events, get_event, search_meetups, get_meetup, search_trip_templates, get_trip, search_posts, search_destinations, get_destination, search_local_guides, search_trip_leads, search_guides, search_wandergo (public); create_meetup, join_meetup, rsvp_next, create_trip, create_trip_from_template, post_review, check_in, save_event, my_upcoming_meetups, my_trips, add_trip_expense, get_trip_expenses, get_trip_report, my_stats, my_meetup_stats (OAuth).
