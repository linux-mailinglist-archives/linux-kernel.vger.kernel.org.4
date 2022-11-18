Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06AE62FA25
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 17:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241525AbiKRQWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 11:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbiKRQWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 11:22:40 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADC7922D4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:22:37 -0800 (PST)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 093C23F333
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1668788554;
        bh=UIuXrM1nrVnpPWLQTVj4KoTkLg8yi2TmNazv9H3mek8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ISDX/pfvgFowBI+DCZb/Y1Ald79ZAS2O8BkTQNAC84tfLP53BmHzsfU25gbhSbVTM
         apJQwCi+NYYdsH4+lSToGpoNf3745thg1WvqbIEyQM9kVcYHvfVCBJOi13A4wdK5fG
         KKBZ+pfB5A3QS0YSMJaGL/X30+d0sE35d/3wm4H1xSaDzLAKiQiZHoMtUdNROBun7Q
         wqDx38nlzZNvlRJaSq2FmsWttQLMO2l/oCXjZvESQ5ezsrz0bnv/O6eY/Rk4rDnyj3
         a2HKVJTGBvlnw8hPL2ungxc8l3SJQvPd5/0pFYvL9RQJw3a6i+3SWz3HqfLTmsSbRd
         F2dYEEsRtz3Og==
Received: by mail-yb1-f198.google.com with SMTP id e8-20020a5b0cc8000000b006bca0fa3ab6so4885685ybr.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:22:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIuXrM1nrVnpPWLQTVj4KoTkLg8yi2TmNazv9H3mek8=;
        b=TIjA1BnOfXFfL/ENAniQ99WgZ7+Bbvw6KAcKwZocUK3y4UjFl08Xoa8SahI2cAhkH5
         +qPmxgafnZ9key9KOiTkk/xYq4yjr0LQh7WmCiwvjIcI7A8GKQHL9SXzxr6HBhAYK8GP
         8gdPRS/b1bW0uR4oMHqqUHbnsNOcuiWPDTqQO5FA8uOAVMsqISrrQYBHuvBlEeUvHJKJ
         S8kUSZsZ6iZeRoBVgzoOU6NNxzb8qGzmMY8dx2L0wQh/Q3r50pVviQBh2v4Ef9gAdzas
         VRmm5MVtfiHXmIYeMTMKysCdkSeqhRx94ow9bNO5SEW6tTBo9FQafI+JT13l/0Ri294A
         wDgg==
X-Gm-Message-State: ANoB5pkHvvtMNu7j6TS2oPza9+ASpfE2hQC+tjhinfp1SFFwTZQkzzTO
        SLXNYjB+/epPmTznJuStX0+/HVHJwlRvypWA4+m/qE7lfLH/SlRe8aaoPb19C4s61Uy49p1u283
        WiXG0CqYluw/9FQfkS5Ppr11SBy5ZcyJekWZIlK92qqa3e28XJ2zRZlt5vQ==
X-Received: by 2002:a25:abe4:0:b0:6e7:cbc4:1ac3 with SMTP id v91-20020a25abe4000000b006e7cbc41ac3mr5814656ybi.559.1668788547250;
        Fri, 18 Nov 2022 08:22:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Z+nWiESsyhyw2ii4v0Xj3hmukMVm82cnfkoBX45XLT0igqXvEGGvMxcYfTrtWigVZvs/Bu94g2NFIVfZaPHE=
X-Received: by 2002:a25:abe4:0:b0:6e7:cbc4:1ac3 with SMTP id
 v91-20020a25abe4000000b006e7cbc41ac3mr5814615ybi.559.1668788546889; Fri, 18
 Nov 2022 08:22:26 -0800 (PST)
MIME-Version: 1.0
References: <20221118010627.70576-1-hal.feng@starfivetech.com> <20221118010627.70576-2-hal.feng@starfivetech.com>
In-Reply-To: <20221118010627.70576-2-hal.feng@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Fri, 18 Nov 2022 17:22:10 +0100
Message-ID: <CAJM55Z8nGNm_TrTsw0HZnAVehWrFU9-MtAj0ngRRx_E8jFapGg@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] clk: starfive: Factor out common JH7100 and
 JH7110 code
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 at 02:06, Hal Feng <hal.feng@starfivetech.com> wrote:
>
> From: Emil Renner Berthing <kernel@esmil.dk>
>
> The clock control registers on the StarFive JH7100 and JH7110 work
> identically, so factor out the code then drivers for the two SoCs
> can share it without depending on each other. No functional change.
>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  MAINTAINERS                                |   2 +-
>  drivers/clk/starfive/Kconfig               |   5 +
>  drivers/clk/starfive/Makefile              |   3 +-
>  drivers/clk/starfive/clk-starfive-jh7100.c | 325 --------------------
>  drivers/clk/starfive/clk-starfive-jh7100.h |   2 +
>  drivers/clk/starfive/clk-starfive-jh71x0.c | 333 +++++++++++++++++++++
>  6 files changed, 343 insertions(+), 327 deletions(-)
>  create mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 256f03904987..d43daa89d5f1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19602,7 +19602,7 @@ STARFIVE JH7100 CLOCK DRIVERS
>  M:     Emil Renner Berthing <kernel@esmil.dk>
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/clock/starfive,jh7100-*.yaml
> -F:     drivers/clk/starfive/clk-starfive-jh7100*
> +F:     drivers/clk/starfive/

