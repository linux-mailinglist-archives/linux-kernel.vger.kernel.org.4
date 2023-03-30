Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB4E6D015E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjC3Kgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjC3Kgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:36:39 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679B8C4;
        Thu, 30 Mar 2023 03:36:37 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id c4so806337pjs.4;
        Thu, 30 Mar 2023 03:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680172597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FyQd6sbMLfRKTpCpmWoRbFYb0Wmig1BiUyo03E2Vdvs=;
        b=AkX7wiUAsePqi0jXhb9jRx1vQzVnds/haVlZ9goKCi7F1udi/DQAExdtk7i4ZXUGCp
         dIWY8cjXP+50Y29gintckbKSI7Z5HIki3e8Gu70gOrb/MzeJXk0SsJGcE3YZjGY6OOzM
         6uO/K860ctpM9MHf0yO+BISiKRY2KGXa09925KDgezbdAizy8kkHKeLQo6Ae6QCbRhNT
         A6hgL4FJQyzmLOUM0idYYvemWCnJzMf1GWVpmMvadZYtU1b6u6MSDF7w14XST4p51PZM
         SlECZ/7SGsJZkbgfswyDNJWP8D4EYD2SD2iXSvfgLrjTTclQkiGGYoqpLVoSeD7cyPAB
         DOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680172597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FyQd6sbMLfRKTpCpmWoRbFYb0Wmig1BiUyo03E2Vdvs=;
        b=7E579UFSMgi/k41cNFM1g48AgqzeblmOlla3o0LFp606WTjmS7mIfaQyWRE1TOvYdR
         WyIx7NUcnBM/4e7TMNYOKVtiGB9dDB9fbUjMbjCg4RBZiL8QxnBC1uDBTTUQS/26OBs6
         B45YVfmpYfOcliGqIDn2QT2jj5aFni6PgxTtO2yjdd+CkzqHacrjcEC+PaGgRlqRVuK9
         BMGCXPSq3fvmhiVP0W8dHWGPLUgFeVFw3ztx35SVysQjXteaYyHLNyeW/a8JkjymuwA7
         JYh5zCuXV4fJjHIrMUhi8pExiDvN/w0Pl2vaBCyEuj0r0isPLX2erHkVgGn41dff0iFW
         x6YQ==
X-Gm-Message-State: AAQBX9eSl1iiYxBdHP73J4Hct/VT6jcCymH4PkykyGPHW1lCfnW6OAnl
        0OQaZIxLArwa3cycLCqZrdY=
X-Google-Smtp-Source: AKy350YtoDGEKzaOnvxrfVw/9K5JJXJ3/Jm48sL6gBPn1MlYIfFGxvzp9OLuvj6hDUJA+T7AhrlaIA==
X-Received: by 2002:a17:902:c44c:b0:1a1:8edc:c5f8 with SMTP id m12-20020a170902c44c00b001a18edcc5f8mr19228788plm.56.1680172596480;
        Thu, 30 Mar 2023 03:36:36 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id bh4-20020a170902a98400b0019cb6222698sm9876977plb.266.2023.03.30.03.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 03:36:36 -0700 (PDT)
Message-ID: <86291f77-9bcc-3740-73b4-7968175c7348@gmail.com>
Date:   Thu, 30 Mar 2023 18:36:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 09/12] clk: nuvoton: Add clock driver for ma35d1 clock
 controller
To:     Stephen Boyd <sboyd@kernel.org>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-10-ychuang570808@gmail.com>
 <b425f98de9378ea8c725fef34fabade4.sboyd@kernel.org>
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <b425f98de9378ea8c725fef34fabade4.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Stephen,


Thanks for your advice.

