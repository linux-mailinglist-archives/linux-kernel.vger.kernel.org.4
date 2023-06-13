Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D7972D70A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238389AbjFMBhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjFMBhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:37:41 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F589BA;
        Mon, 12 Jun 2023 18:37:38 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-75d4094f9baso45378485a.1;
        Mon, 12 Jun 2023 18:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686620257; x=1689212257;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xfXyedCW9caMGoIU8YcNXcNxtnnUDM81M0oJnaMPvj0=;
        b=AoikSY9Zs3LPomQayJ1LYcjv+iVFAmL2TQXHHSjphWe0aMz3ZRTZ98hrGzb/0CCPPB
         90SSj69YCJQSiINQzeYQKwsWQ5PFqtLHB/wKS91lB8FMwYrvbNzFdOBwvjvsm/omvIR7
         flLRJVuXXx1uam+KOL7uluDJYUIiUWc7NgsSl3F1yX5TqJn4Cx5ZktUIhbn6hLTx6A5O
         BuSDKleMh3/bWbxDp3IK5oXonoCAbSpEyf3sU4uBKZH8tqH00QkNwIpebmh1SGquLhIz
         10XRXDSfOLLpVf3hAwC+VpoqlcHCRGociDHlRHLFrQHO9HPWM3CpmWZaApTDLCo+w6BL
         WEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686620257; x=1689212257;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfXyedCW9caMGoIU8YcNXcNxtnnUDM81M0oJnaMPvj0=;
        b=j/XE05m/TdaaD5+xFBvagEXuSpqZNYlUrS7LTvqZ9CtwL3KEoZiOf7zppOobfcDljy
         59auPdwTWWbviWtobiCkF4RvUL5YHz7aIxVAqd8M6I4oqyQu0oNwhW44Zn9Tvg0eQnyX
         +iRc2x0d0gRx5m27ujtLQkA312IeXfqsaY21VqR0wnHzqDaAlvWIhFlNB2gIldokYvdd
         BsmGx6fj3UNE2HWIchHB8Yid9YsC4+YRiws98FpXgLC4D9IKm3gzdCMCNXQtd2D7Bjdm
         w3ASi2tSO2hbgBQ6bgMJK8bCEoJdEhM/GomAgAPwNt0GHMYQc9sS3Y1WftlSzFqU2C0g
         uVyw==
X-Gm-Message-State: AC+VfDx0iRK7NXUN0lz9X3LaghPh4eyRdWu82vQMfPgPlFhOwec8P49v
        HaLRcBov9cEZR4HbyeVK2+k=
X-Google-Smtp-Source: ACHHUZ4etzmMEP/U5MLPlMDSE8KONRdJkCJslOZGUBHxO5iGKUghFFds2BL55wvksX9m4Gp7+Ygkdw==
X-Received: by 2002:a05:620a:2483:b0:761:f5d2:16ec with SMTP id i3-20020a05620a248300b00761f5d216ecmr337241qkn.66.1686620257412;
        Mon, 12 Jun 2023 18:37:37 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id v9-20020a17090a458900b0025bcdada95asm3440638pjg.38.2023.06.12.18.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 18:37:36 -0700 (PDT)
Message-ID: <233f4e83-e872-5499-2ca7-a1c277425fb0@gmail.com>
Date:   Tue, 13 Jun 2023 09:37:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v13 08/10] clk: nuvoton: Add clock driver for ma35d1 clock
 controller
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, tmaimon77@gmail.com, will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, soc@kernel.org,
        schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230605040749.67964-1-ychuang570808@gmail.com>
 <20230605040749.67964-9-ychuang570808@gmail.com>
 <bda5f640831a8080a83eca8c8e37c30d.sboyd@kernel.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <bda5f640831a8080a83eca8c8e37c30d.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Stephen,


On 2023/6/13 上午 09:02, Stephen Boyd wrote:
> Quoting Jacky Huang (2023-06-04 21:07:47)
>> diff --git a/drivers/clk/nuvoton/clk-ma35d1-divider.c b/drivers/clk/nuvoton/clk-ma35d1-divider.c
>> new file mode 100644
>> index 000000000000..0c2bed47909a
>> --- /dev/null
>> +++ b/drivers/clk/nuvoton/clk-ma35d1-divider.c
>> @@ -0,0 +1,135 @@
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
>> +struct clk_hw *ma35d1_reg_adc_clkdiv(struct device *dev, const char *name,
>> +                                    struct clk_hw *parent_hw, spinlock_t *lock,
>> +                                    unsigned long flags, void __iomem *reg,
>> +                                    u8 shift, u8 width, u32 mask_bit);
> Why is this forward declared?

