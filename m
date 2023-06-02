Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22844720ABE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 23:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbjFBVCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 17:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbjFBVCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 17:02:44 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F651197
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 14:02:43 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-ba818eb96dcso2398041276.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 14:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685739762; x=1688331762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRGX/7FVcKXywnk21BiSZROJV8xYMUqrqkGkpYOfQwY=;
        b=Oy8N/RIkZHE7Ca9DK2TAOVdN2mdqX2GzIN7en9kr0rJrnFR8LesI5uLuIhIOC35YeC
         OAD57nZ29rcWqbpMcfv3QJadMbwAFjppOx16wbLbHLghBoYCBsxKYm9GH0EtLDuajuUs
         V2nrkwKtMMtjUX2I36oFib2qNyGtiTk+iWJfofKZv8V8ufmx42lhAuFYkqimMBXlzvFR
         hRtuu6v9yTm6b2NLfldSQZFGXfPmBAVivBRDPfvOVsLRK9qS6WGXPbZRWjKNbpZkIpw0
         gxd3PkpdPEZAe2puKHcAzAqWT/3x5qdCHTIphakvoVVK8QoSsqBLrMas3nJhUmmhzOjH
         hs5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685739762; x=1688331762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRGX/7FVcKXywnk21BiSZROJV8xYMUqrqkGkpYOfQwY=;
        b=JLHqKlGe3SzYooXhGT9S3jB0WEbI0u3Olom5JZ0njyAhJCgd32MGVi251AtwueMKxs
         A3TYV8i/w5sY7CW7f3MahD04hEvX/MuwJ4XCjFikgU2D9C6vMfJH7TLFqOnFowNMrOp9
         E+/r7SOWXlSauqaFZNII27iM9rdnbtkhkgsBPOem8ftJ9MU6e5Eg9vxTkeDk1FyEwWAp
         u3axTj10SXJGpj/ssXTlB+4ogTT0U/c5mvXvmfJ8m63XEadeAHaCbsD8KVcJROwNRTPb
         yh7vObC08Lmd7K9RH+hBS5NIzFrZkF67++KokdgBwNMPIjrAhbYlekpjKMUHXPiD0KTS
         1EzQ==
X-Gm-Message-State: AC+VfDylXcKCyUO1DoPVAKysI1EUBSfcCKBVwTHCKn1V+X06mt7DJtG9
        wahVB1zEpVNfnZ2DhBlxZZlp26gqBLxXIioScX2OPQ+GjkDQqg==
X-Google-Smtp-Source: ACHHUZ5xk2aJcGinyOCzK1I5WIGqUm5962AKqUeDB7EYyqifvJrVfKm7A9zeaFmS1/EHR34jsZFI36zqPYI2c+qy1Ak=
X-Received: by 2002:a25:ab28:0:b0:b9e:5aad:ed72 with SMTP id
 u37-20020a25ab28000000b00b9e5aaded72mr4084855ybi.31.1685739762435; Fri, 02
 Jun 2023 14:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <168547265011.24337.4306067683997517082-0@git.sr.ht>
 <CAHC9VhQhBBPyZE24LM6KvYrET2huW-W_YYsyPndpNkn70Mu3Ug@mail.gmail.com>
 <87fs7abu0f.fsf@email.froward.int.ebiederm.org> <CAHC9VhRk3WhXh-GTDSKFW3PujXiQCDy3xk4Xb9_Lo4szgQ5G6Q@mail.gmail.com>
 <87ilc67i95.fsf@email.froward.int.ebiederm.org> <CAHC9VhT_D9qc3Od-DTZ52q_7bySOX1FWLTXha_OJUyHK5woq5w@mail.gmail.com>
In-Reply-To: <CAHC9VhT_D9qc3Od-DTZ52q_7bySOX1FWLTXha_OJUyHK5woq5w@mail.gmail.com>
From:   Akihiro Suda <suda.kyoto@gmail.com>
Date:   Sat, 3 Jun 2023 06:02:30 +0900
Message-ID: <CAG8fp8TN+DQu8kok7_PcxtK=7TTBJTYm60-Y9ZnH+Euf5n4xJQ@mail.gmail.com>
Subject: Re: [PATCH linux 0/3] [PATCH] userns: add sysctl "kernel.userns_group_range"
To:     Paul Moore <paul@paul-moore.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, containers@lists.linux.dev,
        serge@hallyn.com, brauner@kernel.org, akihiro.suda.cz@hco.ntt.co.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you all for feedbacks,

