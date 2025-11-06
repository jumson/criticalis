#!/bin/bash
# Comprehensive script to create ALL remaining GitHub issues for Criticalis

set -e  # Exit on error

echo "=================================="
echo "Creating ALL Remaining Issues"
echo "=================================="
echo ""

# Track progress
TOTAL_CREATED=0

# ==========================================
# PHASE 2 - SPRINT 2.1: Foundation (Remaining)
# ==========================================

echo "Creating Phase 2 - Sprint 2.1 remaining issues..."

# Issue 20: Setup package managers
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
((TOTAL_CREATED++))

# Issue 21: Configure TypeScript
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
((TOTAL_CREATED++))

# Issue 22: Setup linting and formatting
gh issue create \
  --title "Setup linting and formatting" \
  --body "## Description
Configure ESLint, Prettier, and pre-commit hooks.

## Tasks
- [ ] Configure ESLint
- [ ] Configure Prettier
- [ ] Setup Husky pre-commit hooks
- [ ] Add lint-staged
- [ ] Configure IDE integration
- [ ] Test on sample code

## Acceptance Criteria
- Linting works on all code
- Formatting automatic
- Pre-commit hooks block bad code
- Team can use easily

## Epic
Part of Epic 2.1.1: Development Environment Setup" \
  --label "chore,phase:2,priority:high,size:s" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 23: Configure testing framework
gh issue create \
  --title "Configure testing framework" \
  --body "## Description
Setup Jest or Vitest for unit and integration testing.

## Tasks
- [ ] Select Jest or Vitest
- [ ] Configure test runner
- [ ] Setup testing utilities and helpers
- [ ] Configure coverage reporting
- [ ] Add test scripts to package.json
- [ ] Write sample tests

## Acceptance Criteria
- Tests run successfully
- Coverage reports generated
- Both frontend and backend covered
- CI integration ready

## Epic
Part of Epic 2.1.1: Development Environment Setup" \
  --label "testing,phase:2,priority:high,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 24: Setup CI/CD pipeline
gh issue create \
  --title "Setup CI/CD pipeline" \
  --body "## Description
Configure GitHub Actions for automated builds, tests, and deployments.

## Tasks
- [ ] Create GitHub Actions workflows
- [ ] Setup build automation
- [ ] Setup test automation
- [ ] Setup lint checks
- [ ] Configure branch protection rules
- [ ] Add status badges

## Acceptance Criteria
- CI runs on all PRs
- Tests run automatically
- Build succeeds
- Branch protection enforced

## Epic
Part of Epic 2.1.1: Development Environment Setup" \
  --label "devops,phase:2,priority:critical,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 25: Implement database migrations
gh issue create \
  --title "Implement database migrations" \
  --body "## Description
Create initial database migrations based on schema design.

## Tasks
- [ ] Create migration framework setup
- [ ] Implement initial schema migration
- [ ] Create seed data for development
- [ ] Add migration scripts to package.json
- [ ] Document migration workflow
- [ ] Test migration rollback

## Acceptance Criteria
- Migrations run successfully
- Database schema created
- Seed data loads
- Rollback works

## Epic
Part of Epic 2.1.2: Backend Foundation

## Dependencies
- Requires #12 (PostgreSQL setup)
- Requires #4 (Database schema design)" \
  --label "database,backend,phase:2,priority:critical,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 26: Setup environment configuration
gh issue create \
  --title "Setup environment configuration" \
  --body "## Description
Configure environment variables and secrets management.

## Tasks
- [ ] Setup dotenv configuration
- [ ] Create .env.example file
- [ ] Add config validation
- [ ] Document all environment variables
- [ ] Setup secrets management strategy
- [ ] Add environment-specific configs

## Acceptance Criteria
- Environment config working
- Validation prevents missing vars
- Documentation complete
- Secrets secure

## Epic
Part of Epic 2.1.2: Backend Foundation" \
  --label "backend,phase:2,priority:high,size:s" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 27: Implement logging infrastructure
gh issue create \
  --title "Implement logging infrastructure" \
  --body "## Description
Setup structured logging with Winston or Pino.

## Tasks
- [ ] Select logging library (Winston/Pino)
- [ ] Configure log levels
- [ ] Setup log formatting
- [ ] Add request logging middleware
- [ ] Configure log rotation
- [ ] Add error logging

## Acceptance Criteria
- Structured logs generated
- Different log levels work
- Request logging functional
- Logs useful for debugging

## Epic
Part of Epic 2.1.2: Backend Foundation" \
  --label "backend,phase:2,priority:high,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 28: Setup error handling middleware
gh issue create \
  --title "Setup error handling middleware" \
  --body "## Description
Implement global error handling for the backend.

## Tasks
- [ ] Create global error handler
- [ ] Define custom error classes
- [ ] Add error reporting (Sentry)
- [ ] Format error responses
- [ ] Add error logging
- [ ] Test error scenarios

## Acceptance Criteria
- All errors caught and logged
- User-friendly error responses
- Error reporting working
- No unhandled rejections

## Epic
Part of Epic 2.1.2: Backend Foundation" \
  --label "backend,phase:2,priority:high,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 29: Setup routing
gh issue create \
  --title "Setup routing" \
  --body "## Description
Configure React Router for frontend navigation.

## Tasks
- [ ] Install React Router
- [ ] Configure route definitions
- [ ] Setup protected routes
- [ ] Add navigation components
- [ ] Implement 404 page
- [ ] Test navigation

## Acceptance Criteria
- Routing works smoothly
- Protected routes functional
- Navigation intuitive
- Browser back/forward work

## Epic
Part of Epic 2.1.3: Frontend Foundation" \
  --label "frontend,phase:2,priority:high,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 30: Setup state management
gh issue create \
  --title "Setup state management" \
  --body "## Description
Configure global state management for the frontend.

## Tasks
- [ ] Select state library (Redux/Zustand/Jotai)
- [ ] Configure store
- [ ] Setup DevTools
- [ ] Create initial state structure
- [ ] Add state persistence if needed
- [ ] Document state patterns

## Acceptance Criteria
- State management working
- DevTools functional
- State updates properly
- Patterns documented

## Epic
Part of Epic 2.1.3: Frontend Foundation" \
  --label "frontend,phase:2,priority:high,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 31: Setup UI component library
gh issue create \
  --title "Setup UI component library" \
  --body "## Description
Configure UI component library and theming.

## Tasks
- [ ] Select library (Material-UI/Chakra/Ant Design)
- [ ] Configure theme
- [ ] Setup custom components
- [ ] Create component patterns
- [ ] Add dark mode support
- [ ] Document component usage

## Acceptance Criteria
- Component library integrated
- Theme customized
- Components render properly
- Dark mode works

## Epic
Part of Epic 2.1.3: Frontend Foundation" \
  --label "frontend,ui,phase:2,priority:high,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 32: Implement API client layer
gh issue create \
  --title "Implement API client layer" \
  --body "## Description
Create API client wrapper for backend communication.

## Tasks
- [ ] Setup axios or fetch wrapper
- [ ] Add request interceptors
- [ ] Add response interceptors
- [ ] Implement error handling
- [ ] Add authentication headers
- [ ] Create typed API methods

## Acceptance Criteria
- API calls work reliably
- Errors handled gracefully
- Auth headers added automatically
- TypeScript types correct

## Epic
Part of Epic 2.1.3: Frontend Foundation" \
  --label "frontend,api,phase:2,priority:high,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 33: Setup form handling
gh issue create \
  --title "Setup form handling" \
  --body "## Description
Configure form library and validation.

## Tasks
- [ ] Select form library (React Hook Form/Formik)
- [ ] Configure validation (Yup/Zod)
- [ ] Create form components
- [ ] Add error display
- [ ] Test validation
- [ ] Document patterns

## Acceptance Criteria
- Forms work smoothly
- Validation robust
- Error messages clear
- Accessible forms

## Epic
Part of Epic 2.1.3: Frontend Foundation" \
  --label "frontend,phase:2,priority:medium,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 34: Setup cloud development environment
gh issue create \
  --title "Setup cloud development environment" \
  --body "## Description
Create cloud infrastructure for development environment.

## Tasks
- [ ] Setup cloud provider account (AWS/GCP)
- [ ] Configure VPC and networking
- [ ] Create IAM roles and policies
- [ ] Setup access controls
- [ ] Document infrastructure
- [ ] Add cost monitoring

## Acceptance Criteria
- Cloud environment ready
- Networking configured
- Access controls in place
- Costs tracked

