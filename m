Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E48563BD01
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 10:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiK2JdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 04:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiK2JdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 04:33:14 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25F52CE26
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 01:33:12 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id n1so11437261ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 01:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1KXpJ/FhcKRR6iQ0f+D5q5T3RwhNO0JsJ5C5PoABof4=;
        b=NWjeEzgr8tTy687MbkOthYbE/28nvujW2CQIDb/EojcqIfPcOn0ZrRqqfK7hqrm6w4
         sA3yyu2Tv/uqOs2qJ8FcjGhNyjiv4cIM2K3b/MbyRA+nfRkbS5dSt5Mz/N0ITLAZKDuY
         2BnOZicXs54fH61ohygPDmHJQtZxjU3A/mLMBlmpdHJ3UeM6rLKxm16SUtvilp+KXLj7
         1WJW6AuiTpwvCMLmz5OWZSvS/eTGB8jnDwqVUPlVqGPaDPUfnrA7tZ6LFY9UMJu74O4B
         DSe8ovANdGX/t8GNmQy/y6e2Px1+BaGk80+efqEAPAyOp/yssKxzyhaAWYG/rKmcHRc/
         pmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1KXpJ/FhcKRR6iQ0f+D5q5T3RwhNO0JsJ5C5PoABof4=;
        b=l/JPpm0uYvLKkGbWnzKHk1PKP1ed51R6zIjTK2WefuhvBN8/r3PyyejZxueHUI3qNP
         o+SnRa/wm96doyIm7DVNl4TCiowKwah3nEOSI/dUlckpbkoIFoSN9wsAbMkCy+sG87rW
         V/d7J5ye3HZwjxZeKCVqkI0UIZdMe/vA+qqPgGSMPR7PYuhMP+HRrE3HkRAOy3pr+7Bo
         UdaLXfrQvgz0tgLmu4ByhqgIcU4cus+RgH/EXDg7qM+8/kDO/dHGJSPKK8I76sjSezr7
         HTccbL+DLpuonP8L9NjuxLvCfIqmHAPgoqAIRGUwI70a0PYNUUFnW6x8d9+elsbQmxI5
         0rqg==
X-Gm-Message-State: ANoB5pn2rzRpyrIAmyVStEkf/YwLP0LPg2mDxAZa7YnVeVFTpMsL7cww
        CoLE6b5WdzSWRIlyfDfN2Z439ocCGEdl+Abn
X-Google-Smtp-Source: AA0mqf5tLW7G8ea6DQk7SKUsA7tYAyKJc1UE9wNDzXfLXxKMjxLv/pW4hZOM1TpHTQ/WHOXaJksEGw==
X-Received: by 2002:a2e:bd0c:0:b0:277:10c2:e7ce with SMTP id n12-20020a2ebd0c000000b0027710c2e7cemr18898168ljq.370.1669714390957;
        Tue, 29 Nov 2022 01:33:10 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p13-20020a2e9acd000000b002774e7267a7sm1460180ljj.25.2022.11.29.01.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 01:33:10 -0800 (PST)
Message-ID: <76091207-d81c-e737-34a2-884153251925@linaro.org>
Date:   Tue, 29 Nov 2022 10:33:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/3] hwrng: add Rockchip SoC hwrng driver
Content-Language: en-US
To:     Aurelien Jarno <aurelien@aurel32.net>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lin Jinhan <troy.lin@rock-chips.com>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221128184718.1963353-1-aurelien@aurel32.net>
 <20221128184718.1963353-3-aurelien@aurel32.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221128184718.1963353-3-aurelien@aurel32.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2022 19:47, Aurelien Jarno wrote:
> Rockchip SoCs used to have a random number generator as part of their
> crypto device, and support for it has to be added to the corresponding
> driver. However newer Rockchip SoCs like the RK356x have an independent
> True Random Number Generator device. This patch adds a driver for it,
> greatly inspired from the downstream driver.
> 
> The TRNG device does not seem to have a signal conditionner and the FIPS
> 140-2 test returns a lot of failures. They can be reduced by increasing
> RK_RNG_SAMPLE_CNT, in a tradeoff between quality and speed. This value
> has been adjusted to get ~90% of successes and the quality value has
> been set accordingly.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  drivers/char/hw_random/Kconfig        |  14 ++
>  drivers/char/hw_random/Makefile       |   1 +
>  drivers/char/hw_random/rockchip-rng.c | 250 ++++++++++++++++++++++++++
>  3 files changed, 265 insertions(+)
>  create mode 100644 drivers/char/hw_random/rockchip-rng.c
> 
> diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
> index 3da8e85f8aae..8e5c88504f72 100644
> --- a/drivers/char/hw_random/Kconfig
> +++ b/drivers/char/hw_random/Kconfig
> @@ -549,6 +549,20 @@ config HW_RANDOM_CN10K
>  	 To compile this driver as a module, choose M here.
>  	 The module will be called cn10k_rng. If unsure, say Y.
>  
> +config HW_RANDOM_ROCKCHIP
> +        tristate "Rockchip True Random Number Generator"
> +        depends on HW_RANDOM && (ARCH_ROCKCHIP || COMPILE_TEST)
> +        depends on HAS_IOMEM
> +        default HW_RANDOM
> +        help
> +          This driver provides kernel-side support for the True Random Number
> +          Generator hardware found on some Rockchip SoC like RK3566 or RK3568.
> +
> +          To compile this driver as a module, choose M here: the
> +          module will be called rockchip-rng.
> +
> +          If unsure, say Y.
> +
>  endif # HW_RANDOM
>  
>  config UML_RANDOM
> diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
> index 3e948cf04476..b7e989535fd6 100644
> --- a/drivers/char/hw_random/Makefile
> +++ b/drivers/char/hw_random/Makefile
> @@ -47,3 +47,4 @@ obj-$(CONFIG_HW_RANDOM_XIPHERA) += xiphera-trng.o
>  obj-$(CONFIG_HW_RANDOM_ARM_SMCCC_TRNG) += arm_smccc_trng.o
>  obj-$(CONFIG_HW_RANDOM_CN10K) += cn10k-rng.o
>  obj-$(CONFIG_HW_RANDOM_POLARFIRE_SOC) += mpfs-rng.o
> +obj-$(CONFIG_HW_RANDOM_ROCKCHIP) += rockchip-rng.o
> diff --git a/drivers/char/hw_random/rockchip-rng.c b/drivers/char/hw_random/rockchip-rng.c
> new file mode 100644
> index 000000000000..18cdd91ad8c3
> --- /dev/null
> +++ b/drivers/char/hw_random/rockchip-rng.c
> @@ -0,0 +1,250 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * rockchip-rng.c True Random Number Generator driver for Rockchip SoCs
> + *
> + * Copyright (c) 2018, Fuzhou Rockchip Electronics Co., Ltd.
> + * Copyright (c) 2022, Aurelien Jarno
> + * Authors:
> + *  Lin Jinhan <troy.lin@rock-chips.com>
> + *  Aurelien Jarno <aurelien@aurel32.net>
> + */
> +#include <linux/clk.h>
> +#include <linux/hw_random.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +
> +#define RK_RNG_AUTOSUSPEND_DELAY	100
> +#define RK_RNG_MAX_BYTE			32
> +#define RK_RNG_POLL_PERIOD_US		100
> +#define RK_RNG_POLL_TIMEOUT_US		10000
> +
> +/*
> + * TRNG collects osc ring output bit every RK_RNG_SAMPLE_CNT time. The value is
> + * a tradeoff between speed and quality and has been adjusted to get a quality
> + * of ~900 (~90% of FIPS 140-2 successes).
> + */
> +#define RK_RNG_SAMPLE_CNT		1000
> +
> +/* TRNG registers from RK3568 TRM-Part2, section 5.4.1 */
> +#define TRNG_RST_CTL			0x0004
> +#define TRNG_RNG_CTL			0x0400
> +#define TRNG_RNG_CTL_LEN_64_BIT		(0x00 << 4)
> +#define TRNG_RNG_CTL_LEN_128_BIT	(0x01 << 4)
> +#define TRNG_RNG_CTL_LEN_192_BIT	(0x02 << 4)
> +#define TRNG_RNG_CTL_LEN_256_BIT	(0x03 << 4)
> +#define TRNG_RNG_CTL_OSC_RING_SPEED_0	(0x00 << 2)
> +#define TRNG_RNG_CTL_OSC_RING_SPEED_1	(0x01 << 2)
> +#define TRNG_RNG_CTL_OSC_RING_SPEED_2	(0x02 << 2)
> +#define TRNG_RNG_CTL_OSC_RING_SPEED_3	(0x03 << 2)
> +#define TRNG_RNG_CTL_ENABLE		BIT(1)
> +#define TRNG_RNG_CTL_START		BIT(0)
> +#define TRNG_RNG_SAMPLE_CNT		0x0404
> +#define TRNG_RNG_DOUT_0			0x0410
> +#define TRNG_RNG_DOUT_1			0x0414
> +#define TRNG_RNG_DOUT_2			0x0418
> +#define TRNG_RNG_DOUT_3			0x041c
> +#define TRNG_RNG_DOUT_4			0x0420
> +#define TRNG_RNG_DOUT_5			0x0424
> +#define TRNG_RNG_DOUT_6			0x0428
> +#define TRNG_RNG_DOUT_7			0x042c
> +
> +struct rk_rng {
> +	struct hwrng rng;
> +	void __iomem *base;
> +	struct reset_control *rst;
> +	int clk_num;
> +	struct clk_bulk_data *clk_bulks;
> +};
> +
> +/* The mask determine the bits that are updated */
> +static void rk_rng_write_ctl(struct rk_rng *rng, u32 val, u32 mask)
> +{
> +	writel_relaxed((mask << 16) | val, rng->base + TRNG_RNG_CTL);
> +}
> +
> +static int rk_rng_init(struct hwrng *rng)
> +{
> +	struct rk_rng *rk_rng = container_of(rng, struct rk_rng, rng);
> +	u32 reg;
> +	int ret;
> +
> +	/* start clocks */
> +	ret = clk_bulk_prepare_enable(rk_rng->clk_num, rk_rng->clk_bulks);
> +	if (ret < 0) {
> +		dev_err((struct device *) rk_rng->rng.priv,
> +			"Failed to enable clks %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* set the sample period */
> +	writel(RK_RNG_SAMPLE_CNT, rk_rng->base + TRNG_RNG_SAMPLE_CNT);
> +
> +	/* set osc ring speed and enable it */
> +	reg = TRNG_RNG_CTL_LEN_256_BIT |

It's not reg. It's val.

> +		   TRNG_RNG_CTL_OSC_RING_SPEED_0 |
> +		   TRNG_RNG_CTL_ENABLE;
> +	rk_rng_write_ctl(rk_rng, reg, 0xffff);
> +
> +	return 0;
> +}
> +
> +static void rk_rng_cleanup(struct hwrng *rng)
> +{
> +	struct rk_rng *rk_rng = container_of(rng, struct rk_rng, rng);
> +	u32 reg;
> +
> +	/* stop TRNG */
> +	reg = 0;

It's not reg. It's val.

> +	rk_rng_write_ctl(rk_rng, reg, 0xffff);
> +
> +	/* stop clocks */
> +	clk_bulk_disable_unprepare(rk_rng->clk_num, rk_rng->clk_bulks);
> +}
> +
> +static int rk_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
> +{
> +	struct rk_rng *rk_rng = container_of(rng, struct rk_rng, rng);
> +	u32 reg;
> +	int ret = 0;
> +	int i;
> +
> +	pm_runtime_get_sync((struct device *) rk_rng->rng.priv);

Missing error handling.

> +
> +	/* Start collecting random data */
> +	reg = TRNG_RNG_CTL_START;

This is not usefull. Just use it directly in write call. Actually this
is heavy confusing, as reg suggests address. This would be val instead...

> +	rk_rng_write_ctl(rk_rng, reg, reg);
> +
> +	ret = readl_poll_timeout(rk_rng->base + TRNG_RNG_CTL, reg,
> +				 !(reg & TRNG_RNG_CTL_START),
> +				 RK_RNG_POLL_PERIOD_US,
> +				 RK_RNG_POLL_TIMEOUT_US);
> +	if (ret < 0)
> +		goto out;
> +
> +	/* Read random data stored in the registers */
> +	ret = min_t(size_t, max, RK_RNG_MAX_BYTE);
> +	for (i = 0; i < ret; i += 4) {
> +		*(u32 *)(buf + i) = readl_relaxed(rk_rng->base + TRNG_RNG_DOUT_0 + i);
> +	}

This cannot be just memcpy_fromio?

> +
> +out:
> +	pm_runtime_mark_last_busy((struct device *) rk_rng->rng.priv);
> +	pm_runtime_put_sync_autosuspend((struct device *) rk_rng->rng.priv);
> +
> +	return ret;
> +}
> +
> +static int rk_rng_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct rk_rng *rk_rng;
> +	int ret;
> +
> +	rk_rng = devm_kzalloc(dev, sizeof(struct rk_rng), GFP_KERNEL);

sizeof(*rk_rng)

> +	if (!rk_rng)
> +		return -ENOMEM;
> +

Best regards,
Krzysztof

