Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B97160840E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 06:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJVEAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 00:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJVEA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 00:00:29 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F3CB7F72;
        Fri, 21 Oct 2022 21:00:25 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id v40-20020a056830092800b00661e37421c2so2953038ott.3;
        Fri, 21 Oct 2022 21:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=20L4EctgpcreWPnaAcAxm8gZbB5uiC3QiKEacbqhxTM=;
        b=o7EAYMMwP6ZaxHfdBsXv8JJkEPe1Rh/oyzCpP1GU4U7zcRQpNTjgqw5uvtJ9vah98l
         2145rhiD/FhUTiyybAHbvrP1yVNU4pJKR4/ULEstdmrRFHUzBHFGrYx1Uh9kuluMnzgK
         EWnVCtQv5QIOA01DxDXnK/nkArR2sbnCmW43m/93qQ8TSE3pCDvSy2cdP04U51xVfKjh
         PTUTAdKiqpvwqO9lYXDiL6O+deBD3Jh1/Vo1WVxBXWrkxfhwUDvklRN//PL31R7jH1XR
         BnL8a84pR4JUgNzpgxQNMRimKh+DvhnJBRb7XZRCldd3qhwEz/GtqwVSpcl7W1485Tzu
         7vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20L4EctgpcreWPnaAcAxm8gZbB5uiC3QiKEacbqhxTM=;
        b=4//uIFsRNUtL+2hOJTgCJP+VL+DsZKw3wsXfDm3ljR4KoEAgyrwZA4YuIE5AMbsF4e
         GiFrXJ0fFLM33h47KhZ4V0U1bQcJIPF0/8zC8rA/FRHrpCTtx7Jsknw1JD95s14tIFAx
         Fm1nd03UhepRnDGPBOtfrkqsdjT2VO/tQzP7clAaEuznhWzxaGnHllmMjJuPKiFEFi6g
         i+U5dXZCcCcYGKjDD9OCVel6eewGzZRmR9jndAyCWBaUlQ2EbBr6ZxaHTQF5XnZMLl8U
         PIW9FwHIxQbh/8JorlTuc/74VVS8rnX/OcFr7o0QIGhD6BG3cTFH+pm8eB/kw3Redu2g
         L99Q==
X-Gm-Message-State: ACrzQf01QHCVyNdSrcaXCB+QUWXxmMr/opyHlpJE6t3i7CaDhkQ81S42
        oFsxP8D4uGlvPZiaRmSus61HKVItNpc=
X-Google-Smtp-Source: AMsMyM4a4vfPiXS4ensjO2jmNJL39Q1r0EY2hIwVvjzV2EXjqH84qsTv5jiTjT5zBf8bmYFsnlhJHg==
X-Received: by 2002:a9d:3642:0:b0:655:f25f:be55 with SMTP id w60-20020a9d3642000000b00655f25fbe55mr11516791otb.13.1666411224826;
        Fri, 21 Oct 2022 21:00:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y3-20020a056870418300b0011f400edb17sm11187297oac.4.2022.10.21.21.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 21:00:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <00d859b0-f766-4322-fe58-095d4f84e954@roeck-us.net>
Date:   Fri, 21 Oct 2022 21:00:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] watchdog: aspeed: Add pre-timeout interrupt support
Content-Language: en-US
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-watchdog@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, wim@linux-watchdog.org,
        andrew@aj.id.au, joel@jms.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
References: <20221021151559.781983-1-eajames@linux.ibm.com>
 <20221021151559.781983-2-eajames@linux.ibm.com>
 <20221021165650.GA1888515@roeck-us.net>
 <56929483-56d1-f2b8-9b7e-3fd6388e5f87@linux.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <56929483-56d1-f2b8-9b7e-3fd6388e5f87@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 12:39, Eddie James wrote:
> 
> On 10/21/22 11:56, Guenter Roeck wrote:
>> On Fri, Oct 21, 2022 at 10:15:58AM -0500, Eddie James wrote:
>>> Enable the pre-timeout interrupt if requested by device property.
>>>
>> I am not inclined to accept this patch without detailed explanation.
>> Why would it make sense and/or be desirable to completely bypass the
>> watchdog core with this pretimeout support ?
> 
> 
> Sorry, I should add more detail.
> 
> It doesn't necessarily bypass the watchdog core. It can, if you specify reset-type="none". But if not, the watchdog will still fire at the appropriate time.
> 
> The purpose is to get a stack dump from a kernel panic rather than a hard reset from the watchdog. The interrupt will fire a certain number of microseconds (configurable by dts property) before the watchdog does. The interrupt handler then panics, and all the CPU stacks are dumped, so hopefully you can catch where another processor was stuck.
> 
> 
> I can submit v2 with this information in the commit message and/or comments.
> 

You did not answer the question why you do not use the pretimeout functionality
supported by the watchdog core.

Guenter

