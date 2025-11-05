#!/bin/bash
# Script to create GitHub issues for Criticalis project

# Phase 1 Issues - Epic 1.1: Technical Architecture & Design

echo "Creating Phase 1 issues..."

# Issue 1
gh issue create \
  --title "Research ePub libraries and select primary candidate" \
  --body "## Description
Evaluate and select the best ePub library for the project.

## Tasks
- [ ] Evaluate epub.js library
- [ ] Evaluate Readium projects
- [ ] Evaluate epub-parser
- [ ] Document pros/cons of each
- [ ] Test basic ePub rendering
- [ ] Make recommendation with justification

## Acceptance Criteria
- Comprehensive comparison document created
- Recommendation documented with rationale
- Basic proof-of-concept created with selected library

## Epic
Part of Epic 1.1: Technical Architecture & Design" \
  --label "research,phase:1,priority:critical,size:m" \
  --milestone "Phase 1: Planning & Design" \
  --project "Criticalis Development"

# Issue 2
gh issue create \
  --title "Research Git integration libraries" \
  --body "## Description
Evaluate Git libraries for backend integration to manage text versioning.

## Tasks
- [ ] Evaluate NodeGit library
- [ ] Evaluate simple-git library
- [ ] Evaluate Octokit (GitHub REST API client)
- [ ] Test basic operations (clone, commit, push, PR creation)
- [ ] Document API capabilities and limitations
- [ ] Test performance with large repositories

## Acceptance Criteria
- Comparison matrix created for all libraries
- Performance benchmarks documented
- Recommendation made with justification
- Sample code created demonstrating key operations

## Epic
Part of Epic 1.1: Technical Architecture & Design" \
  --label "research,backend,phase:1,priority:high,size:m" \
  --milestone "Phase 1: Planning & Design" \
  --project "Criticalis Development"

# Issue 3
gh issue create \
  --title "Research annotation frameworks" \
  --body "## Description
Evaluate annotation frameworks and approaches for text selection and commenting.

## Tasks
- [ ] Evaluate Hypothesis framework
- [ ] Research custom solution approaches
- [ ] Test word-level selection in ePub context
- [ ] Document integration complexity
- [ ] Evaluate browser compatibility
- [ ] Test mobile touch selection

## Acceptance Criteria
- Framework comparison documented
- Integration complexity assessed
- Recommendation made
- Proof-of-concept created

## Epic
Part of Epic 1.1: Technical Architecture & Design" \
  --label "research,frontend,phase:1,priority:high,size:s" \
  --milestone "Phase 1: Planning & Design" \
  --project "Criticalis Development"

# Issue 4
gh issue create \
  --title "Design database schema" \
  --body "## Description
Design complete database schema for the platform.

## Tasks
- [ ] Design users table and authentication
- [ ] Design ePub metadata tables
- [ ] Design annotations and corrections tables
- [ ] Design voting and community features tables
- [ ] Design comments and discussion tables
- [ ] Create ER diagram
- [ ] Define indexes for performance
- [ ] Plan migration strategy

## Acceptance Criteria
- Complete database schema documented
- ER diagram created
- Indexes defined
- Migration strategy planned
- Schema reviewed for normalization

## Epic
Part of Epic 1.1: Technical Architecture & Design" \
  --label "design,database,phase:1,priority:critical,size:m" \
  --milestone "Phase 1: Planning & Design" \
  --project "Criticalis Development"

# Issue 5
gh issue create \
  --title "Design system architecture diagram" \
  --body "## Description
Create comprehensive system architecture diagram showing all components and data flow.

## Tasks
- [ ] Design frontend architecture
- [ ] Design backend architecture
- [ ] Design database layer
- [ ] Design Git integration layer
- [ ] Define API boundaries
- [ ] Document data flow for key operations
- [ ] Define caching strategy
- [ ] Document security boundaries