On 2023/3/29 上午 02:18, Stephen Boyd wrote:
> Quoting Jacky Huang (2023-03-27 19:19:09)
>> diff --git a/drivers/clk/nuvoton/Kconfig b/drivers/clk/nuvoton/Kconfig
>> new file mode 100644
>> index 000000000000..c1324efedcb9
>> --- /dev/null
>> +++ b/drivers/clk/nuvoton/Kconfig
>> @@ -0,0 +1,19 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# common clock support for Nuvoton SoC family.
>> +
>> +config COMMON_CLK_NUVOTON
>> +       bool "Nuvoton clock controller common support"
>> +       depends on ARCH_NUVOTON
> Add || COMPILE_TEST
>
>> +       default ARCH_NUVOTON
>> +       help
>> +         Say y here to enable common clock controller for Nuvoton platforms.
>> +
>> +if COMMON_CLK_NUVOTON
> Add a newline here.
>
>> +config CLK_MA35D1
>> +       bool "Nuvoton MA35D1 clock controller support"
>> +       depends on ARM64 || COMPILE_TEST
> Drop this
>
>> +       default y
> And this.
>
>> +       help
>> +         Build the driver for MA35D1 Clock Driver.
> This says driver twice. "Build the clk driver for MA35D1 SoCs"?

I will fix all above of Kconfig file. Thank you.

>> +
>> +endif
>> diff --git a/drivers/clk/nuvoton/clk-ma35d1-divider.c b/drivers/clk/nuvoton/clk-ma35d1-divider.c
>> new file mode 100644
>> index 000000000000..340a889a1417
>> --- /dev/null
>> +++ b/drivers/clk/nuvoton/clk-ma35d1-divider.c
>> @@ -0,0 +1,140 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2023 Nuvoton Technology Corp.
>> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/spinlock.h>
>> +
>> +#include "clk-ma35d1.h"
>> +
>> +#define clk_div_mask(width)    ((1 << (width)) - 1)
> clk-provider.h defines this already, use that?

Yes, I will remove this.

