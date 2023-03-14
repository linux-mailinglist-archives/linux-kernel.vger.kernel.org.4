Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59126B9969
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjCNPfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjCNPef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:34:35 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0523016319
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:34:08 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p16so10619945wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678808040;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cUjs6NviTytRdWImr2LdV+yP+PAoWGINkzdtBEGmEbo=;
        b=POV/DSkl33KHDBhOQAlydeOy9+73CLozXWLMG3Fp6HkjJKsola5G8Vziii75lLRhyv
         CSRrs2f5lbJH7Kx/VJjSwdjCR3jsjTGlRuZcAnp6WFwG1E5Tmc08QtLvoXI1YyIDpThr
         97WIxRQrrbJlOjfSR1TJpyA9y172fwxHOMRTCRC8QgHWSsf3Tkylu2dlIRWSdn2RlZTZ
         R2pfaTyQ1Ppb5qo4K0FuKI38IxJIOAvJPJfOPUeW6Tki0UPChiPjFJ8Acx44qCYbrZ2m
         mbpE4Qoi5+TTIXXuji8sQfgKBsxcNuqLn0IERYFuLgFpHl1BsV7Q/OAOL2vUFTJ+w/Lw
         C5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678808040;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUjs6NviTytRdWImr2LdV+yP+PAoWGINkzdtBEGmEbo=;
        b=6ve59NxsvJxJQdKa5DJ+3BjZNc/c5iEeMvcYfO4Yxjhxdscqnhr/F4Z5HHl9VdVBQz
         JtnxAwfAE3c5yrWg2TdgOAKSzhH5gd8RtuY5RnKnMnQaHc+1KwZpS9bAQrHsWdDNe5lN
         twEWDuzUrb1DtM7CEP/4yo5YHRjgqfxAg1uMKqTzbZU+ucFadAFbtpFw8H7Yhtqsvk+L
         PjKZfOq2BXqvRvvbLBqxF6RPaUyFSnwpkfP0o3xF8aOVR++MkmPynXWsK1sUOwlcqjr5
         mHwY3dgb5JecVcRylYAQjexBkehJYU1Id8aGdbyhD1jNYThWaZPuDf/5D5PO0BCYKKiV
         HaBA==
X-Gm-Message-State: AO0yUKV2y5CZ1y3zuzuZBDDS+Py/o6l3L63RU0j9bsMEYzIRTWK9d2fe
        ShBcvdsve0h/pdWyjZr+exygXcbVqlEZZmeki88p5g==
X-Google-Smtp-Source: AK7set+opZ/oLe2qEwrmqbnw6+/2Ubn1r0GXttqg3AYw7OCBnJYLnOJKGMtbzfih7muqNbDNx5Ux0A==
X-Received: by 2002:a05:600c:4f01:b0:3ea:f6c4:3060 with SMTP id l1-20020a05600c4f0100b003eaf6c43060mr14821352wmq.18.1678808040282;
        Tue, 14 Mar 2023 08:34:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:11c3:d4e5:ef75:8eb9? ([2a01:e0a:982:cbb0:11c3:d4e5:ef75:8eb9])
        by smtp.gmail.com with ESMTPSA id s16-20020a05600c45d000b003ed29899dfdsm3381407wmo.21.2023.03.14.08.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 08:33:59 -0700 (PDT)
Message-ID: <c8fecf94-2581-6cc9-955c-324efdc7c70a@linaro.org>
Date:   Tue, 14 Mar 2023 16:33:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v10 3/5] dt-bindings: clock: meson: add A1 PLL and
 Peripherals clkcs bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     jbrunet@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        khilman@baylibre.com, martin.blumenstingl@googlemail.com,
        jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230313201259.19998-1-ddrokosov@sberdevices.ru>
 <20230313201259.19998-4-ddrokosov@sberdevices.ru>
 <ffebef1d-8447-181b-1890-3e638d399c62@linaro.org>
 <20230314114825.yiv4vcszr6b7m45w@CAB-WSD-L081021>
 <2d9297e9-dab7-9615-3859-79b3b2980d9a@linaro.org>
 <20230314150107.mwcglcu2jv4ixy3r@CAB-WSD-L081021>
 <9d176288-cd7c-7107-e180-761e372a2b6e@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <9d176288-cd7c-7107-e180-761e372a2b6e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/03/2023 16:19, Krzysztof Kozlowski wrote:
> On 14/03/2023 16:01, Dmitry Rokosov wrote:
>> On Tue, Mar 14, 2023 at 03:05:48PM +0100, Krzysztof Kozlowski wrote:
>>> On 14/03/2023 12:48, Dmitry Rokosov wrote:
>>>> On Tue, Mar 14, 2023 at 12:28:40PM +0100, Krzysztof Kozlowski wrote:
>>>>> On 13/03/2023 21:12, Dmitry Rokosov wrote:

<snip>

>>>>>> +/*
>>>>>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>>>>>> + * Author: Jian Hu <jian.hu@amlogic.com>
>>>>>> + *
>>>>>> + * Copyright (c) 2023, SberDevices. All Rights Reserved.
>>>>>> + * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
>>>>>> + */
>>>>>> +
>>>>>> +#ifndef __A1_PLL_CLKC_H
>>>>>> +#define __A1_PLL_CLKC_H
>>>>>> +
>>>>>> +#define CLKID_FIXED_PLL		1
>>>>>> +#define CLKID_FCLK_DIV2		6
>>>>>> +#define CLKID_FCLK_DIV3		7
>>>>>> +#define CLKID_FCLK_DIV5		8
>>>>>> +#define CLKID_FCLK_DIV7		9
>>>>>> +#define CLKID_HIFI_PLL		10
>>>>>
>>>>>
>>>>> Probably I asked about this... why indices are not continuous? You know
>>>>> that consumers are allowed to use number 2 and it will be your ABI, even
>>>>> though you did not write it in the binding? That's a tricky and
>>>>> confusing pattern for no real gains.
>>>>
>>>> Actually, indices are continuou but splitted into two parts: public and
>>>> private. The public part is located in the dt bindings and can be included
>>>> from device tree sources. The private part is in the drivers/clk/meson
>>>> folder, and only clk drivers can use it.
>>>> I know, there is some trick when the user just inserts a digit value and
>>>> doesn't use constants.
>>>
>>> This is not a trick. This is how DTS works. You have only indices/numbers.
>>>
>>>> But I'm starting from the assumption that such
>>>> dts changes will not be approved by maintainers. In other words, the user
>>>> *must* apply defined ABI constants from dt bindings; it's a strong
>>>> restriction.
>>>
>>> But it is not correct assumption. Defines are very important, but they
>>> are just helpers. Otherwise without defines you could not use any clock?
>>> We pretty often use IDs - for DTS to allow merging via different trees,
>>> for DT binding examples to not rely on headers.
>>>
>>> Your driver implements the ABI and the driver exposes for example clock
>>> ID=2, even if it is not in the header.
>>>
>>> These IDs are unfortunately undocumented ABI and you if you change them,
>>> users are allowed to complain.
>>>
>>> Solution: don't do this. Have all exposed clock IDs and clocks in sync
>>> (and continuous).
>>
>> I see. But I don't understand how I can restrict access to private
>> clock objects. I don't want to open ability to change system clocks
>> parents, for example. Or it's under device tree developer responsibility?
>> I would appreciate any assistance in determining the best path.
> 
> There are many ways - depend on your driver. For example like this:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/samsung/clk-exynos5420.c#n975
> 
> The first argument is the clock ID (or ignore).
> 
> BTW, quite likely the problem is generic to all Meson clock drivers.

This issue about "public" non-continuous defined was already discussed at https://lore.kernel.org/all/c088e01c-0714-82be-8347-6140daf56640@linaro.org/

I don't see what's different with this one.

Neil

> 
> Best regards,
> Krzysztof
> 

