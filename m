Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A37696348
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjBNMPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjBNMP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:15:29 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7110525E2C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:15:22 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m10so6510594wrn.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XynBIpbl3JG8PWWiA0X907xN8l+OwX57UjhDBl6wuU4=;
        b=v6TVe2D2FnNPE55AQlAq+Rfa3zBIVzT6NwrSkDHQkzlULtXVHz3Tz5sKFQL+mzuFIM
         EAy4mWXPsWoUGpMEGnWMvFhPQLonZojZOsxQ0dv8AtBqoEzdWWC8aBpclZESNHt5lCoS
         QwPZvyMnyvcyIjVWTHfUgONFyYcIJxpHSW5ESOV8nFmT7n2Zv6+mBCJvJ0i2O0p3ppx9
         8cWMSr/skTTAPEJXHp/7VJsMwWTfLxZLeKyrEKNd2q9EXptLqbQYHnAlWnD7owARkYu1
         gGOov8BONCQZaprtSrLp+HaisSUSwu1Sg89bIs9m6ZEwot4jI1YPG8b+yZ1Q64Kf048L
         jBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XynBIpbl3JG8PWWiA0X907xN8l+OwX57UjhDBl6wuU4=;
        b=Q1oNePJyyknYYNn8B4AiF5OS/RyOzoe/zocP7/c8+XwTpiEkRum1HLLHvGAabXzdfL
         bZ/CudLjRLjGn/KqiroV0MM24t5lIc0tYG9GpECY+J0+jSu9uG0QkGQlcTD3BnReHTZA
         lxofmvlUuPqnpFGHV7IdWxCFk4rNlv6iwd3aOkh9iG2ZROrCjE/R502L1GP4hn3lSVlu
         G/U9QRCXcnRgiKjl5yDjOwXTuKxkMeZnAYPskwfUat1RgZ9/xs7+VUCAGwPGvDt06BX1
         hMwwQmyXCK/r9/+S+bqBTXY17nf5L/FJZn5jNKvjqOyPUwSWMQ+Ooi2W/1wEILGG+ekT
         1aHw==
X-Gm-Message-State: AO0yUKUXj2dQa7PMVO2h/fU87KnJRajzpYls7an3Ko0P9m3j4GX1HOEz
        GsvWGmLUdbI6FuR8IClU+xODRw==
X-Google-Smtp-Source: AK7set8BgeAKsir3I5cSXdcn11Pd8ODYYy+8qbrbhe2HBhbsQmfjz0pI+IWz17m36jJcpXBRK+OQsw==
X-Received: by 2002:adf:f8d1:0:b0:2c5:4c9d:2dab with SMTP id f17-20020adff8d1000000b002c54c9d2dabmr1644618wrq.10.1676376921017;
        Tue, 14 Feb 2023 04:15:21 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q4-20020a05600000c400b002c54737e908sm11130188wrx.91.2023.02.14.04.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 04:15:20 -0800 (PST)
Message-ID: <c23f78fe-8ea4-1a5c-c36e-fd981a2c381d@linaro.org>
Date:   Tue, 14 Feb 2023 13:15:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 3/3] watchdog: mt7621-wdt: avoid ralink architecture
 dependent code
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
References: <20230213200519.889503-1-sergio.paracuellos@gmail.com>
 <20230213200519.889503-4-sergio.paracuellos@gmail.com>
 <f105c7a8-8821-1e7b-af46-13a46971db63@linaro.org>
 <aa68fc8c-cfa1-902d-b95e-4fcbd3154f93@roeck-us.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <aa68fc8c-cfa1-902d-b95e-4fcbd3154f93@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 13:10, Guenter Roeck wrote:
> On 2/14/23 00:31, Krzysztof Kozlowski wrote:
>> On 13/02/2023 21:05, Sergio Paracuellos wrote:
>>> MT7621 SoC has a system controller node. Watchdog need to access to reset
>>> status register. Ralink architecture and related driver are old and from
>>> the beggining they are using some architecture dependent operations for
>>> accessing this shared registers through 'asm/mach-ralink/ralink_regs.h'
>>> header file. However this is not ideal from a driver perspective which can
>>> just access to the system controller registers in an arch independent way
>>> using regmap syscon APIs. Update Kconfig accordingly to select new added
>>> dependencies and allow driver to be compile tested.
>>>
>>> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>>> ---
>>>   drivers/watchdog/Kconfig      |  4 +++-
>>>   drivers/watchdog/mt7621_wdt.c | 18 +++++++++++++-----
>>>   2 files changed, 16 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>> index b64bc49c7..cf752ad64 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -1865,7 +1865,9 @@ config GXP_WATCHDOG
>>>   config MT7621_WDT
>>>   	tristate "Mediatek SoC watchdog"
>>>   	select WATCHDOG_CORE
>>> -	depends on SOC_MT7620 || SOC_MT7621
>>> +	select REGMAP_MMIO
>>> +	select MFD_SYSCON
>>> +	depends on SOC_MT7620 || SOC_MT7621 || COMPILE_TEST
>>>   	help
>>>   	  Hardware driver for the Mediatek/Ralink MT7621/8 SoC Watchdog Timer.
>>>   
>>> diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
>>> index 40fb2c9ba..22e979bdd 100644
>>> --- a/drivers/watchdog/mt7621_wdt.c
>>> +++ b/drivers/watchdog/mt7621_wdt.c
>>> @@ -15,8 +15,8 @@
>>>   #include <linux/moduleparam.h>
>>>   #include <linux/platform_device.h>
>>>   #include <linux/mod_devicetable.h>
>>> -
>>> -#include <asm/mach-ralink/ralink_regs.h>
>>> +#include <linux/mfd/syscon.h>
>>> +#include <linux/regmap.h>
>>>   
>>>   #define SYSC_RSTSTAT			0x38
>>>   #define WDT_RST_CAUSE			BIT(1)
>>> @@ -34,6 +34,7 @@
>>>   struct mt7621_wdt_data {
>>>   	void __iomem *base;
>>>   	struct reset_control *rst;
>>> +	struct regmap *sysc;
>>>   	struct watchdog_device wdt;
>>>   };
>>>   
>>> @@ -104,9 +105,12 @@ static int mt7621_wdt_stop(struct watchdog_device *w)
>>>   	return 0;
>>>   }
>>>   
>>> -static int mt7621_wdt_bootcause(void)
>>> +static int mt7621_wdt_bootcause(struct mt7621_wdt_data *d)
>>>   {
>>> -	if (rt_sysc_r32(SYSC_RSTSTAT) & WDT_RST_CAUSE)
>>> +	u32 val;
>>> +
>>> +	regmap_read(d->sysc, SYSC_RSTSTAT, &val);
>>> +	if (val & WDT_RST_CAUSE)
>>>   		return WDIOF_CARDRESET;
>>>   
>>>   	return 0;
>>> @@ -143,6 +147,10 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
>>>   	if (!drvdata)
>>>   		return -ENOMEM;
>>>   
>>> +	drvdata->sysc = syscon_regmap_lookup_by_compatible("mediatek,mt7621-sysc");
>>> +	if (IS_ERR(drvdata->sysc))
>>> +		return PTR_ERR(drvdata->sysc);
>>
>> This should be the backup/error path for original code using syscon
>> property. Looking up by compatible is really not portable/re-usable.
>>
> 
> I really disagree here.
> 
> $ git grep syscon_regmap_lookup_by_compatible | wc
>       90     326    8940
> 
> I have not yet reviewed this code, but I do not accept this argument against it.

First, argument that bad pattern is being used is not an argument to
keep it and repeat it.

Second, we already had examples that:
1. Author used syscon_regmap_lookup_by_compatible() and assumed "we will
never add new variant/soc".
2. Then turns out that new variants are obviously added and
syscon_regmap_lookup_by_compatible() stops scaling.

Whether any new variant/compatible/platform can appear for this watchdog
- I don't know.

Third, with syscon_regmap_lookup_by_compatible() you have undocumented
(not in the binding) dependency between blocks which:
a. stops any reusability,
b. affects device links and probe ordering (simply - there is no, device
must defer probe),
c. is simply undocumented.

The usage of syscon_regmap_lookup_by_compatible() has clear drawbacks
thus new code should rather use syscon phandles which solve all of above.

Best regards,
Krzysztof

