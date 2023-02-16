Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28E1698E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjBPIU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBPIUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:20:25 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADCE27D55
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:20:19 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a3so3303047ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g9hfU2Fl5/j4A3QnaJpUGjRq1/KXRcgp861nKkf/nNw=;
        b=FZJzzH1JQE4zZJfEpbXHoNj8o9hV8HehrRzPhVUsyc3lBjhsoqWpAR2BAYj0Qccw3t
         wpxXp14Qr5EE9xu9CWMbcAKLn1ckqsqYWNFvISMIXlwAnkbdxKSD0V4EaJMxPHdPYOP3
         Q/RHiTlf+SrFj4Soo+wqFuVT9KJt3QYpwkIG8ZWYuBCOwY2UtoVEl7Fylwfl/KLi4Oq6
         88g2MuMD7QDRoPkMP3tlSKuOUy/EnyEReWCDPfx42GyAnsnxyAJM8nErZA2sL/QQ4/U7
         0uoWCY/K//o8ozFnCllcXwUd4UjSE0PTGZuahmsa9kjNiMl3Vb/fSfuYdWn1K80UKJ+X
         Zr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g9hfU2Fl5/j4A3QnaJpUGjRq1/KXRcgp861nKkf/nNw=;
        b=Wl9FvCz3uXY9zAvUr+stg56r4tQlLdrOwv3vEAQCQJGYmdLmTW3QoKvG0UPT7NWHgr
         1Ww6LWapRx0NRfjxZKi8HRBAuM4ZTswQBDbmW+6CglFryb8rCBVsCNLNzmkzbVXvo1SR
         IadR7v7YBwSSTe3TSxY+/FZNLTrSg3nyx3nYsLBrT8pd4QaHrJXgBb5w7IET/Nd5ZR9y
         QnIXvDOcnPaxuCDg60lrQQfMo9xLenO6qQolWVfBHmp8g33OcYz7+l11zGhApdZ9oWkz
         zdAFxBC2QTITZbWEr7eYusoyTPl7K1PaR/I0Zd50NDdoV1fn6PTXVW0X+/LZh8OpQ0H3
         SGEA==
X-Gm-Message-State: AO0yUKWtrvN9ULo8kFkYARLfJIFFvr39aub2Q55Jd/5d+5GKjL3BMWwc
        Z1wz7C+NodiXcutuo2lW25V9gQ==
X-Google-Smtp-Source: AK7set9HeLdz9xi9BB7rkdqCHJi4WyceVUvbWuT5oEQ0FuJ2pmvnuibIKYF7wC8OyZ5RPuSE0jy6eA==
X-Received: by 2002:a17:906:ca47:b0:8b1:2d40:a399 with SMTP id jx7-20020a170906ca4700b008b12d40a399mr5111853ejb.42.1676535617582;
        Thu, 16 Feb 2023 00:20:17 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i15-20020a17090685cf00b008b1435bd1cbsm488199ejy.105.2023.02.16.00.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 00:20:17 -0800 (PST)
Message-ID: <5ab1d573-aaf2-6747-291d-0c64a01b9ffc@linaro.org>
Date:   Thu, 16 Feb 2023 09:20:15 +0100
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
 <c23f78fe-8ea4-1a5c-c36e-fd981a2c381d@linaro.org>
 <7c815038-e3d2-dd78-26af-8a6f498a6a1e@roeck-us.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7c815038-e3d2-dd78-26af-8a6f498a6a1e@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 16:07, Guenter Roeck wrote:
> On 2/14/23 04:15, Krzysztof Kozlowski wrote:
>> On 14/02/2023 13:10, Guenter Roeck wrote:
>>> On 2/14/23 00:31, Krzysztof Kozlowski wrote:
>>>> On 13/02/2023 21:05, Sergio Paracuellos wrote:
>>>>> MT7621 SoC has a system controller node. Watchdog need to access to reset
>>>>> status register. Ralink architecture and related driver are old and from
>>>>> the beggining they are using some architecture dependent operations for
>>>>> accessing this shared registers through 'asm/mach-ralink/ralink_regs.h'
>>>>> header file. However this is not ideal from a driver perspective which can
>>>>> just access to the system controller registers in an arch independent way
>>>>> using regmap syscon APIs. Update Kconfig accordingly to select new added
>>>>> dependencies and allow driver to be compile tested.
>>>>>
>>>>> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>>>>> ---
>>>>>    drivers/watchdog/Kconfig      |  4 +++-
>>>>>    drivers/watchdog/mt7621_wdt.c | 18 +++++++++++++-----
>>>>>    2 files changed, 16 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>>>> index b64bc49c7..cf752ad64 100644
>>>>> --- a/drivers/watchdog/Kconfig
>>>>> +++ b/drivers/watchdog/Kconfig
>>>>> @@ -1865,7 +1865,9 @@ config GXP_WATCHDOG
>>>>>    config MT7621_WDT
>>>>>    	tristate "Mediatek SoC watchdog"
>>>>>    	select WATCHDOG_CORE
>>>>> -	depends on SOC_MT7620 || SOC_MT7621
>>>>> +	select REGMAP_MMIO
>>>>> +	select MFD_SYSCON
>>>>> +	depends on SOC_MT7620 || SOC_MT7621 || COMPILE_TEST
>>>>>    	help
>>>>>    	  Hardware driver for the Mediatek/Ralink MT7621/8 SoC Watchdog Timer.
>>>>>    
>>>>> diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
>>>>> index 40fb2c9ba..22e979bdd 100644
>>>>> --- a/drivers/watchdog/mt7621_wdt.c
>>>>> +++ b/drivers/watchdog/mt7621_wdt.c
>>>>> @@ -15,8 +15,8 @@
>>>>>    #include <linux/moduleparam.h>
>>>>>    #include <linux/platform_device.h>
>>>>>    #include <linux/mod_devicetable.h>
>>>>> -
>>>>> -#include <asm/mach-ralink/ralink_regs.h>
>>>>> +#include <linux/mfd/syscon.h>
>>>>> +#include <linux/regmap.h>
>>>>>    
>>>>>    #define SYSC_RSTSTAT			0x38
>>>>>    #define WDT_RST_CAUSE			BIT(1)
>>>>> @@ -34,6 +34,7 @@
>>>>>    struct mt7621_wdt_data {
>>>>>    	void __iomem *base;
>>>>>    	struct reset_control *rst;
>>>>> +	struct regmap *sysc;
>>>>>    	struct watchdog_device wdt;
>>>>>    };
>>>>>    
>>>>> @@ -104,9 +105,12 @@ static int mt7621_wdt_stop(struct watchdog_device *w)
>>>>>    	return 0;
>>>>>    }
>>>>>    
>>>>> -static int mt7621_wdt_bootcause(void)
>>>>> +static int mt7621_wdt_bootcause(struct mt7621_wdt_data *d)
>>>>>    {
>>>>> -	if (rt_sysc_r32(SYSC_RSTSTAT) & WDT_RST_CAUSE)
>>>>> +	u32 val;
>>>>> +
>>>>> +	regmap_read(d->sysc, SYSC_RSTSTAT, &val);
>>>>> +	if (val & WDT_RST_CAUSE)
>>>>>    		return WDIOF_CARDRESET;
>>>>>    
>>>>>    	return 0;
>>>>> @@ -143,6 +147,10 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
>>>>>    	if (!drvdata)
>>>>>    		return -ENOMEM;
>>>>>    
>>>>> +	drvdata->sysc = syscon_regmap_lookup_by_compatible("mediatek,mt7621-sysc");
>>>>> +	if (IS_ERR(drvdata->sysc))
>>>>> +		return PTR_ERR(drvdata->sysc);
>>>>
>>>> This should be the backup/error path for original code using syscon
>>>> property. Looking up by compatible is really not portable/re-usable.
>>>>
>>>
>>> I really disagree here.
>>>
>>> $ git grep syscon_regmap_lookup_by_compatible | wc
>>>        90     326    8940
>>>
>>> I have not yet reviewed this code, but I do not accept this argument against it.
>>
>> First, argument that bad pattern is being used is not an argument to
>> keep it and repeat it.
>>
>> Second, we already had examples that:
>> 1. Author used syscon_regmap_lookup_by_compatible() and assumed "we will
>> never add new variant/soc".
>> 2. Then turns out that new variants are obviously added and
>> syscon_regmap_lookup_by_compatible() stops scaling.
>>
> 
> Your arguments only applies if 1) there is ever going to be a new Mediatek/Ralink
> chip with the same watchdog core, and 2) that chip also has the same watchdog
> related registers in its syscon node.
> 
> Both is highly unlikely to happen. There already is a more generic watchdog
> driver for later Mediatek chips (mtk_wdt.c). Even if Mediatek/Ralink ever
> decides to revive this specific watchdog core for whatever reason,
> the time to make the code more generic would have been at that time, at the same
> time ensuring that the more generic code actually works and does have the
> same syscon registers to obtain the boot status.

Sure. In other cases we experienced, people also claimed that this will
not happen. But it happened... I cannot judge whether this will happen
here or not, thus I give generic guideline. If you (singular and plural)
are sure this will not happen, then the code is fine.

> 
>> Whether any new variant/compatible/platform can appear for this watchdog
>> - I don't know.
>>
>> Third, with syscon_regmap_lookup_by_compatible() you have undocumented
>> (not in the binding) dependency between blocks which:
>> a. stops any reusability,
>> b. affects device links and probe ordering (simply - there is no, device
>> must defer probe),
>> c. is simply undocumented.
>>
>> The usage of syscon_regmap_lookup_by_compatible() has clear drawbacks
>> thus new code should rather use syscon phandles which solve all of above.
>>
> 
> "new code". Exactly. This isn't new code.

New code not as "new driver" but new code adding syscon usage. Syscon is
new here so we have flexibility to make it differently, and IMHO, one
way is better than other (for the reasons I stated).

> 
> In order to make progress, I'll accept v7, assuming its updated devicetree
> description is going to be accepted, but my argument still stands.


Best regards,
Krzysztof

