Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5CE6FB7C4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 21:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjEHTxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 15:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjEHTxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 15:53:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E0365A0
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 12:52:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-956ff2399c9so940940566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 12:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683575504; x=1686167504;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Xu1aA1uZ8hLMQrpQh/gprcjgcAn2F9G+veq7uQFD7c=;
        b=UJtHSE2EcfdGKjE3TCe8PgeTd3zvwKw8i1dyrjVUvvN07XFb7KzA/dVVmdrSJj4ij0
         BVQ7w+XvCoSyndl27rcYNOlXFzv3TiJQ3XF6pce88Nvntx1J0BIGoTLFdV+CGcB788l0
         z2/8WeBhgw1apwxQP/Mg/LvoXs7Xzkf+xceCHTQNvVM+IyWuzk2ZJ9zVYpSykShUUYPm
         7MLVHe7lOEacI/7laXctCYhV4ouPFZ8Ahdfw9lzDnFQqnFqmkx71sLW3cKNBjSeIKwAv
         4MEfT5OhRTkBqpd++p9pbGk7cmDO4vyY8fY8zt66xee2/ABgPM8LD9NRlNGA7pR9Ruez
         WsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683575504; x=1686167504;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Xu1aA1uZ8hLMQrpQh/gprcjgcAn2F9G+veq7uQFD7c=;
        b=AhOzcJktKv92GFZQ4bMfHOf5/MRgnGNz0RPoaDQikKmM1zVXH85Kk96BO/xNRYlZ9n
         LsoFmif5WbUpwgRo5SzE9WpzQGIyBActqFJ0I0eFjf/HKJSl1Omkm6UebG04QkL/buTd
         pfx+pfAm7kelsyH/uJs26eakLqidQ3oeU1Jmjp4w6evt2A9HXD4boq2f2Iq4PzbWwKD6
         CG44C+bxrCBscCsb5fFIT1+an8sd6mBd/9yKsaa6dWHZcSwxKWr0c8WCzdeq//SbOe/J
         vVlP0371TtoVe7U5H4EIhn4vGS94srLnX0e3AjplWh3Hgq+8QGh+epOfYPpyhvuIisgm
         z2fA==
X-Gm-Message-State: AC+VfDycao+ZLaWYdXei/1lQhX0hG2xE/EqkUeuCuPf7x7S5jg2R9ZSz
        pbYbnk9rPuSQo2GCfePTBIfuIA==
X-Google-Smtp-Source: ACHHUZ4DtuaVUJulorNkZeKRM9oOArpEKwMHdF9oz8LKy1Ch9WdGDRNS57YnXfTRkYMvcGHKyB4CcA==
X-Received: by 2002:a17:906:da8d:b0:95e:d448:477 with SMTP id xh13-20020a170906da8d00b0095ed4480477mr9151154ejb.33.1683575504263;
        Mon, 08 May 2023 12:51:44 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d19b:4e0f:cfe4:a1ac? ([2a02:810d:15c0:828:d19b:4e0f:cfe4:a1ac])
        by smtp.gmail.com with ESMTPSA id bu2-20020a170906a14200b0096654fdbe34sm362422ejb.142.2023.05.08.12.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 12:51:43 -0700 (PDT)
Message-ID: <23d8ccf8-e363-a823-9252-b9c53a6a307a@linaro.org>
Date:   Mon, 8 May 2023 21:51:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/7] power: supply: max77658: Add ADI MAX77654/58/59
 Charger Support
Content-Language: en-US
To:     Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Nurettin Bolucu <Nurettin.Bolucu@analog.com>
References: <20230508131045.9399-1-Zeynep.Arslanbenzer@analog.com>
 <20230508131045.9399-4-Zeynep.Arslanbenzer@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508131045.9399-4-Zeynep.Arslanbenzer@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 15:10, Zeynep Arslanbenzer wrote:
> Charger driver for ADI MAX77654/58/59.
> 
> The MAX77654/58/59 charger is Smart Power Selector Li+/Li-Poly Charger.
> 
> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---
>  drivers/power/supply/Kconfig            |   7 +
>  drivers/power/supply/Makefile           |   1 +
>  drivers/power/supply/max77658-charger.c | 844 ++++++++++++++++++++++++
>  3 files changed, 852 insertions(+)
>  create mode 100644 drivers/power/supply/max77658-charger.c
> 


> +
> +static int max77658_charger_probe(struct platform_device *pdev)
> +{
> +	struct max77658_dev *max77658 = dev_get_drvdata(pdev->dev.parent);
> +	struct power_supply_config charger_cfg = {};
> +	struct power_supply_battery_info *info;
> +	struct max77658_charger *charger;
> +	struct device *dev = &pdev->dev;
> +	int i, n_irq, ret;
> +
> +	charger = devm_kzalloc(dev, sizeof(*charger), GFP_KERNEL);
> +	if (!charger)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, charger);
> +
> +	charger->dev = dev;
> +	charger->max77658 = max77658;
> +	charger->regmap = dev_get_regmap(charger->dev->parent, NULL);
> +
> +	charger->psy_chg_d.get_property	= max77658_charger_get_property;
> +	charger->psy_chg_d.set_property	= max77658_charger_set_property;
> +	charger->psy_chg_d.type = POWER_SUPPLY_TYPE_USB;
> +	charger_cfg.of_node = dev->of_node;

