Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDD0606010
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiJTMVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiJTMVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:21:48 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0331D3A5F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:21:46 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id s17so11432945qkj.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QU8wwIsX2qw3YuWPGoLshZE9nKsPTHBQ9xDkmS6/43A=;
        b=kxmoe7LVcj5YaehnNatSaJ+sgWuAJIYUVHZi7kkFgy1BEN3isRtJwl+XDqqRPPIZJj
         6s7x2UMRz8IIyEz9CG+9FZuWlnOp6z8CtYGL0HpbUwumjlPwEUL7JTYZnOw+7vLar7Wn
         SoejmHXPColW7UfWN1jaHbvq/J4jPIXfeVpcUjNSujJJQqIYqcju2EzMxd6ddY48LDQX
         A1tlt8aK/n1lBw74+4cxPpCUdH2/KVZeZ5LBmsVzHgDj8NvbpqyCTdE4hM1vBaoNFNP+
         /w6dwgz1OGuvcIigUDxMGAdY/RqReLRuxIk+SE9k8Pg10v6FmZsbmpismQgzrdFyEVWL
         qTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QU8wwIsX2qw3YuWPGoLshZE9nKsPTHBQ9xDkmS6/43A=;
        b=pT+gavyg24S2NZlSIVAOIo32+wvgqsPpM7LXIk+dTDnRcALehxhozSU8A6OjS8qrUI
         lWozcqjB5JPcLHiidyh6OhlxHDn4SD20X5E5eVAcytxrDh4p6CiPW+Oji9x3FIxoF+q3
         AvQJK6+yee/rIVYNLPjaMIeK3EOeZ5wxd7HsY62+TDi4+OUIJZdj5Z+Yc1Ssmm37N752
         58URMWlr6qR7UJq7uvHQNKleV8pkqOhOhUmoLPE+Dnuc3IwS+B8TteFCrXC4CapEgarZ
         OfmaFzU1FXgPQU+MT96r1cqBYjPEO+FfHBdQrtRY6Eg3tsdchvDi31LE0ZY2BhQ31wXu
         YaIQ==
X-Gm-Message-State: ACrzQf38ITaFuvp1xU5ZCyvXVUnQuqCMREiMvj6WNa90d1DcIYyVZci+
        fQLfQ64P8rNjZPsGeSRLYlJA8A==
X-Google-Smtp-Source: AMsMyM7gpLAbDdzem95MlHk1VJuHxCQq2NFZ0KtsUUKL2BU/4obX35xeH+M4i4rRIL7C7psdPxWaKA==
X-Received: by 2002:a05:620a:2489:b0:6ee:6244:a225 with SMTP id i9-20020a05620a248900b006ee6244a225mr8971714qkn.112.1666268505870;
        Thu, 20 Oct 2022 05:21:45 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id cg15-20020a05622a408f00b0039c37a7914csm5877409qtb.23.2022.10.20.05.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 05:21:45 -0700 (PDT)
Message-ID: <2cfed688-f401-e69e-1ff4-f775c6d90f64@linaro.org>
Date:   Thu, 20 Oct 2022 08:21:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 06/10] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Add MT6795
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221007125904.55371-1-y.oudjana@protonmail.com>
 <20221007125904.55371-7-y.oudjana@protonmail.com>
 <0f078a85-056a-c11e-377b-27764a34485d@linaro.org>
 <8WU1KR.065JU8WYUX9C3@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8WU1KR.065JU8WYUX9C3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2022 07:36, Yassine Oudjana wrote:
> 
> On Mon, Oct 10 2022 at 07:24:59 -04:00:00, Krzysztof Kozlowski 
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 07/10/2022 08:59, Yassine Oudjana wrote:
>>>  From: Yassine Oudjana <y.oudjana@protonmail.com>
>>>
>>>  Combine MT6795 pin controller document into MT6779 one. In the
>>>  process, replace the current interrupts property description with
>>>  the one from the MT6795 document since it makes more sense. Also
>>>  amend property descriptions and examples with more detailed
>>>  information that was available in the MT6795 document, and replace
>>>  the current pinmux node name patterns with ones from it since they
>>>  are more common across mediatek pin controller bindings.
>>>
>>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>>  ---
>>>   .../pinctrl/mediatek,mt6779-pinctrl.yaml      |  94 ++++++--
>>>   .../pinctrl/mediatek,pinctrl-mt6795.yaml      | 227 
>>> ------------------
>>>   2 files changed, 77 insertions(+), 244 deletions(-)
>>>   delete mode 100644 
>>> Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
>>>
>>>  diff --git 
>>> a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml 
>>> b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
>>>  index a2141eb0854e..cada3530dd0a 100644
>>>  --- 
>>> a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
>>>  +++ 
>>> b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
>>>  @@ -8,6 +8,7 @@ title: Mediatek MT6779 Pin Controller
>>>
>>>   maintainers:
>>>     - Andy Teng <andy.teng@mediatek.com>
>>>  +  - AngeloGioacchino Del Regno 
>>> <angelogioacchino.delregno@collabora.com>
>>>     - Sean Wang <sean.wang@kernel.org>
>>>
>>>   description:
>>>  @@ -18,6 +19,7 @@ properties:
>>>     compatible:
>>>       enum:
>>>         - mediatek,mt6779-pinctrl
>>>  +      - mediatek,mt6795-pinctrl
>>>         - mediatek,mt6797-pinctrl
>>>
>>>     reg:
>>>  @@ -43,9 +45,10 @@ properties:
>>>     interrupt-controller: true
>>>
>>>     interrupts:
>>>  -    maxItems: 1
>>>  +    minItems: 1
>>>  +    maxItems: 2
>>>       description: |
>>>  -      Specifies the summary IRQ.
>>>  +      The interrupt outputs to sysirq.
>>
>> I am not sure if description is relevant now for all variants... what 
>> is
>> the sysirq? You have two interrupts so both go to one sysirq?
> 
> It's the system interrupt controller and it has several inputs. Both 
> interrupts go to it.

