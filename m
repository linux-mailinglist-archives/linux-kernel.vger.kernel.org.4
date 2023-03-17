Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC876BDF50
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 04:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjCQDJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 23:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCQDJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:09:03 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68F0B7182;
        Thu, 16 Mar 2023 20:07:43 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cn6so3661621pjb.2;
        Thu, 16 Mar 2023 20:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679022458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CkJh2oESNHGt+mpeONu9fOzwq2ixyZFdT7YuiwRkL3A=;
        b=V7U8ykvqArjNtVacaqihDfKHj2kgelcGt5wuRjD4IMDJdOL5OMd0Vn0Vrf5DTYTX2w
         DeX4PBwVecylsjG0R2+/8tWjae46khtya1JiCLHq6pxxVMo/NDns5dWk98a4aoL2kV+G
         C2mkNpJ7ZgR2F155urHo/8O7oNWfDtmVMUdV+sssyFYgaVGZwmCFVuLhSH7epekkk/2p
         ePAaGkGag5DBbbfpUv+/iXP0aAvW2M3Ky/OiUJMTdlVyq/rHkXvGRq+HZy7MsTKeRfRL
         FPV92TPIQQG6KdLCW5vhHCAJoF4FBfnwPKll1dhqGae3LGOk2VKbO9yKNfrd/pjojl9l
         9P8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679022458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CkJh2oESNHGt+mpeONu9fOzwq2ixyZFdT7YuiwRkL3A=;
        b=oh+ct1LwGtXNlGHfiod2aORocxbYME0NbsMp0khLepczFlHLoCn0b85byBcPqaBgGi
         30QCqR/LaptBO9tS63/OSRxHgQ1h7cAeYaF82DcQadGcLG+7y87Btu2EQIMEZBKrThlA
         MQ1eBF8LouX+DLA68NR+Q1Oo42ye+fGkeYb6Vb51z0dg/LJ7WFXbIKRU1SN3mR33XdUZ
         9FxEt2KwDsGpYMPwhhnBnoKBylt3FQTihVSgazZR/9x2MdTyxKWXW431l4/H3MvOgjKn
         NowcsfVqjySfZP3NiAnFtbi0ie6uROdtg4yWZDVstNAkUF+6/F95YBR6kKGmsYLwyDPK
         vRWQ==
X-Gm-Message-State: AO0yUKUaTz3tNg7YxERCUCL33TtQfaYBEvEqYGY6Z3bg8NUbIi4/roLW
        hxg9AxfJMQHfBaiSsa+Rea0=
X-Google-Smtp-Source: AK7set+W8OGmKSPYrEwGTAKwikeluZQssWx7IIEtQBPk7M740p1vMfqfaKDC06HpxzKZ37hNk+y9XQ==
X-Received: by 2002:a17:902:c44a:b0:1a1:a706:5df3 with SMTP id m10-20020a170902c44a00b001a1a7065df3mr700692plm.15.1679022458224;
        Thu, 16 Mar 2023 20:07:38 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902a60a00b00192fe452e17sm393339plq.162.2023.03.16.20.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 20:07:37 -0700 (PDT)
Message-ID: <493c9c33-5ad9-e3f3-501c-d9f27b4d54d5@gmail.com>
Date:   Fri, 17 Mar 2023 11:07:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 12/15] clk: nuvoton: Add clock driver for ma35d1 clock
 controller
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-13-ychuang570808@gmail.com>
 <33aa6111d09fa7a75d0e603c3fd3ac11.sboyd@kernel.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <33aa6111d09fa7a75d0e603c3fd3ac11.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Stephen,

Thanks for your review.


On 2023/3/16 上午 06:30, Stephen Boyd wrote:
> Quoting Jacky Huang (2023-03-15 00:28:59)
>> diff --git a/drivers/clk/nuvoton/clk-ma35d1-divider.c b/drivers/clk/nuvoton/clk-ma35d1-divider.c
>> new file mode 100644
>> index 000000000000..5f4791531e47
>> --- /dev/null
>> +++ b/drivers/clk/nuvoton/clk-ma35d1-divider.c
>> @@ -0,0 +1,144 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2023 Nuvoton Technology Corp.
>> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/slab.h>
>> +#include <linux/io.h>
>> +#include <linux/err.h>
>> +#include <linux/spinlock.h>
>> +
>> +#include "clk-ma35d1.h"
>> +
>> +#define div_mask(width)                ((1 << (width)) - 1)
> This is clk_div_mask()

