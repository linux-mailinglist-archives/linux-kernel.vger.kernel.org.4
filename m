Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46ED3605F06
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiJTLgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiJTLgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:36:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2BB19B67A;
        Thu, 20 Oct 2022 04:36:32 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id l22so29461835edj.5;
        Thu, 20 Oct 2022 04:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2hBzpuTfcLKm/gHU0j1Rb5iDzN0jpTw27RMtS7S6QiY=;
        b=LvS7i/tU9BiRY+bnSEBZx2dHBwo+AeR3GLscVXRJPEgvwLRi0gmXL7Y0hcbVsCXxdh
         GNpDRQjbUKZdTqjAn1gn9SbWj65eppSj30Gm0uUzaE1ijQYGhBN6GOce/D0Jn8SZTaVf
         zWUxff7rS68KU/SKGxDQnSl5yPYCYsmQ7lYWyl10VS0/qpS+zeEYE0c2UB6H++W3zTTz
         I4Qo/dlwvqgllRwT46z0hCtGhIT14yM83rpxBBqLAEVyrrx/oHn6Co5q/4xD50a1SZt8
         sh785bCyqPAHEDs0ZFGJ1VPgcJ6zK54ZGw8cj78YQNfRm/+AudEZSSjdzONlVTlyRBgP
         wqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hBzpuTfcLKm/gHU0j1Rb5iDzN0jpTw27RMtS7S6QiY=;
        b=z6nLix1ZrqCrkYawsC0nTTrtyJKOKi7jPQ3ymkxLuOkfwqVHp/b7s7zhKHZVFu3Vir
         /ZdaYcWKmIjkXldf7c567sJ8qFdNDT/BU4hNtwc2d/Wf+Al6kH3sgwI6jmsBjfbXXJMr
         P737TuV4vIOUwy6udWyogckBcfxcrNcLwqc7mEMMS9akCRhSZeolHlr6REEwnCixdobh
         aXX3lBf5nvRXsMeeglsyJWgiA1WfeNc9fcGQG2rrAUaITXHsgEFpWaIhJU20oDmAdb6R
         LFPhvvru1nQTf1g+YPdmVv4l/mOkObRjy8wLN7jizMiGmGWyrkhxcz+kuJ8L+CY3Tr/F
         ff9A==
X-Gm-Message-State: ACrzQf1gV9q9MGIUs7TL6oHOYqIdZmIbGbOW0p/IRRfb4Nz5bv9pZp6V
        9dhCc0nOGG+COPfLSt6cWr6F9YrHJqXqgA==
X-Google-Smtp-Source: AMsMyM642cRbJkWRb0REHkacf8Zt0nE8dOnuVHN/e2FpIG0h/B96y1K0ZYrvtgKxLuw2QF0YLHrl6A==
X-Received: by 2002:a17:907:da7:b0:791:8f57:6860 with SMTP id go39-20020a1709070da700b007918f576860mr10947353ejc.509.1666265779656;
        Thu, 20 Oct 2022 04:36:19 -0700 (PDT)
Received: from [10.32.3.204] ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id bd13-20020a056402206d00b004590b29d8afsm12108770edb.84.2022.10.20.04.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 04:36:18 -0700 (PDT)
Date:   Thu, 20 Oct 2022 14:36:08 +0300
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH v3 06/10] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Add MT6795
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
Message-Id: <8WU1KR.065JU8WYUX9C3@gmail.com>
In-Reply-To: <0f078a85-056a-c11e-377b-27764a34485d@linaro.org>
References: <20221007125904.55371-1-y.oudjana@protonmail.com>
        <20221007125904.55371-7-y.oudjana@protonmail.com>
        <0f078a85-056a-c11e-377b-27764a34485d@linaro.org>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Oct 10 2022 at 07:24:59 -04:00:00, Krzysztof Kozlowski 
