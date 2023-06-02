Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A0C71F89C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 04:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjFBCxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 22:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjFBCw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 22:52:59 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DC819F;
        Thu,  1 Jun 2023 19:52:57 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-256931ec244so1311168a91.3;
        Thu, 01 Jun 2023 19:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685674377; x=1688266377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/+TBYwgbuRhvfui6dXqksXycS4Ln0IcW9u7kRGefkU=;
        b=A1BhXFTxrPgEd8UtLLp7pITxUJFRgSLU3YIEHSqTkHFzD7PgM50zfvIjt+u+PXhjhR
         LmsbbaBv4iyJN1pAZqEf5xLvqvGLKwh6p+Gu22b4juNY9KXhXcGd2Wuf0m9JX7FvXo9g
         MmDD7pSybi7COPYWnyzOvxLu4drwofDjcGZ8xDXTXfrCQ25UmaYACkz5lNSwRYdDYD1I
         9LqYBMkGi+aqqtCR4nqSSQUmGLvIJ1aZ8qx0V1aIpQ/2xMM+PdlCJRjzfR0WCZBlD5C6
         qIKOediB3nqTqnlJ0F2brT85JvTi4kyspvmcATpZ7qiEUqnXhSoW7/F2W1W6vuWm/1p3
         KqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685674377; x=1688266377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/+TBYwgbuRhvfui6dXqksXycS4Ln0IcW9u7kRGefkU=;
        b=ceT8qFqLTSdHkvKrJEOkTW6m/CD+EzYc3/vNqeIKVo4ckkLWgVxACmm5VEBt7mkOsB
         beIntSXYunyYlxBFxtUm03lVjRHR+h+50d0FHesBa8DbJuUSXPYR3lMrjdGpitwDlcl2
         NuWx82AUW85pIG4BAUtSL4txh3hIHo3RGHZ5Q+BS7RBRYpNPlASUAuSlbrR50SdZrTdU
         MJMcYrMm5L77DVYZY0V/t3SPMJ8muS2qxn4pyZMKtZYGNGcgA0Gx4E6xCz69ZJ87boZe
         u58mpQERlxFtXKhxVhO1uSA4NnhW5wmZp815Rv+veJ1Eja/FJrN4Jgb0pVUyIzDG/kfo
         kUbg==
X-Gm-Message-State: AC+VfDwJuxSITDPBZZile5Deoa9qUrVAXmp1TrNtMn6yLjqgnc+KQChs
        /WSWjLveZzE95jK9z7deeXUajO2/vPbmaAADqgU=
X-Google-Smtp-Source: ACHHUZ5GdJ05jfOrAvM8/twOYnfKHO2dtPne7GRNo58n5BvFJKmcNQJLcXsM4L+eCe/ALu4OYhs1HvGBngz8YH3areg=
X-Received: by 2002:a17:90b:4f8a:b0:255:2daa:4796 with SMTP id
 qe10-20020a17090b4f8a00b002552daa4796mr1056575pjb.44.1685674376921; Thu, 01
 Jun 2023 19:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
 <20230330224726.662344-11-paulmck@kernel.org> <6549da46-dddc-67ac-73c4-966965addad7@nvidia.com>
 <CALm+0cVXGdLNQpfJxnAnq2j2Ybs_rVAEqNzxgLSq7bDJp1KnfA@mail.gmail.com> <0a35ce9d-8eec-4e10-a607-a2e84c8fc5a0@paulmck-laptop>
In-Reply-To: <0a35ce9d-8eec-4e10-a607-a2e84c8fc5a0@paulmck-laptop>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Fri, 2 Jun 2023 10:52:44 +0800
Message-ID: <CALm+0cWkVsMBQo+rHHWFSwsAkRTOmHxXJDSuVE9Dhh=1fHTmEg@mail.gmail.com>
Subject: Re: [PATCH rcu 11/20] srcu: Move grace-period fields from srcu_struct
 to srcu_usage
