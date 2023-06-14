Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0C871FFBF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbjFBKvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbjFBKvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:51:32 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F76D3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:51:29 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BB3B23F452
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 10:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1685703086;
        bh=zEI1/9N9gWamuSdS/IDMYo60k3m7hBOiBlP+LYQ0YMU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=vkrtzTg1uNf8NjnrokLwWpbT0yw5atDKpDcep58Y6FZpZqMaNFqzl009RnbMffzY7
         I1MPoKI9K6gsW+nnofo02ZtUqN6O+Uh+8eiYb2u3gETUStxUbmaicpUKS2ljUvTZVz
         UxlgAc5RoAtJxp884bxsz6WWmMhoJ7qrTpM/Ra9rmFbeDvxZKVllp/zgj4uN1nH61Y
         sL1os9LQsPunrvRk6wqG1u07DX93iY+N+4uErSHU5pd4rEZuw6XZ49jLS3yUky38iN
         OcizHatvtiToBX3r3DQbUueWdYgooiJUcInwwIjPbMHl/TYy7pOg+b03sBtSXfYY4H
         08BsATcRg1gjQ==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f6b3a5a4e8so23791431cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 03:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685703085; x=1688295085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zEI1/9N9gWamuSdS/IDMYo60k3m7hBOiBlP+LYQ0YMU=;
        b=W6WflSi6FGIZ5B+Dv2XHWYfhKxmaAQ/HumeLny0MbLfKmh/ZUsniy0WP5CGcjBH8Cl
         f+tUNJUv+yxZhMGC+VCWgYwxdgiON1v/mnKUZ68ja97qqhz0dXstwf+3BTYLz9Rh9wVs
         Lo7gHyRJY8wpoQXgbVb4XzVsKnwFXHMgCUgUUYMzFHOvRDcHmfK8r9x2strT+FA3Taj+
         437eA+KAU+PsNkN310b9qOA26BkoOjdowdCiwo1RQlKy+/QxCg0H93DeP32H0FUGnidX
         26COJKMKS0EMlLvoxJwcb9ady/+YIVNJnkPAm0yhNCpCOEmtzHYQREGG9VPp4kNGmXw1
         4erQ==
X-Gm-Message-State: AC+VfDwBCq6OyqmLRZ8G1a9lePhz4KO3KN4tq6cQF5PM/OjrOhmUdpCf
        HOvErN+9IR5sXJVhd+ziuPYJecGKcINdqAdgrQiZDgR9dBzoZkG5JWt8lpCJq6eK66EI34FJnN2
        F+JaPX7kze6WCKvNGal2bwz/tl2ZzUbCIqfu2ttwIccmPXInqchfC8j8LjA==
X-Received: by 2002:a05:622a:592:b0:3f5:16fd:c5b2 with SMTP id c18-20020a05622a059200b003f516fdc5b2mr14347912qtb.10.1685703085484;
        Fri, 02 Jun 2023 03:51:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4MbJgpWACWhxtPJsPP7eGJBRbt8OjrRUE1Vs3GjOvg0tfFYdtrhZJ8rpM3VJHt4oJxqfNrJDkGxF1EVExe6dQ=
X-Received: by 2002:a05:622a:592:b0:3f5:16fd:c5b2 with SMTP id
 c18-20020a05622a059200b003f516fdc5b2mr14347900qtb.10.1685703085122; Fri, 02
 Jun 2023 03:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230320135433.144832-1-xingyu.wu@starfivetech.com>
 <20230320135433.144832-3-xingyu.wu@starfivetech.com> <506c0a1e-a839-c9b7-1b04-7fb3af535fe0@starfivetech.com>
