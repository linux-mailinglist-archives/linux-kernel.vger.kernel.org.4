Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D1C6BC7B8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjCPHvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjCPHvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:51:23 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A1214990
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:51:17 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ek18so4033806edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678953075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jwNs+y4b7W9cSxLh5xgNZaGX62BKSLC/hX9j+Q1b4kU=;
        b=QywuFrGEDRv3VZ6XEolZQmkIp6IkL+v0iagUDB2mbc8Yqkjay+5cg0r9+YWHj0JIEf
         JWB18ZDuXr0QSQqX41eNbzNeFv9bZyD8SQnbR8+J8NSHNABj3bFYgu2mk/iQp741COuS
         Pt/xYnxP0TwnZpCcrQGxQpJFOpfD1WplmgUdtizPiUlftlnn8fjrZ7WBeIvx/WqgbJ3B
         OZX7P12LIOOGsmKjQDpt/YyuTURVveQkEidq+uHTC6f/cOXVOQfWpYrwGNT4fJjr6Ji4
         Z95V6uIIIE6asNb9J7vpGzOU6AyiPwyatqpFy2EvSaSL2ZUfSpyQnh9YUg7EBumxA8yY
         IJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678953075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwNs+y4b7W9cSxLh5xgNZaGX62BKSLC/hX9j+Q1b4kU=;
        b=NtlYI3OxhLnZk4keBTWa/4LdMnvE8fCKeSorbk5Zon4gvHeib1YOJXrJQlkd0yWSQe
         Ykzgr0tH/mn8Ortz8KYVNX0Tc6Jb28cdaXi4RfTeH82zRkDo19grRMzDqcSFncHn5e0B
         FpEslnfg85aNcdFvjOqGd9Q0kbGZ2LB3F8VrlmPcldICvH9Bcl7lPhYl8dwwu8AgJOJP
         p5XUChazFXox1w3t3EghyFz9SSq5AdIRuEpnoAtYCWYof7VDuyuQQo/6b8s5apeJwqVw
         zEjdOTzfjPBQwgVMKjaUyiCESIrZ4aAS5l+x7y1nHF8tZFZa4QFrlwBSwr6RFWVVtedO
         VPUQ==
X-Gm-Message-State: AO0yUKVyfA6zB4TxJrxeslLwEJuxuztqTSggUjlwbJVmYpGEGDUt3Tf5
        q7Ux4IjCZTF87EKgWEb/NfhkOQ==
X-Google-Smtp-Source: AK7set+PJC6hY5dJwdCmdbgJw/oOolEboNlFTBYJRN22RgczatHslhrlEzZcqy603FbcwYk5kqVcOA==
X-Received: by 2002:a17:906:940f:b0:8b2:37b5:cc4 with SMTP id q15-20020a170906940f00b008b237b50cc4mr9646884ejx.7.1678953075506;
        Thu, 16 Mar 2023 00:51:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id h25-20020a17090619d900b008b9b4ab6ad1sm3501654ejd.102.2023.03.16.00.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:51:15 -0700 (PDT)
Message-ID: <764f9105-e888-4776-bd49-efec72bd409d@linaro.org>
Date:   Thu, 16 Mar 2023 08:51:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 12/15] clk: nuvoton: Add clock driver for ma35d1 clock
 controller
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-13-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315072902.9298-13-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2023 08:28, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> The clock controller generates clocks for the whole chip, including
> system clocks and all peripheral clocks. This driver support ma35d1
> clock gating, divider, and individual PLL configuration.
> 
> There are 6 PLLs in ma35d1 SoC:
>   - CA-PLL for the two Cortex-A35 CPU clock
>   - SYS-PLL for system bus, which comes from the companion MCU
>     and cannot be programmed by clock controller.
>   - DDR-PLL for DDR
>   - EPLL for GMAC and GFX, Display, and VDEC IPs.
>   - VPLL for video output pixel clock
>   - APLL for SDHC, I2S audio, and other IPs.
> CA-PLL has only one operation mode.
> DDR-PLL, EPLL, VPLL, and APLL are advanced PLLs which have 3
> operation modes: integer mode, fraction mode, and spread specturm mode.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  drivers/clk/Makefile                     |   1 +
>  drivers/clk/nuvoton/Makefile             |   4 +
>  drivers/clk/nuvoton/clk-ma35d1-divider.c | 144 ++++
>  drivers/clk/nuvoton/clk-ma35d1-pll.c     | 534 +++++++++++++
>  drivers/clk/nuvoton/clk-ma35d1.c         | 970 +++++++++++++++++++++++
>  drivers/clk/nuvoton/clk-ma35d1.h         | 198 +++++
>  6 files changed, 1851 insertions(+)
>  create mode 100644 drivers/clk/nuvoton/Makefile
>  create mode 100644 drivers/clk/nuvoton/clk-ma35d1-divider.c
>  create mode 100644 drivers/clk/nuvoton/clk-ma35d1-pll.c
>  create mode 100644 drivers/clk/nuvoton/clk-ma35d1.c
>  create mode 100644 drivers/clk/nuvoton/clk-ma35d1.h
> 
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index e3ca0d058a25..2e7916d269e1 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -103,6 +103,7 @@ endif
>  obj-y					+= mstar/
>  obj-y					+= mvebu/
>  obj-$(CONFIG_ARCH_MXS)			+= mxs/
> +obj-$(CONFIG_ARCH_NUVOTON)		+= nuvoton/

