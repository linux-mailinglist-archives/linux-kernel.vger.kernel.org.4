Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5215162EEED
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241338AbiKRIJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbiKRIJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:09:06 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069E71AD97
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:09:05 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id u11so5834821ljk.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2in+ZVvPB3cbCrsiVBIVBnCTrRph1aB1FMTEbTyQlkw=;
        b=yuJiGXCoMPwt7oL9qapbBm1iCXz5XTH3RDTvDTJmelxHxOa682dFXMgvFD4Iwrqy3K
         qWCZToqNRzEiJeJ44nMcA1wToIO9M3rA6xPq6UcSlV1mDy25ER5IRTnHRLo5v7l4OayS
         4R4ca8VWiX3shsf9dhEU9VmHnuZ4h1QsrSEiVC0usnxORUxv8WaDqlq7E++MfLsx1rm/
         Sx/n5gyZ7P6hI6Kgmo3N4+TX2lKk4BWUDdiNS6Dd9Op+F2fP2vtdd3K9kV3zDwQFVMne
         QRLKfCEtherotSglkLkAOm6EH3YG6OEEHvjBJfqJPm2zdP0Vv3xHsyAxdykOw/vMxA82
         onLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2in+ZVvPB3cbCrsiVBIVBnCTrRph1aB1FMTEbTyQlkw=;
        b=GDhfz9aSIlCSxU853MlTnmVlLuFJRaPVBqA5pLXiszRB1VRMp9CKZB7I+LGPveYUZ1
         fSv8FcwwvH8Esw/dTUGrtZ5Ih7RwWJCxvd1ZsKwsrgz6HNO2pmTFtYeQ8TM3y2LCnJbD
         /AANdOTvyWkgVmBbUtzbBz8Grf0Rbg7jb2VXARIz+K3k9bymK8ZBYBYGHkTw05uBtGLu
         f/2i7V0QMsjVctJEhT1GejaN3SKkg1lgLZl91hcGnYzOC9nRbihL0MQ1zvdFz5Eg6byi
         eaqECvyzrExJcVpxDvMYFOcRktWaV5Ghs2dluZ6IGmzWveGUhyyc+jCOM+oC1yyy5cP3
         i+yw==
X-Gm-Message-State: ANoB5pld7OiO6o//Q/T0/3qaDNFramUk3QT64HApKNhLvUaJdNFssj8l
        glWB5ku8dfoXgk7Z39ig8kGsDA==
X-Google-Smtp-Source: AA0mqf6C6B3Tp1AW/gNjoOPLRQ8Z00wbZh+cOnyUAAWuoYiohmnyfV4lHxR20x5LQq07P0+wTujPpg==
X-Received: by 2002:a2e:a1c6:0:b0:277:4f:bd29 with SMTP id c6-20020a2ea1c6000000b00277004fbd29mr2033408ljm.171.1668758943193;
        Fri, 18 Nov 2022 00:09:03 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q3-20020a056512210300b004a8b9c68728sm562417lfr.105.2022.11.18.00.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 00:09:02 -0800 (PST)
Message-ID: <b6cbbbe5-c1e9-a2fc-dd9d-9076d268a2a0@linaro.org>
Date:   Fri, 18 Nov 2022 09:09:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] media: dt-bindings: allwinner: video-engine: Fix
 number of IOMMU channels
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        samuel@sholland.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20221117060704.367945-1-jernej.skrabec@gmail.com>
 <20221117060704.367945-2-jernej.skrabec@gmail.com>
 <b0125ad2-426c-d908-0839-2021bc59d59f@linaro.org>
 <3385828.QJadu78ljV@jernej-laptop>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3385828.QJadu78ljV@jernej-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2022 21:31, Jernej Škrabec wrote:
> Dne četrtek, 17. november 2022 ob 14:13:00 CET je Krzysztof Kozlowski 
> napisal(a):
>> On 17/11/2022 07:07, Jernej Skrabec wrote:
>>> Cedrus (video engine) on Allwinner H6 actually uses two IOMMU channel,
>>> not just one. However, Cedrus on SoCs like D1 only uses one channel.
>>>
>>> Allow up to 2 IOMMU channels.
>>>
>>> Fixes: 62a8ccf3a248 ("arm64: dts: allwinner: h6: Fix Cedrus IOMMU usage")
>>> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>>> ---
>>>
>>>  .../bindings/media/allwinner,sun4i-a10-video-engine.yaml       | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engin
>>> e.yaml
>>> b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engin
>>> e.yaml index 541325f900a1..6446004d59d9 100644
>>> ---
>>> a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engin
>>> e.yaml +++
>>> b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engin
>>> e.yaml> 
>>> @@ -55,7 +55,8 @@ properties:
>>>      description: Phandle to the device SRAM
>>>    
>>>    iommus:
>>> -    maxItems: 1
>>> +    minItems: 1
>>> +    maxItems: 2
>>
>> You have several compatibles in the file, so usually this is further
>> constrained per each variant in allOf:if:then:.
> 
> Usually, yes. But this whole binding would need update. It has a few optional 
> properties and none of them is tied to any compatible. Additionally, if I do 
> it as you suggest, then Robs automatic test will report the issue, because 
> existing H6 based boards won't match this binding anymore. I would much rather 
> send follow up patch which clears up all optional properties.

I don't understand last argument. It's basically like saying - I keep
bindings not really correct, because otherwise I would see warnings and
I would need to fix them.

If this can be constrained per variant, constrain it and then fix the
boards.
Best regards,
Krzysztof

