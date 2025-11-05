# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Criticalis** is a collaborative platform for improving public domain works through community corrections and annotations. The platform enables contributors to fix OCR errors in digitized texts and add explanatory footnotes for modern readers. The initial focus is on "The Treasury of David" by C. H. Spurgeon (7 volumes).

### Core Concept
- **Git-like version control for texts**: Simplified interface for non-technical users to submit corrections and annotations
- **Community-driven quality**: Contributors propose changes, community approves/disapproves, curator accepts final versions
- **ePub format**: Working with ePub3 files containing XML content that needs correction
- **Focus on accessibility**: Making historical texts more readable for successive generations

## Project Status

**Current Phase**: Planning & Design (Phase 1)
- No implementation code exists yet
- Repository contains source materials (ePub and PDF files of the 7 volumes)
- Cost breakdown and planning documents are complete
- Ready to begin MVP development (Phase 2)

## Repository Structure

```
criticalis/
├── sources/                    # Source materials
│   ├── The_Treasury_of_David-{I-VII}.epub   # OCR-generated ePub files with errors
│   ├── The_Treasury_of_David-{I-VII}.pdf    # Original PDFs for reference
│   └── unzipped/
│       └── TOD_{1-7}/         # Unpacked ePub structure
│           └── OEBPS/
│               ├── content/    # XML content files (e.g., content-0012.xml)
│               ├── data/       # Images and assets
│               ├── volume.opf  # ePub metadata
│               └── _toc_ncx_.ncx  # Table of contents
├── images/                     # Documentation images showing OCR errors
├── README.md                   # Project vision and implementation notes
├── COST_BREAKDOWN.md          # Comprehensive cost analysis for all phases
├── PROJECT_ROADMAP.md         # Detailed breakdown of all 145+ development tasks
├── ISSUE_CREATION_GUIDE.md    # Guide for creating remaining GitHub issues
├── CLAUDE.md                  # This file
├── GITHUB_PROJECT_MANAGEMENT.md # comprehensive guide documenting github interactions
└── create_issues.sh           # Script for batch creating GitHub issues
```

## 📚 GitHub Project Management

**🎯 ACTIVE POLICY (Nov 5, 2025)**: All project tracking managed through GitHub Issues, Projects, and Milestones

**Repository**: https://github.com/jumson/criticalis
**Owner**: jumson
**Project Board**: https://github.com/users/jumson/projects/3

### Project Infrastructure Status
✅ **Complete:**
- GitHub Project created and linked to repository
- 5 Milestones created for all development phases (Phase 1-5)
- Complete label taxonomy created (type, priority, phase, epic, size, status)
- 24 Phase 1 issues created (Planning & Design)
- 10 Phase 2 sample issues created (MVP Development foundation)

📋 **Remaining:**
- ~109 issues to create from PROJECT_ROADMAP.md
- See ISSUE_CREATION_GUIDE.md for instructions

### Quick Reference Commands

| Task | Example Command |
|------|---------|
| **List my issues** | `gh issue list --assignee @me` |
| **List issues by milestone** | `gh issue list --milestone "Phase 5: Nginx Toolset"` |
| **List issues by priority** | `gh issue list --label "priority:blocker"` |
| **View issue** | `gh issue view 123` |
| **Comment on issue** | `gh issue comment 123 --body "Working on this now"` |
| **Close issue** | `gh issue close 123 --comment "Fixed in #PR"` |
| **View project** | `gh project view 1 --owner jumson` |
| **Create issue** | See detailed workflow below |
| **Create PR** | `gh pr create --fill` (auto-links to issues) |

**📖 Full Documentation**: `GITHUB_PROJECT_MANAGEMENT.md` (600+ lines, comprehensive guide)
## Key Technical Challenges

### 1. ePub XML Structure
The content files contain highly granular XML with styling wrapped around individual words:
- Each word is wrapped in `<span>` tags with styling (font-style, font-variant)
- Paragraphs have complex IDs and positioning metadata
- OCR errors appear within this structure (e.g., "TrTLE" instead of "TITLE", "Psai.m" instead of "Psalm")

Example from `content-0012.xml` line 76:
```xml
<p class='gtxt_body' style='font-size:102%;text-indent:1em;'>TrTLE.—
  <span style='font-style:italic;'>This </span>
  <span style='font-style:italic;'>Psalm </span>
```

### 2. Required Platform Architecture
The system needs to synthesize:
- **ePub reader**: Display and interaction with ePub3 content
- **Git client functionality**: Track changes, branches, pull requests (abstracted from users)
- **Annotation system**: Highlight text, propose corrections, add footnotes
- **Community moderation**: Upvote/downvote system, curator approval workflow

### 3. User Interaction Model
Users should be able to:
- Tap/click words to select and propose corrections
- Highlight phrases to suggest footnotes (e.g., "note: this phrase refers to...")
- View proposed changes from other contributors
- Approve/disapprove changes
- See the "community improved" version vs. original

