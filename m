Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A86749725
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjGFINQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjGFINO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:13:14 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5464110
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 01:13:13 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a1c162cdfeso440509b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 01:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688631193; x=1691223193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgG4Ij8rmZfqMBm2oqM6Ju2PS6yYhcktMwLW4JNMQGU=;
        b=ebgLCz/pKdH6r29bkq3wNtiOBu92/5gohz0mqsiCkHyMfi9lqkaYS6l2h2dj3IY8IG
         uqi1S0meqlthR7q73+9Ph6hHlgauiN6eAQ7kzDWh+t9MlC8bm1LhP4UMaktOWBF5Nhp0
         B6rmppTNSLgqixTmuTcHUmerHy57ZJxJj7JtHA8Rp31qItNVGXrDkXwBLezXO6QA2Ym+
         c7Y0NNz4pfUqtskpVYMeY1xLimF7Vw6ukLPyzNIptcaF2r4EQKe7/n+A7fi1bfCoB7GA
         2QBjmjOo2mNeLd8ez3jgLlo7e7sV+9Ru+jOwHQMZvl0b2zDagYmSbWa1RfG8C2Ite883
         4pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688631193; x=1691223193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgG4Ij8rmZfqMBm2oqM6Ju2PS6yYhcktMwLW4JNMQGU=;
        b=j3c/2f6pCvHhGBIRtu8W9SFz7HWXCWNKS/hEtJDUk4uEFc7yCkwQ/Z9ePcq7psje1D
         p/mco/H9Cg9aYb5HgUDs9IqDi4j0A+elMFl2kQ2/+3mcyZuHibDnLuTTpYefuBwvfTMG
         yz/h1jqrFppKDzoHh4cZmddBCyDU18q25jq4vFpTbPyUxL6rN5re0bzVOEiZR2LIdpsG
         RhnQphOHnzGbfSt5nxy6OrxTq/qzyQWCaIMunsaVvxdqnXipKbZPnnDINsRDoBWvuh/U
         ptf+qsDFM89ny3fz6tpjOsxCnbeyjLzjEXNJuZFt8QpS9ItfINfo69mUEwDQ7NTM5BBv
         8/Rg==
X-Gm-Message-State: ABy/qLald9KT5NEBHjMshdDcQI4N16pdpo36aWNKnmDimmISGjLmYIoH
        kIZPzc1m6/OuzNdtdlVPXwlVJ4Wc/RUQ4JXw4eaxb0bvz9Q=
X-Google-Smtp-Source: APBJJlEAKaFoLQ8q7jFdrQL2wgxZy73QnBJRgt25CMlyiYgd/cJg7/tYNqZpKrm9uEMQbnYiLrnmzqj57EhTmxYtRCM=
X-Received: by 2002:aca:2b04:0:b0:3a3:6ae3:bd9 with SMTP id
 i4-20020aca2b04000000b003a36ae30bd9mr923814oik.55.1688631192886; Thu, 06 Jul
 2023 01:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221121035140.118651-1-zhouzhouyi@gmail.com> <efd3ac99-d406-fc45-60e1-73eb8bce4c67@csgroup.eu>
