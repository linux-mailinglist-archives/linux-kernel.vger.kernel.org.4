Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D757273F849
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjF0JIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjF0JIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:08:32 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDF92136
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 02:08:21 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b6a0d91e80so30362571fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 02:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1687856900; x=1690448900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stjT86fYKuiXvBaSB2WoO7+BJHVe758I2dhXd0cbDAY=;
        b=aCwv8XyJHIxBZ7JHg3Ta+tupjTY51coWUiGxvF+8zG4tycNrHZantd4GIiR/WcS3Qb
         CbVZRuCHlNjtORe1Kk4FgR5sMDgXXcHf9jz8shD6qo0bxGca2LYRGxplBVD5K8bGo/UG
         MWYAKhrWrXAszGh6QPpdw2hWo1YabMiri8ThqUHJMpBmip9CwF/iJUgqseSds5wf/m5R
         WdEOcTV3RNfMiVoT6Cqdo43CeTkP0QtPOA8q7nopsKwCm14ZSXD7XhFltpX+IcJ8DLVP
         Mb69xZL0ioOz+85DYEhWp/CwBnx9rjLqMl2EIAko1P/+XrJaouvShtYnQvB+mevwTHVq
         w/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687856900; x=1690448900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stjT86fYKuiXvBaSB2WoO7+BJHVe758I2dhXd0cbDAY=;
        b=IHrYUTpR+ZuVnm8Tk5nyKJsRNJ1Nis0dGy1qs7qqW5WiLmqItKxj20JcPsEmV8C+LJ
         CC9ChpsjA+9S44dG7qANskyVliUgWnZxl0SA9NJM67MOhx/vKO8ha+HbEDcm5OEHwVd9
         gxCr524zV6U8mqv+aMeKhTXVOh/i33l050GIvyTnhxFUDRmO1litQmqMgzef6gWqwsB2
         ZagRaMh5tanSkwg092YceKEJUkwNg//89CVknI18zT9ontRBXnP7IFt0dr89Mukza+xk
         L9u9Aosa8n2Bh4EcjTNMU1AxxhhayR2KHw8y1pjVunfIecLjuHMxfrV3ZThWSc2opT/u
         DgOg==
X-Gm-Message-State: AC+VfDzWcZhaaAlt03GA4TMMCWT4W7e3D2twuI257xTu0AzkNaSWkLs2
        aIyIMSLNXhLUyJ5eM8HjudpEmD2XmVVLIBH3efCJQw==
X-Google-Smtp-Source: ACHHUZ5BN9eKyi0r0qJ9h2elSHMi5KeDf7a+rpIa0hLeV58ADMjKts8uASQ2aziaU/7hkENIVNUMhtca7rKAg++nyAg=
X-Received: by 2002:a2e:6e16:0:b0:2b5:950a:711c with SMTP id
 j22-20020a2e6e16000000b002b5950a711cmr8404984ljc.10.1687856899530; Tue, 27
 Jun 2023 02:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230602094841.1225-1-eric.lin@sifive.com> <CAPqJEFpamQSbCcD0QJ16u7ctRf1=NYihod6gdZJfxFpE0YUVHQ@mail.gmail.com>
 <CABPqkBRyqsMnNbokBKepkWq1DtzfB0npXySGbKS1T3nQTwmaAw@mail.gmail.com> <20230621115811.GD2053369@hirez.programming.kicks-ass.net>
In-Reply-To: <20230621115811.GD2053369@hirez.programming.kicks-ass.net>
From:   Eric Lin <eric.lin@sifive.com>
Date:   Tue, 27 Jun 2023 17:08:07 +0800
Message-ID: <CAPqJEFpV8a8D7eA0sspjvThvBxdZhSLPTEbEzN7WiGCAzSnYYg@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Add pmu stop before unthrottling to prevent WARNING
To:     Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        palmer@dabbelt.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        greentime.hu@sifive.com, vincent.chen@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 01:58:11PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 20, 2023 at 11:18:05PM -0700, Stephane Eranian wrote:
> > On Tue, Jun 20, 2023 at 9:25=E2=80=AFPM Eric Lin <eric.lin@sifive.com> =
wrote:
> > >
> > > CC: Stephane Eranian
> > >
> > > On Fri, Jun 2, 2023 at 5:49=E2=80=AFPM Eric Lin <eric.lin@sifive.com>=
 wrote:
> > > >
> > > > Currently, during the perf sampling, if the perf interrupt takes to=
o long,
> > > > perf framework will lower the perf_event_max_sample_rate. This will=
 limit
> > > > the number of samples per timer tick (max_samples_per_tick) and set=
 hwc->interrupts
