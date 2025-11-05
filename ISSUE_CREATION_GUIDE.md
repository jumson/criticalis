# Issue Creation Guide for Criticalis

## Overview
This guide helps you create the remaining GitHub issues for the Criticalis project. The PROJECT_ROADMAP.md document contains detailed descriptions of all 145+ issues across all development phases.

## Current Status

### ✅ Completed
- **GitHub Project Created**: https://github.com/users/jumson/projects/3
- **Milestones Created**: 5 milestones for all phases
- **Labels Created**: Complete label taxonomy (type, priority, phase, size, epic, etc.)
- **Phase 1 Issues**: 24 issues created (Issues #1-9)
- **Phase 2 Sample Issues**: 10 issues created (Issues #10-19) demonstrating structure

### 📋 Remaining Work
- **Phase 2 Remaining**: ~60 more issues from PROJECT_ROADMAP.md
- **Phase 3**: ~24 issues
- **Phase 4**: ~13 issues
- **Phase 5**: ~12+ issues

## Quick Start Commands

### View Current State
```bash
# View all milestones
gh api repos/jumson/criticalis/milestones

# View all labels
gh label list

# View current issues
gh issue list --milestone "Phase 2: MVP Development"

# View project board
gh project view 3 --owner jumson --web
```

### Create an Issue Template
```bash
gh issue create \
  --title "Your Issue Title" \
  --body "## Description
[Description here]

## Tasks
- [ ] Task 1
- [ ] Task 2

## Acceptance Criteria
- Criterion 1
- Criterion 2

## Epic
Part of Epic X.Y.Z

## Dependencies
- Depends on #issue_number" \
  --label "type,technology,phase:N,priority:level,size:x" \
  --milestone "Phase N: Name" \
  --project "Criticalis Development"
```

## Issue Creation from PROJECT_ROADMAP.md

The PROJECT_ROADMAP.md file contains complete specifications for all 145+ issues. For each issue in the roadmap:

### Step 1: Extract Issue Details
Find the issue in PROJECT_ROADMAP.md and note:
- Issue number
- Title
- Description (from Tasks section)
- Labels (from the "Labels:" line)
- Size estimate
- Epic association
- Dependencies (if any)

### Step 2: Create the Issue
Use the template above, filling in:
- **Title**: From the roadmap
- **Body**: Combine Description, Tasks, and Acceptance Criteria
- **Labels**: Convert the label list to comma-separated format
- **Milestone**: The appropriate phase milestone
- **Project**: Always "Criticalis Development"

### Step 3: Link Dependencies
If the issue depends on other issues, add them in the body:
```markdown
## Dependencies
- Depends on #1 (ePub library research)
- Blocked by #10 (Repository structure)
```

## Batch Creation Script

You can create a script to batch-create issues. Example structure:

```bash
#!/bin/bash

# Phase 2 - Sprint 2.1 Issues
gh issue create --title "..." --body "..." --label "..." --milestone "..." --project "..."
gh issue create --title "..." --body "..." --label "..." --milestone "..." --project "..."
# ... continue for all issues

# Phase 2 - Sprint 2.2 Issues
gh issue create --title "..." --body "..." --label "..." --milestone "..." --project "..."
# ...
```

See `create_issues.sh` for an example of Phase 1 batch creation.

## Issue Organization Strategy

### By Epic
Issues are organized into epics. Each epic has a label like `epic:1.1` or `epic:2.2.1`.

**Phase 1 Epics:**
- Epic 1.1: Technical Architecture & Design (8 issues)
- Epic 1.2: UX/UI Design (8 issues)
- Epic 1.3: Project Documentation (4 issues)
- Epic 1.4: Legal & Compliance (4 issues)

**Phase 2 Epics:** (see PROJECT_ROADMAP.md for complete list)
- Epic 2.1.1: Development Environment Setup
- Epic 2.1.2: Backend Foundation
- Epic 2.1.3: Frontend Foundation
- Epic 2.1.4: Infrastructure Setup
- Epic 2.2.1: ePub Parser & Storage
- Epic 2.2.2: ePub Reader Frontend
- Epic 2.2.3: XML Content Manipulation
- Epic 2.3.1: Correction Workflow
- Epic 2.3.2: Footnote/Annotation Workflow
- Epic 2.3.3: Community Voting
- Epic 2.3.4: Discussion Threads
- Epic 2.4.1: Authentication
- Epic 2.4.2: User Profiles & Permissions
- Epic 2.5.1: End-to-End Integration

### By Sprint
Issues can also be organized by sprint using labels:
- `sprint:2.1` - Foundation & Infrastructure (1 month)
- `sprint:2.2` - ePub Engine (1.5 months)
- `sprint:2.3` - Annotation System (1.5 months)
- `sprint:2.4` - User Management (0.5 month)
- `sprint:2.5` - Integration & Testing (0.5 month)

### By Priority
Use priority labels to focus work:
- `priority:critical` - Must be done for MVP
- `priority:high` - Important for MVP
- `priority:medium` - Nice to have for MVP
- `priority:low` - Post-MVP

## Label Reference

### Type Labels
- `feature` - New functionality
- `bug` - Something broken
- `chore` - Maintenance tasks
- `documentation` - Documentation updates
- `research` - Research and investigation
- `testing` - Testing tasks

### Technology Labels
- `frontend` - Frontend work
- `backend` - Backend work
- `database` - Database work
- `devops` - Infrastructure/DevOps
- `api` - API development
- `ui` - User interface
- `ux` - User experience
- `design` - Design work

### Priority Labels
- `priority:critical` - Drop everything
- `priority:high` - Important
- `priority:medium` - Normal
- `priority:low` - Nice to have

### Phase Labels
- `phase:1` - Planning & Design
- `phase:2` - MVP Development
- `phase:3` - Beta Testing
- `phase:4` - Production Launch
- `phase:5` - Ongoing Operations

### Size Labels
- `size:xs` - < 4 hours
- `size:s` - 0.5-1 day
- `size:m` - 1-2 days
- `size:l` - 3-5 days
- `size:xl` - 1+ week

### Special Labels
- `security` - Security-related
- `performance` - Performance optimization
- `accessibility` - Accessibility improvement
- `marketing` - Marketing tasks
- `support` - Customer support
- `legal` - Legal/compliance
- `mobile` - Mobile development
- `content` - Content-related

## Milestone Reference

1. **Phase 1: Planning & Design** - Due: 2025-01-31
2. **Phase 2: MVP Development** - Due: 2025-06-30
3. **Phase 3: Beta Testing** - Due: 2025-09-15
4. **Phase 4: Production Launch** - Due: 2025-10-15
5. **Phase 5: Ongoing Operations** - No due date (ongoing)

## Project Board Workflow

### Adding Issues to Project
Issues are automatically added to the project board when created with `--project "Criticalis Development"`.

### Organizing on Board
```bash
# View project board
gh project view 3 --owner jumson --web

# List items in project
gh project item-list 3 --owner jumson

# Add existing issue to project
gh project item-add 3 --owner jumson --url https://github.com/jumson/criticalis/issues/XX
```

### Status Fields
The project board should have columns for:
- **Backlog** - Not started
- **In Progress** - Currently working
- **In Review** - Code review or testing
- **Done** - Completed

## Example: Creating Phase 2 Sprint 2.1 Issues

Based on PROJECT_ROADMAP.md, here's how to create the remaining Sprint 2.1 issues:

```bash
# Issue: Setup package managers and dependencies
gh issue create \
  --title "Setup package managers and dependencies" \
  --body "## Description
Configure package manager and workspace for the project.

## Tasks
- [ ] Select npm/yarn/pnpm
- [ ] Configure lock file strategy
- [ ] Setup workspace configuration if monorepo
- [ ] Install initial dependencies
- [ ] Document package manager choice

## Acceptance Criteria
- Package manager configured
- Dependencies installable
- Workspace setup if needed

## Epic
Part of Epic 2.1.1: Development Environment Setup

## Dependencies
- Depends on #10 (Repository structure)" \
  --label "chore,phase:2,priority:critical,size:s" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"

# Issue: Configure TypeScript
gh issue create \
  --title "Configure TypeScript" \
  --body "## Description
Setup TypeScript configuration for the project.

## Tasks
- [ ] Create tsconfig.json files
- [ ] Configure strict mode
- [ ] Setup path aliases
- [ ] Configure for both frontend and backend
- [ ] Test compilation

## Acceptance Criteria
- TypeScript configured
- Strict mode enabled
- Compilation working
- Path aliases functional

## Epic
Part of Epic 2.1.1: Development Environment Setup" \
  --label "chore,phase:2,priority:high,size:s" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"

# Continue with remaining issues from PROJECT_ROADMAP.md...
```

## Automation Opportunities

### GitHub Actions for Auto-Labeling
Create `.github/workflows/auto-label.yml`:
```yaml
name: Auto-label issues
on:
  issues:
    types: [opened]
jobs:
  auto-label:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/labeler@v4
```

### Issue Templates
Create `.github/ISSUE_TEMPLATE/` with templates for:
- `feature.md` - Feature requests
- `bug.md` - Bug reports
- `epic.md` - Epic issues

## Best Practices

1. **Create issues in dependency order**: Start with foundation issues before feature issues
2. **Link dependencies**: Always reference blocking issues
3. **Use consistent formatting**: Follow the template structure
4. **Size appropriately**: Break down large issues (>5 days) into smaller ones
5. **Add acceptance criteria**: Clear definition of done
6. **Assign to milestones**: Keep issues organized by phase
7. **Tag with epics**: Use epic labels for grouping related work

## Workflow Integration

### Starting Work on an Issue
```bash
# Assign yourself
gh issue edit 25 --add-assignee @me

# Add status label
gh issue edit 25 --add-label "status:in-progress"

# Create branch
git checkout -b feature/25-repository-structure
```

### Completing an Issue
```bash
# Create PR that closes issue
gh pr create --title "Initialize repository structure" \
  --body "Implements repository structure.

## Changes
- Created directory structure
- Added initial package.json files

Closes #25"

# After PR merged, issue auto-closes
```

## Reference Documents

- **PROJECT_ROADMAP.md** - Complete issue specifications (145+ issues)
- **GITHUB_PROJECT_MANAGEMENT.md** - Comprehensive GitHub workflow guide
- **COST_BREAKDOWN.md** - Resource planning and timelines
- **CLAUDE.md** - Project overview and technical guidance

## Support

For questions or clarifications:
1. Review PROJECT_ROADMAP.md for issue details
2. Check GITHUB_PROJECT_MANAGEMENT.md for workflow guidance
3. See existing issues (#1-19) for formatting examples
4. Use `gh issue create --web` for interactive issue creation

## Summary

**Created So Far:**
- ✅ 24 Phase 1 issues (Planning & Design)
- ✅ 10 Phase 2 issues (Foundation and core features)

**To Create:**
- 📋 ~60 remaining Phase 2 issues
- 📋 ~24 Phase 3 issues
- 📋 ~13 Phase 4 issues
- 📋 ~12+ Phase 5 issues

**Total:** ~109 issues remaining to create from PROJECT_ROADMAP.md

Use this guide and the PROJECT_ROADMAP.md as your reference to create all remaining issues systematically.