## Epic
Part of Epic 2.1.4: Infrastructure Setup

## Dependencies
- Requires #7 (Infrastructure architecture design)" \
  --label "devops,phase:2,priority:high,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 35: Setup development database instance
gh issue create \
  --title "Setup development database instance" \
  --body "## Description
Create managed PostgreSQL instance for development.

## Tasks
- [ ] Create RDS or managed PostgreSQL instance
- [ ] Configure backup policies
- [ ] Setup connection security
- [ ] Configure monitoring
- [ ] Test connection from app
- [ ] Document access procedures

## Acceptance Criteria
- Database instance running
- Backups configured
- Connection secure
- Monitoring active

## Epic
Part of Epic 2.1.4: Infrastructure Setup" \
  --label "devops,database,phase:2,priority:high,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 36: Setup S3/object storage buckets
gh issue create \
  --title "Setup S3/object storage buckets" \
  --body "## Description
Configure object storage for ePub files and assets.

## Tasks
- [ ] Create S3 buckets or equivalent
- [ ] Configure CORS policies
- [ ] Setup access policies
- [ ] Configure lifecycle rules
- [ ] Test file upload/download
- [ ] Document bucket structure

## Acceptance Criteria
- Buckets created
- CORS working
- Files uploadable
- Access secure

## Epic
Part of Epic 2.1.4: Infrastructure Setup" \
  --label "devops,phase:2,priority:medium,size:s" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 37: Configure CDN for static assets
gh issue create \
  --title "Configure CDN for static assets" \
  --body "## Description
Setup CDN for serving static files and ePub content.

## Tasks
- [ ] Configure CloudFront/CloudFlare
- [ ] Setup cache policies
- [ ] Configure origin settings
- [ ] Add SSL certificates
- [ ] Test asset delivery
- [ ] Monitor performance

## Acceptance Criteria
- CDN serving assets
- Cache policies effective
- SSL working
- Fast delivery

## Epic
Part of Epic 2.1.4: Infrastructure Setup" \
  --label "devops,phase:2,priority:medium,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 38: Setup monitoring and alerts
gh issue create \
  --title "Setup monitoring and alerts" \
  --body "## Description
Configure application and infrastructure monitoring.

## Tasks
- [ ] Setup CloudWatch/Datadog
- [ ] Configure alert thresholds
- [ ] Add performance monitoring
- [ ] Setup error tracking
- [ ] Create dashboards
- [ ] Test alerts

## Acceptance Criteria
- Monitoring active
- Alerts triggering correctly
- Dashboards useful
- Errors tracked

## Epic
Part of Epic 2.1.4: Infrastructure Setup" \
  --label "devops,phase:2,priority:medium,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

echo "Phase 2 Sprint 2.1 complete: $TOTAL_CREATED issues created"
echo ""

# Continue with Sprint 2.2...
echo "Creating Phase 2 - Sprint 2.2 issues (ePub Engine)..."

# Issue 39: Implement ePub file upload
gh issue create \
  --title "Implement ePub file upload" \
  --body "## Description
Build backend service for uploading ePub files.

## Tasks
- [ ] Implement multipart form handling
- [ ] Add file validation (ePub format check)
- [ ] Upload to S3/object storage
- [ ] Generate file metadata
- [ ] Add virus scanning
- [ ] Handle large files

## Acceptance Criteria
- Files upload successfully
- Format validation works
- Stored securely in S3
- Metadata captured

## Epic
Part of Epic 2.2.1: ePub Parser & Storage" \
  --label "backend,feature,phase:2,priority:critical,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 40: Build content file indexing system
gh issue create \
  --title "Build content file indexing system" \
  --body "## Description
Create system to index all content XML files from ePub.

## Tasks
- [ ] Index all content XML files
- [ ] Map paragraph positions
- [ ] Map word positions
- [ ] Create searchable index
- [ ] Store index in database
- [ ] Optimize query performance

## Acceptance Criteria
- All content indexed
- Word positions accurate
- Search queries fast
- Index maintainable

## Epic
Part of Epic 2.2.1: ePub Parser & Storage" \
  --label "backend,feature,phase:2,priority:critical,size:l" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 41: Implement ePub content API
gh issue create \
  --title "Implement ePub content API" \
  --body "## Description
Create REST API endpoints for accessing ePub content.

## Tasks
- [ ] Implement GET /api/epubs/:id/toc
- [ ] Implement GET /api/epubs/:id/content/:fileId
- [ ] Implement GET /api/epubs/:id/metadata
- [ ] Add caching for content
- [ ] Add pagination for large content
- [ ] Document API endpoints

## Acceptance Criteria
- All endpoints functional
- Content returned correctly
- Caching improves performance
- API documented

## Epic
Part of Epic 2.2.1: ePub Parser & Storage" \
  --label "backend,api,phase:2,priority:critical,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 42: Create Git repository for each ePub
gh issue create \
  --title "Create Git repository for each ePub" \
  --body "## Description
Initialize Git repository for version controlling ePub content.

## Tasks
- [ ] Initialize Git repo per ePub
- [ ] Commit initial content files
- [ ] Create staging branch
- [ ] Create final/master branch
- [ ] Configure Git hooks
- [ ] Document Git workflow

## Acceptance Criteria
- Git repos created
- Initial content committed
- Branches set up
- Workflow documented

## Epic
Part of Epic 2.2.1: ePub Parser & Storage

## Dependencies
- Requires #2 (Git library research)" \
  --label "backend,feature,phase:2,priority:critical,size:l" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 43: Integrate epub.js library
gh issue create \
  --title "Integrate epub.js library" \
  --body "## Description
Integrate epub.js for ePub rendering in the browser.

## Tasks
- [ ] Install epub.js
- [ ] Configure library settings
- [ ] Test basic rendering
- [ ] Handle different ePub versions
- [ ] Add error handling
- [ ] Optimize performance

## Acceptance Criteria
- epub.js integrated
- ePubs render correctly
- Performance acceptable
- Errors handled

## Epic
Part of Epic 2.2.2: ePub Reader Frontend

## Dependencies
- Requires #1 (ePub library research)" \
  --label "frontend,feature,phase:2,priority:critical,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 44: Implement table of contents navigation
gh issue create \
  --title "Implement table of contents navigation" \
  --body "## Description
Build TOC sidebar and navigation system.

## Tasks
- [ ] Create TOC sidebar component
- [ ] Render TOC tree structure
- [ ] Implement chapter navigation
- [ ] Add bookmarking functionality
- [ ] Highlight current chapter
- [ ] Make responsive for mobile

## Acceptance Criteria
- TOC displays correctly
- Navigation smooth
- Bookmarks work
- Mobile friendly

## Epic
Part of Epic 2.2.2: ePub Reader Frontend" \
  --label "frontend,feature,phase:2,priority:high,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 45: Implement search functionality
gh issue create \
  --title "Implement search functionality" \
  --body "## Description
Add full-text search within ePub content.

## Tasks
- [ ] Build search UI component
- [ ] Implement search API calls
- [ ] Highlight search results
- [ ] Navigate between results
- [ ] Add search filters
- [ ] Optimize search performance

## Acceptance Criteria
- Search finds text accurately
- Results highlighted
- Navigation easy
- Performance good

## Epic
Part of Epic 2.2.2: ePub Reader Frontend" \
  --label "frontend,feature,phase:2,priority:medium,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 46: Build reading progress tracking
gh issue create \
  --title "Build reading progress tracking" \
  --body "## Description
Track and save user's reading progress.

## Tasks
- [ ] Save last reading position
- [ ] Calculate progress percentage
- [ ] Sync across devices
- [ ] Add progress indicator
- [ ] Resume from last position
- [ ] Handle offline mode

## Acceptance Criteria
- Position saved automatically
- Progress accurate
- Resume works
- Cross-device sync

## Epic
Part of Epic 2.2.2: ePub Reader Frontend" \
  --label "frontend,feature,phase:2,priority:medium,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 47: Implement XML parser for content files
gh issue create \
  --title "Implement XML parser for content files" \
  --body "## Description
Build robust XML parser for ePub content manipulation.

## Tasks
- [ ] Select XML parsing library
- [ ] Parse XML preserving structure
- [ ] Create DOM manipulation utilities
- [ ] Handle malformed XML
- [ ] Add validation
- [ ] Test with real content

## Acceptance Criteria
- XML parsed correctly
- Structure preserved
- Manipulation utilities work
- Handles edge cases

