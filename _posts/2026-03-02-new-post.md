---
layout: post
title: 'How 1P Secures Agent Architectures' 
subtitle: ""
date: 2026-03-02
categories: []
author: Jeff Malnick
---
# How 1Password secures agent architectures

Since 1Password began, we have built security into the places where work actually happens. Security is not treated as an overlay or a separate workflow, we build directly into the browser, command lines, developer tools, and IDEs, where decisions are made and actions take place. We believe that if you want to improve security outcomes, you build where the work happens, making the secure path the simplest one. 

That design philosophy is even more critical in the age of AI agents.

Agent architectures come in many forms. Whether you’re building with a [ReAct pattern](https://docs.langchain.com/oss/python/langchain/agents#example-of-react-loop) (possibly with [RAG](https://en.wikipedia.org/wiki/AI_agent)), [plan-then-execute](https://langchain-ai.github.io/langgraph/tutorials/plan-and-execute/plan-and-execute/), or a [multi-agent swarm](https://relevanceai.com/learn/agent-swarms-orchestrating-the-future-of-ai-collaboration), all AI agents share a common theme: a deterministic chassis. This chassis contains the client-server architecture that underpins all agent architectures. There’s a lot of buzz around AI agents today, but what often gets lost is that what seems novel is actually built on patterns we’ve relied on in software development for decades.

Agentic systems predate generative AI. The [finite state machine](https://en.wikipedia.org/wiki/Finite-state_machine), introduced in the 1950s, underpins workflow-orchestrated and plan-then-execute agent designs. Classical planning systems such as [STRIPS](https://en.wikipedia.org/wiki/Stanford_Research_Institute_Problem_Solver) evolved into [hierarchical task networks](https://en.wikipedia.org/wiki/Hierarchical_task_network) (HTN), which are still essential for task decomposition in modern agents. [Blackboard architectures](https://en.wikipedia.org/wiki/Blackboard_\(design_pattern\)), popular in complex systems and gaming, resemble current multi-agent coordination models. [Event-driven architectures](https://en.wikipedia.org/wiki/Event-driven_architecture) share similarities with the ReAct loop, where the system processes an event, determines an action, executes it, and observes the outcome. While the underlying computational patterns remain consistent, the reasoning engine within these systems has evolved.

In modern agents, that reasoning engine is a probabilistic language model. But the skeleton around it, the runtime, where the execution model for client-server interactions remains deterministic. Every agent ultimately runs inside a client-server shell that invokes an AI context loop one or many times. This shell is the agent chassis, and even though it’s not as sexy as the bleeding-edge models that it interacts with, it’s critical for security.

When I say “agent chassis,” I mean the deterministic runtime that calls the model. It serves as the process boundary where syscalls, client-server network logic, and command flow occur. It is the layer that turns a model’s suggested action into a real interaction. 

The chassis receives little attention because it doesn’t demo well. It is not the part that generates novel text or autonomous behavior. However, it is crucial for security. It mediates network calls, securely retrieves secrets, writes audit logs, and enforces policy guardrails with a deterministic guarantee. 

Until we can prove that agent intent is consistently honest, the AI context itself must be considered untrusted. Trust is established and enforced in the deterministic layer surrounding the context.  Secret injection and decisions to block or permit outbound requests are managed within the chassis.

Agents today are built on the command line, the IDE, and the browser, mature environments with decades of operational and security history. They are the same environments that developers and knowledge workers have relied on for years. The difference is that the “client” interacting with them is increasingly agents rather than humans.

1Password has been building security directly into those environments for a long time. We embed in [browsers](https://support.1password.com/getting-started-browser/) to secure authentication flows without copy-and-paste, integrate with [CLIs](https://developer.1password.com/docs/cli/) to inject secrets without exposing them in shell history or [environment](https://developer.1password.com/docs/environments/) files, and support [IDEs](https://developer.1password.com/docs/vscode/) so developers remain in their workflow. Our investment in [SDKs](https://developer.1password.com/docs/sdks/) and [service accounts](https://developer.1password.com/docs/service-accounts/) enable automation to retrieve secrets safely without hardcoding. Our approach has always been to meet users in their existing tools and ensure that the secure path is the natural one.

This philosophy becomes increasingly important as agents become the interface layer.

The CLI and IDE are becoming the primary entry points for agents, while the browser is evolving into a headless backend, with agents acting on users’ behalf. Although users may interact through chat interfaces, the underlying runtimes remain the browser, terminal, and IDE. As the chassis evolves, its embedded security guarantees must also advance.

This is why [1Password partnered with Browserbase](https://1password.com/blog/closing-the-credential-risk-gap-for-browser-use-ai-agents) last year to develop a headless version of the 1Password browser extension. This allowed agents using [director.ai](http://director.ai) for headless browsing to securely access credentials through a vault-backed mechanism. The browser remained the chassis. The vault remained the source of truth. The enforcement boundary remained outside the AI context: the client changed shape, but the trust model did not.

That same pattern applies to terminals and IDEs. As agents operate inside command-line and IDE workflows, secret injection must continue to be mediated. When you can’t rely on changing behaviors, you have to change the system. That’s why 1Password is invested in building security into the systems that developers and every-day users leverage so the easy path is the secure path, regardless of what tool they’re using.

Agents will continue to evolve, but the chassis will remain the place where security lives, and that’s where you can continue to find 1Password innovating now and in the future. 
