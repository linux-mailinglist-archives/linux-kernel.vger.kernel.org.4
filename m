Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C8A6FB7D9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 21:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjEHT5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 15:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbjEHT5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 15:57:39 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FEF49D6
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 12:57:31 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9661a1ff1e9so383703466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 12:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683575849; x=1686167849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqNm4Pg9q9JTG5RmbcPMzT/Gazj/RL9lVE9lFqNGM3U=;
        b=T6Uhg1KtnlUklTu35/psIniaI61w47RSVLU2iwxcKhG0mynpdvAwlOAAeXMde7wMRk
         eFKPjHl8cZiiNeaKnVrP1RA0i4SfwXEwf3b9HxXmkaZQwvYQ8pVYvvMnoQeUd2ND6+ks
         mY/4pbH4YmXkbh6GcOBgw4HjO8vkMb2yi0Me0GJ56Hrg3hs0g8Cvk5Veuv46NJ4FuOBS
         6WwVczqguUaFa0qJQfFfhScq4a2Ogal5COXlqE08qMY7GJNF+dE3kuHeJ52yK9xGqhEg
         ogvlAXTMNq3ZL+Z+U8O1+uJOpsuXtL2QxCcr7P7JZ1/Bz37fobBhff7BCPH35kheU4ye
         ChBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683575849; x=1686167849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fqNm4Pg9q9JTG5RmbcPMzT/Gazj/RL9lVE9lFqNGM3U=;
        b=Vp1cwyj6aZf3TGjBIDbrm8lktyU1Jng7Aob55zMSwtwPMb6XFOd+SpfF2WYG3QbHZh
         tHXlOI+YiL2FjSF//cwvvjgzjXmiPlTYYRufWlkntogf0yixs1XOuwqAcEjQcZGZk5tp
         gjaMSVVW71tk8pPCxmKTx9k05RoQPZY1g0rWxelGJ4AXV0JlnOH+xPh6xRgNMx7/uhbM
         H5j+dpoKqyvFo/IuHpHbU9mG215PXtsYXo050hLan7iDS0p88pvy5naZhJKGlFYsVzk2
         oyxw8cxC9md6ewp9twGf6vHMXrZ2PHcSuE+RC91IvNbqbSugyoNX/6cAG5ostVAxX0Fo
         hJig==
X-Gm-Message-State: AC+VfDzOgOofayUTewhmvxkQaVHFHDJ4raa0ceD/i3DZ1VSNgNp1poLQ
        I6lWgHqM0dD1SRvJt2vnz7yrHQ==
X-Google-Smtp-Source: ACHHUZ4hoGGr9y5oAQC/lbiqhDVCDTnjY7U6xLJ6pwta2U48lXqaMQ/4DfaYmZv1q/RCCgW4o0eXAA==
X-Received: by 2002:a17:907:25c3:b0:933:868:413a with SMTP id ae3-20020a17090725c300b009330868413amr9144234ejc.15.1683575849436;
        Mon, 08 May 2023 12:57:29 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d19b:4e0f:cfe4:a1ac? ([2a02:810d:15c0:828:d19b:4e0f:cfe4:a1ac])
        by smtp.gmail.com with ESMTPSA id jl21-20020a17090775d500b00965b5540ad7sm386558ejc.17.2023.05.08.12.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 12:57:28 -0700 (PDT)
Message-ID: <04e8e974-c09b-bfcd-85f7-07f9f3fc868c@linaro.org>
Date:   Mon, 8 May 2023 21:57:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 5/7] power: supply: max77658: Add ADI MAX77658 Battery
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
 <20230508131045.9399-6-Zeynep.Arslanbenzer@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508131045.9399-6-Zeynep.Arslanbenzer@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 15:10, Zeynep Arslanbenzer wrote:
> Battery driver for ADI MAX77658.
> 
> The MAX77658 is an ultra-low power fuel gauge which implements the Maxim ModelGauge m5 EZ algorithm.
> 
> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---
>  drivers/power/supply/Kconfig            |   7 +
>  drivers/power/supply/Makefile           |   1 +
>  drivers/power/supply/max77658-battery.c | 633 ++++++++++++++++++++++++
>  3 files changed, 641 insertions(+)
>  create mode 100644 drivers/power/supply/max77658-battery.c
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 4b68bbb1e2a8..f9556f4b9e35 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -572,6 +572,13 @@ config CHARGER_MAX77658
>  	  Say Y to enable support for the battery charger control of
>  	  MAX77654/58/59 PMIC.
>  
> +config BATTERY_MAX77658
> +	tristate "Analog Devices MAX77658 battery driver"
> +	depends on MFD_MAX77658
> +	help
> +	  Say Y to enable support for the battery control of
> +	  MAX77658 PMIC.
> +
>  config CHARGER_MAX77693
>  	tristate "Maxim MAX77693 battery charger driver"
>  	depends on MFD_MAX77693
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index af4bd6e5969f..e5a425d333a7 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -77,6 +77,7 @@ obj-$(CONFIG_CHARGER_MAX14577)	+= max14577_charger.o
>  obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+= max14656_charger_detector.o
>  obj-$(CONFIG_CHARGER_MAX77650)	+= max77650-charger.o
>  obj-$(CONFIG_CHARGER_MAX77658)	+= max77658-charger.o
> +obj-$(CONFIG_BATTERY_MAX77658)	+= max77658-battery.o
>  obj-$(CONFIG_CHARGER_MAX77693)	+= max77693_charger.o
>  obj-$(CONFIG_CHARGER_MAX77976)	+= max77976_charger.o
>  obj-$(CONFIG_CHARGER_MAX8997)	+= max8997_charger.o
> diff --git a/drivers/power/supply/max77658-battery.c b/drivers/power/supply/max77658-battery.c
> new file mode 100644
> index 000000000000..4948ef227db1
> --- /dev/null
> +++ b/drivers/power/supply/max77658-battery.c
> @@ -0,0 +1,633 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 Analog Devices, Inc.
> + * ADI battery driver for the MAX77658
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/max77658.h>
> +#include <linux/module.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +
> +/* Default value for SALRT min threshold, in percent */
> +#define MAX77658_SALRT_MIN_DEFAULT	1
> +/* Default value for SALRT max threshold, in percent */
> +#define MAX77658_SALRT_MAX_DEFAULT	99
> +
> +#define MAX77658_IALRTTH_RESOLUTION	8567
> +#define MAX77658_CURRENT_RESOLUTION	33487
> +#define MAX77658_VOLTAGE_RESOLUTION	78125
> +#define MAX77658_FG_DELAY		1000
> +#define MAX77658_BATTERY_FULL		100
> +#define MAX77658_BATTERY_LOW		40
> +#define MAX77658_BATTERY_CRITICAL	10
> +#define MAX77658_MAXMINVOLT_STEP	20000
> +#define MAX77658_VALRTTH_STEP		20000
> +#define MAX77658_VEMPTY_VE_STEP		10000
> +#define MAX77658_POWER_STEP		17100
> +
> +#define MAX77658_REG_STATUS		0x00
> +#define MAX77658_REG_VALRTTH		0x01
> +#define MAX77658_REG_TALRTTH		0x02
> +#define MAX77658_REG_SALRTTH		0x03
> +#define MAX77658_REG_CONFIG		0x1D
> +#define MAX77658_REG_DEVNAME		0x21
> +#define MAX77658_REG_VEMPTY		0x3A
> +#define MAX77658_REG_AVGPOWER		0xB3
> +#define MAX77658_REG_IALRTTH		0xB4
> +#define MAX77658_REG_CONFIG2		0xBB
> +#define MAX77658_REG_TEMP		0x08
> +#define MAX77658_REG_VCELL		0x09
> +#define MAX77658_REG_CURRENT		0x0A
> +#define MAX77658_REG_AVGCURRENT		0x0B
> +#define MAX77658_REG_AVGVCELL		0x19
> +#define MAX77658_REG_MAXMINTEMP		0x1A
> +#define MAX77658_REG_MAXMINVOLT		0x1B
> +#define MAX77658_REG_MAXMINCURR		0x1C
> +#define MAX77658_REG_REPSOC		0x06
> +#define MAX77658_REG_TTE		0x11
> +#define MAX77658_REG_TTF		0x20
> +
> +#define MAX77658_BIT_STATUS_BR		BIT(15)
> +#define MAX77658_BIT_STATUS_SMX		BIT(14)
> +#define MAX77658_BIT_STATUS_TMX		BIT(13)
> +#define MAX77658_BIT_STATUS_VMX		BIT(12)
> +#define MAX77658_BIT_STATUS_BI		BIT(11)
> +#define MAX77658_BIT_STATUS_SMN		BIT(10)
> +#define MAX77658_BIT_STATUS_TMN		BIT(9)
> +#define MAX77658_BIT_STATUS_VMN		BIT(8)
> +#define MAX77658_BIT_STATUS_POR		BIT(2)
> +#define	MAX77658_BIT_CONFIG_AEN		BIT(2)