## Epic
Part of Epic 2.2.3: XML Content Manipulation" \
  --label "backend,feature,phase:2,priority:critical,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 48: Build word-level positioning system
gh issue create \
  --title "Build word-level positioning system" \
  --body "## Description
Create system to map each word to its exact XML location.

## Tasks
- [ ] Map words to XML paths
- [ ] Handle span-wrapped words
- [ ] Track character offsets
- [ ] Build position index
- [ ] Optimize lookup performance
- [ ] Test accuracy

## Acceptance Criteria
- Every word mappable
- Span wrapping handled
- Fast lookups
- 100% accuracy

## Epic
Part of Epic 2.2.3: XML Content Manipulation" \
  --label "backend,feature,phase:2,priority:critical,size:l" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 49: Implement text replacement in XML
gh issue create \
  --title "Implement text replacement in XML" \
  --body "## Description
Build system to replace text while preserving XML structure.

## Tasks
- [ ] Implement text replacement logic
- [ ] Preserve XML structure and attributes
- [ ] Maintain styling
- [ ] Validate XML after edit
- [ ] Handle edge cases
- [ ] Test thoroughly

## Acceptance Criteria
- Text replaced accurately
- Structure preserved
- Styles maintained
- XML valid after edit

## Epic
Part of Epic 2.2.3: XML Content Manipulation" \
  --label "backend,feature,phase:2,priority:critical,size:l" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 50: Implement footnote insertion in XML
gh issue create \
  --title "Implement footnote insertion in XML" \
  --body "## Description
Build system to insert footnotes into ePub XML content.

## Tasks
- [ ] Insert footnote reference markers
- [ ] Add footnote content at section end
- [ ] Link reference to content
- [ ] Generate unique IDs
- [ ] Maintain XML validity
- [ ] Test rendering

## Acceptance Criteria
- Footnotes insert correctly
- Links work
- XML remains valid
- Renders properly

## Epic
Part of Epic 2.2.3: XML Content Manipulation" \
  --label "backend,feature,phase:2,priority:high,size:l" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

echo "Phase 2 Sprint 2.2 complete: Additional issues created"
echo ""

# Continue with Sprint 2.3...
echo "Creating Phase 2 - Sprint 2.3 issues (Annotation System)..."

# Issue 51: Create Git commit for correction
gh issue create \
  --title "Create Git commit for correction" \
  --body "## Description
Automatically create Git commits when corrections are submitted.

## Tasks
- [ ] Generate commit message from correction
- [ ] Commit to staging branch
- [ ] Track commit hash in database
- [ ] Link commit to issue/PR
- [ ] Handle commit failures
- [ ] Add metadata

## Acceptance Criteria
- Commits created automatically
- Commit messages descriptive
- Hashes tracked
- Failures handled

## Epic
Part of Epic 2.3.1: Correction Workflow

## Dependencies
- Requires #42 (Git repository setup)" \
  --label "backend,feature,phase:2,priority:critical,size:l" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 52: Build correction list view
gh issue create \
  --title "Build correction list view" \
  --body "## Description
Create UI to view all corrections for an ePub.

## Tasks
- [ ] Build list component
- [ ] Add filtering (pending/approved/rejected)
- [ ] Add sorting (votes/date)
- [ ] Show correction details
- [ ] Add pagination
- [ ] Make responsive

## Acceptance Criteria
- List displays all corrections
- Filtering works
- Sorting functional
- Responsive design

## Epic
Part of Epic 2.3.1: Correction Workflow" \
  --label "frontend,feature,phase:2,priority:high,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 53: Implement inline correction display
gh issue create \
  --title "Implement inline correction display" \
  --body "## Description
Show corrections inline within the reader view.

## Tasks
- [ ] Highlight corrected text
- [ ] Show tooltip with correction details
- [ ] Toggle original/corrected view
- [ ] Add visual indicators
- [ ] Handle multiple corrections
- [ ] Test performance

## Acceptance Criteria
- Corrections visible inline
- Details accessible
- Toggle works smoothly
- Performance good

## Epic
Part of Epic 2.3.1: Correction Workflow" \
  --label "frontend,feature,phase:2,priority:high,size:l" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 54: Build footnote proposal UI
gh issue create \
  --title "Build footnote proposal UI" \
  --body "## Description
Create interface for proposing footnotes.

## Tasks
- [ ] Build footnote modal
- [ ] Add rich text editor
- [ ] Preview formatting
- [ ] Character limit
- [ ] Add explanation field
- [ ] Test usability

## Acceptance Criteria
- UI intuitive
- Rich text works
- Preview accurate
- Mobile friendly

## Epic
Part of Epic 2.3.2: Footnote/Annotation Workflow" \
  --label "frontend,feature,phase:2,priority:critical,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 55: Implement footnote submission API
gh issue create \
  --title "Implement footnote submission API" \
  --body "## Description
Create backend API for submitting footnotes.

## Tasks
- [ ] Create POST /api/footnotes endpoint
- [ ] Support markdown or HTML content
- [ ] Link to text range
- [ ] Validate input
- [ ] Sanitize content
- [ ] Store in database

## Acceptance Criteria
- API endpoint works
- Content validated
- XSS prevented
- Data stored correctly

## Epic
Part of Epic 2.3.2: Footnote/Annotation Workflow" \
  --label "backend,api,feature,phase:2,priority:critical,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 56: Create Git commit for footnote
gh issue create \
  --title "Create Git commit for footnote" \
  --body "## Description
Automatically commit footnotes to Git.

## Tasks
- [ ] Insert footnote into XML
- [ ] Generate commit message
- [ ] Commit to staging branch
- [ ] Track commit hash
- [ ] Handle failures
- [ ] Add metadata

## Acceptance Criteria
- Footnotes committed automatically
- XML structure maintained
- Commits tracked
- Errors handled

## Epic
Part of Epic 2.3.2: Footnote/Annotation Workflow" \
  --label "backend,feature,phase:2,priority:critical,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 57: Build footnote display in reader
gh issue create \
  --title "Build footnote display in reader" \
  --body "## Description
Render footnotes in the ePub reader.

## Tasks
- [ ] Add superscript markers
- [ ] Implement popup on hover
- [ ] Add click to jump to footnote
- [ ] Render formatted content
- [ ] Handle multiple footnotes
- [ ] Mobile optimization

## Acceptance Criteria
- Footnotes render correctly
- Markers visible
- Navigation smooth
- Mobile friendly

## Epic
Part of Epic 2.3.2: Footnote/Annotation Workflow" \
  --label "frontend,feature,phase:2,priority:high,size:l" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 58: Implement footnote list view
gh issue create \
  --title "Implement footnote list view" \
  --body "## Description
Create UI to view all footnotes for current chapter.

## Tasks
- [ ] Build footnote list component
- [ ] Add filtering and search
- [ ] Show footnote context
- [ ] Link to text location
- [ ] Add pagination
- [ ] Make responsive

## Acceptance Criteria
- All footnotes listed
- Search works
- Links functional
- Responsive

## Epic
Part of Epic 2.3.2: Footnote/Annotation Workflow" \
  --label "frontend,feature,phase:2,priority:medium,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 59: Build voting UI components
gh issue create \
  --title "Build voting UI components" \
  --body "## Description
Create upvote/downvote UI components.

## Tasks
- [ ] Build vote buttons
- [ ] Show vote count
- [ ] Indicate user's vote
- [ ] Add vote animations
- [ ] Handle vote changes
- [ ] Show voting stats

## Acceptance Criteria
- Voting intuitive
- Animations smooth
- User's vote clear
- Stats accurate

## Epic
Part of Epic 2.3.3: Community Voting" \
  --label "frontend,feature,phase:2,priority:critical,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 60: Implement voting API
gh issue create \
  --title "Implement voting API" \
  --body "## Description
Create backend API for voting on corrections and footnotes.

## Tasks
- [ ] Create POST /api/corrections/:id/vote
- [ ] Create POST /api/footnotes/:id/vote
- [ ] Validate one vote per user
- [ ] Handle vote changes
- [ ] Update vote counts
- [ ] Add rate limiting

## Acceptance Criteria
- Voting API works
- One vote per user enforced
- Vote changes handled
- Counts accurate

## Epic
Part of Epic 2.3.3: Community Voting" \
  --label "backend,api,feature,phase:2,priority:critical,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 61: Implement vote aggregation logic
gh issue create \
  --title "Implement vote aggregation logic" \
  --body "## Description
Build system to aggregate votes and calculate rankings.

