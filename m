Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC29A70C6DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbjEVTXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbjEVTXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:23:07 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC18102
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:23:03 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6af78ce91b1so1131882a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1684783383; x=1687375383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8zMTN7zTGe5ZjtKMSPWF9CCv9G8IAwDGtMsCMVfvqSs=;
        b=Ni4F+wNuA/WRjDsVgmAyhQ6BJB96m2cTpl4yh65IZ8WyOWz/kXJ+jVm79X+LSGwtPn
         jDLY2qlkmy3J2zTpwMuqCKCxbcQisMPtdSwxGHUxTe5iAGvKXePbACpWC0SJxhyEiBPa
         wRvuOJMzL/yr2jmIlYfzGW6ucKNitvMQxfNVdTi7VsSyoHtsA6lGRnmm5+two3DKcSzE
         VyvVQmHf5oXoNAtn+b8yB3tOoH4IgJYKUiqZLPcyeVxygt0kxXnbsMo0sNDhtVlh5SK0
         hgFL/IgY02FRsy40GNBOibyRz1THKvse8cIUlamrAPPlnv/pzjANTWkn5Q7Fv6j2Buii
         jnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684783383; x=1687375383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8zMTN7zTGe5ZjtKMSPWF9CCv9G8IAwDGtMsCMVfvqSs=;
        b=alsj5UI0ONX8tLTIg9Y+eFfIXebG2EorAkEG36i4Wk2T3jh94MATiYAq/A1Vnbed5K
         zCQyh/h7TZZ7X5BIY3KinZP38IVQyQ7JiCwoDk3zkU+JQD9hvzUVhyd/fjFKYqTIqcSc
         F1BGE5m8S3ArPnoaDYv1o48/tG47eJnCzqbXPtNe6w815EBJKBJB1s1OFTfR0fsi994m
         /+TL7k0dVOrpap0MRpE7TDgW4jEry9JARHkFmFGhT97KHyZIFL1mlOfJUJXPmbPJPF4S
         h+n1AGZVFpefR3iMtb/LRMjhtaN+vq6fCTqDTwHpQdyTbey34FB8bqH/5NOSpLlKiQ01
         PJ5w==
X-Gm-Message-State: AC+VfDyWjoXljUmPh056cscRlUUMKE7w5xpSRMebdEn/6CB6Yvo9mLgI
        emh+vxAKGi7T6KBko3MtkJiPC9T2u3IDOPZ072AVQg==
X-Google-Smtp-Source: ACHHUZ7hR6n346vDCXTqeBMqkIZE3IvkKpHCc2z523oVmHdCFGweLS1CGE1ddMyikQMWvCR6UNIUQNabIsuQ0MC2wO0=
X-Received: by 2002:a9d:61ce:0:b0:6ab:35a6:de17 with SMTP id
 h14-20020a9d61ce000000b006ab35a6de17mr6796299otk.28.1684783383185; Mon, 22
 May 2023 12:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230515025716.316888-1-vineeth@bitbyteword.org>
 <20230515025716.316888-3-vineeth@bitbyteword.org> <20230515100616.33ba5dd9@luca64>
 <CAO7JXPgq8V5yHM6F2+iXf4XJ9cyT30Hn4ot5b2k7srjsaPc3JQ@mail.gmail.com>
 <20230516093729.0771938c@luca64> <CAO7JXPh5uLV4QjAEi6bJXfAGSsZ=XsnCyzrvKS8m35BGbRPYJw@mail.gmail.com>
 <20230519115621.2b3f75e2@luca64> <20230519121804.6c85a3ed@luca64>
 <CAO7JXPhZPvzVRyL87qNT5VnaVOf=0wrRftFB-Rjx-vJc3JUMog@mail.gmail.com> <20230520115857.3838a7ea@nowhere>
In-Reply-To: <20230520115857.3838a7ea@nowhere>
From:   Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date:   Mon, 22 May 2023 15:22:52 -0400
Message-ID: <CAO7JXPgXi8q02HBeBR_RLWmODd9uQBH_UMCYgVQwbf+FX=Qxkg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] sched/deadline: Fix reclaim inaccuracy with SMP
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

Merging the last two mails in this reply :-)

> So, we are wasting 181.3 - 95 = 86.3% of CPU time, which 590 cannot
> reclaim (because it cannot execute simultaneously on 2 CPUs).
>
Correct. Thanks for explaining it in detail, I was tracing the scheduler
and verified this pattern you explained.

> Now that the problem is more clear to me, I am trying to understand a
> possible solution (as you mention, moving some extra bandwidth from the
> 590's CPU will fix this problem... But I am not sure if this dynamic
> extra bandwidth migration is feasible in practice without introducing
> too much overhead)
>
> I'll look better at your new proposal.
>
The idea that I mentioned tries to solve this problem in a best effort
way: If global load is high, use the global "Uextra = rq->dl.extra_bw"
and "Umax = rq->dl.this_bw + rq->dl.extra_bw". Otherwise use the local
values "Umax= rq->dl.max_bw", "Uextra= rq->dl.max_bw - rq->dl.this_bw".
This is still not perfect, but tries to reclaim very close to maximum
allowed limit almost always.

Please have a look when you get a chance :-).

>
> I just tried to repeat this test on a VM with 3 CPUs, and I can
> reproduce the stall (100% of CPU time reclaimed by SCHED_DEADLINE
> tasks, with no possibility for the other tasks to execute) when I use
>         dq = -(max{u_i / Umax, (Umax - Uinact - Uextra)}) * dt
>
> But when I use
>         dq = -(max{u_i, (Umax - Uinact - Uextra)} / Umax) * dt
> everything works as expected, the 4 tasks reclaim 95% of the CPU
> time and my shell is still active...
> (so, I cannot reproduce the starvation issue with this equation)
>
Sorry about this confusion, yes you are right, there is no stall with
this equation. The only issue is the lesser reclaim when the load is
less and tasks have different bandwidth requirements.

> So, I now think the second one is the correct equation to be used.
>
Thanks for confirming.

I think it probably makes sense to get the fix for the equation to go
in as a first step and then we can investigate more about the second
issue (less reclaiming with less load and different bandwidth) and
fix it separately. What do you think? I shall send the next iteration
with the fix for the equation alone if its okay with you.

Thanks,
Vineeth