> (Paul)

> Given the challenges around adding access controls to userns
> operations, have you considered using the LSM support that was added
> upstream last year?

I'll consider this.

> The relevant LSM hook can be found in commit
> 7cd4c5c2101c ("security, lsm: Introduce security_create_user_ns()"),
> and although only SELinux currently provides an access control
> implementation, there is no reason you couldn't add support for your
> favorite LSM, or even just a simple BPF LSM to enforce the group
> controls as you've described them here.

My intent is to provide an universal knob that works for both SELinux
distros and AppArmor distros.
So I guess I should try to use BPF LSM (and find out how its end-user
UX in the userspace can be simplified just like sysctl).

---
> (Christian)

> Yes. Please, no more sysctls...

I'll try to find another way, such as (BPF) LSM.

---
> (Eric)

> How does this functionally differ from what already exists
> user.max_user_namespaces?

My patch is not about the numbers of the UserNS, but about who is
permitted to create UserNS,
which can be a potential attack surface to pwn the root in the initial User=
NS.

> Given that setns exists I don't see limiting creation of user namespaces
> by group being meaningful, if your goal is to reduce the attack surface
> of the kernel to mitigate potential kernel vulnerabilities.

Yes, that's my goal.
The intent is to allow creating UserNS only for (semi-trusted) human
users who need to run unprivileged (aka rootless) containers.
Creating UserNS is expected to be prohibited for system daemon
accounts and human users who do not need (or who are not trusted
enough) to run containers.

This configuration should be more secure than just allowing everybody
to run unprivileged (aka rootless) containers, and also more secure
than just disabling UserNS and running everything as the root.

> How does this functionality interact with the use of setgroups in a user
> namespace?
>
> What is the value of a group_range inside of a newly created user
> namespace?  How does that work to maintain the policy you are trying to
> implement?

In a child UserNS, the group_range file is expected to use the mapped
IDs, not the initial UserNS IDs.
(So, the range can't be just initialized with `.range =3D {0,
((gid_t)~0U) - 1}`. My patch v1 is wrong.)

> Paul are you aware that the LSM hook can not be used to achieve the
> objective of this patchset?

What would be an obstacle to using an LSM hook for this? (with an
addition of GID checks)

2023=E5=B9=B46=E6=9C=882=E6=97=A5(=E9=87=91) 23:50 Paul Moore <paul@paul-mo=
ore.com>:
>
> On Thu, Jun 1, 2023 at 9:41=E2=80=AFPM Eric W. Biederman <ebiederm@xmissi=
on.com> wrote:
> > Paul Moore <paul@paul-moore.com> writes:
> > > On Thu, Jun 1, 2023 at 8:14=E2=80=AFPM Eric W. Biederman <ebiederm@xm=
ission.com> wrote:
> > >> Paul Moore <paul@paul-moore.com> writes:
> > >> >
> > >> > Given the challenges around adding access controls to userns
> > >> > operations, have you considered using the LSM support that was add=
ed
> > >> > upstream last year?  The relevant LSM hook can be found in commit
> > >> > 7cd4c5c2101c ("security, lsm: Introduce security_create_user_ns()"=
),
> > >>
> > >> Paul how have you handled the real world regression I reported again=
st
> > >> chromium?
> > >
> > > I don't track chromium development.
> >
> > You have chosen to be the maintainer and I reported it to you.
>
> I just dug through all of the mail I've received from you over the
> past two (?) years, as well as checking the LSM archive on lore and I
> don't see any bug reports from you directed at the upstream LSM or
> SELinux code ... perhaps I missed something, do you have a pointer?
>
> Also, for the sake of clarification, I do not maintain any part of
> Chromium or Chrome OS.  I do maintain the upstream LSM, SELinux,
> audit, and labeled networking subsystems in the Linux Kernel as well
> as a couple of userspace packages.
>
> > >> Paul are you aware that the LSM hook can not be used to achieve the
> > >> objective of this patchset?
> > >
> > > /me shrugs
> >
> > [snip parts about performing a group id check]
>
> My comments here were only discussing the possibility of performing a
> group ID based access control check; I made no claims about the
> desirability of such a check, and I have no interest in rehashing our
> old debates.
>
> --
> paul-moore.com
