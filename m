Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4C85F9BD8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiJJJ2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiJJJ2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:28:31 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBEB5D0C0;
        Mon, 10 Oct 2022 02:28:29 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id b2so15728591lfp.6;
        Mon, 10 Oct 2022 02:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kVIICcvhmRp4KVa6Ys8ayGQsI80PJHFAYPVcNOMoYo8=;
        b=czWmSnFPcPAt6+MrMBGjWrmSmUx0lkCN8xCMr/11Wm0o1dz1bUIAvtEPgUBrPaUBy9
         YIh21O5Y7kvpil9+ii3paGnlvUY/bkrv+DAja+TvZixNvo/q8Zo0NBVJIfmTZMrAJFzY
         4MFxhxQnsP74Bnra2xZHyGSv18wViAtANP6G/ZfiignfDFTEASSjLt3QraphVGEJH65b
         V6EmSCJhkUaZvpHxxDpgUaz9O02nNHpCkhUb3jvR75zrArFSsU/IBAhXlRTuPKiW6Sx/
         KH1O4hcQYd2HbajX3K87W8hWfwU6T5XBNCdr823yepAXH/tggMZXYkWhbHt5xbvMMXJB
         EV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kVIICcvhmRp4KVa6Ys8ayGQsI80PJHFAYPVcNOMoYo8=;
        b=Omy1GQ48jXjKim9b9giI92buyL6a+7QEAdwmCHhHPoObDxj1vYySj74MIL9SDpV+Gc
         7y1KzKT6XzJmlT2OfI+tjdWLqC4cv+LvNxKkyfvHEoZzi0eZAlEyHpZX0lzG90BIJ7b9
         CRwR9skWg7Xr6dd2SjSOnyspzJUBPLzYgKN/v2Nv3KcNXONF/jXXZgM/UbSgZULk5TCi
         ZXBX0kkmb8cu7NcWzD2grkjDjxQNml6A9xGZYf6xPyekOCQUCnDVY2D0rJJaI+zO9QL/
         aNjVEX6mFEJt057HqfQP9JztZNmmgXGH4BZWO1OZ0sV6mVaZU3rI+4ssarbxOQzLItIl
         Idmw==
X-Gm-Message-State: ACrzQf3v6LqAg6Wd5DGMKfKbeLoh9kWC/XAOlh54y4e132sI9mz/bDb+
        sfD1i8M+yeB2QgSZWH+STMs=
X-Google-Smtp-Source: AMsMyM76lZ/+hIs4e3jUZi3yZS/cm0JZPOXs+XhtvpVh0vrQdjRfsq+RuxXn9ClrPuHwlPYuN2pPoQ==
X-Received: by 2002:a05:6512:238e:b0:4a2:48d4:c13a with SMTP id c14-20020a056512238e00b004a248d4c13amr6943760lfv.391.1665394107288;
        Mon, 10 Oct 2022 02:28:27 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id o3-20020a056512050300b0049d0a98f73csm1348895lfb.154.2022.10.10.02.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 02:28:26 -0700 (PDT)
Message-ID: <a913e81e-3904-2e35-eaa7-89ae11652407@gmail.com>
Date:   Mon, 10 Oct 2022 12:28:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH v2 3/5] dt-bindings: iio: Add KX022A accelerometer
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
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
 <7bbc0c04-04a8-f2c6-0436-3be0fc1013c7@gmail.com>
 <20221009132711.16055354@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20221009132711.16055354@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/22 15:27, Jonathan Cameron wrote:
> On Thu, 6 Oct 2022 18:32:22 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Hi dee Ho Krzysztof,
>>
>> On 10/6/22 18:23, Krzysztof Kozlowski wrote:
>>> On 06/10/2022 16:37, Matti Vaittinen wrote:
>>>> KX022A is a 3-axis Accelerometer from ROHM/Kionix. The sensor features
>>>> include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
>>>> tap/motion detection, wake-up & back-to-sleep events, four acceleration
>>>> ranges (2, 4, 8 and 16g) and probably some other cool features.
>>>>   
>>>
>>> Thank you for your patch. There is something to discuss/improve.
>>>    
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: kionix,kx022a
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  interrupts:
>>>> +    minItems: 1
>>>> +    maxItems: 2
>>>> +
>>>> +  interrupt-names:
>>>> +    minItems: 1
>>>> +    maxItems: 2
>>>> +    items:
>>>> +      enum:
>>>> +        - INT1
>>>> +        - INT2
>>>
>>> This allows any order, which I assume was your intention.
>>
>> Yes. I don't see real need to restrict ordering - besides, with my
>> yaml/schema skills it'd took eternity to find corrct example(s) ;)
>>
>> My intention is that the user can give either one of these - or both.
>> Order needs naturally to match the order of IRQs - but this we can't know.
>>
>>> However maybe
>>> at least fix it a bit like:
>>> minItems: 1
>>> items:
>>>     - enum: [ int1, int2]
>>>     - const: int2
>>
>> If you say so XD
>> I can fix this for v3 :)
> If my limited understanding is correct, one advantage of this restriction
> is that we can't have
> 
> "INT1", "INT1"
> though that may be prevented elsewhere...
> 
> There is no loss of useful flexibility in how Krzysztof suggested doing it
> so looks like a good suggestion to me.
Thanks Krzysztof and Jonathan :) I'll use Krzysztof's suggestion for the 
v3.

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

