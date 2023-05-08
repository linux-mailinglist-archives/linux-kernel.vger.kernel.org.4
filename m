Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C64F6FB829
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 22:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbjEHUK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 16:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbjEHUKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 16:10:36 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073B67693
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 13:09:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bc3a2d333so7702168a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 13:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683576554; x=1686168554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tilR7eyPaDKEFXHCAqnTp+peGY1z0Ib18E1yaXftr+k=;
        b=kLvcOmZnUfc3lYK73I3j/sJ37SaQ2AvWCWDQAYKxemg4GisEiYgcTdaPc5qO5KULVT
         2FsTFnFbs37Quiah2pT9yQpLv2tIAMSwWBOEJekzchIAL/FVr+ZpMmn2iNw4j7+8pcU6
         5ghIx2WoU+AfrP+BbbbAbREhcU0gvdVc0uDFLoTktslwS3KWSZ68fHdZ8UwDmWE7+FqT
         KsKeQ35ZoMMS93/r/cWtPN492IBjzuX4hiotR3qwKcuShGY+2JlMr7pB4jSVAOsILYqO
         7DI6xxpa7ALbN87TPC72FISOIrMqqkRJC7d/Nt33Wktgzx2jrbP7VW4ED5bTxJpTpZHF
         ezvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683576554; x=1686168554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tilR7eyPaDKEFXHCAqnTp+peGY1z0Ib18E1yaXftr+k=;
        b=l9luNQy+6kGsWByuugZteAkVvKMlHeSu/Z1N1xT6sPU4ISwwbp2OiNxnpTYbkMrqRX
         +R5HX9lmxfxPZO8JGDZrF5QN7g2yQ/MDt6MPxo72nOZnJXHPzClrtH6CtWLad6DrgAKR
         YtUnSyj+dOE5oQ+7ZCRyy54+jYXq0UDsG1LhL1+4IBwTjkTN3n75EzD6bj5zoLRYLfCQ
         89sQ+V/XrOA8o9h3eiqtFmvHxbX/NYuTcBd9b6tuxVISOhiOXMrZb9ULmzkTy4FW7YnC
         jYx6kbd3Wpr9roqJWc60Yb1ep8qUcaogT3FOqJNFetf6L86aunPsyN0uoAUCPC8p5EuZ
         CnWg==
X-Gm-Message-State: AC+VfDySLjA6AVYyVmrhhFWx7+7V6D1T8aTK7gJvnwEzir3BhCpHMWxg
        yQm514A2OrMfmeh+0Q81MBi6tExY3ZoSUopJ+HY=
X-Google-Smtp-Source: ACHHUZ7qA+TErGF3BPAA0chiAVjVMmr2+vphSynvtmJf+T2ZuSJt2mJzItnXIZvlFzlNxEijNfT1vw==
X-Received: by 2002:a17:907:2d12:b0:969:98eb:3fdd with SMTP id gs18-20020a1709072d1200b0096998eb3fddmr1734857ejc.3.1683576553748;
        Mon, 08 May 2023 13:09:13 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d19b:4e0f:cfe4:a1ac? ([2a02:810d:15c0:828:d19b:4e0f:cfe4:a1ac])
        by smtp.gmail.com with ESMTPSA id jx6-20020a170907760600b00958434d4ecesm402734ejc.13.2023.05.08.13.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 13:09:13 -0700 (PDT)
Message-ID: <7636f1c7-ce54-af9f-03c8-aa124dd26561@linaro.org>
Date:   Mon, 8 May 2023 22:09:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 7/7] mfd: max77658: Add ADI MAX77643/54/58/59 MFD
 Support