In-Reply-To: <efd3ac99-d406-fc45-60e1-73eb8bce4c67@csgroup.eu>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Thu, 6 Jul 2023 16:13:01 +0800
Message-ID: <CAABZP2x5H3VQXe3o+Q-ar-o2VO=yLap0WGA0JFWK+U2=rdH53A@mail.gmail.com>
Subject: Re: [PATCH linux-next][RFC]torture: avoid offline tick_do_timer_cpu
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023 at 3:09=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 21/11/2022 =C3=A0 04:51, Zhouyi Zhou a =C3=A9crit :
> > During CPU-hotplug torture (CONFIG_NO_HZ_FULL=3Dy), if we try to
> > offline tick_do_timer_cpu, the operation will fail because in
> > function tick_nohz_cpu_down:
> > ```
> > if (tick_nohz_full_running && tick_do_timer_cpu =3D=3D cpu)
> >        return -EBUSY;
> > ```
> > Above bug was first discovered in torture tests performed in PPC VM
> > of Open Source Lab of Oregon State University, and reproducable in RISC=
-V
> > and X86-64 (with additional kernel commandline cpu0_hotplug).
> >
> > In this patch, we avoid offline tick_do_timer_cpu by distribute
> > the offlining cpu among remaining cpus.
> >
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > ---
> >   include/linux/tick.h        |  1 +
> >   kernel/time/tick-common.c   |  1 +
> >   kernel/time/tick-internal.h |  1 -
> >   kernel/torture.c            | 10 ++++++++++
> >   4 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/tick.h b/include/linux/tick.h
> > index bfd571f18cfd..23cc0b205853 100644
> > --- a/include/linux/tick.h
> > +++ b/include/linux/tick.h
> > @@ -14,6 +14,7 @@
> >   #include <linux/rcupdate.h>
> >
> >   #ifdef CONFIG_GENERIC_CLOCKEVENTS
> > +extern int tick_do_timer_cpu __read_mostly;
> >   extern void __init tick_init(void);
> >   /* Should be core only, but ARM BL switcher requires it */
> >   extern void tick_suspend_local(void);
> > diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> > index 46789356f856..87b9b9afa320 100644
> > --- a/kernel/time/tick-common.c
> > +++ b/kernel/time/tick-common.c
> > @@ -48,6 +48,7 @@ ktime_t tick_next_period;
> >    *    procedure also covers cpu hotplug.
> >    */
> >   int tick_do_timer_cpu __read_mostly =3D TICK_DO_TIMER_BOOT;
> > +EXPORT_SYMBOL_GPL(tick_do_timer_cpu);
> >   #ifdef CONFIG_NO_HZ_FULL
> >   /*
> >    * tick_do_timer_boot_cpu indicates the boot CPU temporarily owns
> > diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
> > index 649f2b48e8f0..8953dca10fdd 100644
> > --- a/kernel/time/tick-internal.h
> > +++ b/kernel/time/tick-internal.h
> > @@ -15,7 +15,6 @@
> >
> >   DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
> >   extern ktime_t tick_next_period;
> > -extern int tick_do_timer_cpu __read_mostly;
> >
> >   extern void tick_setup_periodic(struct clock_event_device *dev, int b=
roadcast);
> >   extern void tick_handle_periodic(struct clock_event_device *dev);
> > diff --git a/kernel/torture.c b/kernel/torture.c
> > index 789aeb0e1159..bccbdd33dda2 100644
> > --- a/kernel/torture.c
> > +++ b/kernel/torture.c
> > @@ -33,6 +33,7 @@
> >   #include <linux/delay.h>
> >   #include <linux/stat.h>
> >   #include <linux/slab.h>
> > +#include <linux/tick.h>
> >   #include <linux/trace_clock.h>
> >   #include <linux/ktime.h>
> >   #include <asm/byteorder.h>
> > @@ -358,7 +359,16 @@ torture_onoff(void *arg)
> >                       schedule_timeout_interruptible(HZ / 10);
> >                       continue;
> >               }
> > +#ifdef CONFIG_NO_HZ_FULL
> > +             /* do not offline tick do timer cpu */
> > +             if (tick_nohz_full_running) {
>
> Can you use fonction tick_nohz_full_enabled() instead and avoid the #ifde=
f ?
Thank Christophe for your wonderful advice, I will follow your advice
next time I prepare a patch.
For this false positive report, 58d766824264 ("tick/nohz: Fix
cpu_is_hotpluggable() by checking with nohz subsystem") has beaten me
in mainline.

Thanks again
Zhouyi
>
> > +                     cpu =3D (torture_random(&rand) >> 4) % maxcpu;
> > +                     if (cpu >=3D tick_do_timer_cpu)
> > +                             cpu =3D (cpu + 1) % (maxcpu + 1);
> > +             } else
> > +#else
> >               cpu =3D (torture_random(&rand) >> 4) % (maxcpu + 1);
> > +#endif
> >               if (!torture_offline(cpu,
> >                                    &n_offline_attempts, &n_offline_succ=
esses,
> >                                    &sum_offline, &min_offline, &max_off=
line))
