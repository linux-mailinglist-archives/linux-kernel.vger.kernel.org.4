Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D51B613937
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiJaOpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiJaOpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:45:11 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B599CE10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:45:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id y16so16261441wrt.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pF5RczImuOCWESDRu98Gr3zxb5IwHdRJcSVe5kkSv98=;
        b=ntcERPghFw3gfO52LSX2IgHu/mDs6Cg+M3WWSY+btz3LGC98dc/T6aYHcwijNK1FjZ
         KsEESSoKsPNcw1L7ombtPlzk7zanMZptLM8Y3yRAifEm39jeaOHv12Y11/983DqNsbuW
         X/heVvH8/VI4b/9MFr70+n6KHq6PzlcVN9J5/rflCQtGkrB0QOV8AFrPrOyxyIypL2Ki
         /5sBUN5eqeklkrKRudGVWGT/GXfmZ+siKcU2aB1iB7SFZtU6omXJg0SNAPaUqk9xsEB6
         UEl3C7ihUa+Uatf81GBFqXDo9BvByJIU4ftUybSX5sCR5zImOpen8+pIkXkHPmn+twJk
         S6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pF5RczImuOCWESDRu98Gr3zxb5IwHdRJcSVe5kkSv98=;
        b=NPd/CEF0ho+/zmARga0laJkofT1YsZVSap2G1BUUJeV9FTvTF3P9pMdSL7Odq2u4KY
         dYR4pMJnwQSJ1TM+sCSiOw03/wZeqw8z9c6imvIjLWFAC3v5xT/lcepSjnh4wLEU8Zc5
         ceKVZUL2W/0znycARM9DwOWjzntas9DnYlQl1qXQWmiieltGqvgXyVeRHeqOLMkcubOH
         bdfhc3vzyTyPvftEev+lnj6DY476f5ZMBK7urZhn+gSbPGiPPXYNE4c1RCSg0FHPrl+2
         ifd0BRJbE6uBNAjcmZfBCGxxze266hfESV+zNedBXwO26NuRfcAorM93Ah+cWRTqcukg
         y+3g==
X-Gm-Message-State: ACrzQf1gdFIe3/IlJDEyMvM3KnpPGNUVKr38n3dWmob82+zkKRMZ0dep
        hM+GylnlWEA7Spl2oKUQueQ4/w==
X-Google-Smtp-Source: AMsMyM7EocFnu86nqeWlMaaF87fynfBBYVWYVN+YezTIxqaRJlHegdkoq7ofA0Ksc5y8L3jXhpGWxQ==
X-Received: by 2002:a5d:64e2:0:b0:22e:7060:b4a7 with SMTP id g2-20020a5d64e2000000b0022e7060b4a7mr8021382wri.129.1667227507963;
        Mon, 31 Oct 2022 07:45:07 -0700 (PDT)
Received: from [192.168.1.47] (242.155.4.93.rev.sfr.net. [93.4.155.242])
        by smtp.gmail.com with ESMTPSA id bq9-20020a5d5a09000000b0022ae0965a8asm7566051wrb.24.2022.10.31.07.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 07:45:07 -0700 (PDT)
Message-ID: <a2000dfa-6872-fdf5-c636-755ae5a82728@baylibre.com>
Date:   Mon, 31 Oct 2022 15:45:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v5 4/6] mfd: tps65219: Add driver for TI TPS65219 PMIC
Content-Language: en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>, "nm@ti.com" <nm@ti.com>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "tony@atomide.com" <tony@atomide.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "marcel.ziswiler@toradex.com" <marcel.ziswiler@toradex.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jeff@labundy.com" <jeff@labundy.com>
Cc:     "afd@ti.com" <afd@ti.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "msp@baylibre.com" <msp@baylibre.com>,
        "j-keerthy@ti.com" <j-keerthy@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
References: <20220914140758.7582-1-jneanne@baylibre.com>
 <20220914140758.7582-5-jneanne@baylibre.com>
 <OS0PR01MB59221A8415766E7E3615F39E86379@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <OS0PR01MB59221A8415766E7E3615F39E86379@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/10/2022 12:13, Biju Das wrote:
> Hi,
> 
>> Subject: [PATCH v5 4/6] mfd: tps65219: Add driver for TI TPS65219 PMIC
>>
>> The TPS65219 is a power management IC PMIC designed to supply a wide range
>> of SoCs in both portable and stationary applications. Any SoC can control
>> TPS65219 over a standard I2C interface.
>>
>> It contains the following components:
>> - Regulators.
>> - Over Temperature warning and Shut down.
>> - GPIOs
>> - Multi Function Pins (MFP)
>> - power-button
>>
>> This patch adds support for tps65219 PMIC. At this time only the
>> functionalities listed below are made available:
>>
>> - Regulators probe and functionalities
>> - warm and cold reset support
>> - SW shutdown support
>> - Regulator warnings via IRQs
>> - Power-button via IRQ
>>
>> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> ---
>>   MAINTAINERS                  |   1 +
>>   drivers/mfd/Kconfig          |  14 ++
>>   drivers/mfd/Makefile         |   1 +
>>   drivers/mfd/tps65219.c       | 320 ++++++++++++++++++++++++++++++++
>>   include/linux/mfd/tps65219.h | 345 +++++++++++++++++++++++++++++++++++
>>   5 files changed, 681 insertions(+)
>>   create mode 100644 drivers/mfd/tps65219.c  create mode 100644
>> include/linux/mfd/tps65219.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index f35b29ffd5fb..960df879c635 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14926,6 +14926,7 @@ F:	drivers/mfd/menelaus.c
>>   F:	drivers/mfd/palmas.c
>>   F:	drivers/mfd/tps65217.c
>>   F:	drivers/mfd/tps65218.c
>> +F:	drivers/mfd/tps65219.c
>>   F:	drivers/mfd/tps65910.c
>>   F:	drivers/mfd/twl-core.[ch]
>>   F:	drivers/mfd/twl4030*.c
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig index
>> abb58ab1a1a4..1a846c7dd0c2 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -1576,6 +1576,20 @@ config MFD_TPS65218
>>   	  This driver can also be built as a module.  If so, the module
>>   	  will be called tps65218.
>>
>> +config MFD_TPS65219
>> +	tristate "TI TPS65219 Power Management IC"
>> +	depends on I2C && OF
>> +	select MFD_CORE
>> +	select REGMAP_I2C
>> +	select REGMAP_IRQ
>> +	help
>> +	  If you say yes here you get support for the TPS65219 series of
>> Power
>> +	  Management ICs. These include voltage regulators, GPIOs and
>> +	  push/power button that are often used in portable devices.
>> +
>> +	  This driver can also be built as a module. If so, the module
>> +	  will be called tps65219.
>> +
>>   config MFD_TPS6586X
>>   	bool "TI TPS6586x Power Management chips"
>>   	depends on I2C=y
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile index
>> 858cacf659d6..a8ff3d6ea3ab 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -101,6 +101,7 @@ obj-$(CONFIG_TPS6507X)		+= tps6507x.o
>>   obj-$(CONFIG_MFD_TPS65086)	+= tps65086.o
>>   obj-$(CONFIG_MFD_TPS65217)	+= tps65217.o
>>   obj-$(CONFIG_MFD_TPS65218)	+= tps65218.o
>> +obj-$(CONFIG_MFD_TPS65219)	+= tps65219.o
>>   obj-$(CONFIG_MFD_TPS65910)	+= tps65910.o
>>   obj-$(CONFIG_MFD_TPS65912)	+= tps65912-core.o
>>   obj-$(CONFIG_MFD_TPS65912_I2C)	+= tps65912-i2c.o
>> diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c new file mode
>> 100644 index 000000000000..c1638483e069
>> --- /dev/null
>> +++ b/drivers/mfd/tps65219.c
>> @@ -0,0 +1,320 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +//
>> +// Driver for TPS65219 Integrated Power Management Integrated Chips
>> +(PMIC) // // Copyright (C) 2022 BayLibre Incorporated -
>> +
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/i2c.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reboot.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
> 
> Do you need all the includes??
>
No! you're right, I'll remove not needed.
>> +
>> +#include <linux/mfd/core.h>
>> +#include <linux/mfd/tps65219.h>
>> +
>> +static int tps65219_warm_reset(struct tps65219 *tps) {
>> +	return regmap_update_bits(tps->regmap, TPS65219_REG_MFP_CTRL,
>> +				  TPS65219_MFP_WARM_RESET_I2C_CTRL_MASK,
>> +				  TPS65219_MFP_WARM_RESET_I2C_CTRL_MASK);
>> +}
>> +
>> +static int tps65219_cold_reset(struct tps65219 *tps) {
>> +	return regmap_update_bits(tps->regmap, TPS65219_REG_MFP_CTRL,
>> +				  TPS65219_MFP_COLD_RESET_I2C_CTRL_MASK,
>> +				  TPS65219_MFP_COLD_RESET_I2C_CTRL_MASK);
>> +}
>> +
>> +static int tps65219_soft_shutdown(struct tps65219 *tps) {
>> +	return regmap_update_bits(tps->regmap, TPS65219_REG_MFP_CTRL,
>> +				  TPS65219_MFP_I2C_OFF_REQ_MASK,
>> +				  TPS65219_MFP_I2C_OFF_REQ_MASK);
>> +}
>> +
>> +static int tps65219_restart(struct notifier_block *this,
>> +			    unsigned long reboot_mode, void *cmd) {
>> +	struct tps65219 *tps;
>> +
>> +	tps = container_of(this, struct tps65219, nb);
>> +	if (!tps) {
>> +		pr_err("tps65219: Restarting failed because the pointer to
>> tps65219 is invalid\n");
> Why not dev_error?
Because I can't get correct device then: if !tps, I can't get tps->dev 
Then can't reference device in dev_error. Do you have a better 
suggestion than this pr_err?

Best regards,
Jerome.
