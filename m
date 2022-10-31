Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945E06139CE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiJaPOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJaPOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:14:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0AE11454
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:14:44 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g12so16413134wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cq37D+aG9RuZDRpw1wGP0MX3DtBta7wQtRmL2GXhPb4=;
        b=jhEY/rH4R0H5Jw0+aK8ofpuUTm3LequKrN89nkw9m8UyuCrWEncYeG/MIC/Q/BcJ5C
         cZKWafPttdd+RzhHys+cQ8ZAj3iGC66Dkv4ARaCytE7fJTKjvWXxGfzY48cJu0pstmcV
         vYvmGW2kM3V3ddY4K+BVFcwZoXyjhW8nxnr2ohaYqK2JQHDzbwpac7Fh/4DP9fgAPZoK
         iuWerTIRtLWjRoIiJCMV1xeLuWXbxb5ptIDs0apbFK56Gh3HpVh1yvsEYVyD7qfOu5K5
         p6zU1TsGQwlyeSAQvBLe/NH3p7WWW97glUweqVvCakFYISidN6j7cHLmcN1SBI+y05Sr
         qKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cq37D+aG9RuZDRpw1wGP0MX3DtBta7wQtRmL2GXhPb4=;
        b=Th1La0c4wRdME9whLpthPCCFHBmxLuRo+BOC82FZl7DP9r3ob71NCPLEz/23DAZsPy
         YMgeBYdgVZeJaJUvoV2nUiyiBxE0HrKOp2toCp+MKpgiMYsxjIrQ/CbAx2V8HgLmJEgd
         Cu5ttyf1DkDY1LLRL+yGNgsBYzQp/sFwfNaPZHK4KQuuxvSdW3C4T27NZW5wzEaKVK2p
         aSp8oiMrq4MHvM6iV+DjA+E2PBHO1rHmr5AEhCx+mVHgAyBEA/fk2k8TfyUZGR5CSq+X
         ft1aOa8TgOLFGIwbxm/xVWA1deBgkL0QIp9GTdE+OOyVnC6qZV1kzD0/mOK89juSi2TU
         6/CA==
X-Gm-Message-State: ACrzQf2akAYLmcXJwGNjvy9wTn9lBcLPY4MxD7KsIdYAGOcqU4eWU5n5
        B2az6igSdM6DCLxcDSJGIzKI4Q==
X-Google-Smtp-Source: AMsMyM4sXtzCevkx80TqZWjZyuYqrrzcc02J3pYnVDrKqdj1012o/P1qJje9tqqi88CEhob6+59a8g==
X-Received: by 2002:a05:6000:54e:b0:236:5818:d432 with SMTP id b14-20020a056000054e00b002365818d432mr8582721wrf.37.1667229282996;
        Mon, 31 Oct 2022 08:14:42 -0700 (PDT)
Received: from [192.168.1.47] (242.155.4.93.rev.sfr.net. [93.4.155.242])
        by smtp.gmail.com with ESMTPSA id t16-20020adff610000000b0023538fb27c1sm7398137wrp.85.2022.10.31.08.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 08:14:42 -0700 (PDT)
Message-ID: <b251290f-d490-97f2-5642-9f801f6c68af@baylibre.com>
Date:   Mon, 31 Oct 2022 16:14:38 +0100
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
 <a2000dfa-6872-fdf5-c636-755ae5a82728@baylibre.com>
 <OS0PR01MB59225CD0FF691E169F25F56886379@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <OS0PR01MB59225CD0FF691E169F25F56886379@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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