## Tasks
- [ ] Calculate total scores
- [ ] Update ranking algorithms
- [ ] Trigger notifications on thresholds
- [ ] Handle vote decay over time
- [ ] Optimize query performance
- [ ] Add caching

## Acceptance Criteria
- Scores calculated correctly
- Rankings update
- Notifications trigger
- Performance good

## Epic
Part of Epic 2.3.3: Community Voting" \
  --label "backend,feature,phase:2,priority:high,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 62: Build voting leaderboard
gh issue create \
  --title "Build voting leaderboard" \
  --body "## Description
Create leaderboard showing top contributors.

## Tasks
- [ ] Build leaderboard UI
- [ ] Show top contributors
- [ ] Display contribution metrics
- [ ] Add time filters (day/week/month)
- [ ] Show user rank
- [ ] Make engaging

## Acceptance Criteria
- Leaderboard displays correctly
- Metrics accurate
- Filters work
- Engaging design

## Epic
Part of Epic 2.3.3: Community Voting" \
  --label "frontend,feature,phase:2,priority:medium,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 63: Build comment system UI
gh issue create \
  --title "Build comment system UI" \
  --body "## Description
Create comment threads on corrections and footnotes.

## Tasks
- [ ] Build comment component
- [ ] Add reply functionality
- [ ] Show nested threads
- [ ] Add edit/delete
- [ ] Show timestamps
- [ ] Make accessible

## Acceptance Criteria
- Comments display
- Replies work
- Threads nested properly
- Accessible

## Epic
Part of Epic 2.3.4: Discussion Threads" \
  --label "frontend,feature,phase:2,priority:medium,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 64: Implement comment API
gh issue create \
  --title "Implement comment API" \
  --body "## Description
Create backend API for commenting.

## Tasks
- [ ] Create POST /api/corrections/:id/comments
- [ ] Create GET /api/corrections/:id/comments
- [ ] Support nested replies
- [ ] Add edit/delete endpoints
- [ ] Validate and sanitize
- [ ] Add rate limiting

## Acceptance Criteria
- Comment API works
- Nesting supported
- XSS prevented
- Rate limiting active

## Epic
Part of Epic 2.3.4: Discussion Threads" \
  --label "backend,api,feature,phase:2,priority:medium,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 65: Implement comment notifications
gh issue create \
  --title "Implement comment notifications" \
  --body "## Description
Send notifications when users receive comments.

## Tasks
- [ ] Implement email notifications
- [ ] Add in-app notifications
- [ ] Allow notification preferences
- [ ] Batch notifications
- [ ] Add unsubscribe option
- [ ] Test delivery

## Acceptance Criteria
- Notifications sent
- Preferences work
- Email deliverable
- In-app updates real-time

## Epic
Part of Epic 2.3.4: Discussion Threads" \
  --label "backend,feature,phase:2,priority:low,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

echo "Phase 2 Sprint 2.3 complete"
echo ""

# Continue with Sprint 2.4...
echo "Creating Phase 2 - Sprint 2.4 issues (User Management)..."

# Issue 66: Integrate OAuth2 providers
gh issue create \
  --title "Integrate OAuth2 providers" \
  --body "## Description
Add OAuth2 authentication for Google and GitHub.

## Tasks
- [ ] Implement Google OAuth
- [ ] Implement GitHub OAuth
- [ ] Handle OAuth callbacks
- [ ] Link to existing accounts
- [ ] Store OAuth tokens
- [ ] Add error handling

## Acceptance Criteria
- Google OAuth works
- GitHub OAuth works
- Account linking functional
- Errors handled gracefully

## Epic
Part of Epic 2.4.1: Authentication

## Dependencies
- Requires #19 (Base authentication)" \
  --label "backend,feature,phase:2,priority:high,size:l" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 67: Build authentication UI
gh issue create \
  --title "Build authentication UI" \
  --body "## Description
Create login, registration, and password reset UI.

## Tasks
- [ ] Build login form
- [ ] Build registration form
- [ ] Build password reset flow
- [ ] Add social login buttons
- [ ] Show validation errors
- [ ] Make accessible

## Acceptance Criteria
- Forms functional
- Validation clear
- Social login works
- Accessible

## Epic
Part of Epic 2.4.1: Authentication" \
  --label "frontend,feature,phase:2,priority:critical,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 68: Implement protected routes
gh issue create \
  --title "Implement protected routes" \
  --body "## Description
Add route guards for authenticated-only pages.

## Tasks
- [ ] Create route guard component
- [ ] Redirect to login when needed
- [ ] Preserve intended destination
- [ ] Handle token expiration
- [ ] Test all protected routes
- [ ] Add loading states

## Acceptance Criteria
- Protected routes secure
- Redirects work
- Token refresh functional
- Good UX

## Epic
Part of Epic 2.4.1: Authentication" \
  --label "frontend,feature,phase:2,priority:high,size:s" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 69: Implement user profile system
gh issue create \
  --title "Implement user profile system" \
  --body "## Description
Build backend for user profiles and settings.

## Tasks
- [ ] Create profile CRUD endpoints
- [ ] Add avatar upload
- [ ] Store user preferences
- [ ] Add bio and links
- [ ] Add privacy settings
- [ ] Validate data

## Acceptance Criteria
- Profile API works
- Avatars uploadable
- Data validated
- Privacy respected

## Epic
Part of Epic 2.4.2: User Profiles & Permissions" \
  --label "backend,feature,phase:2,priority:high,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 70: Build user profile UI
gh issue create \
  --title "Build user profile UI" \
  --body "## Description
Create user profile page and edit interface.

## Tasks
- [ ] Build profile page
- [ ] Build edit profile form
- [ ] Show contribution history
- [ ] Display statistics
- [ ] Add avatar cropping
- [ ] Make responsive

## Acceptance Criteria
- Profile displays nicely
- Edit form works
- History visible
- Responsive

## Epic
Part of Epic 2.4.2: User Profiles & Permissions" \
  --label "frontend,feature,phase:2,priority:high,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 71: Implement role-based access control
gh issue create \
  --title "Implement role-based access control" \
  --body "## Description
Add RBAC system with user, curator, and admin roles.

## Tasks
- [ ] Define role hierarchy
- [ ] Create permission middleware
- [ ] Add role checking utilities
- [ ] Assign default roles
- [ ] Test permissions
- [ ] Document roles

## Acceptance Criteria
- Roles enforced
- Permissions work correctly
- Default assignments work
- Well documented

## Epic
Part of Epic 2.4.2: User Profiles & Permissions" \
  --label "backend,feature,phase:2,priority:critical,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 72: Build curator dashboard
gh issue create \
  --title "Build curator dashboard" \
  --body "## Description
Create dashboard for curators to manage approvals.

## Tasks
- [ ] Build approval queue
- [ ] Add batch operations
- [ ] Show pending items
- [ ] Add filtering/sorting
- [ ] Show item details
- [ ] Make efficient

## Acceptance Criteria
- Dashboard functional
- Queue organized
- Batch operations work
- Efficient workflow

## Epic
Part of Epic 2.4.2: User Profiles & Permissions" \
  --label "frontend,feature,phase:2,priority:high,size:l" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

echo "Phase 2 Sprint 2.4 complete"
echo ""

# Continue with Sprint 2.5...
echo "Creating Phase 2 - Sprint 2.5 issues (Integration & Testing)..."

# Issue 73: Integration testing setup
gh issue create \
  --title "Integration testing setup" \
  --body "## Description
Setup Cypress or Playwright for E2E testing.

## Tasks
- [ ] Install Cypress/Playwright
- [ ] Configure test environment
- [ ] Create test data fixtures
- [ ] Setup test database
- [ ] Add CI integration
- [ ] Document testing patterns

## Acceptance Criteria
- E2E framework ready
- Tests can run
- CI integration works
- Patterns documented

## Epic
Part of Epic 2.5.1: End-to-End Integration" \
  --label "testing,phase:2,priority:critical,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 74: Write E2E tests for correction flow
gh issue create \
  --title "Write E2E tests for correction flow" \
  --body "## Description
Create comprehensive E2E tests for correction submission workflow.

## Tasks
- [ ] Test correction submission
- [ ] Test community voting
- [ ] Test curator approval
- [ ] Test Git commit creation
- [ ] Test error scenarios
- [ ] Verify database state

## Acceptance Criteria
- All flows tested
- Edge cases covered
- Tests reliable
- Good coverage

## Epic
Part of Epic 2.5.1: End-to-End Integration" \
  --label "testing,phase:2,priority:critical,size:l" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 75: Write E2E tests for footnote flow
