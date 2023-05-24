Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A36470FB65
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjEXQKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 12:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236803AbjEXQKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:10:05 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EAD119
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 09:10:03 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-437de2001bdso356190137.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 09:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684944602; x=1687536602;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hnKnJLk5XskAadqSOglm+u1gXpzLvCMAqdJh1pm0Hzs=;
        b=OPbRiUvnyyM8Ff1YHJXRdDB8TFJhGhfRTeZi/NCsnY+6aqHkO6NOIRuvkasfsCn0XF
         cEAWddOnZQSaHD+LwvRecEBoMv+UGxKgVuRdBNQz4Hc1AM83h6oVTCPTFiju4Sx8ZJ30
         OPR2p6gYx3d0naRWXWzp4hHR2wgjoxkE3yjU3kC7S+pe/XATi4Q0nn6147/LUGSN/a7o
         r0xwjtBbZW2hMEHfGQnjFlYYu8a8vdz/aedcL1ZehKgg6Vh0q/sum/W8ONyA4Wfr6I6p
         Qua3dLeV4r5qXVf/UkF4nRPA7FCdU/HMb4VFtu/VbhGo8oVPkM3/tZYECDZ/iAFgLBeq
         fJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684944602; x=1687536602;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hnKnJLk5XskAadqSOglm+u1gXpzLvCMAqdJh1pm0Hzs=;
        b=a83cgZpxXdmFup/zk8H6tkyIx9X9aZ6zBCej0CnvJq5zv9zx9MBVmMr451N2grv9TV
         53CrKzwhAd9zqUkw1jKzoUgJQpSQvJ9g+E9sHV3b42X3L8L4UUdBRMV+s6Qtdl/ON/4q
         P+FhZ+WVkv4qUt4OYui68R/y4kV2B61qJND3Smqoem3OdVlqa1/f36jtmKTyd51+pA40
         MmxoUNpI6vu7i/6iSYHt5WH2pxnsk20Ua5FS2v197vuNNKkjm/qMcOio4weh/UBHBq7I
         r0eKims0skk2NS0QOvrqsRagDuVxZLKTLTTQmLkbvGKlTWrK6rPyxghd0Bll7dSzAItv
         iXqg==
X-Gm-Message-State: AC+VfDygyAHpU96QNaXd3O/wBy+952A/z9S0qCCWuFo/elngXwuymZRN
        hSdoB5F7vXuWbb3y4GhYnk9SjfHED7IMbTJ8bb2OOg==
X-Google-Smtp-Source: ACHHUZ4N8LNrGGH46475VJSYcLdfqfwXlbofiGMAcoVwOJwNo5Ttw8kKZWbSPwyVOTcCBQ1mZYne0U8cGZf4BfT/hXE=
X-Received: by 2002:a67:e411:0:b0:42e:5597:b60c with SMTP id
 d17-20020a67e411000000b0042e5597b60cmr5117900vsf.2.1684944601973; Wed, 24 May
 2023 09:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvVZ9WF-2zfrYeo3xnWNra0QGxLzei+b4yANZwEvr5CYw@mail.gmail.com>
 <20230524140744.GK4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230524140744.GK4253@hirez.programming.kicks-ass.net>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 24 May 2023 21:39:50 +0530
Message-ID: <CA+G9fYsP1XN31sWMtPsaXzRtiAvHsn+A2cFZS2s6+muE_Qh61Q@mail.gmail.com>
Subject: Re: qemu-x86_64 compat: LTP: controllers: RIP: 0010:__alloc_pages
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, LTP List <ltp@lists.linux.it>,
        lkft-triage@lists.linaro.org, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, 24 May 2023 at 19:37, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, May 24, 2023 at 02:32:20PM +0530, Naresh Kamboju wrote:
> > While running LTP controllers following kernel crash noticed on qemu-x86_64
> > compat mode with stable-rc 6.3.4-rc2.
>
> Both your reports are stable-rc 6.3.4-rc2; can I assume that stable
> 6.3.3 is good?

It was not good.
starting from 6.3.1-c1 these issues were there on
both i386 and x86_64.

I need to check back on other branches and compare it
with Linux mainline and Linux next master branches.

>
> Either way, could you please:
>
>  1) try linus/master
>  2) bisect stable-rc
>
> I don't immediately see a patch in that tree that would cause either of
> these things.

Thanks for asking these questions.
I should have included this information in my earlier email.
I have been noticing this from day one on stable-rc 6.3.1-rc1.

As per your suggestions, I will try to reproduce on other trees and
branches and get back to you.+

FYI,
These are running in AWS cloud as qemu-i386 and qemu-x86_64.

A few old links showing the history of the problem.
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.3-364-ga37c304c022d/testrun/17170422/suite/log-parser-test/test/check-kernel-panic-7c768ef1d898edf92187a69f777efd2977be7fb965a68b333443bd4120e64c06/history/

i386:
====
Boot failed due to the following kernel crash.

<6>[    2.078988] sched_clock: Marking stable (2023078833,
55554488)->(2088116191, -9482870)
<4>[    2.081669] int3: 0000 [#1] PREEMPT SMP
<4>[    2.082070] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.3-rc1 #1
<4>[    2.082174] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.14.0-2 04/01/2014
<4>[    2.082326] EIP: sched_clock_cpu+0xa/0x2b0


i386: while running LTP controllers tests
====
<4>[  888.113619] int3: 0000 [#1] PREEMPT SMP
<4>[  888.113966] CPU: 0 PID: 8805 Comm: pids.sh Not tainted 6.3.1-rc1 #1
<4>[  888.114134] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.14.0-2 04/01/2014
<4>[  888.114360] EIP: get_page_from_freelist+0xf1/0xc70

x86_64: while running LTP controllers tests
======

<4>[ 3182.753415] int3: 0000 [#1] PREEMPT SMP PTI
<4>[ 3182.755092] CPU: 0 PID: 69163 Comm: cgroup_fj_stres Not tainted
6.3.1-rc1 #1
<4>[ 3182.755228] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.14.0-2 04/01/2014
<4>[ 3182.755394] RIP: 0010:__alloc_pages+0xeb/0x340

x86_64: while running LTP tracing tests
======

<4>[   52.392251] int3: 0000 [#1] PREEMPT SMP PTI
<4>[   52.392648] CPU: 0 PID: 331 Comm: journal-offline Not tainted 6.3.3-rc1 #1
<4>[   52.392794] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.14.0-2 04/01/2014
<4>[   52.393070] RIP: 0010:syscall_trace_enter.constprop.0+0x1/0x1b0


- Naresh
