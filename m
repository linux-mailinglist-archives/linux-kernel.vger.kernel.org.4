Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879C56E6A68
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjDRRCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjDRRC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:02:28 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C026A6A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:02:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id fy21so31984773ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681837344; x=1684429344;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+5TFm8G1q6eckW0t79BRMGwZlMLiJfFRdZkFunxVru8=;
        b=rdGnL0DWhUo73XXGLtsCT7BmZDNRn9a/kJTIoYryn5EmJbzIB93+CwLBY0kk2wHEkx
         aqdGBNZ6pHRu0CLTwmXfEy/aWi8hwUc/cU/Kj68zW3b8nFqpq6K64PM3pjDaZFVHHecy
         UgcD3DKVx3ncyhBzsEtsKr2XMTUFNE5TSVQJcsKIcagcFG8n65qVR28CCdgW5CTg48h6
         CJrXTzZeHyQQRXzog9IOWDwbw6bYptuKJD/ysiIzdpYOxEJqoVZFrWadTS6tj7GBPoRS
         xS96BHbCfnZLXu+d2iBR3VhytThfw1wj90qNUQ7cUgNkUEhqHu4M83maJkN5KCO4Lbko
         UGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681837344; x=1684429344;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5TFm8G1q6eckW0t79BRMGwZlMLiJfFRdZkFunxVru8=;
        b=Vip96l2zTAwT5Jk3OH75U7oINWf/Yc/RMc7UMd8Gm5xzFZ/i+N0jfSOaNCmGQcCkMu
         iv/fJqq42TMrxpSe/bM7kADSQkAk8WsT+g7xdIyYUuMrrm2fzpAcUw7lDRE2AJVMuW+l
         XoWeNKNVm9GMWvKC4IXReQjnQ3A0O2DAchcdMTGbxFmqc2HsF/X93ysbwzuiiUMRCUqx
         VmyHJQzAmJXDL8VoiqyE/i1IvNLkwzZOrSQkJ325HIN5qpeD63TNf7KrnT+8FpKbLsEk
         cuv/sZQAj3fg6tEq0GmVDkDsigFYhECLzGujYntEZ8mGgzafxGah66RKUkd7aEJ/w7+0
         mMXg==
X-Gm-Message-State: AAQBX9duUXUMbJNztAXUw0+nmMtZKyFwHpjGcO56VrYFY8TDjwDDp8br
        IATXVwBRez0CFAg7kQqlsGUvYw==
X-Google-Smtp-Source: AKy350alE0C6cFYBJL7Qdo8B11tUxsTNi5e5v1cDFh4R+8QtplXo+RlFiksXYi/z3F5NwG6HFCjWAw==
X-Received: by 2002:a17:906:6959:b0:94f:356d:cd0 with SMTP id c25-20020a170906695900b0094f356d0cd0mr10951845ejs.33.1681837344589;
        Tue, 18 Apr 2023 10:02:24 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id v14-20020a170906380e00b0094a46e2f12bsm8277102ejc.93.2023.04.18.10.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 10:02:24 -0700 (PDT)
Message-ID: <e28a7788-e4b5-d777-4775-d57a00b0fbcc@linaro.org>
Date:   Tue, 18 Apr 2023 19:02:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 1/9] gpio: gxp: Add HPE GXP GPIO
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, linux@armlinux.org.uk,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230418152824.110823-1-nick.hawkins@hpe.com>
 <20230418152824.110823-2-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230418152824.110823-2-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 17:28, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> The GXP SoC supports GPIO on multiple interfaces: Host, CPLD and Soc
> pins. The interface from CPLD and Host are interruptable from vic0
> and vic1. This driver allows support for both of these interfaces
> through the use of different compatible bindings.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  drivers/gpio/Kconfig    |    9 +
>  drivers/gpio/Makefile   |    1 +
>  drivers/gpio/gpio-gxp.c | 1056 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1066 insertions(+)
>  create mode 100644 drivers/gpio/gpio-gxp.c
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 13be729710f2..47435307698c 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1235,6 +1235,15 @@ config HTC_EGPIO
>  	  several HTC phones.  It provides basic support for input
>  	  pins, output pins, and IRQs.
>  
> +config GPIO_GXP
> +        tristate "GXP GPIO support"
> +        depends on ARCH_HPE_GXP

|| COMPILE_TEST

(...)