>> +
>> +struct ma35d1_adc_clk_div {
>> +       struct clk_hw hw;
>> +       void __iomem *reg;
>> +       u8 shift;
>> +       u8 width;
>> +       u32 mask;
>> +       const struct clk_div_table *table;
>> +       /* protects concurrent access to clock divider registers */
>> +       spinlock_t *lock;
>> +};
>> +
>> +static inline struct ma35d1_adc_clk_div *to_ma35d1_adc_clk_div(struct clk_hw *_hw)
>> +{
>> +       return container_of(_hw, struct ma35d1_adc_clk_div, hw);
>> +}
>> +
>> +static inline unsigned long ma35d1_clkdiv_recalc_rate(struct clk_hw *hw,
>> +                                                     unsigned long parent_rate)
>> +{
>> +       unsigned int val;
>> +       struct ma35d1_adc_clk_div *dclk = to_ma35d1_adc_clk_div(hw);
>> +
>> +       val = readl_relaxed(dclk->reg) >> dclk->shift;
>> +       val &= clk_div_mask(dclk->width);
>> +       val += 1;
>> +       return divider_recalc_rate(hw, parent_rate, val, dclk->table,
>> +                                  CLK_DIVIDER_ROUND_CLOSEST, dclk->width);
>> +}
>> +
>> +static inline long ma35d1_clkdiv_round_rate(struct clk_hw *hw,
>> +                                           unsigned long rate,
>> +                                           unsigned long *prate)
>> +{
>> +       struct ma35d1_adc_clk_div *dclk = to_ma35d1_adc_clk_div(hw);
>> +
>> +       return divider_round_rate(hw, rate, prate, dclk->table,
>> +                                 dclk->width, CLK_DIVIDER_ROUND_CLOSEST);
>> +}
>> +
>> +static inline int ma35d1_clkdiv_set_rate(struct clk_hw *hw,
>> +                                        unsigned long rate,
>> +                                        unsigned long parent_rate)
>> +{
>> +       int value;
>> +       unsigned long flags = 0;
>> +       u32 data;
>> +       struct ma35d1_adc_clk_div *dclk = to_ma35d1_adc_clk_div(hw);
>> +
>> +       value = divider_get_val(rate, parent_rate, dclk->table,
>> +                               dclk->width, CLK_DIVIDER_ROUND_CLOSEST);
>> +
>> +       if (dclk->lock)
>> +               spin_lock_irqsave(dclk->lock, flags);
> Can you just always lock? That makes the conditional locking go away.

OK, I will remove the "if (dclk->lock)" check.

>
>> +
>> +       data = readl_relaxed(dclk->reg);
>> +       data &= ~(clk_div_mask(dclk->width) << dclk->shift);
>> +       data |= (value - 1) << dclk->shift;
>> +       data |= dclk->mask;
>> +
>> +       writel_relaxed(data, dclk->reg);
>> +
>> +       if (dclk->lock)
>> +               spin_unlock_irqrestore(dclk->lock, flags);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct clk_ops ma35d1_adc_clkdiv_ops = {
>> +       .recalc_rate = ma35d1_clkdiv_recalc_rate,
>> +       .round_rate = ma35d1_clkdiv_round_rate,
>> +       .set_rate = ma35d1_clkdiv_set_rate,
>> +};
>> +
>> +struct clk_hw *ma35d1_reg_adc_clkdiv(struct device *dev, const char *name,
>> +                                    const char *parent_name,
>> +                                    spinlock_t *lock,
>> +                                    unsigned long flags, void __iomem *reg,
>> +                                    u8 shift, u8 width, u32 mask_bit)
>> +{
>> +       struct ma35d1_adc_clk_div *div;
>> +       struct clk_init_data init;
>> +       struct clk_div_table *table;
>> +       u32 max_div, min_div;
>> +       struct clk_hw *hw;
>> +       int ret;
>> +       int i;
>> +
>> +       div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
>> +       if (!div)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       max_div = clk_div_mask(width) + 1;
>> +       min_div = 1;
>> +
>> +       table = devm_kcalloc(dev, max_div + 1, sizeof(*table), GFP_KERNEL);
>> +       if (!table)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       for (i = 0; i < max_div; i++) {
>> +               table[i].val = (min_div + i);
> Drop useless parenthesis.

I will fix it.

>
>> +               table[i].div = 2 * table[i].val;
>> +       }
>> +       table[max_div].val = 0;
>> +       table[max_div].div = 0;
>> +
>> +       init.name = name;
>> +       init.ops = &ma35d1_adc_clkdiv_ops;
>> +       init.flags |= flags;
>> +       init.parent_names = parent_name ? &parent_name : NULL;
>> +       init.num_parents = parent_name ? 1 : 0;
>> +
>> +       div->reg = reg;
>> +       div->shift = shift;
>> +       div->width = width;
>> +       div->mask = mask_bit ? BIT(mask_bit) : 0;
>> +       div->lock = lock;
>> +       div->hw.init = &init;
>> +       div->table = table;
>> +
>> +       hw = &div->hw;
>> +       ret = devm_clk_hw_register(dev, hw);
>> +       if (ret < 0)
> Use if (ret) instead.

I will fix it.

>
>> +               return ERR_PTR(ret);
>> +       return hw;
>> +}
>> diff --git a/drivers/clk/nuvoton/clk-ma35d1-pll.c b/drivers/clk/nuvoton/clk-ma35d1-pll.c
>> new file mode 100644
>> index 000000000000..b36fbda4fa0a
>> --- /dev/null
>> +++ b/drivers/clk/nuvoton/clk-ma35d1-pll.c
>> @@ -0,0 +1,350 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2023 Nuvoton Technology Corp.
>> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/slab.h>
>> +#include <linux/regmap.h>
>> +
>> +#include "clk-ma35d1.h"
>> +
>> +#define REG_SYS_RLKTZNS                0x1a4 /* Register Lock Control */
>> +
>> +struct ma35d1_clk_pll {
>> +       struct clk_hw hw;
>> +       u8 type;
>> +       u8 mode;
>> +       unsigned long rate;
>> +       void __iomem *ctl0_base;
> This needs an include for __iomem define. Just include kernel.h for now.

OK, I will add it.

>> +       void __iomem *ctl1_base;
>> +       void __iomem *ctl2_base;
>> +       struct regmap *regmap;
>> +};
>> +
>> +static inline struct ma35d1_clk_pll *to_ma35d1_clk_pll(struct clk_hw *_hw)
>> +{
>> +       return container_of(_hw, struct ma35d1_clk_pll, hw);
> Missing include as well.

I will add the
#include <linux/container_of.h>

>
>> +}
>> +
>> +static void ma35d1_unlock_regs(struct ma35d1_clk_pll *pll)
>> +{
>> +       int ret;
>> +
>> +       do {
>> +               regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x59);
>> +               regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x16);
>> +               regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x88);
>> +               regmap_read(pll->regmap, REG_SYS_RLKTZNS, &ret);
>> +       } while (ret == 0);
> Any sort of timeout?

