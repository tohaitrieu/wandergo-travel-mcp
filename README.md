# WanderGo Travel MCP — plugin + skill

[Tiếng Việt](#tiếng-việt) · [English](#english)

Remote MCP server: `https://mcp.wandergo.vn/mcp` (Streamable HTTP, OAuth 2.1 for account tools). This repository holds only the Claude Code plugin, the agent skill and docs — no server code, no keys.

---

## Tiếng Việt

**WanderGo** là ứng dụng tìm bạn đồng hành du lịch ở Việt Nam. Plugin này cho trợ lý AI:

- **Tìm (không cần đăng nhập):** sự kiện văn hoá, kèo (cafe, bia, trà đá, chụp ảnh…), lịch trình mẫu, chuyến đi công khai, địa danh (mùa đẹp, khí hậu), thổ địa, bài cộng đồng, cẩm nang.
- **Làm thay bạn (đăng nhập WanderGo qua OAuth):** lên kèo, vô kèo, báo đi, tạo chuyến đi hoặc chép lịch trình mẫu, check-in, đánh giá, lưu sự kiện. Trợ lý luôn xác nhận với bạn trước khi đăng.

### Cài đặt

**Claude Code**

```
/plugin marketplace add tohaitrieu/wandergo-travel-mcp
/plugin install wandergo@wandergo-travel-mcp
```

Plugin thêm máy chủ MCP `wandergo` và skill `wandergo`. Lần đầu cần tạo / tham gia gì đó, chạy `/mcp` để đăng nhập WanderGo.

**Claude (web · Desktop · mobile)**

1. Cài đặt → Connectors → Add custom connector → URL `https://mcp.wandergo.vn/mcp`.
2. Skill (tuỳ chọn): chạy `make skill-zip` (hoặc `scripts/build-skill-zip.sh`) rồi tải `dist/wandergo-skill.zip` lên Cài đặt → Capabilities → Skills.

**ChatGPT, Gemini CLI, Cursor, VS Code, Devin Desktop, Zed, SDK** — hướng dẫn từng ứng dụng: https://wandergo.vn/travel-mcp/

### Quyền riêng tư và giới hạn

- Chỉ trả về những gì trang công khai của WanderGo đã hiện; không danh tính, liên hệ hay vị trí của người khác.
- Hạn mức mỗi ngày cho nội dung tạo qua trợ lý AI (gói Premium cao gấp 3), cùng luật gói Free/Premium và kiểm duyệt như app.
- Chưa đính kèm ảnh qua trợ lý — thêm ảnh trong app.
- Thu hồi quyền trợ lý bất cứ lúc nào: app → Cài đặt → Kết nối AI, hoặc web → menu tài khoản → Kết nối AI; có hiệu lực ngay. Nhật ký thao tác giữ 3 tháng.
- Chính sách: https://wandergo.vn/privacy/ · Điều khoản: https://wandergo.vn/dieu-khoan/ · Hỗ trợ: https://wandergo.vn/lien-he/ · hello@wandergo.vn

---

## English

**WanderGo** is a travel-companion app for Vietnam. This plugin lets an AI assistant:

- **Find (no sign-in):** cultural events, meetups ("kèo": coffee, beer, street tea, photo walks…), itinerary templates, public trips, destinations (best months, climate), local guides, community posts, travel guides.
- **Act for you (WanderGo sign-in via OAuth):** host or join meetups, RSVP, create a trip or copy a template, check in, review, save events. The assistant confirms with you before posting.

### Install

**Claude Code**

```
/plugin marketplace add tohaitrieu/wandergo-travel-mcp
/plugin install wandergo@wandergo-travel-mcp
```

The plugin adds the `wandergo` MCP server and the `wandergo` skill. The first time an action needs your account, run `/mcp` to sign in to WanderGo.

**Claude (web · Desktop · mobile)**

1. Settings → Connectors → Add custom connector → URL `https://mcp.wandergo.vn/mcp`.
2. Skill (optional): run `make skill-zip` (or `scripts/build-skill-zip.sh`) and upload `dist/wandergo-skill.zip` under Settings → Capabilities → Skills.

**ChatGPT, Gemini CLI, Cursor, VS Code, Devin Desktop, Zed, SDKs** — per-app setup: https://wandergo.vn/travel-mcp/

### Privacy and limits

- Returns only what WanderGo's public pages already show; never other people's identities, contacts or locations.
- Daily limits for AI-created content (3× on Premium), plus the app's Free/Premium rules and moderation.
- Photos can't be attached through assistants yet — add them in the app.
- Revoke an assistant any time: app → Settings → AI connections, or web → account menu → AI connections; it takes effect immediately. Action logs are kept for 3 months.
- Privacy: https://wandergo.vn/privacy/ · Terms: https://wandergo.vn/dieu-khoan/ · Support: https://wandergo.vn/lien-he/ · hello@wandergo.vn

---

## Repository layout

```
.claude-plugin/marketplace.json   marketplace "wandergo-travel-mcp" listing plugin "wandergo"
.claude-plugin/plugin.json        plugin manifest
.mcp.json                         remote MCP server (HTTP, OAuth — no keys)
skills/wandergo/                  agent skill (SKILL.md + reference/tools.md) — canonical copy
scripts/build-skill-zip.sh        builds dist/wandergo-skill.zip for Claude.ai upload
```

Check before publishing: `claude plugin validate .`

License: MIT — see [LICENSE](LICENSE).
