Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7A26A5AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 15:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjB1OfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 09:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjB1OfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 09:35:00 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9200B26CE1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 06:34:29 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id ck15so41115857edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 06:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677594867;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uebId/E2MuuN0Eng4ubkqVVfbCw/rWB/uItWH6yqNNk=;
        b=SI1irGw+2fPr4/IIo5aLmevlsfiWicfh32tSgX+IUYC71HxA75YDUQ9pb8LkiOS8uT
         FHAFOt8ewX53zbChepayWL7SwPz9Ayns/9NVnNtndQwYoZXeWgyIPXrlfttmYyVNJFk/
         AwilCDZRVd3j/dyXG0dT2ud2mSMTz1R7BdSKKbJ/ZAVdLxMaanUrKptrFYs7+vBVj5gO
         Xe0aHcjcZPBPXoCa9iArNaI8zO/hPBBxw6MWO3m4oNZNpNobFTxlKrtPRe3We6L0e9te
         a4uMGTwfAlRcSU3KGT+iqr6AM1LcZMmRDKHAJrHgNhQEs0KO+yuGHyyYheLBVS58NNfE
         JEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677594867;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uebId/E2MuuN0Eng4ubkqVVfbCw/rWB/uItWH6yqNNk=;
        b=tNJdlf4Qno5fMWv3jbCpBupWP+J8x0Xz1kkXfJVnmQTF3Cerp9B1npi4WCGg4MlOqi
         j+2XT66XT2k/i78V81WQ03aQ0aNP2yWT6wZAf9QC9WoB8k+AbvUzHcgRwX9gvQIlFaa2
         nAkh9K6oJt6xEmxyeHuFcqvTjxYoz1NjgH7d0RIq7n0ezni/0AAMwN7D59OlNn9qHt93
         GxzYfEq1p8idcM+D/IAe24ycrGCNRlMDRqqMum3Waa9cDPgFLq0nb/d1hHNT6C8LHSR9
         Kab55fpalVYcLEQOH528z1x+Fw4BwXL3JrQc91j6+0tdA+s5MCFS3qUxPyFIo49tUkwS
         1dCg==
X-Gm-Message-State: AO0yUKU3dVhZrdhzl8k+rf956yCUzPYdcA9r2GssOD+P25Mzjs9QGS5X
        zAeTPwoarbfzSR0x9jbBouW0Sw==
X-Google-Smtp-Source: AK7set8kQ9ata6euqo/6Np+cgIW8IeRuMTqmy4tXn4RTpG4UPnLGLKgbZBqE0j7kjRa/ppTVghc7EQ==
X-Received: by 2002:aa7:c9d9:0:b0:4ab:1c69:5c4 with SMTP id i25-20020aa7c9d9000000b004ab1c6905c4mr3769925edt.26.1677594867546;
        Tue, 28 Feb 2023 06:34:27 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id qq10-20020a17090720ca00b008e09deb6610sm4518783ejb.200.2023.02.28.06.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 06:34:27 -0800 (PST)
Message-ID: <60496973-5382-14de-6c2d-c60b3556defb@linaro.org>
Date:   Tue, 28 Feb 2023 15:34:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 2/2] pwm: starfive: Add PWM driver support
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hal Feng <hal.feng@starfivetech.com>
References: <20230228091345.70515-1-william.qiu@starfivetech.com>
 <20230228091345.70515-3-william.qiu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230228091345.70515-3-william.qiu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2023 10:13, William Qiu wrote:
> Add Pulse Width Modulation driver support for StarFive
> JH7110 soc.
> 
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  MAINTAINERS                    |   7 +
>  drivers/pwm/Kconfig            |  10 ++
>  drivers/pwm/Makefile           |   1 +
>  drivers/pwm/pwm-starfive-ptc.c | 256 +++++++++++++++++++++++++++++++++
>  4 files changed, 274 insertions(+)
>  create mode 100644 drivers/pwm/pwm-starfive-ptc.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ac151975d0d3..05b59605d864 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19929,6 +19929,13 @@ F:	drivers/pinctrl/starfive/pinctrl-starfive-jh71*
>  F:	include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
>  F:	include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h
>  
> +STARFIVE JH71X0 PWM DRIVERS
> +M:	William Qiu <william.qiu@starfivetech.com>
> +M:	Hal Feng <hal.feng@starfivetech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/pwm/pwm-starfive.yaml
> +F:	drivers/pwm/pwm-starfive-ptc.c
> +
>  STARFIVE JH71X0 RESET CONTROLLER DRIVERS
>  M:	Emil Renner Berthing <kernel@esmil.dk>
>  M:	Hal Feng <hal.feng@starfivetech.com>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index dae023d783a2..2307a0099994 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -536,6 +536,16 @@ config PWM_SPRD
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sprd.
>  
> +config PWM_STARFIVE_PTC
> +	tristate "StarFive PWM PTC support"
> +	depends on OF
> +	depends on COMMON_CLK
> +	help
> +	  Generic PWM framework driver for StarFive SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-starfive-ptc.
> +
>  config PWM_STI
>  	tristate "STiH4xx PWM support"
>  	depends on ARCH_STI || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 7bf1a29f02b8..577f69904baa 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -49,6 +49,7 @@ obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
>  obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
>  obj-$(CONFIG_PWM_SPRD)		+= pwm-sprd.o
> +obj-$(CONFIG_PWM_STARFIVE_PTC)	+= pwm-starfive-ptc.o
>  obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
>  obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
>  obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
> diff --git a/drivers/pwm/pwm-starfive-ptc.c b/drivers/pwm/pwm-starfive-ptc.c
> new file mode 100644
> index 000000000000..58831c600168
> --- /dev/null
> +++ b/drivers/pwm/pwm-starfive-ptc.c
> @@ -0,0 +1,256 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PWM driver for the StarFive JH7110 SoC
> + *
> + * Copyright (C) 2018 StarFive Technology Co., Ltd.
> + */
> +
> +#include <dt-bindings/pwm/pwm.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/slab.h>
> +#include <linux/clk.h>
> +#include <linux/reset.h>
> +#include <linux/io.h>
> +
> +/* how many parameters can be transferred to ptc */
> +#define OF_PWM_N_CELLS			3
> +
> +/* PTC Register offsets */
> +#define REG_RPTC_CNTR			0x0
> +#define REG_RPTC_HRC			0x4
> +#define REG_RPTC_LRC			0x8
> +#define REG_RPTC_CTRL			0xC
> +
> +/* Bit for PWM clock */
> +#define BIT_PWM_CLOCK_EN		31
> +
> +/* Bit for clock gen soft reset */
> +#define BIT_CLK_GEN_SOFT_RESET		13
> +
> +#define NS_PER_SECOND			1000000000
> +#define DEFAULT_FREQ_HZ			2000000

Drop unused defines.

> +
> +/*
> + * Access PTC register (cntr hrc lrc and ctrl),
> + * need to replace PWM_BASE_ADDR
> + */
> +#define REG_PTC_BASE_ADDR_SUB(base, N)	\
> +((base) + (((N) > 3) ? (((N) % 4) * 0x10 + (1 << 15)) : ((N) * 0x10)))
> +#define REG_PTC_RPTC_CNTR(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N))
> +#define REG_PTC_RPTC_HRC(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N) + 0x4)
> +#define REG_PTC_RPTC_LRC(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N) + 0x8)
> +#define REG_PTC_RPTC_CTRL(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N) + 0xC)
> +
> +/* PTC_RPTC_CTRL */
> +#define PTC_EN      BIT(0)
> +#define PTC_ECLK    BIT(1)
> +#define PTC_NEC     BIT(2)
> +#define PTC_OE      BIT(3)
> +#define PTC_SIGNLE  BIT(4)
> +#define PTC_INTE    BIT(5)
> +#define PTC_INT     BIT(6)
> +#define PTC_CNTRRST BIT(7)
> +#define PTC_CAPTE   BIT(8)
> +
> +struct starfive_pwm_ptc_device {
> +	struct pwm_chip		chip;
> +	struct clk		*clk;
> +	struct reset_control	*rst;
> +	void __iomem		*regs;
> +	int			irq;
> +	/*pwm apb clock frequency*/

Missing spaces. Use Linux coding style.

> +	unsigned int		approx_freq;
> +};
> +
> +static inline struct starfive_pwm_ptc_device *
> +		chip_to_starfive_ptc(struct pwm_chip *c)
> +{
> +	return container_of(c, struct starfive_pwm_ptc_device, chip);
> +}
> +