So here you have charger of_node...

> +	charger_cfg.drv_data = charger;
> +
> +	switch (max77658->id) {
> +	case ID_MAX77654:

This suggests your devices are not compatible...

> +		charger->psy_chg_d.properties = max77658_charger_props;
> +		charger->psy_chg_d.num_properties =
> +					ARRAY_SIZE(max77658_charger_props);
> +		charger->psy_chg_d.name = "max77654-charger";
> +		charger->psy_chg_d.property_is_writeable =
> +				max77658_property_is_writeable;
> +		n_irq = MAX77658_CHG_IRQ_MAX;
> +		break;
> +	case ID_MAX77658:
> +		charger->psy_chg_d.properties = max77658_charger_props;
> +		charger->psy_chg_d.num_properties =
> +					ARRAY_SIZE(max77658_charger_props);
> +		charger->psy_chg_d.name = "max77658-charger";
> +		charger->psy_chg_d.property_is_writeable =
> +				max77658_property_is_writeable;
> +		n_irq = MAX77658_CHG_IRQ_MAX;
> +		break;
> +	case ID_MAX77659:
> +		charger->psy_chg_d.properties = max77659_charger_props;
> +		charger->psy_chg_d.num_properties =
> +					ARRAY_SIZE(max77659_charger_props);
> +		charger->psy_chg_d.name = "max77659-charger";
> +		charger->psy_chg_d.property_is_writeable =
> +				max77659_property_is_writeable;
> +		n_irq = MAX77659_CHG_IRQ_MAX;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	charger->psy_chg = devm_power_supply_register(dev, &charger->psy_chg_d,
> +						      &charger_cfg);
> +	if (IS_ERR(charger->psy_chg))
> +		return dev_err_probe(dev, PTR_ERR(charger->psy_chg),
> +				     "Failed to register power supply\n");
> +
> +	charger->psy_chg->of_node = of_get_child_by_name(dev->parent->of_node,
> +							 "charger");

and here... this is confusing. Why do you get the child of a parent?
Isn't this exactly this node?


> +
> +	if (!charger->psy_chg->of_node)
> +		dev_err(charger->dev,
> +			"of_get_child_by_name\n");

??? Not helpful error message and actually not helpful case.
Can this even happen?
Maybe you should just drop platform_device_id?

> +
> +	ret = power_supply_get_battery_info(charger->psy_chg, &info);
> +	if (ret) {
> +		dev_err(charger->dev, "Unable to get charger info\n");
> +		charger->fast_charge_current_ua = 15000;
> +	} else {
> +		charger->fast_charge_current_ua =
> +			info->constant_charge_current_max_ua;
> +	}
> +
> +	if (charger->max77658->id != ID_MAX77659)
> +		max77658_charger_parse_dt(charger);
> +
> +	ret = max77658_charger_initialize(charger);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to initialize charger\n");
> +
> +	for (i = 0; i < n_irq; i++) {
> +		charger->irq_arr[i] =
> +				regmap_irq_get_virq(max77658->irqc_chg, i);
> +
> +		if (charger->irq_arr[i] < 0)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid IRQ for MAX77658_CHG_IRQ %d\n",
> +					     i);
> +
> +		ret = devm_request_threaded_irq(dev, charger->irq_arr[i],
> +						NULL, max77658_charger_isr,
> +						IRQF_TRIGGER_FALLING,
> +						max77658_irq_descs[i], charger);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +						 "Failed to request irq: %d\n",
> +						 charger->irq_arr[i]);
> +	}
> +
> +	ret = device_create_file(dev, &dev_attr_fast_charge_timer);

Where the ABI documentation?

> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to create fast charge timer sysfs entry\n");
> +
> +	ret = device_create_file(dev, &dev_attr_topoff_timer);

The same.

> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to create topoff timer sysfs entry\n");
> +
> +	return 0;
> +}
> +
> +static int max77658_charger_remove(struct platform_device *pdev)
> +{
> +	device_remove_file(&pdev->dev, &dev_attr_topoff_timer);
> +	device_remove_file(&pdev->dev, &dev_attr_fast_charge_timer);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id max77658_charger_of_id[] = {
> +	{ .compatible = "adi,max77654-charger" },
> +	{ .compatible = "adi,max77658-charger" },
> +	{ .compatible = "adi,max77659-charger" },

So they are compatible? If so, use one entry. If not, use driver data.


Best regards,
Krzysztof

