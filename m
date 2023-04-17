Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1476E4AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjDQOKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjDQOKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:10:40 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EBB527D;
        Mon, 17 Apr 2023 07:10:32 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id d16so7748023iow.2;
        Mon, 17 Apr 2023 07:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681740632; x=1684332632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=T01sfQqQdMdXRmdajNdjhGR+yeueVTfe3Obxv9jJj0Y=;
        b=MQZNkc3lAjt2dylyV9rIZnVFXTrFt45t7+6VVNZovhgH6uSiLN5wdtIL3Duntc782u
         FA/VPD9x0tuuh5bsX+8otyHUnz0bzCpUFuCFXr1bm5+QlKVqPJFbUXsPQJLK1Hsg9nKJ
         VbU/iSqnXDszW2+XnMZDF1g4nAsiFwj4wa0JbkDZOPjzAPYX83qiTv8fKz/LC9GyiWCa
         frhKNSeGOS94+BdVNqV+dplCCBdpmeBU9vZat0er1tL4Fc5kWAccUdcObf7YeSOJT80Z
         ANGGDzYnqsfAVFjs+wKx/UH9Fh4Qr87tVmjj/7Sa4DDj4fNDJRTq5xe2KX6bjhk9wCVH
         OwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681740632; x=1684332632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T01sfQqQdMdXRmdajNdjhGR+yeueVTfe3Obxv9jJj0Y=;
        b=MUNLhBu9LAThDg0f6bSm+dlzgWmjDuCfjdyaG3sfFSwFBB2NgJ9xbFwzvln2Maa+9+
         miPbchk2DgAySUSOkYWue++n3QTz7VnyjiC794jeAbVZenfVivbkN2Jf/mazBHdC6JtF
         cLBMO0tgB9nylG6Q4QFmGCIM4Xll7cUcLLeJ07Ec6vwCiU4ILbFqnltR+iU9gScPLLx6
         f8KcatsknAOUh4T1Je325P5z0uD/X86o38y2LhZK8SPj6hSuJPoJDO3VRBXFsrF1l584
         paLfkGF1sgMtM7vWiRblojQZAnctHNgd16fi3LBgLzn7FYbOXvis20ZOKc3I+wYDKZdW
         9fcQ==
X-Gm-Message-State: AAQBX9dOOFR1xkykXkAUFrHOHsgJejdoVfnh5lbv46sigXYYSgW4Pe87
        e0ubjwNPfLsUf9gTBUrB5n/gZqIyNPg=
X-Google-Smtp-Source: AKy350Zva82w7J2catmbiiXWXABGiWU7RcWsPP5kw4m/LU/KsB5SsE1he+Zerw/9XTujO4jRtHSztA==
X-Received: by 2002:a5d:88c5:0:b0:760:a51d:d9f9 with SMTP id i5-20020a5d88c5000000b00760a51dd9f9mr9855058iol.12.1681740632080;
        Mon, 17 Apr 2023 07:10:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r16-20020a02aa10000000b0040f978ab875sm1839858jam.107.2023.04.17.07.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 07:10:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2481a311-b8ca-23a8-fcfb-de980a104f8e@roeck-us.net>
Date:   Mon, 17 Apr 2023 07:10:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [EXT] Re: [PATCH 2/2] Watchdog: Add octeontx2 GTI watchdog driver
Content-Language: en-US
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230414102342.23696-1-bbhushan2@marvell.com>
 <20230414102342.23696-2-bbhushan2@marvell.com>
 <b3087a0c-d079-4ccb-8202-593abb4a4d44@roeck-us.net>
 <DM5PR1801MB188396A390171D72C6702021E39C9@DM5PR1801MB1883.namprd18.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <DM5PR1801MB188396A390171D72C6702021E39C9@DM5PR1801MB1883.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/23 04:06, Bharat Bhushan wrote:
> Please see inline
> 
>> -----Original Message-----
>> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
>> Sent: Friday, April 14, 2023 8:05 PM
>> To: Bharat Bhushan <bbhushan2@marvell.com>
>> Cc: wim@linux-watchdog.org; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; linux-watchdog@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: [EXT] Re: [PATCH 2/2] Watchdog: Add octeontx2 GTI watchdog driver
>>
>> External Email
>>
>> ----------------------------------------------------------------------
>> On Fri, Apr 14, 2023 at 03:53:42PM +0530, Bharat Bhushan wrote:
>>> GTI watchdog timer are programmed in "interrupt + del3t + reset mode"
>>> and del3t traps are not enabled.
>>> GTI watchdog exception flow is:
>>>   - 1st timer expiration generates watchdog interrupt.
>>>   - 2nd timer expiration is ignored
>>>   - On 3rd timer expiration will trigger a system-wide core reset.
>>>
>>
>> This means the interrupt should not result in a panic, the programmed timeout
>> value should be considered a pretimeout which is set to (timeout / 3), and the
>> interrupt handler should call watchdog_notify_pretimeout().
>>
>> Either case, the above should be documented in the driver but does not make
>> much if any sense as patch description. If not, what are the other modes, and
>> why is this mode used instead of any of those modes ?
> 
> Hardware supports following mode of operation:
> 1) Interrupt Only:
>      This will generate the interrupt to arm core whenever timeout happens.
> 
> 2) Interrupt + del3t (Interrupt to firmware (SCP processor)).
>       This will generate interrupt to arm core whenever 1st timeout happens
>       This will generate interrupt to SCP processor whenever 2nd timeout happens
> 
> 3) Interrupt + Interrupt to SCP processor (called delt3t) + reboot.
>       This will generate interrupt to arm core whenever 1st timeout happens
>       This will generate interrupt to SCP processor whenever 2nd timeout happens, if interrupt is configured.
>       This will reboot on 3rd timeout.
> 
> We are going with mode-3 above so that system can reboot in case a hardware hang. Also h/w is configured not to generate SCP interrupt, so effectively 2nd timeout is ignored within hardware.
> 
> Software is supposed to poke within 1st timeout. If poke does not happen then it will receive interrupt, interrupt handler will do panic.
> But for some reason if processor can not take interrupt then system will reboot on 3rd timeout.
> 
Then, as I said, the first timeout shopuld be modeled as pretimeout.

Thanks,
Guenter

