Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E21696324
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjBNMKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjBNMKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:10:06 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EF91042A;
        Tue, 14 Feb 2023 04:10:04 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id r28so12818814oiw.3;
        Tue, 14 Feb 2023 04:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zUuZKXab9i7az47moFU039MmUADJp6ucdRHmu481T/c=;
        b=fYqv9FY6EKKRQCgvj0E1n9iIpcXWx1txpnWUa7mflMtx7UUVkhqUGRg7QrYoj4rh+0
         Xn40m2BqQtNsAim00kbuWr/EQWsxXejyZL46qfIwZsKcA0zA1uJRuqT9z3jyzP7qQyby
         959gpbr8nPt022fwTFwZRo+NpTV6fPi7bLwkZO2lTpAAI1ofcMcNiF1kR2hj9DXntSL9
         I9GRQDBoXsNJr+KYItsJgyOb5SaVa/rOG1kqlYx3gAXZRAhHVPx69AlU4Z6I0IP15yiM
         zNWNqfYUbyJuKS2B0MQqLKaVjcqsgVbvG75kAVdYMEEDCFCr3aisRAiu9KOWyV8reMta
         9j1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUuZKXab9i7az47moFU039MmUADJp6ucdRHmu481T/c=;
        b=2Pxs0tNFerdojj0vE6pN3W9M6kodNP7YU/FP2ye4S/V0u+qEDlxLlQl58fS8zvVTex
         oOt1r1tN6oBploq5D2eGY2eOpHepEMPfJamjimtV5jfIQOVwx1iCSBKuG2rwBJSZ287d
         4yE3EwEnpBGWi2+iZvSQJnl6Xkmom383gApSP0cDBnzNxtKzxgj5wT7hzl9lHWNbuBJR
         knhC1nD6AFwhp10/8VO+OyWKv17L3HN0STHTG0pKzeAlEjqm5u+xu+Yv/6ychzcv6Gob
         291HIjo5oNTgq6JBJ6VX3qYvGZ1IVjIpkPdLxRJpB6jxRKsE04WG5YWATAUvI+br/DGm
         sZJg==
X-Gm-Message-State: AO0yUKXc3R10lLVa09SCxMRI7snmnZ+2vVR0u81mfo3k7VV7YdAleg0O
        YcpS2z19/FBAOGJscCCEkMU=
X-Google-Smtp-Source: AK7set/82YvbvMs+kiwWvgpInCYzqt5Tp3wjqF7Nutt6jNFclwSOu3xYUiwgHI3jzW2XYAE+Dlnn8g==
X-Received: by 2002:aca:2216:0:b0:378:516b:cc57 with SMTP id b22-20020aca2216000000b00378516bcc57mr1020444oic.25.1676376603374;
        Tue, 14 Feb 2023 04:10:03 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w6-20020acadf06000000b0037b80fe0539sm6071489oig.42.2023.02.14.04.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 04:10:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <aa68fc8c-cfa1-902d-b95e-4fcbd3154f93@roeck-us.net>
Date:   Tue, 14 Feb 2023 04:10:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 3/3] watchdog: mt7621-wdt: avoid ralink architecture
 dependent code
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <f105c7a8-8821-1e7b-af46-13a46971db63@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 00:31, Krzysztof Kozlowski wrote:
> On 13/02/2023 21:05, Sergio Paracuellos wrote:
>> MT7621 SoC has a system controller node. Watchdog need to access to reset
>> status register. Ralink architecture and related driver are old and from
>> the beggining they are using some architecture dependent operations for
>> accessing this shared registers through 'asm/mach-ralink/ralink_regs.h'
>> header file. However this is not ideal from a driver perspective which can
>> just access to the system controller registers in an arch independent way
>> using regmap syscon APIs. Update Kconfig accordingly to select new added
>> dependencies and allow driver to be compile tested.
>>
>> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>> ---
>>   drivers/watchdog/Kconfig      |  4 +++-
>>   drivers/watchdog/mt7621_wdt.c | 18 +++++++++++++-----
>>   2 files changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index b64bc49c7..cf752ad64 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -1865,7 +1865,9 @@ config GXP_WATCHDOG
>>   config MT7621_WDT
>>   	tristate "Mediatek SoC watchdog"
>>   	select WATCHDOG_CORE
>> -	depends on SOC_MT7620 || SOC_MT7621
>> +	select REGMAP_MMIO
>> +	select MFD_SYSCON
>> +	depends on SOC_MT7620 || SOC_MT7621 || COMPILE_TEST
>>   	help
>>   	  Hardware driver for the Mediatek/Ralink MT7621/8 SoC Watchdog Timer.
>>   
>> diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
>> index 40fb2c9ba..22e979bdd 100644
>> --- a/drivers/watchdog/mt7621_wdt.c
>> +++ b/drivers/watchdog/mt7621_wdt.c
>> @@ -15,8 +15,8 @@
>>   #include <linux/moduleparam.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/mod_devicetable.h>
>> -
>> -#include <asm/mach-ralink/ralink_regs.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/regmap.h>
>>   
>>   #define SYSC_RSTSTAT			0x38
>>   #define WDT_RST_CAUSE			BIT(1)
>> @@ -34,6 +34,7 @@
>>   struct mt7621_wdt_data {
>>   	void __iomem *base;
>>   	struct reset_control *rst;
>> +	struct regmap *sysc;
>>   	struct watchdog_device wdt;
>>   };
>>   
>> @@ -104,9 +105,12 @@ static int mt7621_wdt_stop(struct watchdog_device *w)
>>   	return 0;
>>   }
>>   
>> -static int mt7621_wdt_bootcause(void)
>> +static int mt7621_wdt_bootcause(struct mt7621_wdt_data *d)
>>   {
>> -	if (rt_sysc_r32(SYSC_RSTSTAT) & WDT_RST_CAUSE)
>> +	u32 val;
>> +
>> +	regmap_read(d->sysc, SYSC_RSTSTAT, &val);
>> +	if (val & WDT_RST_CAUSE)
>>   		return WDIOF_CARDRESET;
>>   
>>   	return 0;
>> @@ -143,6 +147,10 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
>>   	if (!drvdata)
>>   		return -ENOMEM;
>>   
>> +	drvdata->sysc = syscon_regmap_lookup_by_compatible("mediatek,mt7621-sysc");
>> +	if (IS_ERR(drvdata->sysc))
>> +		return PTR_ERR(drvdata->sysc);
> 
> This should be the backup/error path for original code using syscon
> property. Looking up by compatible is really not portable/re-usable.
> 

I really disagree here.

$ git grep syscon_regmap_lookup_by_compatible | wc
      90     326    8940

I have not yet reviewed this code, but I do not accept this argument against it.

Guenter