gh issue create \
  --title "Write E2E tests for footnote flow" \
  --body "## Description
Create E2E tests for footnote workflow.

## Tasks
- [ ] Test footnote submission
- [ ] Test footnote display
- [ ] Test voting
- [ ] Test approval
- [ ] Test Git commits
- [ ] Verify rendering

## Acceptance Criteria
- Footnote flow tested
- Display verified
- Git integration tested
- Coverage complete

## Epic
Part of Epic 2.5.1: End-to-End Integration" \
  --label "testing,phase:2,priority:high,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 76: Write E2E tests for authentication
gh issue create \
  --title "Write E2E tests for authentication" \
  --body "## Description
Test complete authentication flows.

## Tasks
- [ ] Test registration flow
- [ ] Test login/logout
- [ ] Test OAuth flows
- [ ] Test protected routes
- [ ] Test password reset
- [ ] Test token refresh

## Acceptance Criteria
- All auth flows tested
- OAuth tested
- Protected routes verified
- Token handling tested

## Epic
Part of Epic 2.5.1: End-to-End Integration" \
  --label "testing,phase:2,priority:high,size:m" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 77: Performance testing
gh issue create \
  --title "Performance testing" \
  --body "## Description
Conduct load testing and performance optimization.

## Tasks
- [ ] Setup k6 or Artillery
- [ ] Create load test scenarios
- [ ] Test database queries
- [ ] Identify bottlenecks
- [ ] Optimize slow queries
- [ ] Document benchmarks

## Acceptance Criteria
- Load tests run
- Bottlenecks identified
- Key optimizations made
- Performance acceptable

## Epic
Part of Epic 2.5.1: End-to-End Integration" \
  --label "testing,performance,phase:2,priority:medium,size:l" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Issue 78: Fix critical bugs from testing
gh issue create \
  --title "Fix critical bugs from testing" \
  --body "## Description
Address all critical bugs discovered during integration testing.

## Tasks
- [ ] Catalog all critical bugs
- [ ] Prioritize by severity
- [ ] Fix blocking issues
- [ ] Verify fixes with tests
- [ ] Re-test affected flows
- [ ] Document resolutions

## Acceptance Criteria
- All critical bugs fixed
- Tests passing
- No regressions
- Documentation updated

## Epic
Part of Epic 2.5.1: End-to-End Integration" \
  --label "bug,phase:2,priority:critical,size:xl" \
  --milestone "Phase 2: MVP Development" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

echo "Phase 2 Sprint 2.5 complete"
echo "Phase 2 complete: All MVP development issues created"
echo ""

echo "Total issues created so far: $TOTAL_CREATED"
echo ""
echo "Continuing with Phase 3..."

# ==========================================
# PHASE 3 - BETA TESTING
# ==========================================

echo "Creating Phase 3 issues..."

# Sprint 3.1: Beta Launch Prep
gh issue create \
  --title "Setup staging environment" \
  --body "## Description
Create production-like staging environment for beta testing.

## Tasks
- [ ] Configure staging infrastructure
- [ ] Setup auto-deploy from staging branch
- [ ] Configure staging database
- [ ] Add monitoring
- [ ] Test deployment
- [ ] Document access

## Acceptance Criteria
- Staging environment live
- Auto-deploy working
- Monitoring active
- Team can access

## Epic
Part of Epic 3.1.1: Beta Infrastructure" \
  --label "devops,phase:3,priority:critical,size:m" \
  --milestone "Phase 3: Beta Testing" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Implement feature flags" \
  --body "## Description
Add feature flag system for gradual rollout.

## Tasks
- [ ] Select feature flag solution (LaunchDarkly/custom)
- [ ] Implement flag checking
- [ ] Add gradual rollout capability
- [ ] Create admin UI
- [ ] Document usage
- [ ] Test flags

## Acceptance Criteria
- Feature flags functional
- Gradual rollout works
- Admin UI usable
- Well documented

## Epic
Part of Epic 3.1.1: Beta Infrastructure" \
  --label "backend,feature,phase:3,priority:high,size:m" \
  --milestone "Phase 3: Beta Testing" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Setup beta user management" \
  --body "## Description
Implement invite-only beta access system.

## Tasks
- [ ] Create invite system
- [ ] Add beta user tracking
- [ ] Limit access to beta users
- [ ] Generate invite codes
- [ ] Track invitations
- [ ] Monitor usage

## Acceptance Criteria
- Invite system works
- Access restricted
- Tracking functional
- Codes secure

## Epic
Part of Epic 3.1.1: Beta Infrastructure" \
  --label "backend,feature,phase:3,priority:high,size:m" \
  --milestone "Phase 3: Beta Testing" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Create beta invitation system" \
  --body "## Description
Build email invitation system for beta testers.

## Tasks
- [ ] Create email templates
- [ ] Implement invite code generation
- [ ] Build invitation UI
- [ ] Send invitation emails
- [ ] Track invitation status
- [ ] Add reminder emails

## Acceptance Criteria
- Invitations sent
- Codes work
- Status tracked
- Reminders sent

## Epic
Part of Epic 3.1.1: Beta Infrastructure" \
  --label "frontend,feature,phase:3,priority:medium,size:m" \
  --milestone "Phase 3: Beta Testing" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Setup analytics tracking" \
  --body "## Description
Integrate analytics for user behavior tracking.

## Tasks
- [ ] Setup Mixpanel or GA4
- [ ] Define key events
- [ ] Implement event tracking
- [ ] Create dashboards
- [ ] Add user properties
- [ ] Test tracking

## Acceptance Criteria
- Analytics collecting data
- Events tracked
- Dashboards useful
- Privacy compliant

## Epic
Part of Epic 3.1.1: Beta Infrastructure" \
  --label "frontend,feature,phase:3,priority:high,size:m" \
  --milestone "Phase 3: Beta Testing" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Setup user feedback system" \
  --body "## Description
Add in-app feedback widget for beta testers.

## Tasks
- [ ] Integrate feedback widget
- [ ] Configure UserVoice or similar
- [ ] Add feedback categories
- [ ] Test submission
- [ ] Setup notifications
- [ ] Monitor feedback

## Acceptance Criteria
- Widget functional
- Feedback collectable
- Categorization works
- Team notified

## Epic
Part of Epic 3.1.1: Beta Infrastructure" \
  --label "frontend,feature,phase:3,priority:medium,size:m" \
  --milestone "Phase 3: Beta Testing" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Sprint 3.1: Documentation & Onboarding
gh issue create \
  --title "Write user documentation" \
  --body "## Description
Create comprehensive user guides and documentation.

## Tasks
- [ ] Write getting started guide
- [ ] Document correction submission
- [ ] Document footnote creation
- [ ] Explain voting system
- [ ] Create FAQ
- [ ] Add screenshots

## Acceptance Criteria
- Documentation complete
- All features covered
- Clear and concise
- Screenshots helpful

## Epic
Part of Epic 3.1.2: Documentation & Onboarding" \
  --label "documentation,phase:3,priority:high,size:m" \
  --milestone "Phase 3: Beta Testing" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Create video tutorials" \
  --body "## Description
Record video tutorials for key workflows.

## Tasks
- [ ] Script tutorial content
- [ ] Record screen captures
- [ ] Edit videos
- [ ] Add captions
- [ ] Host videos
- [ ] Embed in app

## Acceptance Criteria
- Videos recorded
- Key workflows covered
- Quality good
- Accessible

## Epic
Part of Epic 3.1.2: Documentation & Onboarding" \
  --label "documentation,phase:3,priority:medium,size:m" \
  --milestone "Phase 3: Beta Testing" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Build onboarding flow" \
  --body "## Description
Create interactive onboarding for new users.

## Tasks
- [ ] Design welcome tour
- [ ] Build interactive tutorial
- [ ] Add progress tracking
- [ ] Create tooltips
- [ ] Add skip option
- [ ] Test with users

## Acceptance Criteria
- Tour guides users
- Tutorial interactive
- Progress saved
- Skippable

## Epic
Part of Epic 3.1.2: Documentation & Onboarding" \
  --label "frontend,feature,phase:3,priority:high,size:l" \
  --milestone "Phase 3: Beta Testing" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Create FAQ page" \
  --body "## Description
Build comprehensive FAQ page.

## Tasks
- [ ] Compile common questions
- [ ] Write clear answers
- [ ] Organize by category
- [ ] Add search
- [ ] Link to docs
- [ ] Keep updated

