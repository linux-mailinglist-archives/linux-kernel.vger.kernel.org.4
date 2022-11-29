Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD53663C658
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbiK2RWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbiK2RWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:22:34 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A820C6C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:22:33 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id m7-20020a9d6447000000b0066da0504b5eso9525742otl.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ERzS4U2j7MTY+q0b6hybFjdEdU2YsUOeh9tkV6tQ7R8=;
        b=P68pHJx/xDGYU19tBbtmlh8dH2BZ4O1B8pO10i2goAlNMAaQ54qSn0jtNJ1sIg9Aj1
         Q9R6vEb91togZPOme6eJRs5dz6XBeE8Dzass+tIHqztTEHyxk0bIiC53v1Tt1CY+srYZ
         i6QPA8GTjjQ5XG9/j5tHAcWF6cdU/KNQ6sYXua/r/ARkT6b2PYtXl3ZeNIHFTdLGfufK
         5Ta5ta0fmTaV5U6lr7Xu/9EZ8IfqvmcM1s4l1Melm5rF6wmjZrv7Ka/h5MVX+D6mMkFy
         SH9UD7+S4bAlBYT8GS8QlFUhZox5kO+vq58DXuB7IF72XF/FV1+QBexFmISXFyu5LzEG
         nWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERzS4U2j7MTY+q0b6hybFjdEdU2YsUOeh9tkV6tQ7R8=;
        b=jYuYRYolDiRFkg8AoUKCgWWWTMiMQnRbePm6usnu11wVrdi9ZXS/NQ0iy+3HTtY3BH
         z4ODp7n3T5ZLDrX//2AVnCwi+p45uqmeOe7toEuz1eiEGoRLx7URpOudON3n4uN/ELSy
         4X1t5Lp76gXegr5I0BOOrmS33Ou5LxlHtRWIb94C6oyfkopd3K7r118PmlHoNGMAhCfw
         1Po2ULpKDGVUz7kNmP+9oSbzqJWGOuWMpaDR6RSgTzD/tTcA0wM98Ks8DrSG2YXHD71v
         IBtS+7ww1IpTRM8mBwzS9bsNSDAna3gDzniXR/2LWzBhq6IDuHaM05WD0Uc38r5KiS6J
         FKRg==
X-Gm-Message-State: ANoB5pnyhKajnCtwiIueB+9M17rvkLUZ3phiESFo8M5l/CY0i7LEZDmf
        drCoX0hrUykwAgsyyxBidCXHR+p8tHXq0a7wh3VSCQ==
X-Google-Smtp-Source: AA0mqf5CWImQG2jZGF4VQvkIetPlLOql83+imxUC6Tcb57B0VvferIBl3sP6CqUAMmLR+kzm9Cm3iIBaqBt6oKZvJ5g=
X-Received: by 2002:a9d:5e0f:0:b0:662:2458:3ef7 with SMTP id
 d15-20020a9d5e0f000000b0066224583ef7mr28862254oti.150.1669742552546; Tue, 29
 Nov 2022 09:22:32 -0800 (PST)
MIME-Version: 1.0
References: <20221129140313.886192-1-apatel@ventanamicro.com>
 <20221129140313.886192-4-apatel@ventanamicro.com> <Y4YY6kBBEBdZoUIp@wendy>
 <CAAhSdy3dWGVV=jh5mzK=m63A3UAqwJhxidcAZQU_WC4TRNfCjQ@mail.gmail.com> <Y4Y+vZ7qndV2c5Ai@spud>
In-Reply-To: <Y4Y+vZ7qndV2c5Ai@spud>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 29 Nov 2022 22:52:22 +0530
Message-ID: <CAK9=C2VtgCOk9S_FucJbwsG+nMuBqEsFk3sAMt7_doAKsMHQ8w@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] clocksource: timer-riscv: Set CLOCK_EVT_FEAT_C3STOP
 based on DT
