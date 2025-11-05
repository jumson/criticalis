# GitHub CLI Project Management Cheatsheet

## 📋 Philosophy & Workflow

**Goal**: Use `gh` to manage the entire project lifecycle — from planning to execution to delivery — with full traceability between commits, issues, PRs, milestones, and project boards.

**Core Principles**:
- Every feature/bug gets an issue
- Issues belong to milestones (sprints/releases)
- Issues are tracked on project boards
- Commits reference issues (`#123`)
- PRs auto-link to issues via keywords
- Project boards auto-update via automation

---

## 🏗 Project Structure Strategy

### Recommended Project Types

1. **Main Roadmap** - High-level strategic view
2. **Release Projects** - One per major version (e.g., "v1.0", "v2.0")
3. **Sprint/Phase Projects** - Time-boxed work periods
4. **Team Projects** - Per-team backlogs (backend, frontend, etc.)

### Example Setup

```bash
# Main strategic board
gh project create --owner <ORG> --title "🗺 Product Roadmap" --format board

# Current release tracking
gh project create --owner <ORG> --title "🚀 Release v1.0" --format board

# Sprint board
gh project create --owner <ORG> --title "🏃 Sprint 2024-Q1" --format board

# Link projects to your repo so issues auto-appear
gh project link <PROJECT_NUMBER> --owner <ORG> --repo <REPO>
```

---

## 🎯 Milestone Management

### Create Milestones (via web or API)

```bash
# CLI doesn't have native milestone commands yet, use API:
gh api repos/<OWNER>/<REPO>/milestones \
  --method POST \
  --field title="v1.0 Beta" \
  --field description="Feature complete, ready for testing" \
  --field due_on="2024-12-31T23:59:59Z"

# List milestones
gh api repos/<OWNER>/<REPO>/milestones

# Close a milestone
gh api repos/<OWNER>/<REPO>/milestones/<NUMBER> \
  --method PATCH \
  --field state="closed"
```

---

## 📝 Issue Management Workflow

### 1. Create Issues with Full Metadata

```bash
# Feature request
gh issue create \
  --title "Add user authentication" \
  --body "Implement OAuth2 login flow with Google/GitHub providers" \
  --label "feature,priority:high" \
  --assignee @me \
  --milestone "v1.0 Beta" \
  --project "Release v1.0"

# Bug report
gh issue create \
  --title "Login fails with special characters" \
  --body "Users with + or @ in username cannot log in" \
  --label "bug,priority:critical" \
  --assignee @teamlead \
  --milestone "v1.0 Beta" \
  --project "Sprint 2024-Q1"

# Task with template
gh issue create --template bug_report.md
```

### 2. Batch Issue Creation (Planning Phase)

```bash
# Create issues from a list
cat <<EOF | while read title; do
  gh issue create --title "$title" --label "epic" --milestone "v1.0 Beta" --project "Product Roadmap"
done
User Authentication System
Payment Processing
Admin Dashboard
Notification System
EOF
```

### 3. Update Issues

```bash
# Add labels
gh issue edit 123 --add-label "needs-review,backend"

# Change milestone
gh issue edit 123 --milestone "v1.1"

# Add to project
gh issue edit 123 --add-project "Sprint 2024-Q1"

# Reassign
gh issue edit 123 --assignee @alice

# Update body
gh issue edit 123 --body "Updated requirements: ..."

# Comment on issue
gh issue comment 123 --body "Working on this now, ETA 3 days"
```

### 4. Link Issues to Each Other

```bash
# In issue body or comment, reference other issues:
gh issue comment 123 --body "Blocked by #456, depends on #789"

# Mark as duplicate
gh issue comment 123 --body "Duplicate of #100"
gh issue close 123 --reason "not planned"
```

### 5. Query & Filter Issues

```bash
# All open issues assigned to you
gh issue list --assignee @me --state open

# High priority bugs in current milestone
gh issue list --label "bug,priority:high" --milestone "v1.0 Beta"

# Recently updated issues
gh issue list --state all --search "updated:>2024-01-01"

# Issues in a project
gh project item-list <PROJECT_NUMBER> --owner <ORG> --format json | jq
```

---

## 🔀 Git Workflow with Smart Commits

### Branch Naming Convention

```bash
# Pattern: <type>/<issue-number>-<short-description>
git checkout -b feature/123-user-authentication
git checkout -b bugfix/456-login-special-chars
git checkout -b hotfix/789-security-patch
git checkout -b chore/101-update-dependencies
```