## Implementation References (from README)

### Potential Libraries to Evaluate
**ePub Reading & Rendering:**
- `epub` (npm): Simple ePub streamer
- `epub-parser` (npm): ePub to JSON with HTML generation
- `epub.js` (Future Press): Interactive ePub renderer with events/hooks - *"most promising"*
- Readium projects: ePub3 rendering suite

**Annotation Layer:**
- Hypothesis: Web annotation framework (may be more than needed)
- Custom solution: Highlight word → suggest correction → server makes XML edit

**Version Control:**
- NodeGit: Native Git bindings
- `simple-git` (npm): Simplified Git commands
- Octokit (GitHub REST API): Complete GitHub API client for issues/PRs

### Data Flow Architecture
1. User highlights text in ePub reader
2. User proposes correction or footnote
3. Frontend sends change to server with:
   - File path (e.g., `content-0012.xml`)
   - Line/word location
   - Proposed change
4. Server creates Git commit/PR in background
5. Other users see proposed change, vote
6. Curator approves → change merged to "final" branch
7. Two branches maintained:
   - **Staging**: All proposed changes visible
   - **Final**: Only curator-approved changes

### Footnote Syntax
Contributors can add footnotes using a syntax like:
```
note: this phrase is referring to the king of england at that time - Henry the VIII
```

## Development Workflow

**Note**: When implementation begins, this section should be updated with actual commands.

### Expected Setup (Future)
```bash
# Install dependencies
npm install

# Run development server
npm run dev

# Run tests
npm test

# Build for production
npm run build

# Lint code
npm run lint
```

### Git Workflow
- **Main branch**: `master` (production/final approved versions)
- **Feature branches**: Use descriptive names (e.g., `feature/epub-reader`, `feature/annotation-ui`)
- **Commits**: Include reference to issues or features being implemented

## Architecture Considerations

### Performance & Scalability
From COST_BREAKDOWN.md, the platform should handle:
- **MVP**: ~1,000 users, ~10,000 annotations
- **Beta**: ~5,000 users, ~50,000 annotations
- **Production Launch**: ~20,000 users, ~200,000 annotations
- **Year 1 End**: ~50,000-100,000 users, 1M+ annotations

### Infrastructure Philosophy
- Only compress and push XML files, not entire ePub (bandwidth optimization)
- Use CDN for static assets and ePub downloads
- Cache rendered content (85% hit rate target)
- PostgreSQL for user data and annotations
- S3/object storage for ePub files

### Security & Content Moderation
- Prevent spam/vandalism through community voting
- Curator has final approval authority
- Track all changes with full Git history
- Content moderation service for inappropriate submissions

## Key Design Principles

1. **Simplicity for Contributors**: Hide Git complexity behind social-media-like interface
2. **Accuracy**: Reference original PDFs when needed for verification
3. **Accessibility**: Make aging works understandable to modern readers
4. **Community Self-Governance**: Upvote/downvote system with curator oversight
5. **Preservation**: Maintain complete change history via Git

## Types of Improvements

### Corrections
Fix OCR errors from automatic conversion (PDF → ePub):
- Character recognition errors: "TrTLE" → "TITLE"
- Formatting issues: "Psai.m" → "Psalm"
- Punctuation mistakes
- Word breaks and hyphenation

### Explanations
Add footnotes for:
- Archaic words (e.g., "controverted" - 10× more common in 1880)
- Historical references
- Obscure phrases
- Cultural context for modern readers

## Future Development Phases

**Phase 2 - MVP Development** (5 months):
- Basic ePub reader
- Simple correction submission
- Basic Git integration
- User authentication

**Phase 3 - Beta Testing** (2.5 months):
- Community voting system
- Curator workflow
- Annotation features
- Performance optimization

**Phase 4 - Production Launch** (1 month):
- Full feature set
- Marketing materials
- Support infrastructure

**Phase 5 - Ongoing Operations**:
- Machine learning for improved OCR (separate project)
- Expand to additional public domain works
- Enhanced moderation tools

## Funding Context

The project has detailed cost projections:
- **To Launch**: ~$806K (Phases 1-4)
- **First Year Operations**: ~$1.58M
- **Three-Year Plan**: ~$3.73M
- Primary cost driver: Personnel (87.7% of budget)
- Infrastructure represents only 0.8% of costs

Alternative approaches available for bootstrap/lean implementation.

## Contributing Philosophy

When implementing features:
1. **User experience first**: Remember contributors are likely scholars/readers, not developers
2. **Git abstraction**: Users should never see Git terminology or commands
3. **XML precision**: Changes must preserve structure and styling of ePub files
4. **Performance**: Keep interface responsive even with large texts
5. **Accessibility**: Follow WCAG guidelines for screen readers and navigation