To:     paulmck@kernel.org
Cc:     Jon Hunter <jonathanh@nvidia.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On Thu, Jun 01, 2023 at 08:33:10PM +0800, Z qiang wrote:
> > >
> > > Hi Paul,
> > >
> > > On 30/03/2023 23:47, Paul E. McKenney wrote:
> > > > This commit moves the ->srcu_gp_seq, ->srcu_gp_seq_needed,
> > > > ->srcu_gp_seq_needed_exp, ->srcu_gp_start, and ->srcu_last_gp_end f=
ields
> > > > from the srcu_struct structure to the srcu_usage structure to reduc=
e
> > > > the size of the former in order to improve cache locality.
> > > >
> > > > Suggested-by: Christoph Hellwig <hch@lst.de>
> > > > Tested-by: Sachin Sant <sachinp@linux.ibm.com>
> > > > Tested-by: "Zhang, Qiang1" <qiang1.zhang@intel.com>
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > >
> > >
> > > I have noticed a suspend regression on some of our Tegra boards recen=
tly
> > with v6.4-rc and interestingly bisect is pointing to this commit. I was
> > unable revert this on top of the latest mainline but if I checkout this
> > commit suspend fails and if I checkout the previous commit is passes.
> > >
> > > Enabling more debug I was able to capture the following crash log I s=
ee
> > on one of the boards ...
> > >
> > > [   57.327645] PM: suspend entry (deep)
> > > [   57.331660] Filesystems sync: 0.000 seconds
> > > [   57.340147] Freezing user space processes
> > > [   57.347470] Freezing user space processes completed (elapsed 0.007
> > seconds)
> > > [   57.347501] OOM killer disabled.
> > > [   57.347508] Freezing remaining freezable tasks
> > > [   57.348834] Freezing remaining freezable tasks completed (elapsed
> > 0.001 seconds)
> > > [   57.349932] 8<--- cut here ---
> > > [   57.349943] Unable to handle kernel NULL pointer dereference at
> > virtual address 00000000 when write
> > > [   57.349960] [00000000] *pgd=3D00000000
> > > [   57.349986] Internal error: Oops: 805 [#1] PREEMPT SMP ARM
> > > [   57.350007] Modules linked in: tegra30_tsensor
> > > [   57.350033] CPU: 0 PID: 589 Comm: rtcwake Not tainted
> > 6.3.0-rc1-00011-g03200b5ca3b4-dirty #3
> > > [   57.350057] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree=
)
> > > [   57.350067] PC is at rcu_segcblist_enqueue+0x2c/0x38
> > > [   57.350120] LR is at srcu_gp_start_if_needed+0xe4/0x544
> > > [   57.350169] pc : [<c01a5120>]    lr : [<c0198b5c>]    psr: a007009=
3
> > > [   57.350183] sp : f0b2dd20  ip : 3b5870ef  fp : 00000000
> > > [   57.350194] r10: ef787d84  r9 : 00000000  r8 : ef787d80
> > > [   57.350205] r7 : 80070013  r6 : c131ec30  r5 : ef787d40  r4 : f0b2=
dd64
> > > [   57.350217] r3 : 00000000  r2 : 00000000  r1 : f0b2dd64  r0 : ef78=
7d84
> > > [   57.350230] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
> >  Segment none
> > > [   57.350251] Control: 10c5387d  Table: 81d8004a  DAC: 00000051
> > > [   57.350261] Register r0 information: non-slab/vmalloc memory
> > > [   57.350283] Register r1 information: 2-page vmalloc region startin=
g at
> > 0xf0b2c000 allocated at kernel_clone+0xb4/0x3e4
> > > [   57.350322] Register r2 information: NULL pointer
> > > [   57.350337] Register r3 information: NULL pointer
> > > [   57.350350] Register r4 information: 2-page vmalloc region startin=
g at
> > 0xf0b2c000 allocated at kernel_clone+0xb4/0x3e4
> > > [   57.350379] Register r5 information: non-slab/vmalloc memory
> > > [   57.350394] Register r6 information: non-slab/vmalloc memory
> > > [   57.350408] Register r7 information: non-paged memory
> > > [   57.350422] Register r8 information: non-slab/vmalloc memory
> > > [   57.350436] Register r9 information: NULL pointer
> > > [   57.350449] Register r10 information: non-slab/vmalloc memory
> > > [   57.350463] Register r11 information: NULL pointer
> > > [   57.350477] Register r12 information: non-paged memory
> > > [   57.350491] Process rtcwake (pid: 589, stack limit =3D 0x410bb531)
> > > [   57.350510] Stack: (0xf0b2dd20 to 0xf0b2e000)
> > > [   57.350534] dd20: 00000000 c1ee4a40 f0b2dd7c c0184f24 ef781495
> > 3b5870ef c1ee4a40 c1ee4a40
> > > [   57.350555] dd40: c131ec30 00000000 00000002 c0f3d1fc c3542ac0
> > c2abbb10 c1ee4a40 c0199044
> > > [   57.350574] dd60: 60070013 00000000 c0195924 00000000 00000000
> > f0b2dd74 f0b2dd74 3b5870ef
> > > [   57.350592] dd80: 00000000 c131ebc0 c120ab28 c0146d9c c2785b94
> > c2785b40 c0fee9f4 c0872590
> > > [   57.350611] dda0: c2785b40 c08c39cc c2785b40 c08c3a3c c2788c00
> > c08c40b0 c0f3d1fc c066f028
> > > [   57.350630] ddc0: f0b2de14 c2788c00 c1325ef4 c08c1d40 c2788c00
> > c1325ef4 c0fee9f4 c08c31cc
> > > [   57.350648] dde0: c13708a0 0000000d 00000000 c0681c10 c16afe84
> > 00000002 56508788 0000000d
> > > [   57.350665] de00: 00000002 c13708a0 10624dd3 56409580 0000000d
> > 00000000 00000002 c0f3d1fc
> > > [   57.350685] de20: c3542ac0 c2abbb10 c1ee4a40 c06824e4 00000000
> > ffffa900 00000000 c1386510
> > > [   57.350703] de40: 00000003 00000003 c1204f75 c017e8a8 c3542ac0
> > c2abbb10 00428228 c0171574
> > > [   57.350721] de60: 00000000 00000000 00000003 3b5870ef c1204f75
> > 00000000 00000003 c137aeb4
> > > [   57.350739] de80: c1204f75 c0f3d1fc c3542ac0 c2abbb10 00428228
> > c017f380 00000003 c0f38a54
> > > [   57.350757] dea0: 00000003 c1386524 00000004 c017d708 00000004
> > c2abbb00 00000000 00000000
> > > [   57.350775] dec0: c3542ac0 f0b2df28 c2abbb10 c03305b4 00000000
> > 00000000 c2953c00 c1ee4a40
> > > [   57.350794] dee0: 00429438 00000004 c0d18488 00004004 00000000
> > c02b1094 00000a55 c1d80010
> > > [   57.350812] df00: c1d80010 00000000 00000000 f0b2df78 01010006
> > 00000004 00000000 00429438
> > > [   57.350830] df20: 00000000 00000000 c2953c00 00000000 00000000
> > 00000000 00000000 00000000
> > > [   57.350848] df40: 00000000 00004004 00000000 00000000 0000006c
> > 3b5870ef c2953c00 c2953c00
> > > [   57.350866] df60: 00000000 00000000 c1ee4a40 00429438 00000004
> > c02b12c8 00000000 00000000
> > > [   57.350885] df80: 00001008 3b5870ef 0000006c 00429438 00428228
> > 00000004 c0100324 c1ee4a40
> > > [   57.350902] dfa0: 00000004 c01000c0 0000006c 00429438 00000004
> > 00429438 00000004 00000000
> > > [   57.350920] dfc0: 0000006c 00429438 00428228 00000004 00000004
> > 00000004 0041578c 00428228
> > > [   57.350938] dfe0: 00000004 becda9a8 b6e9bc0b b6e26206 600f0030
> > 00000004 00000000 00000000
> > > [   57.350960]  rcu_segcblist_enqueue from
> > srcu_gp_start_if_needed+0xe4/0x544
> > > [   57.351023]  srcu_gp_start_if_needed from
> > __synchronize_srcu.part.6+0x70/0x98
> > > [   57.351084]  __synchronize_srcu.part.6 from
> > srcu_notifier_chain_unregister+0x6c/0xdc
> > > [   57.351155]  srcu_notifier_chain_unregister from
> > cpufreq_unregister_notifier+0x60/0xbc
> > > [   57.351215]  cpufreq_unregister_notifier from
> > tegra_actmon_pause.part.0+0x1c/0x54
> > > [   57.351277]  tegra_actmon_pause.part.0 from tegra_actmon_stop+0x38=
/0x3c
> > > [   57.351324]  tegra_actmon_stop from
> > tegra_governor_event_handler+0x100/0x11c
> > > [   57.351373]  tegra_governor_event_handler from
> > devfreq_suspend_device+0x64/0xac
> > > [   57.351423]  devfreq_suspend_device from devfreq_suspend+0x30/0x64
> > > [   57.351467]  devfreq_suspend from dpm_suspend+0x34/0x33c
> > > [   57.351506]  dpm_suspend from dpm_suspend_start+0x90/0x98
> > > [   57.351528]  dpm_suspend_start from
> > suspend_devices_and_enter+0xe4/0x93c
> > > [   57.351573]  suspend_devices_and_enter from pm_suspend+0x280/0x3ac
> > > [   57.351614]  pm_suspend from state_store+0x6c/0xc8
> > > [   57.351654]  state_store from kernfs_fop_write_iter+0x118/0x1b4
> > > [   57.351696]  kernfs_fop_write_iter from vfs_write+0x314/0x3d4
> > > [   57.351733]  vfs_write from ksys_write+0xa0/0xd0
> > > [   57.351760]  ksys_write from ret_fast_syscall+0x0/0x54
> > > [   57.351788] Exception stack(0xf0b2dfa8 to 0xf0b2dff0)
> > > [   57.351809] dfa0:                   0000006c 00429438 00000004
> > 00429438 00000004 00000000
> > > [   57.351828] dfc0: 0000006c 00429438 00428228 00000004 00000004
> > 00000004 0041578c 00428228
> > > [   57.351843] dfe0: 00000004 becda9a8 b6e9bc0b b6e26206
> > > [   57.351863] Code: e2833001 e5803034 e5812000 e5903010 (e5831000)
> > > [   57.351875] ---[ end trace 0000000000000000 ]---
> > >
> > >
> > > I have not dug into this yet and so wanted to see if you have any
> > thoughts on this?
> > >
> >
> > Hi, Jon
> >
> > Please try it:
> >
> > diff --git a/include/linux/notifier.h b/include/linux/notifier.h
> > index 2aba75145144..3ce6b59e02e5 100644
> > --- a/include/linux/notifier.h
> > +++ b/include/linux/notifier.h
> > @@ -110,6 +110,7 @@ extern void srcu_init_notifier_head(struct
> > srcu_notifier_head *nh);
> >         {                                                       \
> >                 .mutex =3D __MUTEX_INITIALIZER(name.mutex),       \
> >                 .head =3D NULL,                                   \
> > +               .srcuu =3D __SRCU_USAGE_INIT(name.srcuu),         \
> >                 .srcu =3D __SRCU_STRUCT_INIT(name.srcu, name.srcuu, pcp=
u), \
> >         }
>
> Thank you both!
>
> Huh.  It looks like Chen-Yu Tsai sent a patch to this effect and
> AngeloGioacchino Del Regno tested it.  No one has picked it up yet.
>
> https://lore.kernel.org/all/20230526073539.339203-1-wenst@chromium.org/
>
> This is clearly a regression, and I don't see it in -next.  I will pick
> it up and send it along in a few days if Matthias or Rafael don't beat
> me to it.
>
> In the meantime, I would be happy to add Jon's Reported-by and Tested-by,
> along with Qiang's Acked-by or Reviewed-by.
>

