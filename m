Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85635628835
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbiKNSUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbiKNSUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:20:21 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2018BA461
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:20:20 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id l6so11114378pjj.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OH7OygSYbTRWmJGgVVpb8CLHwpB+vsrnDnYlpEZZpPA=;
        b=V4QDFej6mjBxZuavrIW8lfD4hvJvdfBR46+Rd6BQo2ytrfca2xvzij9U5NfyGk6t2z
         oRA5UccYIDFft2LIo5HbcMqPJ/2rGXd1KDnJqXRhGoDO0VoIJq/mwuYF0+6MX9W23Onp
         17mQLeu9xfZFJgERkIDe21ozI1YzNBm9UgzPXSmJ3Oly6eQNbSdRJVu+rA5f3QfV/Ei0
         zuPAzyIWe9MkM3vTgcx04jS0VIWt5SUc6WHDxrdvZuSGBN1e9s5UhPWGjK50+s8ykl/L
         Yn9LnGhx7zr+4KVOvpAiCjX/YVgq42dIXCmyp44Fyneq6U7FCRnpbhhtWss/jL4QzrTm
         eC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OH7OygSYbTRWmJGgVVpb8CLHwpB+vsrnDnYlpEZZpPA=;
        b=jEjtmnvAd0XO1fq4iowyC3K7fqCKQMkM12A5QEeAMdi+YMz6xnRL6AFKkgs/jdWF4h
         qDs+YjNDcx77nWoXELt5yHTarBbhxDVBR9QzKnSjGHd9JVLVwsGAaV7lu0mXLuWnhz5q
         +cvBQ+NqREGLi8+ggYrPnqGQHOSbmrMwgvLnOngwYZ+h6swincJwVG9emQLp0gVQhzyd
         oJMQgEr+ohZpbmCiXsJBkUl2dpec85dz4448CrHqKrd8Q4rgMdw1+5h2R3kw7Bxk1e5Y
         QpTxMQ80JK0NN5QWMMYKV5k7t8zUDE/h/k9wclOkvpnhCh9tDQm4fQho0XKoLMoAnUPn
         tB8Q==
X-Gm-Message-State: ANoB5pl95lmGYdtq67Uo9u3fXrVLE64KsLPXw5T3HTLCVqXRXC+peqbR
        /cpHAPK7xkB7C5ABIrg2LrKrpg==
X-Google-Smtp-Source: AA0mqf7z2pl/BadCtzO73L8mLM73fuRDqlfASOwtHaRaws1kRzCXrNYV3GqobrcgElfDThCGx5QqyA==
X-Received: by 2002:a17:90a:ee45:b0:213:d2c:1923 with SMTP id bu5-20020a17090aee4500b002130d2c1923mr15032547pjb.234.1668450019575;
        Mon, 14 Nov 2022 10:20:19 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:da6a:d4a2:1253:adfc:370? ([2405:201:d02f:da6a:d4a2:1253:adfc:370])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b00188767268ddsm7851377plk.151.2022.11.14.10.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 10:20:18 -0800 (PST)
Message-ID: <6f2880d6-04e6-867a-f61b-30a65554e280@9elements.com>
Date:   Mon, 14 Nov 2022 23:50:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v8 2/2] mfd: max597x: Add support for MAX5970 and MAX5978
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
References: <20221103213425.2474772-1-Naresh.Solanki@9elements.com>
 <20221103213425.2474772-3-Naresh.Solanki@9elements.com>
 <Y2jRm2J4tvK5ET1e@google.com>
 <f5e5a2d3-d985-f351-78e0-8a479a6d896a@9elements.com>
 <Y3IGR887iuyP2SoL@google.com>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <Y3IGR887iuyP2SoL@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 14-11-2022 02:41 pm, Lee Jones wrote:
> On Fri, 11 Nov 2022, Naresh Solanki wrote:
>> On 07-11-2022 03:06 pm, Lee Jones wrote:
>>> On Thu, 03 Nov 2022, Naresh Solanki wrote:
>>>
>>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>>
>>>> Implement a regulator driver with IRQ support for fault management.
>>>
>>> This is not a "regulator driver".
>>>
>>>> Written against documentation [1] and [2] and tested on real hardware.
>>>>
>>>> Every channel has its own regulator supplies nammed 'vss1-supply' and
>>>> 'vss2-supply'. The regulator supply is used to determine the output
>>>> voltage, as the smart switch provides no output regulation.
>>>> The driver requires the 'shunt-resistor-micro-ohms' property to be
>>>> present in Device Tree to properly calculate current related
>>>> values.
>>>>
>>>> Datasheet links:
>>>> 1: https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
>>>> 2: https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
>>>>
>>>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> 
> [...]
> 
Patrick & Marcello worked on the patch. I'm upstreaming it. Will update 
it as:
Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Co-Developed-by: Marcello Sylvester Bauer <sylv@sylv.io>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

ok?

>>>> +static const struct of_device_id max597x_of_match[] = {
>>>> +	{ .compatible = "maxim,max5970", .data = (void *)MAX597x_TYPE_MAX5970 },
>>>> +	{ .compatible = "maxim,max5978", .data = (void *)MAX597x_TYPE_MAX5978 },
>>>
>>> Where is .data used?
>> The .data isn't used.
> 
> Then why add it?
Yes. Will remove that in next version.
> 
> [...]
> 
>>>> +#include <linux/device.h>
>>>> +#include <linux/regmap.h>
>>>> +
>>>> +/* Number of switch based on chip variant */
>>>
>>> This comment is superfluous.
>> You mean this comment should be removed ?
> 
> I do.
Sure will remove.
> 
>>>> +#define MAX5970_NUM_SWITCHES 2
>>>> +#define MAX5978_NUM_SWITCHES 1
>>>> +/* Both chip variant have 4 indication LEDs used by LED cell */
>>>
>>> Here too I think.
>>>
>>>> +#define MAX597X_NUM_LEDS     4
>>>> +
>>>> +enum max597x_chip_type {
>>>> +	MAX597x_TYPE_MAX5978 = 1,
>>>
>>> Why 1?
>> MAX5978 & single power switch wheres MAX5970 has two.
> 
> That's not what this enum means.
> 
> You are just describing the type to be matched on.
> 
> The value should be arbitrary, no?
Yes you are right. And thats how its being used.
Setting the first enum value to 1 was to avoid zero.
> 
> [...]
> 
>>>> +#define  OC_STATUS_WARN(ch)				BIT(ch)
>>>> +
>>>> +#define MAX5970_REG_CHXEN				0x3b
>>>> +#define  CHXEN(ch)						(3 << (ch * 2))
>>>> +
>>>> +#define MAX5970_REG_LED_FLASH			0x43
>>>
>>> Do these all need to be shared?
>>>
>>> Or can they be isolated into, say, the Regulator driver?
>>>
>> Shared reg.
> 
> Where else are they used?
> 
The respective cell regulator/iio & led driver.

Regards,
Naresh
