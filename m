Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4C16525F4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiLTSGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbiLTSGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:06:01 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD7F10AA
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:05:59 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id cf42so19830528lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zT6l/y+/pcaCmWRWjjyqwx7biICVm4k76H1yPF1TiAw=;
        b=VAfEntZvS7ozYFIxBpP/w6QhPifNGUsxboGKFqt1S0S/XZ+YCl4fhf+qIGjQfYD92T
         LzbWusQn88EBEl65Laq9d42wzF7FBu8ll3I4WMRaEvXq3R5Wp6+0jLUMUnX/fs0Deh8R
         oG4A2WJ5KfmpCukTCWe9uhlqiElFhxas/MOec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zT6l/y+/pcaCmWRWjjyqwx7biICVm4k76H1yPF1TiAw=;
        b=Jq/9dRhta8k62jOTb31sc41jP0EXK4CAoWSJY+4ABq0zZQ6P21eg+kovP35JeO6RsL
         ItW7vs/iEE1LE/DzXjpksBM6kVNH9UUzwiw3w93P1CD8KR6YqTLUkXz36E2muklBJSlO
         5y/NxNXP1CW/gM8mBYEh1Ld00ahDOHbtpZXkNT/UJNMpqsUAZwzCN9QddJEB3x9WzRGa
         6WQ4AOkPYBKYOfESbRhu8L9uoHi/rKxEllU2kLPOkU/cnfgz9xokRiq4vhba+QCla326
         dg9PC8T5qjbDQDIpXM8V28DShbPHh8ajqPzNV8k7lWQxnmFccqGLscT3WUuVzwNUlhWd
         kc+w==
X-Gm-Message-State: ANoB5pkmmgCn7aHTHyacXc+0LbLykGg6AEBmqV7pcZtHir6j+GLb2U2A
        Ztb8mR0iDxOw7H2X7qxWJQl3qJCpCOKEUYuLGvcukg==
X-Google-Smtp-Source: AA0mqf7ACIOYyaWFZgZT0P2Gp4sAUR/fuzWXWMMqzGPI5InVmVPUWObxItqzpZSl0PiAcalJyRXzIh2J80hkTXXfcp4=
X-Received: by 2002:ac2:4347:0:b0:4a4:782a:42ac with SMTP id
 o7-20020ac24347000000b004a4782a42acmr31861231lfl.468.1671559557915; Tue, 20
 Dec 2022 10:05:57 -0800 (PST)
MIME-Version: 1.0
References: <20221218191310.130904-1-joel@joelfernandes.org>
 <589da7c9-5fb7-5f6f-db88-ca464987997e@efficios.com> <CAEXW_YQHpz3dNqW1ocqjr-e9qn09Rkg4kQ19byZORGbO18Xckg@mail.gmail.com>
 <2da94283-4fce-9aff-ac5d-ba181fa0f008@efficios.com> <CAEXW_YQBmwynuBOWbV6_L2itRr_i3BZUxQ91PDC2We2vXhpztQ@mail.gmail.com>
 <CAEXW_YTyZaE4ULvm-HygFN2BGm-jayHTbpnYbrJFoo_GOsYKQg@mail.gmail.com>
 <659763b0-eee4-10dd-5f4a-37241173809c@efficios.com> <CAEXW_YQ+NTaM43Va5FG8kYSxr2gsbjar4_f3xnpSAHzgUVZ-+g@mail.gmail.com>
 <CAEXW_YRqscm++0TP9bEnM0PQNLMe4cXFWAdRvHh2M5chERm+UA@mail.gmail.com> <35293ec4-40a1-cf6b-3bdd-0e3e30819c06@efficios.com>
In-Reply-To: <35293ec4-40a1-cf6b-3bdd-0e3e30819c06@efficios.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 20 Dec 2022 18:05:46 +0000
Message-ID: <CAEXW_YR194jzDQM7YZr0H8pDjhxUdymFbaheOGsMXq8judgGEQ@mail.gmail.com>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Tue, Dec 20, 2022 at 5:00 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2022-12-19 20:04, Joel Fernandes wrote:
> > On Mon, Dec 19, 2022 at 7:55 PM Joel Fernandes <joel@joelfernandes.org> wrote:
[...]
> >>> On a 64-bit system, where 64-bit counters are used, AFAIU this need to
> >>> be exactly 2^64 read-side critical sections.
> >>
> >> Yes, but what about 32-bit systems?
>
> The overflow indeed happens after 2^32 increments, just like seqlock.
> The question we need to ask is therefore: if 2^32 is good enough for
> seqlock, why isn't it good enough for SRCU ?

I think Paul said wrap around does happen with SRCU on 32-bit but I'll
let him talk more about it. If 32-bit is good enough, let us also drop
the size of the counters for 64-bit then?

> >>> There are other synchronization algorithms such as seqlocks which are
> >>> quite happy with much less protection against overflow (using a 32-bit
> >>> counter even on 64-bit architectures).
> >>
> >> The seqlock is an interesting point.
> >>
> >>> For practical purposes, I suspect this issue is really just theoretical.
> >>
> >> I have to ask, what is the benefit of avoiding a flip and scanning
> >> active readers? Is the issue about grace period delay or performance?
> >> If so, it might be worth prototyping that approach and measuring using
> >> rcutorture/rcuscale. If there is significant benefit to current
> >> approach, then IMO it is worth exploring.
>
> The main benefit I expect is improved performance of the grace period
> implementation in common cases where there are few or no readers
> present, especially on machines with many cpus.
>
> It allows scanning both periods (0/1) for each cpu within the same pass,
> therefore loading both period's unlock counters sitting in the same
> cache line at once (improved locality), and then loading both period's
> lock counters, also sitting in the same cache line.
>
> It also allows skipping the period flip entirely if there are no readers
> present, which is an -arguably- tiny performance improvement as well.

The issue of counter wrap aside, what if a new reader always shows up
in the active index being scanned, then can you not delay the GP
indefinitely? It seems like writer-starvation is possible then (sure
it is possible also with preemption after reader-index-sampling, but
scanning active index deliberately will make that worse). Seqlock does
not have such writer starvation just because the writer does not care
about what the readers are doing.

That said, the approach of scanning both counters does seem attractive
for when there are no readers, for the reasons you mentioned. Maybe a
heuristic to count the number of readers might help? If we are not
reader-heavy, then scan both. Otherwise, just scan the inactive ones,
and also couple that heuristic with the number of CPUs. I am
interested in working on such a design with you! Let us do it and
prototype/measure. ;-)

Thanks.
