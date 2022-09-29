Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5D65EFC84
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbiI2R5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbiI2R5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:57:39 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C702F50B5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:57:37 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id u59-20020a17090a51c100b00205d3c44162so6691678pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=+yNiT9IW9rypDA3SBFF/X+2wnJNYacifHzWzldOuinY=;
        b=Aetb/CwF11lPf/BgyiLTDgC8JGAaSG3oEF/tQX8vhLxLW0MbXKVhFm1mUzsv1WBE/6
         OisHisnewGD66vc0zOogVUldL58/ZmXTCRvdAzMYPrKUPgfANhINn7yNUzZrDFXGvS1K
         1kbn/5nClHsbCoH044/VkelXa19hpGkof0ItVqFy4T87WiplzWwKBZcr9Y4z7oDH+l7M
         CXgizZPFXNjslweHfPogRHWVoLQFLr1Nh2PKevqWxctIb6A6tuQR1AvGCn1vEi8ldPua
         KZurFcDK6W+1u/RNerrexpe6r2orOnZJlEdUhBKIRZx5Y6GDzl9oO8MYnc4jRI17mu17
         9cUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+yNiT9IW9rypDA3SBFF/X+2wnJNYacifHzWzldOuinY=;
        b=eKM+YqcwK5HjyakcheV/2Wq3tPwz3INonrRv/IyQIdCZyXA6Jr9RV2RFmzvIPIbZ2p
         hOhBowtxVcb4u/nZjxQbku86WOYIjSMKEAdHd1eO3A0kDnCJtOYecuLd1ONnPUX/FKPW
         pXAs3xfX2SE+ZRNO8pXtJ5VemySHORzpZyGzJaqQdWpaLO9t5gNZoDTays2rFLyr1kJo
         Whg+MTM6zbzMq6UHCNQsPZm1rbh932KR036w20Rf3LfLdSYy4iW0OfbAHy2XqICsEKem
         Bnzpi+r33GFvpHjd/4Dq0xFfE5qIYf550WqErF1ENu4obT/TrCpwhMRxAhQq8FeSapks
         aSrA==
X-Gm-Message-State: ACrzQf09NtEeGPY4XakE/OafP4moI6m3HnnekQVOIdDfWNqkwdT9Hbqy
        orr8dXeiCrpZ59ozKisT+Hldew==
X-Google-Smtp-Source: AMsMyM5fOjCL0nDiei3D/4TzCIHjodyRTeL4unQHD5Jj55LtLWqygLKO/RRCiGi/g1lFAFmGj9d4uQ==
X-Received: by 2002:a17:90b:384f:b0:202:e1b9:5921 with SMTP id nl15-20020a17090b384f00b00202e1b95921mr17831610pjb.130.1664474256689;
        Thu, 29 Sep 2022 10:57:36 -0700 (PDT)
Received: from [172.20.4.240] ([12.199.201.12])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902e89200b00176b63535ccsm154047plg.193.2022.09.29.10.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 10:57:36 -0700 (PDT)
Message-ID: <40d0abb6-88dc-d315-f768-27a623f60986@sifive.com>
Date:   Thu, 29 Sep 2022 18:57:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 05/30] soc: sifive: l2 cache: Convert to platform
 driver
Content-Language: en-GB
To:     Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org, Zong Li <zong.li@sifive.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220929143225.17907-6-hal.feng@linux.starfivetech.com>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <20220929143225.17907-6-hal.feng@linux.starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 15:32, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> This converts the driver to use the builtin_platform_driver_probe macro
> to initialize the driver. This macro ends up calling device_initcall as
> was used previously, but also allocates a platform device which gives us
> access to much nicer APIs such as platform_ioremap_resource,
> platform_get_irq and dev_err_probe.