As we have discussed in [PATCH v6 08/12] of this patchset, we will 
remove the register lock.
So, this function will be removed in the next version.

>> +}
>> +
>> +static void ma35d1_lock_regs(struct ma35d1_clk_pll *pll)
>> +{
>> +       regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x0);
>> +}
>> +
>> +static unsigned long ma35d1_calc_smic_pll_freq(u32 pll0_ctl0,
>> +                                              unsigned long parent_rate)
>> +{
>> +       u32 m, n, p, outdiv;
>> +       u64 pll_freq;
>> +       u32 clk_div_table[] = { 1, 2, 4, 8 };
> const

OK, I will add const to the clk_div_table[].
>
>> +
>> +       if (pll0_ctl0 & SPLL0_CTL0_BP)
>> +               return parent_rate;
>> +
>> +       n = FIELD_GET(SPLL0_CTL0_FBDIV, pll0_ctl0);
>> +       m = FIELD_GET(SPLL0_CTL0_INDIV, pll0_ctl0);
>> +       p = FIELD_GET(SPLL0_CTL0_OUTDIV, pll0_ctl0);
>> +       outdiv = clk_div_table[p];
>> +       pll_freq = (u64)parent_rate * n;
>> +       do_div(pll_freq, m * outdiv);
>> +       return (unsigned long)pll_freq;
> Remove useless cast.

I will fix it.

>> +}
>> +
>> +static unsigned long ma35d1_calc_pll_freq(u8 mode, u32 *reg_ctl,
>> +                                         unsigned long parent_rate)
>> +{
>> +       u32 m, n, p;
>> +       u64 pll_freq, x;
>> +
>> +       if (reg_ctl[1] & PLL_CTL1_BP)
>> +               return parent_rate;
>> +
>> +       if (mode == PLL_MODE_INT) {
>> +               n = FIELD_GET(PLL_CTL0_FBDIV, reg_ctl[0]);
>> +               m = FIELD_GET(PLL_CTL0_INDIV, reg_ctl[0]);
>> +               p = FIELD_GET(PLL_CTL1_OUTDIV, reg_ctl[1]);
>> +               pll_freq = (u64)parent_rate * n;
>> +               do_div(pll_freq, m * p);
>> +       } else {
>> +               n = FIELD_GET(PLL_CTL0_FBDIV, reg_ctl[0]);
>> +               m = FIELD_GET(PLL_CTL0_INDIV, reg_ctl[0]);
>> +               p = FIELD_GET(PLL_CTL1_OUTDIV, reg_ctl[1]);
> The n, m, p are the same, so pull them out of the if-else to deduplicate.

Ok, I will modify it.

>
>> +               x = FIELD_GET(PLL_CTL1_FRAC, reg_ctl[1]);
>> +               /* 2 decimal places floating to integer (ex. 1.23 to 123) */
>> +               n = n * 100 + ((x * 100) / FIELD_MAX(PLL_CTL1_FRAC));
> Is this mult_frac()?

Not exactly. The number is represented as n.x.
Suppose the number is 123.45, then n is 123 and x is 45.
We have it be multiplied with 100 to be integer 12345, which is n.

In the following
pll_freq = ((u64)parent_rate * n) / 100 / m / p;

We can keep precision of n.

It seems not applicable to mult_frac().

>
>> +               pll_freq = ((u64)parent_rate * n) / 100 / m / p;
>> +       }
> Add a newline
>
>> +       return (unsigned long)pll_freq;
> Remove useless cast.

I will fix them.

>> +}
>> +
>> +static int ma35d1_pll_find_closest(struct ma35d1_clk_pll *pll,
>> +                                  unsigned long rate,
>> +                                  unsigned long parent_rate,
>> +                                  u32 *reg_ctl, unsigned long *freq)
>> +{
>> +       int p, m, n;
>> +       int fbdiv_min, fbdiv_max;
>> +       unsigned long diff = 0xffffffff;
>> +
>> +       *freq = 0;
>> +       if ((rate < PLL_FCLKO_MIN_FREQ) || (rate > PLL_FCLKO_MAX_FREQ))
>> +               return -EINVAL;
>> +
>> +       if (pll->mode == PLL_MODE_INT) {
>> +               fbdiv_min = FBDIV_MIN;
>> +               fbdiv_max = FBDIV_MAX;
>> +       } else {
>> +               fbdiv_min = FBDIV_FRAC_MIN;
>> +               fbdiv_max = FBDIV_FRAC_MAX;
>> +       }
>> +
>> +       for (m = INDIV_MIN; m <= INDIV_MAX; m++) {
>> +               for (n = fbdiv_min; n <= fbdiv_max; n++) {
>> +                       for (p = OUTDIV_MIN; p <= OUTDIV_MAX; p++) {
>> +                               unsigned long tmp, fout;
>> +                               u64 fclk;
>> +
>> +                               tmp = parent_rate / m;
>> +                               if (tmp < PLL_FREF_M_MIN_FREQ ||
>> +                                   tmp > PLL_FREF_M_MAX_FREQ)
>> +                                       continue; /* constrain */
>> +
>> +                               fclk = (u64)parent_rate * n / m;
>> +                               /* for 2 decimal places */
>> +                               if (pll->mode != PLL_MODE_INT)
>> +                                       fclk /= 100;
>> +
>> +                               if (fclk < PLL_FCLK_MIN_FREQ ||
>> +                                   fclk > PLL_FCLK_MAX_FREQ)
>> +                                       continue; /* constrain */
>> +
>> +                               fout = (unsigned long)(fclk / p);
>> +                               if (fout < PLL_FCLKO_MIN_FREQ ||
>> +                                   fout > PLL_FCLKO_MAX_FREQ)
>> +                                       continue; /* constrain */
>> +
>> +                               if (abs(rate - fout) < diff) {
>> +                                       reg_ctl[0] = FIELD_PREP(PLL_CTL0_INDIV, m) |
>> +                                                    FIELD_PREP(PLL_CTL0_FBDIV, n);
>> +                                       reg_ctl[1] = FIELD_PREP(PLL_CTL1_OUTDIV, p);
>> +                                       *freq = fout;
>> +                                       diff = abs(rate - fout);
>> +                                       if (diff == 0)
>> +                                               break;
>> +                               }
>> +                       }
>> +               }
>> +       }
>> +       if (*freq == 0)
>> +               return -EINVAL; /* cannot find even one valid setting */
>> +       return 0;
>> +}
>> +
>> +static int ma35d1_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>> +                                  unsigned long parent_rate)
>> +{
>> +       struct ma35d1_clk_pll *pll = to_ma35d1_clk_pll(hw);
>> +       u32 reg_ctl[3] = { 0 };
>> +       unsigned long pll_freq;
>> +       int ret;
>> +
>> +       if ((parent_rate < PLL_FREF_MIN_FREQ) ||
>> +           (parent_rate > PLL_FREF_MAX_FREQ))
> Remove useless parenthesis.
>
>> +               return -EINVAL;
>> +
>> +       if ((pll->type == MA35D1_CAPLL) || (pll->type == MA35D1_DDRPLL)) {
> Remove useless parenthesis.

I will fix them.

>> +               pr_warn("Nuvoton MA35D1 CAPLL/DDRPLL is read only.\n");
>> +               return -EACCES;
>> +       }
>> +
>> +       ret = ma35d1_pll_find_closest(pll, rate, parent_rate, reg_ctl, &pll_freq);
>> +       if (ret != 0)
>> +               return ret;
>> +       pll->rate = pll_freq;
>> +
>> +       switch (pll->mode) {
>> +       case PLL_MODE_INT:
>> +               reg_ctl[0] |= FIELD_PREP(PLL_CTL0_MODE, PLL_MODE_INT);
>> +               break;
>> +       case PLL_MODE_FRAC:
>> +               reg_ctl[0] |= FIELD_PREP(PLL_CTL0_MODE, PLL_MODE_FRAC);
>> +               break;
>> +       case PLL_MODE_SS:
>> +               reg_ctl[0] |= FIELD_PREP(PLL_CTL0_MODE, PLL_MODE_SS) |
>> +                             FIELD_PREP(PLL_CTL0_SSRATE, PLL_SS_RATE);
>> +               reg_ctl[2] = FIELD_PREP(PLL_CTL2_SLOPE, PLL_SLOPE);
>> +               break;
>> +       }
>> +       reg_ctl[1] |= PLL_CTL1_PD;
>> +
>> +       ma35d1_unlock_regs(pll);
>> +       writel_relaxed(reg_ctl[0], pll->ctl0_base);
>> +       writel_relaxed(reg_ctl[1], pll->ctl1_base);
>> +       writel_relaxed(reg_ctl[2], pll->ctl2_base);
>> +       ma35d1_lock_regs(pll);
>> +       return 0;
>> +}
>> +
>> +static unsigned long ma35d1_clk_pll_recalc_rate(struct clk_hw *hw,
>> +                                               unsigned long parent_rate)
>> +{
>> +       struct ma35d1_clk_pll *pll = to_ma35d1_clk_pll(hw);
>> +       u32 reg_ctl[3];
>> +       unsigned long pll_freq;
>> +
>> +       if ((parent_rate < PLL_FREF_MIN_FREQ) || (parent_rate > PLL_FREF_MAX_FREQ))
> Remove useless parenthesis.

I will fix it.

>
>> +               return 0;
>> +
>> +       switch (pll->type) {
>> +       case MA35D1_CAPLL:
>> +               reg_ctl[0] = readl_relaxed(pll->ctl0_base);
>> +               pll_freq = ma35d1_calc_smic_pll_freq(reg_ctl[0], parent_rate);
> return?

Yes, I will have it return here.

>> +               break;
>> +       case MA35D1_DDRPLL:
>> +       case MA35D1_APLL:
>> +       case MA35D1_EPLL:
>> +       case MA35D1_VPLL:
>> +               reg_ctl[0] = readl_relaxed(pll->ctl0_base);
>> +               reg_ctl[1] = readl_relaxed(pll->ctl1_base);
>> +               pll_freq = ma35d1_calc_pll_freq(pll->mode, reg_ctl, parent_rate);
> return?
>
>> +               break;
>> +       }
>> +       return pll_freq;
> return 0?

Yes, I will fix them.

>
>> +}
>> +
>> +static long ma35d1_clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
>> +                                     unsigned long *parent_rate)
>> +{
>> +       struct ma35d1_clk_pll *pll = to_ma35d1_clk_pll(hw);
>> +       u32 reg_ctl[3] = { 0 };
>> +       unsigned long pll_freq;
>> +       long ret;
>> +
>> +       if (*parent_rate < PLL_FREF_MIN_FREQ || *parent_rate > PLL_FREF_MAX_FREQ)
>> +               return -EINVAL;
>> +
>> +       ret = ma35d1_pll_find_closest(pll, rate, *parent_rate, reg_ctl, &pll_freq);
>> +       if (ret != 0)
>> +               return ret;
>> +
>> +       switch (pll->type) {
>> +       case MA35D1_CAPLL:
>> +               reg_ctl[0] = readl_relaxed(pll->ctl0_base);
>> +               pll_freq = ma35d1_calc_smic_pll_freq(reg_ctl[0], *parent_rate);
> return?
>
>> +               break;
>> +       case MA35D1_DDRPLL:
>> +       case MA35D1_APLL:
>> +       case MA35D1_EPLL:
>> +       case MA35D1_VPLL:
>> +               reg_ctl[0] = readl_relaxed(pll->ctl0_base);
>> +               reg_ctl[1] = readl_relaxed(pll->ctl1_base);
>> +               pll_freq = ma35d1_calc_pll_freq(pll->mode, reg_ctl, *parent_rate);
> return?
>
>> +               break;
>> +       }
>> +       return pll_freq;
> return 0?

Yes, I will fix them.

>> +}
>> +
>> +static int ma35d1_clk_pll_is_prepared(struct clk_hw *hw)
>> +{
>> +       struct ma35d1_clk_pll *pll = to_ma35d1_clk_pll(hw);
>> +       u32 val = readl_relaxed(pll->ctl1_base);
>> +
>> +       return val & PLL_CTL1_PD ? 0 : 1;
>> +}
>> +
>> +static int ma35d1_clk_pll_prepare(struct clk_hw *hw)
>> +{
>> +       struct ma35d1_clk_pll *pll = to_ma35d1_clk_pll(hw);
>> +       u32 val;
>> +
>> +       if ((pll->type == MA35D1_CAPLL) || (pll->type == MA35D1_DDRPLL)) {
> Drop useless parenthesis.

I will fix it.

>
>> +               pr_warn("Nuvoton MA35D1 CAPLL/DDRPLL is read only.\n");
>> +               return -EACCES;
>> +       }
>> +
>> +       ma35d1_unlock_regs(pll);
>> +       val = readl_relaxed(pll->ctl1_base);
>> +       val &= ~PLL_CTL1_PD;
>> +       writel_relaxed(val, pll->ctl1_base);
>> +       ma35d1_lock_regs(pll);
>> +       return 0;
>> +}
>> +
>> +static void ma35d1_clk_pll_unprepare(struct clk_hw *hw)
>> +{
>> +       struct ma35d1_clk_pll *pll = to_ma35d1_clk_pll(hw);
>> +       u32 val;
>> +
>> +       if ((pll->type == MA35D1_CAPLL) || (pll->type == MA35D1_DDRPLL)) {
> Drop useless parenthesis.

I will fix it.

>
>> +               pr_warn("Nuvoton MA35D1 CAPLL/DDRPLL is read only.\n");
> These read-only checks should be removed and different clk_ops should be
> assigned for the read-only type of clks.

OK, I will fix it.

>> +       } else {
>> +               val = readl_relaxed(pll->ctl1_base);
>> +               val |= PLL_CTL1_PD;
>> +               writel_relaxed(val, pll->ctl1_base);
>> +       }
>> +}
>> +
>> +static const struct clk_ops ma35d1_clk_pll_ops = {
>> +       .is_prepared = ma35d1_clk_pll_is_prepared,
>> +       .prepare = ma35d1_clk_pll_prepare,
>> +       .unprepare = ma35d1_clk_pll_unprepare,
>> +       .set_rate = ma35d1_clk_pll_set_rate,
>> +       .recalc_rate = ma35d1_clk_pll_recalc_rate,
>> +       .round_rate = ma35d1_clk_pll_round_rate,
>> +};
>> +
>> +struct clk_hw *ma35d1_reg_clk_pll(enum ma35d1_pll_type type,
> Pass a device here.

OK, I will add it.

>> +                                 u8 u8mode, const char *name,
>> +                                 const char *parent,
>> +                                 unsigned long targetFreq,
>> +                                 void __iomem *base,
>> +                                 struct regmap *regmap)
>> +{
>> +       struct ma35d1_clk_pll *pll;
>> +       struct clk_hw *hw;
>> +       struct clk_init_data init;
> init = {};
>
>> +       int ret;
>> +
>> +       pll = kmalloc(sizeof(*pll), GFP_KERNEL);
> Just use kzalloc(). This isn't a hot path.

I will use devm_kzalloc().

>> +       if (!pll)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       pll->type = type;
>> +       pll->mode = u8mode;
>> +       pll->rate = targetFreq;
>> +       pll->ctl0_base = base + REG_PLL_CTL0_OFFSET;
>> +       pll->ctl1_base = base + REG_PLL_CTL1_OFFSET;
>> +       pll->ctl2_base = base + REG_PLL_CTL2_OFFSET;
>> +       pll->regmap = regmap;
>> +
>> +       init.name = name;
>> +       init.flags = 0;
>> +       init.parent_names = &parent;
>> +       init.num_parents = 1;
>> +       init.ops = &ma35d1_clk_pll_ops;
>> +       pll->hw.init = &init;
>> +       hw = &pll->hw;
>> +
>> +       ret = clk_hw_register(NULL, hw);
> Use devm_

OK, I will fix it.

>
>> +       if (ret) {
>> +               pr_err("failed to register vsi-pll clock!!!\n");
> I'm going to put a dev_err_probe() into clk registration code. Remove
> this printk.

OK, I will remove it.

>> +               kfree(pll);
>> +               return ERR_PTR(ret);
>> +       }
>> +       return hw;
>> +}
>> diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
>> new file mode 100644
>> index 000000000000..e4d3ced396a3
>> --- /dev/null
>> +++ b/drivers/clk/nuvoton/clk-ma35d1.c
>> @@ -0,0 +1,963 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2023 Nuvoton Technology Corp.
>> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/spinlock.h>
>> +#include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +
>> +#include "clk-ma35d1.h"
>> +
>> +static DEFINE_SPINLOCK(ma35d1_lock);
>> +
>> +static const char *const ca35clk_sel_clks[] = {
> Use clk_parent_data instead.

I will fix it.

>
>> +       "hxt", "capll", "ddrpll", "dummy"
>> +};
>> +
> [...]
>> +
>> +static inline struct clk_hw *ma35d1_clk_fixed(const char *name, int rate)
>> +{
>> +       return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
>> +}
>> +
>> +static inline struct clk_hw *ma35d1_clk_mux(const char *name,
>> +                                           void __iomem *reg,
>> +                                           u8 shift, u8 width,
>> +                                           const char *const *parents,
>> +                                           int num_parents)
>> +{
>> +       return clk_hw_register_mux(NULL, name, parents, num_parents,
>> +                                  CLK_SET_RATE_NO_REPARENT, reg, shift,
>> +                                  width, 0, &ma35d1_lock);
>> +}
>> +
>> +static inline struct clk_hw *ma35d1_clk_divider(const char *name,
>> +                                               const char *parent,
>> +                                               void __iomem *reg, u8 shift,
>> +                                               u8 width)
>> +{
>> +       return clk_hw_register_divider(NULL, name, parent, CLK_SET_RATE_PARENT,
>> +                                      reg, shift, width, 0, &ma35d1_lock);
>> +}
>> +
>> +static inline struct clk_hw *ma35d1_clk_divider_pow2(const char *name,
>> +                                                    const char *parent,
>> +                                                    void __iomem *reg,
>> +                                                    u8 shift, u8 width)
>> +{
>> +       return clk_hw_register_divider(NULL, name, parent,
>> +                                      CLK_DIVIDER_POWER_OF_TWO, reg, shift,
>> +                                      width, 0, &ma35d1_lock);
>> +}
>> +
>> +static inline struct clk_hw *ma35d1_clk_divider_table(const char *name,
>> +                                       const char *parent,
>> +                                       void __iomem *reg,
>> +                                       u8 shift, u8 width,
>> +                                       const struct clk_div_table *table)
>> +{
>> +       return clk_hw_register_divider_table(NULL, name, parent, 0,
>> +                                            reg, shift, width, 0, table,
>> +                                            &ma35d1_lock);
>> +}
>> +
>> +static inline struct clk_hw *ma35d1_clk_fixed_factor(const char *name,
>> +                                                    const char *parent,
>> +                                                    unsigned int mult,
>> +                                                    unsigned int div)
>> +{
>> +       return clk_hw_register_fixed_factor(NULL, name, parent,
>> +                                           CLK_SET_RATE_PARENT, mult, div);
>> +}
>> +
>> +static inline struct clk_hw *ma35d1_clk_gate(const char *name,
>> +                                            const char *parent,
>> +                                            void __iomem *reg, u8 shift)
>> +{
>> +       return clk_hw_register_gate(NULL, name, parent, CLK_SET_RATE_PARENT,
>> +                                   reg, shift, 0, &ma35d1_lock);
>> +}
> These need to use devm_ to unregister on failure.