Content-Language: en-US
To:     Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Nurettin Bolucu <Nurettin.Bolucu@analog.com>
References: <20230508131045.9399-1-Zeynep.Arslanbenzer@analog.com>
 <20230508131045.9399-8-Zeynep.Arslanbenzer@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508131045.9399-8-Zeynep.Arslanbenzer@analog.com>
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
> MFD driver for MAX77643/54/58/59 to enable its sub
> devices.
> 
> The MAX77643 is a multi-function devices. It includes
> regulator.
> 
> The MAX77654 is a multi-function devices. It includes
> regulator and charger.
> 
> The MAX77658 is a multi-function devices. It includes
> regulator, charger and battery.
> 
> The MAX77659 is a multi-function devices. It includes
> regulator and charger.
> 
> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---
>  drivers/mfd/Kconfig          |  13 ++
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/max77658.c       | 426 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/max77658.h |  80 +++++++
>  4 files changed, 520 insertions(+)
>  create mode 100644 drivers/mfd/max77658.c
>  create mode 100644 include/linux/mfd/max77658.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 8b93856de432..aa1630a6d33a 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -821,6 +821,19 @@ config MFD_MAX77650
>  	  the following functionalities of the device: GPIO, regulator,
>  	  charger, LED, onkey.
>  

...
			glbl1_chip, &max77658->irqc_glbl1);
> +}
> +
> +static int max77658_i2c_probe(struct i2c_client *client,
> +			      const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct max77658_dev *max77658;
> +	const struct mfd_cell *cells;
> +	struct i2c_client *fuel;
> +	int ret, n_devs;
> +
> +	max77658 = devm_kzalloc(dev, sizeof(*max77658), GFP_KERNEL);
> +	if (!max77658)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, max77658);
> +	max77658->irq = client->irq;
> +
> +	max77658->id  = (enum max77658_ids)device_get_match_data(dev);

Double space -> One space.

> +	if (!max77658->id)
> +		max77658->id  = (enum max77658_ids)id->driver_data;
> +
> +	if (!max77658->id)
> +		return -EINVAL;
> +
> +	max77658->regmap = devm_regmap_init_i2c(client,
> +						&max77658_regmap_config);
> +	if (IS_ERR(max77658->regmap))
> +		return dev_err_probe(dev, PTR_ERR(max77658->regmap),
> +				     "Failed to initialize regmap\n");
> +
> +	fuel = i2c_new_dummy_device(client->adapter, I2C_ADDR_FUEL_GAUGE);
> +	if (IS_ERR(fuel))
> +		return dev_err_probe(dev, PTR_ERR(fuel),
> +				     "Failed to create I2C device[0x%Xh]\n",
> +				      I2C_ADDR_FUEL_GAUGE);

Where do you free "fuel" instance?

> +
> +	i2c_set_clientdata(fuel, max77658);
> +
> +	max77658->regmap_fg = devm_regmap_init_i2c(fuel,
> +						   &max77658_regmap_config_fg);
> +	if (IS_ERR(max77658->regmap_fg))
> +		return dev_err_probe(dev,
> +				     PTR_ERR(max77658->regmap_fg),
> +				     "Failed to initialize I2C device[0x%Xh]\n",
> +				     I2C_ADDR_FUEL_GAUGE);
> +
> +	ret = max77658_pmic_irq_init(dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to initialize IRQ\n");
> +
> +	switch (max77658->id) {
> +	case ID_MAX77643:
> +		cells = max77643_devs;
> +		n_devs = ARRAY_SIZE(max77643_devs);
> +		break;
> +	case ID_MAX77654:
> +		cells = max77654_devs;
> +		n_devs = ARRAY_SIZE(max77654_devs);
> +		break;
> +	case ID_MAX77658:
> +		cells = max77658_devs;
> +		n_devs = ARRAY_SIZE(max77658_devs);
> +		break;
> +	case ID_MAX77659:
> +		cells = max77659_devs;
> +		n_devs = ARRAY_SIZE(max77659_devs);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = devm_mfd_add_devices(dev, -1, cells, n_devs,  NULL, 0, NULL);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add sub-devices\n");
> +
> +	return device_init_wakeup(dev, true);
> +}

Best regards,
Krzysztof

