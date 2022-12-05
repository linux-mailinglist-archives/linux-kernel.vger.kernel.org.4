Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3286430B9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiLESoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiLESoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:44:30 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD13138;
        Mon,  5 Dec 2022 10:44:29 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v8so17104573edi.3;
        Mon, 05 Dec 2022 10:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dlHbPYWA6349Ak4E81TJrxbwnHl0AOIrx3H6Nh0+tbA=;
        b=UyO2bJTpFVjMY/0tBBDoPGsNfZlMI2tQ6T9TO0Se8rWkVDepqwR5LDaw5qoE6k4Xl6
         RUrKk1f7VKjgKTMvPFJYmmJgoSqHZZhZNJFoYrZozl4LGj+6lPmbHwNhtbc0+PHGW/p4
         aOQbKkS73nEae24oBKL/BgSlhEjBni+mcX+cZt2k6B9khxwMiVgAP+dFzzT8gI41hGGZ
         FAMJ2c58IbkULB91g9pGA2CvSqvXhj+pViCw8xF7BsSO8wM5/KiG5f7ZIhG908Oz8k4k
         07BRzeIfxNZCBKvnV6Mp3VDOVNQdnbiJV8RRNUXpOjMFNuOUsSXB3jjZiHJ96+dsQSGJ
         5AuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dlHbPYWA6349Ak4E81TJrxbwnHl0AOIrx3H6Nh0+tbA=;
        b=EkvbhSvietVkW9Fn+uEZslFS3nyG0U+8ESxTx7LSpJTDYTqePqj3TpfkDCYD0rNiMb
         4OXfuYPAnbwyneoGHkJBuIcdZ+vDQ7v9elQ9RR2CTdtVHX4SR7NRTjh28p54gHsY4+UQ
         czeWyjZd5vwgL5r9t50QQxKmFiGb06SLBQJny2lPDvD+JoW9bj4wbG6eoMJtzz2UN8F2
         VsvqVvI3SmCeq3l/Kg3IGmTjCNJmvcM7m9txotOeUe2BUOMObmzzdblT6qg2fc9oyfWP
         Fx97JfzNkDlcW/OXRLKlRm+1OAZR4gxagSjb3tyIlUmX6lUVEnHwwz69cGV0+4K2wTQa
         ygTg==
X-Gm-Message-State: ANoB5pkJW2fZVnZ/OAvK68led2q7VUB+T3hh/fmc08xfJ7A6llI7CNxc
        /Gt720CTGQ212j7o5XTDBYA=
X-Google-Smtp-Source: AA0mqf6Ts/kNLWVJ/stt694d1GxznEbV+QnGfRt4nf9Wu50yMePzguJgq41aTGP0fEAvkbNYwvPaJw==
X-Received: by 2002:aa7:c046:0:b0:461:54f0:f7dc with SMTP id k6-20020aa7c046000000b0046154f0f7dcmr74844673edo.117.1670265868344;
        Mon, 05 Dec 2022 10:44:28 -0800 (PST)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id y20-20020a50eb94000000b004589da5e5cesm103090edr.41.2022.12.05.10.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 10:44:27 -0800 (PST)
Message-ID: <38c9aae4-0cae-a5a6-7c76-f23edf259dab@gmail.com>
Date:   Mon, 5 Dec 2022 19:44:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: leds: Mark label property as deprecated
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, Rob Herring <robh@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@dh-electronics.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <Y3y/S5COG7VPbsqL@duo.ucw.cz> <3f4c89a3-8955-ce41-ac2a-cee9b0ed5210@denx.de>
 <20221130191905.GA2631320-robh@kernel.org>
 <4043d693-7739-4709-8551-9f476031db70@denx.de>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <4043d693-7739-4709-8551-9f476031db70@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 12/2/22 00:41, Marek Vasut wrote:
> On 11/30/22 20:19, Rob Herring wrote:
>> On Fri, Nov 25, 2022 at 10:26:30PM +0100, Marek Vasut wrote:
>>> On 11/22/22 13:23, Pavel Machek wrote:
>>>> Hi!
>>>
>>> Hi,
>>>
>>>>> Mark the label property as deprecated as it is mentioned
>>>>> in the description.
>>>>
>>>> Lets do it the other way around. Functions (etc) don't really provide
>>>> good enough description of LED, and label is still needed.
>>>
>>> Can you please provide a clear explanation which property or approach 
>>> is the
>>> correct one for new DTs ?
>>>
>>> So far, the documentation states that "label" is deprecated, and users
>>> should replace it with "function" and "color".
>>
>> 'function' is what activity/operation the LED is associated with. It is
>> a fixed set of strings which s/w may use. It is a replacement for
>> 'linux,default-trigger'.
> 
> Isn't this 'function' more of a standardized replacement for 'label' ?

Yes it is. Introduction of function and color properties aimed at 
standardizing LED naming. Before there was only 'label' used for that,
with DT node name as fallback if 'label' property was not provided.
With introduction of 'function' and 'color' label was deprecated in
the sense that if the former two are present, they are used for
composing the LED name.

In LED documentation [0] people are encouraged to use definitions from
include/dt-bindings/leds/common.h to keep LED naming uniform.
It allows to avoid duplicates like "wlan" and "wifi".

> $ git grep LED_FUNCTION_ include/
> ...
> include/dt-bindings/leds/common.h:#define LED_FUNCTION_PLAYER5 "player-5"
> include/dt-bindings/leds/common.h:#define LED_FUNCTION_ACTIVITY "activity"
> include/dt-bindings/leds/common.h:#define LED_FUNCTION_ALARM "alarm"
> include/dt-bindings/leds/common.h:#define LED_FUNCTION_BACKLIGHT 
> "backlight"
> include/dt-bindings/leds/common.h:#define LED_FUNCTION_BLUETOOTH 
> "bluetooth"
> include/dt-bindings/leds/common.h:#define LED_FUNCTION_BOOT "boot"
> ...
> 
> Seems to me that ^ is closer to a "standardized" form of 'label' .
> 
> The LED subsystem does not infer any behavior of those LEDs based on 
> their 'function' property as far as I can tell, at least not in the way 
> 'linux,default-trigger' behaves.
> 
>> 'label' is what is printed next to the LED for a human to read. 'label'
>> can be anything and the OS shouldn't care what it is.
> 
> This part I understand. What is not clear to me is, why is 'label' being 
> un-deprecated.

It shouldn't be. It seems to be Pavel's ad-hoc decision.

> We newly have 'function', 'function-enumerator' and 'color' DT 
> properties for LEDs, which seem to be standardized forms of describing 
> what the LED is used for, which LED it is (if there are multiple), and 
> color of that LED. This was previously described in the 'label' 
> property, usually in free form of e.g. "beaglebone:green:usr2" .
> 
>> They serve 2 different purposes.
> 
> [...]

[0] Documentation/leds/leds-class.rst
-- 
Best regards,
Jacek Anaszewski