> +
> +	drvdata->chip.parent = &pdev->dev;
> +	ret = devm_gpiochip_add_data(&pdev->dev, &drvdata->chip, NULL);
> +	if (ret < 0)
> +		dev_err(&pdev->dev,
> +			"Could not register gpiochip for fn2, %d\n", ret);
> +	dev_info(&pdev->dev, "HPE GXP FN2 driver loaded.\n");

Drop non-informative probe successes. They are not needed.


> +
> +	return 0;
> +}
> +
> +static int gxp_gpio_pl_init(struct platform_device *pdev)
> +{
> +	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
> +	struct gpio_irq_chip *girq;
> +	int ret;
> +	unsigned int val;
> +
> +	drvdata->pl_led = gxp_gpio_init_regmap(pdev, "pl-led", 8);
> +	if (IS_ERR(drvdata->pl_led))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->pl_int),
> +				     "failed to map pl_led\n");
> +
> +	drvdata->pl_health = gxp_gpio_init_regmap(pdev, "pl-health", 8);
> +	if (IS_ERR(drvdata->pl_health))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->pl_int),
> +				     "failed to map pl_health\n");
> +
> +	drvdata->pl_int = gxp_gpio_init_regmap(pdev, "pl-int", 8);
> +	if (IS_ERR(drvdata->pl_int))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->pl_int),
> +				     "failed to map pl_int\n");
> +
> +	drvdata->chip = plreg_chip;
> +	drvdata->chip.ngpio = 100;
> +	drvdata->chip.parent = &pdev->dev;
> +
> +	girq = &drvdata->chip.irq;
> +	girq->chip = &gxp_plreg_irqchip;
> +	girq->parent_handler = NULL;
> +	girq->num_parents = 0;
> +	girq->parents = NULL;
> +	girq->default_type = IRQ_TYPE_NONE;
> +	girq->handler = handle_edge_irq;
> +
> +	girq->init_hw = gxp_gpio_irq_init_hw;
> +
> +	ret = devm_gpiochip_add_data(&pdev->dev, &drvdata->chip, drvdata);
> +	if (ret < 0)
> +		dev_err(&pdev->dev, "Could not register gpiochip for plreg, %d\n",
> +			ret);
> +
> +	regmap_update_bits(drvdata->pl_int, PLREG_INT_HI_PRI_EN,
> +			   BIT(4) | BIT(5), BIT(4) | BIT(5));
> +	regmap_update_bits(drvdata->pl_int, PLREG_INT_GRP_STAT_MASK,
> +			   BIT(4) | BIT(5), 0x00);
> +	regmap_read(drvdata->pl_int, PLREG_INT_HI_PRI_EN, &val);
> +	regmap_read(drvdata->pl_int, PLREG_INT_GRP_STAT_MASK, &val);
> +
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Get irq from platform fail - %d\n", ret);
> +		return ret;

return dev_err_probe

> +	}
> +
> +	drvdata->irq = ret;
> +
> +	ret = devm_request_irq(&pdev->dev, drvdata->irq, gxp_gpio_pl_irq_handle,
> +			       IRQF_SHARED, "gxp-pl", drvdata);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "IRQ handler failed - %d\n", ret);

return dev_err_probe
Actually other applicable places as well...

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id gxp_gpio_of_match[] = {
> +	{ .compatible = "hpe,gxp-gpio"},
> +	{ .compatible = "hpe,gxp-gpio-pl"},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, gxp_gpio_of_match);
> +
> +static int gxp_gpio_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct gxp_gpio_drvdata *drvdata;
> +	struct device *dev = &pdev->dev;
> +	struct device *parent;
> +	const struct of_device_id *match = of_match_device(gxp_gpio_of_match, dev);
> +
> +	if (!match) {
> +		dev_err(dev, "device is not compatible");

It is not possible.

> +		return -EINVAL;
> +	}
> +
> +	parent = dev->parent;
> +	if (!parent) {
> +		dev_err(dev, "no parent\n");

Why do you need this check?

> +		return -ENODEV;
> +	}
> +
> +	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct gxp_gpio_drvdata),

sizeof(*)

> +			       GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, drvdata);
> +
> +	if (strcmp(match->compatible, "hpe,gxp-gpio-pl") == 0)

No, use match data. Anyway this is open-coding of OF functions...

> +		ret = gxp_gpio_pl_init(pdev);
> +	else
> +		ret = gxp_gpio_init(pdev);
> +
> +	return ret;

Best regards,
Krzysztof

