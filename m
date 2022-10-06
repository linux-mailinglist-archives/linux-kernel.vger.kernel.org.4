Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BC25F6AA6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiJFPcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiJFPc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:32:28 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D026CA598C;
        Thu,  6 Oct 2022 08:32:27 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id r14so3287770lfm.2;
        Thu, 06 Oct 2022 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date;
        bh=PSnridKMFXX1oHGe8dg+gb0bRu2roWI84V1eijz8eLg=;
        b=Do6RRGKJ0zGQppy6Mcem1G4C9hsJ3j71Us9VPtWZnSCFiFmDLfWxiF7S9Za+jssdAA
         NLo0eE9a72yRyC22N4Q+M1hIBoAWwGBM6PQoMweuymrCQBfMLHRB3eTQcKynCSeMMHbO
         3l5eurRXyqE9+fmYFyExiBfqYBjxinDcbInXwcXFjs7XvO1RwEA7faE4TTegHN1NzDGV
         ileioX25/9kxe65DuHjFJ51ZAk1174U5pF7ijRxjkAtHV4cYoPH0sHLhyUkm1nRif9X0
         kL0EvDKtssKvmQEyds/f/Z9JVw+x4zSKXGfzK2F3TUa7cwhfDv1Do9PCfZWLxILxOI9l
         Hh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PSnridKMFXX1oHGe8dg+gb0bRu2roWI84V1eijz8eLg=;
        b=mq1N6t7QMuLgR6yfKK7kfoLQ2oHI+BWHWZpbdwIXPz5R4WTHupxWeuBUCHu56+dJx/
         Hmv4BuE7hTIqqUzwY9fwp/CJplzAMGMHHdNkneBLp/I2GGxGx0fGZ7hUiBrjnLMnjHN1
         IY9v4kOiJjVQr0BNlSijY2lw9IrX5Gv8EEyqaXHh9zynDuKEgwtA+M5iL+HEi0VJZOri
         fAV3cMtFNjM7OIbowW4qC6Ws0wN/oYEU/dpPA6d4+cO7rgksV01LaqhNv4SUhV0pwwie
         UextS+yOjj1PQhGD6P1YoD749OKENOLKayCHCKWIBRtS7EWh2fZwXgNf0rPjMYQLq3E0
         Xb4g==
X-Gm-Message-State: ACrzQf25RxLhoF+UIGnmILlZgIu8kid+7zmaGfWcIUD+7hDc6PxEiU9U
        JkUQhRzbz27HaB2wYaQ0Gzw=
X-Google-Smtp-Source: AMsMyM5EFh6FHQ971Y6DxjG1i1/HXfuJ4x9s+wR245sRDEOF2gfiEw/XgAwM9/FRsbmBp0T1wjzQ7Q==
X-Received: by 2002:a05:6512:2314:b0:4a2:6c4a:4fb9 with SMTP id o20-20020a056512231400b004a26c4a4fb9mr216012lfu.482.1665070346182;
        Thu, 06 Oct 2022 08:32:26 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id g17-20020a2ea4b1000000b00267232d0652sm1912189ljm.46.2022.10.06.08.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 08:32:25 -0700 (PDT)
Message-ID: <7bbc0c04-04a8-f2c6-0436-3be0fc1013c7@gmail.com>
Date:   Thu, 6 Oct 2022 18:32:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1665066397.git.mazziesaccount@gmail.com>
 <80fa42040f385eb47f4f3c71b9b02f643a643e38.1665066397.git.mazziesaccount@gmail.com>
 <fc7c064f-074a-e66a-07b3-541f2ad56804@linaro.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [RFC PATCH v2 3/5] dt-bindings: iio: Add KX022A accelerometer
In-Reply-To: <fc7c064f-074a-e66a-07b3-541f2ad56804@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi dee Ho Krzysztof,

On 10/6/22 18:23, Krzysztof Kozlowski wrote:
> On 06/10/2022 16:37, Matti Vaittinen wrote:
>> KX022A is a 3-axis Accelerometer from ROHM/Kionix. The sensor features
>> include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
>> tap/motion detection, wake-up & back-to-sleep events, four acceleration
>> ranges (2, 4, 8 and 16g) and probably some other cool features.
>>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> +
>> +properties:
>> +  compatible:
>> +    const: kionix,kx022a
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  interrupt-names:
>> +    minItems: 1
>> +    maxItems: 2
>> +    items:
>> +      enum:
>> +        - INT1
>> +        - INT2
> 
> This allows any order, which I assume was your intention.

Yes. I don't see real need to restrict ordering - besides, with my 
yaml/schema skills it'd took eternity to find corrct example(s) ;)

My intention is that the user can give either one of these - or both. 
Order needs naturally to match the order of IRQs - but this we can't know.

> However maybe
> at least fix it a bit like:
> minItems: 1
> items:
>    - enum: [ int1, int2]
>    - const: int2

If you say so XD
I can fix this for v3 :)

> 
> OTOH, the names are not really descriptive. Do they match pin names?
> 

Yes. They match to pin names used in the data-sheet.


Yours
	-- Matti

Ps. I've heard this year has not been that good with the mushrooms here 
in Finland ;)

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