When this entry cover all the starfive clock drivers the header should
also match. Eg.
STARFIVE CLOCK DRIVERS


>  F:     include/dt-bindings/clock/starfive-jh7100*.h
>
>  STARFIVE JH7100 PINCTRL DRIVER
> diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
> index 003bd2d56ce7..594d516dcb38 100644
> --- a/drivers/clk/starfive/Kconfig
> +++ b/drivers/clk/starfive/Kconfig
> @@ -1,8 +1,12 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> +config CLK_STARFIVE_JH71X0
> +       bool
> +
>  config CLK_STARFIVE_JH7100
>         bool "StarFive JH7100 clock support"
>         depends on SOC_STARFIVE || COMPILE_TEST
> +       select CLK_STARFIVE_JH71X0
>         default SOC_STARFIVE
>         help
>           Say yes here to support the clock controller on the StarFive JH7100
> @@ -11,6 +15,7 @@ config CLK_STARFIVE_JH7100
>  config CLK_STARFIVE_JH7100_AUDIO
>         tristate "StarFive JH7100 audio clock support"
>         depends on CLK_STARFIVE_JH7100
> +       select CLK_STARFIVE_JH71X0
>         default m if SOC_STARFIVE
>         help
>           Say Y or M here to support the audio clocks on the StarFive JH7100
> diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
> index 0fa8ecb9ec1c..82edfa9f9cb8 100644
> --- a/drivers/clk/starfive/Makefile
> +++ b/drivers/clk/starfive/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -# StarFive Clock
> +obj-$(CONFIG_CLK_STARFIVE_JH71X0)      += clk-starfive-jh71x0.o
> +
>  obj-$(CONFIG_CLK_STARFIVE_JH7100)      += clk-starfive-jh7100.o
>  obj-$(CONFIG_CLK_STARFIVE_JH7100_AUDIO)        += clk-starfive-jh7100-audio.o
> diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c b/drivers/clk/starfive/clk-starfive-jh7100.c
> index 691aeebc7092..eea52f16af0d 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7100.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7100.c
> @@ -7,15 +7,10 @@
>   * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
>   */
>
> -#include <linux/bits.h>
>  #include <linux/clk-provider.h>
> -#include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
> -#include <linux/io.h>
> -#include <linux/kernel.h>
>  #include <linux/mod_devicetable.h>
> -#include <linux/module.h>
>  #include <linux/platform_device.h>
>
>  #include <dt-bindings/clock/starfive-jh7100.h>
> @@ -269,326 +264,6 @@ static const struct jh7100_clk_data jh7100_clk_data[] __initconst = {
>         JH7100_GATE(JH7100_CLK_SYSERR_APB, "syserr_apb", 0, JH7100_CLK_APB2_BUS),
>  };
>
> -static struct jh7100_clk *jh7100_clk_from(struct clk_hw *hw)
> -{
> -       return container_of(hw, struct jh7100_clk, hw);
> -}
> -
> -static struct jh7100_clk_priv *jh7100_priv_from(struct jh7100_clk *clk)
> -{
> -       return container_of(clk, struct jh7100_clk_priv, reg[clk->idx]);
> -}
> -
> -static u32 jh7100_clk_reg_get(struct jh7100_clk *clk)
> -{
> -       struct jh7100_clk_priv *priv = jh7100_priv_from(clk);
> -       void __iomem *reg = priv->base + 4 * clk->idx;
> -
> -       return readl_relaxed(reg);
> -}
> -
> -static void jh7100_clk_reg_rmw(struct jh7100_clk *clk, u32 mask, u32 value)
> -{
> -       struct jh7100_clk_priv *priv = jh7100_priv_from(clk);
> -       void __iomem *reg = priv->base + 4 * clk->idx;
> -       unsigned long flags;
> -
> -       spin_lock_irqsave(&priv->rmw_lock, flags);
> -       value |= readl_relaxed(reg) & ~mask;
> -       writel_relaxed(value, reg);
> -       spin_unlock_irqrestore(&priv->rmw_lock, flags);
> -}
> -
> -static int jh7100_clk_enable(struct clk_hw *hw)
> -{
> -       struct jh7100_clk *clk = jh7100_clk_from(hw);
> -
> -       jh7100_clk_reg_rmw(clk, JH7100_CLK_ENABLE, JH7100_CLK_ENABLE);
> -       return 0;
> -}
> -
> -static void jh7100_clk_disable(struct clk_hw *hw)
> -{
> -       struct jh7100_clk *clk = jh7100_clk_from(hw);
> -
> -       jh7100_clk_reg_rmw(clk, JH7100_CLK_ENABLE, 0);
> -}
> -
> -static int jh7100_clk_is_enabled(struct clk_hw *hw)
> -{
> -       struct jh7100_clk *clk = jh7100_clk_from(hw);
> -
> -       return !!(jh7100_clk_reg_get(clk) & JH7100_CLK_ENABLE);
> -}
> -
> -static unsigned long jh7100_clk_recalc_rate(struct clk_hw *hw,
> -                                           unsigned long parent_rate)
> -{
> -       struct jh7100_clk *clk = jh7100_clk_from(hw);
> -       u32 div = jh7100_clk_reg_get(clk) & JH7100_CLK_DIV_MASK;
> -
> -       return div ? parent_rate / div : 0;
> -}
> -
> -static int jh7100_clk_determine_rate(struct clk_hw *hw,
> -                                    struct clk_rate_request *req)
> -{
> -       struct jh7100_clk *clk = jh7100_clk_from(hw);
> -       unsigned long parent = req->best_parent_rate;
> -       unsigned long rate = clamp(req->rate, req->min_rate, req->max_rate);
> -       unsigned long div = min_t(unsigned long, DIV_ROUND_UP(parent, rate), clk->max_div);
> -       unsigned long result = parent / div;
> -
> -       /*
> -        * we want the result clamped by min_rate and max_rate if possible:
> -        * case 1: div hits the max divider value, which means it's less than
> -        * parent / rate, so the result is greater than rate and min_rate in
> -        * particular. we can't do anything about result > max_rate because the
> -        * divider doesn't go any further.
> -        * case 2: div = DIV_ROUND_UP(parent, rate) which means the result is
> -        * always lower or equal to rate and max_rate. however the result may
> -        * turn out lower than min_rate, but then the next higher rate is fine:
> -        *   div - 1 = ceil(parent / rate) - 1 < parent / rate
> -        * and thus
> -        *   min_rate <= rate < parent / (div - 1)
> -        */
> -       if (result < req->min_rate && div > 1)
> -               result = parent / (div - 1);
> -
> -       req->rate = result;
> -       return 0;
> -}
> -
> -static int jh7100_clk_set_rate(struct clk_hw *hw,
> -                              unsigned long rate,
> -                              unsigned long parent_rate)
> -{
> -       struct jh7100_clk *clk = jh7100_clk_from(hw);
> -       unsigned long div = clamp(DIV_ROUND_CLOSEST(parent_rate, rate),
> -                                 1UL, (unsigned long)clk->max_div);
> -
> -       jh7100_clk_reg_rmw(clk, JH7100_CLK_DIV_MASK, div);
> -       return 0;
> -}
> -
> -static unsigned long jh7100_clk_frac_recalc_rate(struct clk_hw *hw,
> -                                                unsigned long parent_rate)
> -{
> -       struct jh7100_clk *clk = jh7100_clk_from(hw);
> -       u32 reg = jh7100_clk_reg_get(clk);
> -       unsigned long div100 = 100 * (reg & JH7100_CLK_INT_MASK) +
> -                              ((reg & JH7100_CLK_FRAC_MASK) >> JH7100_CLK_FRAC_SHIFT);
> -
> -       return (div100 >= JH7100_CLK_FRAC_MIN) ? 100 * parent_rate / div100 : 0;
> -}
> -
> -static int jh7100_clk_frac_determine_rate(struct clk_hw *hw,
> -                                         struct clk_rate_request *req)
> -{
> -       unsigned long parent100 = 100 * req->best_parent_rate;
> -       unsigned long rate = clamp(req->rate, req->min_rate, req->max_rate);
> -       unsigned long div100 = clamp(DIV_ROUND_CLOSEST(parent100, rate),
> -                                    JH7100_CLK_FRAC_MIN, JH7100_CLK_FRAC_MAX);
> -       unsigned long result = parent100 / div100;
> -
> -       /* clamp the result as in jh7100_clk_determine_rate() above */
> -       if (result > req->max_rate && div100 < JH7100_CLK_FRAC_MAX)
> -               result = parent100 / (div100 + 1);
> -       if (result < req->min_rate && div100 > JH7100_CLK_FRAC_MIN)
> -               result = parent100 / (div100 - 1);
> -
> -       req->rate = result;
> -       return 0;
> -}
> -
> -static int jh7100_clk_frac_set_rate(struct clk_hw *hw,
> -                                   unsigned long rate,
> -                                   unsigned long parent_rate)
> -{
> -       struct jh7100_clk *clk = jh7100_clk_from(hw);
> -       unsigned long div100 = clamp(DIV_ROUND_CLOSEST(100 * parent_rate, rate),
> -                                    JH7100_CLK_FRAC_MIN, JH7100_CLK_FRAC_MAX);
> -       u32 value = ((div100 % 100) << JH7100_CLK_FRAC_SHIFT) | (div100 / 100);
> -
> -       jh7100_clk_reg_rmw(clk, JH7100_CLK_DIV_MASK, value);
> -       return 0;
> -}
> -
> -static u8 jh7100_clk_get_parent(struct clk_hw *hw)
> -{
> -       struct jh7100_clk *clk = jh7100_clk_from(hw);
> -       u32 value = jh7100_clk_reg_get(clk);
> -
> -       return (value & JH7100_CLK_MUX_MASK) >> JH7100_CLK_MUX_SHIFT;
> -}
> -
> -static int jh7100_clk_set_parent(struct clk_hw *hw, u8 index)
> -{
> -       struct jh7100_clk *clk = jh7100_clk_from(hw);
> -       u32 value = (u32)index << JH7100_CLK_MUX_SHIFT;
> -
> -       jh7100_clk_reg_rmw(clk, JH7100_CLK_MUX_MASK, value);
> -       return 0;
> -}
> -
> -static int jh7100_clk_mux_determine_rate(struct clk_hw *hw,
> -                                        struct clk_rate_request *req)
> -{
> -       return clk_mux_determine_rate_flags(hw, req, 0);
> -}
> -
> -static int jh7100_clk_get_phase(struct clk_hw *hw)
> -{
> -       struct jh7100_clk *clk = jh7100_clk_from(hw);
> -       u32 value = jh7100_clk_reg_get(clk);
> -
> -       return (value & JH7100_CLK_INVERT) ? 180 : 0;
> -}
> -
> -static int jh7100_clk_set_phase(struct clk_hw *hw, int degrees)
> -{
> -       struct jh7100_clk *clk = jh7100_clk_from(hw);
> -       u32 value;
> -
> -       if (degrees == 0)
> -               value = 0;
> -       else if (degrees == 180)
> -               value = JH7100_CLK_INVERT;
> -       else
> -               return -EINVAL;
> -
> -       jh7100_clk_reg_rmw(clk, JH7100_CLK_INVERT, value);
> -       return 0;
> -}
> -
> -#ifdef CONFIG_DEBUG_FS
> -static void jh7100_clk_debug_init(struct clk_hw *hw, struct dentry *dentry)
> -{
> -       static const struct debugfs_reg32 jh7100_clk_reg = {
> -               .name = "CTRL",
> -               .offset = 0,
> -       };
> -       struct jh7100_clk *clk = jh7100_clk_from(hw);
> -       struct jh7100_clk_priv *priv = jh7100_priv_from(clk);
> -       struct debugfs_regset32 *regset;
> -
> -       regset = devm_kzalloc(priv->dev, sizeof(*regset), GFP_KERNEL);
> -       if (!regset)
> -               return;
> -
> -       regset->regs = &jh7100_clk_reg;
> -       regset->nregs = 1;
> -       regset->base = priv->base + 4 * clk->idx;
> -
> -       debugfs_create_regset32("registers", 0400, dentry, regset);
> -}
> -#else
> -#define jh7100_clk_debug_init NULL
> -#endif
> -
> -static const struct clk_ops jh7100_clk_gate_ops = {
> -       .enable = jh7100_clk_enable,
> -       .disable = jh7100_clk_disable,
> -       .is_enabled = jh7100_clk_is_enabled,
> -       .debug_init = jh7100_clk_debug_init,
> -};
> -
> -static const struct clk_ops jh7100_clk_div_ops = {
> -       .recalc_rate = jh7100_clk_recalc_rate,
> -       .determine_rate = jh7100_clk_determine_rate,
> -       .set_rate = jh7100_clk_set_rate,
> -       .debug_init = jh7100_clk_debug_init,
> -};
> -
> -static const struct clk_ops jh7100_clk_fdiv_ops = {
> -       .recalc_rate = jh7100_clk_frac_recalc_rate,
> -       .determine_rate = jh7100_clk_frac_determine_rate,
> -       .set_rate = jh7100_clk_frac_set_rate,
> -       .debug_init = jh7100_clk_debug_init,
> -};
> -
> -static const struct clk_ops jh7100_clk_gdiv_ops = {
> -       .enable = jh7100_clk_enable,
> -       .disable = jh7100_clk_disable,
> -       .is_enabled = jh7100_clk_is_enabled,
> -       .recalc_rate = jh7100_clk_recalc_rate,
> -       .determine_rate = jh7100_clk_determine_rate,
> -       .set_rate = jh7100_clk_set_rate,
> -       .debug_init = jh7100_clk_debug_init,
> -};
> -
> -static const struct clk_ops jh7100_clk_mux_ops = {
> -       .determine_rate = jh7100_clk_mux_determine_rate,
> -       .set_parent = jh7100_clk_set_parent,
> -       .get_parent = jh7100_clk_get_parent,
> -       .debug_init = jh7100_clk_debug_init,
> -};
> -
> -static const struct clk_ops jh7100_clk_gmux_ops = {
> -       .enable = jh7100_clk_enable,
> -       .disable = jh7100_clk_disable,
> -       .is_enabled = jh7100_clk_is_enabled,
> -       .determine_rate = jh7100_clk_mux_determine_rate,
> -       .set_parent = jh7100_clk_set_parent,
> -       .get_parent = jh7100_clk_get_parent,
> -       .debug_init = jh7100_clk_debug_init,
> -};
> -
> -static const struct clk_ops jh7100_clk_mdiv_ops = {
> -       .recalc_rate = jh7100_clk_recalc_rate,
> -       .determine_rate = jh7100_clk_determine_rate,
> -       .get_parent = jh7100_clk_get_parent,
> -       .set_parent = jh7100_clk_set_parent,
> -       .set_rate = jh7100_clk_set_rate,
> -       .debug_init = jh7100_clk_debug_init,
> -};
> -
> -static const struct clk_ops jh7100_clk_gmd_ops = {
> -       .enable = jh7100_clk_enable,
> -       .disable = jh7100_clk_disable,
> -       .is_enabled = jh7100_clk_is_enabled,
> -       .recalc_rate = jh7100_clk_recalc_rate,
> -       .determine_rate = jh7100_clk_determine_rate,
> -       .get_parent = jh7100_clk_get_parent,
> -       .set_parent = jh7100_clk_set_parent,
> -       .set_rate = jh7100_clk_set_rate,
> -       .debug_init = jh7100_clk_debug_init,
> -};
> -
> -static const struct clk_ops jh7100_clk_inv_ops = {
> -       .get_phase = jh7100_clk_get_phase,
> -       .set_phase = jh7100_clk_set_phase,
> -       .debug_init = jh7100_clk_debug_init,
> -};
> -
> -const struct clk_ops *starfive_jh7100_clk_ops(u32 max)
> -{
> -       if (max & JH7100_CLK_DIV_MASK) {
> -               if (max & JH7100_CLK_MUX_MASK) {
> -                       if (max & JH7100_CLK_ENABLE)
> -                               return &jh7100_clk_gmd_ops;
> -                       return &jh7100_clk_mdiv_ops;
> -               }
> -               if (max & JH7100_CLK_ENABLE)
> -                       return &jh7100_clk_gdiv_ops;
> -               if (max == JH7100_CLK_FRAC_MAX)
> -                       return &jh7100_clk_fdiv_ops;
> -               return &jh7100_clk_div_ops;
> -       }
> -
> -       if (max & JH7100_CLK_MUX_MASK) {
> -               if (max & JH7100_CLK_ENABLE)
> -                       return &jh7100_clk_gmux_ops;
> -               return &jh7100_clk_mux_ops;
> -       }
> -
> -       if (max & JH7100_CLK_ENABLE)
> -               return &jh7100_clk_gate_ops;
> -
> -       return &jh7100_clk_inv_ops;
> -}
> -EXPORT_SYMBOL_GPL(starfive_jh7100_clk_ops);
> -
>  static struct clk_hw *jh7100_clk_get(struct of_phandle_args *clkspec, void *data)
>  {
>         struct jh7100_clk_priv *priv = data;
> diff --git a/drivers/clk/starfive/clk-starfive-jh7100.h b/drivers/clk/starfive/clk-starfive-jh7100.h
> index f116be5740a5..a8ba6e25b5ce 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7100.h
> +++ b/drivers/clk/starfive/clk-starfive-jh7100.h
> @@ -4,6 +4,8 @@
>
>  #include <linux/bits.h>
>  #include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/spinlock.h>
>
>  /* register fields */
>  #define JH7100_CLK_ENABLE      BIT(31)
> diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.c b/drivers/clk/starfive/clk-starfive-jh71x0.c
> new file mode 100644
> index 000000000000..6c07b61b4a32
> --- /dev/null
> +++ b/drivers/clk/starfive/clk-starfive-jh71x0.c
> @@ -0,0 +1,333 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * StarFive JH7100 Clock Generator Driver
> + *
> + * Copyright (C) 2021-2022 Emil Renner Berthing <kernel@esmil.dk>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +
> +#include "clk-starfive-jh7100.h"
> +
> +static struct jh7100_clk *jh7100_clk_from(struct clk_hw *hw)
> +{
> +       return container_of(hw, struct jh7100_clk, hw);
> +}
> +
> +static struct jh7100_clk_priv *jh7100_priv_from(struct jh7100_clk *clk)
> +{
> +       return container_of(clk, struct jh7100_clk_priv, reg[clk->idx]);
> +}
> +
> +static u32 jh7100_clk_reg_get(struct jh7100_clk *clk)
> +{
> +       struct jh7100_clk_priv *priv = jh7100_priv_from(clk);
> +       void __iomem *reg = priv->base + 4 * clk->idx;
> +
> +       return readl_relaxed(reg);
> +}
> +
> +static void jh7100_clk_reg_rmw(struct jh7100_clk *clk, u32 mask, u32 value)
> +{
> +       struct jh7100_clk_priv *priv = jh7100_priv_from(clk);
> +       void __iomem *reg = priv->base + 4 * clk->idx;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&priv->rmw_lock, flags);
> +       value |= readl_relaxed(reg) & ~mask;
> +       writel_relaxed(value, reg);
> +       spin_unlock_irqrestore(&priv->rmw_lock, flags);
> +}
> +
> +static int jh7100_clk_enable(struct clk_hw *hw)
> +{
> +       struct jh7100_clk *clk = jh7100_clk_from(hw);
> +
> +       jh7100_clk_reg_rmw(clk, JH7100_CLK_ENABLE, JH7100_CLK_ENABLE);
> +       return 0;
> +}
> +
> +static void jh7100_clk_disable(struct clk_hw *hw)
> +{
> +       struct jh7100_clk *clk = jh7100_clk_from(hw);
> +
> +       jh7100_clk_reg_rmw(clk, JH7100_CLK_ENABLE, 0);
> +}
> +
> +static int jh7100_clk_is_enabled(struct clk_hw *hw)
> +{
> +       struct jh7100_clk *clk = jh7100_clk_from(hw);
> +
> +       return !!(jh7100_clk_reg_get(clk) & JH7100_CLK_ENABLE);
> +}
> +
> +static unsigned long jh7100_clk_recalc_rate(struct clk_hw *hw,
> +                                           unsigned long parent_rate)
> +{
> +       struct jh7100_clk *clk = jh7100_clk_from(hw);
> +       u32 div = jh7100_clk_reg_get(clk) & JH7100_CLK_DIV_MASK;
> +
> +       return div ? parent_rate / div : 0;
> +}
> +
> +static int jh7100_clk_determine_rate(struct clk_hw *hw,
> +                                    struct clk_rate_request *req)
> +{
> +       struct jh7100_clk *clk = jh7100_clk_from(hw);
> +       unsigned long parent = req->best_parent_rate;
> +       unsigned long rate = clamp(req->rate, req->min_rate, req->max_rate);
> +       unsigned long div = min_t(unsigned long, DIV_ROUND_UP(parent, rate), clk->max_div);
> +       unsigned long result = parent / div;
> +
> +       /*
> +        * we want the result clamped by min_rate and max_rate if possible:
> +        * case 1: div hits the max divider value, which means it's less than
> +        * parent / rate, so the result is greater than rate and min_rate in
> +        * particular. we can't do anything about result > max_rate because the
> +        * divider doesn't go any further.
> +        * case 2: div = DIV_ROUND_UP(parent, rate) which means the result is
> +        * always lower or equal to rate and max_rate. however the result may
> +        * turn out lower than min_rate, but then the next higher rate is fine:
> +        *   div - 1 = ceil(parent / rate) - 1 < parent / rate
> +        * and thus
> +        *   min_rate <= rate < parent / (div - 1)
> +        */
> +       if (result < req->min_rate && div > 1)
> +               result = parent / (div - 1);
> +
> +       req->rate = result;
> +       return 0;
> +}
> +
> +static int jh7100_clk_set_rate(struct clk_hw *hw,
> +                              unsigned long rate,
> +                              unsigned long parent_rate)
> +{
> +       struct jh7100_clk *clk = jh7100_clk_from(hw);
> +       unsigned long div = clamp(DIV_ROUND_CLOSEST(parent_rate, rate),
> +                                 1UL, (unsigned long)clk->max_div);
> +
> +       jh7100_clk_reg_rmw(clk, JH7100_CLK_DIV_MASK, div);
> +       return 0;
> +}
> +
> +static unsigned long jh7100_clk_frac_recalc_rate(struct clk_hw *hw,
> +                                                unsigned long parent_rate)
> +{
> +       struct jh7100_clk *clk = jh7100_clk_from(hw);
> +       u32 reg = jh7100_clk_reg_get(clk);
> +       unsigned long div100 = 100 * (reg & JH7100_CLK_INT_MASK) +
> +                              ((reg & JH7100_CLK_FRAC_MASK) >> JH7100_CLK_FRAC_SHIFT);
> +
> +       return (div100 >= JH7100_CLK_FRAC_MIN) ? 100 * parent_rate / div100 : 0;
> +}
> +
> +static int jh7100_clk_frac_determine_rate(struct clk_hw *hw,
> +                                         struct clk_rate_request *req)
> +{
> +       unsigned long parent100 = 100 * req->best_parent_rate;
> +       unsigned long rate = clamp(req->rate, req->min_rate, req->max_rate);
> +       unsigned long div100 = clamp(DIV_ROUND_CLOSEST(parent100, rate),
> +                                    JH7100_CLK_FRAC_MIN, JH7100_CLK_FRAC_MAX);
> +       unsigned long result = parent100 / div100;
> +
> +       /* clamp the result as in jh7100_clk_determine_rate() above */
> +       if (result > req->max_rate && div100 < JH7100_CLK_FRAC_MAX)
> +               result = parent100 / (div100 + 1);
> +       if (result < req->min_rate && div100 > JH7100_CLK_FRAC_MIN)
> +               result = parent100 / (div100 - 1);
> +
> +       req->rate = result;
> +       return 0;
> +}
> +
> +static int jh7100_clk_frac_set_rate(struct clk_hw *hw,
> +                                   unsigned long rate,
> +                                   unsigned long parent_rate)
> +{
> +       struct jh7100_clk *clk = jh7100_clk_from(hw);
> +       unsigned long div100 = clamp(DIV_ROUND_CLOSEST(100 * parent_rate, rate),
> +                                    JH7100_CLK_FRAC_MIN, JH7100_CLK_FRAC_MAX);
> +       u32 value = ((div100 % 100) << JH7100_CLK_FRAC_SHIFT) | (div100 / 100);
> +
> +       jh7100_clk_reg_rmw(clk, JH7100_CLK_DIV_MASK, value);
> +       return 0;
> +}
> +
> +static u8 jh7100_clk_get_parent(struct clk_hw *hw)
> +{
> +       struct jh7100_clk *clk = jh7100_clk_from(hw);
> +       u32 value = jh7100_clk_reg_get(clk);
> +
> +       return (value & JH7100_CLK_MUX_MASK) >> JH7100_CLK_MUX_SHIFT;
> +}
> +
> +static int jh7100_clk_set_parent(struct clk_hw *hw, u8 index)
> +{
> +       struct jh7100_clk *clk = jh7100_clk_from(hw);
> +       u32 value = (u32)index << JH7100_CLK_MUX_SHIFT;
> +
> +       jh7100_clk_reg_rmw(clk, JH7100_CLK_MUX_MASK, value);
> +       return 0;
> +}
> +
> +static int jh7100_clk_mux_determine_rate(struct clk_hw *hw,
> +                                        struct clk_rate_request *req)
> +{
> +       return clk_mux_determine_rate_flags(hw, req, 0);
> +}
> +
> +static int jh7100_clk_get_phase(struct clk_hw *hw)
> +{
> +       struct jh7100_clk *clk = jh7100_clk_from(hw);
> +       u32 value = jh7100_clk_reg_get(clk);
> +
> +       return (value & JH7100_CLK_INVERT) ? 180 : 0;
> +}
> +
> +static int jh7100_clk_set_phase(struct clk_hw *hw, int degrees)
> +{
> +       struct jh7100_clk *clk = jh7100_clk_from(hw);
> +       u32 value;
> +
> +       if (degrees == 0)
> +               value = 0;
> +       else if (degrees == 180)
> +               value = JH7100_CLK_INVERT;
> +       else
> +               return -EINVAL;
> +
> +       jh7100_clk_reg_rmw(clk, JH7100_CLK_INVERT, value);
> +       return 0;
> +}
> +
> +#ifdef CONFIG_DEBUG_FS
> +static void jh7100_clk_debug_init(struct clk_hw *hw, struct dentry *dentry)
> +{
> +       static const struct debugfs_reg32 jh7100_clk_reg = {
> +               .name = "CTRL",
> +               .offset = 0,
> +       };
> +       struct jh7100_clk *clk = jh7100_clk_from(hw);
> +       struct jh7100_clk_priv *priv = jh7100_priv_from(clk);
> +       struct debugfs_regset32 *regset;
> +
> +       regset = devm_kzalloc(priv->dev, sizeof(*regset), GFP_KERNEL);
> +       if (!regset)
> +               return;
> +
> +       regset->regs = &jh7100_clk_reg;
> +       regset->nregs = 1;
> +       regset->base = priv->base + 4 * clk->idx;
> +
> +       debugfs_create_regset32("registers", 0400, dentry, regset);
> +}
> +#else
> +#define jh7100_clk_debug_init NULL
> +#endif
> +
> +static const struct clk_ops jh7100_clk_gate_ops = {
> +       .enable = jh7100_clk_enable,
> +       .disable = jh7100_clk_disable,
> +       .is_enabled = jh7100_clk_is_enabled,
> +       .debug_init = jh7100_clk_debug_init,
> +};
> +
> +static const struct clk_ops jh7100_clk_div_ops = {
> +       .recalc_rate = jh7100_clk_recalc_rate,
> +       .determine_rate = jh7100_clk_determine_rate,
> +       .set_rate = jh7100_clk_set_rate,
> +       .debug_init = jh7100_clk_debug_init,
> +};
> +
> +static const struct clk_ops jh7100_clk_fdiv_ops = {
> +       .recalc_rate = jh7100_clk_frac_recalc_rate,
> +       .determine_rate = jh7100_clk_frac_determine_rate,
> +       .set_rate = jh7100_clk_frac_set_rate,
> +       .debug_init = jh7100_clk_debug_init,
> +};
> +
> +static const struct clk_ops jh7100_clk_gdiv_ops = {
> +       .enable = jh7100_clk_enable,
> +       .disable = jh7100_clk_disable,
> +       .is_enabled = jh7100_clk_is_enabled,
> +       .recalc_rate = jh7100_clk_recalc_rate,
> +       .determine_rate = jh7100_clk_determine_rate,
> +       .set_rate = jh7100_clk_set_rate,
> +       .debug_init = jh7100_clk_debug_init,
> +};
> +
> +static const struct clk_ops jh7100_clk_mux_ops = {
> +       .determine_rate = jh7100_clk_mux_determine_rate,
> +       .set_parent = jh7100_clk_set_parent,
> +       .get_parent = jh7100_clk_get_parent,
> +       .debug_init = jh7100_clk_debug_init,
> +};
> +
> +static const struct clk_ops jh7100_clk_gmux_ops = {
> +       .enable = jh7100_clk_enable,
> +       .disable = jh7100_clk_disable,
> +       .is_enabled = jh7100_clk_is_enabled,
> +       .determine_rate = jh7100_clk_mux_determine_rate,
> +       .set_parent = jh7100_clk_set_parent,
> +       .get_parent = jh7100_clk_get_parent,
> +       .debug_init = jh7100_clk_debug_init,
> +};
> +
> +static const struct clk_ops jh7100_clk_mdiv_ops = {
> +       .recalc_rate = jh7100_clk_recalc_rate,
> +       .determine_rate = jh7100_clk_determine_rate,
> +       .get_parent = jh7100_clk_get_parent,
> +       .set_parent = jh7100_clk_set_parent,
> +       .set_rate = jh7100_clk_set_rate,
> +       .debug_init = jh7100_clk_debug_init,
> +};
> +
> +static const struct clk_ops jh7100_clk_gmd_ops = {
> +       .enable = jh7100_clk_enable,
> +       .disable = jh7100_clk_disable,
> +       .is_enabled = jh7100_clk_is_enabled,
> +       .recalc_rate = jh7100_clk_recalc_rate,
> +       .determine_rate = jh7100_clk_determine_rate,
> +       .get_parent = jh7100_clk_get_parent,
> +       .set_parent = jh7100_clk_set_parent,
> +       .set_rate = jh7100_clk_set_rate,
> +       .debug_init = jh7100_clk_debug_init,
> +};
> +
> +static const struct clk_ops jh7100_clk_inv_ops = {
> +       .get_phase = jh7100_clk_get_phase,
> +       .set_phase = jh7100_clk_set_phase,
> +       .debug_init = jh7100_clk_debug_init,
> +};
> +
> +const struct clk_ops *starfive_jh7100_clk_ops(u32 max)
> +{
> +       if (max & JH7100_CLK_DIV_MASK) {
> +               if (max & JH7100_CLK_MUX_MASK) {
> +                       if (max & JH7100_CLK_ENABLE)
> +                               return &jh7100_clk_gmd_ops;
> +                       return &jh7100_clk_mdiv_ops;
> +               }
> +               if (max & JH7100_CLK_ENABLE)
> +                       return &jh7100_clk_gdiv_ops;
> +               if (max == JH7100_CLK_FRAC_MAX)
> +                       return &jh7100_clk_fdiv_ops;
> +               return &jh7100_clk_div_ops;
> +       }
> +
> +       if (max & JH7100_CLK_MUX_MASK) {
> +               if (max & JH7100_CLK_ENABLE)
> +                       return &jh7100_clk_gmux_ops;
> +               return &jh7100_clk_mux_ops;
> +       }
> +
> +       if (max & JH7100_CLK_ENABLE)
> +               return &jh7100_clk_gate_ops;
> +
> +       return &jh7100_clk_inv_ops;
> +}
> +EXPORT_SYMBOL_GPL(starfive_jh7100_clk_ops);
> --
> 2.38.1
>
