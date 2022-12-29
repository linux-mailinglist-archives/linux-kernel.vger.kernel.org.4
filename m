Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840F2658F21
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 17:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiL2Qjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 11:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiL2Qjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:39:36 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCC6DFBB
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:39:34 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id f34so28189589lfv.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=txhwA/ZUpFbIFup9wIuYZkJbnGVjKJ2jOcyXprhCmPo=;
        b=dciD/Ycio+250FM8/AnXaPz7gWoiQnZOdqmXMoWmcp4LN7w7crY0b6I2jusEBfZXtb
         ktw4vWgyJ5jgYO9TR6pKjLXzCcMFVGX1Ss5Y0tQvijj2VkDHekM0sIXS0NddjGSEuwEn
         06nXyfTFWuMz94aVPy4D2FnFXUQY+k7dl7x9wbEjgrV7klfIGDflVhZQ9jBTK33he120
         yUlrzN98WHnDpN/FwIIwwnBIk7LV2RjS3VAVYYf7JsleInUKpbjWIUn8cub29ioBxett
         qlcnodjnJTOj3GDtc7dhrYVnQfreLB3buLsnAfcsqcykkTK9jOdnu0KyRslmdiXdApq+
         14Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=txhwA/ZUpFbIFup9wIuYZkJbnGVjKJ2jOcyXprhCmPo=;
        b=1Wc81C5lFiOqdWDkj4W2sqXc0HV7IpUiwG2ZOBSE7v2oU4gJ4BXoXhuopWv4NCJwYi
         4oTe21jIyWPkcw43Z7H5UwAHKP2XnJKHeTEDodMbwwlazsxpz/jecfkDqwLm4nArM4+c
         XqsJDL8c9XXBfp4ivN3PNDCtfJu8EdN1KffM6Fyy3La7e8uv8hLbp3DErz/CVAfSUPyN
         zJp3qqk6gR3t+EqIdRmVRCUyqhdZBskCDQqQl0Bdu0k/0qeoStljJ3DqkwLrVxbhs9St
         l56hsXgH01VKK/aUBov0DxWJl7BGUTvu6u82tS8Oq544whOxOzG+9FhJUwU00dRNEdO+
         5Wwg==
X-Gm-Message-State: AFqh2krGyOeM5lsnqKxyqEZRwzIbti3vtLRF5V5i8LrBXbp2TT8FMCq0
        OxtX9oq3t7Lszj1NKWibPKzskg==
X-Google-Smtp-Source: AMrXdXvRaSHvaRVe+JHJaQXcOjSgEqHn7LvdZ9o/fNdzXysgRNxJg4InJ4AXNIgDCb7l0sIfT68vxA==
X-Received: by 2002:a05:6512:529:b0:4cb:1438:12d6 with SMTP id o9-20020a056512052900b004cb143812d6mr2499958lfc.8.1672331972997;
        Thu, 29 Dec 2022 08:39:32 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c8-20020a056512324800b00499aefcf68esm3141911lfr.292.2022.12.29.08.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 08:39:32 -0800 (PST)
Message-ID: <105cae8a-ba03-ea60-70f2-8a307a26ad14@linaro.org>
Date:   Thu, 29 Dec 2022 17:39:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/3] dt-bindings: hwmon: Add bindings for max31732
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Sinan Divarci <Sinan.Divarci@analog.com>, jdelvare@suse.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221214142206.13288-1-Sinan.Divarci@analog.com>
 <20221214142206.13288-4-Sinan.Divarci@analog.com>
 <386e3717-a063-a2ea-6028-19d11b5838b0@linaro.org>
 <20221229155227.GA22937@roeck-us.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221229155227.GA22937@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/12/2022 16:52, Guenter Roeck wrote:
>>> +  adi,alarm1-interrupt-mode:
>>> +    description: |
>>> +      Enables the ALARM1 output to function in interrupt mode.
>>> +      Default ALARM1 output function is comparator mode.
>>
>> Why this is a property of DT/hardware? Don't encode policy in DT.
>>
> 
> I would not call this "policy". Normally it is an implementation
> question or decision, since interrupts behave differently depending
> on the mode. Impact is difficult to see, though, since the chip
> documentation is not available to the public.

Some more background would be useful here from the author...

> 
>>> +    type: boolean
>>> +
>>> +  adi,alarm2-interrupt-mode:
>>> +    description: |
>>> +      Enables the ALARM2 output to function in interrupt mode.
>>> +      Default ALARM2 output function is comparator mode.
>>
>> Same question.
>>
>>> +    type: boolean
>>> +
>>> +  adi,alarm1-fault-queue:
>>> +    description: The number of consecutive faults required to assert ALARM1.
>>
>> Same question - why this number differs with hardware?
>>
> 
> Noisier hardware will require more samples to avoid spurious faults.
> Trade-off is speed of reporting a fault. Normally the board designer
> would determine a value which is low enough to avoid spurious faults.
> 
> Note that the chip (according to patch 2/3) supports resistance
> cancellation as well as beta compensation, which are also board specific.
> I don't have access to the datasheet, so I don't know for sure if those
> are configurable (typically they are). If they are configurable, I would
> expect to see respective properties.

If that's the argument behind property, then it's fine.

Best regards,
Krzysztof