## Acceptance Criteria
- FAQ comprehensive
- Searchable
- Well organized
- Maintained

## Epic
Part of Epic 3.1.2: Documentation & Onboarding" \
  --label "frontend,documentation,phase:3,priority:medium,size:m" \
  --milestone "Phase 3: Beta Testing" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Sprint 3.2: Beta Testing
gh issue create \
  --title "Recruit beta testers" \
  --body "## Description
Recruit 50-100 beta testers from target communities.

## Tasks
- [ ] Identify target communities
- [ ] Create recruitment materials
- [ ] Post to forums/groups
- [ ] Screen applications
- [ ] Send invitations
- [ ] Track responses

## Acceptance Criteria
- 50-100 testers recruited
- Diverse user base
- Engaged participants
- All invited

## Epic
Part of Epic 3.2.1: Beta Testing Coordination" \
  --label "research,phase:3,priority:critical,size:m" \
  --milestone "Phase 3: Beta Testing" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Conduct onboarding sessions" \
  --body "## Description
Run live onboarding sessions for beta testers.

## Tasks
- [ ] Schedule sessions
- [ ] Prepare demo script
- [ ] Conduct live demos
- [ ] Answer questions
- [ ] Record sessions
- [ ] Share recordings

## Acceptance Criteria
- Sessions conducted
- All testers onboarded
- Questions answered
- Recordings available

## Epic
Part of Epic 3.2.1: Beta Testing Coordination" \
  --label "research,phase:3,priority:high,size:m" \
  --milestone "Phase 3: Beta Testing" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Monitor beta usage metrics" \
  --body "## Description
Track and analyze beta user engagement.

## Tasks
- [ ] Monitor daily active users
- [ ] Track correction submission rate
- [ ] Measure feature adoption
- [ ] Identify drop-off points
- [ ] Analyze user paths
- [ ] Create reports

## Acceptance Criteria
- Metrics tracked
- Analysis conducted
- Insights generated
- Reports created

## Epic
Part of Epic 3.2.1: Beta Testing Coordination" \
  --label "research,phase:3,priority:high,size:s" \
  --milestone "Phase 3: Beta Testing" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Collect and prioritize feedback" \
  --body "## Description
Systematically collect and organize beta feedback.

## Tasks
- [ ] Review all feedback
- [ ] Categorize issues
- [ ] Prioritize by severity
- [ ] Create action items
- [ ] Track resolution
- [ ] Communicate back

## Acceptance Criteria
- All feedback reviewed
- Prioritization clear
- Action items created
- Users informed

## Epic
Part of Epic 3.2.1: Beta Testing Coordination" \
  --label "research,phase:3,priority:high,size:s" \
  --milestone "Phase 3: Beta Testing" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Fix high-priority bugs" \
  --body "## Description
Address critical issues found during beta testing.

## Tasks
- [ ] Triage all reported bugs
- [ ] Fix blocking issues
- [ ] Fix data loss issues
- [ ] Fix security issues
- [ ] Test fixes
- [ ] Deploy to beta

## Acceptance Criteria
- All critical bugs fixed
- No data loss
- Security solid
- Beta stable

## Epic
Part of Epic 3.2.2: Bug Fixes & Refinements" \
  --label "bug,phase:3,priority:critical,size:xl" \
  --milestone "Phase 3: Beta Testing" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Fix medium-priority bugs" \
  --body "## Description
Address important but non-critical issues.

## Tasks
- [ ] Review medium priority bugs
- [ ] Fix usability issues
- [ ] Fix UI glitches
- [ ] Fix minor data issues
- [ ] Test thoroughly
- [ ] Deploy fixes

## Acceptance Criteria
- Important bugs fixed
- UX improved
- UI polished
- Quality high

## Epic
Part of Epic 3.2.2: Bug Fixes & Refinements" \
  --label "bug,phase:3,priority:high,size:l" \
  --milestone "Phase 3: Beta Testing" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "UI/UX improvements from feedback" \
  --body "## Description
Improve UI/UX based on beta tester feedback.

## Tasks
- [ ] Review UX feedback
- [ ] Redesign confusing flows
- [ ] Improve navigation
- [ ] Enhance visuals
- [ ] Add polish
- [ ] Test changes

## Acceptance Criteria
- UX significantly improved
- Navigation clearer
- Visual polish added
- Users satisfied

## Epic
Part of Epic 3.2.2: Bug Fixes & Refinements" \
  --label "frontend,ux,phase:3,priority:high,size:l" \
  --milestone "Phase 3: Beta Testing" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Performance optimizations" \
  --body "## Description
Optimize performance based on beta usage patterns.

## Tasks
- [ ] Identify slow queries
- [ ] Optimize database indexes
- [ ] Reduce bundle size
- [ ] Add lazy loading
- [ ] Optimize images
- [ ] Test improvements

## Acceptance Criteria
- Queries faster
- Bundle smaller
- Load times improved
- Smooth experience

## Epic
Part of Epic 3.2.2: Bug Fixes & Refinements" \
  --label "performance,phase:3,priority:medium,size:m" \
  --milestone "Phase 3: Beta Testing" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

# Sprint 3.3: Production Readiness
gh issue create \
  --title "Security audit" \
  --body "## Description
Conduct comprehensive third-party security audit.

## Tasks
- [ ] Hire security firm
- [ ] Provide access
- [ ] Answer questions
- [ ] Review findings
- [ ] Fix vulnerabilities
- [ ] Re-test

## Acceptance Criteria
- Audit completed
- Vulnerabilities fixed
- No critical issues
- Report clean

## Epic
Part of Epic 3.3.1: Production Readiness" \
  --label "security,phase:3,priority:critical,size:l" \
  --milestone "Phase 3: Beta Testing" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Accessibility audit" \
  --body "## Description
Ensure WCAG 2.1 AA compliance.

## Tasks
- [ ] Run automated tests
- [ ] Manual screen reader testing
- [ ] Keyboard navigation testing
- [ ] Color contrast verification
- [ ] Fix accessibility issues
- [ ] Document compliance

## Acceptance Criteria
- WCAG 2.1 AA compliant
- Screen reader works
- Keyboard accessible
- Documented

## Epic
Part of Epic 3.3.1: Production Readiness" \
  --label "accessibility,phase:3,priority:high,size:m" \
  --milestone "Phase 3: Beta Testing" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Database optimization" \
  --body "## Description
Final database performance tuning.

## Tasks
- [ ] Analyze query patterns
- [ ] Optimize indexes
- [ ] Tune PostgreSQL config
- [ ] Add query caching
- [ ] Run vacuum/analyze
- [ ] Benchmark performance

## Acceptance Criteria
- Queries optimized
- Indexes efficient
- Config tuned
- Performance good

## Epic
Part of Epic 3.3.1: Production Readiness" \
  --label "database,performance,phase:3,priority:high,size:m" \
  --milestone "Phase 3: Beta Testing" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Implement rate limiting" \
  --body "## Description
Add comprehensive rate limiting for API protection.

## Tasks
- [ ] Implement API rate limits
- [ ] Add IP-based throttling
- [ ] Configure DDoS protection
- [ ] Add WAF rules
- [ ] Test limits
- [ ] Monitor effectiveness

## Acceptance Criteria
- Rate limiting active
- DDoS protection on
- Abuse prevented
- Legitimate users unaffected

## Epic
Part of Epic 3.3.1: Production Readiness" \
  --label "backend,security,phase:3,priority:high,size:m" \
  --milestone "Phase 3: Beta Testing" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Setup CDN for ePub files" \
  --body "## Description
Optimize ePub file delivery through CDN.

## Tasks
- [ ] Configure CDN for ePubs
- [ ] Set cache policies
- [ ] Test download speeds
- [ ] Monitor CDN usage
- [ ] Optimize costs
- [ ] Document setup

## Acceptance Criteria
- ePubs served via CDN
- Download speeds fast
- Caching effective
- Costs reasonable

## Epic
Part of Epic 3.3.1: Production Readiness" \
  --label "devops,phase:3,priority:medium,size:m" \
  --milestone "Phase 3: Beta Testing" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Implement caching layer" \
  --body "## Description
Add Redis caching for sessions and API responses.

## Tasks
- [ ] Setup Redis
- [ ] Implement session caching
- [ ] Add API response caching
- [ ] Define cache invalidation strategy
- [ ] Monitor cache hit rates
- [ ] Optimize cache usage

## Acceptance Criteria
- Redis operational
- Caching improves performance
- Hit rate >85%
- Invalidation works

