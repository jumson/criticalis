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
│  │ (foliate-js │  │    Layer     │  │   UI      │  │
│  │  or epub.js)│  │              │  │           │  │
│  └──────┬──────┘  └──────┬───────┘  └─────┬─────┘  │
│         └────────────────┼────────────────┘         │
│                          │                          │
└──────────────────────────┼──────────────────────────┘
                           │ HTTP / SSE
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

---

## Recommended Tech Stack

| Layer | Technology | License | Notes |
|-------|-----------|---------|-------|
| **Framework** | [SvelteKit](https://kit.svelte.dev/) | MIT | Smallest bundles, fast hydration, SSR built-in |
| **ePub Rendering** | [foliate-js](https://github.com/johnfactotum/foliate-js) | MIT | Modern, native ES modules, direct DOM access |
| **ePub Rendering (alt)** | [epub.js](https://github.com/futurepress/epub.js) | BSD | Fallback — more stable API, larger community |
| **Annotation UI** | [text-annotator-js](https://github.com/recogito/text-annotator-js) | BSD-3 | W3C Web Annotation compatible, lightweight |
| **ePub Modification** | [@smoores/epub](https://www.npmjs.com/package/@smoores/epub) | MIT | Server-side ePub3 inspection and modification |
| **Database** | [PostgreSQL](https://www.postgresql.org/) | PostgreSQL License | Full-text search, JSONB, audit capabilities |
| **ORM** | [Drizzle ORM](https://orm.drizzle.team/) | Apache 2.0 | Type-safe, SQL-like, lightweight |
| **Auth** | [Better Auth](https://www.better-auth.com/) | MIT | OSS, framework-agnostic, successor to Auth.js |
| **Notifications** | [Novu](https://github.com/novuhq/novu) | MIT (core) | In-app + email, workflow engine |
| **Real-time** | Server-Sent Events (native) | — | Built into SvelteKit, no extra dependency |
| **Deployment** | [Railway](https://railway.app/) / [Fly.io](https://fly.io/) | — | Managed Postgres included, free tiers |

### Why not Git under the hood?

The original README envisioned Git as the backend for tracking changes. After research, a **database-first approach** is recommended instead:

- Users submit word/phrase-level corrections — far more granular than file-level diffs
- Git's merge model is designed for code, not for hundreds of small text fixes to XML
- A database gives you voting, status tracking, and querying for free
- Managing a Git branch per correction creates massive overhead
- You can still **export to Git** periodically — generate commits from approved batches of corrections for a public audit trail

If at any point the project needs true distributed/offline editing (Phase 5+), CRDTs via [Yjs](https://github.com/yjs/yjs) can be layered on.

---

## Phase 0 — Foundation & Spike

**Goal:** Prove the core rendering and text-selection loop works before committing to a stack.

### Tasks

- [ ] **0.1** — Set up a minimal SvelteKit project
- [ ] **0.2** — Integrate foliate-js to render one volume of *Treasury of David* in the browser
- [ ] **0.3** — Implement text selection: user selects a word or phrase and a popup appears showing what they selected, including its location in the ePub XML (volume, file, XPath or CFI)
- [ ] **0.4** — Test with the actual ePub files in `sources/` — confirm OCR content renders correctly, page navigation works, and the XML structure can be targeted for modifications
- [ ] **0.5** — Spike: use `@smoores/epub` to programmatically apply a test correction to one XML file and verify the ePub still renders correctly

### Decision Point: ePub Renderer

> After completing 0.2–0.4, evaluate:
>
> - **Does foliate-js provide reliable text selection and position reporting?**
>   - If YES → continue with foliate-js
>   - If NO → switch to epub.js (more battle-tested, hook-based event system)
>   - If NEITHER → consider rendering the ePub content as plain HTML (extract XML content server-side, serve as styled HTML pages). This loses some ePub features but gives full DOM control.
>
> - **Does `@smoores/epub` handle the Google Books OCR ePub structure?**
>   - These ePubs have unusual XML with deeply nested `<span>` elements and Google-specific class names (see README examples). If `@smoores/epub` struggles with them, the fallback is direct XML manipulation via a library like [fast-xml-parser](https://github.com/NaturalIntelligence/fast-xml-parser) or [cheerio](https://github.com/cheeriojs/cheerio).

### Deliverable

A local dev environment where you can open a volume, select text, and see the precise XML location logged to the console. One test correction applied and verified.

---

## Phase 1 — Reader MVP

**Goal:** A deployed web app where anyone can read *The Treasury of David* in their browser.

### Tasks

- [ ] **1.1** — Volume selection screen (all 7 volumes with cover images/titles)
- [ ] **1.2** — Full reader UI: table of contents, page/chapter navigation, bookmarking (local storage)
- [ ] **1.3** — Responsive layout — readable on desktop, tablet, and phone
- [ ] **1.4** — Basic SEO: server-rendered landing page, meta tags, structured data for the public domain work
- [ ] **1.5** — Deploy to Railway or Fly.io with a public URL
- [ ] **1.6** — Store ePub files: decide between filesystem (simpler) or object storage (S3-compatible via Tigris/Cloudflare R2)

### Decision Point: Rendering Strategy

> After Phase 1 is live, gather feedback:
>
> - **Is the reading experience good enough?** Fast load times, readable typography, smooth navigation?
> - **Are there rendering quirks** with the Google Books ePub structure that need workarounds?
> - **Should we pre-process the ePubs** into a cleaner intermediate format (e.g., simplified HTML or Markdown) rather than rendering raw OCR XML? This would make corrections easier to apply and the content easier to search.
>   - Pre-processing trade-off: upfront effort, but dramatically simplifies everything downstream.

### Deliverable

A publicly accessible web reader for all 7 volumes. No accounts, no corrections — just reading.

---

## Phase 2 — Corrections Workflow

**Goal:** Authenticated users can submit corrections and footnotes. A curator can review and apply them.

### Tasks

- [ ] **2.1** — Set up PostgreSQL database with core schema:
  ```
  users, corrections, correction_history, documents, document_versions
  ```
- [ ] **2.2** — Integrate Better Auth: email/password + at least one social login (Google or GitHub)
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
- [ ] **5.6** — Migrate deployment to Fly.io (if still on Railway) for global edge distribution and better scaling
- [ ] **5.7** — Automated backup strategy for database and ePub files

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
- **Caveat**: API is not yet stable — pin to a specific commit via git submodule. No npm package.
- **Alternative**: [epub.js](https://github.com/futurepress/epub.js) (~6.6k stars, BSD license, npm package `epubjs`). More stable API but semi-dormant maintenance. Good documentation and plugin/hook system.

### text-annotator-js (Recogito)
- **Repo**: https://github.com/recogito/text-annotator-js
- **What**: Text annotation library. Successor to recogito-js.
- **Why**: W3C Web Annotation compatible selectors, lightweight, framework-agnostic with React wrapper available, supports highlight customization.
- **Alternative**: Build a custom selection popup (simpler, fewer dependencies, may be sufficient for v1).

### @smoores/epub
- **Repo/npm**: https://www.npmjs.com/package/@smoores/epub
- **What**: Node.js library for inspecting, modifying, and creating EPUB3 publications.
- **Why**: Purpose-built for programmatic ePub modification — exactly what we need for applying corrections to XML files.
- **Alternative**: Direct XML manipulation via [cheerio](https://github.com/cheeriojs/cheerio) or [fast-xml-parser](https://github.com/NaturalIntelligence/fast-xml-parser). Less ePub-aware but more flexible if the ePub structure is unusual.

### SvelteKit
- **Site**: https://kit.svelte.dev/
- **What**: Full-stack web framework built on Svelte.
- **Why**: Smallest bundle sizes of any major framework, fast hydration, built-in SSR/SSG, API routes, form actions. Excellent developer experience for small teams.
- **Alternative**: [Remix / React Router v7](https://remix.run/) if you prefer React. Progressive enhancement model is also a good fit for this project.

### PostgreSQL + Drizzle ORM
- **PG**: https://www.postgresql.org/
- **Drizzle**: https://orm.drizzle.team/
- **What**: Relational database + type-safe ORM.
- **Why PG**: Full-text search, JSONB for flexible annotation data, `pg_trgm` for fuzzy matching, rock-solid reliability, free.
- **Why Drizzle**: Lightweight, SQL-like syntax (not an abstraction over SQL), excellent TypeScript support, works with any framework.

### Better Auth
- **Site**: https://www.better-auth.com/
- **What**: Open-source authentication framework.
- **Why**: Framework-agnostic, auto schema generation, social logins, self-hostable, actively funded and developed. Successor to Auth.js/NextAuth.
- **Alternative**: [Clerk](https://clerk.com/) (managed, paid per MAU — simpler but vendor lock-in).

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

---

*This document is a living reference. Update it as decisions are made and the project evolves.*
