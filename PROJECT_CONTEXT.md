FocusFlow — Project Context

1. Project Identity

Project Name: FocusFlow

Project Type: AI-powered adaptive study planner and student productivity application.

Primary Platform: Windows Desktop

Future Platforms: Android and iOS

Development Framework: Flutter

Project Status: Foundation / Initial Development

Important: This document is a living project document. Technology choices, architecture details, features, and implementation decisions may be updated as development progresses. Planned technologies are not considered final until they are selected, implemented, and documented.

2. Product Vision

FocusFlow is an AI-powered study and productivity assistant designed for students.

The goal is not simply to generate a timetable.

FocusFlow should help students:

Create personalized study schedules

Manage subjects and activities

Track planned and actual study time

Receive reminders

Complete, skip, or partially complete sessions

Adapt their schedule when circumstances change

Understand their study habits and progress

Interact with the application using natural language and voice

Connect their schedule with external calendars

Synchronize their data across devices in the future

Core Product Principle

AI recommends. The student decides.

AI-generated schedule changes must require user approval before they are applied.

3. Problem Statement

Students often create study timetables that work only under ideal circumstances.

In real life:

A study session may be missed.

A student may become unavailable.

Priorities may change.

A deadline may move closer.

A new subject or task may be added.

A student may have less time than expected.

A planned session may take longer than expected.

Many traditional timetable approaches are designed around fixed schedules and require students to manually adjust their plans when circumstances change.

FocusFlow aims to solve this problem through an adaptive planning system.

4. Target Users

Primary users:

College students

University students

Students preparing for technical interviews

Students preparing for examinations

Students learning multiple technical subjects

Students managing courses and personal projects

Initial personal use cases may include activities such as:

Python

SQL

AI courses

Cybersecurity learning

Projects

DSA

Interview preparation

LinkedIn / career activities

The application must remain customizable rather than hardcoding these activities.

5. Core User Workflow

A typical FocusFlow workflow should eventually look like this:

Student defines goals and activities.

Student specifies available time.

Student creates or generates a schedule.

FocusFlow displays the day's plan.

Student receives reminders.

Student starts a study session.

FocusFlow tracks the session.

Student completes, skips, or partially completes the session.

FocusFlow records the result.

If the schedule changes, FocusFlow can analyze the situation.

AI proposes a possible adjustment.

Student reviews the recommendation.

Student approves, rejects, or edits it.

FocusFlow applies approved changes.

Progress and analytics are updated.

6. Core Features

6.1 Activity Management

Users must be able to:

Create activities

Edit activities

Delete activities

Enable or disable activities

Categorize activities

Set preferred duration

Set priority

Configure reminders

Activities must be dynamic.

The application must never assume a fixed list of subjects.

6.2 Schedule Management

Users must be able to:

Create schedules

Edit schedules

Move sessions

Change duration

Change days

Add new sessions

Remove sessions

View daily schedules

View weekly schedules

Schedules should be editable at any time.

6.3 Study Sessions

Users should be able to:

Start a session

Pause a session

Resume a session

Complete a session

Skip a session

Record partial completion

Add notes

FocusFlow should distinguish between:

Planned time

Actual time

Completed sessions

Missed sessions

Skipped sessions

Partially completed sessions

6.4 Notifications

FocusFlow should provide reliable reminders for scheduled activities.

Notification behavior should eventually support:

Scheduled reminders

Activity name

Start time

Session duration

Optional voice interaction

Notifications should remain useful even when AI services are unavailable.

6.5 Progress and Analytics

FocusFlow should eventually provide:

Daily study time

Weekly study time

Monthly study time

Completion percentage

Subject/activity breakdown

Planned vs actual study time

Study streaks

Missed sessions

Productivity trends

6.6 Gamification

Gamification is planned as a supporting feature rather than the main purpose of FocusFlow.

Potential capabilities include:

Study streaks

Points or experience

Daily goals

Achievement badges

Completion milestones

Weekly challenges

The exact gamification system will be designed and implemented when this feature phase begins.

7. Feature Maturity and Implementation Stages

FocusFlow will be developed incrementally to avoid unnecessary complexity and scope creep.

MVP — Core Application

The first usable version should focus on:

Activity management

Schedule management

Daily/weekly timetable

Study session timer

Session tracking

Local data storage

Basic notifications

Basic progress tracking

The MVP should be useful without AI, n8n, cloud services, or external integrations.

AI / Automation Phase

Later phases may introduce:

AI assistant

Natural language interaction

Adaptive scheduling

AI-generated recommendations

n8n automation

User approval workflow

Advanced Phase

Later development may include:

Voice interaction

Google Calendar integration

Advanced analytics

Gamification

Cloud synchronization

Cross-device synchronization

Other integrations discovered to be useful during development

These stages describe the current product direction. The exact order may change based on technical findings and implementation experience.

8. AI Capabilities

AI is a major component of FocusFlow but should not control the application directly.

Potential AI capabilities include:

Natural Language Interaction

Examples:

"What do I have today?"