## Acceptance Criteria
- Complete architecture diagram created
- Component responsibilities documented
- Data flow diagrams for key operations
- API boundaries clearly defined
- Caching strategy documented

## Epic
Part of Epic 1.1: Technical Architecture & Design" \
  --label "design,phase:1,priority:critical,size:l" \
  --milestone "Phase 1: Planning & Design" \
  --project "Criticalis Development"

# Issue 6
gh issue create \
  --title "Define API contract (OpenAPI/Swagger)" \
  --body "## Description
Create complete API specification using OpenAPI/Swagger format.

## Tasks
- [ ] Define REST endpoints for all operations
- [ ] Define request/response schemas
- [ ] Define authentication flows
- [ ] Define WebSocket events for real-time updates
- [ ] Document error responses
- [ ] Define rate limiting policies
- [ ] Create OpenAPI YAML file

## Acceptance Criteria
- Complete OpenAPI 3.0 specification
- All endpoints documented
- Authentication flows specified
- WebSocket events defined
- Specification validates with tools

## Epic
Part of Epic 1.1: Technical Architecture & Design" \
  --label "design,api,phase:1,priority:high,size:l" \
  --milestone "Phase 1: Planning & Design" \
  --project "Criticalis Development"

# Issue 7
gh issue create \
  --title "Infrastructure architecture design" \
  --body "## Description
Design cloud infrastructure architecture and deployment strategy.

## Tasks
- [ ] Evaluate cloud providers (AWS/GCP/Azure)
- [ ] Design VPC and networking
- [ ] Define compute requirements
- [ ] Design database infrastructure
- [ ] Design storage strategy (S3/object storage)
- [ ] Design CI/CD pipeline
- [ ] Design monitoring and logging strategy
- [ ] Document cost projections

## Acceptance Criteria
- Infrastructure diagram created
- Cloud provider selected with justification
- Cost projections documented
- CI/CD pipeline designed
- Monitoring strategy defined

## Epic
Part of Epic 1.1: Technical Architecture & Design

## References
- See COST_BREAKDOWN.md for infrastructure cost estimates" \
  --label "design,devops,phase:1,priority:high,size:m" \
  --milestone "Phase 1: Planning & Design" \
  --project "Criticalis Development"

# Issue 8
gh issue create \
  --title "Security architecture review" \
  --body "## Description
Comprehensive security architecture planning and threat modeling.

## Tasks
- [ ] Design authentication/authorization strategy
- [ ] Plan XSS prevention measures
- [ ] Plan CSRF protection
- [ ] Plan SQL injection prevention
- [ ] Design rate limiting and DDoS protection
- [ ] Plan data encryption strategy
- [ ] Document security best practices
- [ ] Create threat model

## Acceptance Criteria
- Security architecture documented
- Threat model created
- OWASP Top 10 mitigations planned
- Authentication strategy defined
- Security checklist created

## Epic
Part of Epic 1.1: Technical Architecture & Design" \
  --label "security,design,phase:1,priority:critical,size:m" \
  --milestone "Phase 1: Planning & Design" \
  --project "Criticalis Development"

echo "Phase 1 - Epic 1.1 issues created!"

# Issue 9
gh issue create \
  --title "Create user personas and journey maps" \
  --body "## Description
Develop detailed user personas and journey maps for key user types.

## Tasks
- [ ] Create scholar persona
- [ ] Create casual reader persona
- [ ] Create curator persona
- [ ] Map correction submission journey
- [ ] Map annotation creation journey
- [ ] Map voting and community interaction journey
- [ ] Map curator approval workflow
- [ ] Identify pain points and opportunities

## Acceptance Criteria
- 3 detailed personas created
- Journey maps for key workflows
- Pain points documented
- Opportunities identified

## Epic
Part of Epic 1.2: UX/UI Design" \
  --label "design,ux,phase:1,priority:high,size:m" \
  --milestone "Phase 1: Planning & Design" \
  --project "Criticalis Development"