On 31/10/2022 15:48, Biju Das wrote:
>> Subject: Re: [PATCH v5 4/6] mfd: tps65219: Add driver for TI TPS65219
>> PMIC
>>
>>
>>
>> On 31/10/2022 12:13, Biju Das wrote:
>>> Hi,
>>>
>>>> Subject: [PATCH v5 4/6] mfd: tps65219: Add driver for TI TPS65219
>>>> PMIC
>>>>
>>>> The TPS65219 is a power management IC PMIC designed to supply a
>> wide
>>>> range of SoCs in both portable and stationary applications. Any SoC
>>>> can control
>>>> TPS65219 over a standard I2C interface.
>>>>
>>>> It contains the following components:
>>>> - Regulators.
>>>> - Over Temperature warning and Shut down.
>>>> - GPIOs
>>>> - Multi Function Pins (MFP)
>>>> - power-button
>>>>
>>>> This patch adds support for tps65219 PMIC. At this time only the
>>>> functionalities listed below are made available:
>>>>
>>>> - Regulators probe and functionalities
>>>> - warm and cold reset support
>>>> - SW shutdown support
>>>> - Regulator warnings via IRQs
>>>> - Power-button via IRQ
>>>>
>>>> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
>>>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>>>> ---
>>>>    MAINTAINERS                  |   1 +
>>>>    drivers/mfd/Kconfig          |  14 ++
>>>>    drivers/mfd/Makefile         |   1 +
>>>>    drivers/mfd/tps65219.c       | 320
>> ++++++++++++++++++++++++++++++++
>>>>    include/linux/mfd/tps65219.h | 345
>> +++++++++++++++++++++++++++++++++++
>>>>    5 files changed, 681 insertions(+)
>>>>    create mode 100644 drivers/mfd/tps65219.c  create mode 100644
>>>> include/linux/mfd/tps65219.h
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS index
>>>> f35b29ffd5fb..960df879c635 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -14926,6 +14926,7 @@ F:	drivers/mfd/menelaus.c
>>>>    F:	drivers/mfd/palmas.c
>>>>    F:	drivers/mfd/tps65217.c
>>>>    F:	drivers/mfd/tps65218.c
>>>> +F:	drivers/mfd/tps65219.c
>>>>    F:	drivers/mfd/tps65910.c
>>>>    F:	drivers/mfd/twl-core.[ch]
>>>>    F:	drivers/mfd/twl4030*.c
>>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig index
>>>> abb58ab1a1a4..1a846c7dd0c2 100644
>>>> --- a/drivers/mfd/Kconfig
>>>> +++ b/drivers/mfd/Kconfig
>>>> @@ -1576,6 +1576,20 @@ config MFD_TPS65218
>>>>    	  This driver can also be built as a module.  If so, the module
>>>>    	  will be called tps65218.
>>>>
>>>> +config MFD_TPS65219
>>>> +	tristate "TI TPS65219 Power Management IC"
>>>> +	depends on I2C && OF
>>>> +	select MFD_CORE
>>>> +	select REGMAP_I2C
>>>> +	select REGMAP_IRQ
>>>> +	help
>>>> +	  If you say yes here you get support for the TPS65219 series of
>>>> Power
>>>> +	  Management ICs. These include voltage regulators, GPIOs and
>>>> +	  push/power button that are often used in portable devices.
>>>> +
>>>> +	  This driver can also be built as a module. If so, the module
>>>> +	  will be called tps65219.
>>>> +
>>>>    config MFD_TPS6586X
>>>>    	bool "TI TPS6586x Power Management chips"
>>>>    	depends on I2C=y
>>>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile index
>>>> 858cacf659d6..a8ff3d6ea3ab 100644
>>>> --- a/drivers/mfd/Makefile
>>>> +++ b/drivers/mfd/Makefile
>>>> @@ -101,6 +101,7 @@ obj-$(CONFIG_TPS6507X)		+= tps6507x.o
>>>>    obj-$(CONFIG_MFD_TPS65086)	+= tps65086.o
>>>>    obj-$(CONFIG_MFD_TPS65217)	+= tps65217.o
>>>>    obj-$(CONFIG_MFD_TPS65218)	+= tps65218.o
>>>> +obj-$(CONFIG_MFD_TPS65219)	+= tps65219.o
>>>>    obj-$(CONFIG_MFD_TPS65910)	+= tps65910.o
>>>>    obj-$(CONFIG_MFD_TPS65912)	+= tps65912-core.o
>>>>    obj-$(CONFIG_MFD_TPS65912_I2C)	+= tps65912-i2c.o
>>>> diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c new
>> file
>>>> mode
>>>> 100644 index 000000000000..c1638483e069
>>>> --- /dev/null
>>>> +++ b/drivers/mfd/tps65219.c
>>>> @@ -0,0 +1,320 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +//
>>>> +// Driver for TPS65219 Integrated Power Management Integrated
>> Chips
>>>> +(PMIC) // // Copyright (C) 2022 BayLibre Incorporated -
>>>> +
>>>> +
>>>> +static int tps65219_restart(struct notifier_block *this,
>>>> +			    unsigned long reboot_mode, void *cmd) {
>>>> +	struct tps65219 *tps;
>>>> +
>>>> +	tps = container_of(this, struct tps65219, nb);
>>>> +	if (!tps) {
>>>> +		pr_err("tps65219: Restarting failed because the pointer to
>>>> tps65219 is invalid\n");
>>> Why not dev_error?
>> Because I can't get correct device then: if !tps, I can't get tps->dev
>> Then can't reference device in dev_error. Do you have a better
>> suggestion than this pr_err?
> 
> How container_of can fail?
>
Good point. This check sounds useless. I'll just remove then...

Thanks for highlighting this.

Jerome.