>>
>>> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
>>> ---
>>>   drivers/watchdog/Kconfig         |   9 ++
>>>   drivers/watchdog/Makefile        |   1 +
>>>   drivers/watchdog/octeontx2_wdt.c | 238
>>> +++++++++++++++++++++++++++++++
>>>   3 files changed, 248 insertions(+)
>>>   create mode 100644 drivers/watchdog/octeontx2_wdt.c
>>>
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig index
>>> f0872970daf9..31ff282c62ad 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -2212,4 +2212,13 @@ config KEEMBAY_WATCHDOG
>>>   	  To compile this driver as a module, choose M here: the
>>>   	  module will be called keembay_wdt.
>>>
>>> +config OCTEONTX2_WATCHDOG
>>> +	tristate "OCTEONTX2 Watchdog driver"
>>> +	depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)
>>> +	help
>>> +	 OCTEONTX2 GTI hardware supports watchdog timer. This watchdog
>> timer are
>>> +	 programmed in "interrupt + del3t + reset" mode. On first expiry it will
>>> +	 generate interrupt. Second expiry (del3t) is ignored and system will reset
>>> +	 on final timer expiry.
>>> +
>>
>> The above should be part of the in-driver documentation but those details
>> should not be in Kconfig.
> 
> Ok,
> 
>>
>> Is the documentation available in public ? I'd like to check if this mode, especially
>> the ignored del3t mode, really makes sense.
> 
> Documentation is not public. Provided some description above, let me know if I need to provide some more details.
> 
>>
>>>   endif # WATCHDOG
>>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>>> index 9cbf6580f16c..aa1b813ad1f9 100644
>>> --- a/drivers/watchdog/Makefile
>>> +++ b/drivers/watchdog/Makefile
>>> @@ -230,3 +230,4 @@ obj-$(CONFIG_MENZ069_WATCHDOG) +=
>> menz69_wdt.o
>>>   obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
>>>   obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
>>>   obj-$(CONFIG_SL28CPLD_WATCHDOG) += sl28cpld_wdt.o
>>> +obj-$(CONFIG_OCTEONTX2_WATCHDOG) += octeontx2_wdt.o
>>> diff --git a/drivers/watchdog/octeontx2_wdt.c
>>> b/drivers/watchdog/octeontx2_wdt.c
>>> new file mode 100644
>>> index 000000000000..7b78a092e83f
>>> --- /dev/null
>>> +++ b/drivers/watchdog/octeontx2_wdt.c
>>> @@ -0,0 +1,238 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/* Marvell Octeontx2 Watchdog driver
>>> + *
>>> + * Copyright (C) 2023 Marvell International Ltd.
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> +modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/cpu.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/of_platform.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/watchdog.h>
>>> +#include <linux/sched/debug.h>
>>
>> What is this include for ?
> 
> Taken from other driver when started coding this one. Will remove
> 
>>
>>> +
>>> +#include <asm/arch_timer.h>
>>> +
>>> +/* GTI CWD Watchdog Registers */
>>> +#define GTI_CWD_GLOBAL_WDOG_IDX		63
>>> +#define GTI_CWD_WDOG			(0x8 *
>> GTI_CWD_GLOBAL_WDOG_IDX)
>>> +#define GTI_CWD_WDOG_MODE_INT_DEL3T_RST	0x3
>>> +#define GTI_CWD_WDOG_MODE_MASK		0x3
>>> +#define GTI_CWD_WDOG_LEN_SHIFT		4
>>> +#define GTI_CWD_WDOG_CNT_SHIFT		20
>>> +
>>> +/* GTI Per-core Watchdog Interrupt Register */
>>> +#define GTI_CWD_INT			0x200
>>> +#define GTI_CWD_INT_PENDING_STATUS	(1ULL <<
>> GTI_CWD_GLOBAL_WDOG_IDX)
>>> +
>>> +/* GTI Per-core Watchdog Interrupt Enable Clear Register */
>>> +#define GTI_CWD_INT_ENA_CLR		0x210
>>> +#define GTI_CWD_INT_ENA_CLR_VAL		(1ULL <<
>> GTI_CWD_GLOBAL_WDOG_IDX)
>>> +
>>> +/* GTI Per-core Watchdog Interrupt Enable Set Register */
>>> +#define GTI_CWD_INT_ENA_SET		0x218
>>> +#define GTI_CWD_INT_ENA_SET_VAL		(1ULL <<
>> GTI_CWD_GLOBAL_WDOG_IDX)
>>> +
>>> +/* GTI Per-core Watchdog Poke Registers */
>>> +#define GTI_CWD_POKE		(0x10000 + 0x8 *
>> GTI_CWD_GLOBAL_WDOG_IDX)
>>> +#define GTI_CWD_POKE_VAL	(1ULL << GTI_CWD_GLOBAL_WDOG_IDX)
>>> +
>>> +struct octeontx2_wdt_priv {
>>> +	struct watchdog_device wdev;
>>> +	void __iomem *base;
>>> +	u64 clock_freq;
>>> +	int irq;
>>> +};
>>> +
>>> +static irqreturn_t octeontx2_wdt_interrupt(int irq, void *data) {
>>> +	panic("Kernel Watchdog");
>>> +	return IRQ_HANDLED;
>>> +}
>>> +
>>> +static int octeontx2_wdt_ping(struct watchdog_device *wdev) {
>>> +	struct octeontx2_wdt_priv *priv = watchdog_get_drvdata(wdev);
>>> +
>>> +	writeq(GTI_CWD_POKE_VAL, priv->base + GTI_CWD_POKE);
>>> +	return 0;
>>> +}
>>> +
>>> +static int octeontx2_wdt_start(struct watchdog_device *wdev) {
>>> +	struct octeontx2_wdt_priv *priv = watchdog_get_drvdata(wdev);
>>> +	u64 regval;
>>> +
>>> +	set_bit(WDOG_HW_RUNNING, &wdev->status);
>>> +
>>> +	/* Clear any pending interrupt */
>>> +	writeq(GTI_CWD_INT_PENDING_STATUS, priv->base + GTI_CWD_INT);
>>> +
>>> +	/* Enable Interrupt */
>>> +	writeq(GTI_CWD_INT_ENA_SET_VAL, priv->base +
>> GTI_CWD_INT_ENA_SET);
>>> +
>>> +	/* Set (Interrupt + SCP interrupt (DEL3T) + core domain reset) Mode */
>>> +	regval = readq(priv->base + GTI_CWD_WDOG);
>>> +	regval |= GTI_CWD_WDOG_MODE_INT_DEL3T_RST;
>>> +	writeq(regval, priv->base + GTI_CWD_WDOG);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int octeontx2_wdt_stop(struct watchdog_device *wdev) {
>>> +	struct octeontx2_wdt_priv *priv = watchdog_get_drvdata(wdev);
>>> +	u64 regval;
>>> +
>>> +	/* Disable Interrupt */
>>> +	writeq(GTI_CWD_INT_ENA_CLR_VAL, priv->base +
>> GTI_CWD_INT_ENA_CLR);
>>> +
>>> +	/* Set GTI_CWD_WDOG.Mode = 0 to stop the timer */
>>> +	regval = readq(priv->base + GTI_CWD_WDOG);
>>> +	regval &= ~GTI_CWD_WDOG_MODE_MASK;
>>> +	writeq(regval, priv->base + GTI_CWD_WDOG);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int octeontx2_wdt_settimeout(struct watchdog_device *wdev,
>>> +					unsigned int timeout)
>>> +{
>>> +	struct octeontx2_wdt_priv *priv = watchdog_get_drvdata(wdev);
>>> +	u64 timeout_wdog, regval;
>>> +
>>> +	/* Update new timeout */
>>> +	wdev->timeout = timeout;
>>> +
>>> +	/* Get clock cycles from timeout in second */
>>> +	timeout_wdog = (u64)timeout * priv->clock_freq;
>>> +
>>> +	/* Watchdog counts in 1024 cycle steps */
>>> +	timeout_wdog = timeout_wdog >> 10;
>>> +
>>> +	/*
>>> +	 * Hardware allows programming of upper 16-bits of 24-bits cycles
>>> +	 * Round up and use upper 16-bits only.
>>> +	 * Set max if timeout more than h/w supported
>>
>> This should be covered when setting max_timeout or max_hw_heartbeat_ms.
>> Setting the actual timeout to a value smaller than configured may result in the
>> watchdog firing before its configured timeout expires.
> 
> wdog_dev->max_timeout = 16 is set based on above description, will move this comment there.
> 
> Just to explain why I added above comment here and below check, that was to ensure that if user provides timeout more than " wdog_dev->max_timeout" then program wdog_dev->max_timeout only.
> But now looking at the code "set_timeout()" will be called only if timeout is valid ( timeout is <= wdog_dev->max_timeout)
> 
> So above comment is not valid, while below check can also be removed.
> 
>>
>>> +	 */
>>> +	timeout_wdog = (timeout_wdog + 0xff) >> 8;
>>> +	if (timeout_wdog >= 0x10000)
>>> +		timeout_wdog = 0xffff;
>>> +
>>> +	/*
>>> +	 * GTI_CWD_WDOG.LEN have only upper 16-bits of 24-bits
>>> +	 * GTI_CWD_WDOG.CNT, need addition shift of 8.
>>> +	 */
>>> +	regval = readq(priv->base + GTI_CWD_WDOG);
>>> +	regval &= GTI_CWD_WDOG_MODE_MASK;
>>> +	regval |= ((timeout_wdog) << (GTI_CWD_WDOG_CNT_SHIFT + 8)) |
>>> +		   (timeout_wdog << GTI_CWD_WDOG_LEN_SHIFT);
>>
>> () around timeout is unnecessary. Why does the timeout need to be programmed
>> twice into the register ? The shift values are odd.
>> Are you sure this does what you expect it to do ?
> 
> This register have two timeouts:
>     GTI_CWD_WDOG.CNT[43:20] (24bit) = this is something decrementing with a frequency.
>     GTI_CWD_WDOG.LEN[19:4] (16bit) = this is something loaded in upper 16 bits of GTI_CWD_WDOG.CNT when poke happens.
> 
> Shift looks odd but it works as expected.
> 
>>
>>> +	writeq(regval, priv->base + GTI_CWD_WDOG);
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct watchdog_info octeontx2_wdt_ident = {
>>> +	.identity = "OcteonTX2 watchdog",
>>> +	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
>> WDIOF_MAGICCLOSE |
>>> +			  WDIOF_CARDRESET,
>>> +};
>>> +
>>> +static const struct watchdog_ops octeontx2_wdt_ops = {
>>> +	.owner = THIS_MODULE,
>>> +	.start = octeontx2_wdt_start,
>>> +	.stop = octeontx2_wdt_stop,
>>> +	.ping = octeontx2_wdt_ping,
>>> +	.set_timeout = octeontx2_wdt_settimeout, };
>>> +
>>> +static int octeontx2_wdt_probe(struct platform_device *pdev) {
>>> +	struct octeontx2_wdt_priv *priv;
>>> +	struct device *dev = &pdev->dev;
>>> +	struct watchdog_device *wdog_dev;
>>> +	int irq;
>>> +	int err;
>>> +
>>> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>>> +	if (!priv)
>>> +		return -ENOMEM;
>>> +
>>> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
>>> +	if (IS_ERR(priv->base))
>>> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->base),
>>> +			      "reg property not valid/found\n");
>>> +
>>> +	priv->clock_freq = arch_timer_get_cntfrq();
>>> +
>>> +	wdog_dev = &priv->wdev;
>>> +	wdog_dev->info = &octeontx2_wdt_ident,
>>> +	wdog_dev->ops = &octeontx2_wdt_ops,
>>> +	wdog_dev->parent = dev;
>>> +	wdog_dev->min_timeout = 1;
>>> +	wdog_dev->max_timeout = 16;
>>
>> Setting max_timeout makes max_hw_heartbeat_ms useless. Use only
>> max_hw_heartbeat_ms to enable larger soft timeouts, or use only max_timeout
>> to set the hard limit, but not both.
> 
> Okay, thanks for details
> 
>>
>>> +	wdog_dev->max_hw_heartbeat_ms = 16000;
>>> +	wdog_dev->timeout = 8;
>>> +
>>> +	irq = platform_get_irq(pdev, 0);
>>> +	if (irq < 0) {
>>> +		dev_err(&pdev->dev, "IRQ resource not found\n");
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	err = request_irq(irq, octeontx2_wdt_interrupt, 0, pdev->name, priv);
>>> +	if (err) {
>>> +		dev_err(dev, "cannot register interrupt handler %d\n", err);
>>> +		return err;
>>> +	}
>>
>> Use devm_request_irq() and request the interrupt after registering the watchdog.
> 
> Okay,
> 
>>
>>> +
>>> +	priv->irq = irq;
>>> +	watchdog_set_drvdata(wdog_dev, priv);
>>> +	platform_set_drvdata(pdev, priv);
>>> +	watchdog_init_timeout(wdog_dev, wdog_dev->timeout, dev);
>>
>> watchdog_init_timeout sets wdog_dev->timeout, so this is pointless.
>> Calling watchdog_init_timeout() only makes sense if the parameter is either a
>> timeout module parameter or 0 and the idea is to use a value from devicetree if
>> configured.
> 
> Okay, thanks again for detail
> 
> Regards
> -Bharat
> 
>>
>>> +	octeontx2_wdt_settimeout(wdog_dev, wdog_dev->timeout);
>>> +	watchdog_stop_on_reboot(wdog_dev);
>>> +	watchdog_stop_on_unregister(wdog_dev);
>>> +
>>> +	err = devm_watchdog_register_device(dev, wdog_dev);
>>> +	if (err) {
>>> +		free_irq(irq, priv);
>>> +		return err;
>>> +	}
>>> +
>>> +	dev_info(dev, "Watchdog enabled (timeout=%d sec)\n", wdog_dev-
>>> timeout);
>>> +	return 0;
>>> +}
>>> +
>>> +static int octeontx2_wdt_remove(struct platform_device *pdev) {
>>> +	struct octeontx2_wdt_priv *priv = platform_get_drvdata(pdev);
>>> +
>>> +	if (priv->irq)
>>> +		free_irq(priv->irq, priv);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct of_device_id octeontx2_wdt_of_match[] = {
>>> +	{ .compatible = "marvell-octeontx2-wdt", },
>>> +	{ },
>>> +};
>>> +MODULE_DEVICE_TABLE(of, octeontx2_wdt_of_match);
>>> +
>>> +static struct platform_driver octeontx2_wdt_driver = {
>>> +	.driver = {
>>> +		.name = "octeontx2-wdt",
>>> +		.of_match_table = octeontx2_wdt_of_match,
>>> +	},
>>> +	.probe = octeontx2_wdt_probe,
>>> +	.remove = octeontx2_wdt_remove,
>>> +};
>>> +module_platform_driver(octeontx2_wdt_driver);
>>> +
>>> +MODULE_AUTHOR("Bharat Bhushan <bbhushan2@marvell.com>");
>>> +MODULE_DESCRIPTION("OcteonTX2 watchdog driver");
>>> --
>>> 2.17.1
>>>