<krzysztof.kozlowski@linaro.org> wrote:
> On 07/10/2022 08:59, Yassine Oudjana wrote:
>>  From: Yassine Oudjana <y.oudjana@protonmail.com>
>> 
>>  Combine MT6795 pin controller document into MT6779 one. In the
>>  process, replace the current interrupts property description with
>>  the one from the MT6795 document since it makes more sense. Also
>>  amend property descriptions and examples with more detailed
>>  information that was available in the MT6795 document, and replace
>>  the current pinmux node name patterns with ones from it since they
>>  are more common across mediatek pin controller bindings.
>> 
>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>  ---
>>   .../pinctrl/mediatek,mt6779-pinctrl.yaml      |  94 ++++++--
>>   .../pinctrl/mediatek,pinctrl-mt6795.yaml      | 227 
>> ------------------
>>   2 files changed, 77 insertions(+), 244 deletions(-)
>>   delete mode 100644 
>> Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
>> 
>>  diff --git 
>> a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml 
>> b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
>>  index a2141eb0854e..cada3530dd0a 100644
>>  --- 
>> a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
>>  +++ 
>> b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
>>  @@ -8,6 +8,7 @@ title: Mediatek MT6779 Pin Controller
>> 
>>   maintainers:
>>     - Andy Teng <andy.teng@mediatek.com>
>>  +  - AngeloGioacchino Del Regno 
>> <angelogioacchino.delregno@collabora.com>
>>     - Sean Wang <sean.wang@kernel.org>
>> 
>>   description:
>>  @@ -18,6 +19,7 @@ properties:
>>     compatible:
>>       enum:
>>         - mediatek,mt6779-pinctrl
>>  +      - mediatek,mt6795-pinctrl
>>         - mediatek,mt6797-pinctrl
>> 
>>     reg:
>>  @@ -43,9 +45,10 @@ properties:
>>     interrupt-controller: true
>> 
>>     interrupts:
>>  -    maxItems: 1
>>  +    minItems: 1
>>  +    maxItems: 2
>>       description: |
>>  -      Specifies the summary IRQ.
>>  +      The interrupt outputs to sysirq.
> 
> I am not sure if description is relevant now for all variants... what 
> is
> the sysirq? You have two interrupts so both go to one sysirq?

It's the system interrupt controller and it has several inputs. Both 
interrupts go to it.

> 
>> 
>>     "#interrupt-cells":
>>       const: 2
>>  @@ -81,6 +84,30 @@ allOf:
>>               - const: iocfg_lt
>>               - const: iocfg_tl
>>               - const: eint
>>  +
>>  +        interrupts:
>>  +          items:
>>  +            - description: EINT interrupt
>>  +
>>  +  - if:
>>  +      properties:
>>  +        compatible:
>>  +          contains:
>>  +            const: mediatek,mt6795-pinctrl
>>  +    then:
>>  +      properties:
>>  +        reg:
>>  +          minItems: 2
> 
> What's the maxItems? You declared reg and reg-names in top-level
> properties as accepting anything, therefore you cannot have loose
> constraints here.

That was an oversight. I'll fix it.
> 
>>  +
>>  +        reg-names:
>>  +          items:
>>  +            - const: base
>>  +            - const: eint
>>  +
>>  +        interrupts:
>>  +          items:
>>  +            - description: EINT interrupt
>>  +            - description: EINT event_b interrupt
> 
> Blank line
> 
>>     - if:
>>         properties:
>>           compatible:
>>  @@ -111,32 +138,50 @@ allOf:
>>           - "#interrupt-cells"
>> 
>>   patternProperties:
>>  -  '-[0-9]*$':
>>  +  '-pins$':
>>       type: object
>>       additionalProperties: false
>> 
>>       patternProperties:
>>  -      '-pins*$':
>>  +      '^pins':
>>           type: object
>>           description: |
>>             A pinctrl node should contain at least one subnodes 
>> representing the
>>             pinctrl groups available on the machine. Each subnode 
>> will list the
>>             pins it needs, and how they should be configured, with 
>> regard to muxer
>>  -          configuration, pullups, drive strength, input 
>> enable/disable and input schmitt.
>>  -        $ref: "/schemas/pinctrl/pincfg-node.yaml"
>>  +          configuration, pullups, drive strength, input 
>> enable/disable and
>>  +          input schmitt.
>>  +        $ref: "pinmux-node.yaml"
> 
> Drop quotes
> 
> Why this one is not pincfg-node anymore? All your properties are not
> valid then? You mix here so many changes it is a bit difficult to
> understand the concept.