OK, I will rename div_mask() as clk_div_mask().

>
>> +
>> +struct ma35d1_adc_clk_divider {
>> +       struct clk_hw hw;
>> +       void __iomem *reg;
>> +       u8 shift;
>> +       u8 width;
>> +       u32 mask;
>> +       const struct clk_div_table *table;
>> +       spinlock_t *lock;
>> +};
>> +
>> +#define to_ma35d1_adc_clk_divider(_hw) \
>> +       container_of(_hw, struct ma35d1_adc_clk_divider, hw)
>> +
>> +static unsigned long ma35d1_clkdiv_recalc_rate(struct clk_hw *hw,
>> +                                              unsigned long parent_rate)
>> +{
>> +       unsigned int val;
>> +       struct ma35d1_adc_clk_divider *dclk = to_ma35d1_adc_clk_divider(hw);
>> +
>> +       val = readl_relaxed(dclk->reg) >> dclk->shift;
>> +       val &= div_mask(dclk->width);
>> +       val += 1;
>> +       return divider_recalc_rate(hw, parent_rate, val, dclk->table,
>> +                                  CLK_DIVIDER_ROUND_CLOSEST, dclk->width);
>> +}
>> +
>> +static long ma35d1_clkdiv_round_rate(struct clk_hw *hw, unsigned long rate,
>> +                                    unsigned long *prate)
>> +{
>> +       struct ma35d1_adc_clk_divider *dclk = to_ma35d1_adc_clk_divider(hw);
>> +
>> +       return divider_round_rate(hw, rate, prate, dclk->table,
>> +                                 dclk->width, CLK_DIVIDER_ROUND_CLOSEST);
>> +}
>> +
>> +static int ma35d1_clkdiv_set_rate(struct clk_hw *hw, unsigned long rate,
>> +                                 unsigned long parent_rate)
>> +{
>> +       int value;
>> +       unsigned long flags = 0;
>> +       u32 data;
>> +       struct ma35d1_adc_clk_divider *dclk = to_ma35d1_adc_clk_divider(hw);
>> +
>> +       value = divider_get_val(rate, parent_rate, dclk->table,
>> +                               dclk->width, CLK_DIVIDER_ROUND_CLOSEST);
>> +
>> +       if (dclk->lock)
>> +               spin_lock_irqsave(dclk->lock, flags);
>> +
>> +       data = readl_relaxed(dclk->reg);
>> +       data &= ~(div_mask(dclk->width) << dclk->shift);
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
>> +                                    unsigned long flags, void __iomem *reg,
>> +                                    u8 shift, u8 width, u32 mask_bit)
>> +{
>> +       struct ma35d1_adc_clk_divider *div;
>> +       struct clk_init_data init;
>> +       struct clk_div_table *table;
>> +       u32 max_div, min_div;
>> +       struct clk_hw *hw;
>> +       int ret;
>> +       int i;
>> +
>> +       /* allocate the divider */
> Please remove useless comment.
>
>> +       div = kzalloc(sizeof(*div), GFP_KERNEL);
>> +       if (!div)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       /* Init the divider table */
> Please remove useless comment.

I will remove all useless comments.

>
>> +       max_div = div_mask(width) + 1;
>> +       min_div = 1;
>> +
>> +       table = kcalloc(max_div + 1, sizeof(*table), GFP_KERNEL);
> Use devm_ allocations please.

OK, I will use devm_kzallloc() instead.

>> +       if (!table) {
>> +               kfree(div);
>> +               return ERR_PTR(-ENOMEM);
>> +       }
>> +
>> +       for (i = 0; i < max_div; i++) {
>> +               table[i].val = (min_div + i);
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
>> +       /* struct ma35d1_adc_clk_divider assignments */
> Please remove useless comment.
>
>> +       div->reg = reg;
>> +       div->shift = shift;
>> +       div->width = width;
>> +       div->mask = mask_bit ? BIT(mask_bit) : 0;
>> +       div->lock = &ma35d1_lock;
>> +       div->hw.init = &init;
>> +       div->table = table;
>> +
>> +       /* Register the clock */
> Please remove useless comment.
>
>> +       hw = &div->hw;
>> +       ret = clk_hw_register(NULL, hw);
> Use devm_clk_hw_register()

I will use devm_clk_hw_registers() instead.

>
>> +       if (ret) {
>> +               kfree(table);
>> +               kfree(div);
>> +               return ERR_PTR(ret);
>> +       }
>> +       return hw;
>> +}
>> diff --git a/drivers/clk/nuvoton/clk-ma35d1-pll.c b/drivers/clk/nuvoton/clk-ma35d1-pll.c
>> new file mode 100644
>> index 000000000000..79e724b148fa
>> --- /dev/null
>> +++ b/drivers/clk/nuvoton/clk-ma35d1-pll.c
>> @@ -0,0 +1,534 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2023 Nuvoton Technology Corp.
>> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
>> + */
>> +
>> +#include <linux/clk.h>
> Do you need to include this header?

I remove it and compile passed. It is not used here.
I will remove it in the next version.

>
>> +#include <linux/clk-provider.h>
>> +#include <linux/io.h>
>> +#include <linux/slab.h>
>> +#include <linux/bitfield.h>
>> +
>> +#include "clk-ma35d1.h"
>> +
>> +#define to_ma35d1_clk_pll(clk) \
>> +       (container_of(clk, struct ma35d1_clk_pll, clk))
>> +
>> +#define PLL0CTL0_FBDIV_MSK     GENMASK(7, 0)
>> +#define PLL0CTL0_INDIV_MSK     GENMASK(11, 8)
>> +#define PLL0CTL0_OUTDIV_MSK    GENMASK(13, 12)
>> +#define PLL0CTL0_PD_MSK                BIT(16)
>> +#define PLL0CTL0_BP_MSK                BIT(17)
>> +#define PLLXCTL0_FBDIV_MSK     GENMASK(10, 0)
>> +#define PLLXCTL0_INDIV_MSK     GENMASK(17, 12)
>> +#define PLLXCTL0_MODE_MSK      GENMASK(19, 18)
>> +#define PLLXCTL0_SSRATE_MSK    GENMASK(30, 20)
>> +#define PLLXCTL1_PD_MSK                BIT(0)
>> +#define PLLXCTL1_BP_MSK                BIT(1)
>> +#define PLLXCTL1_OUTDIV_MSK    GENMASK(6, 4)
>> +#define PLLXCTL1_FRAC_MSK      GENMASK(31, 8)
>> +#define PLLXCTL2_SLOPE_MSK     GENMASK(23, 0)
>> +
>> +struct ma35d1_clk_pll {
>> +       struct clk_hw hw;
>> +       u8 type;
>> +       u8 mode;
>> +       unsigned long rate;
>> +       void __iomem *ctl0_base;
>> +       void __iomem *ctl1_base;
>> +       void __iomem *ctl2_base;
>> +       struct regmap *regmap;
>> +};
>> +
>> +struct vsipll_freq_conf_reg_tbl {
>> +       unsigned long freq;
>> +       u8 mode;
>> +       u32 ctl0_reg;
>> +       u32 ctl1_reg;
>> +       u32 ctl2_reg;
>> +};
>> +
>> +static const struct vsipll_freq_conf_reg_tbl ma35d1pll_freq[] = {
>> +       { 1000000000, VSIPLL_INTEGER_MODE, 0x307d, 0x10, 0 },
>> +       { 884736000, VSIPLL_FRACTIONAL_MODE, 0x41024, 0xdd2f1b11, 0 },
>> +       { 533000000, VSIPLL_SS_MODE, 0x12b8102c, 0x6aaaab20, 0x12317 },
>> +       { }
>> +};
>> +
>> +static void CLK_UnLockReg(struct ma35d1_clk_pll *pll)
> Please don't use a mix of upper and lower case function names.
> Everything should be lower case. Maybe the name should be
>
> 	ma35d1_clk_pll_unlock_reg()

Sure, we will review all the macros and API to have all lower case naming.

>> +{
>> +       int ret;
>> +
>> +       /* Unlock PLL registers */
>> +       do {
>> +               regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x59);
>> +               regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x16);
>> +               regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x88);
>> +               regmap_read(pll->regmap, REG_SYS_RLKTZNS, &ret);
>> +       } while (ret == 0);
>> +}
>> +
>> +static void CLK_LockReg(struct ma35d1_clk_pll *pll)
>> +{
> 	ma35d1_clk_pll_lock_reg()
>
>> +       /* Lock PLL registers */
> Remove these worthless comments.
>
>> +       regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x0);
>> +}
>> +
>> +/* SMIC PLL for CAPLL */
>> +unsigned long CLK_GetPLLFreq_SMICPLL(struct ma35d1_clk_pll *pll,
>> +                                    unsigned long PllSrcClk)
>> +{
>> +       u32 u32M, u32N, u32P, u32OutDiv;
> Variable names should not have the type in them. 'm', 'n', 'p', 'div'
> should suffice.

OK, we review all variables naming and modify them to linux coding style.

>> +       u32 val;
>> +       unsigned long u64PllClk;
>> +       u32 clk_div_table[] = { 1, 2, 4, 8};
>> +
>> +       val = __raw_readl(pll->ctl0_base);
> Why do you need to use __raw_readl()? Just use readl() here.

OK, I will modify all __raw_real() to raw_read().

>> +
>> +       u32N = FIELD_GET(PLL0CTL0_FBDIV_MSK, val);
>> +       u32M = FIELD_GET(PLL0CTL0_INDIV_MSK, val);
>> +       u32P = FIELD_GET(PLL0CTL0_OUTDIV_MSK, val);
>> +       u32OutDiv = clk_div_table[u32P];
>> +
>> +       if (val & PLL0CTL0_BP_MSK) {
>> +               u64PllClk = PllSrcClk;
>> +       } else {
>> +               u64PllClk = PllSrcClk * u32N;
>> +               do_div(u64PllClk, u32M * u32OutDiv);
>> +       }
> Add a newline here.
>
>> +       return u64PllClk;
>> +}
>> +
>> +/* VSI-PLL: INTEGER_MODE */
> I have no idea what this means.