> > > > to MAX_INTERRUPTS within the __perf_event_account_interrupt() funct=
ion.
> > > >
> > > > Afterward, the perf framework will unthrottle the event in the time=
r interrupt
> > > > handler, which triggers the driver's *_pmu_start() function. Most o=
f the driver's
> > > > *_pmu_start() functions will check the event->hw.state to determine=
 whether this
> > > > event has stopped. If the event has not stopped, a WARN_ON_ONCE() w=
arning
> > > > will be triggered as shown below:
> > > >
> > > > [ 2110.224723] ------------[ cut here ]------------
> > > > [ 2110.224851] WARNING: CPU: 0 PID: 240 at drivers/perf/riscv_pmu.c=
:184 riscv_pmu_start+0x7c/0x8e
> > > > [ 2110.225242] Modules linked in:
> > > > [ 2110.225380] CPU: 0 PID: 240 Comm: ls Not tainted 6.4-rc4-g19d078=
8e9ef2 #1
> > > > [ 2110.225574] Hardware name: SiFive (DT)
> > > > [ 2110.225657] epc : riscv_pmu_start+0x7c/0x8e
> > > > [ 2110.225834]  ra : riscv_pmu_start+0x28/0x8e
> > > > [ 2110.225998] epc : ffffffff80aef864 ra : ffffffff80aef810 sp : ff=
ff8f80004db6f0
> > > > [ 2110.226135]  gp : ffffffff81c83750 tp : ffffaf80069f9bc0 t0 : ff=
ff8f80004db6c0
> > > > [ 2110.226245]  t1 : 0000000000000000 t2 : 000000000000001f s0 : ff=
ff8f80004db720
> > > > [ 2110.226367]  s1 : ffffaf8008ca1068 a0 : 0000ffffffffffff a1 : 00=
00000000000000
> > > > [ 2110.226488]  a2 : 0000000000000001 a3 : 0000000000000870 a4 : 00=
00000000000000
> > > > [ 2110.226605]  a5 : 0000000000000000 a6 : 0000000000000840 a7 : 00=
00000000000030
> > > > [ 2110.226721]  s2 : 0000000000000000 s3 : ffffaf8005165800 s4 : ff=
ffaf800424da00
> > > > [ 2110.226838]  s5 : ffffffffffffffff s6 : ffffffff81cc7590 s7 : 00=
00000000000000
> > > > [ 2110.226955]  s8 : 0000000000000006 s9 : 0000000000000001 s10: ff=
ffaf807efbc340
> > > > [ 2110.227064]  s11: ffffaf807efbbf00 t3 : ffffaf8006a16028 t4 : 00=
000000dbfbb796
> > > > [ 2110.227180]  t5 : 0000000700000000 t6 : ffffaf8005269870
> > > > [ 2110.227277] status: 0000000200000100 badaddr: 0000000000000000 c=
ause: 0000000000000003
> > > > [ 2110.227407] [<ffffffff80aef864>] riscv_pmu_start+0x7c/0x8e
> > > > [ 2110.227622] [<ffffffff80185b56>] perf_adjust_freq_unthr_context+=
0x15e/0x174
> > > > [ 2110.227961] [<ffffffff80188642>] perf_event_task_tick+0x88/0x9c
> > > > [ 2110.228235] [<ffffffff800626a8>] scheduler_tick+0xfe/0x27c
> > > > [ 2110.228463] [<ffffffff800b5640>] update_process_times+0x9a/0xba
> > > > [ 2110.228690] [<ffffffff800c5bd4>] tick_sched_handle+0x32/0x66
> > > > [ 2110.229007] [<ffffffff800c5e0c>] tick_sched_timer+0x64/0xb0
> > > > [ 2110.229253] [<ffffffff800b5e50>] __hrtimer_run_queues+0x156/0x2f=
4
> > > > [ 2110.229446] [<ffffffff800b6bdc>] hrtimer_interrupt+0xe2/0x1fe
> > > > [ 2110.229637] [<ffffffff80acc9e8>] riscv_timer_interrupt+0x38/0x42
> > > > [ 2110.229984] [<ffffffff80090a16>] handle_percpu_devid_irq+0x90/0x=
1d2
> > > > [ 2110.230162] [<ffffffff8008a9f4>] generic_handle_domain_irq+0x28/=
0x36
> > > >
> > > > To prevent this warning, we should call the driver's *_pmu_stop() f=
unction before unthrottling
> > > >
> > > > Signed-off-by: Eric Lin <eric.lin@sifive.com>
> > > > ---
> > > >  kernel/events/core.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > > index db016e418931..098c875abe88 100644
> > > > --- a/kernel/events/core.c
> > > > +++ b/kernel/events/core.c
> > > > @@ -4128,6 +4128,7 @@ perf_adjust_freq_unthr_context(struct perf_ev=
ent_context *ctx, bool unthrottle)
> > > >
> > > >                 if (hwc->interrupts =3D=3D MAX_INTERRUPTS) {
> > > >                         hwc->interrupts =3D 0;
> > > > +                       event->pmu->stop(event, 0);
> >
> > But how could the event have been stopped with a call to pmu->stop()
> > during throttling?
>
> Yeah, Changelog fails to explain how we got to the faulty state -- and
> without that we can't judge if the proposed solution actually fixes the
> problem or not.
>

Hi Stephane, Peter,

Most of the pmu driver will call *_pmu_stop(event,0) in the
*_pmu_handle_irq() function and update the hwc->state with
PERF_HES_STOPPED flag as below:

arch/alpha/kernel/perf_event.c:856:             if
(perf_event_overflow(event, &data, regs)) {
arch/alpha/kernel/perf_event.c-857-                     /* Interrupts
coming too quickly; "throttle" the
arch/alpha/kernel/perf_event.c-858-                      * counter,
i.e., disable it for a little while.
arch/alpha/kernel/perf_event.c-859-                      */
arch/alpha/kernel/perf_event.c-860-
alpha_pmu_stop(event, 0);
arch/alpha/kernel/perf_event.c-861-             }
-----
arch/arc/kernel/perf_event.c:603:                       if
(perf_event_overflow(event, &data, regs))
arch/arc/kernel/perf_event.c-604-
arc_pmu_stop(event, 0);
arch/arc/kernel/perf_event.c-605-               }
-----
arch/x86/events/amd/core.c:935:         if (perf_event_overflow(event,
&data, regs))
arch/x86/events/amd/core.c-936-                 x86_pmu_stop(event, 0);
arch/x86/events/amd/core.c-937- }
-----

