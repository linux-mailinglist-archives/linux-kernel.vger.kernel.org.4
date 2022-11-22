Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B028C6334BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 06:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiKVFga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 00:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiKVFg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 00:36:28 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308631DDF6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 21:36:27 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id l42-20020a9d1b2d000000b0066c6366fbc3so8681475otl.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 21:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i5qyeYsVmx6XhfZt4paEL95PnVohNk27++knFv/BVmU=;
        b=KN63+OhwilsyWIs3Ix3N08+28icP335y7QajHdzDMB50KfNfdj7civnR0ceKzd2jJH
         JHSud1kQ9O3GDRtMVBGG5jN1CaoMhvqljkwnpJ9496AwKSTZLWEq286LHFy+Zn3NLLHy
         oUOyD1Awx+2wbbiyeWbyaRyB/WLstJt5KjjQ6xcZV+LJPzOVUjg7O+pxrpGoKLFz20db
         oOve+lxyeTYSrl0ZfrsA+uSyB4EI5IG+m6x+7MmPtKBBw8k3qcm2BaBNOzbEDbatx6T2
         f2Hw4I9rt6u4MuvebLwfuxLO5knV9nK1wHqExaw4Kt4254XSny/4iOWmRqj03X+0tJf1
         i/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i5qyeYsVmx6XhfZt4paEL95PnVohNk27++knFv/BVmU=;
        b=4dI7jUwsAfVEiRVIwZg3j8ZtpyVp5BDZr4cNksu3Cued5iFVyB0Cfsj87eFtqtIyW8
         dxdlQ6eCxsj8XiCPA6NSYBoPBVZGaEgfKJ7g3TXWekCbnusHPBT69yYFh+b6RHPfIWfl
         lZnPbNsXWvePpuUvBALH6+CX0T+t+9eYZ7lOf7qXX7WSa6l67SbMdT/WXHFHVZGNoruU
         OPw6jRCoxlEA51BRHXC/M7TFfU929MWGgCkSVosibH09zBtyqzfdEFSxARfXIJLvSqO3
         ypo4ZEls4l3E1nLnn4Sq7Sh5iY8QKNWwOzR3TQtRNgw2Ge28z69cUewnC0vgQfEmqc+A
         6Gug==
X-Gm-Message-State: ANoB5pmZx8GL7I/aXH+lt/rLblKGLKR0C1O5Qa8FvaONwvmGhJmuUauT
        ic50Pwuj/CtxVV8RHkTTd9VzED8ZfPigS9kDAQ1nJQ==
X-Google-Smtp-Source: AA0mqf4SqsUgk4Ll2Vp6cdBMpsPY2pdXBHEOaPLJ82EcWt0/XAv2Ftta9n6K6Eo4FFzvuW+VaDb9RFommyqDRkve6Sw=
X-Received: by 2002:a9d:5e0f:0:b0:662:2458:3ef7 with SMTP id
 d15-20020a9d5e0f000000b0066224583ef7mr11466185oti.150.1669095386364; Mon, 21
 Nov 2022 21:36:26 -0800 (PST)
MIME-Version: 1.0
References: <CAAhSdy0Fs9ZVoRgtz92RgLnFPvgwUzCP_KpK9SCOiVsA-t3p3Q@mail.gmail.com>
 <mhng-3f44cc1f-7305-41c5-a1cf-dfed096bd364@palmer-ri-x1c9>
In-Reply-To: <mhng-3f44cc1f-7305-41c5-a1cf-dfed096bd364@palmer-ri-x1c9>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 22 Nov 2022 11:06:15 +0530
Message-ID: <CAK9=C2USZHdfBQrrgd2Rs3u3_gTyscpRgxvPU5P6ptOPu1+Axg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Stop using non-retentive suspend
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     anup@brainfault.org, Conor Dooley <conor@kernel.org>,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 10:46 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> On Mon, 21 Nov 2022 19:45:07 PST (-0800), anup@brainfault.org wrote:
> > On Tue, Nov 22, 2022 at 2:27 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
> >>
> >> From: Palmer Dabbelt <palmer@rivosinc.com>
> >>
> >> As per [1], whether or not the core can wake up from non-retentive
> >> suspend is a platform-specific detail.  We don't have any way to encode
> >> that, so just stop using them until we've sorted that out.
> >>
> >> Link: https://github.com/riscv-non-isa/riscv-sbi-doc/issues/98#issuecomment-1288564687
> >> Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
> >> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> >
> > This is just unnecessary maintenance churn and it's not the
> > right way to go. Better to fix this the right way instead of having
> > a temporary fix.
> >
> > I had already sent-out a patch series 5 months back to describe
> > this in DT:
> > https://lore.kernel.org/lkml/20220727114302.302201-1-apatel@ventanamicro.com/
> >
> > No one has commented/suggested anything (except Samuel
> > Holland and Sudeep Holla).
>
> I see some comments from Krzysztof here
> <https://lore.kernel.org/lkml/7a0477a0-9f0f-87d6-4070-30321745f4cc@linaro.org/>
> as well.  Looks like everyone is pointing out that having our CPU nodes
> encode timers is a bad idea, my guess is that they're probably right.

Adding a separate timer DT node, creates a new set of compatibility
issues for existing platforms. I am fine updating my series to have
separate timer DT node but do we want to go in this direction ?

Even if ARM has a separate timer DT node, the timers are still part
of the CPU. It depends on how we see the DT bindings aligning with
actual HW.

>
> > Please review this series. I can quickly address comments to
> > make this available for Linux-6.2. Until this series is merged,
> > the affected platforms can simply remove non-retentive suspend
> > states from their DT.
>
> That leaves us with a dependency between kernel versions and DT
> bindings: kernels with the current driver will result in broken systems
> with the non-retentive suspend states in the DT they boot with when
> those states can't wake up the CPU.

This is not a new problem we are facing. Even in the ARM world,
the DT bindings grew organically over time based on newer platform
requirements.

Now that we have a platform which does not want the time
C3STOP feature, we need to first come-up with DT bindings
to support this platform instead of temporarily disabling
features which don't work on this platform.

Regards,
Anup

>
> > With all due respect, NACK to this patch from my side.
> >
> > Regards,
> > Anup
> >
> >>
> >> ---
> >>
> >> This should allow us to revert 232ccac1bd9b ("clocksource/drivers/riscv:
> >> Events are stopped during CPU suspend"), which fixes suspend on the D1
> >> but breaks timers everywhere.
> >> ---
> >>  drivers/cpuidle/cpuidle-riscv-sbi.c | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
> >> index 05fe2902df9a..9d1063a54495 100644
> >> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> >> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> >> @@ -214,6 +214,17 @@ static bool sbi_suspend_state_is_valid(u32 state)
> >>         if (state > SBI_HSM_SUSPEND_NON_RET_DEFAULT &&
> >>             state < SBI_HSM_SUSPEND_NON_RET_PLATFORM)
> >>                 return false;
> >> +
> >> +       /*
> >> +        * Whether or not RISC-V systems deliver interrupts to harts in a
> >> +        * non-retentive suspend state is a platform-specific detail.  This can
> >> +        * leave the hart unable to wake up, so just mark these states as
> >> +        * unsupported until we have a mechanism to expose these
> >> +        * platform-specific details to Linux.
> >> +        */
> >> +       if (state & SBI_HSM_SUSP_NON_RET_BIT)
> >> +               return false;
> >> +
> >>         return true;
> >>  }
> >>
> >> --
> >> 2.38.1
> >>
