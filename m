Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1932A6DD5C6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjDKIkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjDKIkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:40:06 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DEC97
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:40:04 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n9-20020a05600c4f8900b003f05f617f3cso10530209wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681202402; x=1683794402;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9/wYNat7TPM3zWz4GDYzbktloA3LkLTC7q3uSG76aLY=;
        b=QO/KWej9A19X+y12P04FrRCY+Paf9jgWd9OI1Nen2I8bgVAMWeGPb9O2kDxPVSSYJY
         U7wTC/1C7KpD3KR9v5KvyQU8hQzOecI4eew03cAa6n3l14+G+M9F24FMEDIJpBimQuDB
         M34F2FMqj7sPfkx2I6jxhKLjgRz9Ae2TJxgUmhvPq+LMTazxLMeT81tWHrbnkkeYPeUJ
         XWgEsvxdlVsEpoVFqk1XInjX+6Ol/YJCueoOLuDnifNL5aI7glCbgCtgqNk3FE+5FBbr
         csZ98Zk/UDMdXpA1q/sgtbc/XbHm5/kYKsvA46e+hEMU41TikMIBaqDccgkBC6bHzsNC
         mpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681202402; x=1683794402;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/wYNat7TPM3zWz4GDYzbktloA3LkLTC7q3uSG76aLY=;
        b=uY7z/4n9sUC1vGXSwoe/LTeT1NN4th+0asrE2VMCvNPQYvRGr3M4btQQZbnkfbK3Ph
         YzEvoNVDOtKoNwvJUMr5E5KomuMQ8Cu/b0vxcvOmKfVOIWO5Edph1O33KTA+EV1k1F4j
         /RYKD1LMgXIQVYU5CIbKxan1dI+Oyd7tKlMzsgwG/DdfZyVP7jv/iw/3zu0sbbQvfkY5
         bU/wnF4FsJ0Jjff2HfsHxtEp2UeWS0DAD+OgQGFoZ8xt1OY+AH31x5Oz3uujjLrFDE68
         tLow9QFxUdi5FPq94jHqX3jJAtaJPIzqzdTEMemDSPSPWPbkazuUDaWB6D/Exv0NO3R1
         5QFg==
X-Gm-Message-State: AAQBX9eA+LgoBSns14h0/HYi1HTM4YdmLkyN804/z0rW91inl0ALOz5z
        dPM91ulz8XHUKD+M2SZI4PGIIA==
X-Google-Smtp-Source: AKy350ZTF43P835vc5NPh7vSRk88CSUb3apDwgby7DBU+yDKQR+urh8M5ltZc3mi903belBfjDFwDw==
X-Received: by 2002:a05:600c:299:b0:3ed:5d41:f998 with SMTP id 25-20020a05600c029900b003ed5d41f998mr9763322wmk.15.1681202402518;
        Tue, 11 Apr 2023 01:40:02 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:2611:592:3b9e:d2ae? ([2a05:6e02:1041:c10:2611:592:3b9e:d2ae])
        by smtp.googlemail.com with ESMTPSA id x10-20020a05600c21ca00b003edf2dc7ca3sm16242062wmj.34.2023.04.11.01.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 01:40:02 -0700 (PDT)
Message-ID: <23636c0c-957c-cab8-6ded-c1f22481f6a6@linaro.org>
Date:   Tue, 11 Apr 2023 10:40:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drivers: clocksource: fix memory leak in
 davinci_timer_register
Content-Language: en-US
To:     =?UTF-8?B?5oi06ZKm5ram?= <u201911649@hust.edu.cn>,
        thomas gleixner <tglx@linutronix.de>,
        bartosz golaszewski <bgolaszewski@baylibre.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        linux-kernel@vger.kernel.org
References: <20230322151945.102353-1-flno@hust.edu.cn>
 <192d4b12.39f86.1876b0d8808.Coremail.u201911649@hust.edu.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <192d4b12.39f86.1876b0d8808.Coremail.u201911649@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

thanks for the fix.

However, the changes are incomplete, you should create the rollback 
labels to undo all the allocated resources.

On 10/04/2023 14:04, 戴钦润 wrote:
> 
> ping?



>> -----Original Messages-----
>> From: "Qinrun Dai" <flno@hust.edu.cn>
>> Sent Time: 2023-03-22 23:19:45 (Wednesday)
>> To: "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Bartosz Golaszewski" <bgolaszewski@baylibre.com>
>> Cc: hust-os-kernel-patches@googlegroups.com, "Qinrun Dai" <flno@hust.edu.cn>, linux-kernel@vger.kernel.org
>> Subject: [PATCH] drivers: clocksource: fix memory leak in davinci_timer_register
>>
>> Smatch reports:
>> drivers/clocksource/timer-davinci.c:332 davinci_timer_register()
>> warn: 'base' from ioremap() not released on lines: 274.
>>
>> Fix this by defining a unified function exit
>> to iounmap 'base' and return corresponding value.
>>
>> Fixes: 721154f972aa ("clocksource/drivers/davinci: Add support for clockevents")
>> Signed-off-by: Qinrun Dai <flno@hust.edu.cn>
>> ---
>>   drivers/clocksource/timer-davinci.c | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
>> index 9996c0542520..a6dd1da9e6d1 100644
>> --- a/drivers/clocksource/timer-davinci.c
>> +++ b/drivers/clocksource/timer-davinci.c
>> @@ -270,8 +270,10 @@ int __init davinci_timer_register(struct clk *clk,
>>   	tick_rate = clk_get_rate(clk);
>>   
>>   	clockevent = kzalloc(sizeof(*clockevent), GFP_KERNEL);
>> -	if (!clockevent)
>> -		return -ENOMEM;
>> +	if (!clockevent) {
>> +		rv = -ENOMEM;
>> +		goto iounmap_base;
>> +	}
>>   
>>   	clockevent->dev.name = "tim12";
>>   	clockevent->dev.features = CLOCK_EVT_FEAT_ONESHOT;
>> @@ -296,7 +298,7 @@ int __init davinci_timer_register(struct clk *clk,
>>   			 "clockevent/tim12", clockevent);
>>   	if (rv) {
>>   		pr_err("Unable to request the clockevent interrupt\n");
>> -		return rv;
>> +		goto iounmap_base;
>>   	}
>>   
>>   	davinci_clocksource.dev.rating = 300;
>> @@ -323,13 +325,17 @@ int __init davinci_timer_register(struct clk *clk,
>>   	rv = clocksource_register_hz(&davinci_clocksource.dev, tick_rate);
>>   	if (rv) {
>>   		pr_err("Unable to register clocksource\n");
>> -		return rv;
>> +		goto iounmap_base;
>>   	}
>>   
>>   	sched_clock_register(davinci_timer_read_sched_clock,
>>   			     DAVINCI_TIMER_CLKSRC_BITS, tick_rate);
>>   
>>   	return 0;
>> +
>> +iounmap_base:
>> +	iounmap(base);
>> +	return rv;
>>   }
>>   
>>   static int __init of_davinci_timer_register(struct device_node *np)
>> -- 
>> 2.37.2

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