To:     Conor Dooley <conor@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 10:47 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Tue, Nov 29, 2022 at 10:41:09PM +0530, Anup Patel wrote:
> > On Tue, Nov 29, 2022 at 8:06 PM Conor Dooley <conor.dooley@microchip.com> wrote:
> > >
> > > On Tue, Nov 29, 2022 at 07:33:13PM +0530, Anup Patel wrote:
> > > > We should set CLOCK_EVT_FEAT_C3STOP for a clock_event_device only
> > > > when riscv,timer-cant-wake-up DT property is present in the RISC-V
> > > > timer DT node.
> > > >
> > > > This way CLOCK_EVT_FEAT_C3STOP feature is set for clock_event_device
> > > > based on RISC-V platform capabilities rather than having it set for
> > > > all RISC-V platforms.
> > > >
> > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > >
> > > I thought I had left an R-b on this one?
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > >
> > > Also, I think that we need to backport *something* that disables C3STOP
> > > which is why I had suggested keeping the revert in place.
> > > Patch 1 of this series only solves the timer issues but does not restore
> > > sleep states to their prior behaviour, right?
> > > Either this patch or the revert needs to go to stable IMO.
> >
> > Since it works for you with the C3STOP set and broadcast timer enabled,
> > we can directly go with this patch. I am fine including the revert as well.
>
> I don't mind which gets backported. To me, this one is preferable as it
> is more "complete" but it is a bit on the new feature side of things,
> no?
>
> Whoever applies it can decide, and I'll backport the revert if they
> decide that this patch is not stable material :)
>
> Thanks again for helping sort this mess out, I see it helped with your
> IPI series too!

Yes, I was surprised to see that it helped the IPI series as well.
Thanks for your patch.

Regards,
Anup

>
> Conor.
>
> > > > ---
> > > >  drivers/clocksource/timer-riscv.c | 12 +++++++++++-
> > > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> > > > index 969a552da8d2..0c8bdd168a45 100644
> > > > --- a/drivers/clocksource/timer-riscv.c
> > > > +++ b/drivers/clocksource/timer-riscv.c
> > > > @@ -28,6 +28,7 @@
> > > >  #include <asm/timex.h>
> > > >
> > > >  static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
> > > > +static bool riscv_timer_cant_wake_cpu;
> > > >
> > > >  static int riscv_clock_next_event(unsigned long delta,
> > > >               struct clock_event_device *ce)
> > > > @@ -51,7 +52,7 @@ static int riscv_clock_next_event(unsigned long delta,
> > > >  static unsigned int riscv_clock_event_irq;
> > > >  static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
> > > >       .name                   = "riscv_timer_clockevent",
> > > > -     .features               = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP,
> > > > +     .features               = CLOCK_EVT_FEAT_ONESHOT,
> > > >       .rating                 = 100,
> > > >       .set_next_event         = riscv_clock_next_event,
> > > >  };
> > > > @@ -85,6 +86,8 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
> > > >
> > > >       ce->cpumask = cpumask_of(cpu);
> > > >       ce->irq = riscv_clock_event_irq;
> > > > +     if (riscv_timer_cant_wake_cpu)
> > > > +             ce->features |= CLOCK_EVT_FEAT_C3STOP;
> > > >       clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
> > > >
> > > >       enable_percpu_irq(riscv_clock_event_irq,
> > > > @@ -139,6 +142,13 @@ static int __init riscv_timer_init_dt(struct device_node *n)
> > > >       if (cpuid != smp_processor_id())
> > > >               return 0;
> > > >
> > > > +     child = of_find_compatible_node(NULL, NULL, "riscv,timer");
> > > > +     if (child) {
> > > > +             riscv_timer_cant_wake_cpu = of_property_read_bool(child,
> > > > +                                             "riscv,timer-cant-wake-cpu");
> > > > +             of_node_put(child);
> > > > +     }
> > > > +
> > > >       domain = NULL;
> > > >       child = of_get_compatible_child(n, "riscv,cpu-intc");
> > > >       if (!child) {
> > > > --
> > > > 2.34.1
> > > >
