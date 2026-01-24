---
layout: post
title: "Agent AuthN: The Hard Problem"
subtitle: "Authentication, not authorization, is the hard agentic problem we need to solve."
date: 2026-01-23
categories: [ai-security, identity]
author: Jeff Malnick
---

Most agent frameworks today rely on OAuth to let humans authorize agents to access applications on their behalf. This works largely because OAuth gives us a familiar, just-in-time browser flow where a human can make an explicit decision. It is a pragmatic choice. But as agents become more autonomous and less predictable, the lack of authentication for agents becomes the limiting factor in how secure modern systems can be.

AI agents change the landscape not because the idea of an agent is new, but because the logic that controls how an AI agent behaves is non-deterministic, and they are experienced as extensions of human capability. Chat interfaces paired with decision-making powerful enough to act on our behalf shift these systems closer to human actors than to structured programs with deterministic outputs. Delegation is a natural approach to first-line security.

You can see this most clearly in the security mechanisms we have built to control agents. MCP servers ship with OAuth as the primary layer for humans to authorize agents to access systems on their behalf. This choice is natural both structurally and as a user interface. The browser-based consent flow is something we already understand, and it gives humans a clear moment in the loop to approve access to confidential data or services.

## The Limits of Authorization

But authorization is designed to connect one application to another within strictly defined scopes. Authorization solves a usability problem around human-mediated trust between deterministic systems. Instead of manually configuring trust between Calendly and Google Calendar, OAuth authorization allows Calendly to ask Google for access, prompts the user to approve a set of scopes, and, with a single click, establishes trust on both sides. It is elegant when you consider the alternatives that came before it.

This flow assumes a lot about the systems involved:

- Authorized client behavior is stable and constrained by predictable software
- Human consent is a reasonable proxy for future behavior, and approval implies long-term trust
- Scopes granted adequately match the intent of the authorized client
- Required capabilities are static, and do not evolve without a new authorization event
- The authorization server defines the subject, and resource servers do not require strong guarantees about the client's identity

**AI agents break all of these assumptions.**

An AI agent is not a bounded client. Its behavior is not fixed at deploy time, and it is not constrained to a single, predictable execution path. Decisions are made at runtime, shaped by prompts, external context, retrieved data, and probabilistic inference. A one-time moment of human consent cannot reasonably stand in for future behavior when that behavior is adaptive by design. As a result, scopes stop being a useful approximation of intent. They describe what an agent can touch, but not why, when, or how that access will be exercised. As an agent's goals and reasoning shift in response to new context, the authority granted during authorization drifts further away from the behavior that actually occurs at execution time.

Authorization gives us a familiar control surface and keeps a human in the loop. But it also pushes us toward a model where trust is inferred rather than asserted, where identity is implied rather than authenticated, and limits fully autonomous behavior. In this model, the subject of access is still effectively the human. The agent is treated as a conduit, not as principal. Audit trails collapse back to the approving user, if you can bring all the audit logs from the various third party systems together in a comprehensible way. There is no stable, cryptographically rooted identity.

## Authentication as Foundation

Authentication can fill these gaps.

Authentication gives us a way to treat agents as accountable entities rather than extensions of a human. With authentication, an agent can present an identity rooted in a trusted identity provider (or hardware), distinct from the human who created or authorized it. Access can then be granted based on who or what the agent is, not just what it has been allowed to access. This enables tighter, context-aware controls, and auditability that reflects the true actor in the system. It also allows trust to be established independently of a single authorization event, which matters when behavior is adaptive, long-lived, or requires fully autonomous execution.

Without authentication, we will continue forcing adaptive, decision-making systems into security models built for static software. The result is not only weaker security, but a loss of accountability at the exact moment systems begin acting on our behalf.

## Emerging Standards

Though not explicitly about solving AI agent security challenges, the IETF and W3C have several projects that evolve existing frameworks, and are creating new ones that begin to address these gaps.

Within the IETF, efforts like **WIMSE** and **SPICE** are starting to address the gap between traditional workload identity and the realities of modern agent execution. WIMSE explores headless OIDC-based flows for machine identity, where authentication does not depend on an interactive human session. WIMSE is also compliant with SPIFFE, allowing builders to automate secure introduction of workloads with minimal friction. SPICE pushes further on how software can present verifiable identity in environments that are dynamic, distributed, and not fully controlled.

These efforts will allow engineers to more easily build for a fully authenticated identity, rather than the delegated workflows common today. They assume that non-human actors need to enroll with identity providers, present cryptographic proof of who or what they are, and be treated as principals rather than extensions of a user.

## Looking Ahead

Looking further ahead, there is a future where **W3C Verifiable Credentials** are the unifying layer of identity for humans, agents, and machine workloads. In that world, humans and agents carry portable, cryptographically verifiable claims about their origin, capabilities, and operating constraints. Identity would no longer be tied exclusively to a single runtime, cloud provider, or authorization server. Instead, human and non-human actors could prove properties about themselves across environments, even when running on hardware or platforms outside of direct administrative control.

Authorization cannot carry the weight of agent identity on its own. As agents become more autonomous, adaptive, and long-lived, authentication must become the first approach engineers reach for when building agentic systems. As engineers, we need to build toward a model where agent identity is explicit, attestable, and independent of a single authorization event. Ideally, I'm hoping this future also allows us to unify our approach to identity in a single framework, enabling a simplified, defragmented future for both engineers and end users.
