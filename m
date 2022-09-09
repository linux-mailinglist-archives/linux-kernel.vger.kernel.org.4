Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1125B3D37
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiIIQmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiIIQm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:42:28 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84A31440A7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:42:26 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f11so3649082lfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 09:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=AhS1mhLSPdTYHS3sCWcsfuKlT4/D61hxxGGDcI1RHwY=;
        b=EzoTQ92kcupNMBHuKMSK11U3VhWVT+KmYj4JSactNf2qPFZflLB3+nwBMbwTFd6t+U
         XWjuUU1tZ40oZH6WMD/GwnB5K6T57FqOIe12D9Q1q1+KdtMIXj9o8bPMZJFQBpZxYEGD
         /V7MTqAceSh9bl8AjdQcBGFdvZHK330DO6ABeSt+sOgpEVekUlethgy4Y4xmW0FYGZIa
         aou1wwq/77UDnSf/aDPNiUfc8TpewzRatwx1OxV/tNg0g1MaNMO7brIgghAzS8jHAC/p
         IZVNClOB3clDLICjW6a4atiYeEPbF3OUS+kHSZn99yeAyrunJ0tqFdGjHkVlu3XEPum5
         Zsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=AhS1mhLSPdTYHS3sCWcsfuKlT4/D61hxxGGDcI1RHwY=;
        b=bBgfxohmsozLtjABZwRNiOW9/8qSso3UuG/YMBu3LgCs5qOq9XYK7MV1ss57JqK7+o
         bowz6Xk9YFIYgQ7YKLA+2P+oW3rpyuwWUsinyUQut6AXGNUQAA+orbpoQtUAzsqbAHO8
         75ZslbTsuyDW7NsNtM2dj9Z6IADwG0ETXJeUN78W6MnhbotJxMQHMpbsfpwNiyW/hcjA
         ZRsga/+678+5ub4LkLxJhssNPPriQnOFh8dbmO25tb926yCdtLz3cgmCnOuEEdV+lhdZ
         tJma34ndWvI2LYqr5MygPFQkQ9P7AOrbUD0XXF4F4CK/zWty0TLRxlVtaea3MCf0h2d9
         +HHg==
X-Gm-Message-State: ACgBeo2gaPx1EoV2pVLuLkwgjreoH9hPen6hUJO35Z2lq7ybRomb9Wa5
        NLSYbaJ4fDU0ltw1bCJ0L1e83g==
X-Google-Smtp-Source: AA6agR62MO5VH+iTJ0jkLL7/fd5B2DVPyCGmMoEV8SdYJxJ4BdyZeXPp/Bur+wIj3bL9jXGhlUjc7Q==
X-Received: by 2002:a05:6512:c1:b0:497:a63d:563a with SMTP id c1-20020a05651200c100b00497a63d563amr4617909lfp.366.1662741745342;
        Fri, 09 Sep 2022 09:42:25 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id bi24-20020a05651c231800b00261c6c80b38sm140789ljb.75.2022.09.09.09.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 09:42:24 -0700 (PDT)
Message-ID: <1f2738ce-9901-35c9-eed8-52c02bfc65d3@linaro.org>
Date:   Fri, 9 Sep 2022 18:42:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v8 3/4] dt-bindings: hwmon: Add bindings for max31760
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220909133718.388213-1-Ibrahim.Tilki@analog.com>
 <20220909133718.388213-4-Ibrahim.Tilki@analog.com>
 <9d5e8a41-8e0a-c67a-1b68-f743b4680510@linaro.org>
 <339d3857-2deb-b5d9-332d-cc65cc90ca19@roeck-us.net>
 <96766080-dee3-1c06-031e-331a8702cf37@linaro.org>
 <ba55b70f-b1b1-c31a-e1ef-a079f0f02782@roeck-us.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ba55b70f-b1b1-c31a-e1ef-a079f0f02782@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 17:04, Guenter Roeck wrote:
> On 9/9/22 07:56, Krzysztof Kozlowski wrote:
>> On 09/09/2022 16:52, Guenter Roeck wrote:
>>> Hi Krzysztof,
>>>
>>> On 9/9/22 07:49, Krzysztof Kozlowski wrote:
>>>> On 09/09/2022 15:37, Ibrahim Tilki wrote:
>>>>> Adding bindings for Analog Devices MAX31760 Fan-Speed Controller
>>>>>
>>>>> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
>>>>> ---
>>>>
>>>>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>> Please wait with applying for Rob's bot to check it.
>>>>
>>>
>>> I don't think I see those results unless there is a failure.
>>
>> That's correct.
>>
>>> Is there a link where I can look up the results ?
>>
>> It will pop-up on Patchwork:
>> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20220909133718.388213-4-Ibrahim.Tilki@analog.com/

And there is a failure - the bindings were not tested before sending. :(

The error is visible when testing locally, although syntax in general
looks fine.

Un-reviewed.

Best regards,
Krzysztof