Yes, it's unused. I will remove this declaration.

>
>> +
>> +static inline struct ma35d1_adc_clk_div *to_ma35d1_adc_clk_div(struct clk_hw *_hw)
>> +{
>> +       return container_of(_hw, struct ma35d1_adc_clk_div, hw);
>> +}
>> +
>> +static unsigned long ma35d1_clkdiv_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
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
>> +static long ma35d1_clkdiv_round_rate(struct clk_hw *hw, unsigned long rate, unsigned long *prate)
>> +{
>> +       struct ma35d1_adc_clk_div *dclk = to_ma35d1_adc_clk_div(hw);
>> +
>> +       return divider_round_rate(hw, rate, prate, dclk->table,
>> +                                 dclk->width, CLK_DIVIDER_ROUND_CLOSEST);
>> +}
>> +
>> +static int ma35d1_clkdiv_set_rate(struct clk_hw *hw, unsigned long rate, unsigned long parent_rate)
>> +{
>> +       int value;
>> +       unsigned long flags = 0;
>> +       u32 data;
>> +       struct ma35d1_adc_clk_div *dclk = to_ma35d1_adc_clk_div(hw);
>> +
>> +       value = divider_get_val(rate, parent_rate, dclk->table,
>> +                               dclk->width, CLK_DIVIDER_ROUND_CLOSEST);
>> +
>> +       spin_lock_irqsave(dclk->lock, flags);
>> +
>> +       data = readl_relaxed(dclk->reg);
>> +       data &= ~(clk_div_mask(dclk->width) << dclk->shift);
>> +       data |= (value - 1) << dclk->shift;
>> +       data |= dclk->mask;
>> +       writel_relaxed(data, dclk->reg);
>> +
>> +       spin_unlock_irqrestore(dclk->lock, flags);
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
>> +                                    struct clk_hw *parent_hw, spinlock_t *lock,
>> +                                    unsigned long flags, void __iomem *reg,
>> +                                    u8 shift, u8 width, u32 mask_bit)
>> +{
>> +       struct ma35d1_adc_clk_div *div;
>> +       struct clk_init_data init;
>> +       struct clk_div_table *table;
>> +       struct clk_parent_data pdata = { .index = 0 };
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
>> +               table[i].val = min_div + i;
>> +               table[i].div = 2 * table[i].val;
>> +       }
>> +       table[max_div].val = 0;
>> +       table[max_div].div = 0;
>> +
>> +       memset(&init, 0, sizeof(init));
>> +       init.name = name;
>> +       init.ops = &ma35d1_adc_clkdiv_ops;
>> +       init.flags |= flags;
>> +       pdata.hw = parent_hw;
>> +       init.parent_data = &pdata;
>> +       init.num_parents = 1;
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
>> +       if (ret)
>> +               return ERR_PTR(ret);
>> +       return hw;
>> +}
>> +EXPORT_SYMBOL_GPL(ma35d1_reg_adc_clkdiv);
>> diff --git a/drivers/clk/nuvoton/clk-ma35d1-pll.c b/drivers/clk/nuvoton/clk-ma35d1-pll.c
>> new file mode 100644
>> index 000000000000..e4c9f94e6796
>> --- /dev/null
>> +++ b/drivers/clk/nuvoton/clk-ma35d1-pll.c
>> @@ -0,0 +1,361 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2023 Nuvoton Technology Corp.
>> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/container_of.h>
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/math64.h>
>> +#include <linux/slab.h>
>> +#include <linux/units.h>
>> +#include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +
>> +/* PLL frequency limits */
>> +#define PLL_FREF_MAX_FREQ      (200 * HZ_PER_MHZ)
>> +#define PLL_FREF_MIN_FREQ      (1 * HZ_PER_MHZ)
>> +#define PLL_FREF_M_MAX_FREQ    (40 * HZ_PER_MHZ)
>> +#define PLL_FREF_M_MIN_FREQ    (10 * HZ_PER_MHZ)
>> +#define PLL_FCLK_MAX_FREQ      (2400 * HZ_PER_MHZ)
>> +#define PLL_FCLK_MIN_FREQ      (600 * HZ_PER_MHZ)
>> +#define PLL_FCLKO_MAX_FREQ     (2400 * HZ_PER_MHZ)
>> +#define PLL_FCLKO_MIN_FREQ     (85700 * HZ_PER_KHZ)
>> +#define PLL_SS_RATE            0x77
>> +#define PLL_SLOPE              0x58CFA
>> +
>> +#define REG_PLL_CTL0_OFFSET    0x0
>> +#define REG_PLL_CTL1_OFFSET    0x4
>> +#define REG_PLL_CTL2_OFFSET    0x8
>> +
>> +/* bit fields for REG_CLK_PLL0CTL0, which is SMIC PLL design */
>> +#define SPLL0_CTL0_FBDIV       GENMASK(7, 0)
>> +#define SPLL0_CTL0_INDIV       GENMASK(11, 8)
>> +#define SPLL0_CTL0_OUTDIV      GENMASK(13, 12)
>> +#define SPLL0_CTL0_PD          BIT(16)
>> +#define SPLL0_CTL0_BP          BIT(17)
>> +
>> +/* bit fields for REG_CLK_PLLxCTL0 ~ REG_CLK_PLLxCTL2, where x = 2 ~ 5 */
>> +#define PLL_CTL0_FBDIV         GENMASK(10, 0)
>> +#define PLL_CTL0_INDIV         GENMASK(17, 12)
>> +#define PLL_CTL0_MODE          GENMASK(19, 18)
>> +#define PLL_CTL0_SSRATE                GENMASK(30, 20)
>> +#define PLL_CTL1_PD            BIT(0)
>> +#define PLL_CTL1_BP            BIT(1)
>> +#define PLL_CTL1_OUTDIV                GENMASK(6, 4)
>> +#define PLL_CTL1_FRAC          GENMASK(31, 24)
>> +#define PLL_CTL2_SLOPE         GENMASK(23, 0)
>> +
>> +#define INDIV_MIN              1
>> +#define INDIV_MAX              63
>> +#define FBDIV_MIN              16
>> +#define FBDIV_MAX              2047
>> +#define FBDIV_FRAC_MIN         1600
>> +#define FBDIV_FRAC_MAX         204700
>> +#define OUTDIV_MIN             1
>> +#define OUTDIV_MAX             7
>> +
>> +#define PLL_MODE_INT            0
>> +#define PLL_MODE_FRAC           1
>> +#define PLL_MODE_SS             2
>> +
>> +struct ma35d1_clk_pll {
>> +       struct clk_hw hw;
>> +       u32 id;
>> +       u8 mode;
>> +       void __iomem *ctl0_base;
>> +       void __iomem *ctl1_base;
>> +       void __iomem *ctl2_base;
>> +};
>> +
>> +struct clk_hw *ma35d1_reg_clk_pll(struct device *dev, u32 id, u8 u8mode, const char *name,
>> +                                 struct clk_hw *parent_hw, void __iomem *base);
> Why is this forward declared?

