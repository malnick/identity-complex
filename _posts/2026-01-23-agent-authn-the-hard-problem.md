---
layout: post
title: "The Hard Problems with Agent Auth"
date: 2026-01-23
categories: [ai-security, identity]
author: Jeff Malnick
---
Most agent architectures today rely on authorization to let agents access applications on a human's behalf. This works because OAuth gives us a familiar, just-in-time browser flow where a human can make an explicit decision. It is a pragmatic choice. But as agents become more autonomous and less predictable, the lack of authentication for agents becomes the limiting factor in how secure modern systems can be.

Software agents are not new: we've been building autonomous agents for a long time now. AI agents are different because the logic that controls how an AI agent behaves is non-deterministic, and is typically an extension of human action. Chat interfaces paired with decision-making powerful enough to act on our behalf shift these systems closer to human actors than to structured programs with deterministic outputs. Delegation is a natural approach to first-line security.

You can see this most clearly in the security mechanisms we have built to control agents. MCP servers ship with OAuth as the primary layer for humans to authorize agents to access systems on their behalf. This choice is natural both structurally and as a user interface. The browser-based consent flow is something we already understand, and it gives humans a clear moment in the loop to approve access to confidential data or services.

But authorization is designed to connect one application to another within strictly defined scopes. Authorization solves a usability problem around human-mediated trust between deterministic systems. Instead of manually configuring trust between Calendly and Google Calendar, OAuth authorization allows Calendly to ask Google for access, prompts the user to approve a set of scopes, and, with a single click, establishes trust on both sides. It is elegant when you consider the alternatives that came before it.

This flow assumes a lot about the systems involved:
- Authorized client behavior is stable and constrained by predictable software
- Human consent is a reasonable proxy for future behavior, and approval implies long-term trust
- Scopes granted adequately match the intent of the authorized client
- Required capabilities are static, and do not evolve without a new authorization event
- The authorization server defines the oauth `subject`, and resource servers do not require strong guarantees about the client's identity

**AI agents break these assumptions.**

An AI agent is not a bounded client. Its behavior is not fixed at deploy time, and it is not constrained to a single, predictable execution path. Decisions are made at runtime, shaped by prompts, external context, retrieved data, and inference. A one-time human consent doesn’t account for future behavior when that behavior is adaptive by design. As a result, scopes stop being a useful approximation of intent. They describe what an agent can touch, but not why, when, or how that access will be exercised. As an agent's goals and reasoning shift in response to new context, the authority granted during authorization drifts further away from the behavior that occurs at execution time.

Authorization gives us familiar control and keeps a human in the loop. But it also pushes us toward a model where trust is inferred, identity is implied, and limits autonomous behavior. In this model, the subject of access is still the human. The agent is treated as a conduit, not as principal. A byproduct of this is that audit trails collapse back to the approving user or the subject that the authorization server defined. When something goes wrong, it’s impossible to attribute the problem to any particular agent that the human authorized.

**Authentication can fill these gaps**, but there are tradeoffs. 

Authentication gives us a way to treat agents as entities rather than just extensions of a human. With authentication, an agent can present an identity rooted in a trusted identity provider (or hardware), distinct from the human who created or authorized it. Access can then be granted based on who or what the agent is, not just what it has been allowed to access. This enables tighter, context-aware controls, and auditability that reflects the true actor in the system. It also allows trust to be established independently of a single authorization event, which matters when behavior is adaptive, long-lived, or requires fully autonomous execution.

Without authentication, we force adaptive, decision-making systems into security models built for static software. The result is weaker auditability and control at the exact moment systems begin acting on our behalf. 

In reality the authentication and authorization protocols that exist today aren’t adequate to securely handle agentic permissions and auditability. Because agents share attributes of both human and machine interaction modes, we need new systems that can combine the advantages of both authorization and authentication. These systems should let humans approve scoped actions that respect principles of least privilege, help that approval keep up with agentic speed and scale, and let auditors attribute actions to particular agents. 

*Though not explicitly about solving AI agent security challenges*, the IETF and W3C have several projects that evolve existing frameworks, and are creating new ones that begin to address these gaps.
Within the IETF, efforts like [WIMSE](https://datatracker.ietf.org/group/wimse/documents/) and [SPICE](https://datatracker.ietf.org/wg/spice/about/) are starting to address the gap between traditional workload identity and the realities of modern agent execution. WIMSE explores headless OIDC-based flows for machine identity, where authentication does not depend on an interactive human session. WIMSE is also compliant with SPIFFE, allowing builders to automate secure introduction of workloads with minimal friction. SPICE pushes further on how software can present verifiable identity in environments that are dynamic, distributed, and not fully controlled.