Seems like I didn't pay enough attention to that. This node actually 
takes both pinmux-node (pinmux specifically) and pincfg-node 
properties, so would it make sense to add ref for both?

> 
>> 
>>           properties:
>>             pinmux:
>>               description:
>>  -              integer array, represents gpio pin number and mux 
>> setting.
>>  -              Supported pin number and mux varies for different 
>> SoCs, and are defined
>>  -              as macros in boot/dts/<soc>-pinfunc.h directly.
>>  +              Integer array, represents gpio pin number and mux 
>> setting.
>>  +              Supported pin number and mux varies for different 
>> SoCs, and are
>>  +              defined as macros in 
>> dt-bindings/pinctrl/<soc>-pinfunc.h
>>  +              directly.
>> 
>>             bias-disable: true
>> 
>>  -          bias-pull-up: true
>>  -
>>  -          bias-pull-down: true
>>  +          bias-pull-up:
>>  +            oneOf:
>>  +              - type: boolean
>>  +              - enum: [100, 101, 102, 103]
> 
> Missing ref
> 
>>  +                description: Pull up PUPD/R0/R1 type define value.
>>  +            description: |
>>  +               For normal pull up type, it is not necessary to 
>> specify R1R0
>>  +               values; When pull up type is PUPD/R0/R1, adding 
>> R1R0 defines
>>  +               will set different resistance values.
>>  +
>>  +          bias-pull-down:
>>  +            oneOf:
>>  +              - type: boolean
>>  +              - enum: [100, 101, 102, 103]
> 
> Missing ref
> 
>>  +                description: Pull down PUPD/R0/R1 type define 
>> value.
>>  +            description: |
>>  +               For normal pull down type, it is not necessary to 
>> specify R1R0
>>  +               values; When pull down type is PUPD/R0/R1, adding 
>> R1R0 defines
>>  +               will set different resistance values.
>> 
>>             input-enable: true
>> 
>>  @@ -151,7 +196,7 @@ patternProperties:
>>             input-schmitt-disable: true
>> 
>>             drive-strength:
>>  -            enum: [2, 4, 8, 12, 16]
>>  +            enum: [2, 4, 6, 8, 10, 12, 14, 16]
> 
> Now you are missing ref - you do not have a type now, because you
> removed pincfg-node. Split the merging of different pinctrl bindings 
> and
> reorganization.

Will do.

> 
> The drive strengths are also not valid for the other variant...

Actually the supported drive strengths vary between pins of a single 
variant, so technically they have never been described completely 
accurately. The old drive strenghs are a superset of strengths 
supported by pins on the MT6779 pin controller, and this change expands 
the superset with values supported by some pins in MT6795. Would it be 
better to move this to the conditionals to have it defined per variant?

>> 
>>             slew-rate:
>>               enum: [0, 1]
>>  @@ -218,8 +263,9 @@ examples:
>>               #interrupt-cells = <2>;
>>               interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
>> 
>>  -            mmc0_pins_default: mmc0-0 {
>>  -                cmd-dat-pins {
>>  +            /* GPIOs 167-174, 176-178 set as multifunction MSDC0 */
>>  +            mmc0_pins_default: mmc0-pins {
>>  +                pins-cmd-dat {
>>                       pinmux = <PINMUX_GPIO168__FUNC_MSDC0_DAT0>,
>>                           <PINMUX_GPIO172__FUNC_MSDC0_DAT1>,
>>                           <PINMUX_GPIO169__FUNC_MSDC0_DAT2>,
>>  @@ -232,15 +278,29 @@ examples:
>>                       input-enable;
>>                       mediatek,pull-up-adv = <1>;
>>                   };
>>  -                clk-pins {
>>  +                pins-clk {
>>                       pinmux = <PINMUX_GPIO176__FUNC_MSDC0_CLK>;
>>                       mediatek,pull-down-adv = <2>;
>>                   };
>>  -                rst-pins {
>>  +                pins-rst {
>>                       pinmux = <PINMUX_GPIO178__FUNC_MSDC0_RSTB>;
>>                       mediatek,pull-up-adv = <0>;
>>                   };
> 
> Best regards,
> Krzysztof
> 


