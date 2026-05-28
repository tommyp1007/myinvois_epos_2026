# Copilot Audit & Command Protocol

This file contains the detailed Module Audit Protocol and Command System for structured codebase analysis.
Read this file when `/audit`, `/plan`, `/implement`,
`/debug`, `/refactor`, `/document`, `/test`,
or `/release` commands are used.

---

## Module Audit Protocol

When asked to audit any module (`/audit [module]`), follow this structure exactly.

### Required Outputs

#### 1. Implementation Report

List ALL features related to the module.

For each feature include:

- Feature name
- Status: Implemented | Partial | UI only | Backend only | Not implemented
- Description of actual behavior
- Code references: file names, functions/classes, components

#### 2. Architecture Report

Include:

- **Data Model** — Entities, fields, relationships, constraints
- **Lifecycle / State Behavior** — State transitions, what actually happens in code
- **API / Services / Jobs** — Endpoints, service methods, background jobs
- **UI Components** — Pages, components, interactive vs static
- **Dependencies / Integrations** — External services, shared modules

#### 3. Gap Analysis

Provide a table:

| Feature | Current State | Expected Behavior | Gap | Priority |
|---------|---------------|-------------------|-----|----------|

Be explicit and concrete.

#### 4. Status Document

Create or update: `docs/status/[module-name]-status.md`

Use this template:

```markdown
# [Module Name] Status

## Current State
### Implemented
### Partial
### UI Only
### Backend Only
### Not Implemented

## Data Model
## Lifecycle / State Behavior
## API / Services / Jobs
## UI Components
## Dependencies / Integrations
## Known Issues

## Next Priority Tasks
1.
2.
3.
```

### Simulation Requirement

Simulate the main end-to-end flow of the module. For each step:

- Describe what actually happens
- Identify what works
- Identify what is missing or broken

Do NOT assume behavior.

### Code Verification Rules

For every claim:

- Include code references
- If no reference exists → mark as NOT IMPLEMENTED

Never:

- Infer backend from UI
- Infer UI from schema
- Assume logic exists because fields exist

### Anti-Hallucination

- Do NOT say "done" without listing changed files
- Do NOT claim support without describing actual behavior
- Do NOT fabricate architecture or skip missing pieces

### Codebase Coverage

When analyzing a module, also inspect: shared models, services, state management, validators, permissions, background jobs, integration hooks. Do NOT limit analysis to files with the module name.

---

## Command System

Each command has a defined behavior. When a command is used, follow it strictly. Execute ONE command at a time. If unclear, ask for clarification.

### /audit [module]

Analyze the current state of a module based on actual
code. Follow the Module Audit Protocol above — generate
all required outputs (Implementation report, Architecture
report, Gap analysis, Status document) with code
references for every claim.

### /plan [feature or module]

Design an implementation approach before coding.
Do NOT implement yet.

1. Search codebase for all related code, patterns,
   and dependencies
2. Identify gaps between current state and desired
   outcome
3. Produce a plan with these sections:
   - **Approach** — High-level strategy
   - **Files to modify** — List with expected changes
   - **Data model changes** — Schema/model updates
   - **API changes** — New or modified endpoints
   - **UI changes** — Components affected
   - **Risks** — What could break, edge cases
   - **Open questions** — Anything needing user input
4. Wait for user approval before implementing

### /implement [task]

Implement a clearly defined, scoped change.

1. **Inspect** — Identify current implementation and
   all affected files
2. **Report** — Summarize current state, gaps, and
   planned changes before writing code
3. **Implement** — Only planned changes. No unrelated
   changes.
4. **Verify** — Confirm behavior works, check for
   regressions and type/lint errors
5. **Report completion** — List all changed files,
   explain what was done, highlight limitations

### /debug [issue]

Identify root cause of a problem.

1. Gather context: error messages, stack traces,
   logs, and user-reported symptoms