Odd indentation

(...)

> +}
> +
> +static void max77658_fg_parse_dt(struct max77658_fg *max77658_fg)
> +{
> +	struct device *dev = max77658_fg->dev;
> +	int ret;
> +
> +	ret = device_property_read_u32(dev, "adi,valrt-min-microvolt",
> +				       &max77658_fg->volt_min_uv);
> +	if (ret) {
> +		dev_dbg(dev,
> +			"Could not read adi,valrt-min-microvolt DT property\n");
> +		max77658_fg->volt_min_uv = 0;

So you have defaults? DT binding is missing them

> +	}
> +
> +	ret = device_property_read_u32(dev, "adi,valrt-max-microvolt",
> +				       &max77658_fg->volt_max_uv);
> +	if (ret) {
> +		dev_dbg(dev,
> +			"Could not read adi,valrt-max-microvolt DT property\n");
> +		max77658_fg->volt_max_uv = 5100000;

Ditto

> +	}
> +
> +	ret = device_property_read_u32(dev, "adi,ialrt-min-microamp",
> +				       &max77658_fg->curr_min_ma);
> +	if (ret) {
> +		dev_dbg(dev,
> +			"Could not read adi,ialrt-min-microamp DT property\n");
> +		max77658_fg->curr_min_ma = MAX77658_IALRTTH_RESOLUTION * (-128);

Ditto

> +	}
> +
> +	ret = device_property_read_u32(dev, "adi,ialrt-max-microamp",
> +				       &max77658_fg->curr_max_ma);
> +	if (ret) {
> +		dev_dbg(dev,
> +			"Could not read adi,ialrt-max-microamp DT property\n");
> +		max77658_fg->curr_max_ma = MAX77658_IALRTTH_RESOLUTION * 127;

Ditto


> +	}
> +}
> +
> +static int max77658_fg_probe(struct platform_device *pdev)
> +{
> +	struct max77658_dev *max77658 = dev_get_drvdata(pdev->dev.parent);
> +	struct power_supply_battery_info *info;
> +	struct power_supply_config fg_cfg = {};
> +	struct device *dev = &pdev->dev;
> +	struct max77658_fg *fg;
> +	int ret = 0;
> +
> +	fg = devm_kzalloc(&pdev->dev, sizeof(*fg), GFP_KERNEL);
> +	if (!fg)
> +		return -ENOMEM;
> +
> +	fg->dev = &pdev->dev;
> +	fg->regmap = max77658->regmap_fg;
> +
> +	fg->psy_batt_d.name = "max77658-battery";
> +	fg->psy_batt_d.type = POWER_SUPPLY_TYPE_BATTERY;
> +	fg->psy_batt_d.get_property = max77658_fg_get_property;
> +	fg->psy_batt_d.set_property = max77658_fg_set_property;
> +	fg->psy_batt_d.properties = max77658_fg_battery_props;
> +	fg->psy_batt_d.property_is_writeable = max77658_property_is_writeable;
> +	fg->psy_batt_d.num_properties = ARRAY_SIZE(max77658_fg_battery_props);
> +	fg_cfg.drv_data = fg;
> +
> +	INIT_DELAYED_WORK(&fg->work, max77658_fg_work);
> +	ret = devm_add_action(&pdev->dev, max77658_stop_work, fg);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Error in setting delayed work\n");
> +
> +	fg->battery = devm_power_supply_register(dev, &fg->psy_batt_d,
> +						 &fg_cfg);
> +	if (IS_ERR(fg->battery))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(fg->battery),
> +				     "Failed to register battery\n");
> +
> +	fg->battery->of_node = of_get_child_by_name(dev->parent->of_node,
> +						    "fuel-gauge");
> +
> +	if (!fg->battery->of_node)
> +		dev_err(dev,
> +			"of_get_child_by_name\n");

Same problems a previous patch...

Best regards,
Krzysztof