I will remove it.

>
>> +
>> +static inline struct ma35d1_clk_pll *to_ma35d1_clk_pll(struct clk_hw *_hw)
>> +{
>> +       return container_of(_hw, struct ma35d1_clk_pll, hw);
>> +}
>> +
>> +static unsigned long ma35d1_calc_smic_pll_freq(u32 pll0_ctl0,
>> +                                              unsigned long parent_rate)
>> +{
>> +       u32 m, n, p, outdiv;
>> +       u64 pll_freq;
>> +
>> +       if (pll0_ctl0 & SPLL0_CTL0_BP)
>> +               return parent_rate;
>> +
>> +       n = FIELD_GET(SPLL0_CTL0_FBDIV, pll0_ctl0);
>> +       m = FIELD_GET(SPLL0_CTL0_INDIV, pll0_ctl0);
>> +       p = FIELD_GET(SPLL0_CTL0_OUTDIV, pll0_ctl0);
>> +       outdiv = 1 << p;
>> +       pll_freq = (u64)parent_rate * n;
>> +       div_u64(pll_freq, m * outdiv);
>> +       return pll_freq;
>> +}
>> +
>> +static unsigned long ma35d1_calc_pll_freq(u8 mode, u32 *reg_ctl, unsigned long parent_rate)
>> +{
>> +       unsigned long pll_freq, x;
>> +       u32 m, n, p;
>> +
>> +       if (reg_ctl[1] & PLL_CTL1_BP)
>> +               return parent_rate;
>> +
>> +       n = FIELD_GET(PLL_CTL0_FBDIV, reg_ctl[0]);
>> +       m = FIELD_GET(PLL_CTL0_INDIV, reg_ctl[0]);
>> +       p = FIELD_GET(PLL_CTL1_OUTDIV, reg_ctl[1]);
>> +
>> +       if (mode == PLL_MODE_INT) {
>> +               pll_freq = (u64)parent_rate * n;
>> +               div_u64(pll_freq, m * p);
>> +       } else {
>> +               x = FIELD_GET(PLL_CTL1_FRAC, reg_ctl[1]);
>> +               /* 2 decimal places floating to integer (ex. 1.23 to 123) */
>> +               n = n * 100 + ((x * 100) / FIELD_MAX(PLL_CTL1_FRAC));
>> +               pll_freq = div_u64(parent_rate * n, 100 * m * p);
>> +       }
>> +       return pll_freq;
>> +}
>> +
>> +static int ma35d1_pll_find_closest(struct ma35d1_clk_pll *pll, unsigned long rate,
>> +                                  unsigned long parent_rate, u32 *reg_ctl,
>> +                                  unsigned long *freq)
>> +{
>> +       unsigned long min_diff = ULONG_MAX;
>> +       int fbdiv_min, fbdiv_max;
>> +       int p, m, n;
>> +
>> +       *freq = 0;
>> +       if (rate < PLL_FCLKO_MIN_FREQ || rate > PLL_FCLKO_MAX_FREQ)
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
>> +                               unsigned long tmp, fout, fclk, diff;
>> +
>> +                               tmp = div_u64(parent_rate, m);
>> +                               if (tmp < PLL_FREF_M_MIN_FREQ ||
>> +                                   tmp > PLL_FREF_M_MAX_FREQ)
>> +                                       continue; /* constrain */
>> +
>> +                               fclk = div_u64(parent_rate * n, m);
>> +                               /* for 2 decimal places */
>> +                               if (pll->mode != PLL_MODE_INT)
>> +                                       fclk = div_u64(fclk, 100);
>> +
>> +                               if (fclk < PLL_FCLK_MIN_FREQ ||
>> +                                   fclk > PLL_FCLK_MAX_FREQ)
>> +                                       continue; /* constrain */
>> +
>> +                               fout = div_u64(fclk, p);
>> +                               if (fout < PLL_FCLKO_MIN_FREQ ||
>> +                                   fout > PLL_FCLKO_MAX_FREQ)
>> +                                       continue; /* constrain */
>> +
>> +                               diff = abs(rate - fout);
>> +                               if (diff < min_diff) {
>> +                                       reg_ctl[0] = FIELD_PREP(PLL_CTL0_INDIV, m) |
>> +                                                    FIELD_PREP(PLL_CTL0_FBDIV, n);
>> +                                       reg_ctl[1] = FIELD_PREP(PLL_CTL1_OUTDIV, p);
>> +                                       *freq = fout;
>> +                                       min_diff = diff;
>> +                                       if (min_diff == 0)
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
>> +       if (parent_rate < PLL_FREF_MIN_FREQ || parent_rate > PLL_FREF_MAX_FREQ)
>> +               return -EINVAL;
>> +
>> +       ret = ma35d1_pll_find_closest(pll, rate, parent_rate, reg_ctl, &pll_freq);
>> +       if (ret != 0)
>> +               return ret;
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
>> +       writel_relaxed(reg_ctl[0], pll->ctl0_base);
>> +       writel_relaxed(reg_ctl[1], pll->ctl1_base);
>> +       writel_relaxed(reg_ctl[2], pll->ctl2_base);
>> +       return 0;
>> +}
>> +
>> +static unsigned long ma35d1_clk_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
>> +{
>> +       struct ma35d1_clk_pll *pll = to_ma35d1_clk_pll(hw);
>> +       u32 reg_ctl[3];
>> +       unsigned long pll_freq;
>> +
>> +       if (parent_rate < PLL_FREF_MIN_FREQ || parent_rate > PLL_FREF_MAX_FREQ)
>> +               return 0;
>> +
>> +       switch (pll->id) {
>> +       case CAPLL:
>> +               reg_ctl[0] = readl_relaxed(pll->ctl0_base);
>> +               pll_freq = ma35d1_calc_smic_pll_freq(reg_ctl[0], parent_rate);
>> +               return pll_freq;
>> +       case DDRPLL:
>> +       case APLL:
>> +       case EPLL:
>> +       case VPLL:
>> +               reg_ctl[0] = readl_relaxed(pll->ctl0_base);
>> +               reg_ctl[1] = readl_relaxed(pll->ctl1_base);
>> +               pll_freq = ma35d1_calc_pll_freq(pll->mode, reg_ctl, parent_rate);
>> +               return pll_freq;
>> +       }
>> +       return 0;
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
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       switch (pll->id) {
>> +       case CAPLL:
>> +               reg_ctl[0] = readl_relaxed(pll->ctl0_base);
>> +               pll_freq = ma35d1_calc_smic_pll_freq(reg_ctl[0], *parent_rate);
>> +               return pll_freq;
>> +       case DDRPLL:
>> +       case APLL:
>> +       case EPLL:
>> +       case VPLL:
>> +               reg_ctl[0] = readl_relaxed(pll->ctl0_base);
>> +               reg_ctl[1] = readl_relaxed(pll->ctl1_base);
>> +               pll_freq = ma35d1_calc_pll_freq(pll->mode, reg_ctl, *parent_rate);
>> +               return pll_freq;
>> +       }
>> +       return 0;
>> +}
>> +
>> +static int ma35d1_clk_pll_is_prepared(struct clk_hw *hw)
>> +{
>> +       struct ma35d1_clk_pll *pll = to_ma35d1_clk_pll(hw);
>> +       u32 val = readl_relaxed(pll->ctl1_base);
>> +
>> +       return !(val & PLL_CTL1_PD);
>> +}
>> +
>> +static int ma35d1_clk_pll_prepare(struct clk_hw *hw)
>> +{
>> +       struct ma35d1_clk_pll *pll = to_ma35d1_clk_pll(hw);
>> +       u32 val;
>> +
>> +       val = readl_relaxed(pll->ctl1_base);
>> +       val &= ~PLL_CTL1_PD;
>> +       writel_relaxed(val, pll->ctl1_base);
>> +       return 0;
>> +}
>> +
>> +static void ma35d1_clk_pll_unprepare(struct clk_hw *hw)
>> +{
>> +       struct ma35d1_clk_pll *pll = to_ma35d1_clk_pll(hw);
>> +       u32 val;
>> +
>> +       val = readl_relaxed(pll->ctl1_base);
>> +       val |= PLL_CTL1_PD;
>> +       writel_relaxed(val, pll->ctl1_base);
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
>> +static const struct clk_ops ma35d1_clk_fixed_pll_ops = {
>> +       .recalc_rate = ma35d1_clk_pll_recalc_rate,
>> +       .round_rate = ma35d1_clk_pll_round_rate,
>> +};
>> +
>> +struct clk_hw *ma35d1_reg_clk_pll(struct device *dev, u32 id, u8 u8mode, const char *name,
>> +                                 struct clk_hw *parent_hw, void __iomem *base)
>> +{
>> +       struct clk_parent_data pdata = { .index = 0 };
>> +       struct clk_init_data init = {};
>> +       struct ma35d1_clk_pll *pll;
>> +       struct clk_hw *hw;
>> +       int ret;
>> +
>> +       pll = devm_kzalloc(dev, sizeof(*pll), GFP_KERNEL);
>> +       if (!pll)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       pll->id = id;
>> +       pll->mode = u8mode;
>> +       pll->ctl0_base = base + REG_PLL_CTL0_OFFSET;
>> +       pll->ctl1_base = base + REG_PLL_CTL1_OFFSET;
>> +       pll->ctl2_base = base + REG_PLL_CTL2_OFFSET;
>> +
>> +       init.name = name;
>> +       init.flags = 0;
>> +       pdata.hw = parent_hw;
>> +       init.parent_data = &pdata;
>> +       init.num_parents = 1;
>> +
>> +       if (id == CAPLL || id == DDRPLL)
>> +               init.ops = &ma35d1_clk_fixed_pll_ops;
>> +       else
>> +               init.ops = &ma35d1_clk_pll_ops;
>> +
>> +       pll->hw.init = &init;
>> +       hw = &pll->hw;
>> +
>> +       ret = devm_clk_hw_register(dev, hw);
>> +       if (ret)
>> +               return ERR_PTR(ret);
>> +       return hw;
>> +}
>> +EXPORT_SYMBOL_GPL(ma35d1_reg_clk_pll);
>> diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
>> new file mode 100644
>> index 000000000000..297b11585f00
>> --- /dev/null
>> +++ b/drivers/clk/nuvoton/clk-ma35d1.c
>> @@ -0,0 +1,933 @@
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
>> +#include <linux/platform_device.h>
>> +#include <linux/spinlock.h>
>> +#include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +
>> +static DEFINE_SPINLOCK(ma35d1_lock);
>> +
>> +#define PLL_MAX_NUM            5
>> +
>> +/* Clock Control Registers Offset */
>> +#define REG_CLK_PWRCTL         0x00
>> +#define REG_CLK_SYSCLK0                0x04
>> +#define REG_CLK_SYSCLK1                0x08
>> +#define REG_CLK_APBCLK0                0x0C
>> +#define REG_CLK_APBCLK1                0x10
>> +#define REG_CLK_APBCLK2                0x14
>> +#define REG_CLK_CLKSEL0                0x18
>> +#define REG_CLK_CLKSEL1                0x1C
>> +#define REG_CLK_CLKSEL2                0x20
>> +#define REG_CLK_CLKSEL3                0x24
>> +#define REG_CLK_CLKSEL4                0x28
>> +#define REG_CLK_CLKDIV0                0x2C
>> +#define REG_CLK_CLKDIV1                0x30
>> +#define REG_CLK_CLKDIV2                0x34
>> +#define REG_CLK_CLKDIV3                0x38
>> +#define REG_CLK_CLKDIV4                0x3C
>> +#define REG_CLK_CLKOCTL                0x40
>> +#define REG_CLK_STATUS         0x50
>> +#define REG_CLK_PLL0CTL0       0x60
>> +#define REG_CLK_PLL2CTL0       0x80
>> +#define REG_CLK_PLL2CTL1       0x84
>> +#define REG_CLK_PLL2CTL2       0x88
>> +#define REG_CLK_PLL3CTL0       0x90
>> +#define REG_CLK_PLL3CTL1       0x94
>> +#define REG_CLK_PLL3CTL2       0x98
>> +#define REG_CLK_PLL4CTL0       0xA0
>> +#define REG_CLK_PLL4CTL1       0xA4
>> +#define REG_CLK_PLL4CTL2       0xA8
>> +#define REG_CLK_PLL5CTL0       0xB0
>> +#define REG_CLK_PLL5CTL1       0xB4
>> +#define REG_CLK_PLL5CTL2       0xB8
>> +#define REG_CLK_CLKDCTL                0xC0
>> +#define REG_CLK_CLKDSTS                0xC4
>> +#define REG_CLK_CDUPB          0xC8
>> +#define REG_CLK_CDLOWB         0xCC
>> +#define REG_CLK_CKFLTRCTL      0xD0
>> +#define REG_CLK_TESTCLK                0xF0
>> +#define REG_CLK_PLLCTL         0x40
> Please use lowercase hex.

I will fix them.

>> +
>> +#define PLL_MODE_INT            0
>> +#define PLL_MODE_FRAC           1
>> +#define PLL_MODE_SS             2
>> +
>> +struct clk_hw *ma35d1_reg_clk_pll(struct device *dev, u32 id, u8 u8mode,
>> +                                 const char *name, struct clk_hw *parent_hw,
>> +                                 void __iomem *base);
>> +struct clk_hw *ma35d1_reg_adc_clkdiv(struct device *dev, const char *name,
>> +                                    struct clk_hw *hw, spinlock_t *lock,
>> +                                    unsigned long flags, void __iomem *reg,
>> +                                    u8 shift, u8 width, u32 mask_bit);
> These function prototypes should be in a header and included in any C
> files that use them.

I will re-create clk-ma35d1.h in the same directory, and move these function
prototypes to the header file.

>> +
>> +static const struct clk_parent_data ca35clk_sel_clks[] = {
>> +       { .index = 0 },  /* HXT */
>> +       { .index = 1 },  /* CAPLL */
>> +       { .index = 2 }   /* DDRPLL */
>> +};
>> +
>> +static const char *const sysclk0_sel_clks[] = {
>> +       "epll_div2", "syspll"
>> +};
>> +
>> +static const char *const sysclk1_sel_clks[] = {
>> +       "hxt", "syspll"
> [...]
>> +       "pclk0", "apll", "dummy", "dummy"
>> +};
>> +
>> +static const char *const i2s0_sel_clks[] = {
>> +       "apll", "sysclk1_div2", "dummy", "dummy"
>> +};
>> +
>> +static const char *const i2s1_sel_clks[] = {
>> +       "apll", "sysclk1_div2", "dummy", "dummy"
>> +};
>> +
>> +static const char *const can_sel_clks[] = {
>> +       "apll", "vpll"
>> +};
>> +
>> +static const char *const cko_sel_clks[] = {
>> +       "hxt", "lxt", "hirc", "lirc", "capll_div4", "syspll",
>> +       "ddrpll", "epll_div2", "apll", "vpll", "dummy", "dummy",
>> +       "dummy", "dummy", "dummy", "dummy"
> I suspect "dummy" is something that we don't want to tell Linux about?
> If possible, we should simply omit it entirely from the parent_data
> arrays.

The array is a mapping to bit field of clock selection registers, and 
"dummy" means reserved.

I will remove the trailing "dummy", but would like to preserve the 
middle "dummy" as the followings.

static const char *const timer0_sel_clks[] = {
     "hxt", "lxt", "pclk0", "dummy", "dummy", "lirc", "dummy", "hirc"
};


>> +};
>> +
>> +static const char *const smc_sel_clks[] = {
>> +       "hxt", "pclk4"
>> +};
>> +
>> +static const char *const kpi_sel_clks[] = {
>> +       "hxt", "lxt"
>> +};
>> +
>> +static const struct clk_div_table ip_div_table[] = {
>> +       {0, 2}, {1, 4}, {2, 6}, {3, 8}, {4, 10},
>> +       {5, 12}, {6, 14}, {7, 16}, {0, 0},
>> +};
>> +
>> +static const struct clk_div_table eadc_div_table[] = {
>> +       {0, 2}, {1, 4}, {2, 6}, {3, 8}, {4, 10},
>> +       {5, 12}, {6, 14}, {7, 16}, {8, 18},
>> +       {9, 20}, {10, 22}, {11, 24}, {12, 26},
>> +       {13, 28}, {14, 30}, {15, 32}, {0, 0},
>> +};
>> +
>> +static struct clk_hw *ma35d1_clk_fixed(const char *name, int rate)
>> +{
>> +       return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
>> +}
>> +
>> +static struct clk_hw *ma35d1_clk_mux_parent(struct device *dev, const char *name,
>> +                                           void __iomem *reg, u8 shift, u8 width,
>> +                                           const struct clk_parent_data *pdata,
>> +                                           int num_pdata)
>> +{
>> +       return clk_hw_register_mux_parent_data(dev, name, pdata, num_pdata,
>> +                                              CLK_SET_RATE_NO_REPARENT, reg, shift,
>> +                                              width, 0, &ma35d1_lock);
>> +}
>> +
>> +static struct clk_hw *ma35d1_clk_mux(struct device *dev, const char *name,
>> +                                    void __iomem *reg, u8 shift, u8 width,
>> +                                    const char *const *parents, int num_parents)
> Please don't use string arrays for parent descriptions. Everything
> should use clk_parent_data or direct clk_hw pointers.

I will use clk_parent_data instead of strings.


Best Regards,
Jacky Huang

