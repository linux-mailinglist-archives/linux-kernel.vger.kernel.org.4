Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DF65B43C2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 04:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIJCfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 22:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiIJCft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 22:35:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39AEEB2F8;
        Fri,  9 Sep 2022 19:35:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67DA6B826FB;
        Sat, 10 Sep 2022 02:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107B1C433B5;
        Sat, 10 Sep 2022 02:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662777346;
        bh=0Mjpz0NZyG15c3hKekSKAa1N3iRYO+AMMCvxdMAwiLw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EAm+OM4Y1f/NntvBYNo6p5j6xhoM1uZT8NUvy7WSKErMegmK+5lEDotHLbi7oNZvs
         kZSL9N45oVJV80NTaXc9MJbTb0hf/1tPv9zsA2x2oJ+4IQEPyynZ8p62l1enp0/uA8
         t3cdaE0nT4RNLX9FYV0WL4eJfKLrwKUErZmNdwLoyFwAJIj8rkkjQj/57RbtBUtPHy
         Kd1kxRDU2/NU0TtHNRdUJ+7JIBi+SDm0ieetVoV+qnYVGbG1baHhJ8BWbcKV3BoTaE
         plzxDmu1PDTJcPrCVacqYei1rvYZpdWvQsGsossCgTLXNBiy0XRW17pR0s6sCp2V1W
         O95LURgdcixKA==
Received: by mail-ot1-f46.google.com with SMTP id t8-20020a9d5908000000b0063b41908168so2217098oth.8;
        Fri, 09 Sep 2022 19:35:46 -0700 (PDT)
X-Gm-Message-State: ACgBeo3emFEFx5N89w78KmWTpdP14MO5nXj1ghsFf8Wc9W0tsMLvBe8P
        eF1rCNwwh5Z/M8vKbAJX99o9gJ6nPVR7qrzlrwA=
X-Google-Smtp-Source: AA6agR4NZuxapoem7Ze6cnesDBQReIS6ZvRk5lDRhuoebef/CHJvEgm9viSddPBGbZmy2r1qbivMF6FPUPXCWzjOzJs=
X-Received: by 2002:a05:6830:3482:b0:638:92b7:f09b with SMTP id
 c2-20020a056830348200b0063892b7f09bmr6488987otu.140.1662777345127; Fri, 09
 Sep 2022 19:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210723161600.19688-1-mathieu.desnoyers@efficios.com>
 <20210723161600.19688-2-mathieu.desnoyers@efficios.com> <CAJF2gTR9_SzAm2kPXyP+xJDVmdvM=XSm7kJn_eNq-wQmhLqTeg@mail.gmail.com>
 <2070284546.6496.1627316900287.JavaMail.zimbra@efficios.com> <cbd08ae8-4558-60e3-17e4-988e625984a1@efficios.com>
In-Reply-To: <cbd08ae8-4558-60e3-17e4-988e625984a1@efficios.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 10 Sep 2022 10:35:33 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRbn-JiUMiX_s52geJSiTs7qYV3oEkW1+NC8Vwp1YAKvg@mail.gmail.com>
Message-ID: <CAJF2gTRbn-JiUMiX_s52geJSiTs7qYV3oEkW1+NC8Vwp1YAKvg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] Revert "csky: Add support for restartable sequence"
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2022 at 4:01 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2021-07-26 12:28, Mathieu Desnoyers wrote:
> > ----- On Jul 26, 2021, at 12:10 PM, Guo Ren guoren@kernel.org wrote:
> >
> >> Hi Mathieu,
> >>
> >> Sorry for forgetting to CC you in the last patch, and that patch has
> >> been merged into master which has the problem of syscall restart.
> >>
> >> I still want to keep rseq feature for csky, and implement the
> >> RSEQ_SKIP_FASTPATH for self-test, it that okay?
> >
> > No, the RSEQ_SKIP_FASTPATH is the one special-case of test build which
> > skips building rseq critical sections entirely. This leaves out any
> > relevant testing of rseq per-se. With what we have in the upstream
> > selftests, I expect this test configuration to abort at runtime because
> > no slow-path fallbacks are available when the fastpath is disabled.
> >
> > The asm glue to test rseq user-space really needs to be implemented
> > for any useful testing to be done here.
> >
> > Unless that asm glue is contributed, none of the rseq logic is actually
> > tested on that architecture.
> >
> > Considering the extremely-hard-to-debug nature of races with a broken
> > rseq kernel implementation, proper testing coverage is paramount, so I
> > still recommend the revert unless the selftests user-space asm glue is
> > contributed for C-Sky.
>
> Hi Guo,
>
> A friendly ping after 1.5 year about the fact that the selftests code is
> still missing for the csky architecture. So there is no way to validate
> that the kernel pieces that were merged actually work on that architecture.
>
> What is the timeline for contribution of the missing bits needed to enable
> those tests ?
I would send the 1st version of patchset before 2022/10/30, or just
revert it from csky.

1. a patch for fixup the bug:
diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
index b7b3685283d7..434dcf2e8e37 100644
--- a/arch/csky/kernel/signal.c
+++ b/arch/csky/kernel/signal.c
@@ -179,8 +179,6 @@ static void handle_signal(struct ksignal *ksig,
struct pt_regs *regs)
        sigset_t *oldset = sigmask_to_save();
        int ret;

-       rseq_signal_deliver(ksig, regs);
-
        /* Are we from a system call? */
        if (in_syscall(regs)) {
                /* Avoid additional syscall restarting via ret_from_exception */
@@ -206,6 +204,8 @@ static void handle_signal(struct ksignal *ksig,
struct pt_regs *regs)
                }
        }

+       rseq_signal_deliver(ksig, regs);
+
        /* Set up the stack frame */
        ret = setup_rt_frame(ksig, oldset, regs);

2. Add tools/testing/selftests/rseq/rseq-csky* codes.



>
> Here are the required header files:
>
> tools/testing/selftests/rseq/rseq-csky.h
> tools/testing/selftests/rseq/rseq-csky-thread-pointer.h (only if __builtin_thread_pointer is not implemented by gcc)
>
> I'm open to suggestions from other rseq co-maintainers on how to best address
> this situation.
>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com



-- 
Best Regards
 Guo Ren
