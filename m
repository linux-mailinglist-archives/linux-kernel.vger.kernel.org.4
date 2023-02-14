Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C62369620E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjBNLLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjBNLKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:10:54 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE912822F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:09:50 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id he5so2880960wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rhXsxnHv5iaD89+to6Yh1JylxbzmQTcip18+PxtXccs=;
        b=P5ZBboA6fcsGEXMgChR7x9nAIa1TJztLLxT4QvJtfQn4cQpk3NizRvnrZT+mI5tPTH
         VSL4CiWGQoJaP2HWgOBPEaHP2krfjJhkJoprJ5Ss/8s96oHssau6YwTXgA6y2sCbP5+k
         q/q6zGC+wtXCOSy3E7y0YXw0qxUYRj3jrIsfRmJ0Oejmayjudv63TRGE9nAzs7vC18SB
         9x70GTjGtRVwpniQUkgikSltfHO4a+bczK1h8wcDswna1gYys9zlZLsacqGpgrKu6SYO
         zO0/Qk4iiCwEIVDyG2zDMBgsvr6JrFr1ic6wC6fQUXwLSIeGWCEQncvJYv4gNKhxdbDH
         irfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhXsxnHv5iaD89+to6Yh1JylxbzmQTcip18+PxtXccs=;
        b=d3qw5BqJqkV0WKTUk7AayGmgrGwULFthYOLniawG6EK7C1YlDnnyoH7SGnUphArmYu
         hGJHTlPFd0n0dt4EGHvIcili/Q9yZVE8CW5ol6ttsCNu62fnuT6JFonM8Q+uRiJrZvSh
         CQAmeAt8w9AMAZ+004kBEGgOUOFDmhTt0j50+R0v9kn0hVlFxD5/wlCTNAseVbFmQoZQ
         JSeCn9j6iV+qxRxRwduPpVweG/Aag0txpPunlOizloF1A/eAsLYIIudO2/VlbDW/nTYq
         VD9CZQKGiNBxTzuzAj8aQb2oSz/R//95qfK5JpDITj6pQH4DUzM1o/6v6RgvNtP+6DX/
         NUwA==
X-Gm-Message-State: AO0yUKV3lJj2Afrv1EuOAyJnWC/v98a5w71itYDgkFCK9VMmBDgyKxcD
        STow8d0Z+Y5XzWQ3wgMgKqFV4g==
X-Google-Smtp-Source: AK7set96qzXr5H8bxyUu5JYyZMSP1zvFEAmfOjwu8U/m/YuxbSAbgxIVjLdWXIHt9DvPSm4uWgz1nQ==
X-Received: by 2002:a05:600c:1c0d:b0:3cf:7197:e68a with SMTP id j13-20020a05600c1c0d00b003cf7197e68amr1726544wms.18.1676372954495;
        Tue, 14 Feb 2023 03:09:14 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id az7-20020a05600c600700b003dfe659f9b1sm1857206wmb.3.2023.02.14.03.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 03:09:13 -0800 (PST)
Message-ID: <9047654f-0d51-ba07-5440-7a6f55a8bc4e@linaro.org>
Date:   Tue, 14 Feb 2023 12:09:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] clocksource/drivers/timer-mediatek: Make timer-mediatek
 become loadable module
Content-Language: en-US
To:     =?UTF-8?B?V2FsdGVyIENoYW5nICjlvLXntq3lk7Ip?= 
        <Walter.Chang@mediatek.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "jstultz@google.com" <jstultz@google.com>,
        "macro@orcam.me.uk" <macro@orcam.me.uk>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        =?UTF-8?B?RnJlZGR5IEhzaW4gKOi+m+aBkuixkCk=?= 
        <Freddy.Hsin@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>
References: <20230210100058.19861-1-walter.chang@mediatek.com>
 <f2d66681-a7b6-2369-b9f7-f886f8ea6ae5@linaro.org>
 <e533bd12816ec5f1184fcf138f644f7719def962.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e533bd12816ec5f1184fcf138f644f7719def962.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 12:06, Walter Chang (張維哲) wrote:
> On Fri, 2023-02-10 at 11:07 +0100, Krzysztof Kozlowski wrote:
>> On 10/02/2023 11:00, walter.chang@mediatek.com wrote:
>>> From: Chun-Hung Wu <chun-hung.wu@mediatek.com>
>>>
>>> This patch makes the timer-mediatek driver which can
>>
>> Do not use "This commit/patch".
>>
> https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst*L95__;Iw!!CTRNKA9wMg0ARbw!g1yigOO6iIpjlr82Ud0dn1yVP_1yqSfLWJ-1GFC7O88n7l7lrb9SlYAw5KHzA3339zyiV-s72Wn_OZrARjlaY0RMmdnOUyQ$ 
>>  
>>
>>> register an always-on timer as tick_broadcast_device
>>> on MediaTek SoCs become loadable module in GKI.
>>
>> Are you planning to answer other parts of that discussion? IOW, does
>> the
>> system boot fine? What's the impact of this being a module?
>>
>>>
>>> This patch depends on the previous patch.
>>>
> https://lore.kernel.org/lkml/20230208094813.20874-1-walter.chang@mediatek.com/T/#t
>>
>> This does not belong to commit msg. What's the point of keeping it in
>> commit history forever?
>>
>>>
>>> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
>>> ---
>>>  drivers/clocksource/Kconfig          |  2 +-
>>>  drivers/clocksource/timer-mediatek.c | 43
>>> ++++++++++++++++++++++++++++
>>>  2 files changed, 44 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clocksource/Kconfig
>>> b/drivers/clocksource/Kconfig
>>> index 4469e7f555e9..41345827055b 100644
>>> --- a/drivers/clocksource/Kconfig
>>> +++ b/drivers/clocksource/Kconfig
>>> @@ -472,7 +472,7 @@ config SYS_SUPPORTS_SH_CMT
>>>  	bool
>>>  
>>>  config MTK_TIMER
>>> -	bool "Mediatek timer driver" if COMPILE_TEST
>>> +	tristate "Mediatek timer driver"
>>>  	depends on HAS_IOMEM
>>>  	select TIMER_OF
>>>  	select CLKSRC_MMIO
>>> diff --git a/drivers/clocksource/timer-mediatek.c
>>> b/drivers/clocksource/timer-mediatek.c
>>> index d5b29fd03ca2..806044ef391c 100644
>>> --- a/drivers/clocksource/timer-mediatek.c
>>> +++ b/drivers/clocksource/timer-mediatek.c
>>> @@ -13,6 +13,9 @@
>>>  #include <linux/clocksource.h>
>>>  #include <linux/interrupt.h>
>>>  #include <linux/irqreturn.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/platform_device.h>
>>>  #include <linux/sched_clock.h>
>>>  #include <linux/slab.h>
>>>  #include "timer-of.h"
>>> @@ -450,6 +453,46 @@ static int __init mtk_gpt_init(struct
>>> device_node *node)
>>>  
>>>  	return 0;
>>>  }
>>> +
>>> +#ifdef MODULE
>>> +static int mtk_timer_probe(struct platform_device *pdev)
>>> +{
>>> +	int (*timer_init)(struct device_node *node);
>>> +	struct device_node *np = pdev->dev.of_node;
>>> +
>>> +	timer_init = of_device_get_match_data(&pdev->dev);
>>> +	return timer_init(np);
>>> +}
>>> +
>>> +static const struct of_device_id mtk_timer_match_table[] = {
>>> +	{
>>> +		.compatible = "mediatek,mt6577-timer",
>>> +		.data = mtk_gpt_init,
>>> +	},
>>> +	{
>>> +		.compatible = "mediatek,mt6765-timer",
>>> +		.data = mtk_syst_init,
>>> +	},
>>> +	{
>>> +		.compatible = "mediatek,mt6795-systimer",
>>> +		.data = mtk_cpux_init,
>>> +	},
>>> +	{}
>>> +};
>>> +
>>> +static struct platform_driver mtk_timer_driver = {
>>> +	.probe = mtk_timer_probe,
>>> +	.driver = {
>>> +		.name = "mtk-timer",
>>> +		.of_match_table = mtk_timer_match_table,
>>> +	},
>>> +};
>>> +MODULE_DESCRIPTION("MEDIATEK Module Timer driver");
>>> +MODULE_LICENSE("GPL v2");
>>
>> I don't think you run checkpatch before sending... please do not use
>> humans for review which is done by automatic tools.
>>
>>> +
>>> +module_platform_driver(mtk_timer_driver);
>>
>> Follow coding convention like in very other driver, so this goes
>> immediately after definition of driver structure.
>>
>>> +#else
>>
>>
>> Best regards,
>> Krzysztof
>>
> 
> Thanks for pointing out the mistake. I have fixed it and submitted 
> patch v2, which merged the driver and export functions in the same
> patch.
> 
> 
> https://lore.kernel.org/lkml/20230214105412.5856-1-walter.chang@mediatek.com/T/#t

My other questions are unanswered.

Best regards,
Krzysztof

