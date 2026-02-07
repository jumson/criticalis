# Criticalis — Roadmap & Technical Reference

> A collaborative platform for crowdsourced correction and annotation of public domain works.
> Initial subject: *The Treasury of David* by C. H. Spurgeon (7 volumes).

This document serves as both a **technical roadmap** and a **decision log**. It is organized into phases, each with clear goals, recommended technologies, and explicit decision points where we'll evaluate before proceeding.

---

## Table of Contents

- [Guiding Principles](#guiding-principles)
- [Architecture Overview](#architecture-overview)
- [Recommended Tech Stack](#recommended-tech-stack)
- [Phase 0 — Foundation & Spike](#phase-0--foundation--spike)
- [Phase 1 — Reader MVP](#phase-1--reader-mvp)
- [Phase 2 — Corrections Workflow](#phase-2--corrections-workflow)
- [Phase 3 — Community Layer](#phase-3--community-layer)
- [Phase 4 — Curation & Publishing](#phase-4--curation--publishing)
- [Phase 5 — Scale & Polish](#phase-5--scale--polish)
- [Phase 6 — Multi-Corpus & TEI Support](#phase-6--multi-corpus--tei-support)
- [Future Horizons](#future-horizons)
- [Technology Reference](#technology-reference)

---

## Guiding Principles

1. **Simplicity for contributors.** The people best suited to correct Spurgeon are not software engineers. Every interaction must be as intuitive as posting a comment on social media.
2. **Fidelity to the text.** The platform must always show the *original* OCR text alongside any proposed changes. Nothing is silently altered.
3. **Incremental complexity.** Start with a working reader and a correction form. Add community features only after the core loop works.
4. **Public and open.** All source, all corrections, all discussion — publicly visible. The improved texts themselves remain in the public domain.
5. **Small footprint.** Prefer lightweight tools. This is a community project, not an enterprise product.

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────┐
│                    Browser Client                    │
│                                                     │
│  ┌─────────────┐  ┌──────────────┐  ┌───────────┐  │
│  │  ePub Reader │  │  Annotation  │  │ Community │  │
│  │ (foliate-js)│  │    Layer     │  │   UI      │  │
│  └──────┬──────┘  └──────┬───────┘  └─────┬─────┘  │
│         └────────────────┼────────────────┘         │
│                          │                          │
└──────────────────────────┼──────────────────────────┘
                           │ HTTP
┌──────────────────────────┼──────────────────────────┐
│                     OpenResty                        │
│            (reverse proxy, rate limiting)             │
└──────────────────────────┼──────────────────────────┘
                           │
┌──────────────────────────┼──────────────────────────┐
│                    SvelteKit Server                  │
│                                                     │
│  ┌──────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │ API      │  │ Correction   │  │ Auth         │  │
│  │ Routes   │  │ Engine       │  │ (Better Auth)│  │
│  └────┬─────┘  └──────┬───────┘  └──────────────┘  │
│       │               │                             │
│       │    ┌──────────┴──────────┐                  │
│       │    │  @smoores/epub      │                  │
│       │    │  (ePub modification)│                  │
│       │    └─────────────────────┘                  │
│       │                                             │
└───────┼─────────────────────────────────────────────┘
        │
┌───────┼─────────────────────────────────────────────┐
│       ▼          PostgreSQL                         │
│  ┌──────────┐  ┌───────────┐  ┌──────────────────┐ │
│  │ users    │  │corrections│  │ epub_documents   │ │
│  │ sessions │  │ votes     │  │ document_versions│ │
│  │ profiles │  │ comments  │  │ applied_changes  │ │
│  └──────────┘  └───────────┘  └──────────────────┘ │
└─────────────────────────────────────────────────────┘
```

All three services (OpenResty, SvelteKit, PostgreSQL) run as Docker containers orchestrated by Docker Compose. See [DEPLOYING.md](DEPLOYING.md) for operational details.

---

## Recommended Tech Stack

| Layer | Technology | License | Notes |
|-------|-----------|---------|-------|
| **Framework** | [SvelteKit](https://kit.svelte.dev/) | MIT | Smallest bundles, fast hydration, SSR built-in |
| **ePub Rendering** | [foliate-js](https://github.com/johnfactotum/foliate-js) | MIT | Modern, native ES modules, direct DOM access |
| **Annotation UI** | [text-annotator-js](https://github.com/recogito/text-annotator-js) | BSD-3 | W3C Web Annotation compatible, lightweight |
| **ePub Modification** | [@smoores/epub](https://www.npmjs.com/package/@smoores/epub) | MIT | Server-side ePub3 inspection and modification |
| **Database** | [PostgreSQL](https://www.postgresql.org/) | PostgreSQL License | Full-text search, JSONB, audit capabilities |
| **ORM** | [Drizzle ORM](https://orm.drizzle.team/) | Apache 2.0 | Type-safe, SQL-like, lightweight |
| **Auth** | [Better Auth](https://www.better-auth.com/) | MIT | OSS, framework-agnostic, successor to Auth.js |
| **Text Encoding** | [TEI P5 XML](https://tei-c.org/guidelines/p5/) | Open | Standard for digital humanities texts; Phase 6 for EEBO/ECCO/TCP corpus |
| **Notifications** | [Novu](https://github.com/novuhq/novu) | MIT (core) | In-app + email, workflow engine |
| **Real-time** | Server-Sent Events (native) | — | Built into SvelteKit, no extra dependency |
| **Reverse Proxy** | [OpenResty](https://openresty.org/) | BSD | nginx + Lua, rate limiting, security headers |
| **Deployment** | Docker Compose (self-hosted) | — | Three-container stack: app, db, proxy |

### Why not Git under the hood?

The original README envisioned Git as the backend for tracking changes. After research, a **database-first approach** is recommended instead:

- Users submit word/phrase-level corrections — far more granular than file-level diffs
- Git's merge model is designed for code, not for hundreds of small text fixes to XML
- A database gives you voting, status tracking, and querying for free
- Managing a Git branch per correction creates massive overhead
- You can still **export to Git** periodically — generate commits from approved batches of corrections for a public audit trail

If at any point the project needs true distributed/offline editing (Phase 5+), CRDTs via [Yjs](https://github.com/yjs/yjs) can be layered on.

---

## Phase 0 — Foundation & Spike ✓

**Goal:** Prove the core rendering and text-selection loop works before committing to a stack.

**Status: Complete** (Feb 7, 2026) — all core rendering proven, foliate-js selected.

### Tasks

- [x] **0.1** — Set up a minimal SvelteKit project
- [x] **0.2** — Integrate foliate-js to render one volume of *Treasury of David* in the browser
- [x] **0.3** — Implement text selection: user selects a word or phrase and the selection is captured (logged to console with CFI position tracking)
- [x] **0.4** — Test with the actual ePub files in `sources/` — confirmed OCR content renders correctly, page navigation works, and the XML structure can be targeted
- [ ] **0.5** — Spike: use `@smoores/epub` to programmatically apply a test correction to one XML file and verify the ePub still renders correctly *(deferred to start of Phase 2 — not blocking the reader MVP)*

### Decision Point: ePub Renderer — DECIDED

> **foliate-js** was selected and integrated via git submodule (pinned commit).
>
> - Text selection works reliably and provides CFI-based position data
> - Rendering of the Google Books OCR ePubs is correct
> - Paginated and scrolled modes both work
> - epub.js was not needed as a fallback
>
> **`@smoores/epub` evaluation** is deferred to Phase 2 when server-side ePub modification is actually needed. The package is already in `package.json` (as `@storyteller-platform/epub`).

### Deliverable

~~A local dev environment where you can open a volume, select text, and see the precise XML location logged to the console.~~ Done.

---

## Phase 1 — Reader MVP ✓

**Goal:** A deployed web app where anyone can read *The Treasury of David* in their browser.

**Status: Complete** (Feb 7, 2026) — reader is functional with all features, Docker deployment ready.

### Tasks

- [x] **1.1** — Volume selection screen with styled CSS book covers showing title, volume number, and psalm range
- [x] **1.2** — Full reader UI: table of contents sidebar, page/chapter navigation (arrow keys + buttons), bookmarking via localStorage (save/restore reading position per volume)
- [x] **1.3** — Responsive layout — mobile breakpoints at 600px across all pages (header, volume grid, reader toolbar, TOC overlay)
- [x] **1.4** — SEO: Open Graph and Twitter Card meta tags, JSON-LD structured data (`CollectionPage` on home, `Book` on reader), descriptive titles
- [x] **1.5** — Deploy via Docker Compose: three-container stack (SvelteKit app, PostgreSQL 17, OpenResty proxy) with configurable domain, rate limiting, and security headers
- [x] **1.6** — ePub storage: filesystem-based, mounted as a Docker volume at `/data/sources`, configurable via `SOURCES_PATH` env var

### Decision Point: Deployment — DECIDED

> **Self-hosted Docker Compose with OpenResty** was chosen over Railway/Fly.io.
>
> - The project owner has a VPS with an existing OpenResty setup
> - Docker Compose provides full control and avoids vendor lock-in
> - OpenResty handles reverse proxy, rate limiting, and security headers
> - The `.env.example` documents all configuration options
> - See [DEPLOYING.md](DEPLOYING.md) for full setup instructions

### Decision Point: Rendering Strategy — OPEN

> Now that the reader is live, gather feedback:
>
> - **Is the reading experience good enough?** Fast load times, readable typography, smooth navigation?
> - **Are there rendering quirks** with the Google Books ePub structure that need workarounds?
> - **Should we pre-process the ePubs** into a cleaner intermediate format (e.g., simplified HTML or Markdown) rather than rendering raw OCR XML? This would make corrections easier to apply and the content easier to search.
>   - Pre-processing trade-off: upfront effort, but dramatically simplifies everything downstream.

### Deliverable

~~A publicly accessible web reader for all 7 volumes. No accounts, no corrections — just reading.~~ Done. Deploy with `docker compose up -d`.

### Validation (Feb 7, 2026, 7:07 AM EST)

Production build (`npm run build`) and server (`node build`) tested against all routes:

| Test | Result |
|------|--------|
| All 7 volume pages (`/read/vol-1` … `/read/vol-7`) | 200 OK |
| All 7 ePub API endpoints (`/api/epub/vol-1` … `/api/epub/vol-7`) | 200 OK, `application/epub+zip`, ~1.4 MB |
| Landing page `/` | 200 OK, 7 volume covers rendered |
| About page `/about` | 200 OK |
| Invalid volume `/read/vol-99` | 404 |
| Invalid API `/api/epub/vol-99` | 404 |
| Unknown route `/nonexistent` | 404 |
| SEO: 1 `<meta name="description">` per page | Pass (duplicate from `app.html` fixed) |
| SEO: JSON-LD on `/` and `/read/*` | Pass (`CollectionPage`, `Book`) |
| SEO: Open Graph + Twitter Card tags | Pass |
| CSP header present | Pass |
| ePub caching (`max-age=86400`) | Pass |
| Viewport meta for responsive | Pass |
| Bookmark button in reader toolbar | Pass |

Not yet tested (requires Docker daemon or browser): Docker Compose stack, OpenResty proxy, foliate-js client-side rendering, localStorage bookmarking.

---

## Phase 2 — Corrections Workflow ← NEXT

**Goal:** Authenticated users can submit corrections and footnotes. A curator can review and apply them.

### Groundwork already done

The following infrastructure from Phase 0/1 is ready for Phase 2:

- **Database schema** exists in `src/lib/server/schema.ts`: `user`, `session`, `account`, `verification`, `correction` (with status/type enums), `vote`, `comment`
- **Better Auth** configured with email/password (`src/lib/server/auth.ts`), OAuth provider stubs in `.env.example`
- **Text selection** is captured in the reader (`handleTextSelection` function) — ready to wire into a correction popup
- **`@storyteller-platform/epub`** (`@smoores/epub`) is installed as a dependency

### Tasks

- [ ] **2.0** — Run the deferred 0.5 spike: use `@smoores/epub` to apply a test correction to a Google Books ePub and verify it still renders. If it fails, fall back to cheerio/fast-xml-parser for direct XML manipulation.
- [ ] **2.1** — Run database migrations (Drizzle Kit) to create the schema tables in PostgreSQL
- [ ] **2.2** — Wire up Better Auth routes: sign up, sign in, sign out, session management. Add at least one social login (Google or GitHub).
- [ ] **2.3** — Correction submission UI:
  - User selects text in the reader
  - Popup with two tabs: "Suggest Correction" and "Add Footnote"
  - Correction: shows original text, provides input for replacement text and optional explanation
  - Footnote: provides input for explanatory note to be attached to the selected phrase
  - Submits structured data to the API
- [ ] **2.4** — Correction list view: see all pending corrections for a given Psalm/chapter, filterable by status (pending, approved, rejected)
- [ ] **2.5** — Curator dashboard:
  - Queue of pending corrections, sorted by votes (once voting exists) or chronologically
  - Side-by-side view: original text vs. proposed correction, with surrounding context
  - Approve / reject / request changes buttons
  - On approval: server applies the correction to the ePub XML and creates a new document version
- [ ] **2.6** — Visual indicators in the reader: subtle highlights or icons showing where corrections have been submitted (so users don't duplicate effort)

### Decision Point: Correction Granularity

> After initial usage, evaluate:
>
> - **Are users submitting single-word fixes, phrase-level corrections, or paragraph rewrites?** This determines how the location-targeting system needs to work.
> - **Is XPath/CFI sufficient for locating corrections**, or do we need a more robust anchoring strategy (e.g., text quoting with surrounding context, similar to the W3C Web Annotation selector model)?
>   - If corrections frequently "drift" because the XML changes, switch to **TextQuoteSelector** (match by surrounding text rather than position).

### Decision Point: Annotation Library

> After building 2.3:
>
> - **Is the custom popup sufficient**, or do users need richer annotation features (multi-selection, annotation threading, etc.)?
>   - If richer features are needed → integrate [text-annotator-js](https://github.com/recogito/text-annotator-js) from Recogito
>   - If the simple popup works → keep it custom (less dependency weight)

### Deliverable

Authenticated users can submit corrections. A curator can review and apply them. The "community-improved" version of the text begins to take shape.

---

## Phase 3 — Community Layer

**Goal:** Contributors can vote on and discuss corrections. Reputation emerges organically.

### Tasks

- [ ] **3.1** — Voting on corrections: upvote/downvote (one vote per user per correction), displayed as net score
- [ ] **3.2** — Threaded comments on corrections: contributors can discuss the merits of a proposed change
- [ ] **3.3** — User profiles: public page showing a user's submitted corrections, approval rate, and total contribution score
- [ ] **3.4** — Activity feed: "Recent corrections" page showing latest submissions, approvals, and active discussions across all volumes
- [ ] **3.5** — Basic notification system:
  - In-app: "Your correction was approved" / "New comment on your correction" / "Someone suggested a correction to a passage you also corrected"
  - Email digest (optional, user-configurable)
  - Evaluate [Novu](https://github.com/novuhq/novu) vs. a simpler custom implementation
- [ ] **3.6** — Curator tools: sort pending corrections by community vote score, filter by volume/chapter, bulk actions
- [ ] **3.7** — Contributor guidelines page: what makes a good correction, how footnotes should be formatted, community standards

### Decision Point: Notification Infrastructure

> After building 3.5:
>
> - **Is Novu worth the operational overhead**, or is a simple database-backed notification table + email via [Resend](https://resend.com/) sufficient?
>   - For < 1,000 active users, a custom solution is likely fine
>   - For > 1,000 active users, Novu's workflow engine and delivery guarantees become valuable

### Decision Point: Moderation

> As the community grows:
>
> - **Is community self-governance (voting + curator review) sufficient**, or do we need additional moderation tools?
>   - Spam/abuse prevention: rate limiting, account age requirements for voting
>   - User reporting system
>   - Temporary bans for bad actors
>   - Trusted contributor roles (auto-approve corrections from high-reputation users?)
>
> Build moderation tooling reactively based on actual problems, not speculatively.

### Deliverable

A living community around the text. Corrections are discussed and voted on. The curator has signal from the community about which changes matter most.

---

## Phase 4 — Curation & Publishing

**Goal:** Produce and distribute polished, corrected ePub editions.

### Tasks

- [ ] **4.1** — Version management: the curator can create named "editions" (e.g., "Community Edition v1.0 — January 2027") that snapshot the current state of all approved corrections
- [ ] **4.2** — Diff viewer: show all changes between two editions (or between the original OCR and the current state)
- [ ] **4.3** — ePub export: generate a downloadable ePub file of any edition, with:
  - All approved corrections applied
  - Footnotes properly formatted and linked
  - A colophon page crediting contributors
- [ ] **4.4** — PDF export (stretch goal): generate a printable PDF from the corrected ePub
- [ ] **4.5** — Public changelog: a human-readable page listing all corrections in each edition, linked to the original discussions
- [ ] **4.6** — Git archive (optional): push each edition as a tagged commit to a public GitHub repository for archival and transparency

### Decision Point: Export Format

> After building 4.3:
>
> - **Is ePub the right primary output format**, or would users prefer a web-native reading experience (i.e., just read the corrected text on the site, no download needed)?
> - Consider offering both: the site as the primary experience, with ePub/PDF as downloadable artifacts.
> - **Should footnotes be inline** (visible in the text flow) or **endnotes** (collected at the chapter/volume end)? Let the community weigh in.

### Deliverable

Downloadable, corrected editions of *The Treasury of David* with community attribution. A public record of every change made and why.

---

## Phase 5 — Scale & Polish

**Goal:** Harden the platform for broader use and additional texts.

### Tasks

- [ ] **5.1** — Full-text search across all volumes (PostgreSQL `tsvector` + `tsquery`)
- [ ] **5.2** — Performance optimization: lazy-load volumes, cache rendered pages, optimize ePub parsing
- [ ] **5.3** — Accessibility audit: screen reader support, keyboard navigation, high contrast mode
- [ ] **5.4** — Multi-text support: generalize the platform so a second public domain work can be added (new "project" containing its own volumes, corrections, and community)
- [ ] **5.5** — API for third-party access: corrections data, edition metadata, contributor stats
- [ ] **5.6** — Automated backup strategy for database and ePub files
- [ ] **5.7** — Monitoring and alerting (uptime, error rates, disk usage)

### Decision Point: Real-time Collaboration

> At this scale, evaluate:
>
> - **Do users need to see each other's corrections in real-time** (Google Docs style), or is the asynchronous submit-review-approve loop sufficient?
>   - If real-time is needed → integrate [Yjs](https://github.com/yjs/yjs) for CRDT-based sync
>   - If async is fine → keep the current architecture (simpler, cheaper, more than adequate for editorial workflows)

### Decision Point: Multi-text Architecture

> When adding a second text (5.4):
>
> - **Single database with project scoping**, or **separate deployments per text**?
>   - Single DB is simpler and lets users maintain one profile across texts
>   - Separate deployments provide isolation but increase operational burden
>   - Recommendation: single database, scoped by `project_id`

### Deliverable

A production-grade platform capable of hosting multiple public domain texts with active correction communities.

---

## Phase 6 — Multi-Corpus & TEI Support

**Goal:** Extend the platform beyond ePub/OCR texts to support the vast public domain corpus of early printed books transcribed by the Text Creation Partnership (TCP), encoded in TEI P5 XML.

### Background

The **Text Creation Partnership** has produced over 70,000 accurate full-text transcriptions of early printed books from:

- **EEBO (Early English Books Online)** — books printed in England, Ireland, Scotland, Wales, and British North America between 1473 and 1700
- **ECCO (Eighteenth Century Collections Online)** — books printed in the UK and Americas between 1701 and 1800

These transcriptions were **double-keyed** (typed twice, compared for accuracy) and encoded in **TEI P5 XML** with structural markup for chapters, poems, lists, tables, marginalia, and more. EEBO-TCP Phase I (25,000+ texts) and Phase II (40,000+ texts) are now **public domain (CC0)**, freely downloadable from the TCP's GitHub repository.

Despite their quality, these transcriptions have known gaps and errors:

- **Non-Latin scripts** left as placeholders (e.g., `〈 in non-Latin alphabet 〉`) — Greek, Hebrew, Syriac, Arabic
- **Latin phrases** sometimes garbled or truncated
- **Archaic typography** — long S (ſ), ligatures, abbreviation marks
- **Structural gaps** — complex tables, verse layouts, and marginalia may be incompletely tagged

Criticalis can serve as the platform where scholars, students, and enthusiasts collaboratively fill these gaps by comparing the TEI transcriptions against the original page scans.

### Tasks

- [ ] **6.1** — Side-by-side scan viewer:
  - Display the scanned page image (PDF page, JPEG, or TIFF) alongside the electronic text
  - Synchronized scrolling/navigation — selecting a passage in the text highlights the approximate region in the scan, and vice versa
  - Zoom and pan controls for the scan image
  - **Scan sources** (three tiers):
    - **Platform-provided**: scans sourced from Internet Archive, ProQuest (EEBO/ECCO), or other archives — publicly visible to all users
    - **User-uploaded**: users upload their own scans (PDF, images) to work with a text — **private by default**, visible only to the uploader
    - **Shared**: user-uploaded scans can be explicitly shared with specific individuals (by invitation) but remain non-public unless the uploader opts to release them
  - Support for PDF (rendered page-by-page), IIIF image API (used by many digital libraries), and static image files
  - **Privacy rationale**: some users may have institutional access to scans (e.g., via ProQuest) that cannot be redistributed. They should still be able to use those scans for correction work on the platform without exposing the images to the public. Corrections to the *text* (which is CC0) remain public; the *scan images* used to make those corrections may be private.

- [ ] **6.2** — TEI P5 XML ingestion and rendering:
  - Parse TEI P5 XML into a readable view, respecting structural markup (divisions, paragraphs, verse, tables, marginalia, front/back matter)
  - Render TEI elements with appropriate styling (e.g., `<hi rend="italic">` → italic, `<foreign>` → language-tagged, `<gap>` → visible placeholder)
  - Preserve the full TEI structure when corrections are applied — edits modify the XML source, not a flattened representation
  - Handle TEI-specific constructs: `<choice>` (original/regularized spellings), `<abbr>`/`<expan>`, `<sic>`/`<corr>`, `<add>`/`<del>`

- [ ] **6.3** — Special character input:
  - Virtual keyboard panel for frequently needed characters:
    - **Archaic English**: long S (ſ), common ligatures, thorn (þ), eth (ð), wynn (ƿ)
    - **Greek**: full polytonic Greek keyboard layout (for biblical/classical quotations)
    - **Hebrew**: right-to-left input with vowel points (nikkud)
    - **Latin**: macrons, breves, and other diacritical marks
  - Character picker / search — type a description (e.g., "long s") and find the Unicode character
  - Recently-used characters panel for quick access
  - Copy-paste from external sources with encoding normalization (NFC)

- [ ] **6.4** — AI-assisted correction (BYOK — Bring Your Own Key):
  - **Region-select OCR**: user draws a box around difficult text in the page scan (foreign script, damaged/faded, archaic font) and sends that region for AI interpretation
  - **Page-by-page batch mode**: process an entire page's transcription against the scan, with the AI identifying discrepancies and suggesting corrections
  - Result is always presented as a *suggestion* for human review — never auto-applied
  - Confidence scoring — flag low-confidence interpretations for expert review
  - **BYOK provider system** — users supply their own AI credentials:
    - Cloud APIs: OpenAI, Anthropic (Claude), Google (Gemini) — user enters their API key in account settings
    - Local/self-hosted: Ollama endpoint URL, or any OpenAI-compatible API endpoint (LM Studio, vLLM, etc.)
    - Platform may also offer a shared/subsidized tier for light usage (with rate limits)
  - **Usage tracking and cost controls**:
    - Token counting per request (input/output tokens displayed before confirming)
    - Per-user usage dashboard: total tokens consumed, estimated cost, history
    - Configurable limits: per-request token cap, daily/monthly budget ceiling, auto-pause when limit reached
    - Cost estimation before sending a request ("This will use ~2,000 tokens, est. $0.006")
  - **Client-side OCR option**: Tesseract.js (WASM, runs entirely in the browser) as a free, no-API-key-needed baseline for printed text — lower accuracy than cloud models but zero cost and no data leaving the user's machine

- [ ] **6.5** — TEI-to-ePub export pipeline:
  - Convert corrected TEI P5 XML into well-formed ePub 3 for reading and distribution
  - Preserve structural hierarchy (TEI divisions → ePub chapters)
  - Render footnotes, marginalia, and annotations as ePub footnotes
  - Include a colophon crediting contributors
  - Generate table of contents from TEI structure
  - Optional: TEI-to-HTML export for web reading without ePub

- [ ] **6.6** — Corpus management:
  - Admin interface for adding new texts (upload TEI XML + associated page scans)
  - Metadata import from TEI headers (`<teiHeader>`) — author, title, date, printer, subject
  - Per-text correction statistics and progress tracking (e.g., "342 of 1,200 gaps filled")
  - Batch import support for adding multiple texts from the TCP corpus

### Decision Points

> **Scan alignment strategy**: How to link page scans to TEI text positions? — DECIDED
>
> Use the `<pb>` elements already present in TCP texts as the alignment backbone. Three scan source tiers:
> 1. **Platform-provided scans**: sourced from Internet Archive, ProQuest, or other archives — publicly visible
> 2. **User-uploaded scans**: private by default (the user may have institutional access to scans they cannot redistribute). Users can still make corrections against private scans — the corrections to the CC0 text are public, the scan images are not.
> 3. **Shared scans**: user-uploaded scans explicitly shared with specific individuals by invitation
>
> Support IIIF for hotlinking to library-hosted images (Internet Archive, Bodleian, Folger, HathiTrust) where available. Fall back to self-hosted or user-uploaded scans for texts without free IIIF sources. AI-assisted alignment (OCR + fuzzy match) is a stretch goal.

> **TEI editing granularity**: Should contributors edit raw TEI XML, or a WYSIWYG view?
> - Most contributors should see a rich-text view and submit corrections through the same popup workflow as Phase 2
> - Power users / editors may need a "source view" toggle to edit TEI markup directly (e.g., wrapping a phrase in `<foreign xml:lang="grc">`)
> - The platform should enforce TEI validity — reject edits that produce malformed XML

> **Virtual keyboard vs. input method**: Build a custom keyboard panel, or integrate an existing library?
> - Evaluate: [online-keyboard](https://github.com/nicklambson/online-keyboard), browser-native `inputMode` hints, or a custom panel
> - Greek polytonic input is the hardest — consider leveraging existing polytonic Greek keyboard layouts

### Deliverable

A platform capable of hosting and improving TEI-encoded early printed books at scale, with side-by-side scan comparison, special character input, AI-assisted gap filling, and ePub export. The 70,000+ public domain TCP texts become candidates for community-driven improvement.

---

## Future Horizons

These are ideas that are worth recording but should not influence architectural decisions today:

- **ML-assisted OCR correction**: Use the corpus of human corrections as training data to build or fine-tune an OCR post-processing model that can suggest corrections automatically. This was mentioned in the original README and remains an exciting long-term possibility.
- **Cross-reference linking**: Automatically detect and link biblical references, quotations, and citations across volumes.
- **Audio integration**: Community-contributed audio readings of corrected passages.
- **Translation support**: Corrections and annotations in multiple languages.
- **Offline/local-first**: Use CRDTs (Yjs) and service workers for fully offline reading and correction submission.
- **Federation**: Allow other communities to host their own Criticalis instances for different texts, with optional cross-instance discovery.

---

## Technology Reference

Detailed notes on each recommended technology, for quick reference during implementation.

### foliate-js
- **Repo**: https://github.com/johnfactotum/foliate-js
- **What**: Browser-based e-book renderer. Supports EPUB, MOBI, KF8, FB2, CBZ.
- **Why**: Native ES modules (no build step), more accurate text range detection than epub.js (uses bisecting), supports paginated and scrolled modes, direct DOM access.
- **Caveat**: API is not yet stable — pinned to a specific commit via git submodule. No npm package.
- **Status**: Integrated and working. Rendering of Google Books OCR ePubs confirmed.

### text-annotator-js (Recogito)
- **Repo**: https://github.com/recogito/text-annotator-js
- **What**: Text annotation library. Successor to recogito-js.
- **Why**: W3C Web Annotation compatible selectors, lightweight, framework-agnostic with React wrapper available, supports highlight customization.
- **Status**: Not yet integrated. Evaluate during Phase 2 — may not be needed if a custom popup suffices.

### @smoores/epub
- **Repo/npm**: https://www.npmjs.com/package/@smoores/epub
- **What**: Node.js library for inspecting, modifying, and creating EPUB3 publications.
- **Why**: Purpose-built for programmatic ePub modification — exactly what we need for applying corrections to XML files.
- **Status**: Installed as `@storyteller-platform/epub`. Not yet tested against the Google Books ePub structure — scheduled as task 2.0.
- **Alternative**: Direct XML manipulation via [cheerio](https://github.com/cheeriojs/cheerio) or [fast-xml-parser](https://github.com/NaturalIntelligence/fast-xml-parser). Less ePub-aware but more flexible if the ePub structure is unusual.

### SvelteKit
- **Site**: https://kit.svelte.dev/
- **What**: Full-stack web framework built on Svelte.
- **Why**: Smallest bundle sizes of any major framework, fast hydration, built-in SSR/SSG, API routes, form actions. Excellent developer experience for small teams.
- **Status**: Integrated. Using SvelteKit 2 with Svelte 5, adapter-node for Docker deployment.

### PostgreSQL + Drizzle ORM
- **PG**: https://www.postgresql.org/
- **Drizzle**: https://orm.drizzle.team/
- **What**: Relational database + type-safe ORM.
- **Why PG**: Full-text search, JSONB for flexible annotation data, `pg_trgm` for fuzzy matching, rock-solid reliability, free.
- **Why Drizzle**: Lightweight, SQL-like syntax (not an abstraction over SQL), excellent TypeScript support, works with any framework.
- **Status**: Schema defined in `src/lib/server/schema.ts`. Migrations not yet run (Phase 2).

### Better Auth
- **Site**: https://www.better-auth.com/
- **What**: Open-source authentication framework.
- **Why**: Framework-agnostic, auto schema generation, social logins, self-hostable, actively funded and developed. Successor to Auth.js/NextAuth.
- **Status**: Configured with email/password in `src/lib/server/auth.ts`. OAuth providers stubbed in `.env.example`.

### OpenResty
- **Site**: https://openresty.org/
- **What**: nginx + Lua scripting for high-performance web applications.
- **Why**: Lightweight reverse proxy with rate limiting, security headers, and gzip compression. Familiar nginx configuration.
- **Status**: Integrated into Docker Compose stack. Config template with envsubst for domain configuration.

### Yjs (future, if needed)
- **Repo**: https://github.com/yjs/yjs
- **What**: High-performance CRDT for collaborative editing.
- **Why**: 900k+ weekly downloads, extensive editor integrations (ProseMirror, TipTap, CodeMirror), used by Proton Docs, NextCloud, ClickUp.
- **When**: Only if Phase 5 evaluation determines that real-time collaboration is needed. Overkill for the asynchronous correction workflow in Phases 1–4.

### Novu (future, if needed)
- **Repo**: https://github.com/novuhq/novu
- **What**: Open-source notification infrastructure.
- **Why**: In-app inbox, email, push notifications. Workflow engine for event-driven notifications.
- **When**: Evaluate during Phase 3. A simpler custom notification table + [Resend](https://resend.com/) for email may be sufficient at smaller scale.

### TEI P5 XML (Phase 6)
- **Spec**: https://tei-c.org/guidelines/p5/
- **What**: The Text Encoding Initiative Guidelines (P5) — the standard for representing texts in digital form, widely used in digital humanities.
- **Why**: The TCP corpus (EEBO, ECCO) is encoded in TEI P5 XML. Supporting TEI means Criticalis can work with 70,000+ public domain texts.
- **Key elements**: `<teiHeader>` (metadata), `<body>` (text content), `<div>` (sections), `<pb>` (page breaks, linkable to scans), `<gap>` (lacunae), `<foreign>` (non-English text), `<choice>`/`<sic>`/`<corr>` (editorial corrections).
- **Parsing**: Standard XML parsers work. Consider [saxes](https://github.com/lddubeau/saxes) for streaming or the browser's native DOMParser for client-side rendering.

### EEBO-TCP & ECCO-TCP (Phase 6)
- **EEBO-TCP**: https://textcreationpartnership.org/tcp-texts/eebo-tcp-early-english-books-online/
- **ECCO-TCP**: https://textcreationpartnership.org/tcp-texts/ecco-tcp-eighteenth-century-collections-online/
- **What**: Over 70,000 manually keyed transcriptions of early printed books (1473–1800), encoded in TEI P5 XML.
- **Production method**: Double-keying (typed twice, compared) for near-perfect accuracy of English text. Structural markup added by editors.
- **Known gaps**: Non-Latin scripts (Greek, Hebrew) often left as `〈 in non-Latin alphabet 〉` placeholders. Complex layouts (tables, marginalia) may be incomplete.
- **License**: CC0 (public domain). Freely downloadable from TCP GitHub and archival storage.
- **Status**: Not yet integrated. Example files to be provided for evaluation.

### IIIF (Phase 6, if needed)
- **Spec**: https://iiif.io/
- **What**: International Image Interoperability Framework — a standard API for serving and annotating high-resolution images from digital libraries.
- **Why**: Many libraries (Bodleian, Folger, HathiTrust) serve their page scans via IIIF. Integrating IIIF would allow Criticalis to display page scans directly from library servers without hosting the images locally.
- **When**: Evaluate during Phase 6 scan viewer implementation. Start with local PDF/image files, add IIIF as a second source.

---

*This document is a living reference. Update it as decisions are made and the project evolves.*
