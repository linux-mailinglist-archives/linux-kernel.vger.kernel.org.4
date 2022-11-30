Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B648963D0CC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbiK3Ift (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbiK3IfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:35:09 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B1010A5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:35:07 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id d3so20082106ljl.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kcyWsekNpjW83jaBV4h3bWe3M3a62T4akctRwJN9qQw=;
        b=xxygHrVudH/jRn0zVZTJRKc+hk75Z//tJLTCgljOhPvuK4wDPJOhwCxdNjLllI+bKZ
         ORhapHPhNmP3+zRihBWBONgRqaHLXF5NjioBc83wTFDobjePOPwzfRzdH+Ym99XQtxrJ
         iHLZMR49Gxtzee5/M0vkXrN7WpfCZqqnHSJ0aleb1a4dmmrhfvIkn7K1AQXFxgrDaN9p
         Mh6v9aRVqEcjSavFC1xluoh/eg+3ymaf5XEP1zOOYWpvhk/1cWqqqMzeihAedfidWP3X
         koyUyxpmrFjPI1p7hxX9Rb2sdCwc86M2adQctegd+VwosMptsH+4zyVHGj/dZxmwDzHA
         vsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kcyWsekNpjW83jaBV4h3bWe3M3a62T4akctRwJN9qQw=;
        b=4bxGZCQRiK1WDRqIHf8QMc6+XPb0J/5ldaMXMw1cLynzgpydaBLcR3fB4Y/f1E+AZl
         2qG6h5CGEpr3a3z5HgnlbEBMPQQ13elDd5h3txN/pF5/BXSp81czNNnRr8f7d28SCkGs
         SYey6Vcnes4OjHdNTtcbF+UqutYrlA0gqTHOHkwnXaY/xkZupT05jc42i96v+JYqgbmm
         9ZpE4sej4YsWK0PJWiblPkTfmcp3gByg49TdJ6gt7NttoIm21BblicnJnZqiOTDvOjy8
         cpyIr1m2vspTvjUnIx+rlp5oZ8y17h3qOBKjvE529IK0qtu2eqLoVMj5Ha1hCw2HqLdn
         eQOg==
X-Gm-Message-State: ANoB5pmsFTSSAC7F/baj/Npn90JO66nOYIL3G+Gi2VTTdzG4btoJnBFJ
        VsiuGJfD4hKLzLFv+S7JSs30GQ==
X-Google-Smtp-Source: AA0mqf4U+gFSGMAw9tW/t9ns6UxsiuwlvarT6QZfwU3S1rmz5GnvBtFX9HqRwIDY6T3CdKG32JHOFw==
X-Received: by 2002:a2e:592:0:b0:279:c85d:43da with SMTP id 140-20020a2e0592000000b00279c85d43damr295192ljf.435.1669797305804;
        Wed, 30 Nov 2022 00:35:05 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u13-20020a05651206cd00b0049fbf5facf4sm167617lff.75.2022.11.30.00.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 00:35:05 -0800 (PST)
Message-ID: <bc356f96-600a-64df-c0fe-00c807fa605c@linaro.org>
Date:   Wed, 30 Nov 2022 09:35:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 7/9] dt-bindings: spi: mtk-snfi: add two timing delay
 property
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
 <20221128020613.14821-8-xiangsheng.hou@mediatek.com>
 <9985d44e-977e-d7ea-0932-4879a3ccd14d@linaro.org>
 <f83184ae803dbe0afd37a31a8a83a369a9772880.camel@mediatek.com>
 <08ebc76a-0220-f984-b546-23dba8677be9@linaro.org>
 <741d7ce16df25450b08c92e508190bc7c91fc8d9.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <741d7ce16df25450b08c92e508190bc7c91fc8d9.camel@mediatek.com>
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
>>
>>>>> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-
>>>>> snfi.yaml
>>>>> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-
>>>>> snfi.yaml
>>>>> @@ -55,6 +55,22 @@ properties:
>>>>>      description: device-tree node of the accompanying ECC
>>>>> engine.
>>>>>      $ref: /schemas/types.yaml#/definitions/phandle
>>>>>  
>>>>> +  rx-sample-delay:
>>>>
>>>> No, use existing property, don't invent your own stuff - missing
>>>> unit
>>>> suffix. See spi-peripheral-props.yaml.
>>>
>>> Will change to other private property. The read sample delay with
>>> MediaTek SPI NAND controller can be set with values from 0 to 47.
>>> However, it`s difficult to say the unit of each vaule, because the
>>> unit
>>> value will be difference with different chip process or different
>>> corner IC.
>>
>> Why you cannot use same formula as other SPI drivers for sample-
>> delay?
>> And divide/multiple by some factor specific to SoC, which is taken
>> from
>> driver_data?
> 
> Even for specific SoC, the unit of sample delay may be various with
> different corner IC.

Which is easy to achieve with driver_data as I said.

> Besides, whether it`s acceptable by change the property rx-sample-delay 
> and rx-latch-latency to mediatek,rx-sample-delay and mediatek,rx-latch-
> latency?

Not for sample delay, because you should use existing properties. Your
driver implementation is not usually argument to duplicate properties in
the bindings.

Best regards,
Krzysztof

