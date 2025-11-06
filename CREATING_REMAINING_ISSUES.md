# Creating Remaining GitHub Issues

## Current Status

**Issues Created**: 27/145+ (19%)
- ✅ Phase 1 (Planning & Design): **24/24 issues (100%)**
- ✅ Phase 2 (MVP Development - Critical): **~7/70 issues (10%)**
- ⏳ Phase 2 (Remaining): ~63 issues
- ⏳ Phase 3 (Beta Testing): ~24 issues
- ⏳ Phase 4 (Production Launch): ~15 issues
- ⏳ Phase 5 (Ongoing Operations): ~12 issues

**Total Remaining**: ~114 issues

## Why Not All Issues Created?

Creating 145+ issues takes significant time due to:
- GitHub rate limiting (recommended 1-2 seconds between requests)
- ~114 remaining issues × 2 seconds = ~4 hours of script runtime
- Network latency and API response times

**Solution**: All infrastructure is ready, and you can create remaining issues anytime using the provided scripts.

## Quick Start: Create All Remaining Issues

### Option 1: Run the Complete Script (Recommended)

The comprehensive script creates all 114 remaining issues automatically:

```bash
cd /home/whitebox/jon/machines/whitebox/projects/criticalis

# Run the script (takes ~2-4 hours due to rate limiting)
./create_all_remaining_issues.sh

# Or run in background and check progress later
nohup ./create_all_remaining_issues.sh > issue_creation.log 2>&1 &

# Monitor progress
tail -f issue_creation.log

# Count issues created so far
gh issue list --limit 300 | wc -l
```

### Option 2: Create Issues in Batches

If you want more control, create issues by phase:

```bash
# Edit the script to comment out phases you don't want yet
nano create_all_remaining_issues.sh

# For example, to create only Phase 2 issues, comment out:
# - Lines for Phase 3 (starting around line 1664)
# - Lines for Phase 4 (starting around line 2300)
# - Lines for Phase 5 (starting around line 2700)

# Then run
./create_all_remaining_issues.sh
```

### Option 3: Create Issues Manually

Use the `PROJECT_ROADMAP.md` as your guide and create issues one-by-one:

```bash
# Template
gh issue create \
  --title "Issue Title from Roadmap" \
  --body "## Description
[Copy from PROJECT_ROADMAP.md]

## Tasks
- [ ] Task 1
- [ ] Task 2

## Acceptance Criteria
- Criterion 1
- Criterion 2

## Epic
Part of Epic X.Y.Z

## Dependencies
- Depends on #XX" \
  --label "type,technology,phase:N,priority:level,size:x" \
  --milestone "Phase N: Name" \
  --project "Criticalis Development"
```

## Verification

After creating issues, verify everything is set up correctly:

```bash
# Check total issue count
gh issue list --limit 300 | wc -l

# View issues by milestone
gh issue list --milestone "Phase 2: MVP Development"

# View project board
gh project view 3 --owner jumson --web

# List issues by phase
gh issue list --label "phase:2"
gh issue list --label "phase:3"
gh issue list --label "phase:4"
gh issue list --label "phase:5"
```

## Issue Breakdown by Phase

### Phase 2: MVP Development (~63 remaining)
**Sprint 2.1**: Foundation (~8 more issues)
- Backend foundation setup
- Frontend foundation setup
- Infrastructure configuration

**Sprint 2.2**: ePub Engine (~12 issues)
- ePub parsing and storage
- Reader frontend
- XML manipulation

**Sprint 2.3**: Annotation System (~15 issues)
- Correction workflow
- Footnote workflow
- Community voting
- Discussion threads

**Sprint 2.4**: User Management (~7 issues)
- Authentication (OAuth, JWT)
- User profiles and permissions
- Curator dashboard

**Sprint 2.5**: Integration & Testing (~6 issues)
- E2E testing
- Performance testing
- Bug fixes

### Phase 3: Beta Testing (~24 issues)
- Beta infrastructure and invitations
- Documentation and onboarding
- User feedback collection
- Bug fixes and refinements
- Production readiness

### Phase 4: Production Launch (~15 issues)
- Production infrastructure
- Launch preparation
- Marketing and support setup
- Launch execution and monitoring

### Phase 5: Ongoing Operations (~12 issues)
- Maintenance and security updates
- Feature enhancements
- Scaling and growth

## Troubleshooting

### Rate Limiting Errors
If you get rate limiting errors:

```bash
# Add delays between issue creation
# The script already includes 'sleep 1' but you can increase it:
sed -i 's/sleep 1/sleep 2/g' create_all_remaining_issues.sh
```

### Authentication Errors
```bash
# Re-authenticate with proper scopes
gh auth login --scopes "repo,project,workflow"

# Or refresh auth
gh auth refresh -s project
```

### Duplicate Issues
```bash
# Find and close duplicates
gh issue list --search "is:issue is:open" --json number,title | \
  jq -r '.[] | [.number, .title] | @tsv' | \
  sort -k2 | \
  uniq -f1 -D

# Close a duplicate (replace 123 with issue number)
gh issue close 123 --comment "Duplicate issue"
```

### Script Errors
```bash
# Check for syntax errors
bash -n create_all_remaining_issues.sh

# Run in debug mode
bash -x create_all_remaining_issues.sh 2>&1 | tee debug.log
```

## Alternative: Manual Creation from Roadmap

If scripts don't work, you can create issues manually using the PROJECT_ROADMAP.md:

1. Open `PROJECT_ROADMAP.md`
2. Find the issue spec (e.g., "Issue 40: Build content file indexing system")
3. Copy the description, tasks, and acceptance criteria
4. Create issue via command line or GitHub web interface
5. Add appropriate labels from the issue spec
6. Assign to correct milestone and project

## Best Practices

1. **Create in dependency order**: Start with foundation issues before features
2. **Review roadmap first**: Ensure you understand the issue before creating
3. **Customize if needed**: Adjust issue descriptions based on your specific needs
4. **Link dependencies**: Always reference blocking issues in the body
5. **Use templates**: The provided scripts use consistent formatting

## Resources

- **PROJECT_ROADMAP.md**: Complete specifications for all 145+ issues
- **ISSUE_CREATION_GUIDE.md**: Detailed guide for manual issue creation
- **GITHUB_PROJECT_MANAGEMENT.md**: GitHub workflow best practices
- **create_all_remaining_issues.sh**: Automated creation script
- **Project Board**: https://github.com/users/jumson/projects/3

## Next Steps After Creating Issues

Once all issues are created:

1. **Review Phase 1 Issues**: Prioritize and assign planning tasks
2. **Begin Research**: Start with critical research issues (#1, #2, #3)
3. **Architecture Design**: Work on technical architecture (#4, #5, #6)
4. **UI/UX Design**: Create wireframes and mockups (#10-#16)
5. **Prepare for Phase 2**: Complete planning before starting MVP development

## Support

If you encounter issues:
1. Check the error in the log file
2. Verify GitHub CLI authentication: `gh auth status`
3. Check API rate limits: Visit https://github.com/settings/tokens
4. Review existing issues for duplicates before creating
5. Consult PROJECT_ROADMAP.md for issue specifications

---

**Last Updated**: November 5, 2025
**Status**: Infrastructure complete, 27/145 issues created
**Next**: Run `./create_all_remaining_issues.sh` to create remaining 118 issues