# Issue 10
gh issue create \
  --title "Design wireframes for ePub reader interface" \
  --body "## Description
Create wireframes for the ePub reader interface.

## Tasks
- [ ] Design reading view layout
- [ ] Design annotation overlay UI
- [ ] Design text selection interface
- [ ] Design navigation and table of contents
- [ ] Design font and theme controls
- [ ] Design bookmark interface
- [ ] Create mobile responsive versions
- [ ] Conduct internal review

## Acceptance Criteria
- Complete wireframes for reader interface
- Desktop and mobile versions
- All key features included
- Internal stakeholder approval

## Epic
Part of Epic 1.2: UX/UI Design" \
  --label "design,ui,frontend,phase:1,priority:critical,size:l" \
  --milestone "Phase 1: Planning & Design" \
  --project "Criticalis Development"

# Issue 11
gh issue create \
  --title "Design wireframes for annotation workflow" \
  --body "## Description
Design the complete annotation and correction workflow UI.

## Tasks
- [ ] Design propose correction modal
- [ ] Design add footnote interface
- [ ] Design view suggestions panel
- [ ] Design voting UI components
- [ ] Design comment threads interface
- [ ] Design rich text editor for footnotes
- [ ] Design preview mode
- [ ] Create mobile versions

## Acceptance Criteria
- Complete annotation workflow wireframes
- Correction and footnote interfaces designed
- Voting and commenting UI designed
- Mobile versions included

## Epic
Part of Epic 1.2: UX/UI Design" \
  --label "design,ui,frontend,phase:1,priority:critical,size:l" \
  --milestone "Phase 1: Planning & Design" \
  --project "Criticalis Development"

# Issue 12
gh issue create \
  --title "Design wireframes for community features" \
  --body "## Description
Design community interaction features including profiles and leaderboards.

## Tasks
- [ ] Design user profile page
- [ ] Design contribution history view
- [ ] Design leaderboards
- [ ] Design gamification elements
- [ ] Design discussion threads
- [ ] Design notification center
- [ ] Create mobile versions

## Acceptance Criteria
- Community features wireframed
- Profile and history views designed
- Leaderboard design completed
- Gamification elements defined

## Epic
Part of Epic 1.2: UX/UI Design" \
  --label "design,ui,frontend,phase:1,priority:high,size:m" \
  --milestone "Phase 1: Planning & Design" \
  --project "Criticalis Development"

# Issue 13
gh issue create \
  --title "Design wireframes for curator dashboard" \
  --body "## Description
Design the curator dashboard for managing approvals and moderation.

## Tasks
- [ ] Design approval queue interface
- [ ] Design batch operations UI
- [ ] Design controversial changes review
- [ ] Design curator analytics
- [ ] Design moderation tools
- [ ] Design bulk approval workflow
- [ ] Create responsive versions

## Acceptance Criteria
- Curator dashboard wireframed
- Approval queue designed
- Batch operations UI created
- Analytics view included

## Epic
Part of Epic 1.2: UX/UI Design" \
  --label "design,ui,frontend,phase:1,priority:high,size:m" \
  --milestone "Phase 1: Planning & Design" \
  --project "Criticalis Development"

# Issue 14
gh issue create \
  --title "Create high-fidelity mockups" \
  --body "## Description
Create polished, high-fidelity mockups based on approved wireframes.

## Tasks
- [ ] Define color scheme
- [ ] Select typography
- [ ] Create component library
- [ ] Design all key screens
- [ ] Create responsive designs (mobile/tablet/desktop)
- [ ] Design dark mode variant
- [ ] Ensure accessibility standards
- [ ] Create design system documentation

## Acceptance Criteria
- Complete high-fidelity mockups
- Color scheme and typography defined
- Component library created
- Responsive designs for all screens
- Design system documented

## Epic
Part of Epic 1.2: UX/UI Design" \
  --label "design,ui,phase:1,priority:high,size:l" \
  --milestone "Phase 1: Planning & Design" \
  --project "Criticalis Development"

