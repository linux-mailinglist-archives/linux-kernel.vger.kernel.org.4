Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAA46E233C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjDNM2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjDNM2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:28:22 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D37AB440
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 05:28:17 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id c9so6279757ejz.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 05:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681475296; x=1684067296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2IJkV6Vx5TKwaqO1LbgwCrd/XJlJ7MEyOwn1DdAcAA8=;
        b=HHGMdc8w7jAyHnf3DTnO+F9+TV3P3GjfeaU9BME8ObPJ/dgUcklR27VL96fm+VUiJB
         v6FD9cN+SI3xLVazbu33X4+bmoc3mMFFqosZmMX5uG9rgCosTjB6mIG3ZBA7y7/PGkbu
         XFh4hCiY2+n9gEsEtebJbJsC4GQBbmMjJ1NQyKT6EogBAGhLJ6Z4D/HxJhuQFe/92DxR
         Epbd0L7dXxagrtyy7n/9cuS/wMHvNitdP7muzsaEUJL8lz6FV0z3sbvWnPJwyj0bD+sB
         OHFklIaLR8XIlAQAGlATj+c3JJW7Zl7XHB/C0j8FKJCTB6gtE1r5pwLjNv9Bdk+MLlrc
         4Eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681475296; x=1684067296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2IJkV6Vx5TKwaqO1LbgwCrd/XJlJ7MEyOwn1DdAcAA8=;
        b=KNThQ+gDXRCZogZaNVlrypzb8BYrDjYPaaPvB+2iRSy2wG8N0RaRysOZFLuPh72+0i
         3pajhxppV33oRQOkAKGsynRU7EbrmnjcVjYSOckNBzxY2iNamyqp6ic5VcCDltSn+uBo
         5n5PdvbVz9vl15R95TdjDnKXnHtTaSF2WoPm2nBfYslt4OuKOIXwGGNxTrCNBcG2eAET
         WnkRyj0wqcZfLL1n65UPRVjvi14aS/ymNZR30k4uXHy/ACbfRPc99AIe7gDmpqiVWcyD
         2kM2y/EUgVc8FaegEmt+MKc95CDABGMvpVHfwBzfKgD8yHWACtXUYfYyJsUFm1HcNRuc
         0Ybg==
X-Gm-Message-State: AAQBX9eysGViUcnCElB7K1IFTwdQIwjwLA9TtcLRDmjjYwXr4cHppPWA
        7y1f0QKl93KEcPydfP0+4GvRKQ==
X-Google-Smtp-Source: AKy350YZi+IejTh/8DUpsdpqBZWUHt951EgYelr9S/h0i88I2IrJ+FGLh9huM0t3PTVnT7qAh48bVw==
X-Received: by 2002:a17:907:d094:b0:94e:eb42:2a7c with SMTP id vc20-20020a170907d09400b0094eeb422a7cmr1444904ejc.25.1681475295927;
        Fri, 14 Apr 2023 05:28:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:39b7:81a0:bd41:17b1? ([2a02:810d:15c0:828:39b7:81a0:bd41:17b1])
        by smtp.gmail.com with ESMTPSA id p9-20020a05640210c900b004fa012332ecsm2076486edu.1.2023.04.14.05.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 05:28:15 -0700 (PDT)
Message-ID: <512ac643-c487-ed83-9bf5-242f4890c680@linaro.org>
Date:   Fri, 14 Apr 2023 14:28:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [EXT] Re: [PATCH 2/2] Watchdog: Add octeontx2 GTI watchdog driver
To:     Bharat Bhushan <bbhushan2@marvell.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230414102342.23696-1-bbhushan2@marvell.com>
 <20230414102342.23696-2-bbhushan2@marvell.com>
 <832d7830-be98-243c-ebf7-c23ae51e4ccc@linaro.org>
 <DM5PR1801MB1883F11EF48041C7B9EF3D9EE3999@DM5PR1801MB1883.namprd18.prod.outlook.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DM5PR1801MB1883F11EF48041C7B9EF3D9EE3999@DM5PR1801MB1883.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 13:44, Bharat Bhushan wrote:
> Please see inline 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Friday, April 14, 2023 4:58 PM
>> To: Bharat Bhushan <bbhushan2@marvell.com>; wim@linux-watchdog.org;
>> linux@roeck-us.net; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
>> linux-watchdog@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: [EXT] Re: [PATCH 2/2] Watchdog: Add octeontx2 GTI watchdog driver
>>
>> External Email
>>
>> ----------------------------------------------------------------------
>> On 14/04/2023 12:23, Bharat Bhushan wrote:
>>> GTI watchdog timer are programmed in "interrupt + del3t + reset mode"
>>> and del3t traps are not enabled.
>>> GTI watchdog exception flow is:
>>>  - 1st timer expiration generates watchdog interrupt.
>>>  - 2nd timer expiration is ignored
>>>  - On 3rd timer expiration will trigger a system-wide core reset.
>>>
>>> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
>>> ---
>>>  drivers/watchdog/Kconfig         |   9 ++
>>>  drivers/watchdog/Makefile        |   1 +
>>>  drivers/watchdog/octeontx2_wdt.c | 238
>>> +++++++++++++++++++++++++++++++
>>>  3 files changed, 248 insertions(+)
>>>  create mode 100644 drivers/watchdog/octeontx2_wdt.c
>>>
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig index
>>> f0872970daf9..31ff282c62ad 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -2212,4 +2212,13 @@ config KEEMBAY_WATCHDOG
>>>  	  To compile this driver as a module, choose M here: the
>>>  	  module will be called keembay_wdt.
>>>
>>> +config OCTEONTX2_WATCHDOG
>>> +	tristate "OCTEONTX2 Watchdog driver"
>>> +	depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)
>>
>> Why it cannot be compile tested on 32-bit?
> 
> Used in 64 bit configuration but no harm getting compile tested for 32bit.
> Will change
> 
>>
>>> +	help
>>> +	 OCTEONTX2 GTI hardware supports watchdog timer. This watchdog
>> timer are
>>> +	 programmed in "interrupt + del3t + reset" mode. On first expiry it will
>>> +	 generate interrupt. Second expiry (del3t) is ignored and system will reset
>>> +	 on final timer expiry.
>>> +
>>>  endif # WATCHDOG
>>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>>> index 9cbf6580f16c..aa1b813ad1f9 100644
>>> --- a/drivers/watchdog/Makefile
>>> +++ b/drivers/watchdog/Makefile
>>> @@ -230,3 +230,4 @@ obj-$(CONFIG_MENZ069_WATCHDOG) +=
>> menz69_wdt.o
>>>  obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
>>>  obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
>>>  obj-$(CONFIG_SL28CPLD_WATCHDOG) += sl28cpld_wdt.o
>>> +obj-$(CONFIG_OCTEONTX2_WATCHDOG) += octeontx2_wdt.o
>>
>> Please tell me that you added it in some reasonable place, not just at the end...
>> The same in Kconfig.
> 
> Is it alphabetical order, any suggestion?

'O' is not after 'S', thus for sure you did not add it in alphabetical
order.

Or what is a question? If so, then yes, usually we try to keep
alphabetical order. Anyway adding entries to the end is conflictprone.


>>> +	dev_info(dev, "Watchdog enabled (timeout=%d sec)\n", wdog_dev-
>>> timeout);
>>> +	return 0;
>>> +}
>>> +
>>> +static int octeontx2_wdt_remove(struct platform_device *pdev) {
>>> +	struct octeontx2_wdt_priv *priv = platform_get_drvdata(pdev);
>>> +
>>> +	if (priv->irq)
>>
>> Is it possible?

You did not reply, so I assume it is not possible. Drop.

>>
>>> +		free_irq(priv->irq, priv);
>>
>> Anyway, your order of cleanup is a bit surprising. It is expected to be reversed
>> from probe. In probe() you requested IRQs before watchdog, but cleanup will be
>> done before watchdog release? This does not look right.
> 
> Watchdog release happen outside this driver as we used devm_*. 

I know, this is why I raised the question. Don't repeat the obvious but
rather address the problem mentioned here.


> Will convert request_irq to devm_request_irq(). 

If interrupt is not shared, then looks like correct approach.

Best regards,
Krzysztof