Missing compile test.

(...)

> +
> +MODULE_AUTHOR("Chi-Fang Li<cfli0@nuvoton.com>");
> +MODULE_DESCRIPTION("NUVOTON MA35D1 Clock Driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/clk/nuvoton/clk-ma35d1.h b/drivers/clk/nuvoton/clk-ma35d1.h
> new file mode 100644
> index 000000000000..faae5a17e425
> --- /dev/null
> +++ b/drivers/clk/nuvoton/clk-ma35d1.h
> @@ -0,0 +1,198 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2023 Nuvoton Technology Corp.
> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
> + */
> +
> +#ifndef __DRV_CLK_NUVOTON_MA35D1_H
> +#define __DRV_CLK_NUVOTON_MA35D1_H
> +
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/spinlock.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mfd/ma35d1-sys.h>
> +
> +enum ma35d1_pll_type {
> +	MA35D1_CAPLL,
> +	MA35D1_DDRPLL,
> +	MA35D1_APLL,
> +	MA35D1_EPLL,
> +	MA35D1_VPLL,
> +};
> +
> +enum ma35d1_pll_mode {
> +	VSIPLL_INTEGER_MODE,
> +	VSIPLL_FRACTIONAL_MODE,
> +	VSIPLL_SS_MODE,
> +};
> +
> +/* VSI-PLL CTL0~2 */
> +#define VSIPLL_CTL0			0x0
> +#define VSIPLL_CTL1			0x4
> +#define VSIPLL_CTL2			0x8
> +
> +/* VSI-PLL Specification limits */
> +#define VSIPLL_FREF_MAX_FREQ		200000000UL
> +#define VSIPLL_FREF_MIN_FREQ		1000000UL
> +#define VSIPLL_FREFDIVM_MAX_FREQ	40000000UL
> +#define VSIPLL_FREFDIVM_MIN_FREQ0	1000000UL
> +#define VSIPLL_FREFDIVM_MIN_FREQ1	10000000UL
> +#define VSIPLL_FCLK_MAX_FREQ		2400000000UL
> +#define VSIPLL_FCLK_MIN_FREQ		600000000UL
> +#define VSIPLL_FCLKO_MAX_FREQ		2400000000UL
> +#define VSIPLL_FCLKO_MIN_FREQ		85700000UL
> +#define VSIPLL_SPREAD_RANGE		194
> +#define VSIPLL_MODULATION_FREQ		50000
> +
> +/* Clock Control Registers Offset */
> +#define REG_CLK_PWRCTL			(0x00)
> +#define REG_CLK_SYSCLK0			(0x04)
> +#define REG_CLK_SYSCLK1			(0x08)
> +#define REG_CLK_APBCLK0			(0x0C)
> +#define REG_CLK_APBCLK1			(0x10)
> +#define REG_CLK_APBCLK2			(0x14)
> +#define REG_CLK_CLKSEL0			(0x18)
> +#define REG_CLK_CLKSEL1			(0x1C)
> +#define REG_CLK_CLKSEL2			(0x20)
> +#define REG_CLK_CLKSEL3			(0x24)
> +#define REG_CLK_CLKSEL4			(0x28)
> +#define REG_CLK_CLKDIV0			(0x2C)
> +#define REG_CLK_CLKDIV1			(0x30)
> +#define REG_CLK_CLKDIV2			(0x34)
> +#define REG_CLK_CLKDIV3			(0x38)
> +#define REG_CLK_CLKDIV4			(0x3C)
> +#define REG_CLK_CLKOCTL			(0x40)
> +#define REG_CLK_STATUS			(0x50)
> +#define REG_CLK_PLL0CTL0		(0x60)
> +#define REG_CLK_PLL2CTL0		(0x80)
> +#define REG_CLK_PLL2CTL1		(0x84)
> +#define REG_CLK_PLL2CTL2		(0x88)
> +#define REG_CLK_PLL3CTL0		(0x90)
> +#define REG_CLK_PLL3CTL1		(0x94)
> +#define REG_CLK_PLL3CTL2		(0x98)
> +#define REG_CLK_PLL4CTL0		(0xA0)
> +#define REG_CLK_PLL4CTL1		(0xA4)
> +#define REG_CLK_PLL4CTL2		(0xA8)
> +#define REG_CLK_PLL5CTL0		(0xB0)
> +#define REG_CLK_PLL5CTL1		(0xB4)
> +#define REG_CLK_PLL5CTL2		(0xB8)
> +#define REG_CLK_CLKDCTL			(0xC0)
> +#define REG_CLK_CLKDSTS			(0xC4)
> +#define REG_CLK_CDUPB			(0xC8)
> +#define REG_CLK_CDLOWB			(0xCC)
> +#define REG_CLK_CKFLTRCTL		(0xD0)
> +#define REG_CLK_TESTCLK			(0xF0)
> +#define REG_CLK_PLLCTL			(0x40)
> +
> +/* Constant Definitions for Clock Controller */
> +#define SMICPLLCTL0_FBDIV_POS		(0)
> +#define SMICPLLCTL0_FBDIV_MSK		(0xfful << SMICPLLCTL0_FBDIV_POS)
> +#define SMICPLLCTL0_INDIV_POS		(8)
> +#define SMICPLLCTL0_INDIV_MSK		(0xful << SMICPLLCTL0_INDIV_POS)
> +#define SMICPLLCTL0_OUTDIV_POS		(12)
> +#define SMICPLLCTL0_OUTDIV_MSK		(0x3ul << SMICPLLCTL0_OUTDIV_POS)
> +#define SMICPLLCTL0_PD_POS		(16)
> +#define SMICPLLCTL0_PD_MSK		(0x1ul << SMICPLLCTL0_PD_POS)
> +#define SMICPLLCTL0_BP_POS		(17)
> +#define SMICPLLCTL0_BP_MSK		(0x1ul << SMICPLLCTL0_BP_POS)
> +#define VSIPLLCTL0_FBDIV_POS		(0)
> +#define VSIPLLCTL0_FBDIV_MSK		(0x7fful << VSIPLLCTL0_FBDIV_POS)
> +#define VSIPLLCTL0_INDIV_POS		(12)
> +#define VSIPLLCTL0_INDIV_MSK		(0x3ful << VSIPLLCTL0_INDIV_POS)
> +#define VSIPLLCTL0_MODE_POS		(18)
> +#define VSIPLLCTL0_MODE_MSK		(0x3ul << VSIPLLCTL0_MODE_POS)
> +#define VSIPLLCTL0_SSRATE_POS		(20)
> +#define VSIPLLCTL0_SSRATE_MSK		(0x7fful << VSIPLLCTL0_SSRATE_POS)
> +#define VSIPLLCTL1_PD_POS		(0)
> +#define VSIPLLCTL1_PD_MSK		(0x1ul << VSIPLLCTL1_PD_POS)
> +#define VSIPLLCTL1_BP_POS		(1)
> +#define VSIPLLCTL1_BP_MSK		(0x1ul << VSIPLLCTL1_BP_POS)
> +#define VSIPLLCTL1_OUTDIV_POS		(4)
> +#define VSIPLLCTL1_OUTDIV_MSK		(0x7ul << VSIPLLCTL1_OUTDIV_POS)
> +#define VSIPLLCTL1_FRAC_POS		(8)
> +#define VSIPLLCTL1_FRAC_MSK		(0xfffffful << VSIPLLCTL1_FRAC_POS)
> +#define VSIPLLCTL2_SLOPE_POS		(0)
> +#define VSIPLLCTL2_SLOPE_MSK		(0xfffffful << VSIPLLCTL2_SLOPE_POS)
> +
> +struct clk_hw *ma35d1_reg_clk_pll(enum ma35d1_pll_type type, u8 u8mode,
> +				 const char *name, const char *parent,
> +				 unsigned long targetFreq,
> +				 void __iomem *base,
> +				 struct regmap *regmap);
> +
> +struct clk_hw *ma35d1_reg_adc_clkdiv(struct device *dev,
> +				    const char *name,
> +				    const char *parent_name,
> +				    unsigned long flags,
> +				    void __iomem *reg, u8 shift,
> +				    u8 width, u32 mask_bit);
> +
> +extern spinlock_t ma35d1_lock;

Why this is here?

> +
> +static inline struct clk_hw *ma35d1_clk_fixed(const char *name, int rate)
> +{
> +	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
> +}
> +

Why all these are here?

> +
> +#endif /* __DRV_CLK_NUVOTON_MA35D1_H */

Best regards,
Krzysztof