The PLL has 3 operation modes, and integer mode in one of them.
We will add descriptions about PLL to comments.

>
>> +unsigned long CLK_CalPLLFreq_Mode0(unsigned long PllSrcClk,
>> +                                  unsigned long u64PllFreq, u32 *u32Reg)
> Again, don't put types into the variable name.
>
>> +{
>> +       u32 u32TmpM, u32TmpN, u32TmpP;
>> +       u32 u32RngMinN, u32RngMinM, u32RngMinP;
>> +       u32 u32RngMaxN, u32RngMaxM, u32RngMaxP;
>> +       u32 u32Tmp, u32Min, u32MinN, u32MinM, u32MinP;
>> +       unsigned long u64PllClk;
>> +       unsigned long u64Con1, u64Con2, u64Con3;
> My eyes! Seriously, kernel style is not this way. Did checkpatch.pl pass
> on this?

We will completely rewrite this function to make it readable.

>> +
>> +       u64PllClk = 0;
>> +       u32Min = (u32) -1;
>> +
>> +       if (!((u64PllFreq >= VSIPLL_FCLKO_MIN_FREQ) &&
>> +           (u64PllFreq <= VSIPLL_FCLKO_MAX_FREQ))) {
>> +               u32Reg[0] = ma35d1pll_freq[0].ctl0_reg;
>> +               u32Reg[1] = ma35d1pll_freq[0].ctl1_reg;
>> +               u64PllClk = ma35d1pll_freq[0].freq;
>> +               return u64PllClk;
>> +       }
>> +
>> +       u32RngMinM = 1UL;
>> +       u32RngMaxM = 63UL;
>> +       u32RngMinM = ((PllSrcClk / VSIPLL_FREFDIVM_MAX_FREQ) > 1) ?
>> +                    (PllSrcClk / VSIPLL_FREFDIVM_MAX_FREQ) : 1;
>> +       u32RngMaxM = ((PllSrcClk / VSIPLL_FREFDIVM_MIN_FREQ0) < u32RngMaxM) ?
>> +                    (PllSrcClk / VSIPLL_FREFDIVM_MIN_FREQ0) : u32RngMaxM;
>> +
>> +       for (u32TmpM = u32RngMinM; u32TmpM < (u32RngMaxM + 1); u32TmpM++) {
>> +               u64Con1 = PllSrcClk / u32TmpM;
>> +               u32RngMinN = 16UL;
>> +               u32RngMaxN = 2047UL;
>> +               u32RngMinN = ((VSIPLL_FCLK_MIN_FREQ / u64Con1) > u32RngMinN) ?
>> +                            (VSIPLL_FCLK_MIN_FREQ / u64Con1) : u32RngMinN;
>> +               u32RngMaxN = ((VSIPLL_FCLK_MAX_FREQ / u64Con1) < u32RngMaxN) ?
>> +                            (VSIPLL_FCLK_MAX_FREQ / u64Con1) : u32RngMaxN;
> Is this clamp()?
>
>> +
>> +               for (u32TmpN = u32RngMinN; u32TmpN < (u32RngMaxN + 1);
>> +                    u32TmpN++) {
>> +                       u64Con2 = u64Con1 * u32TmpN;
>> +                       u32RngMinP = 1UL;
>> +                       u32RngMaxP = 7UL;
>> +                       u32RngMinP = ((u64Con2 / VSIPLL_FCLKO_MAX_FREQ) > 1) ?
>> +                                     (u64Con2 / VSIPLL_FCLKO_MAX_FREQ) : 1;
> Is this clamp()?
>
>> +                       u32RngMaxP = ((u64Con2 / VSIPLL_FCLKO_MIN_FREQ) <
>> +                                     u32RngMaxP) ?
>> +                                     (u64Con2 / VSIPLL_FCLKO_MIN_FREQ) :
>> +                                     u32RngMaxP;
>> +                       for (u32TmpP = u32RngMinP; u32TmpP < (u32RngMaxP + 1);
>> +                            u32TmpP++) {
>> +                               u64Con3 = u64Con2 / u32TmpP;
>> +                               if (u64Con3 > u64PllFreq)
>> +                                       u32Tmp = u64Con3 - u64PllFreq;
>> +                               else
>> +                                       u32Tmp = u64PllFreq - u64Con3;
>> +
>> +                               if (u32Tmp < u32Min) {
>> +                                       u32Min = u32Tmp;
>> +                                       u32MinM = u32TmpM;
>> +                                       u32MinN = u32TmpN;
>> +                                       u32MinP = u32TmpP;
>> +
>> +                                       if (u32Min == 0UL) {
>> +                                               u32Reg[0] = (u32MinM << 12) |
>> +                                                           (u32MinN);
>> +                                               u32Reg[1] = (u32MinP << 4);
>> +                                               return ((PllSrcClk * u32MinN) /
>> +                                                       (u32MinP * u32MinM));
>> +                                       }
>> +                               }
>> +                       }
>> +               }
>> +       }
> It's too hard to read this code.

We will completely rewrite this function to make it readable.
And add formula descriptions to comments.

>> +
>> +       u32Reg[0] = (u32MinM << 12) | (u32MinN);
> FIELD_PREP?
>
>> +       u32Reg[1] = (u32MinP << 4);
> ditto?
>
>> +       u64PllClk = (PllSrcClk * u32MinN) / (u32MinP * u32MinM);
>> +       return u64PllClk;
>> +}
>> +
>> +/* VSI-PLL: FRACTIONAL_MODE */
>> +unsigned long CLK_CalPLLFreq_Mode1(unsigned long PllSrcClk,
>> +                                  unsigned long u64PllFreq, u32 *u32Reg)
>> +{
>> +       unsigned long u64X, u64N, u64M, u64P, u64tmp;
>> +       unsigned long u64PllClk, u64FCLKO;
>> +       u32 u32FRAC;
>> +
>> +       if (u64PllFreq > VSIPLL_FCLKO_MAX_FREQ) {
>> +               u32Reg[0] = ma35d1pll_freq[1].ctl0_reg;
>> +               u32Reg[1] = ma35d1pll_freq[1].ctl1_reg;
>> +               u64PllClk = ma35d1pll_freq[1].freq;
>> +               return u64PllClk;
>> +       }
>> +
>> +       if (u64PllFreq > (VSIPLL_FCLKO_MIN_FREQ/(100-1))) {
> Use a local variable for the right hand side of the comparison.

We will completely rewrite this function to make it readable.
And add formula descriptions to comments.


>> +               u64FCLKO = u64PllFreq * ((VSIPLL_FCLKO_MIN_FREQ / u64PllFreq) +
>> +                          ((VSIPLL_FCLKO_MIN_FREQ % u64PllFreq) ? 1 : 0));
> Is this DIV_ROUND_UP() or something like that?
>
>> +       } else {
>> +               pr_err("Failed to set rate %ld\n", u64PllFreq);
>> +               return 0;
>> +       }
>> +
>> +       u64P = (u64FCLKO >= VSIPLL_FCLK_MIN_FREQ) ? 1 :
>> +              ((VSIPLL_FCLK_MIN_FREQ / u64FCLKO) +
>> +               ((VSIPLL_FCLK_MIN_FREQ % u64FCLKO) ? 1 : 0));
>> +
>> +       if ((PllSrcClk > (VSIPLL_FREFDIVM_MAX_FREQ * (64-1))) ||
>> +           (PllSrcClk < VSIPLL_FREFDIVM_MIN_FREQ1))
>> +               return 0;
>> +
> [...]
>> +               break;
>> +       }
>> +
>> +       return pllfreq;
>> +}
>> +
>> +static long ma35d1_clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
>> +                                     unsigned long *prate)
>> +{
>> +       return rate;
> This needs to do actual math and figure out that some rate will not
> work and calculate what the rate will actually be if clk_set_rate() is
> called with 'rate'.

Got it. We will add clock rate check here.

>> +}
>> +
>> +static int ma35d1_clk_pll_is_prepared(struct clk_hw *hw)
>> +{
>> +       struct ma35d1_clk_pll *pll = to_ma35d1_clk_pll(hw);
>> +       u32 val = __raw_readl(pll->ctl1_base);
>> +
>> +       return (val & VSIPLLCTL1_PD_MSK) ? 0 : 1;
>> +}
>> +
>> +static int ma35d1_clk_pll_prepare(struct clk_hw *hw)
>> +{
>> +       struct ma35d1_clk_pll *pll = to_ma35d1_clk_pll(hw);
>> +       u32 val;
>> +
>> +       if ((pll->type == MA35D1_CAPLL) || (pll->type == MA35D1_DDRPLL)) {
>> +               pr_warn("Nuvoton MA35D1 CAPLL/DDRPLL is read only.\n");
>> +               return -EACCES;
>> +       }
>> +
>> +       CLK_UnLockReg(pll);
>> +       val = __raw_readl(pll->ctl1_base);
>> +       val &= ~VSIPLLCTL1_PD_MSK;
>> +       __raw_writel(val, pll->ctl1_base);
>> +       CLK_LockReg(pll);
>> +       return 0;
>> +}
>> +
>> +static void ma35d1_clk_pll_unprepare(struct clk_hw *hw)
>> +{
>> +       struct ma35d1_clk_pll *pll = to_ma35d1_clk_pll(hw);
>> +       u32 val;
>> +
>> +       if ((pll->type == MA35D1_CAPLL) || (pll->type == MA35D1_DDRPLL)) {
>> +               pr_warn("Nuvoton MA35D1 CAPLL/DDRPLL is read only.\n");
>> +       } else {
>> +               val = __raw_readl(pll->ctl1_base);
>> +               val |= VSIPLLCTL1_PD_MSK;
>> +               __raw_writel(val, pll->ctl1_base);
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
>> +                                 u8 u8mode, const char *name,
>> +                                 const char *parent,
>> +                                 unsigned long targetFreq,
>> +                                 void __iomem *base,
>> +                                 struct regmap *regmap)
>> +{
>> +       struct ma35d1_clk_pll *pll;
>> +       struct clk_hw *hw;
>> +       struct clk_init_data init;
>> +       int ret;
>> +
>> +       pll = kmalloc(sizeof(*pll), GFP_KERNEL);
>> +       if (!pll)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       pll->type = type;
>> +       pll->mode = u8mode;
>> +       pll->rate = targetFreq;
>> +       pll->ctl0_base = base + VSIPLL_CTL0;
>> +       pll->ctl1_base = base + VSIPLL_CTL1;
>> +       pll->ctl2_base = base + VSIPLL_CTL2;
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
>> +       if (ret) {
>> +               pr_err("failed to register vsi-pll clock!!!\n");
>> +               kfree(pll);
>> +               return ERR_PTR(ret);
>> +       }
>> +       return hw;
>> +}
>> diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
>> new file mode 100644
>> index 000000000000..ac8154458b81
>> --- /dev/null
>> +++ b/drivers/clk/nuvoton/clk-ma35d1.c
>> @@ -0,0 +1,970 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2023 Nuvoton Technology Corp.
>> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
>> + */
>> +
>> +#include <linux/clk.h>
> I don't see any clk consumer usage. Please remove.
+#include <linux/clk-provider.h>
>> +#include <linux/clkdev.h>
> I don't see any clkdev usage. Please remove.

Yes, clk.h and clkdev.h are not used here. I will remove them.


>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/spinlock.h>
>> +#include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +
>> +#include "clk-ma35d1.h"
>> +
>> +DEFINE_SPINLOCK(ma35d1_lock);
> Why not static?

ma35d1_lock is used in clk-ma35d1-divider.c only.
I will move it form clk-ma35d1.c to clk-ma35d1-divider.c as add static.

>
>> +
>> +static const char *const ca35clk_sel_clks[] = {
>> +       "hxt", "capll", "ddrpll", "dummy"
> Are these parent mappings? Please use 'struct clk_parent_data' instead
> if so.
>
>> +};
>> +
>> +static const char *const sysclk0_sel_clks[] = {
>> +       "epll_div2", "syspll"
>> +};
>> +
> [...]
>> +
>> +static struct clk_hw **hws;
>> +static struct clk_hw_onecell_data *ma35d1_hw_data;
> Any reason to make these global pointers vs local pointers during probe?

We will consider about using devm_of_clk_add_hw_provider() and remove 
these global pointers.

>
>> +
>> +static int ma35d1_clocks_probe(struct platform_device *pdev)
>> +{
>> +       int ret;
>> +       struct device *dev = &pdev->dev;
>> +       struct device_node *clk_node = dev->of_node;
>> +       void __iomem *clk_base;
>> +       struct regmap *regmap;
>> +       u32 pllmode[5] = { 0, 0, 0, 0, 0 };
>> +       u32 pllfreq[5] = { 0, 0, 0, 0, 0 };
>> +
>> +       dev_info(&pdev->dev, "Nuvoton MA35D1 Clock Driver\n");
> Drop this banner message please.

OK, I will remove it.

>
>> +       ma35d1_hw_data = devm_kzalloc(&pdev->dev, struct_size(ma35d1_hw_data,
>> +                                     hws, CLK_MAX_IDX), GFP_KERNEL);
>> +
>> +       if (WARN_ON(!ma35d1_hw_data))
>> +               return -ENOMEM;
>> +
>> +       ma35d1_hw_data->num = CLK_MAX_IDX;
>> +       hws = ma35d1_hw_data->hws;
>> +
>> +       clk_node = of_find_compatible_node(NULL, NULL, "nuvoton,ma35d1-clk");
>> +       clk_base = of_iomap(clk_node, 0);
> Use platform_device APIs as you have a platform device here ('pdev').

OK, I will fix it.

>> +       of_node_put(clk_node);
>> +       if (!clk_base) {
>> +               pr_err("%s: could not map region\n", __func__);
>> +               return -ENOMEM;
>> +       }
>> +       regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
>> +                                                "nuvoton,sys");
> Why is it a syscon?
>
>> +       if (IS_ERR(regmap))
>> +               pr_warn("%s: Unable to get syscon\n", __func__);
> How can we continue without the regmap?

I will make it return error here.

>
>> +
>> +       /* clock sources */
>> +       hws[HXT] = ma35d1_clk_fixed("hxt", 24000000);
> [...]
>> +       /* EADC */
>> +       hws[EADC_DIV] = ma35d1_clk_divider_table("eadc_div", "pclk2",
>> +                                                clk_base + REG_CLK_CLKDIV4,
>> +                                                0, 4, eadc_div_table);
>> +       hws[EADC_GATE] = ma35d1_clk_gate("eadc_gate", "eadc_div",
>> +                                        clk_base + REG_CLK_APBCLK2, 25);
>> +
>> +       ret = of_clk_add_hw_provider(clk_node, of_clk_hw_onecell_get,
> Use devm_ variant.

OK, I will fix it.

>
>> +                                    ma35d1_hw_data);
>> +       if (ret < 0) {
>> +               dev_err(dev, "failed to register hws for MA35D1\n");
>> +               iounmap(clk_base);
> Use devm mapping APIs to avoid unmapping on error path.

>> +       }
>> +       return ret;
>> +}
>> +
>> +static const struct of_device_id ma35d1_clk_of_match[] = {
>> +       { .compatible = "nuvoton,ma35d1-clk" },
>> +       { },
> Drop comma above so nothing can come after this.

I will remove the comma.

>
>> +};
>> +MODULE_DEVICE_TABLE(of, ma35d1_clk_of_match);
>> +
>> +static struct platform_driver ma35d1_clk_driver = {
>> +       .probe = ma35d1_clocks_probe,
>> +       .driver = {
>> +               .name = "ma35d1-clk",
>> +               .of_match_table = ma35d1_clk_of_match,
>> +       },
>> +};
>> +
>> +static int __init ma35d1_clocks_init(void)
>> +{
>> +       return platform_driver_register(&ma35d1_clk_driver);
>> +}
>> +
>> +postcore_initcall(ma35d1_clocks_init);
>> +
>> +MODULE_AUTHOR("Chi-Fang Li<cfli0@nuvoton.com>");
>> +MODULE_DESCRIPTION("NUVOTON MA35D1 Clock Driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/clk/nuvoton/clk-ma35d1.h b/drivers/clk/nuvoton/clk-ma35d1.h
>> new file mode 100644
>> index 000000000000..faae5a17e425
>> --- /dev/null
>> +++ b/drivers/clk/nuvoton/clk-ma35d1.h
>> @@ -0,0 +1,198 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2023 Nuvoton Technology Corp.
>> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
>> + */
>> +
>> +#ifndef __DRV_CLK_NUVOTON_MA35D1_H
>> +#define __DRV_CLK_NUVOTON_MA35D1_H
>> +
>> +#include <linux/clk.h>
>> +#include <linux/clkdev.h>
> Are these includes used?

I remove them and compile passed, so I will will remove them in the next 
version.


>
>> +#include <linux/clk-provider.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/regmap.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/mfd/ma35d1-sys.h>
> These probably aren't needed to be included here. Just forward declare
> structs you need and include the headers in the C file.

Sure, we will move all #include in clk-ma35d1.h, and only include 
required .h files in C file.

>> +
> [...]
>> +
>> +struct clk_hw *ma35d1_reg_adc_clkdiv(struct device *dev,
>> +                                   const char *name,
>> +                                   const char *parent_name,
>> +                                   unsigned long flags,
>> +                                   void __iomem *reg, u8 shift,
>> +                                   u8 width, u32 mask_bit);
>> +
>> +extern spinlock_t ma35d1_lock;
> Why?
I will remove all "extern" ma35d1_lock, as it will be static in 
clk-ma35d1-divider.c.


Best regards,

Jacky Huang