## Epic
Part of Epic 3.3.1: Production Readiness" \
  --label "backend,performance,phase:3,priority:high,size:m" \
  --milestone "Phase 3: Beta Testing" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

echo "Phase 3 complete: All beta testing issues created"
echo ""

# ==========================================
# PHASE 4 - PRODUCTION LAUNCH
# ==========================================

echo "Creating Phase 4 issues..."

gh issue create \
  --title "Setup production environment" \
  --body "## Description
Create production infrastructure with high availability.

## Tasks
- [ ] Configure multi-AZ deployment
- [ ] Setup auto-scaling
- [ ] Configure load balancer
- [ ] Setup monitoring
- [ ] Test failover
- [ ] Document architecture

## Acceptance Criteria
- Production environment live
- High availability configured
- Auto-scaling working
- Failover tested

## Epic
Part of Epic 4.1.1: Production Infrastructure" \
  --label "devops,phase:4,priority:critical,size:l" \
  --milestone "Phase 4: Production Launch" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Production database setup" \
  --body "## Description
Setup production PostgreSQL with redundancy.

## Tasks
- [ ] Create multi-AZ PostgreSQL
- [ ] Configure automated backups
- [ ] Setup read replicas
- [ ] Configure monitoring
- [ ] Test backup restore
- [ ] Document procedures

## Acceptance Criteria
- Database highly available
- Backups automatic
- Replicas working
- Recovery tested

## Epic
Part of Epic 4.1.1: Production Infrastructure" \
  --label "devops,database,phase:4,priority:critical,size:m" \
  --milestone "Phase 4: Production Launch" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Setup load balancer" \
  --body "## Description
Configure production load balancer with SSL.

## Tasks
- [ ] Setup AWS ALB or equivalent
- [ ] Configure SSL/TLS certificates
- [ ] Add health checks
- [ ] Configure routing rules
- [ ] Test load distribution
- [ ] Monitor performance

## Acceptance Criteria
- Load balancer operational
- SSL working
- Health checks active
- Traffic distributed

## Epic
Part of Epic 4.1.1: Production Infrastructure" \
  --label "devops,phase:4,priority:critical,size:m" \
  --milestone "Phase 4: Production Launch" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Configure WAF and DDoS protection" \
  --body "## Description
Enable WAF and DDoS protection for production.

## Tasks
- [ ] Configure WAF rules
- [ ] Enable DDoS protection
- [ ] Add rate limiting
- [ ] Setup geo-blocking if needed
- [ ] Test protections
- [ ] Monitor threats

## Acceptance Criteria
- WAF active
- DDoS protection on
- Rules effective
- Threats blocked

## Epic
Part of Epic 4.1.1: Production Infrastructure" \
  --label "devops,security,phase:4,priority:high,size:m" \
  --milestone "Phase 4: Production Launch" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Setup monitoring and alerting" \
  --body "## Description
Configure comprehensive monitoring for production.

## Tasks
- [ ] Setup application monitoring
- [ ] Configure infrastructure monitoring
- [ ] Define alert thresholds
- [ ] Create on-call rotation
- [ ] Test alerting
- [ ] Create dashboards

## Acceptance Criteria
- Full monitoring coverage
- Alerts trigger appropriately
- On-call rotation set
- Dashboards informative

## Epic
Part of Epic 4.1.1: Production Infrastructure" \
  --label "devops,phase:4,priority:critical,size:m" \
  --milestone "Phase 4: Production Launch" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Setup backup and disaster recovery" \
  --body "## Description
Implement backup and DR procedures.

## Tasks
- [ ] Configure automated backups
- [ ] Setup cross-region replication
- [ ] Document recovery procedures
- [ ] Test backup restoration
- [ ] Test DR failover
- [ ] Train team

## Acceptance Criteria
- Backups automatic
- DR plan tested
- Recovery works
- Team trained

## Epic
Part of Epic 4.1.1: Production Infrastructure" \
  --label "devops,phase:4,priority:critical,size:m" \
  --milestone "Phase 4: Production Launch" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Create launch checklist" \
  --body "## Description
Develop comprehensive pre-launch checklist.

## Tasks
- [ ] List all pre-launch checks
- [ ] Define rollback procedures
- [ ] Create communication plan
- [ ] Assign responsibilities
- [ ] Review with team
- [ ] Get sign-off

## Acceptance Criteria
- Checklist complete
- Rollback plan ready
- Team aligned
- Sign-off obtained

## Epic
Part of Epic 4.1.2: Launch Preparation" \
  --label "documentation,phase:4,priority:high,size:s" \
  --milestone "Phase 4: Production Launch" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Prepare marketing materials" \
  --body "## Description
Create all marketing materials for launch.

## Tasks
- [ ] Design landing page
- [ ] Write social media posts
- [ ] Create press release
- [ ] Make demo videos
- [ ] Prepare blog posts
- [ ] Schedule announcements

## Acceptance Criteria
- Landing page live
- Social posts ready
- Press release drafted
- Videos created

## Epic
Part of Epic 4.1.2: Launch Preparation" \
  --label "marketing,phase:4,priority:high,size:m" \
  --milestone "Phase 4: Production Launch" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Setup customer support infrastructure" \
  --body "## Description
Prepare customer support systems and team.

## Tasks
- [ ] Setup help desk (Intercom)
- [ ] Create support documentation
- [ ] Train support team
- [ ] Define SLAs
- [ ] Setup ticket routing
- [ ] Test workflows

## Acceptance Criteria
- Help desk operational
- Team trained
- Documentation ready
- SLAs defined

## Epic
Part of Epic 4.1.2: Launch Preparation" \
  --label "support,phase:4,priority:high,size:m" \
  --milestone "Phase 4: Production Launch" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Setup status page" \
  --body "## Description
Create public status page for system health.

## Tasks
- [ ] Setup Statuspage.io
- [ ] Configure component monitoring
- [ ] Add incident templates
- [ ] Test notifications
- [ ] Link from main site
- [ ] Train team on usage

## Acceptance Criteria
- Status page live
- Components monitored
- Notifications work
- Team knows process

## Epic
Part of Epic 4.1.2: Launch Preparation" \
  --label "devops,phase:4,priority:medium,size:s" \
  --milestone "Phase 4: Production Launch" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Final load testing" \
  --body "## Description
Conduct final stress and load testing before launch.

## Tasks
- [ ] Run stress tests
- [ ] Test capacity limits
- [ ] Simulate traffic spikes
- [ ] Verify auto-scaling
- [ ] Test failover
- [ ] Document results

## Acceptance Criteria
- System handles expected load
- Auto-scaling works
- Failover successful
- Capacity adequate

## Epic
Part of Epic 4.1.2: Launch Preparation" \
  --label "testing,performance,phase:4,priority:critical,size:m" \
  --milestone "Phase 4: Production Launch" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Production deployment" \
  --body "## Description
Execute production deployment.

## Tasks
- [ ] Run pre-launch checklist
- [ ] Deploy to production
- [ ] Run smoke tests
- [ ] Verify all systems
- [ ] Monitor closely
- [ ] Announce launch

## Acceptance Criteria
- Deployment successful
- All systems operational
- Smoke tests pass
- Launch announced

## Epic
Part of Epic 4.1.2: Launch Preparation" \
  --label "devops,phase:4,priority:critical,size:m" \
  --milestone "Phase 4: Production Launch" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Public launch announcement" \
  --body "## Description
Coordinate public launch communications.

## Tasks
- [ ] Publish landing page
- [ ] Send press release
- [ ] Post to social media
- [ ] Email subscribers
- [ ] Post to forums
- [ ] Monitor response

## Acceptance Criteria
- All channels announced
- Press release sent
- Social posts live
- Community notified

## Epic
Part of Epic 4.1.3: Launch & Monitoring" \
  --label "marketing,phase:4,priority:critical,size:s" \
  --milestone "Phase 4: Production Launch" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Monitor launch metrics" \
  --body "## Description
Closely monitor all metrics during launch week.

## Tasks
- [ ] Track user registration
- [ ] Monitor system performance
- [ ] Watch error rates
- [ ] Measure response times
- [ ] Track user engagement
- [ ] Create daily reports

## Acceptance Criteria
- All metrics tracked
- Issues caught early
- Reports generated
- Team informed

## Epic
Part of Epic 4.1.3: Launch & Monitoring" \
  --label "research,phase:4,priority:critical,size:s" \
  --milestone "Phase 4: Production Launch" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Rapid response to issues" \
  --body "## Description