2. Reproduce or simulate the issue by tracing the
   code path from trigger to failure point
3. Identify the failure layer: UI, backend logic,
   data, external integration, or configuration
4. Pinpoint: root cause, exact file + function +
   line, and why it fails
5. Propose a targeted fix plan — scope it to the
   minimum change that resolves the issue
6. If the fix is straightforward, ask user whether
   to implement immediately

### /refactor [module or code]

Improve structure without changing behavior.

1. Analyze current structure — read all related files
2. Identify: duplication, inconsistencies, excessive
   complexity, unclear naming, tight coupling
3. Propose specific improvements with rationale for
   each change
4. Wait for user approval before making changes
5. Implement refactor — ensure no behavior changes
6. Verify: existing tests still pass, no new errors
7. Report: files changed, what was improved, what
   was left unchanged and why

### /document [module|organize]

Update system documentation to reflect current implementation,
or organize the docs directory.

**Always (both modes):**

1. Maintain `docs/DOCUMENT-INDEX.md` — every doc must be listed
2. Maintain crosslinks — every doc must have a `Related:` header
   linking to related docs
3. Fix any broken references found during the update
4. Do NOT invent features — only document what exists in code

**When a module is specified** (`/document image`,
`/document turn-flow`, etc.):

1. Search all docs for content about the module (grep for
   keywords, check DOCUMENT-INDEX.md)
2. Update each doc that covers the module: architecture,
   status, API reference, schema docs, usage notes
3. Ensure consistency — same facts in all docs that mention
   the module
4. If a status doc exists in `docs/status/`, update it
5. If no status doc exists and the module is complex enough,
   create one using the status template from `/audit`
   (see "Required Outputs > 4. Status Document" above)

**When "organize" is specified** (or no module given):

1. Scan docs/ for content overlap — flag docs with >50%
   shared content
2. Merge overlapping docs (keep the more complete version,
   redirect the other)
3. Archive obsolete docs to `docs/archive/` with a note at
   the top pointing to the replacement or explaining why
4. Verify DOCUMENT-INDEX.md is complete and accurate
5. Remove dead crosslinks, fix broken references
6. Ensure consistent frontmatter (`Related:` links at top)
7. Report: what was merged, archived, or reorganized

### /test [module or scope]

Run tests and validate system behavior for a module
or the full project.

**Automated tests:**

1. Identify test files related to the scope
2. Run the project's test command (e.g. `pnpm test`,
   `npm test`, `pytest`, etc.)
3. Report: passed, failed, skipped counts
4. For failures: identify root cause, file, and line
5. Propose fixes for failing tests if related to
   recent changes

**Behavioral verification** (when no tests exist or
when deeper validation is needed):

1. Trace the main code paths for the feature/module
2. Identify: what works, what fails, edge cases
3. Check data consistency across layers (UI, backend,
   data store)
4. Report gaps: missing validation, unhandled errors,
   broken flows
5. Suggest tests to add for uncovered scenarios

### /release

Prepare code for a release commit.

1. **Determine version bump** — Scan commits since last
   release: `feat:` → MINOR, `fix:` → PATCH, breaking
   changes → MAJOR (semver)
2. **Bump version** — Update version in all package/config
   files (discover with `file_search **/*package.json` or
   equivalent manifest files for the project's language)
3. **Update changelog** — Add entry to changelog with new
   features, bug fixes, breaking changes (create changelog
   if none exists)
4. **Update documentation** — Update any docs affected by
   the changes. Run `/document organize` checks (crosslinks,
   index, broken references)
5. **Add code documentation** — Add/update doc comments on
   new or modified exported symbols (JSDoc, docstrings, etc.
   per language)
6. **Verify build** — Ensure the project compiles/builds
   without errors
7. **Commit** — Use conventional commit format:
   `release: vX.Y.Z`
8. **Push** — Push the release commit to the configured
   remote. If tags are part of the release flow, push the
   release tag as well after the commit succeeds