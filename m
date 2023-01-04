Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C0665D6F8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbjADPPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjADPPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:15:43 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822AF1AA2C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 07:15:42 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id a30so7422995pfr.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 07:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NcHEJMiIJ2CTsxxcy2YLVjiMLnHtyJJbhyDHZkGM4Oc=;
        b=F9bpsh37Sd0YglgZi0WpS89CpHqfv0diullW3FFmTO9bOi7hfscSE/OjGPxPEPQkEN
         30dLoca9DbFdO0h28yq/V0+zKhhwP7if4KzONvm0C5e4ZGN7RR/mJV/dX+GglLwSPMpc
         Gck5P/9AM6XxWAH5yODKBjx04KGJHJrt3cUGzkNpLz7TtkHshqQEQMmgpRlw05G6wUeV
         5W4gvQ8VVwwjaGsE/rtTb24nlbbWIKIJVIXrbhMZpYUq/nPtkr3qwhzF10vZuWlV1+AP
         2/8yaiwVmq1nGEh+/72E1SVue5OHi7WQ+fmXOrDqBI08/KLZ3ui1bKaArAvMh6A4NakM
         rQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NcHEJMiIJ2CTsxxcy2YLVjiMLnHtyJJbhyDHZkGM4Oc=;
        b=xIaVDtK/NargfbEcRy5aRwUiOJjAyXEfUVF4deiOBIMJR4ukkSwekctD9Z+aqTnO5S
         SBp18GMKg+KTHL+ScvimpvvHPe3OizAYaPLcspYZSmk7jn2X/OXZ9S5RL6bqwqmSBKxl
         qmaHgDBUJKyCfdWD49+F3fM7LZgL7oqBXK8HyyqKhBBKC6fYkOHZXCFJyZLcjFyIxy1i
         zFNW8h73ut/5Do9mB6Bxk+PCW+XTTvqlfK/ASr4WfoqbIijAsDkkqnQLA+8xJNAgYF4P
         t02EAPHvRnr/T1Pgihv1EBI2yXEjM4+gdUKL7+gET2sZwfMfcDOtG7Vrv9L+85hlGPCK
         TOsg==
X-Gm-Message-State: AFqh2kpOPMLhFumyjn5NUrxbKivyTOQw/8KCr0afxAjDrTW90TVFhiSy
        gTpvBvvyFTYIzfVifeN65fODIoWQpMk00ZoWD02wBA==
X-Google-Smtp-Source: AMrXdXt93Kj3tA2/Y9cGuM6OLuxk7FuAuBumQ9h/vxk1VLQQewgTolksdOkOGf5EMaiCJCDrv92isJrfu7ZsSe9hYkE=
X-Received: by 2002:a63:ba09:0:b0:479:2227:3aa1 with SMTP id
 k9-20020a63ba09000000b0047922273aa1mr2127830pgf.595.1672845341858; Wed, 04
 Jan 2023 07:15:41 -0800 (PST)
MIME-Version: 1.0
References: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org> <Y6Iq1CyHScvZM++Y@fedora>
In-Reply-To: <Y6Iq1CyHScvZM++Y@fedora>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Jan 2023 16:15:05 +0100
Message-ID: <CAPDyKFpCK-z5TH02rFTUHwsFTz83xtiAq=Vp0iE+iztB-CcB5w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] PM: Fixes for Realtime systems
To:     Adrien Thierry <athierry@redhat.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
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

On Tue, 20 Dec 2022 at 22:36, Adrien Thierry <athierry@redhat.com> wrote:
>
> Hi Krzysztof,
> Thanks for looking into this!
>
> I tested your patchset on the QDrive3 on a CentOS Stream 9 RT kernel (I
> couldn't test it on mainline because the latest RT patchset only supports
> 6.1 which is missing some bits needed to boot QDrive3).
>
> It fixes the PSCI cpuidle issue I was encountering in [1]. However, I may
> have found another code path that triggers a similar issue:
>
> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
> in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 113, name: kworker/4:2
> preempt_count: 1, expected: 0
> RCU nest depth: 0, expected: 0
> 4 locks held by kworker/4:2/113:
>  #0: ffff09b0c2376928 ((wq_completion)pm){+.+.}-{0:0}, at: process_one_work+0x1f4/0x7c0
>  #1: ffff800008bf3dd0 ((work_completion)(&genpd->power_off_work)){+.+.}-{0:0}, at: process_one_work+0x1f4/0x7c0
>  #2: ffff09b0c2e44860 (&genpd->rslock){....}-{2:2}, at: genpd_lock_rawspin+0x20/0x30
>  #3: ffff09b0c6696a20 (&dev->power.lock){+.+.}-{2:2}, at: dev_pm_qos_flags+0x2c/0x60
> irq event stamp: 170
> hardirqs last  enabled at (169): [<ffffa1be822f8a78>] _raw_spin_unlock_irq+0x48/0xc4
> hardirqs last disabled at (170): [<ffffa1be822f8df4>] _raw_spin_lock_irqsave+0xb0/0xfc
> softirqs last  enabled at (0): [<ffffa1be814cfff0>] copy_process+0x68c/0x1500
> softirqs last disabled at (0): [<0000000000000000>] 0x0
> Preemption disabled at:
> [<ffffa1be81d7e620>] genpd_lock_rawspin+0x20/0x30
> CPU: 4 PID: 113 Comm: kworker/4:2 Tainted: G               X --------- ---  5.14.0-rt14+ #2
> Hardware name: Qualcomm SA8540 ADP (DT)
> Workqueue: pm genpd_power_off_work_fn
> Call trace:
>  dump_backtrace+0xb4/0x12c
>  show_stack+0x1c/0x70
>  dump_stack_lvl+0x98/0xd0
>  dump_stack+0x14/0x2c
>  __might_resched+0x180/0x220
>  rt_spin_lock+0x74/0x11c
>  dev_pm_qos_flags+0x2c/0x60
>  genpd_power_off.part.0.isra.0+0xac/0x2d0
>  genpd_power_off_work_fn+0x68/0x8c
>  process_one_work+0x2b8/0x7c0
>  worker_thread+0x15c/0x44c
>  kthread+0xf8/0x104
>  ret_from_fork+0x10/0x20
>
> This happens consistently during boot. But on the mainline kernel, this
> code path has changed: genpd_power_off no longer calls dev_pm_qos_flags.
> So it might not happen on mainline. I hope to be able to test your
> patchset again soon on mainline with the next version of the RT patchset
> (which should be able to boot the QDrive3).

You are right, since commit 3f9ee7da724a ("PM: domains: Don't check
PM_QOS_FLAG_NO_POWER_OFF in genpd") dev_pm_qos_flags() doesn't get
called in genpd_power_off() anymore. That patch was introduced in
v5.19.
>
> Best,
> Adrien
>
> [1] https://lore.kernel.org/all/20220615203605.1068453-1-athierry@redhat.com/
>

Kind regards
Uffe