### Commit Message Format (Links to Issues)

```bash
# Imperative mood, reference issue number
git commit -m "Add OAuth2 login flow (#123)

- Implement Google provider
- Implement GitHub provider
- Add session management
- Update documentation

Related to #124, #125"

# For bug fixes
git commit -m "Fix login with special characters (#456)

Properly escape username input before validation.

Fixes #456"
```

### Commit Keywords that Auto-Close Issues

Use these in commit messages to auto-close issues when PR merges:

```bash
# Any of these will close the issue:
git commit -m "Fixes #123"
git commit -m "Resolves #123"
git commit -m "Closes #123"

# Multiple issues
git commit -m "Fixes #123, closes #456, resolves #789"
```

---

## 🔄 Pull Request Workflow

### 1. Create PR Linked to Issue

```bash
# Push branch
git push -u origin feature/123-user-authentication

# Create PR that auto-closes issue on merge
gh pr create \
  --title "Add user authentication system" \
  --body "Implements OAuth2 login flow.

## Changes
- Google OAuth2 provider
- GitHub OAuth2 provider
- Session management
- Unit tests

## Testing
- Manual testing with test accounts
- Added integration tests

Closes #123
Related to #124" \
  --assignee @me \
  --label "feature" \
  --milestone "v1.0 Beta" \
  --project "Release v1.0"

# Or use interactive mode
gh pr create --fill  # Auto-fills from commits

# Add PR to project board
gh project item-add <PROJECT_NUMBER> --owner <ORG> --url <PR_URL>
```

### 2. Link Existing PR to Issue

```bash
# Edit PR body to add "Closes #123"
gh pr edit 45 --body "$(gh pr view 45 --json body -q .body)

Closes #123"

# Or comment
gh pr comment 45 --body "This PR resolves #123"
```

### 3. PR Review Workflow

```bash
# Request review
gh pr edit 45 --add-reviewer @alice,@bob

# Check status
gh pr view 45

# Merge when ready (auto-closes linked issues)
gh pr merge 45 --squash --delete-branch

# Or merge with custom message
gh pr merge 45 --squash --body "Closes #123, closes #124"
```

---

## 📊 Project Board Management

### 1. View & Navigate Projects

```bash
# List all projects
gh project list --owner <ORG>

# View project in terminal
gh project view <PROJECT_NUMBER> --owner <ORG>

# Open in browser
gh project view <PROJECT_NUMBER> --owner <ORG> --web
```

### 2. Manage Items in Projects

```bash
# Add existing issue/PR to project
gh project item-add <PROJECT_NUMBER> --owner <ORG> --url <ISSUE_OR_PR_URL>

# Create draft issue directly in project
gh project item-create <PROJECT_NUMBER> --owner <ORG> \
  --title "Research cloud providers" \
  --body "Evaluate AWS vs GCP vs Azure"

# List all items
gh project item-list <PROJECT_NUMBER> --owner <ORG>

# Archive completed items
gh project item-archive <PROJECT_NUMBER> --owner <ORG> --id <ITEM_ID>

# Delete item from project (doesn't delete the issue)
gh project item-delete <PROJECT_NUMBER> --owner <ORG> --id <ITEM_ID>
```

### 3. Update Item Fields (Status, Priority, etc.)

```bash
# Note: Field updates require GraphQL API
# Get project and field IDs first:
gh project view <PROJECT_NUMBER> --owner <ORG> --format json

# Update status field (example)
gh project item-edit \
  --project-id <PROJECT_ID> \
  --id <ITEM_ID> \
  --field-id <STATUS_FIELD_ID> \
  --option-id <OPTION_ID>

# Easier: Use GitHub CLI extensions or web UI for field updates
```

---

## 🏷 Label Strategy

### Create Consistent Label System

```bash
# Type labels
gh label create "feature" --color "0e8a16" --description "New feature"
gh label create "bug" --color "d73a4a" --description "Something broken"
gh label create "chore" --color "fef2c0" --description "Maintenance task"
gh label create "docs" --color "0075ca" --description "Documentation"

# Priority labels
gh label create "priority:critical" --color "b60205" --description "Drop everything"
gh label create "priority:high" --color "d93f0b" --description "Important"
gh label create "priority:medium" --color "fbca04" --description "Normal"
gh label create "priority:low" --color "0e8a16" --description "Nice to have"

# Status labels
gh label create "status:blocked" --color "d93f0b" --description "Blocked by something"
gh label create "status:in-progress" --color "fbca04" --description "Actively working"
gh label create "status:review" --color "0075ca" --description "Needs review"

# Size labels (for estimation)
gh label create "size:xs" --color "c2e0c6" --description "< 1 hour"
gh label create "size:s" --color "c2e0c6" --description "< 4 hours"
gh label create "size:m" --color "bfdadc" --description "< 2 days"
gh label create "size:l" --color "f9d0c4" --description "< 1 week"
gh label create "size:xl" --color "f9d0c4" --description "> 1 week"

# List labels
gh label list
```

