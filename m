Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1210963BAEA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 08:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiK2HrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 02:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiK2HrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:47:09 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A0C51C0E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:47:08 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id g7so21207887lfv.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=loSpF9AgG01RMo3LBV/v8v6fFtboHwkwvrGYRwDPayw=;
        b=BCIwFn6W/n3Cf25bMWz/YeiC1vDxWars4v8YMEFnaxBFn1+klIarsq0thr5IvFXBd9
         y0iEYk/HW1kb38E9fGJQE23xoYKh1JSMPNptDyAci8eDnjw187PoZRcMaTSsGScprKF0
         3JnzlEVO7XLzbb726ClGkCFzGKUg130Zltw6RkyFgarJr3EFrx3Ku1npNJ8ga77eTfkO
         69uWTfnN2vC1onzoddkNRL9JzocY4lCxV2vQJqwWxkWEMQCWlm07jXhcvDk8tqH+MEI6
         NmW+Z+mOT5piPL3GJr0IjEujQDbz1T01BGCV4QvqAHhK5GOztAAeZlu9lhf35ypj5sSe
         RrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=loSpF9AgG01RMo3LBV/v8v6fFtboHwkwvrGYRwDPayw=;
        b=BYxO/+rgVlNALSIyJVH6r250HPuXwimgCxLReP6IEmwPy/fobOMRqhmn4tJtx5yzK/
         oJB8gEq3rnPBEcTWKhL7XSdFw7GDGzSJwHdTtH6oT69TI3+vqIVIHDYswzGmCsns09qO
         5YLNjDQM0GPJUwOeXk+xJLXkYmBqPn6IYWGnXFEcShDugg4PfRHPSmY5bgcOTZD6WkJi
         ziX9nrusQ8yVPAjYn9k1BpvNC6RG1mv5GA8DP9Ml+2Yt8ZA0ErZ6rEXXia3fqsctIFGS
         EWON2Dn82bDbnWCWAlqCeBeTiPzNCqjPbQcEOUE63eWZh2hLWOiB1CslTVUlAUhDvTBJ
         vtww==
X-Gm-Message-State: ANoB5pmdfxAJUdkQhepZPgdg6gkdm9vZhM4a92eS4wF0FSOEWF38u0Zm
        GSvt1yMVHRnZbxwOvm8ABaatWw==
X-Google-Smtp-Source: AA0mqf6+wcgPAn5cslfEauv8J6Mh6lwM69/leKqgZb2AnXuqe0SSsSZ6WHFsED5uSwSOj/bep+llhw==
X-Received: by 2002:a05:6512:2212:b0:4b5:acf:8789 with SMTP id h18-20020a056512221200b004b50acf8789mr4757200lfu.549.1669708026761;
        Mon, 28 Nov 2022 23:47:06 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id r13-20020ac252ad000000b004b49025f96dsm2096814lfm.187.2022.11.28.23.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 23:47:06 -0800 (PST)
Message-ID: <08ebc76a-0220-f984-b546-23dba8677be9@linaro.org>
Date:   Tue, 29 Nov 2022 08:47:05 +0100
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f83184ae803dbe0afd37a31a8a83a369a9772880.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2022 03:50, Xiangsheng Hou (侯祥胜) wrote:

>>> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-
>>> snfi.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-
>>> snfi.yaml
>>> @@ -55,6 +55,22 @@ properties:
>>>      description: device-tree node of the accompanying ECC engine.
>>>      $ref: /schemas/types.yaml#/definitions/phandle
>>>  
>>> +  rx-sample-delay:
>>
>> No, use existing property, don't invent your own stuff - missing unit
>> suffix. See spi-peripheral-props.yaml.
> Will change to other private property. The read sample delay with
> MediaTek SPI NAND controller can be set with values from 0 to 47.
> However, it`s difficult to say the unit of each vaule, because the unit
> value will be difference with different chip process or different
> corner IC.

Why you cannot use same formula as other SPI drivers for sample-delay?
And divide/multiple by some factor specific to SoC, which is taken from
driver_data?

> 
>>> +    description: Rx delay to sample data with this value, the
>>> valid
>>> +                 values are from 0 to 47. The delay is smaller
>>> than
>>> +                 the rx-latch-latency.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>
>> Drop $ref.
> Will do.
> 
>>
>>> +    minItems: 0
>>> +    maxItems: 47
>>> +    default: 0
>>> +
>>> +  rx-latch-latency:
>>
>> Same problems. Did you check spi-peripheral-props.yaml or other SPI
>> controller schemas for such property?
>>
>>> +    description: Rx delay to sample data with this value, the
>>> value
>>> +                 unit is clock cycle.
>>
>> I think the unit should be rather time (e.g. us).
>>
> Yes, I checked the spi-peripheral-props.yaml and the delay values are
> described exactly unit with ns or us. However the unit of MediaTek read
> latch latency is clock cycle and it`s difference with different clock
> frequency.

This is fine in such case.

> 
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [0, 1, 2, 3]
>>> +    default: 0
>>> +

Best regards,
Krzysztof

