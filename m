Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88202651CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 09:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbiLTIzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 03:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiLTIy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 03:54:57 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077122BF4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 00:54:57 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so11429747pjd.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 00:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LsgUbWA0oaO98/rxmdhbwjk4RhX07lFMYlpGEJGL62Q=;
        b=ljwxUO9CO6d2EvEEbERmJLD/GzelrZnwTt3v2ueLgR6ElaVTniUl3ZKiDKpz8u4Pmg
         dWbGmoPRA9pUcBVHMGGC1nM4JBSfil0s5GCPw2GxAhMM553bjGx5pQIdkpqevfEoVhKv
         kZUrgSH3g2jOHFnaY8p2BiRLu1LdXhH0RBrnh+jcy4krN8lMglSharYJtGidOqhV7FsI
         ReoRq8XE9A1NnqQ23hkEWxM7sF48W+Bys+6hpZrtVg9Q4U+WrCjC167gL/mAKdnqyChS
         uyede3qlPFzvitOf2UDfJPmWzCRUSqCvX/WC1SN8Dp9C6dTaz+wWU1STDRStCQOGLTCU
         eOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsgUbWA0oaO98/rxmdhbwjk4RhX07lFMYlpGEJGL62Q=;
        b=sMIIw0XcybRWVebWaipG24JZDy69UKirrg4OnF2ngZyqiy/0aZpxS03rpfDZqPHbSU
         WW8zm4nJJ+sk7gtJruq33LcB7+UpJmiU5KgFPAbDlI2frI2VhPkA66K4icRq2F36NjHJ
         8UFfa+baBxbVdWG7IQXt2OEIv88qFHLdNUOEwAIse2iFdY4HYpP3RbsHGn3JB0EsFf8E
         aqK131ijSJWfJOUh9Yv+22VWuFl5tdO8ehcYnpYUhZtN3hI+uw+21hCeIe5LNzqt8b0n
         r9zH1U6pmlV8DeLdbiomCcribxD1RgWO3se5xvyRyLPZiO7qE1rOXMHf1kMx3/qufMTA
         /EzQ==
X-Gm-Message-State: AFqh2kp/uXaHd7C8QsUcgZL80LFi+xBRWSMd5CB8hC16iT66+bDDDtO2
        Nhd4/eeqCSsVnzyYU4bc+EcfP7Q+kkOrPJf3kIT7Mw==
X-Google-Smtp-Source: AMrXdXvc3+JZdiL5yHe6wk7hp0iOaktHs/BXEI0ZyUhzJJT+WaxufaKI0+XCDeqOiVpgkeSd1sZ4ZSZ5U7AK83RAUlg=
X-Received: by 2002:a17:90b:309:b0:223:4a7d:878d with SMTP id
 ay9-20020a17090b030900b002234a7d878dmr2130200pjb.29.1671526496397; Tue, 20
 Dec 2022 00:54:56 -0800 (PST)
MIME-Version: 1.0
References: <CADYN=9LfFwNjToc8nhrD1MMZnQptyMNjbEFaMjPXuzzxADMbsA@mail.gmail.com>
 <c68c4226-6a5b-b3f6-3102-d7c34b576f9d@huawei.com>