# Issue 15
gh issue create \
  --title "Create interactive prototype in Figma" \
  --body "## Description
Build clickable interactive prototype for user testing.

## Tasks
- [ ] Import high-fidelity mockups to Figma
- [ ] Add interactions and transitions
- [ ] Link all screens and flows
- [ ] Add transition animations
- [ ] Test prototype flow
- [ ] Prepare for user testing
- [ ] Document prototype navigation

## Acceptance Criteria
- Interactive Figma prototype created
- All key flows working
- Transitions and animations added
- Ready for user testing

## Epic
Part of Epic 1.2: UX/UI Design" \
  --label "design,ui,phase:1,priority:medium,size:m" \
  --milestone "Phase 1: Planning & Design" \
  --project "Criticalis Development"

# Issue 16
gh issue create \
  --title "Conduct user testing on prototype" \
  --body "## Description
Recruit users and conduct moderated testing sessions on interactive prototype.

## Tasks
- [ ] Recruit 5-10 test users
- [ ] Prepare test script
- [ ] Conduct moderated testing sessions
- [ ] Record observations and feedback
- [ ] Analyze findings
- [ ] Document insights and recommendations
- [ ] Iterate on design based on feedback

## Acceptance Criteria
- 5-10 users tested
- Testing sessions recorded
- Findings documented
- Design recommendations created
- Stakeholder review completed

## Epic
Part of Epic 1.2: UX/UI Design" \
  --label "research,ux,phase:1,priority:medium,size:l" \
  --milestone "Phase 1: Planning & Design" \
  --project "Criticalis Development"

echo "Phase 1 - Epic 1.2 issues created!"

# Continue with remaining Phase 1 issues...
# Issue 17-24 (Epic 1.3 and 1.4)

gh issue create \
  --title "Write technical specification document" \
  --body "## Description
Create comprehensive technical specification document for the platform.

## Tasks
- [ ] Document technology stack decisions
- [ ] Document architecture details
- [ ] Include API specifications
- [ ] Document database schema
- [ ] Document security measures
- [ ] Document deployment strategy
- [ ] Include diagrams and visualizations
- [ ] Review with technical team

## Acceptance Criteria
- Complete technical specification
- All major decisions documented
- Architecture documented
- Team review completed

## Epic
Part of Epic 1.3: Project Documentation" \
  --label "documentation,phase:1,priority:high,size:l" \
  --milestone "Phase 1: Planning & Design" \
  --project "Criticalis Development"

gh issue create \
  --title "Write product requirements document (PRD)" \
  --body "## Description
Create detailed product requirements document.

## Tasks
- [ ] Document feature list and priorities
- [ ] Define success metrics and KPIs
- [ ] Write user stories for all features
- [ ] Define MVP scope
- [ ] Document non-functional requirements
- [ ] Create product roadmap
- [ ] Get stakeholder approval

## Acceptance Criteria
- Complete PRD document
- Feature priorities defined
- Success metrics documented
- User stories written
- Stakeholder approval obtained

## Epic
Part of Epic 1.3: Project Documentation" \
  --label "documentation,phase:1,priority:high,size:m" \
  --milestone "Phase 1: Planning & Design" \
  --project "Criticalis Development"

gh issue create \
  --title "Document development workflows" \
  --body "## Description
Document all development workflows and processes.

## Tasks
- [ ] Document Git workflow and branching strategy
- [ ] Document code review process
- [ ] Document testing requirements
- [ ] Document deployment process
- [ ] Create contribution guidelines
- [ ] Document issue/PR templates

## Acceptance Criteria
- Development workflows documented
- Git workflow defined
- Code review process documented
- Contribution guidelines created

## Epic
Part of Epic 1.3: Project Documentation" \
  --label "documentation,phase:1,priority:medium,size:s" \
  --milestone "Phase 1: Planning & Design" \
  --project "Criticalis Development"