(...)

> +static int starfive_pwm_ptc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct starfive_pwm_ptc_device *pwm;
> +	struct pwm_chip *chip;
> +	struct resource *res;
> +	unsigned int clk_apb_freq;
> +	int ret;
> +
> +	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	chip = &pwm->chip;
> +	chip->dev = dev;
> +	chip->ops = &starfive_pwm_ptc_ops;
> +	chip->npwm = 8;
> +
> +	chip->of_pwm_n_cells = OF_PWM_N_CELLS;
> +	chip->base = -1;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pwm->regs = devm_ioremap_resource(dev, res);

Combine these two, there is a helper for it.

> +	if (IS_ERR(pwm->regs)) {
> +		dev_err(dev, "Unable to map IO resources\n");

return dev_err_probe(), everywhere probably.

> +		return PTR_ERR(pwm->regs);
> +	}
> +
> +	pwm->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(pwm->clk)) {
> +		dev_err(dev, "Unable to get pwm clock\n");
> +		return PTR_ERR(pwm->clk);
> +	}
> +
> +	pwm->rst = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(pwm->rst)) {
> +		dev_err(dev, "Unable to get pwm reset\n");
> +		return PTR_ERR(pwm->rst);
> +	}
> +
> +	ret = clk_prepare_enable(pwm->clk);
> +	if (ret) {
> +		dev_err(dev,
> +			"Failed to enable pwm clock, %d\n", ret);
> +		return ret;
> +	}
> +
> +	reset_control_deassert(pwm->rst);
> +
> +	clk_apb_freq = (unsigned int)clk_get_rate(pwm->clk);

Why do you need this local variable? And why the cast?

> +	if (!clk_apb_freq)
> +		dev_warn(dev,
> +			 "get pwm apb clock rate failed.\n");

and pwm->approx_freq stays 0 which you later use for dividing. Did you
actually test it? It should produce big splat...

> +	else
> +		pwm->approx_freq = clk_apb_freq;
> +
> +	ret = pwmchip_add(chip);

devm

> +	if (ret < 0) {
> +		dev_err(dev, "cannot register PTC: %d\n", ret);
> +		clk_disable_unprepare(pwm->clk);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, pwm);
> +
> +	return 0;
> +}
> +
> +static int starfive_pwm_ptc_remove(struct platform_device *dev)
> +{
> +	struct starfive_pwm_ptc_device *pwm = platform_get_drvdata(dev);
> +	struct pwm_chip *chip = &pwm->chip;
> +
> +	pwmchip_remove(chip);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id starfive_pwm_ptc_of_match[] = {
> +	{ .compatible = "starfive,jh7110-pwm" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, starfive_pwm_ptc_of_match);
> +
> +static struct platform_driver starfive_pwm_ptc_driver = {
> +	.probe = starfive_pwm_ptc_probe,
> +	.remove = starfive_pwm_ptc_remove,
> +	.driver = {
> +		.name = "pwm-starfive-ptc",
> +		.of_match_table = of_match_ptr(starfive_pwm_ptc_of_match),

of_match_ptr goes with maybe_unused, which you do not have. Anyway I am
not sure what's the benefit of having it here, so just drop it.

Best regards,
Krzysztof

