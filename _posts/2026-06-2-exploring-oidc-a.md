---
layout: post
title: "Exploring OIDC-A and the Limits of Existing OAuth Frameworks"
date: 2026-02-06
categories: [ai-security, identity]
author: Jeff Malnick
---
## Exploring OIDC-A and the Limits of Existing OAuth Frameworks

Modern identity systems such as [OAuth 2.0](https://datatracker.ietf.org/doc/html/rfc6749) are built on an assumption that has held for decades: authority ultimately traces back to a human and is exercised through static, centrally governed access models. This approach works well for traditional automation, where access is provisioned deliberately, changes infrequently, and is constrained by well-understood operational boundaries such as deployed services and CI/CD pipelines.

Agents challenge this model because their behavior and access needs are neither static nor easily predicted. Traditional automation is typically deterministic and tightly scoped, with permissions configured by a small set of administrators and rarely revisited. Autonomous and semi-autonomous agents, by contrast, [operate continuously](https://arxiv.org/abs/2509.25974?utm_source=chatgpt.com), make decisions at machine speed, and are frequently tasked with broad, situational objectives rather than fixed workflows.

As agents reason and act, their authority must adapt to context, intent, and changing conditions, which introduces access patterns that are both more dynamic and more sensitive than those of traditional workloads. This [increases the need for clear authority boundaries](https://www.nist.gov/itl/ai-risk-management-framework) and accountability, while simultaneously exposing the limits of identity systems that assume access can be defined once and enforced indefinitely.

The resulting gap appears structural rather than procedural, because identity systems optimized for centralized, manual approval do not naturally extend to environments where delegation is frequent, task-specific, and time-bounded. Relying on static roles and pre-approved access becomes increasingly brittle as authorization decisions need to be evaluated continuously and often without direct human involvement.

[OIDC-A, or OpenID Connect for Agents](https://arxiv.org/abs/2509.25974), represents one proposed approach to addressing this gap by extending existing identity protocols to better express delegation, policy-bounded authority, and accountability. Rather than replacing OAuth or OpenID Connect, OIDC-A explores how additional semantics at the identity layer might support more dynamic authorization models, where individuals can delegate limited authority within organizational constraints.

## The Limits of Traditional Identity Models

[OpenID Connect](https://openid.net/connect/) is optimized to answer a narrow but powerful question: who authenticated, and who vouches for that authentication. The resulting ID token ties a subject to an issuer, with optional claims describing the authenticated entity. This works well for users and static applications, but it was not designed to model the behaviors and trust relationships common in agent-based systems.

Agents are not just clients with credentials. Agents can be created dynamically, operate autonomously, and [delegate authority to other agents](https://www.nist.gov/itl/ai-risk-management-framework). They may act under constrained authority, for a limited time, and for a narrowly scoped purpose, with those constraints changing as tasks evolve.

OAuth scopes in OpenID Connect were designed to express access rights, not the context in which that access was granted. They do not encode who delegated authority, how that authority was constrained, or why a subject should be trusted to act in a given situation. As a result, systems often reconstruct provenance and intent using application-specific logic layered on top of tokens, which makes authorization decisions opaque and difficult to audit.

OIDC-A proposes addressing these gaps by extending OpenID Connect to carry explicit delegation chains, agent identity claims, and trust signals directly within the protocol. This shifts some of the burden of interpretation out of application code and into the identity layer itself, allowing authorization decisions to be evaluated more consistently across services rather than inferred indirectly.

## What OIDC-A Introduces

[OIDC-A builds on OAuth 2.0](https://arxiv.org/pdf/2509.25974.pdf) and OpenID Connect rather than replacing them, which preserves interoperability and lowers the barrier to experimentation. One of its central ideas is allowing tokens to carry structured claims describing the agent itself, such as its type, model identity, provider, and instance metadata. For agents, identity and capability are closely linked, because properties such as model type or runtime environment may influence authorization decisions and trust assessment. OIDC-A explores how making these attributes explicit and machine-verifiable could support more nuanced policy evaluation.

Delegation is central to agent ecosystems. Agents frequently act on behalf of users, organizations, or other agents, often with reduced or constrained authority. OIDC-A introduces a structured way to represent delegation chains inside tokens, where each step captures who delegated authority, what was delegated, and under what constraints. This approach aligns with the principle of [least privilege](https://csrc.nist.gov/glossary/term/least_privilege), where downstream actors receive only the authority required to perform a specific task. By making delegation explicit, OIDC-A suggests a path toward systems that can enforce and audit delegation decisions more reliably.

OIDC-A also provides a mechanism for including attestation evidence alongside identity claims, allowing relying parties to evaluate properties of an agent’s execution environment such as platform integrity or runtime guarantees. This work builds on existing attestation efforts like [IETF RATS](https://datatracker.ietf.org/doc/html/rfc9334), which define how trust evidence can be conveyed between systems. In practice, technologies like [SPIFFE](https://spiffe.io/docs/latest/spiffe-about/overview/) and SPIRE already generate this type of workload-level attestation by issuing cryptographically verifiable identities tied to runtime and platform characteristics. OIDC-A complements these systems by proposing a standardized way to carry attestation-derived trust signals through OpenID Connect, enabling authorization decisions to account not only for who issued a token, but also how and where the agent is operating.

## Why OIDC-A Matters for the Future of Agents

Agents are [already interacting with production systems](https://owasp.org/www-project-top-10-for-large-language-model-applications/), credentials, and sensitive data. As their autonomy increases, the need for clear accountability and bounded authority becomes more acute. Identity systems that assume a human is present at authorization time struggle to express these requirements. OIDC-A is interesting not because it claims to solve agent identity outright, but because it surfaces the limitations of existing models and proposes concrete extensions to address them. By evolving proven standards rather than discarding them, it offers a path for experimenting with agent-native identity semantics within familiar infrastructure.

OIDC-A is not the final word on identity for agents, but it represents a meaningful step toward treating agents as first-class participants. Whether or not it becomes the dominant approach, the problems it highlights are real, and any durable solution will need to confront delegation, accountability, and trust at the identity layer.