In-Reply-To: <506c0a1e-a839-c9b7-1b04-7fb3af535fe0@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Fri, 2 Jun 2023 12:51:08 +0200
Message-ID: <CAJM55Z_MMQB=EoPn4fEC2httzTOdhedY6yeH+GBy3DAR1GtQpA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] clocksource: Add StarFive timer driver
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2023 at 11:48, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>
> On 2023/3/20 21:54, Xingyu Wu wrote:
> > Add timer driver for the StarFive JH7110 SoC.
> >
> > Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> > ---
> >  MAINTAINERS                          |   7 +
> >  drivers/clocksource/Kconfig          |  12 +
> >  drivers/clocksource/Makefile         |   1 +
> >  drivers/clocksource/timer-starfive.c | 390 +++++++++++++++++++++++++++
> >  drivers/clocksource/timer-starfive.h |  96 +++++++
> >  5 files changed, 506 insertions(+)
> >  create mode 100644 drivers/clocksource/timer-starfive.c
> >  create mode 100644 drivers/clocksource/timer-starfive.h

Hi Xingyu,

Just by a quick glance you're again adding a header that is only used
in one file. I don't see any other driver in drivers/clocksource doing
that, so I don't understand why you need that.

/Emil

> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 958b7ec118b4..dac6298d8f6e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19958,6 +19958,13 @@ S:   Maintained
> >  T:   git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
> >  F:   drivers/soc/starfive/
> >
> > +STARFIVE TIMER DRIVER
> > +M:   Samin Guo <samin.guo@starfivetech.com>
> > +M:   Xingyu Wu <xingyu.wu@starfivetech.com>
> > +S:   Supported
> > +F:   Documentation/devicetree/bindings/timer/starfive*
> > +F:   drivers/clocksource/timer-starfive*
> > +
> >  STARFIVE TRNG DRIVER
> >  M:   Jia Jie Ho <jiajie.ho@starfivetech.com>
> >  S:   Supported
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index 5fc8f0e7fb38..35daf07d4db7 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -630,6 +630,18 @@ config RISCV_TIMER
> >         is accessed via both the SBI and the rdcycle instruction.  This is
> >         required for all RISC-V systems.
> >
> > +config STARFIVE_TIMER
> > +     bool "Timer for the STARFIVE SoCs"
> > +     depends on ARCH_STARFIVE || COMPILE_TEST
> > +     select TIMER_OF
> > +     select CLKSRC_MMIO
> > +     default ARCH_STARFIVE
> > +     help
> > +       This enables the timer for StarFive SoCs. On RISC-V platform,
> > +       the system has started RISCV_TIMER. But you can also use this timer
> > +       to do a lot more on StarFive SoCs. This timer can provide high
> > +       precision and four channels to use in JH7110 SoC.
> > +
> >  config CLINT_TIMER
> >       bool "CLINT Timer for the RISC-V platform" if COMPILE_TEST
> >       depends on GENERIC_SCHED_CLOCK && RISCV
> > diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> > index 64ab547de97b..276695d95cdc 100644
> > --- a/drivers/clocksource/Makefile
> > +++ b/drivers/clocksource/Makefile
> > @@ -80,6 +80,7 @@ obj-$(CONFIG_INGENIC_TIMER)         += ingenic-timer.o
> >  obj-$(CONFIG_CLKSRC_ST_LPC)          += clksrc_st_lpc.o
> >  obj-$(CONFIG_X86_NUMACHIP)           += numachip.o
> >  obj-$(CONFIG_RISCV_TIMER)            += timer-riscv.o
> > +obj-$(CONFIG_STARFIVE_TIMER)         += timer-starfive.o
> >  obj-$(CONFIG_CLINT_TIMER)            += timer-clint.o
> >  obj-$(CONFIG_CSKY_MP_TIMER)          += timer-mp-csky.o
> >  obj-$(CONFIG_GX6605S_TIMER)          += timer-gx6605s.o
> > diff --git a/drivers/clocksource/timer-starfive.c b/drivers/clocksource/timer-starfive.c
> > new file mode 100644
> > index 000000000000..53163948ed86
> > --- /dev/null
> > +++ b/drivers/clocksource/timer-starfive.c
> > @@ -0,0 +1,390 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Starfive Timer driver
> > + *
> > + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> > + *
> > + * Author:
> > + * Xingyu Wu <xingyu.wu@starfivetech.com>
> > + * Samin Guo <samin.guo@starfivetech.com>
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/clockchips.h>
> > +#include <linux/clocksource.h>
> > +#include <linux/err.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/irq.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/reset.h>
> > +#include <linux/sched_clock.h>
> > +
> > +#include "timer-starfive.h"
> > +
> > +static const struct starfive_timer_chan_base starfive_timer_jh7110_base = {
> > +     .ctrl           = STARFIVE_TIMER_JH7110_CTL,
> > +     .load           = STARFIVE_TIMER_JH7110_LOAD,
> > +     .enable         = STARFIVE_TIMER_JH7110_ENABLE,
> > +     .reload         = STARFIVE_TIMER_JH7110_RELOAD,
> > +     .value          = STARFIVE_TIMER_JH7110_VALUE,
> > +     .intclr         = STARFIVE_TIMER_JH7110_INT_CLR,
> > +     .intmask        = STARFIVE_TIMER_JH7110_INT_MASK,
> > +     .channel_num    = STARFIVE_TIMER_CH_4,
> > +     .channel_base   = {STARFIVE_TIMER_CH_BASE(0), STARFIVE_TIMER_CH_BASE(1),
> > +                        STARFIVE_TIMER_CH_BASE(2), STARFIVE_TIMER_CH_BASE(3)},
> > +};
> > +
> > +static inline struct starfive_clkevt *to_starfive_clkevt(struct clock_event_device *evt)
> > +{
> > +     return container_of(evt, struct starfive_clkevt, evt);
> > +}
> > +
> > +/* 0:continuous-run mode, 1:single-run mode */
> > +static inline void starfive_timer_set_mod(struct starfive_clkevt *clkevt, int mod)
> > +{
> > +     writel(mod, clkevt->ctrl);
> > +}
> > +
> > +/* Interrupt Mask Register, 0:Unmask, 1:Mask */
> > +static inline void starfive_timer_int_enable(struct starfive_clkevt *clkevt)
> > +{
> > +     writel(STARFIVE_TIMER_INTMASK_DIS, clkevt->intmask);
> > +}
> > +
> > +static inline void starfive_timer_int_disable(struct starfive_clkevt *clkevt)
> > +{
> > +     writel(STARFIVE_TIMER_INTMASK_ENA, clkevt->intmask);
> > +}
> > +
> > +/*
> > + * BIT(0): Read value represent channel intr status.
> > + * Write 1 to this bit to clear interrupt. Write 0 has no effects.
> > + * BIT(1): "1" means that it is clearing interrupt. BIT(0) can not be written.
> > + */
> > +static inline int starfive_timer_int_clear(struct starfive_clkevt *clkevt)
> > +{
> > +     u32 value;
> > +     int ret;
> > +
> > +     /* waiting interrupt can be to clearing */
> > +     ret = readl_poll_timeout_atomic(clkevt->intclr, value,
> > +                                     !(value & STARFIVE_TIMER_JH7110_INT_CLR_AVA_MASK),
> > +                                     STARFIVE_DELAY_US, STARFIVE_TIMEOUT_US);
> > +     if (!ret)
> > +             writel(0x1, clkevt->intclr);
> > +
> > +     return ret;
> > +}
> > +
> > +/*
> > + * The initial value to be loaded into the
> > + * counter and is also used as the reload value.
> > + * val = clock rate --> 1s
> > + */
> > +static inline void starfive_timer_set_load(struct starfive_clkevt *clkevt, u32 val)
> > +{
> > +     writel(val, clkevt->load);
> > +}
> > +
> > +static inline u32 starfive_timer_get_val(struct starfive_clkevt *clkevt)
> > +{
> > +     return readl(clkevt->value);
> > +}
> > +
> > +/*
> > + * Write RELOAD register to reload preset value to counter.
> > + * (Write 0 and write 1 are both ok)
> > + */
> > +static inline void starfive_timer_set_reload(struct starfive_clkevt *clkevt)
> > +{
> > +     writel(0, clkevt->reload);
> > +}
> > +
> > +static inline void starfive_timer_enable(struct starfive_clkevt *clkevt)
> > +{
> > +     writel(STARFIVE_TIMER_ENA, clkevt->enable);
> > +}
> > +
> > +static inline void starfive_timer_disable(struct starfive_clkevt *clkevt)
> > +{
> > +     writel(STARFIVE_TIMER_DIS, clkevt->enable);
> > +}
> > +
> > +static int starfive_timer_int_init_enable(struct starfive_clkevt *clkevt)
> > +{
> > +     int ret;
> > +
> > +     starfive_timer_int_disable(clkevt);
> > +     ret = starfive_timer_int_clear(clkevt);
> > +     if (ret)
> > +             return ret;
> > +
> > +     starfive_timer_int_enable(clkevt);
> > +     starfive_timer_enable(clkevt);
> > +
> > +     return 0;
> > +}
> > +
> > +static int starfive_timer_shutdown(struct clock_event_device *evt)
> > +{
> > +     struct starfive_clkevt *clkevt = to_starfive_clkevt(evt);
> > +
> > +     starfive_timer_disable(clkevt);
> > +     return starfive_timer_int_clear(clkevt);
> > +}
> > +
> > +static void starfive_timer_suspend(struct clock_event_device *evt)
> > +{
> > +     struct starfive_clkevt *clkevt = to_starfive_clkevt(evt);
> > +
> > +     clkevt->reload_val = starfive_timer_get_val(clkevt);
> > +     starfive_timer_shutdown(evt);
> > +}
> > +
> > +static void starfive_timer_resume(struct clock_event_device *evt)
> > +{
> > +     struct starfive_clkevt *clkevt = to_starfive_clkevt(evt);
> > +
> > +     starfive_timer_set_load(clkevt, clkevt->reload_val);
> > +     starfive_timer_set_reload(clkevt);
> > +     starfive_timer_int_enable(clkevt);
> > +     starfive_timer_enable(clkevt);
> > +}
> > +
> > +static int starfive_timer_tick_resume(struct clock_event_device *evt)
> > +{
> > +     starfive_timer_resume(evt);
> > +
> > +     return 0;
> > +}
> > +
> > +static int starfive_clocksource_init(struct starfive_clkevt *clkevt)
> > +{
> > +     int ret;
> > +
> > +     starfive_timer_set_mod(clkevt, STARFIVE_TIMER_MOD_CONTIN);
> > +     starfive_timer_set_load(clkevt, STARFIVE_TIMER_MAX_TICKS);
> > +     ret = starfive_timer_int_init_enable(clkevt);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return clocksource_mmio_init(clkevt->value, clkevt->name, clkevt->rate,
> > +                                  STARFIVE_CLOCK_SOURCE_RATING, STARFIVE_VALID_BITS,
> > +                                  clocksource_mmio_readl_down);
> > +}
> > +
> > +/* IRQ handler for the timer */
> > +static irqreturn_t starfive_timer_interrupt(int irq, void *priv)
> > +{
> > +     struct clock_event_device *evt = (struct clock_event_device *)priv;
> > +     struct starfive_clkevt *clkevt = to_starfive_clkevt(evt);
> > +
> > +     if (starfive_timer_int_clear(clkevt))
> > +             return IRQ_NONE;
> > +
> > +     if (evt->event_handler)
> > +             evt->event_handler(evt);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static int starfive_timer_set_periodic(struct clock_event_device *evt)
> > +{
> > +     struct starfive_clkevt *clkevt = to_starfive_clkevt(evt);
> > +
> > +     starfive_timer_disable(clkevt);
> > +     starfive_timer_set_mod(clkevt, STARFIVE_TIMER_MOD_CONTIN);
> > +     starfive_timer_set_load(clkevt, clkevt->periodic);
> > +
> > +     return starfive_timer_int_init_enable(clkevt);
> > +}
> > +
> > +static int starfive_timer_set_oneshot(struct clock_event_device *evt)
> > +{
> > +     struct starfive_clkevt *clkevt = to_starfive_clkevt(evt);
> > +
> > +     starfive_timer_disable(clkevt);
> > +     starfive_timer_set_mod(clkevt, STARFIVE_TIMER_MOD_SINGLE);
> > +     starfive_timer_set_load(clkevt, STARFIVE_TIMER_MAX_TICKS);
> > +
> > +     return starfive_timer_int_init_enable(clkevt);
> > +}
> > +
> > +static int starfive_timer_set_next_event(unsigned long next,
> > +                                      struct clock_event_device *evt)
> > +{
> > +     struct starfive_clkevt *clkevt = to_starfive_clkevt(evt);
> > +
> > +     starfive_timer_disable(clkevt);
> > +     starfive_timer_set_mod(clkevt, STARFIVE_TIMER_MOD_SINGLE);
> > +     starfive_timer_set_load(clkevt, next);
> > +     starfive_timer_enable(clkevt);
> > +
> > +     return 0;
> > +}
> > +
> > +static void starfive_set_clockevent(struct clock_event_device *evt)
> > +{
> > +     evt->features = CLOCK_EVT_FEAT_PERIODIC |
> > +                     CLOCK_EVT_FEAT_ONESHOT |
> > +                     CLOCK_EVT_FEAT_DYNIRQ;
> > +     evt->set_state_shutdown = starfive_timer_shutdown;
> > +     evt->set_state_periodic = starfive_timer_set_periodic;
> > +     evt->set_state_oneshot = starfive_timer_set_oneshot;
> > +     evt->set_state_oneshot_stopped = starfive_timer_shutdown;
> > +     evt->tick_resume = starfive_timer_tick_resume;
> > +     evt->set_next_event = starfive_timer_set_next_event;
> > +     evt->suspend = starfive_timer_suspend;
> > +     evt->resume = starfive_timer_resume;
> > +     evt->rating = STARFIVE_CLOCKEVENT_RATING;
> > +}
> > +
> > +static void starfive_clockevents_register(struct starfive_clkevt *clkevt)
> > +{
> > +     clkevt->rate = clk_get_rate(clkevt->clk);
> > +     clkevt->periodic = DIV_ROUND_CLOSEST(clkevt->rate, HZ);
> > +
> > +     starfive_set_clockevent(&clkevt->evt);
> > +     clkevt->evt.name = clkevt->name;
> > +     clkevt->evt.irq = clkevt->irq;
> > +     clkevt->evt.cpumask = cpu_possible_mask;
> > +
> > +     clockevents_config_and_register(&clkevt->evt, clkevt->rate,
> > +                                     STARFIVE_TIMER_MIN_TICKS, STARFIVE_TIMER_MAX_TICKS);
> > +}
> > +
> > +static void __init starfive_clkevt_base_init(const struct starfive_timer_chan_base *timer,
> > +                                          struct starfive_clkevt *clkevt,
> > +                                          void __iomem *base, int ch)
> > +{
> > +     void __iomem *channel_base;
> > +
> > +     channel_base = base + timer->channel_base[ch];
> > +     clkevt->base = channel_base;
> > +     clkevt->ctrl = channel_base + timer->ctrl;
> > +     clkevt->load = channel_base + timer->load;
> > +     clkevt->enable = channel_base + timer->enable;
> > +     clkevt->reload = channel_base + timer->reload;
> > +     clkevt->value = channel_base + timer->value;
> > +     clkevt->intclr = channel_base + timer->intclr;
> > +     clkevt->intmask = channel_base + timer->intmask;
> > +}
> > +
> > +static int __init starfive_timer_probe(struct platform_device *pdev)
> > +{
> > +     const struct starfive_timer_chan_base *timer_base = of_device_get_match_data(&pdev->dev);
> > +     char name[10];
> > +     struct starfive_timer_priv *priv;
> > +     struct starfive_clkevt *clkevt;
> > +     struct clk *pclk;
> > +     struct reset_control *rst;
> > +     int ch;
> > +     int ret;
> > +
> > +     priv = devm_kzalloc(&pdev->dev, struct_size(priv, clkevt, timer_base->channel_num),
> > +                         GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     priv->base = devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(priv->base))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(priv->base),
> > +                                  "failed to map registers\n");
> > +
> > +     rst = devm_reset_control_get_exclusive(&pdev->dev, "apb");
> > +     if (IS_ERR(rst))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(rst), "failed to get apb reset\n");
> > +
> > +     pclk = devm_clk_get_enabled(&pdev->dev, "apb");
> > +     if (IS_ERR(pclk))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(pclk),
> > +                                  "failed to get & enable apb clock\n");
> > +
> > +     ret = reset_control_deassert(rst);
> > +     if (ret)
> > +             goto err;
> > +
> > +     priv->dev = &pdev->dev;
> > +     platform_set_drvdata(pdev, priv);
> > +
> > +     for (ch = 0; ch < timer_base->channel_num; ch++) {
> > +             clkevt = &priv->clkevt[ch];
> > +             snprintf(name, sizeof(name), "ch%d", ch);
> > +
> > +             starfive_clkevt_base_init(timer_base, clkevt, priv->base, ch);
> > +             /* Ensure timers are disabled */
> > +             starfive_timer_disable(clkevt);
> > +
> > +             rst = devm_reset_control_get_exclusive(&pdev->dev, name);
> > +             if (IS_ERR(rst)) {
> > +                     ret = PTR_ERR(rst);
> > +                     goto err;
> > +             }
> > +
> > +             clkevt->clk = devm_clk_get_enabled(&pdev->dev, name);
> > +             if (IS_ERR(clkevt->clk)) {
> > +                     ret = PTR_ERR(clkevt->clk);
> > +                     goto err;
> > +             }
> > +
> > +             ret = reset_control_deassert(rst);
> > +             if (ret)
> > +                     goto ch_err;
> > +
> > +             clkevt->irq = platform_get_irq(pdev, ch);
> > +             if (clkevt->irq < 0) {
> > +                     ret = clkevt->irq;
> > +                     goto ch_err;
> > +             }
> > +
> > +             snprintf(clkevt->name, sizeof(clkevt->name), "%s.ch%d", pdev->name, ch);
> > +             starfive_clockevents_register(clkevt);
> > +
> > +             ret = devm_request_irq(&pdev->dev, clkevt->irq, starfive_timer_interrupt,
> > +                                    IRQF_TIMER | IRQF_IRQPOLL,
> > +                                    clkevt->name, &clkevt->evt);
> > +             if (ret)
> > +                     goto ch_err;
> > +
> > +             ret = starfive_clocksource_init(clkevt);
> > +             if (ret)
> > +                     goto ch_err;
> > +     }
> > +
> > +     return 0;
> > +
> > +ch_err:
> > +     /* Only unregister the failed channel and the rest timer channels continue to work. */
> > +     clk_disable_unprepare(clkevt->clk);
> > +err:
> > +     /* If no other channel successfully registers, pclk should be disabled. */
> > +     if (!ch)
> > +             clk_disable_unprepare(pclk);
> > +
> > +     return ret;
> > +}
> > +
> > +static const struct of_device_id starfive_timer_match[] = {
> > +     { .compatible = "starfive,jh7110-timer", .data = &starfive_timer_jh7110_base },
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, starfive_timer_match);
> > +
> > +static struct platform_driver starfive_timer_driver = {
> > +     .probe = starfive_timer_probe,
> > +     .driver = {
> > +             .name = "starfive-timer",
> > +             .of_match_table = starfive_timer_match,
> > +     },
> > +};
> > +module_platform_driver(starfive_timer_driver);
> > +
> > +MODULE_AUTHOR("Xingyu Wu <xingyu.wu@starfivetech.com>");
> > +MODULE_DESCRIPTION("StarFive timer driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/clocksource/timer-starfive.h b/drivers/clocksource/timer-starfive.h
> > new file mode 100644
> > index 000000000000..62eb630cc98d
> > --- /dev/null
> > +++ b/drivers/clocksource/timer-starfive.h
> > @@ -0,0 +1,96 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> > + */
> > +
> > +#ifndef __STARFIVE_TIMER_H__
> > +#define __STARFIVE_TIMER_H__
> > +
> > +/* Bias: Ch0-0x0, Ch1-0x40, Ch2-0x80, and so on. */
> > +#define STARFIVE_TIMER_CH_LEN                        0x40
> > +#define STARFIVE_TIMER_CH_BASE(x)            ((STARFIVE_TIMER_CH_##x) * STARFIVE_TIMER_CH_LEN)
> > +
> > +#define STARFIVE_CLOCK_SOURCE_RATING         200
> > +#define STARFIVE_VALID_BITS                  32
> > +#define STARFIVE_DELAY_US                    0
> > +#define STARFIVE_TIMEOUT_US                  10000
> > +#define STARFIVE_CLOCKEVENT_RATING           300
> > +#define STARFIVE_TIMER_MAX_TICKS             0xffffffff
> > +#define STARFIVE_TIMER_MIN_TICKS             0xf
> > +
> > +#define STARFIVE_TIMER_JH7110_INT_STATUS     0x00 /* RO[0:4]: Interrupt Status for channel0~4 */
> > +#define STARFIVE_TIMER_JH7110_CTL            0x04 /* RW[0]: 0-continuous run, 1-single run */
> > +#define STARFIVE_TIMER_JH7110_LOAD           0x08 /* RW: load value to counter */
> > +#define STARFIVE_TIMER_JH7110_ENABLE         0x10 /* RW[0]: timer enable register */
> > +#define STARFIVE_TIMER_JH7110_RELOAD         0x14 /* RW: write 1 or 0 both reload counter */
> > +#define STARFIVE_TIMER_JH7110_VALUE          0x18 /* RO: timer value register */
> > +#define STARFIVE_TIMER_JH7110_INT_CLR                0x20 /* RW: timer interrupt clear register */
> > +#define STARFIVE_TIMER_JH7110_INT_MASK               0x24 /* RW[0]: timer interrupt mask register */
> > +#define STARFIVE_TIMER_JH7110_INT_CLR_AVA_MASK       BIT(1)
> > +
> > +enum STARFIVE_TIMER_CH {
> > +     STARFIVE_TIMER_CH_0 = 0,
> > +     STARFIVE_TIMER_CH_1,
> > +     STARFIVE_TIMER_CH_2,
> > +     STARFIVE_TIMER_CH_3,
> > +     STARFIVE_TIMER_CH_4,
> > +     STARFIVE_TIMER_CH_5,
> > +     STARFIVE_TIMER_CH_6,
> > +     STARFIVE_TIMER_CH_7,
> > +     STARFIVE_TIMER_CH_MAX
> > +};
> > +
> > +enum STARFIVE_TIMER_INTMASK {
> > +     STARFIVE_TIMER_INTMASK_DIS = 0,
> > +     STARFIVE_TIMER_INTMASK_ENA = 1
> > +};
> > +
> > +enum STARFIVE_TIMER_MOD {
> > +     STARFIVE_TIMER_MOD_CONTIN = 0,
> > +     STARFIVE_TIMER_MOD_SINGLE = 1
> > +};
> > +
> > +enum STARFIVE_TIMER_CTL_EN {
> > +     STARFIVE_TIMER_DIS = 0,
> > +     STARFIVE_TIMER_ENA = 1
> > +};
> > +
> > +struct starfive_timer_chan_base {
> > +     /* Resgister */
> > +     unsigned int ctrl;
> > +     unsigned int load;
> > +     unsigned int enable;
> > +     unsigned int reload;
> > +     unsigned int value;
> > +     unsigned int intclr;
> > +     unsigned int intmask;
> > +
> > +     unsigned int channel_num;       /* timer channel numbers */
> > +     unsigned int channel_base[];
> > +};
> > +
> > +struct starfive_clkevt {
> > +     struct clock_event_device evt;
> > +     struct clk *clk;
> > +     char name[20];
> > +     int irq;
> > +     u32 periodic;
> > +     u32 rate;
> > +     u32 reload_val;
> > +     void __iomem *base;
> > +     void __iomem *ctrl;
> > +     void __iomem *load;
> > +     void __iomem *enable;
> > +     void __iomem *reload;
> > +     void __iomem *value;
> > +     void __iomem *intclr;
> > +     void __iomem *intmask;
> > +};
> > +
> > +struct starfive_timer_priv {
> > +     struct device *dev;
> > +     void __iomem *base;
> > +     struct starfive_clkevt clkevt[];
> > +};
> > +
> > +#endif /* __STARFIVE_TIMER_H__ */
>
> Hi Daniel and Thomas,
>
> I have submitted patches for Timer driver. Could you please help to review and give your comments?
> Thanks.
>
> Best regards,
> Xingyu Wu
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
