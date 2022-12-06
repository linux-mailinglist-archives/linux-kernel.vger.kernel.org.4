Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB169644E4F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 23:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiLFWDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 17:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiLFWDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 17:03:19 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA24D36C61;
        Tue,  6 Dec 2022 14:03:17 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id n21so9644634ejb.9;
        Tue, 06 Dec 2022 14:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1yIUVOdh+m3Dcu9OS+dIGaj9snCyPCPz+jQsInm3lVA=;
        b=fj+mMyzKgo1mb4RVbihyunopfeH48INBzqzhUoAqeUand973K6fikqQ/4UY4BIshIz
         BPSc2GE6YHZ9vmTlXVW/lLmbNN9LLuOX2mNUP1sPzMEja1GNI7qoudEilbfpKbL2fUTW
         yGgNax8Im6VcKpDsJW/kt2U64HTaQ0hEwi7npvxfpk6QEraQuPK4g2wHdZ2n5BHKSz9v
         WEdMsKqqGi7YcSFXhO7ckyc/9Hh3fAU/jtHQTzjh7bsp52AbLK7Xda+XXI03SFuZj+ic
         3ho4DpdfmtuCixZ6NLsWYjAlXbKiUF3A1OR9/E+DW/LtHnGorpVoK/5NxfrYk10OjfAE
         ZNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1yIUVOdh+m3Dcu9OS+dIGaj9snCyPCPz+jQsInm3lVA=;
        b=tqGa6K2KhVDoDKmci2puWTMRgqOGskP6Tcn+wxRk4SKiE9dtc6yUmT/VvrYbFYOB/H
         1z0Q/j2e46uTUTsyFwovVfxAt80lClF86UHWuJAbS2rXuYnv35ZIFRYzDcrneesQdn8l
         4qUsYQavVkovOAsHNfM6rc2+0/vYb6MLINSnK6Yz1fhXfKgDNcqQpvTDWGF2PbW665OZ
         /GR5xim9K6ywx25Y99YEVL18ECptYuxZHJkOq6nd5stQilmLHmOBlF5vqn4RSKn3Whw7
         ATxJaM3vzxfICdx3vHAi/78OfM7lc3H8vPXHTnrupFoHJGDOXvPhj+ONHtU9h6Hv+8IQ
         VFig==
X-Gm-Message-State: ANoB5pk1gJfn8PkQ9tK9sScVDjflyqiYL6mm52US3owEbZxZm3+qhIjd
        u/xtngdAWINby+2p3aAcOdmOk9aZ2uZlAmE5vKw=
X-Google-Smtp-Source: AA0mqf5GVsDkQt6G7Fo6+AxKAVUtqu8r2WD58xz9D2NRSSDU48e1GdP+G1fa5IRFLAvU1tEuXTVuWRgbkn9T8CXHFsM=
X-Received: by 2002:a17:906:2793:b0:7c1:174f:d69 with SMTP id
 j19-20020a170906279300b007c1174f0d69mr2191990ejc.447.1670364196158; Tue, 06
 Dec 2022 14:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20221201123954.1111603-1-apatel@ventanamicro.com>
 <20221201123954.1111603-4-apatel@ventanamicro.com> <20221202000603.GA1720201-robh@kernel.org>
 <CAK9=C2VbM+CP0Y9Xx-SM9O4TFrQmOKvVWy-u5mxdPxrhacK4JQ@mail.gmail.com> <Y40ueQiTZK6hi7RS@spud>
In-Reply-To: <Y40ueQiTZK6hi7RS@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 6 Dec 2022 22:02:49 +0000
Message-ID: <CA+V-a8vvS+0H8vv9AnifMzSoBMiOj3g4XBXcMjo-jcD__CaNCQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] clocksource: timer-riscv: Set CLOCK_EVT_FEAT_C3STOP
 based on DT
To:     Conor Dooley <conor@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Sun, Dec 4, 2022 at 11:34 PM Conor Dooley <conor@kernel.org> wrote:
>
> Hey Rob, Anup, Prabhakar,
>
> On Fri, Dec 02, 2022 at 12:03:05PM +0530, Anup Patel wrote:
> > On Fri, Dec 2, 2022 at 5:36 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Thu, Dec 01, 2022 at 06:09:54PM +0530, Anup Patel wrote:
> > > > We should set CLOCK_EVT_FEAT_C3STOP for a clock_event_device only
> > > > when riscv,timer-cannot-wake-cpu DT property is present in the RISC-V
> > > > timer DT node.
> > > >
> > > > This way CLOCK_EVT_FEAT_C3STOP feature is set for clock_event_device
> > > > based on RISC-V platform capabilities rather than having it set for
> > > > all RISC-V platforms.
> > > >
> > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > > ---
> > > >  drivers/clocksource/timer-riscv.c | 12 +++++++++++-
> > > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> > > > index 969a552da8d2..1b4b36df5484 100644
> > > > --- a/drivers/clocksource/timer-riscv.c
> > > > +++ b/drivers/clocksource/timer-riscv.c
> > > > @@ -28,6 +28,7 @@
> > > >  #include <asm/timex.h>
> > > >
> > > >  static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
> > > > +static bool riscv_timer_cannot_wake_cpu;
> > > >
> > > >  static int riscv_clock_next_event(unsigned long delta,
> > > >               struct clock_event_device *ce)
> > > > @@ -51,7 +52,7 @@ static int riscv_clock_next_event(unsigned long delta,
> > > >  static unsigned int riscv_clock_event_irq;
> > > >  static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
> > > >       .name                   = "riscv_timer_clockevent",
> > > > -     .features               = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP,
> > > > +     .features               = CLOCK_EVT_FEAT_ONESHOT,
> > >
> > > A platform that depended on CLOCK_EVT_FEAT_C3STOP being set will break
> > > with this change because its existing DT will not have the new property.
> > >
> > > It needs to be the other way around which would effectively be the
> > > existing 'always-on' property.
> >
> > There are no RISC-V platforms using C3STOP. The patch which
> > added C3STOP has been reverted.
> > (Refer, https://lore.kernel.org/lkml/a218ebf8-0fba-168d-6598-c970bbff5faf@sholland.org/T/)
> >
> > I just need to rebase this patch upon the C3STOP revert patch.
>
> I guess you could say that the C3STOP addition was done spec-ulatively*,
> as the platform that actually exhibits that behaviour does not use the
> riscv-timer & its maintainer acked the revert (allwinner d1 family).
>
> *The spec does not make any guarantees about whether events arrive
> during suspend, only the behaviour *if* they arrive.
>
> Switching the property to "always-on" would require retrofitting that
> property to every other existing platform (and therefore regressing some
> behaviour there, no?).
>
> Most of the existing platforms are "toys" or demo platforms though, so
> it would not, I guess, be the end of the world to do so. Doubly so since
> none of them actually implement any sleep states that making it an
> "always-on" property.
>
> I've said since the start that defaulting to C3STOP is the "safer" thing
> to do, and although we disagreed on this last time Anup, I think the
> better outcome of someone missing a DT property is inaccessible sleep
> states rather than going into sleep states they cannot get out of.
>
> For PolarFire SoC, which I guess is one of the few "commerical"
> platforms, I'd be willing to accept retrofitting, since we have not yet
> implemented such sleep states yet.
>
> Maybe Prabhakar knows whether the RZ/Five has either a) implemented
> sleep states and b) which side of the "timer events arrive in suspend"
> divide their platform lies on.
> I'm particular interested here since that is not a SiFive core complex.
>
On RZ/Five we haven't implemented the sleep states yet.

Cheers,
Prabhakar