OK, I will fix them all.

>> +
>> +static int ma35d1_get_pll_setting(struct device_node *clk_node,
>> +                                 u32 *pllmode, u32 *pllfreq)
>> +{
>> +       const char *of_str;
>> +       int i;
>> +
>> +       for (i = 0; i < PLL_MAX_NUM; i++) {
>> +               if (of_property_read_string_index(clk_node, "nuvoton,pll-mode", i, &of_str))
>> +                       return -EINVAL;
>> +               if (!strcmp(of_str, "integer"))
>> +                       pllmode[i] = PLL_MODE_INT;
>> +               else if (!strcmp(of_str, "fractional"))
>> +                       pllmode[i] = PLL_MODE_FRAC;
>> +               else if (!strcmp(of_str, "spread-spectrum"))
>> +                       pllmode[i] = PLL_MODE_SS;
>> +               else
>> +                       return -EINVAL;
>> +       }
>> +       return of_property_read_u32_array(clk_node, "assigned-clock-rates",
> The clk framework looks at this property. Why is the driver looking at
> it too?

We should not use "assigned-clock-rates", instead we should create a
vendor-specific property to describe the pll frequency array.

I will fix it in the next version.


>> +                                         pllfreq, PLL_MAX_NUM);
>> +}
>> +


Best regards,
Jacky Huang