In-Reply-To: <c68c4226-6a5b-b3f6-3102-d7c34b576f9d@huawei.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 20 Dec 2022 09:54:45 +0100
Message-ID: <CADYN=9K0m4ELhrROKh5S9qmKnFHwrt7ORVeC4HioQ1-TuHe7sA@mail.gmail.com>
Subject: Re: BUG: sleeping function called from invalid context at kernel/kallsyms.c:305
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     mcgrof@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Dec 2022 at 04:29, Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
>
>
> On 2022/12/16 18:45, Anders Roxell wrote:
> > Hi,
> >
> > I'm building an arm64 allmodconfig kernel (see the .config [1]) on
> > yesterdays next tag 20221215 with KALLSYMS_SELFTEST enabled and I saw
> > the following bug when the selftest ran:
> >
> > [29725.015182][   T58] BUG: sleeping function called from invalid
> > context at kernel/kallsyms.c:305
> > [29725.022953][   T58] in_atomic(): 0, irqs_disabled(): 128,
> > non_block: 0, pid: 58, name: kallsyms_test
> > [29725.031272][   T58] preempt_count: 0, expected: 0
> > [29725.035903][   T58] RCU nest depth: 0, expected: 0
> > [29725.040574][   T58] no locks held by kallsyms_test/58.
> > [29725.045494][   T58] irq event stamp: 18899904
> > [29725.049809][ T58] hardirqs last enabled at (18899903):
> > finish_task_switch.isra.0 (core.c:?)
> > [29725.059608][ T58] hardirqs last disabled at (18899904):
> > test_perf_kallsyms_on_each_symbol (kallsyms_selftest.c:?)
> > [29725.069936][ T58] softirqs last enabled at (18899886): __do_softirq (??:?)
> > [29725.078670][ T58] softirqs last disabled at (18899879):
> > ____do_softirq (irq.c:?)
> > [29725.087399][   T58] CPU: 0 PID: 58 Comm: kallsyms_test Tainted: G
> >              T  6.1.0-next-20221215 #2
> > 0a142be8faea13ac333ed9a1cf4e71b6966ad16e
> > [29725.099607][   T58] Hardware name: linux,dummy-virt (DT)
> > [29725.104674][   T58] Call trace:
> > [29725.107909][ T58] dump_backtrace (??:?)
> > [29725.112706][ T58] show_stack (??:?)
> > [29725.116883][ T58] dump_stack_lvl (??:?)
> > [29725.121666][ T58] dump_stack (??:?)
> > [29725.125852][ T58] __might_resched (??:?)
> > [29725.130712][ T58] kallsyms_on_each_symbol (??:?)
> > [29725.136018][ T58] test_perf_kallsyms_on_each_symbol (kallsyms_selftest.c:?)
> > [29725.142008][ T58] test_entry (kallsyms_selftest.c:?)
> > [29725.146312][ T58] kthread (kthread.c:?)
> > [29725.150567][ T58] ret_from_fork (??:?)
> > [29734.975283][   T58] kallsyms_selftest: kallsyms_on_each_symbol()
> > traverse all: 5744310840 ns
> > [29734.992268][   T58] kallsyms_selftest:
> > kallsyms_on_each_match_symbol() traverse all: 1164580 ns
> > [29735.049679][   T58] kallsyms_selftest: finish
> >
> > looks like the issue is that test_perf_kallsyms_on_each_symbol() does
> > these function calls:
> >
> >        local_irq_save(flags);
> >        t0 = sched_clock();
> >        kallsyms_on_each_match_symbol(match_symbol, stat.name, &stat);
> >        t1 = sched_clock();
> >        local_irq_restore(flags);
> >
> > and inside kallsyms_on_each_match_symbol(), cond_resched() is called.
> >
> > Any ideas how to solve this?
>
> I was initially hoping that the test process would not be interrupted.
> It is not a big problem to remove local_irq_save(). From a probabilistic
> statistical point of view: it does not affect the horizontal comparison
> between kallsyms_on_each_symbol() and kallsyms_on_each_match_symbol(),
> and the vertical comparison before and after optimization is also not
> affected.
>
> Or do not call cond_resched() during the test. This method seems to be
> a little better.

I tried this patch and yes it made the kallsyms selftest to finish.

Please send a patch.

Cheers,
Anders

>
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index e31b4d87a4e1b71..9e07fabaf08e647 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -358,7 +358,8 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
>                 ret = fn(data, namebuf, NULL, kallsyms_sym_address(i));
>                 if (ret != 0)
>                         return ret;
> -               cond_resched();
> +               if (!IS_ENABLED(CONFIG_KALLSYMS_SELFTEST))
> +                       cond_resched();
>         }
>         return 0;
>  }
> @@ -375,7 +376,8 @@ int kallsyms_on_each_match_symbol(int (*fn)(void *, unsigned long),
>
>         for (i = start; !ret && i <= end; i++) {
>                 ret = fn(data, kallsyms_sym_address(get_symbol_seq(i)));
> -               cond_resched();
> +               if (!IS_ENABLED(CONFIG_KALLSYMS_SELFTEST))
> +                       cond_resched();
>         }
>
>         return ret;
>
> >
> > Cheers,
> > Anders
> > [1] https://people.linaro.org/~anders.roxell/next-20221215.config
> > .
> >
>
> --
> Regards,
>   Zhen Lei