Maintain 24/7 coverage for launch week.

## Tasks
- [ ] Staff on-call rotation
- [ ] Monitor all channels
- [ ] Respond to issues quickly
- [ ] Deploy hot-fixes as needed
- [ ] Communicate status
- [ ] Document incidents

## Acceptance Criteria
- 24/7 coverage maintained
- Issues resolved quickly
- Hot-fixes deployed
- Users informed

## Epic
Part of Epic 4.1.3: Launch & Monitoring" \
  --label "bug,phase:4,priority:critical,size:s" \
  --milestone "Phase 4: Production Launch" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

echo "Phase 4 complete: All production launch issues created"
echo ""

# ==========================================
# PHASE 5 - ONGOING OPERATIONS
# ==========================================

echo "Creating Phase 5 issues..."

gh issue create \
  --title "Regular security updates" \
  --body "## Description
Maintain ongoing security updates and patches.

## Tasks
- [ ] Monitor security advisories
- [ ] Update dependencies regularly
- [ ] Apply security patches
- [ ] Test updates
- [ ] Document changes
- [ ] Schedule maintenance

## Acceptance Criteria
- Updates applied monthly
- No known vulnerabilities
- Changes documented
- Minimal downtime

## Epic
Part of Epic 5.1: Maintenance & Support" \
  --label "security,phase:5,priority:high,size:s" \
  --milestone "Phase 5: Ongoing Operations" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Database maintenance" \
  --body "## Description
Regular database maintenance and optimization.

## Tasks
- [ ] Run vacuum operations
- [ ] Optimize indexes
- [ ] Monitor query performance
- [ ] Archive old data
- [ ] Test backups
- [ ] Review growth

## Acceptance Criteria
- Maintenance scheduled
- Performance maintained
- Backups verified
- Growth managed

## Epic
Part of Epic 5.1: Maintenance & Support" \
  --label "database,phase:5,priority:high,size:s" \
  --milestone "Phase 5: Ongoing Operations" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Performance monitoring and optimization" \
  --body "## Description
Continuous performance monitoring and tuning.

## Tasks
- [ ] Monitor key metrics
- [ ] Identify bottlenecks
- [ ] Optimize as needed
- [ ] Track improvements
- [ ] Update capacity plans
- [ ] Report trends

## Acceptance Criteria
- Performance tracked
- Bottlenecks addressed
- Metrics improving
- Capacity planned

## Epic
Part of Epic 5.1: Maintenance & Support" \
  --label "performance,phase:5,priority:medium,size:s" \
  --milestone "Phase 5: Ongoing Operations" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "User support" \
  --body "## Description
Ongoing user support and issue resolution.

## Tasks
- [ ] Answer user questions
- [ ] Resolve support tickets
- [ ] Update documentation
- [ ] Track common issues
- [ ] Improve self-service
- [ ] Measure satisfaction

## Acceptance Criteria
- Response time <24hrs
- Issues resolved
- Users satisfied
- Docs updated

## Epic
Part of Epic 5.1: Maintenance & Support" \
  --label "support,phase:5,priority:high,size:s" \
  --milestone "Phase 5: Ongoing Operations" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Implement advanced search" \
  --body "## Description
Add advanced full-text search across all ePubs.

## Tasks
- [ ] Implement search engine (Elasticsearch)
- [ ] Index all content
- [ ] Add advanced filters
- [ ] Build search UI
- [ ] Optimize performance
- [ ] Test thoroughly

## Acceptance Criteria
- Advanced search works
- All content searchable
- Filters functional
- Fast results

## Epic
Part of Epic 5.2: Feature Enhancements" \
  --label "feature,phase:5,priority:medium,size:l" \
  --milestone "Phase 5: Ongoing Operations" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Build mobile apps" \
  --body "## Description
Develop native mobile apps for iOS and Android.

## Tasks
- [ ] Setup React Native
- [ ] Build core features
- [ ] Implement offline mode
- [ ] Test on devices
- [ ] Submit to app stores
- [ ] Launch apps

## Acceptance Criteria
- Apps functional
- Feature parity achieved
- Published to stores
- Users satisfied

## Epic
Part of Epic 5.2: Feature Enhancements" \
  --label "feature,mobile,phase:5,priority:medium,size:xl" \
  --milestone "Phase 5: Ongoing Operations" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Implement gamification features" \
  --body "## Description
Add badges, achievements, and contribution streaks.

## Tasks
- [ ] Design badge system
- [ ] Implement achievements
- [ ] Add contribution streaks
- [ ] Build leaderboards
- [ ] Add notifications
- [ ] Test engagement

## Acceptance Criteria
- Gamification engaging
- Badges awarded
- Streaks tracked
- Engagement increased

## Epic
Part of Epic 5.2: Feature Enhancements" \
  --label "feature,phase:5,priority:low,size:m" \
  --milestone "Phase 5: Ongoing Operations" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Add support for additional ePub formats" \
  --body "## Description
Support more ebook formats beyond ePub3.

## Tasks
- [ ] Research format requirements
- [ ] Add ePub2 support
- [ ] Evaluate other formats
- [ ] Implement parsers
- [ ] Test thoroughly
- [ ] Document support

## Acceptance Criteria
- Multiple formats supported
- Conversion works
- Quality maintained
- Documented

## Epic
Part of Epic 5.2: Feature Enhancements" \
  --label "feature,phase:5,priority:medium,size:l" \
  --milestone "Phase 5: Ongoing Operations" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Machine learning for OCR improvement" \
  --body "## Description
Research and implement ML to improve OCR using corrections.

## Tasks
- [ ] Analyze correction patterns
- [ ] Train ML model
- [ ] Validate improvements
- [ ] Integrate into pipeline
- [ ] Monitor quality
- [ ] Document results

## Acceptance Criteria
- ML model trained
- OCR improved
- Quality measurable
- Pipeline integrated

## Epic
Part of Epic 5.2: Feature Enhancements" \
  --label "feature,research,phase:5,priority:low,size:xl" \
  --milestone "Phase 5: Ongoing Operations" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Add support for more public domain works" \
  --body "## Description
Expand platform to support additional public domain texts.

## Tasks
- [ ] Identify requested works
- [ ] Source quality texts
- [ ] Process and upload
- [ ] Create metadata
- [ ] Test platform support
- [ ] Announce availability

## Acceptance Criteria
- Multiple works supported
- Quality maintained
- Metadata complete
- Community engaged

## Epic
Part of Epic 5.3: Scaling & Growth" \
  --label "feature,content,phase:5,priority:medium,size:m" \
  --milestone "Phase 5: Ongoing Operations" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Infrastructure scaling" \
  --body "## Description
Scale infrastructure based on growth.

## Tasks
- [ ] Monitor usage trends
- [ ] Plan capacity increases
- [ ] Implement scaling
- [ ] Optimize costs
- [ ] Test performance
- [ ] Document changes

## Acceptance Criteria
- Infrastructure scales with demand
- Performance maintained
- Costs optimized
- Growth supported

## Epic
Part of Epic 5.3: Scaling & Growth" \
  --label "devops,phase:5,priority:high,size:m" \
  --milestone "Phase 5: Ongoing Operations" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

gh issue create \
  --title "Community moderation tools" \
  --body "## Description
Build advanced moderation tools for community management.

## Tasks
- [ ] Design moderation dashboard
- [ ] Implement spam detection
- [ ] Add user reporting
- [ ] Build review queue
- [ ] Add ban/mute features
- [ ] Document policies

## Acceptance Criteria
- Moderation efficient
- Spam detected
- Community healthy
- Policies clear

## Epic
Part of Epic 5.3: Scaling & Growth" \
  --label "feature,phase:5,priority:medium,size:l" \
  --milestone "Phase 5: Ongoing Operations" \
  --project "Criticalis Development"
((TOTAL_CREATED++))

echo "Phase 5 complete: All ongoing operations issues created"
echo ""

echo "=================================="
echo "ALL ISSUES CREATED!"
echo "=================================="
echo "Total issues created: $TOTAL_CREATED"
echo ""
echo "Summary by Phase:"
echo "- Phase 2 remaining: ~60 issues"
echo "- Phase 3: ~24 issues"
echo "- Phase 4: ~15 issues"
echo "- Phase 5: ~12 issues"
echo ""
echo "Total new issues: ~111"
echo "Previously created: 34"
echo "Grand total: ~145 issues"
echo ""
echo "View all issues: https://github.com/jumson/criticalis/issues"
echo "View project board: https://github.com/users/jumson/projects/3"
