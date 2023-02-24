Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D806A14F0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 03:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjBXCdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 21:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjBXCdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 21:33:04 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8183F199DB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 18:33:02 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id b20so7760090pfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 18:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v7D5+/tTKW4hdCKLoGhGLZFN3+ohidFIvVz7P7koHlk=;
        b=TqIRXVfgz6LBupiY2MkRcBseRiyJ7neFuVaTF3fYvmFFGl9TsT/USgKJ8ewASzxh3o
         /HRAPsYVkwaMImGHtKYQbogH+nOgDY/U1PMJmKMXeOxWpDU9FLMzJV0YXBA4JTaeGzN1
         YsTkOZ7aoJ6IkvizZRl3Axbg55L7Osd8eVdt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7D5+/tTKW4hdCKLoGhGLZFN3+ohidFIvVz7P7koHlk=;
        b=WLF7YB+p57/PoSDuVBOIvr7pLS7LeExmbn+FY4b36vHIcJw8NerOgJeDM0AqARnu0l
         +pXmPtNy9Ex2irFwbGrlxYPFMrd++QQ/c64qbLpo8q2Q+mWq0bB4lWoXYWtokJwUSmsF
         yV80UaF+WY/zyAlswGXJKjUpVOLfP1fKxwGnD1tpasLxnNvxHNmAlMrtI+xTynYZdBDR
         zE3XrrPwKuNEZ+44gBwP1K3sB8SY4+SdBXNc87uznEm0X7vVmEQ21mmGkcPTZbXLIDag
         f60z2SBSss399Lns9TmGQOtU/okOYPb+8otJK96H4uMRfLEdSz9QzOf6nxifSJLH2QH7
         SptQ==
X-Gm-Message-State: AO0yUKUOIkwvaiTUPyhQry5nK2u7+aqQxQVnu0b7X4wVBsPWw6hkz9Bz
        EpKKXA/4LpzfnLBkMqDZywiBYsq3cA0B/gSuLdoo
X-Google-Smtp-Source: AK7set++kyCManleDnDskA+/fx2yOFWwby3yiI0iFzoAl+ek8Jbav3knAnBru2MFKPfxE5NSNvbWGImJgNblJx3qzTs=
X-Received: by 2002:a05:6a02:110:b0:502:e3fb:bdac with SMTP id
 bg16-20020a056a02011000b00502e3fbbdacmr1435529pgb.1.1677205981535; Thu, 23
 Feb 2023 18:33:01 -0800 (PST)
MIME-Version: 1.0
References: <CAOnJCUKHq_8msJtU-H1JvWJ8nY94J0tcarQMBsPNpBZO8sP6HQ@mail.gmail.com>
 <Y/cjW8qVhRTPiz0t@hirez.programming.kicks-ass.net>
In-Reply-To: <Y/cjW8qVhRTPiz0t@hirez.programming.kicks-ass.net>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 23 Feb 2023 18:32:50 -0800
Message-ID: <CAOnJCUJQVQQUn_brgKCMFduo_RUYndFDuV-m0e2g3AQo6CV==g@mail.gmail.com>
Subject: Re: Perf event to counter mapping question
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-perf-users@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Beeman Strong <beeman@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
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

On Thu, Feb 23, 2023 at 12:27 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Feb 22, 2023 at 04:28:36PM -0800, Atish Patra wrote:
>
> > AFAIK, ARM64 allows all-to-all mapping in pmuv3[1]. That makes life
> > much easier. It just needs to pick the next available counter.
> > On the other hand, x86 allows selective counter mapping which is
> > discovered from the json file and maintained in per event
> > constraints[4].
>
> All the contraint management is done in kernel, and yes, it's a giant
> pain in the rear side.
>
> From what I understand the reason for these contraints is complexity of
> implementation, less constraints is more 'wires' in the hardware.
>
> With PMU use being ever more popular, we're seeing the x86 PMU move
> towards less constraints -- although I don't think we'll ever get rid of
> them :/
>
> > 2. Mandate all-to-all mapping similar to ARM64.
>
> If at all possible, I would strongly recommend taking this route. Yes,
> the hardware people will complain, but newer x86 hardware having less,
> or simpler, constraints might be sufficient to convince them.
>

Yeah. That's where folks want to go in order to provide flexibility
for future platform vendors by
allowing constraints.

Can you provide some examples or some pointers that describe these
simpler constraints ?

Finding a middle path would certainly keep everyone happy :). Thanks a
lot for your input.

> (and if you do have to do contraints, please take a lesson from x86 and
>  *never* allow overlapping contraints as AMD had, solving those
>  constraints is not fun)
>
> As you note, this is *much* simpler to program and virtualize.
>
> > Note: This is only for programmable counters. If the platform supports
> > any fixed counters (i.e. can monitor
> > only a specific event), that needs to be provisioned via some other
> > method. IIRC the fixed counters(apart from cycle) in ARM64 are part of
> > AMU not PMU.
>
> So free running counters are ideal and fairly simple to multiplex/use.
>
> The moment you start adding overflow interrupts / filters and any other
> complexities to fixed function counters it becomes a mess (look at the
> x86 PMU again).



--
Regards,
Atish