---

## 🤖 Automation & Keeping Things Updated

### 1. Auto-add Issues to Projects

```bash
# Link repo to project so new issues auto-appear
gh project link <PROJECT_NUMBER> --owner <ORG> --repo <REPO>

# GitHub Actions can auto-add issues to projects:
# .github/workflows/add-to-project.yml
```

### 2. Status Sync Script

Save as `sync-project.sh`:

```bash
#!/bin/bash
# Sync issue status to project board

PROJECT_NUMBER=1
OWNER="your-org"
REPO="your-repo"

# Close completed issues
gh issue list --state open --label "status:done" --json number --jq '.[].number' | while read issue; do
  echo "Closing completed issue #$issue"
  gh issue close $issue --comment "Completed ✅"
done

# Add new issues to project
gh issue list --state open --json number,url --jq '.[] | select(.projectItems | length == 0) | .url' | while read url; do
  echo "Adding $url to project"
  gh project item-add $PROJECT_NUMBER --owner $OWNER --url $url
done
```

### 3. Daily Standup Report

```bash
#!/bin/bash
# Generate daily status report

echo "## 📊 Daily Standup - $(date +%Y-%m-%d)"
echo ""
echo "### ✅ Closed Yesterday"
gh issue list --state closed --search "closed:>=$(date -d '1 day ago' +%Y-%m-%d)" --json number,title --jq '.[] | "- #\(.number) \(.title)"'
echo ""
echo "### 🏗 In Progress"
gh issue list --assignee @me --state open --label "status:in-progress" --json number,title --jq '.[] | "- #\(.number) \(.title)"'
echo ""
echo "### 🚧 Blocked"
gh issue list --state open --label "status:blocked" --json number,title,assignees --jq '.[] | "- #\(.number) \(.title) (@\(.assignees[0].login))"'
```

---

## 📈 Reporting & Metrics

### Milestone Progress

```bash
# Check milestone completion
gh api repos/<OWNER>/<REPO>/milestones/<NUMBER> --jq '
  "Milestone: \(.title)",
  "Progress: \(.closed_issues)/\(.open_issues + .closed_issues) issues closed",
  "Due: \(.due_on)",
  "State: \(.state)"
'
```

### Velocity Tracking

```bash
# Issues closed per week
gh issue list --state closed --search "closed:>=$(date -d '7 days ago' +%Y-%m-%d)" --json number | jq 'length'

# Issues by label (distribution)
gh issue list --state all --json labels --jq '
  [.[].labels[].name] | group_by(.) | 
  map({label: .[0], count: length}) | 
  sort_by(.count) | reverse
'
```

### Project Health Check

```bash
#!/bin/bash
# Check project health

echo "## Project Health Report"
echo ""
echo "### Issue Stats"
echo "- Total open: $(gh issue list --state open --json number | jq 'length')"
echo "- Unassigned: $(gh issue list --state open --json assignees --jq '[.[] | select(.assignees | length == 0)] | length')"
echo "- Blocked: $(gh issue list --state open --label status:blocked --json number | jq 'length')"
echo "- No milestone: $(gh issue list --state open --search 'no:milestone' --json number | jq 'length')"
echo "- Stale (>30 days): $(gh issue list --state open --search 'updated:<$(date -d '30 days ago' +%Y-%m-%d)' --json number | jq 'length')"
```

---

## 🎬 Complete Project Lifecycle Example

### Phase 1: Project Kickoff

