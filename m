Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECC063D0C6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbiK3Ife (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbiK3IfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:35:04 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F982A95A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:33:57 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id r12so25859127lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bInR2egbUtB2hdBJUO3XKA2gh33pftK8BC1pboCK4Cw=;
        b=zcjMf5MiAzYT57sPm6IN9blQQbOHLzrtaEsAe7mOQqNQvADeYMPI6oVtT7tEITeYcV
         DagPXMaBFptf7ab5MlLq3GvjTGyfkxJym+RiU8PnSWHwog0c7q/EAgdXvIGj5hBB7Yuc
         CBUcKNqdu1JTahD0Eym6DaDoPS/zGPNtZqbIBLtsrQWEMz+adpWWlKy2qMfXmb9j7KWi
         amSs0oAAQRlsisUu7q0gT75bG2xBY8l5S3FMwNTVJt0GgdLHoprXxlaD6asuPtqDu0QG
         FvvxlX4k8VOxiqiOVj0w0KO5kcAt1yb1ChuyULvXbQMzPNaesCIpu9ZnuTN4cEN8dW+n
         dUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bInR2egbUtB2hdBJUO3XKA2gh33pftK8BC1pboCK4Cw=;
        b=ElZMhuOfRO/I1Zi77mdtswMOpx7ETJcLqavmh9zvKd4vGn4aXWemdpStadAbFWZC+D
         C9Vcvc9nJzTmAFYrAOl4Y4esSkCQ2xj1Y6jaOfLcKIapCYNisDNaIdxPrrkfAx4AaOFQ
         lTF/GvGnqD9ED5SQccOr9POkpn8BPl2hv4wxL8aa+kRZxFS8JyWpXjtXB9e+N+Mc/2Pa
         HH4K7qmlqoYCHNDs61NiTYXrWz+KEISyMdppJXKMthpV/sq/++AYh7Xb8294Ng9SujL6
         do7MP1XAFLd7/nwYgbE5IiCcJRSsFdEKpIVuAV8XB9KZFxzWmkP9BKUgvr6xH2l21y7R
         I2Cg==
X-Gm-Message-State: ANoB5pmcv6PGh/kuq4AvEv9/ApgFMmvkBytW9XUkRb3JF/8hx9WAO4cR
        kX9gmT0roVOSFSB5YfyQQOGwWw==
X-Google-Smtp-Source: AA0mqf5ij2hVTbkErt4ghcZygMlO+KN57N0P9UqggTllmp6/9wSbhnOoztToCTHGNxgcaruT7tXxuA==
X-Received: by 2002:a05:6512:5d4:b0:4b0:8622:662f with SMTP id o20-20020a05651205d400b004b08622662fmr21180119lfo.316.1669797235649;
        Wed, 30 Nov 2022 00:33:55 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m2-20020a195202000000b004a47e7b91c4sm163429lfb.195.2022.11.30.00.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 00:33:55 -0800 (PST)
Message-ID: <cc2f8ded-f88b-66d0-3ec1-9e1cd74b493f@linaro.org>
Date:   Wed, 30 Nov 2022 09:33:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 5/9] dt-bindings: spi: mtk-snfi: add mt7986 IC snfi
 bindings
Content-Language: en-US
To:     =?UTF-8?B?WGlhbmdzaGVuZyBIb3UgKOS+r+elpeiDnCk=?= 
        <Xiangsheng.Hou@mediatek.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "gch981213@gmail.com" <gch981213@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "richard@nod.at" <richard@nod.at>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?QmVubGlhbmcgWmhhbyAo6LW15pys5LquKQ==?= 
        <Benliang.Zhao@mediatek.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?QmluIFpoYW5nICjnq6Dmlowp?= <bin.zhang@mediatek.com>
References: <20221128020613.14821-1-xiangsheng.hou@mediatek.com>
 <20221128020613.14821-6-xiangsheng.hou@mediatek.com>
 <8b8e4b23-a3bc-7e3d-199a-e8f591d05d71@linaro.org>
 <5f76482d33933c19e191ea618f8622cd0660597f.camel@mediatek.com>
 <e512b7fd-3404-3c2d-dbf6-dc66ee662a06@linaro.org>
 <36d71d033f6926dfaefed7010bced94b4cd4b339.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <36d71d033f6926dfaefed7010bced94b4cd4b339.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2022 09:18, Xiangsheng Hou (侯祥胜) wrote:
> Hi Krzysztof,
> 
> On Tue, 2022-11-29 at 08:47 +0100, Krzysztof Kozlowski wrote:
>> On 29/11/2022 03:50, Xiangsheng Hou (侯祥胜) wrote:
>>>
>>>>>    clocks:
>>>>> +    minItems: 2
>>>>>      items:
>>>>>        - description: clock used for the controller
>>>>>        - description: clock used for the SPI bus
>>>>> +      - description: clock used for the AHB bus dma bus, this
>>>>> depends on
>>>>> +                     hardware design, so this is optional.
>>>>
>>>> Optional for which variants? For all of them?
>>>
>>> It`s only needed for the item 3 nfi_hclk. Is it proper with this
>>> description or any other suggestion.
>>
>> I understand third clock is optional. For which variants/compatibles
>> it
>> is optional? Add allOf:if:then restricting it.
> 
> The MediaTek SPI NAND controller IP used by MT7986 is the newest.
> In the future, there will have other SoCs.
> If add restricting on this, may not easy to maintain.
> Does this acceptable?

I don't think it is not easy to maintain. We have it in many, many
bindings...

Best regards,
Krzysztof