This is useful, but also there are other changes currently being sorted
out by Zong Li (cc'd into this message) which have already been reviewed
and are hopefully queued for the next kernel release.

> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> ---
>   drivers/soc/sifive/sifive_l2_cache.c | 79 ++++++++++++++--------------
>   1 file changed, 40 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/soc/sifive/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
> index 59640a1d0b28..010d612f7420 100644
> --- a/drivers/soc/sifive/sifive_l2_cache.c
> +++ b/drivers/soc/sifive/sifive_l2_cache.c
> @@ -7,9 +7,9 @@
>    */
>   #include <linux/debugfs.h>
>   #include <linux/interrupt.h>
> -#include <linux/of_irq.h>
> -#include <linux/of_address.h>
> -#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
>   #include <asm/cacheinfo.h>
>   #include <soc/sifive/sifive_l2_cache.h>
>   
> @@ -96,12 +96,6 @@ static void l2_config_read(void)
>   	pr_info("L2CACHE: Index of the largest way enabled: %d\n", regval);
>   }
>   
> -static const struct of_device_id sifive_l2_ids[] = {
> -	{ .compatible = "sifive,fu540-c000-ccache" },
> -	{ .compatible = "sifive,fu740-c000-ccache" },
> -	{ /* end of table */ },
> -};
> -
>   static ATOMIC_NOTIFIER_HEAD(l2_err_chain);
>   
>   int register_sifive_l2_error_notifier(struct notifier_block *nb)
> @@ -192,36 +186,29 @@ static irqreturn_t l2_int_handler(int irq, void *device)
>   	return IRQ_HANDLED;
>   }
>   
> -static int __init sifive_l2_init(void)
> +static int __init sifive_l2_probe(struct platform_device *pdev)
>   {
> -	struct device_node *np;
> -	struct resource res;
> -	int i, rc, intr_num;
> -
> -	np = of_find_matching_node(NULL, sifive_l2_ids);
> -	if (!np)
> -		return -ENODEV;
> -
> -	if (of_address_to_resource(np, 0, &res))
> -		return -ENODEV;
> -
> -	l2_base = ioremap(res.start, resource_size(&res));
> -	if (!l2_base)
> -		return -ENOMEM;
> -
> -	intr_num = of_property_count_u32_elems(np, "interrupts");
> -	if (!intr_num) {
> -		pr_err("L2CACHE: no interrupts property\n");
> -		return -ENODEV;
> -	}
> -
> -	for (i = 0; i < intr_num; i++) {
> -		g_irq[i] = irq_of_parse_and_map(np, i);
> -		rc = request_irq(g_irq[i], l2_int_handler, 0, "l2_ecc", NULL);
> -		if (rc) {
> -			pr_err("L2CACHE: Could not request IRQ %d\n", g_irq[i]);
> -			return rc;
> -		}
> +	struct device *dev = &pdev->dev;
> +	int nirqs;
> +	int ret;
> +	int i;
> +
> +	l2_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(l2_base))
> +		return PTR_ERR(l2_base);
> +
> +	nirqs = platform_irq_count(pdev);
> +	if (nirqs <= 0)
> +		return dev_err_probe(dev, -ENODEV, "no interrupts\n");

I wonder if zero irqs is an actual issue here?

> +	for (i = 0; i < nirqs; i++) {
> +		g_irq[i] = platform_get_irq(pdev, i);

I wonder if we need to keep g_irq[] around now? Is it going to be useful 
in the future?

> +		if (g_irq[i] < 0)
> +			return g_irq[i];
> +
> +		ret = devm_request_irq(dev, g_irq[i], l2_int_handler, 0, pdev->name, NULL);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Could not request IRQ %d\n", g_irq[i]);
>   	}
>   
>   	l2_config_read();
> @@ -234,4 +221,18 @@ static int __init sifive_l2_init(void)
>   #endif
>   	return 0;
>   }
> -device_initcall(sifive_l2_init);
> +
> +static const struct of_device_id sifive_l2_match[] = {
> +	{ .compatible = "sifive,fu540-c000-ccache" },
> +	{ .compatible = "sifive,fu740-c000-ccache" },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver sifive_l2_driver = {
> +	.driver = {
> +		.name = "sifive_l2_cache",
> +		.of_match_table = sifive_l2_match,
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +builtin_platform_driver_probe(sifive_l2_driver, sifive_l2_probe);

