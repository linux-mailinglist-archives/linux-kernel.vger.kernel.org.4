Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDFC68001C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 16:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjA2P7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 10:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjA2P7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 10:59:50 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490CD15CA1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 07:59:49 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t7so646959wrp.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 07:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mF4/RgNWBVZCYtU/1f2NreRNL4Xyx/noHyWvkGcpot0=;
        b=v78Lh/DOQuyyvT8a0aBRj1Z38M7XR1iSHyzdwcx3zTCU7DJ1+0lXaewS84Zp6SShIy
         Xn0/m27YaMw6H5nfvcM36hmDCdIe4K42Qcm81u68he/XuOdEbXwf2/1PLPAU16i3tA7A
         dFTwC3JG7YbmsHTj7fbkQEmxlXDa1mgszVXQeSnE0Cdg/cHfTr2UOFzkYX60p45DovTg
         kggZ7oRSaUmNOpW0sPuRAWMBJ+i16tpz0amGIPeWU7RGM+AS65izraU07TaZpE9+fZoB
         MoYG8LWbkhPxqsgA4mMxXpPHakRUQteMArqn6wBrxQybadsV24it1q2eruFKwnCRiWaB
         pG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mF4/RgNWBVZCYtU/1f2NreRNL4Xyx/noHyWvkGcpot0=;
        b=dWN5Oi+AZuJBHLy6D5T9S0GH4mJjCCCkUMXK+Z9Wjrv+WKDEFRsLxAyNZPm2xe/ZdR
         o7a/qsdrMwXlD5qfHDHKOVt5dl03Dvp1YJFnnRCbSUq/y3TD1h/VOwVje9w/h8gf3cGb
         cc4AFl2Zq+EsfrbG04QkSUqvF9ieFuftR97CfHqE0bfS7IWFXcWBzLyM3LHSKOw5b/Qs
         zukKSZSMeMTepeC1WN6e6P1rE/f2tYchcj9tu10ESm8BA7m3k0WzUc5U/LScm9mHSM+k
         S0nqS4EriVR3WdbqxqiUQB6xXqyBb2fYVdkd7yMuMz8IK1UnEbKMh7c4NH7jI/wI66gE
         Dctg==
X-Gm-Message-State: AO0yUKUwaWc+MNwrBOXIqVU0xaYMYvvD8cvFmDLUKDYPDDMAeXBNsPvT
        JkUxPZUacjLjd17VZEfFzZqdgQ==
X-Google-Smtp-Source: AK7set8KGu4Ovfx8qfYoK4hp+/pmZA6BfNFj4GfR7W1m38iD5XQS75vHu6YXDBK7JQDt52K6T0jJeA==
X-Received: by 2002:adf:efcb:0:b0:2bf:ae3f:9911 with SMTP id i11-20020adfefcb000000b002bfae3f9911mr18212986wrp.12.1675007987835;
        Sun, 29 Jan 2023 07:59:47 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k4-20020a5d4284000000b00241fde8fe04sm9511888wrq.7.2023.01.29.07.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 07:59:47 -0800 (PST)
Message-ID: <ed16faa2-eb04-772d-8762-0c3f90fddbcb@linaro.org>
Date:   Sun, 29 Jan 2023 16:59:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] gpio: dt-bindings: add new property to wd,mbl-gpio
 bindings
Content-Language: en-US
To:     "Leonard, Niall" <Niall.Leonard@ncr.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230126-gpio-mmio-fix-v1-0-8a20ce0e8275@ncr.com>
 <20230126-gpio-mmio-fix-v1-1-8a20ce0e8275@ncr.com>
 <d4a70ab2-c5a2-2478-3fa9-c703c1619252@linaro.org>
 <MW5PR15MB52184F83BA524D9600B820F5FDCC9@MW5PR15MB5218.namprd15.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MW5PR15MB52184F83BA524D9600B820F5FDCC9@MW5PR15MB5218.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 12:39, Leonard, Niall wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: 26 January 2023 12:29
>> To: Leonard, Niall <Niall.Leonard@ncr.com>; Linus Walleij
>> <linus.walleij@linaro.org>; Bartosz Golaszewski <brgl@bgdev.pl>; Rob
>> Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>
>> Cc: linux-gpio@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH 1/3] gpio: dt-bindings: add new property to wd,mbl-gpio
>> bindings
>>
>> *External Message* - Use caution before opening links or attachments
>>
>> On 26/01/2023 11:17, Niall Leonard via B4 Submission Endpoint wrote:
>>> From: Niall Leonard <nl250060@ncr.com>
>>
>> Subject: missing "wd,mbl-gpio:" prefix.
>>
>> Subject: drop second/last, redundant "bindings". The "dt-bindings"
>> prefix is already stating that these are bindings.
>>
>>>
>>> Added optional "no-input" property
>>
>> Missing full stop.
>>
>>>
>>> Signed-off-by: Niall Leonard <nl250060@ncr.com>
>>> ---
>>>  Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
>>> b/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
>>> index 038c3a6a1f4d..9405f9dad522 100644
>>> --- a/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
>>> +++ b/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
>>> @@ -18,6 +18,7 @@ Required properties:
>>>
>>>  Optional properties:
>>>  	- no-output: GPIOs are read-only.
>>> +	- no-input: GPIOs are write-only. Read is via a shadow register.
>>
>> Why this property is needed? Why driver cannot always use shadow
>> register?
>>
> The shadow register is currently only used during the write operation. It is not available during the read operation. 

You just wrote above that reading is via shadow register, so how can it
not be available for reads? Again, why you cannot always read via shadow
register and need to make a property? You mean that for other GPIOs
there is no shadow register at all?

What changes between one board and another that justifies this property?

> That is essentially the change I have 
> submitted.

This does not answer me. I am asking why this change is justified in
terms of Devicetree.

> An alternative approach would have been to develop an entire new gpio driver similar to the 74xx driver, but I felt this approach was better.
> 
>> Anyway, please convert the bindings to DT schema first (see writing-schema
>> and example-schema).
>> Documentation/devicetree/bindings/writing-schema.rst
>>
> The bindings for this driver are duplicated in a few files even though they use the same driver.
> i.e. wd,mbl-gpio.txt, ni,169445-nand-gpio.txt, brcm,bcm6345-gpio.yaml

So your changes here affect several bindings but you adjust only one?
This won't work.

> I don't know why these multiple bindings exist. It would perhaps make sense to remove these duplicate binding documentation files and replace with a single one for "basic-mmio-gpio". I happened to pick ". wd,mbl-gpio.txt", but I could have just as easily chosen one of the other 2.

We usually keep same hardware in the same bindings. This might or might
not map to same Linux driver (drivers are independent). All this
hardware looks like having the same interface and same properties, so
having one binding makes sense.

Best regards,
Krzysztof