gh issue create \
  --title "Create project wiki structure" \
  --body "## Description
Setup and organize project wiki with essential documentation.

## Tasks
- [ ] Create wiki structure
- [ ] Write setup instructions
- [ ] Write contribution guidelines
- [ ] Create FAQ section
- [ ] Document architecture overview
- [ ] Add troubleshooting guides

## Acceptance Criteria
- Wiki structure created
- Essential documentation added
- Navigation clear and logical
- Documentation reviewed

## Epic
Part of Epic 1.3: Project Documentation" \
  --label "documentation,phase:1,priority:medium,size:s" \
  --milestone "Phase 1: Planning & Design" \
  --project "Criticalis Development"

gh issue create \
  --title "Legal review of public domain usage" \
  --body "## Description
Confirm legal status and requirements for using public domain texts.

## Tasks
- [ ] Confirm Treasury of David public domain status
- [ ] Research copyright requirements
- [ ] Document attribution requirements
- [ ] Review similar projects
- [ ] Consult with legal advisor
- [ ] Document findings

## Acceptance Criteria
- Public domain status confirmed
- Legal requirements documented
- Attribution requirements clear
- Legal advisor consulted

## Epic
Part of Epic 1.4: Legal & Compliance" \
  --label "legal,phase:1,priority:high,size:xs" \
  --milestone "Phase 1: Planning & Design" \
  --project "Criticalis Development"

gh issue create \
  --title "Draft Terms of Service" \
  --body "## Description
Draft comprehensive Terms of Service for the platform.

## Tasks
- [ ] Research similar platform ToS
- [ ] Define user content licensing (CC BY-SA?)
- [ ] Include liability disclaimers
- [ ] Address user conduct policies
- [ ] Review with legal advisor
- [ ] Finalize and format

## Acceptance Criteria
- Complete Terms of Service drafted
- Content licensing defined
- Legal review completed
- Ready for publication

## Epic
Part of Epic 1.4: Legal & Compliance" \
  --label "legal,phase:1,priority:high,size:s" \
  --milestone "Phase 1: Planning & Design" \
  --project "Criticalis Development"

gh issue create \
  --title "Draft Privacy Policy" \
  --body "## Description
Create GDPR-compliant Privacy Policy.

## Tasks
- [ ] Document data collection practices
- [ ] Document data usage policies
- [ ] Include GDPR compliance measures
- [ ] Address cookie policies
- [ ] Include data deletion procedures
- [ ] Review with legal advisor
- [ ] Finalize and format

## Acceptance Criteria
- Complete Privacy Policy drafted
- GDPR compliance addressed
- Legal review completed
- Ready for publication

## Epic
Part of Epic 1.4: Legal & Compliance" \
  --label "legal,phase:1,priority:high,size:s" \
  --milestone "Phase 1: Planning & Design" \
  --project "Criticalis Development"

gh issue create \
  --title "Review accessibility compliance (WCAG)" \
  --body "## Description
Review and plan for WCAG 2.1 AA accessibility compliance.

## Tasks
- [ ] Document WCAG 2.1 AA requirements
- [ ] Review design mockups for compliance
- [ ] Create accessibility testing strategy
- [ ] Document accessibility standards
- [ ] Plan accessibility features
- [ ] Create accessibility checklist

## Acceptance Criteria
- WCAG requirements documented
- Design reviewed for compliance
- Testing strategy created
- Accessibility checklist ready

## Epic
Part of Epic 1.4: Legal & Compliance" \
  --label "accessibility,phase:1,priority:medium,size:m" \
  --milestone "Phase 1: Planning & Design" \
  --project "Criticalis Development"

echo "All Phase 1 issues created successfully!"
echo ""
echo "Summary:"
echo "- 24 issues created for Phase 1: Planning & Design"
echo "- Organized into 4 epics"
echo "- All issues assigned to milestone and project"
echo ""
echo "Next steps: Create Phase 2 issues (70 issues)"