Acked-by: Zqiang <qiang.zhang1211@gmail.com>

Thanks
Zqiang

>
>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit bf7da55fcdd1478839b21697cf0534be1f149a49
> Author: Chen-Yu Tsai <wenst@chromium.org>
> Date:   Fri May 26 15:35:37 2023 +0800
>
>     notifier: Initialize new struct srcu_usage field
>
>     In commit 95433f726301 ("srcu: Begin offloading srcu_struct fields to
>     srcu_update"), a new struct srcu_usage field was added, but was not
>     properly initialized. This led to a "spinlock bad magic" BUG when the
>     SRCU notifier was ever used. This was observed in the MediaTek CCI
>     devfreq driver on next-20230525. The trimmed stack trace is as follow=
s:
>
>         BUG: spinlock bad magic on CPU#4, swapper/0/1
>          lock: 0xffffff80ff529ac0, .magic: 00000000, .owner: <none>/-1, .=
owner_cpu: 0
>         Call trace:
>          spin_bug+0xa4/0xe8
>          do_raw_spin_lock+0xec/0x120
>          _raw_spin_lock_irqsave+0x78/0xb8
>          synchronize_srcu+0x3c/0x168
>          srcu_notifier_chain_unregister+0x5c/0xa0
>          cpufreq_unregister_notifier+0x94/0xe0
>          devfreq_passive_event_handler+0x7c/0x3e0
>          devfreq_remove_device+0x48/0xe8
>
>     Add __SRCU_USAGE_INIT() to SRCU_NOTIFIER_INIT() so that srcu_usage ge=
ts
>     initialized properly.
>
>     Fixes: 95433f726301 ("srcu: Begin offloading srcu_struct fields to sr=
cu_update")
>     Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>     Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
>     Cc: Matthias Brugger <matthias.bgg@gmail.com>
>     Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>     Cc: "Micha=C5=82 Miros=C5=82aw" <mirq-linux@rere.qmqm.pl>
>     Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>     Cc: Sachin Sant <sachinp@linux.ibm.com>
>     Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
>     Cc: Joel Fernandes (Google) <joel@joelfernandes.org
>     Cc: Jon Hunter <jonathanh@nvidia.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/include/linux/notifier.h b/include/linux/notifier.h
> index 2aba75145144..86544707236a 100644
> --- a/include/linux/notifier.h
> +++ b/include/linux/notifier.h
> @@ -106,12 +106,22 @@ extern void srcu_init_notifier_head(struct srcu_not=
ifier_head *nh);
>  #define RAW_NOTIFIER_INIT(name)        {                               \
>                 .head =3D NULL }
>
> +#ifdef CONFIG_TREE_SRCU
>  #define SRCU_NOTIFIER_INIT(name, pcpu)                         \
>         {                                                       \
>                 .mutex =3D __MUTEX_INITIALIZER(name.mutex),       \
>                 .head =3D NULL,                                   \
> +               .srcuu =3D __SRCU_USAGE_INIT(name.srcuu),         \
>                 .srcu =3D __SRCU_STRUCT_INIT(name.srcu, name.srcuu, pcpu)=
, \
>         }
> +#else
> +#define SRCU_NOTIFIER_INIT(name, pcpu)                         \
> +       {                                                       \
> +               .mutex =3D __MUTEX_INITIALIZER(name.mutex),       \
> +               .head =3D NULL,                                   \
> +               .srcu =3D __SRCU_STRUCT_INIT(name.srcu, name.srcuu, pcpu)=
, \
> +       }
> +#endif
>
>  #define ATOMIC_NOTIFIER_HEAD(name)                             \
>         struct atomic_notifier_head name =3D                      \
