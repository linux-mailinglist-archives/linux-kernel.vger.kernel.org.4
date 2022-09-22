Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5262B5E59BC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 05:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiIVDtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 23:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIVDt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 23:49:28 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E169AB07B;
        Wed, 21 Sep 2022 20:49:27 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z25so12619376lfr.2;
        Wed, 21 Sep 2022 20:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=hM/hPj2kErZVrLGH7HE2a6ky1BHulbnUraRG0cUBVMk=;
        b=TzoWMMC8U0DFHzke8NjSpVyLZdyZ5LwjDljBMbxDAWWE/irzfM4z96QbpxpEOH92DD
         aWuzk3z7b5dZh6tBpiujL18vVh7PSzeHlVHSxvCrjr8AlhTyWGnfn3tFJ4v2IOiB6HSk
         O7CtFfNIt9vPFjRtwFFyCgJkU+/3m06oCc/iqCi/7CXWV6bkox5c1HB6EAswtddVTi0t
         74gU2qwOAB4rAea8VLByL9YMHBAoZyn7i1yV0ju2wUTTmQmsQ/ot/mbNwHn08MaE+als
         DdV0M2GnH4/xZyjejzN/x589q/mkYzwLgpDr3so1+8k+Sqcw+aJrOqD+gFfogEwzHHEp
         axGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hM/hPj2kErZVrLGH7HE2a6ky1BHulbnUraRG0cUBVMk=;
        b=e1EeSHjnMf4RmTbChxMAnxV+I0pAQojF2SkXA8+i5JxCgTPkXHIjGTnBREUTiZYi55
         O2kxWCEn95r6sJKudG0vlthF7yEYXqiNucwTH7ZVB+VxmSOaUujltnWIGd3xf2BV8AzN
         9CXeaXQwjWBnktFSFa2qLnW/t65AlJPXxYzDail2btaipDCsNN5SZMMt19a0wKaxZLkm
         KpDOal/xXPyrif0yB2thM8QeyHqHFoi3S/Y9Ey7i3FpTU9F1zKafKyMULgQ4NNQXRNLs
         uqJjy8FMGwP0oFQPc8MFqsCQ5BEzapkNcMksAQ1gYadkPVfeFQJWATWv5BNR9mDi5Fzl
         wUvA==
X-Gm-Message-State: ACrzQf0V6wziVq45ewk/Y+lvYuRQIhJ+f0hL2IoQOdQz2NZS2kj+co7T
        +V4ziLMfgbCRrWkafn+HgzPmsJokyb4=
X-Google-Smtp-Source: AMsMyM6A5PIxfDn/wEagUwjlvZ9u62A05fHnju8MzATQqaH+iIG8Z/wN9qS4UI+u2lUMNrDAmAI+dQ==
X-Received: by 2002:a19:6909:0:b0:498:f6d4:c5b8 with SMTP id e9-20020a196909000000b00498f6d4c5b8mr502325lfc.647.1663818565321;
        Wed, 21 Sep 2022 20:49:25 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id o23-20020ac25e37000000b0048a83336343sm709743lfg.252.2022.09.21.20.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 20:49:24 -0700 (PDT)
Message-ID: <e3ccfc4e-e1b1-252f-cf46-7385dcd21dfd@gmail.com>
Date:   Thu, 22 Sep 2022 06:49:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH 3/5] dt-bindings: iio: Add KX022A accelerometer
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1663760018.git.mazziesaccount@gmail.com>
 <eb3edbb63c117f93e8ec534f50d8e3cf91ab3041.1663760018.git.mazziesaccount@gmail.com>
 <482c5a54-3d53-5760-fc8e-8aa3b9341707@linaro.org>
 <7582e9e9-4558-ac33-a0f8-cb4e69d0628e@fi.rohmeurope.com>
 <1e9b83f5-67a9-c5ee-3ede-b26a6bde2263@linaro.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <1e9b83f5-67a9-c5ee-3ede-b26a6bde2263@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Morning Krzysztof,

On 9/21/22 22:56, Krzysztof Kozlowski wrote:
> On 21/09/2022 21:30, Vaittinen, Matti wrote:
>> Hi dee Ho Krzysztof,
>>
>> Thanks for looking through this!
>>
>> On 9/21/22 22:11, Krzysztof Kozlowski wrote:
>>> On 21/09/2022 13:45, Matti Vaittinen wrote:
>>>> KX022A is a 3-axis Accelerometer from ROHM/Kionix. The senor features
>>>> include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
>>>> +
>>>> +maintainers:
>>>> +  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
>>
>> My own comment - switch the email to the gmail-one. Company mail is
>> unreliable at best..
>>
>>>> +
>>>> +description: |
>>>> +  KX022A is a 3-axis accelerometer supporting +/- 2G, 4G, 8G and 16G ranges,
>>>> +  output data-rates from 0.78Hz to 1600Hz and a hardware-fifo buffering.
>>>> +  KX022A can be accessed either via I2C or SPI.
>>>> +
>>>> +properties:
>>>> +  compatible: kionix,kx022a
>>>
>>> Missing const. I wonder how did it pass testing...
>>
>> I originally had
>> oneOf:
>>    items const ...
>> construct here as I had separate compatibles for *-spi and *-i2c. I am
>> unsure if I remembered to run the tests after dropping the extra
>> compatibles :| - Sorry! I'll fix this.
> 
> This should be just:
>    compatible:
>      const: foo,bar
> 
>>
>>>> +  io_vdd-supply: true
>>>
>>> No underscores, so io-vdd-supply
>>
>> The rationale behind the underscore is that the data-sheet uses terms
>> vdd and vdd_io (with underscore). I wanted to match the supply name to
>> what is used in the data-sheet. Not a big thing but I'd rather kept if
>> same as the data-sheet if the requirement of "no-underscores" is not
>> "hard". (If it is, then I'll drop the underscore).
> 
> Underscores trigger warnings at some dtc W level (W=1 or W=2) so they
> are not allowed.

Thanks for the explanation. I'll change this too.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