> Thanks,
> 
> Eddie
> 
> 
>>
>> Thanks,
>> Guenter
>>
>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>>> ---
>>>   drivers/watchdog/aspeed_wdt.c | 53 +++++++++++++++++++++++++++++++++--
>>>   1 file changed, 51 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
>>> index 0cff2adfbfc9..8e12181a827e 100644
>>> --- a/drivers/watchdog/aspeed_wdt.c
>>> +++ b/drivers/watchdog/aspeed_wdt.c
>>> @@ -5,11 +5,14 @@
>>>    * Joel Stanley <joel@jms.id.au>
>>>    */
>>> +#include <linux/bits.h>
>>>   #include <linux/delay.h>
>>> +#include <linux/interrupt.h>
>>>   #include <linux/io.h>
>>>   #include <linux/kernel.h>
>>>   #include <linux/module.h>
>>>   #include <linux/of.h>
>>> +#include <linux/of_irq.h>
>>>   #include <linux/platform_device.h>
>>>   #include <linux/watchdog.h>
>>> @@ -26,20 +29,32 @@ struct aspeed_wdt {
>>>   struct aspeed_wdt_config {
>>>       u32 ext_pulse_width_mask;
>>> +    u32 irq_shift;
>>> +    u32 irq_mask;
>>>   };
>>>   static const struct aspeed_wdt_config ast2400_config = {
>>>       .ext_pulse_width_mask = 0xff,
>>> +    .irq_shift = 0,
>>> +    .irq_mask = 0,
>>>   };
>>>   static const struct aspeed_wdt_config ast2500_config = {
>>>       .ext_pulse_width_mask = 0xfffff,
>>> +    .irq_shift = 12,
>>> +    .irq_mask = GENMASK(31, 12),
>>> +};
>>> +
>>> +static const struct aspeed_wdt_config ast2600_config = {
>>> +    .ext_pulse_width_mask = 0xfffff,
>>> +    .irq_shift = 0,
>>> +    .irq_mask = GENMASK(31, 10),
>>>   };
>>>   static const struct of_device_id aspeed_wdt_of_table[] = {
>>>       { .compatible = "aspeed,ast2400-wdt", .data = &ast2400_config },
>>>       { .compatible = "aspeed,ast2500-wdt", .data = &ast2500_config },
>>> -    { .compatible = "aspeed,ast2600-wdt", .data = &ast2500_config },
>>> +    { .compatible = "aspeed,ast2600-wdt", .data = &ast2600_config },
>>>       { },
>>>   };
>>>   MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>>> @@ -58,6 +73,7 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>>>   #define   WDT_CTRL_RESET_SYSTEM        BIT(1)
>>>   #define   WDT_CTRL_ENABLE        BIT(0)
>>>   #define WDT_TIMEOUT_STATUS    0x10
>>> +#define   WDT_TIMEOUT_STATUS_IRQ        BIT(2)
>>>   #define   WDT_TIMEOUT_STATUS_BOOT_SECONDARY    BIT(1)
>>>   #define WDT_CLEAR_TIMEOUT_STATUS    0x14
>>>   #define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION    BIT(0)
>>> @@ -243,6 +259,17 @@ static const struct watchdog_info aspeed_wdt_info = {
>>>       .identity    = KBUILD_MODNAME,
>>>   };
>>> +static irqreturn_t aspeed_wdt_irq(int irq, void *arg)
>>> +{
>>> +    struct aspeed_wdt *wdt = arg;
>>> +    u32 status = readl(wdt->base + WDT_TIMEOUT_STATUS);
>>> +
>>> +    if (status & WDT_TIMEOUT_STATUS_IRQ)
>>> +        panic("Watchdog pre-timeout IRQ");
>>> +
>>> +    return IRQ_NONE;
>>> +}
>>> +
>>>   static int aspeed_wdt_probe(struct platform_device *pdev)
>>>   {
>>>       struct device *dev = &pdev->dev;
>>> @@ -253,6 +280,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>>>       const char *reset_type;
>>>       u32 duration;
>>>       u32 status;
>>> +    u32 timeout = 0;
>>>       int ret;
>>>       wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>>> @@ -291,6 +319,27 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>>>       if (of_device_is_compatible(np, "aspeed,ast2400-wdt"))
>>>           wdt->ctrl = WDT_CTRL_1MHZ_CLK;
>>> +    if (config->irq_mask) {
>>> +        if (!of_property_read_u32(np, "aspeed,pre-timeout-irq-us", &timeout) && timeout) {
>>> +            int irq =  platform_get_irq(pdev, 0);
>>> +
>>> +            if (irq < 0) {
>>> +                dev_warn(dev, "Couldn't find IRQ: %d\n", irq);
>>> +                timeout = 0;
>>> +            } else {
>>> +                ret = devm_request_irq(dev, irq, aspeed_wdt_irq, IRQF_SHARED,
>>> +                               dev_name(dev), wdt);
>>> +                if (ret) {
>>> +                    dev_warn(dev, "Couldn't request IRQ:%d\n", ret);
>>> +                    timeout = 0;
>>> +                } else {
>>> +                    wdt->ctrl |= ((timeout << config->irq_shift) &
>>> +                              config->irq_mask) | WDT_CTRL_WDT_INTR;
>>> +                }
>>> +            }
>>> +        }
>>> +    }
>>> +
>>>       /*
>>>        * Control reset on a per-device basis to ensure the
>>>        * host is not affected by a BMC reboot
>>> @@ -308,7 +357,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>>>           else if (!strcmp(reset_type, "system"))
>>>               wdt->ctrl |= WDT_CTRL_RESET_MODE_FULL_CHIP |
>>>                        WDT_CTRL_RESET_SYSTEM;
>>> -        else if (strcmp(reset_type, "none"))
>>> +        else if (strcmp(reset_type, "none") && !timeout)
>>>               return -EINVAL;
>>>       }
>>>       if (of_property_read_bool(np, "aspeed,external-signal"))
>>> -- 
>>> 2.31.1
>>>

