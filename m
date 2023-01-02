Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A8865B1D6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 13:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjABMLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 07:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjABMLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:11:04 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D028624A
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 04:11:03 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id b88so32411990edf.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 04:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=11NdqoQWvtMGVBH5+YEPkXuBY0lT6IFLrzJv1n1sPnE=;
        b=AO3QSnKZUCNrin6KCkWVd8Jr2r7Nu/jya+MCUKVa1tD+DS3R5MfhW3456aHMhQtkDQ
         B7Qn/2IVuIJOUadjcAm8fF1Ye6QqGskK967CV0XcVe56pKe7XiA+p9Mo9+D/mlez+Quc
         +cszJn/avxfC1ERzeey9Ry1upOtY+I5nfBKehunVnny20UhZ6Dit318Yw4HvTnWJIMsP
         2PurGEapYYoEb3eNgQ/qUL6Dxv2KyAKUuNcEvFG0cngKUM2mx17twk0utgOTU5fiVeZJ
         a9ItXG+gjM/m7D6zdNyoFolrt+btLiuv6hS4sSQOqBeusOP7z5V80gEJPjkq/KykCMRB
         jC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=11NdqoQWvtMGVBH5+YEPkXuBY0lT6IFLrzJv1n1sPnE=;
        b=2ruY74yMzs8oRArLqC9pVQsATw3JsIto0MRBqfaKI8UEQ/AmZBFBiFIjPxu9WRBwyK
         skDdw3IFsl8bn+MoYWBri02De//A/Oan+Vi7FjMKC2ltAIM5f7acAIOp5nExrQb4vtg9
         ov1iLNn69Y0Y434PUFvg7gB5hcU1m6Vc+JtbCsn3VMGd3nJwYRg2xMofxS5hKGzeQ69D
         yoFez/3LTgZwHcfFJp7TKE+wfq00owuMeIImujWkewSpdn6ra/2vcFTtvR7IkGQwYKGL
         Lkzc6TySsxJxeFVXZX2sl7bS+LrCkDSfU0uXzWZ4l3Yl0uJ+dMh3W5hncRFjCZHKlxPX
         6MPA==
X-Gm-Message-State: AFqh2koPjxgHAz3RFkEnmbG/7xQsU05PjFtspj8rRg5Er0/IaCMNlzMX
        WAOeKKXW1KzcOIG6sLWndf+5mA==
X-Google-Smtp-Source: AMrXdXudBKoxijSiMeNTK/zRwLLjFRAdMIjw+wuQUh3XfFI8ZV6BWdECXCN8vk4IEYwfjIK8Q9wN0g==
X-Received: by 2002:a05:6402:1298:b0:461:75f1:9254 with SMTP id w24-20020a056402129800b0046175f19254mr36983003edv.2.1672661461828;
        Mon, 02 Jan 2023 04:11:01 -0800 (PST)
Received: from [192.168.0.104] ([82.77.81.242])
        by smtp.gmail.com with ESMTPSA id bc2-20020a056402204200b00467481df198sm12579597edb.48.2023.01.02.04.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 04:11:01 -0800 (PST)
Message-ID: <1ee9cf77-1ca0-6e4e-ba7d-896838bd71de@linaro.org>
Date:   Mon, 2 Jan 2023 14:11:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/8] spi: dt-bindings: Introduce spi-cs-setup-ns property
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     Mark Brown <broonie@kernel.org>, tudor.ambarus@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        nicolas.ferre@microchip.com, robh+dt@kernel.org
References: <20221117105249.115649-2-tudor.ambarus@microchip.com>
 <20221118141458.954646-1-michael@walle.cc> <Y3elIdM3Xz1H4kKk@sirena.org.uk>
 <28da9e33-57e8-7ac1-7e6c-13c297a945d6@gmail.com>
 <a2f58ad34ba74ff135852bc1e24da4d6@walle.cc>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <a2f58ad34ba74ff135852bc1e24da4d6@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02.01.2023 13:48, Michael Walle wrote:
> Hi,

Hi,

> 
> Am 2023-01-02 10:37, schrieb Tudor Ambarus:
>> Hi,
>>
>> On 18.11.2022 17:30, Mark Brown wrote:
>>> On Fri, Nov 18, 2022 at 03:14:58PM +0100, Michael Walle wrote:
>>>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>>>
>>>>> +  spi-cs-setup-ns:
>>>>> +    description:
>>>>> +      Delay in nanosecods to be introduced by the controller after 
>>>>> CS is
>>>>> +      asserted.
>>>
>>>> Does this need a type as the spi-cs-setup-ns is apparently just 
>>>> 16bit? At
>>>> least the driver uses it that way.
>>>
>>>> But IMHO this should just be a normal uint32 value to be consistent 
>>>> with
>>>> all the other properties. Also the max value with 16bit will be 'just'
>>>> 65us.
>>>
>>> Making it 32 bit does seem safer.  I've applied the series
>>
>> Thanks. There are few implications to consider before making this prop a
>> u32, and I'd like to check them with you.
>>
>> struct spi_delay will have to be updated to have a u32 value, now it's a
>> u16. This means that we'll have to update spi_delay_to_ns() to either
>> return a s64 or to add a u64 *delay parameter to the function so that we
>> can still handle the conversions from usecs and the error codes in the
>> SPI_DELAY_UNIT_SCK case. Then all its callers have to be updated to
>> consider the u64 delay.
> 
> I was talking about the device tree property. Even if the driver continue
> to use just 16bit, the DT property could be 32bit IMHO.

but then you'll have an implicit cast to u16 at:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi.c#n2314
which will make the u32 dt prop misleading.

> 
> At the moment, the schema says its 32bit (if I'm not mistaken, because
> it doesn't have a type), but the driver will parse the property as
> 16bit and your device tree also has this /bits/ thingy. So regardless
> if the driver is using 16bit or 32bit for the value, there seems to be
> a discrepancy between the schema and the devicetree (and driver).

okay, thanks for pointing it out. Let's decide how we fix this.

> 
> All other properties are just the regular 32bit values, thus I was
> suggesting to change the DT property to 32bit.

If we want to change the dt prop to 32bit I think we should also handle
the parsed value as u32, not as u16.
