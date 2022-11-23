Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734CC634F9D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 06:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbiKWFfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 00:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiKWFfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 00:35:46 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D08F1D88
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 21:35:44 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-142306beb9aso19695915fac.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 21:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UyGDSFNUaTTEMKnKYZB8pKfyRedwZJqPE2HT6gVc/Kc=;
        b=KQd4DuUvWugD0Onfs4QqsG8DlIi7orLmAM4hRS6DW3XVAAgaxTaLxMTHH3QPbfGZBr
         Wl8Guue9wicxRCtmBcga0sdF5H8AiJAZ/1iv14bRC7krTG7MfRGeqMimpWkGvIcaZxIf
         IDgUTAnjTyZ3b+bdS9k7LuS3BIiXjtygZTIrT0mV1xCSoW6ID32Ypat0wyB3LXsw5SGN
         6z+AXVNYftDiywPGDJOdsephRxG8usUSznAs7TyTcTVXdTlFuT2aDcXB9qoKOil7vxsJ
         iXtKIz+NbRtW6tsU3g7rxbcCjUo3PqaZ0QftncV4ijEZ0L8d/abCFtDGy8dclK//U7lB
         k8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UyGDSFNUaTTEMKnKYZB8pKfyRedwZJqPE2HT6gVc/Kc=;
        b=vajsVZ9dJTtme3WVeyqqqGFTAlSgJ5SKlb0wlGo/E4bBywSELemwqfmiRPoYlbcm21
         8F2IPCdBsPvzxPteNXtf3HU6nz17rbnnBfqfvcOUX2rWSIRgH/9tQClem8s3pnU7lj+6
         ksIbutzJJMOWCW89jRzHsdKVVLPw/83bkG5wiaKZJyTTWr6gr8gitBwRONh8zr7zMpPQ
         C+5HKJZV747BGy1vMICtG2kkBvDG5YIagH5zhw5OqGCCAtBb518A5BZvOfkMr0aKw9se
         hoS3oZljbDbanctkW9xtkR5MZ++d2U3jMe5QpngzetGthvFVsRKQenUk+3zABtIi/XEh
         yrmQ==
X-Gm-Message-State: ANoB5pkh6cw8z+vI0id+Y2C5h5H5Buvh9EnmtFcRrBBTLzSE+vZZm0Qe
        JO01g8ttpz7i/kcOSU0c0Lg0eNR5V0n9FYGCAGJUQw==
X-Google-Smtp-Source: AA0mqf6lc+iP+7Sak7isl2cm4qkptP9US+fAqELAR+6pilz9PEqebvaPt65jIiJQ6kEsqhJ+LvfMaRZt1NdGg6x6NqQ=
X-Received: by 2002:a05:6870:3b0a:b0:142:ff0f:3db with SMTP id
 gh10-20020a0568703b0a00b00142ff0f03dbmr4962571oab.17.1669181743154; Tue, 22
 Nov 2022 21:35:43 -0800 (PST)
MIME-Version: 1.0
References: <mhng-6299f108-11af-4e70-9981-d7e7b3be0b9a@palmer-ri-x1c9> <57114829-c205-dece-abdb-1100947286d4@sholland.org>
In-Reply-To: <57114829-c205-dece-abdb-1100947286d4@sholland.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 23 Nov 2022 11:05:32 +0530
Message-ID: <CAK9=C2WLOa_zgboFE5UCgnwMB-kbWMAVtmXsBxoswqY63-5QHw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Stop using non-retentive suspend
To:     Samuel Holland <samuel@sholland.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, conor.dooley@microchip.com,
        anup@brainfault.org, Conor Dooley <conor@kernel.org>,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
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

