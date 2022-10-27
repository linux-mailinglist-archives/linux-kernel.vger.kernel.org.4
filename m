Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DADE60F849
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbiJ0NCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbiJ0NCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:02:43 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31531757A2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:02:42 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id h188so1379889iof.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TGLKpxZOlMv1oQKhBXbn5pk4T3IOonLKRPQdZbP5eNY=;
        b=LiScULGbSZ7F7yQ6eDZyyJNC8WlGr54/jqCQ8LAKmrxPDy0pI5635ZhAGS9xQ+pcmo
         7OdEZDuJSOZyixcIu/7Ejicef5zw3l8V+mq+VXTcyy0n1OOHXu4vAH2+XvvVUPZCcjbN
         cHQVBE+pDYSV8Fv7exKtyUMwygV6n+ZH02IpuCsuqcveQJWxa7qkS57i7upFRtmHShFW
         3t0oPXNBt6DfCz0baGiIhdahL2GYIG10Oc/NCM82y1wOQpbBHF1eCscYhcW8LcaPPe8O
         aiORwRC/DTOY2RSl235uvv9qnguVCMTt6pxVYaf/zDXEtW6QMn8uwihektueJaKe/I2Y
         QbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGLKpxZOlMv1oQKhBXbn5pk4T3IOonLKRPQdZbP5eNY=;
        b=GX0pt1N41MWAB26b4VNJoE7UcTEBnCXnM+itq+3w3DZNnfDuDbFuLAYs/LYr5EjM6c
         XFqyBX2bAid6C5zDwzvhO/Z15V4jA8W1KHEka4bm1tYKD8Tg0gED8jBOXwlLnXropCvt
         e5j1E7J7DcAufj4fMqwOclVGhgUxUsdVm77MDPTiVFQVLjVkM4ZWiZeMjQFdTiWboBkY
         2xVEG4hQg6NXiL6ue61U/DUsYqMRVAysKxSl7lj+MUZmKexN6ldypntmwkTJ44uYZl+d
         su1PCCxWB5Rt5Yp4a9oSPop+j4TsnYQuMBCTB/IMkGfUXl/VVWrQEhiIHIdEej0miE0h
         UGcw==
X-Gm-Message-State: ACrzQf0WAjbTSoo8kYLMtXOajczQLOxpM1okuFTXfrDF36zefLY/y/it
        /f70ukqNgmUj/xwSpK6xbG3TSjWI6zZuKQ==
X-Google-Smtp-Source: AMsMyM6aU8WYV8rw/aGC3bW6/7M1Bt3B2qQh71bOJakmCD3pUdJq+SK17j5wVfG+En+ypNTByPcdXw==
X-Received: by 2002:a05:622a:512:b0:39a:d23a:431a with SMTP id l18-20020a05622a051200b0039ad23a431amr40746210qtx.370.1666875751577;
        Thu, 27 Oct 2022 06:02:31 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id n14-20020a05620a294e00b006eed094dcdasm935978qkp.70.2022.10.27.06.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 06:02:30 -0700 (PDT)
Message-ID: <10581088-e4ff-76db-3c9b-42a7a9c118ee@linaro.org>
Date:   Thu, 27 Oct 2022 09:02:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
Content-Language: en-US
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
References: <20221026134545.7146-1-vadym.kochan@plvision.eu>
 <20221026134545.7146-2-vadym.kochan@plvision.eu>
 <33f04b06-dc00-b7ce-6a24-2282608b40dc@linaro.org>
 <VI1P190MB0317C739E2D39427CD2A771D95309@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <VI1P190MB0317C739E2D39427CD2A771D95309@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2022 17:57, Vadym Kochan wrote:
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>
>> What happened to maxItems here? This is wrong. You keep changing random
>> things, again. V3 was correct.
>>
> 
> It is not random, I tried to enforce to use 2 clocks for A7k/8K case.

I think I gave you example how these clocks are being enforced, but
let's paste it here one more time:
https://elixir.bootlin.com/linux/v5.19-rc6/source/Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml#L38

If you have always two clocks, you just put here maxItems and skip the
allOf:if:then.

If you have here for some variants one clock, for some two, then define
wide constraints here and narrow them for each variant in allOf:if:then
("else:")

> 
>>
>>> +    description:
>>> +      Shall reference the NAND controller clocks, the second one is
>>> +      is only needed for the Armada 7K/8K SoCs
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: core
>>> +      - const: reg
>>> +
>>> +  dmas:
>>> +    maxItems: 1
>>> +
>>> +  dma-names:
>>> +    items:
>>> +      - const: rxtx
>>> +
>>> +  marvell,system-controller:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description: Syscon node that handles NAND controller related registers
>>> +
>>> +patternProperties:
>>> +  "^nand@[0-3]$":
>>> +    type: object
>>> +    properties:
>>> +      reg:
>>> +        minimum: 0
>>> +        maximum: 3
>>> +
>>> +      nand-rb:
>>> +        minimum: 0
>>> +        maximum: 1
>>> +
>>> +      nand-ecc-strength:
>>> +        enum: [1, 4, 8]
>>> +
>>> +      nand-on-flash-bbt: true
>>> +
>>> +      nand-ecc-mode: true
>>> +
>>> +      nand-ecc-algo:
>>> +        description: |
>>> +          This property is essentially useful when not using hardware ECC.
>>> +          Howerver, it may be added when using hardware ECC for clarification
>>> +          but will be ignored by the driver because ECC mode is chosen depending
>>> +          on the page size and the strength required by the NAND chip.
>>> +          This value may be overwritten with nand-ecc-strength property.
>>> +
>>> +      nand-ecc-step-size:
>>> +        description: |
>>> +          Marvell's NAND flash controller does use fixed strength
>>> +          (1-bit for Hamming, 16-bit for BCH), so the actual step size
>>> +          will shrink or grow in order to fit the required strength.
>>> +          Step sizes are not completely random for all and follow certain
>>> +          patterns described in AN-379, "Marvell SoC NFC ECC".
>>> +
>>> +      label:
>>> +        $ref: /schemas/types.yaml#/definitions/string
>>> +
>>> +      partitions:
>>> +        type: object
>>
>> That's not what I asked for. Like four times I asked you to add here
>> unevaluatedProperties: false and I never said that ref to partition.yaml
>> should be removed and you... instead remove that ref.
>>
>> You need to define here children and specify their ref.
>>
>> You must use unevaluatedProperties: false here. So this is fifth time I
>> am writing this feedback.
>>
>>
> 
> It is a bit confusing that it is needed to define "partitions" and "label" rules particulary
> in this nand controller instead of some common place like nand-chip.yaml, these properties
> are common also for the other nand controllers.

No one speaks about label, I never commented about label, I think...

If you think the property is really generic and every NAND controller
bindings implement it, then feel free to include them there, in a
separate patch. It sounds sensible, but I did not check other bindings.

Best regards,
Krzysztof