However, some of the pmu drivers stop the event in the
*_pmu_handle_irq() without updating the hwc->state with
PERF_HES_STOPPED flag as below:

arch/arm/kernel/perf_event_v7.c:994:            if
(perf_event_overflow(event, &data, regs))
arch/arm/kernel/perf_event_v7.c-995-
cpu_pmu->disable(event); // <=3D=3D not update with PERF_HES_STOPPED
arch/arm/kernel/perf_event_v7.c-996-    }
------
arch/csky/kernel/perf_event.c:1142:             if
(perf_event_overflow(event, &data, regs))
arch/csky/kernel/perf_event.c-1143-
csky_pmu_stop_event(event); // <=3D=3D not update with PERF_HES_STOPPED
arch/csky/kernel/perf_event.c-1144-     }
-------
arch/loongarch/kernel/perf_event.c:492: if (perf_event_overflow(event,
data, regs))
arch/loongarch/kernel/perf_event.c-493-
loongarch_pmu_disable_event(idx);    // <=3D=3D not update with
PERF_HES_STOPPED
arch/loongarch/kernel/perf_event.c-494-}
-------
arch/mips/kernel/perf_event_mipsxx.c:794:       if
(perf_event_overflow(event, data, regs))
arch/mips/kernel/perf_event_mipsxx.c-795-
mipsxx_pmu_disable_event(idx); // <=3D=3D not update with PERF_HES_STOPPED
arch/mips/kernel/perf_event_mipsxx.c-796-}
....

Furthermore, these drivers did not add event->hw.state checking in
*_pmu_start() before starting the event like x86 does:

1497 static void x86_pmu_start(struct perf_event *event, int flags)
1498 {
1499     struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
1500     int idx =3D event->hw.idx;
1501
1502     if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
1503         return;
1504

As a result, these drivers won't trigger the WARN_ON_ONCE warning as
shown in this patch.

However, if a pmu driver like RISC-V pmu which didn't call
*_pmu_stop(event,0) without updating the hwc->state with
PERF_HES_STOPPED flag in the *_pmu_handle_irq() function
but has event->hw.state checking in *_pmu_start(), it could trigger
the WARN_ON_ONCE warning as shown in this patch.

Therefore, I think we need to call pmu->stop() before unthrottling the
event to prevent this warning.

Or maybe we can add hwc->state checking before we call pmu->stop() as below=
:

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4128,7 +4128,8 @@ perf_adjust_freq_unthr_context(struct
perf_event_context *ctx, bool unthrottle)

                if (hwc->interrupts =3D=3D MAX_INTERRUPTS) {
                        hwc->interrupts =3D 0;
-                       event->pmu->stop(event, 0);
+                       if (!(hwc->state & PERF_HES_STOPPED))
+                               event->pmu->stop(event, 0);
                        perf_log_throttle(event, 1);
                        event->pmu->start(event, 0);
                }

Thanks.

Best Regards,
Eric Lin.


> > >
> > > >                         perf_log_throttle(event, 1);
> > > >                         event->pmu->start(event, 0);
> > > >                 }
> > > > --
> > > > 2.17.1
> > > >