Then the naming is confusing because "sysirq" sounds like "system
interrupt".

> 
>>
>>>
>>>     "#interrupt-cells":
>>>       const: 2
>>>  @@ -81,6 +84,30 @@ allOf:
>>>               - const: iocfg_lt
>>>               - const: iocfg_tl
>>>               - const: eint
>>>  +
>>>  +        interrupts:
>>>  +          items:
>>>  +            - description: EINT interrupt
>>>  +
>>>  +  - if:
>>>  +      properties:
>>>  +        compatible:
>>>  +          contains:
>>>  +            const: mediatek,mt6795-pinctrl
>>>  +    then:
>>>  +      properties:
>>>  +        reg:
>>>  +          minItems: 2
>>
>> What's the maxItems? You declared reg and reg-names in top-level
>> properties as accepting anything, therefore you cannot have loose
>> constraints here.
> 
> That was an oversight. I'll fix it.
>>
>>>  +
>>>  +        reg-names:
>>>  +          items:
>>>  +            - const: base
>>>  +            - const: eint
>>>  +
>>>  +        interrupts:
>>>  +          items:
>>>  +            - description: EINT interrupt
>>>  +            - description: EINT event_b interrupt
>>
>> Blank line
>>
>>>     - if:
>>>         properties:
>>>           compatible:
>>>  @@ -111,32 +138,50 @@ allOf:
>>>           - "#interrupt-cells"
>>>
>>>   patternProperties:
>>>  -  '-[0-9]*$':
>>>  +  '-pins$':
>>>       type: object
>>>       additionalProperties: false
>>>
>>>       patternProperties:
>>>  -      '-pins*$':
>>>  +      '^pins':
>>>           type: object
>>>           description: |
>>>             A pinctrl node should contain at least one subnodes 
>>> representing the
>>>             pinctrl groups available on the machine. Each subnode 
>>> will list the
>>>             pins it needs, and how they should be configured, with 
>>> regard to muxer
>>>  -          configuration, pullups, drive strength, input 
>>> enable/disable and input schmitt.
>>>  -        $ref: "/schemas/pinctrl/pincfg-node.yaml"
>>>  +          configuration, pullups, drive strength, input 
>>> enable/disable and
>>>  +          input schmitt.
>>>  +        $ref: "pinmux-node.yaml"
>>
>> Drop quotes
>>
>> Why this one is not pincfg-node anymore? All your properties are not
>> valid then? You mix here so many changes it is a bit difficult to
>> understand the concept.
> 
> Seems like I didn't pay enough attention to that. This node actually 
> takes both pinmux-node (pinmux specifically) and pincfg-node 
> properties, so would it make sense to add ref for both?

Yes, and make changes in organized way, easier to read...

> 
>>
>>>
>>>           properties:
>>>             pinmux:
>>>               description:
>>>  -              integer array, represents gpio pin number and mux 
>>> setting.
>>>  -              Supported pin number and mux varies for different 
>>> SoCs, and are defined
>>>  -              as macros in boot/dts/<soc>-pinfunc.h directly.
>>>  +              Integer array, represents gpio pin number and mux 
>>> setting.
>>>  +              Supported pin number and mux varies for different 
>>> SoCs, and are
>>>  +              defined as macros in 
>>> dt-bindings/pinctrl/<soc>-pinfunc.h
>>>  +              directly.
>>>
>>>             bias-disable: true
>>>
>>>  -          bias-pull-up: true
>>>  -
>>>  -          bias-pull-down: true
>>>  +          bias-pull-up:
>>>  +            oneOf:
>>>  +              - type: boolean
>>>  +              - enum: [100, 101, 102, 103]
>>
>> Missing ref
>>
>>>  +                description: Pull up PUPD/R0/R1 type define value.
>>>  +            description: |
>>>  +               For normal pull up type, it is not necessary to 
>>> specify R1R0
>>>  +               values; When pull up type is PUPD/R0/R1, adding 
>>> R1R0 defines
>>>  +               will set different resistance values.
>>>  +
>>>  +          bias-pull-down:
>>>  +            oneOf:
>>>  +              - type: boolean
>>>  +              - enum: [100, 101, 102, 103]
>>
>> Missing ref
>>
>>>  +                description: Pull down PUPD/R0/R1 type define 
>>> value.
>>>  +            description: |
>>>  +               For normal pull down type, it is not necessary to 
>>> specify R1R0
>>>  +               values; When pull down type is PUPD/R0/R1, adding 
>>> R1R0 defines
>>>  +               will set different resistance values.
>>>
>>>             input-enable: true
>>>
>>>  @@ -151,7 +196,7 @@ patternProperties:
>>>             input-schmitt-disable: true
>>>
>>>             drive-strength:
>>>  -            enum: [2, 4, 8, 12, 16]
>>>  +            enum: [2, 4, 6, 8, 10, 12, 14, 16]
>>
>> Now you are missing ref - you do not have a type now, because you
>> removed pincfg-node. Split the merging of different pinctrl bindings 
>> and
>> reorganization.
> 
> Will do.
> 
>>
>> The drive strengths are also not valid for the other variant...
> 
> Actually the supported drive strengths vary between pins of a single 
> variant, so technically they have never been described completely 
> accurately. The old drive strenghs are a superset of strengths 
> supported by pins on the MT6779 pin controller, and this change expands 
> the superset with values supported by some pins in MT6795. Would it be 
> better to move this to the conditionals to have it defined per variant?

If they vary, then yes.


Best regards,
Krzysztof