"I missed my Python session."

"Move Python to 4 PM."

"I only have three hours today."

"How much did I study this week?"

Adaptive Scheduling

When a student misses a session or their available time changes, AI may analyze:

Remaining available time

Activity priority

Deadlines

Previous progress

Missed sessions

Planned duration

Existing schedule conflicts

The AI should then produce a structured recommendation.

Example:

Python session missed.

Suggested change:

Move Python from 2:00 PM to 4:00 PM.

Reason:

The session was missed and 90 minutes remain available today.

Requires approval:

Yes

The exact AI model, provider, API, and orchestration approach will be selected during implementation and may change later.

9. AI Safety and Control Principle

The AI must not have unrestricted authority over user data or schedules.

Preferred flow:

User/Event
    ↓
FocusFlow
    ↓
AI analysis
    ↓
Structured recommendation
    ↓
Application validation
    ↓
User approval
    ↓
Schedule update

AI recommendations should be treated as proposals.

The application remains responsible for validating and applying changes.

10. Automation

FocusFlow may use an automation/orchestration platform such as n8n in a later phase.

Potential responsibilities include:

AI workflow orchestration

External API calls

Scheduled automation

Progress reports

AI planning workflows

Calendar-related workflows

Future integrations

n8n should not become the core database or primary alarm system.

Core application functionality should remain independent of external automation services wherever practical.

The exact automation architecture is not finalized and will be documented when implemented.

11. Voice

Voice interaction is a planned feature.

Potential voice capabilities:

Voice commands

Speech-to-text

Text-to-speech

Spoken schedule information

Voice-based activity changes

Voice-based session actions

Examples:

"What is my next session?"

"Move SQL to 5 PM."

"Start my Python session."

Voice should complement normal UI and notifications rather than being the only way to interact with the application.

The exact speech-to-text, text-to-speech, and voice technologies are not finalized.

12. Google Calendar Integration

Google Calendar integration is planned for a later phase.

Potential functionality:

Read calendar availability

Detect schedule conflicts

Consider calendar events when planning

Potentially create approved study sessions in the calendar

Calendar integration must respect user authorization and privacy.

The exact integration approach will be selected when this phase begins.

13. Cloud Synchronization

Cloud synchronization is planned for a later phase.

The long-term goal is to allow users to access their FocusFlow data across:

Windows

Android

iOS

The exact backend, database, authentication system, hosting platform, and cloud provider will be selected when this phase begins.

No backend or cloud technology should be treated as finalized until it has been selected, implemented, tested, and documented.

14. Local-First Principle

FocusFlow should initially prioritize local functionality.

Core functionality should work without an internet connection where practical.

The application should not depend on AI or cloud services for:

Basic schedule viewing

Basic schedule editing

Session tracking

Basic notifications

Local progress tracking

AI and external services should enhance the application rather than make its basic functionality unusable.

15. Planned Technology Stack

This section describes the current direction, not permanent technology decisions.

Frontend

Current choice:

Flutter

Dart

Initial target:

Windows Desktop

Future targets:

Android

iOS

Local Storage

Current direction:

A Flutter-compatible local database, likely SQLite or another appropriate solution.

The exact database/package will be selected during the storage implementation phase based on requirements such as reliability, maintainability, offline support, and future platform compatibility.

Backend

A backend may be introduced when required for:

AI services

Authentication

Cloud synchronization

External integrations

Other server-side functionality

Status: Not finalized.

The backend technology will be selected based on actual project requirements rather than being chosen prematurely.

AI

Potential components may include:

LLM APIs

OpenRouter

Structured AI outputs

n8n or another orchestration approach

Status: Not finalized.

The exact model, provider, API, and AI architecture may change during development.

Automation

Potential option:

n8n

Status: Planned / under evaluation until implemented.

External Integrations

Potential integrations include:

Google Calendar

AI/LLM APIs

Notification services where required

Other services added only when they provide a clear product benefit

Status: Planned, not finalized.

Technology Decision Rule: Future tools and technologies will be added to this document when the corresponding feature is actually designed. Each significant technology decision should record what was selected, why it was selected, alternatives considered when relevant, and any platform implications.

16. Architecture Principles

FocusFlow should follow these principles:

Keep the application modular.

Avoid unnecessary dependencies.

Separate UI from business logic.

Separate business logic from data storage.

Keep AI logic isolated from core scheduling logic.

Validate AI-generated recommendations.

Require user approval for AI schedule changes.

Preserve future Android/iOS compatibility.

Prefer maintainable solutions over unnecessarily complex solutions.

Do not hardcode user-specific schedules.

Avoid unnecessary rewrites.

Do not modify unrelated files when implementing features.

Keep core functionality usable without optional external services.

The detailed architecture will be maintained separately in ARCHITECTURE.md and updated as implementation decisions are made.

17. Product Non-Goals

FocusFlow is not intended to:

Automatically control a student's entire life

Automatically modify schedules without user approval

Replace teachers, mentors, or academic advisors

Require AI for basic timetable functionality