On Wed, Nov 23, 2022 at 10:41 AM Samuel Holland <samuel@sholland.org> wrote:
>
> Hi Palmer,
>
> On 11/22/22 09:28, Palmer Dabbelt wrote:
> > On Tue, 22 Nov 2022 03:19:43 PST (-0800), conor.dooley@microchip.com wrote:
> >> On Tue, Nov 22, 2022 at 11:06:15AM +0530, Anup Patel wrote:
> >>> On Tue, Nov 22, 2022 at 10:46 AM Palmer Dabbelt <palmer@rivosinc.com>
> >>> wrote:
> >>> >
> >>> > On Mon, 21 Nov 2022 19:45:07 PST (-0800), anup@brainfault.org wrote:
> >>> > > On Tue, Nov 22, 2022 at 2:27 AM Palmer Dabbelt
> >>> <palmer@rivosinc.com> wrote:
> >>> > >>
> >>> > >> From: Palmer Dabbelt <palmer@rivosinc.com>
> >>> > >>
> >>> > >> As per [1], whether or not the core can wake up from non-retentive
> >>> > >> suspend is a platform-specific detail.  We don't have any way to
> >>> encode
> >>> > >> that, so just stop using them until we've sorted that out.
> >>> > >>
> >>> > >> Link:
> >>> https://github.com/riscv-non-isa/riscv-sbi-doc/issues/98#issuecomment-1288564687
> >>> > >> Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
> >>> > >> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> >>> > >
> >>> > > This is just unnecessary maintenance churn and it's not the
> >>> > > right way to go. Better to fix this the right way instead of having
> >>> > > a temporary fix.
> >>> > >
> >>> > > I had already sent-out a patch series 5 months back to describe
> >>> > > this in DT:
> >>> > >
> >>> https://lore.kernel.org/lkml/20220727114302.302201-1-apatel@ventanamicro.com/
> >>> > >
> >>> > > No one has commented/suggested anything (except Samuel
> >>> > > Holland and Sudeep Holla).
> >>> >
> >>> > I see some comments from Krzysztof here
> >>> >
> >>> <https://lore.kernel.org/lkml/7a0477a0-9f0f-87d6-4070-30321745f4cc@linaro.org/>
> >>> > as well.  Looks like everyone is pointing out that having our CPU
> >>> nodes
> >>> > encode timers is a bad idea, my guess is that they're probably right.
> >>>
> >>> Adding a separate timer DT node, creates a new set of compatibility
> >>> issues for existing platforms. I am fine updating my series to have
> >>> separate timer DT node but do we want to go in this direction ?
> >>
> >> I don't really follow. How is there a compatibility issue created by
> >> adding a new node that is not added for a new property? Both will
> >> require changes to the device tree. (You need not reply here, I am going
> >> to review the other thread, it's been on my todo list for too long. Been
> >> caught up with non-coherent stuff & our sw release cycle..)
> >>
> >>> Even if ARM has a separate timer DT node, the timers are still part
> >>> of the CPU. It depends on how we see the DT bindings aligning with
> >>> actual HW.
> >>>
> >>> >
> >>> > > Please review this series. I can quickly address comments to
> >>> > > make this available for Linux-6.2. Until this series is merged,
> >>> > > the affected platforms can simply remove non-retentive suspend
> >>> > > states from their DT.
> >>> >
> >>> > That leaves us with a dependency between kernel versions and DT
> >>> > bindings: kernels with the current driver will result in broken
> >>> systems
> >>> > with the non-retentive suspend states in the DT they boot with when
> >>> > those states can't wake up the CPU.
> >>
> >> Can someone point me at a (non D1 or virt) system that has suspend
> >> states in the DT that would need fixing?
> >>
> >>> This is not a new problem we are facing. Even in the ARM world,
> >>> the DT bindings grew organically over time based on newer platform
> >>> requirements.
> >>>
> >>> Now that we have a platform which does not want the time
> >>> C3STOP feature, we need to first come-up with DT bindings
> >>> to support this platform instead of temporarily disabling
> >>> features which don't work on this platform.
> >>
> >> It's the opposite surely? It should be "now that we have a platform that
> >> *does want* the C3STOP feature", right?
> >
> > IMO we just shouldn't be turning on C3STOP at all.  Sure it's making the
> > problem here go away, but it's trying to emulate a bunch of Intel timer
> > features we don't have on RISC-V and ending up in a bunch of fallback
> > paths.
>
> While the comment in include/linux/clockchips.h and the name of the flag
> imply that C3STOP is Intel-specific, it really isn't. The flag is used
> on ARM, MIPS, and PowerPC as well.
>
> However we do it, the end goal here is making tick_broadcast_enter()
> return nonzero (when called from inside cpuidle_enter_state()), thus
> inhibiting Linux from using idle states with the "local-timer-stop"
> property set in the DT.
>
> Looking down inside tick_broadcast_oneshot_control(), it appears
> CLOCK_EVT_FEAT_C3STOP really is required to make this happen.
>
> What are you referring to by "fallback paths"?
>
> We could add another CLOCK_EVT_FEAT_??? flag, but how should it differ
> from CLOCK_EVT_FEAT_C3STOP?
>
> > If we need some workaround in the timer subsystem to sort out the
> > non-retentive states then we can sort that out, but my guess is that
> > vendors are just going to 3
>
> (your message got cut off here)
>
> >>> > > With all due respect, NACK to this patch from my side.
> >>
> >> As Samuel pointed out that the D1 doesn't actually use the timer in
> >> question, I think we are okay here?
> >
> > IIUC it just should use the sunxi timer driver, but that requires some
> > priority changes (and presumably breaks
>
> (and here too)
>
> D1 currently uses sun4i_tick (rating 350) over riscv_timer_clockevent
> (rating 100). The ratings are fine as is.
>
> > That said, I guess I'm confused about what's actually broken here.  My
> > understanding of the problem is: The D1's firmware disables some
> > interrupts during non-retentive suspend, which results in SBI timers
> > failing to wake up the core.
>
> The D1's hardware cannot deliver the RISC-V architectural timer
> interrupt while the C906 core is powered off. It cannot deliver the
> RISC-V architectural external interrupt either, but the SoC provides a
> side channel for all of the PLIC inputs, so they _can_ wake up the CPU.
> So the net result is that the CLINT is the only peripheral unable to
> wake the CPU.
>
> > The patch to add C3STOP makes the core
> > come back from sleep, but that results in a bunch of other timer-related
> > issues.
>
> No, C3STOP _inhibits_ Linux from entering idle states that both:
>  1) rely on that clockevent device to wake the local CPU, and
>  2) cause that clockevent device to stop working, as signified by the
>     CPUIDLE_FLAG_TIMER_STOP flag, which is set by the local-timer-stop
>     property in the idle state DT node.
>
> That means entering the idle state is allowed if Linux can solve that
> first condition by finding another clockevent device on some other CPU
> to wake the local CPU with an IPI. That is the purpose of the broadcast
> timer mechanism.
>
> In the case of the D1, since it is single core, there is no other CPU to
> broadcast a timer event. So if riscv_timer_clockevent is the only
> clockevent device, then tick_broadcast_enter() should return nonzero,
> and find_deepest_state() will pick a retentive idle state instead.
>
> This is the already-existing mechanism for only entering idle states we
> can reliably wake up from. :)
>
> > So IMO we should revert the C3STOP patch as it's causing regressions
>
> I agree that clearly something is going wrong in the Linux code to cause
> problems on SMP systems like PolarFire. I do not really understand the
> broadcast timer internals, but what I do know is:
>  1) By setting CLOCK_EVT_FEAT_C3STOP, we inhibit the RISC-V timer from
>     being used as the broadcast timer (tick_check_broadcast_device()),
>     and IIUC fall back to kernel/time/tick-broadcast-hrtimer.c. Maybe
>     something goes wrong there?
>  2) The broadcast timer wakes up CPUs via IPIs. Maybe something goes
>     wrong with IPI delivery? (This raises the question of if we need
>     another DT property for receiving IPIs in non-retentive suspend.)
>
> But neither of these should affect behavior when not using broadcast timers.
>
> > (ie, old workloads break in order to make new ones work).  Seems like
> > folks mostly agree on that one?
>
> Well, for the D1 specifically, there is no new workload that the C3STOP
> patch makes work. Non-retentive suspend worked there already, as I have
> explained. The patch was always about being compliant to the spec.
>
> > I also think we should stop entering non-retentive suspend until we can
> > sort out how reliably wake up from it, as the SBI makes that a
> > platform-specific detail.  If the answer there is "non-retentive suspend
> > is fine on the D1 as long as we don't use the SBI timers" then that
> > seems fine, we just need some way to describe that in Linux -- that
> > doesn't fix other platforms and other interrupts, but at least it's a
> > start.
>
> We need some way to describe the situation from the SBI implementation
> to Linux.
>
> Non-retentive suspend is fine on the D1 as long as either one of these
> conditions is met:
>  1) we don't use the SBI timers, or
>  2) the SBI timer implementation does not use the CLINT
>
> And it is up to the SBI implementation which timer hardware it uses, so
> the SBI implementation needs to patch this information in to the DT at
> runtime.

Rather than SBI implementation patching information in DT, it is much
simpler to add a quirk in RISC-V timer driver for D1 platform (i.e. based
on D1 compatible string in root node).

Regards,
Anup
