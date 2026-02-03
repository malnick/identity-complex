---
layout: post
title: "Emerging Agent Identity Frameworks"
date: 2026-02-01
categories: [ai-security, identity]
author: Jeff Malnick
---
## Agent Identity Is Not a Single Model

As agents move from experimentation into real systems, “agent identity” keeps getting talked about like it’s one problem waiting for the right standard. What’s actually happening is more subtle and more interesting. We’re running into different identity problems at different moments in an agent’s lifecycle. How long an agent lives, how independently it acts, and how often its intent changes all matter, and they surface different failure modes.

Once agents persist over time and operate without humans in the loop, identity stops being about login and starts being about how authority persists, moves, and stays accountable over time. Across research, standards work, and early production systems, three identity models show up repeatedly: authorization delegation and authenticated delegation, persistent agent identity, and hybrid or compound identity. Most real systems end up using more than one at the same time. Recent work like [OpenID Connect for Agents (OIDC-A)](https://subramanya.ai/2025/04/28/oidc-a-proposal/), [Agentic JWT (A-JWT)](https://arxiv.org/abs/2509.13597), and MIT’s paper on [Authenticated Delegation and Authorized AI Agents](https://www.media.mit.edu/publications/authenticated-delegation-and-authorized-ai-agents/) is exciting precisely because it starts to separate these layers instead of mashing them together.

Most agent systems today begin with authorization delegation, even if they don’t call it that. A human logs in, an agent gets a token, and actions happen “on the user’s behalf.” [OAuth 2.0](https://oauth.net/2/) and [OpenID Connect](https://openid.net/specs/openid-connect-core-1_0.html) were built for this model. A user authenticates, consent is captured, scopes are granted, and a client is trusted to behave. This works well when the client is a relatively dumb application. It breaks down when the client is an autonomous agent.

The cracks are structural, not accidental. Delegation is implicit, because tokens carry scopes but look indistinguishable from application tokens to downstream systems. Authentication disappears early, because once a token is issued, most services lose visibility into the original human authentication event. Authorization assumes intent is static, because scopes are evaluated at issuance time while agents reason and adapt continuously. Attribution fragments, because the same agent shows up under different identities across systems. None of this is a bug. These frameworks were designed for apps, not actors.

This is the gap the MIT paper names very explicitly with authenticated delegation. What makes authenticated delegation compelling is that it draws a hard line between impersonation and delegation. In this model, a third party can verify that the interacting entity is an AI agent, that it is acting on behalf of a specific human, and that the human actually authenticated and delegated that authority. Identity is no longer implied or inferred. It is cryptographically provable.

What’s important here is that the agent does not authenticate *as* the human. Instead, it presents verifiable proof that it is acting under a delegation explicitly bound to a prior human authentication event. OAuth and OpenID Connect already provide most of the primitives needed to do this, and the MIT paper shows how to extend them with explicit agent identities and delegation tokens rather than inventing a new identity system from scratch. OIDC-A pushes in this direction by making agents first-class participants in the protocol and by introducing delegation chains and contextual claims that preserve the link back to the human authenticator. Authenticated delegation is exciting because it allows agent intent to closely track user intent while keeping accountability intact.

That said, authenticated delegation still has a natural ceiling. Once agents run without humans in the loop, you need a stable principal for the agent itself. This is where persistent agent identity comes in. In this model, an agent authenticates as itself, holds credentials, and survives restarts, redeployments, and long-running workflows. We’ve been building this kind of workload identity for years with systems like [SPIFFE](https://spiffe.io/) and [SPIRE](https://spiffe.io/spire/), which give us durable identifiers, automated rotation, and strong authentication guarantees.

Persistence is great for continuity. Logs make sense. Credentials rotate. Agents don’t disappear when a session expires. What persistent identity does *not* tell you is why the agent is acting or whose authority it is exercising at any given moment. The MIT paper is very clear on this point: identity alone is not accountability. Without a verifiable delegation context, persistent agents start to look like independent actors, even when they are meant to be acting for someone else. This is where things get interesting.

In practice, agents are neither purely delegated nor purely autonomous. They need authorization delegation to grant scoped access, authenticated delegation to ground actions in a human principal, persistent identity to operate continuously, and a way to keep authority aligned as behavior evolves. This is hybrid or compound identity, where multiple standards layer on top of each other to provide a complete framework. 

What really excites me here is how cleanly A-JWT fits into this picture. A-JWT assumes that the agent already has a persistent identity and that authority originated through authenticated delegation upstream. It doesn’t replace OAuth, OpenID Connect, or any other standard. Instead, it tackles a very specific failure mode: drift. Rather than issuing a static access token, [A-JWT](https://arxiv.org/abs/2509.13597) issues a short-lived intent token for each action. That token binds the agent’s identity, the original delegation context, the workflow and execution state, and proof-of-possession keys tied to the runtime.

The result is that services can verify not just who the agent is and who delegated authority, but whether the agent is acting within that delegation *right now*. Delegation stays meaningful even as agents reason, adapt, and take unexpected paths.

There isn’t going to be a single protocol that “solves” agent identity. What we’re building instead is a stack: authorization delegation to establish access scope, authenticated delegation to establish accountability, persistent agent identity to enable autonomy, and intent-bound enforcement to keep authority aligned over time. That stack is starting to come into focus, and that’s what makes this moment interesting.

If you’re building in this space and want to compare notes on the challenges you’re seeing, how they map to these layers, or just want to talk through where agent security is heading, I’d love to chat.