Force a single study methodology on every user

Store unnecessary personal information

Become a generic AI chatbot unrelated to study planning

Add technology or integrations simply because they are available

Features should support the central product problem rather than increase complexity without a clear user benefit.

18. Development Environment

Current development environment:

Operating System: Windows 11

Flutter: 3.32.5

Dart: 3.8.1

Android SDK: 36.0.0

Android Studio: 2025.1.1

Git: 2.46.0.windows.1

Node.js: 20.19.4

npm: 11.6.3

VS Code

Visual Studio Build Tools 2019

Current available Flutter development targets:

Windows Desktop

Chrome

Edge

Primary development target:

Windows Desktop

19. Current Project Status

Completed

Flutter project created

Windows desktop target configured

Android development environment configured

Visual Studio C++ build requirements configured

Flutter doctor verified

Project successfully launches on Windows

Git repository initialized

Main branch created

Initial project committed

Initial Git commit:

0905676 chore: initialize FocusFlow Flutter project

The default Flutter counter application is still present and will be replaced as the application shell is implemented.

20. Current Development Phase

Current phase:

Phase 0 — Project Foundation

Current objectives:

Complete project documentation

Define architecture

Define development roadmap

Replace default Flutter counter application

Build FocusFlow application shell

Implement core activity management

Implement schedule management

Implement session tracking

Implement notifications

Implement analytics

Introduce automation

Introduce AI

Introduce adaptive scheduling

Introduce voice

Introduce calendar integration

Introduce cloud synchronization

Add gamification

Testing and deployment

The objectives are intentionally high-level. Detailed implementation tasks will be maintained in DEVELOPMENT_PLAN.md.

21. Development Rules for AI Coding Assistants

Any AI coding assistant working on FocusFlow must follow these rules.

Rule 1 — Understand Before Changing

Read the relevant project documentation and existing implementation before modifying code.

Rule 2 — No Unnecessary Rewrites

Do not rewrite working code unless there is a clear technical reason.

Rule 3 — Explain Dependencies

Do not introduce a new dependency without explaining:

What it does

Why it is needed

What alternatives were considered

Whether it affects future platforms

Rule 4 — Protect Architecture

Do not introduce architectural changes casually.

Rule 5 — Modify Only What Is Necessary

Avoid unrelated file changes.

Rule 6 — Preserve Cross-Platform Compatibility

Future Android and iOS support must be considered when implementing application logic.

Rule 7 — No Hardcoded User Data

Subjects, activities, schedules, priorities, and user preferences must come from user-controlled data.

Rule 8 — AI Cannot Directly Control the Schedule

AI recommendations must go through application validation and user approval.

Rule 9 — Test Before Claiming Success

Do not claim that functionality works unless it has been tested.

Rule 10 — Document Important Decisions

Major architectural and technology decisions should be documented.

Rule 11 — Keep Git History Meaningful

Use focused commits describing meaningful changes.

Rule 12 — Teach the Developer

Important implementation decisions should be explained so the project owner understands the code and can explain it during technical interviews.

22. Git Strategy

Development should use small, meaningful commits.

Examples:

chore: initialize FocusFlow Flutter project

docs: add project foundation

docs: define application architecture

feat: add application shell

feat: add activity management

feat: add schedule management

feat: add study session tracking

feat: add local notifications

feat: add progress analytics

feat: add AI assistant

feat: add adaptive scheduling

feat: add voice interaction

feat: add Google Calendar integration

feat: add cloud synchronization

feat: add gamification

test: add schedule service tests

fix: resolve notification scheduling issue

Commit examples are guides, not mandatory names. Actual commits should describe the change that was really made.

23. Important Product Principle

FocusFlow should not become a collection of disconnected AI features.

Every feature should contribute to the central problem:

Helping students create, follow, understand, and adapt their study routine.

The product should remain useful even without AI.

AI should make the existing productivity system smarter.

24. Project Documentation and Decision Tracking

FocusFlow uses documentation as a source of truth, but the documentation is expected to evolve.

Important documents:

PROJECT_CONTEXT.md — product vision, scope, principles, current technology direction, and project context

ARCHITECTURE.md — implemented and planned architecture

DEVELOPMENT_PLAN.md — development phases and implementation tasks

When an important decision is made during development:

Discuss the requirement.

Evaluate appropriate technical options.

Select the approach.

Implement it.

Test it.

Document the final decision.

Update affected project documentation.

Do not treat an unimplemented idea as an implemented feature.

25. Project Goal

The final project should demonstrate practical experience with:

Flutter

Dart

Desktop application development

Mobile application architecture

Local databases

APIs

AI/LLM integration

Automation/orchestration

Natural language interfaces

Voice interaction

Scheduling systems

Notifications

Analytics

Calendar integration

Cloud synchronization

Gamification

Git/GitHub

Testing

Software architecture

The project should be understandable, maintainable, testable, and suitable for demonstrating during technical interviews.

Final principle: Build the simplest reliable version first, validate it, then add complexity only when the next feature requires it.