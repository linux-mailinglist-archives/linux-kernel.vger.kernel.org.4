Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DB163BAED
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 08:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiK2HsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 02:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiK2Hr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:47:58 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C97851328
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:47:56 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b3so21219510lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=etxMVrTTVJSTddGDgARHAHEO1RrGD5Hs7SuIw9ap/3I=;
        b=rJ2CHbAyVDgULRTpj4MDVg2dwBK1HADystIZFbvhbTYoLIME+/tt+UNXjiftguq7ib
         w244K+6QPoVERfMg79BoElJO38d82eLScZZat5sFVE49snZOfOK2/+f0fnJIKBPDeYwr
         FMbKUIjfcevvcaBgXAKIO3MbRsFR3P6ZtMV7rNa9PIY4woHjOWMCcZuqv4pX0tOMHtUg
         i6K9FHqMYrX/NmhNXcCLLkLhSjNQEx5ifmowHQHPkWFrl7Bjgf4qKioahqfbJwtbyu+O
         kUj+dvJ58qD1SX7rLqgkoUAxuWicMcWgz3BzKtCsL8WBGDD+0gJi4HnxuReDXO62n9lO
         ykmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=etxMVrTTVJSTddGDgARHAHEO1RrGD5Hs7SuIw9ap/3I=;
        b=iD22pwqBNdeOJzg7Gu83id4qwqXHdviSCnEZ8kkQfm+OFGLDvdYJOG8PcrsXV1+tuT
         Cknl/mMSRjzxTe9MfxSHM73ugtqPnL2OQfx/QHRETwt3FeVE1yVHs0QEOVNYJ4fWK8Gq
         lIKm62RKQDUfFkvOM754F4ow09tworoAC96REfSNn+KDfP/nRJprnsWpz5GqhOA0/4Il
         7U7eCku2LalfrLDfOFshO+R/GjabnonZoC37uf+GiAwhm0qg9obpMZEvliUUQ7ZCQZWq
         UdFtqh4K0TWVMvOuyiBOE3fYyMQSWTZbRGjFJY1UdFhekJaf+GA3XrKxNFfocUEBi1ij
         5kig==
X-Gm-Message-State: ANoB5pmL9bDD7pGQSX6fHzaEaW0FsSpiOPQNd3xxWmqXaOfk2iH2nF2c
        zyz61mS322O2x7jsUXhOmZqrvA==
X-Google-Smtp-Source: AA0mqf67TcbUg0koPs/HiroxNXgbbcwrSRcrk/nihBw0w3MO/AQgLVDwdMtZH+S68ivSZKmzzQx01Q==
X-Received: by 2002:a19:ae18:0:b0:4aa:c879:5bc with SMTP id f24-20020a19ae18000000b004aac87905bcmr12172113lfc.498.1669708074608;
        Mon, 28 Nov 2022 23:47:54 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k16-20020a0565123d9000b0049e9122bd1bsm2080686lfv.164.2022.11.28.23.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 23:47:54 -0800 (PST)
Message-ID: <e512b7fd-3404-3c2d-dbf6-dc66ee662a06@linaro.org>
Date:   Tue, 29 Nov 2022 08:47:53 +0100
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5f76482d33933c19e191ea618f8622cd0660597f.camel@mediatek.com>
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

On 29/11/2022 03:50, Xiangsheng Hou (侯祥胜) wrote:
> Hi Krzysztof,
> 
> On Mon, 2022-11-28 at 10:00 +0100, Krzysztof Kozlowski wrote:
>> On 28/11/2022 03:06, Xiangsheng Hou wrote:
>>> 1. add mt7986 IC bindings
>>
>> Subject: drop second, redundant "bindings".
> Will be fixed in next series.
> 
>>>    clocks:
>>> +    minItems: 2
>>>      items:
>>>        - description: clock used for the controller
>>>        - description: clock used for the SPI bus
>>> +      - description: clock used for the AHB bus dma bus, this
>>> depends on
>>> +                     hardware design, so this is optional.
>>
>> Optional for which variants? For all of them?
> It`s only needed for the item 3 nfi_hclk. Is it proper with this
> description or any other suggestion.

I understand third clock is optional. For which variants/compatibles it
is optional? Add allOf:if:then restricting it.

Best regards,
Krzysztof