```bash
# 1. Create project structure
gh project create --owner myorg --title "🚀 Product v2.0" --format board
gh project create --owner myorg --title "🏃 Sprint 1 - Foundation" --format board

# 2. Create milestone
gh api repos/myorg/myrepo/milestones \
  --method POST \
  --field title="v2.0 Alpha" \
  --field due_on="2024-06-30T23:59:59Z"

# 3. Link project to repo
gh project link 1 --owner myorg --repo myrepo

# 4. Create epics
gh issue create --title "🎯 EPIC: User Authentication Overhaul" --label "epic" --milestone "v2.0 Alpha" --project "Product v2.0"
gh issue create --title "🎯 EPIC: New Dashboard UI" --label "epic" --milestone "v2.0 Alpha" --project "Product v2.0"

# 5. Break down into issues
gh issue create --title "Research OAuth2 providers" --body "Part of #1" --label "research" --milestone "v2.0 Alpha" --project "Sprint 1"
gh issue create --title "Design login screen mockups" --body "Part of #1" --label "design" --milestone "v2.0 Alpha" --project "Sprint 1"
```

### Phase 2: Active Development

```bash
# 6. Pick up an issue
gh issue list --assignee @me --milestone "v2.0 Alpha"
gh issue view 3

# 7. Start work
git checkout -b feature/3-oauth-research
gh issue edit 3 --add-label "status:in-progress"
gh issue comment 3 --body "Started research, investigating Google + GitHub providers"

# 8. Commit work
git commit -m "Add OAuth2 provider comparison matrix (#3)

Evaluated Google, GitHub, Auth0, and Okta.
Recommendation: Start with Google + GitHub.

Related to #1"

# 9. Create PR
git push -u origin feature/3-oauth-research
gh pr create --fill --web

# 10. Update PR to close issue
gh pr edit 12 --body "$(gh pr view 12 --json body -q .body)

Closes #3"

# 11. Get review and merge
gh pr review 12 --approve
gh pr merge 12 --squash --delete-branch
# Issue #3 automatically closes!
```

### Phase 3: Sprint Close & Release

```bash
# 12. Review sprint completion
gh project view 2 --owner myorg  # Sprint board
gh issue list --milestone "v2.0 Alpha" --state open

# 13. Move unfinished items
gh issue list --milestone "v2.0 Alpha" --state open --json number | jq -r '.[].number' | while read issue; do
  gh issue edit $issue --milestone "v2.0 Beta"
done

# 14. Close milestone
gh api repos/myorg/myrepo/milestones/1 --method PATCH --field state="closed"

# 15. Create release
gh release create v2.0.0-alpha \
  --title "v2.0 Alpha Release" \
  --notes "First alpha release of v2.0

## Features
- OAuth2 authentication (#3, #5)
- New dashboard UI (#7)

## Bug Fixes
- Fixed login edge cases (#12)

Full changelog: https://github.com/myorg/myrepo/compare/v1.0...v2.0.0-alpha"
```

---

## 🔐 Authentication Setup

```bash
# Initial auth with all needed scopes
gh auth login --scopes "repo,project,workflow"

# Or refresh to add project scope
gh auth refresh -s project

# Check status
gh auth status
```

---

## 💡 Pro Tips

1. **Use templates**: Create issue/PR templates in `.github/ISSUE_TEMPLATE/` and `.github/pull_request_template.md`

2. **Alias common commands**:
```bash
# Add to ~/.bashrc or ~/.zshrc
alias ghic='gh issue create --web'
alias ghil='gh issue list --assignee @me'
alias ghpc='gh pr create --fill --web'
alias ghpv='gh pr view --web'
```

3. **JSON output for scripting**:
```bash
gh issue list --json number,title,labels,milestone --jq '.[] | select(.milestone.title == "v2.0")'
```

4. **Use GitHub Actions** for automation (auto-label, auto-assign, auto-project-add)

5. **Regular syncs**: Run daily/weekly scripts to keep boards updated

6. **Commit message conventions**: Use Conventional Commits (feat:, fix:, docs:, etc.)

---

## 📚 Quick Reference

| Task | Command |
|------|---------|
| Create issue | `gh issue create --title "..." --label "..." --milestone "..." --project "..."` |
| List my issues | `gh issue list --assignee @me` |
| Comment on issue | `gh issue comment 123 --body "..."` |
| Close issue | `gh issue close 123` |
| Create PR | `gh pr create --fill` |
| Merge PR | `gh pr merge 123 --squash` |
| Create project | `gh project create --owner <ORG> --title "..."` |
| Add to project | `gh project item-add <NUM> --owner <ORG> --url <URL>` |
| List project items | `gh project item-list <NUM> --owner <ORG>` |
| Create milestone | `gh api repos/<OWNER>/<REPO>/milestones --method POST --field title="..."` |
| Create label | `gh label create "name" --color "hex" --description "..."` |

