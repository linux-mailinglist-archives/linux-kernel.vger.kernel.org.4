Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FCE5F9D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 13:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiJJL1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 07:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiJJL1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:27:15 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974D65F23A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 04:27:13 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id l19so6933994qvu.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 04:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=odSCtf43g66m4iDOcahuiv+23dWqctEIwhRpyIp7LRM=;
        b=vVwRl2+cxrmVghzaCBVUULCU9KLvC31/LWln8VhhDZMNw3L7RaI4QOyk/CNZfvEiDk
         K3SFX0lHUdIfSRxiuNZ86uDcoVfWW32Uxsu0V0R5+v0zHNOpIPJXcp/IVX8j0vhwDSYj
         sFrinDihgKoIbwWecHFGqf29GNIWLZ4TlnhErhjurg4wyRB1PLPmEbvHC+mlMaRy/+Vr
         zXBQnBUhwNOe+pZlc3BaH9eeEf5Ggf0U6mTyTMcdd/d0beIo8t+ZXo1b8OAJRmw6zkCX
         VzfoZWRMy5rmuvN5xjlP4Uxk4CSheZyGUVFEoRtvNED0rJ9FjEEynQzJOmsBYF58PLn+
         NO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odSCtf43g66m4iDOcahuiv+23dWqctEIwhRpyIp7LRM=;
        b=o/RX8Ch5sOANs14cBia8PH2KsYwE4Lp9pxbigk7/2yWfYLbMgsEgJqmWn2Qjrhug8q
         lZ6hjKaQTWLrab7PFIrDnn0doNK3dqQxb4/rRW2if27g2BcjVFcyhNTUGcNkRiI1u2Xq
         N8xojEvLWG42abHKcL1Ki7nTipJ6P9LVYINoB5aR3ocewUiMfsTKq/mQCqnytyAaq8Gt
         ZObJEUzxT3STWVeOtnETI0TriQ+PiQ6grcZKl4+vVd/F3VoEH09o/zrhcijO6vqjn5q3
         cchgB+VEsLTRv4sL+DDmjsORsyX6yfAqoemjXzpY7B87z9AYQ1SvlgxHigNXSmSRxwZh
         8dNQ==
X-Gm-Message-State: ACrzQf1EsEHauBQCp8OEgyNBLSdpbQtWVZjkUi9nf9mxb8PTeitwKPyf
        WyQUUEq/h6IxTnutk76ESiNpLA==
X-Google-Smtp-Source: AMsMyM4yb53ZqK0THwHxH5mjARAZ1MjhYrO0IFD3HwvWL7rGl1jjhLngIhfmBWjjPyclz+YTHKodiA==
X-Received: by 2002:a05:6214:766:b0:4b3:e83b:6e8a with SMTP id f6-20020a056214076600b004b3e83b6e8amr7403207qvz.53.1665401232727;
        Mon, 10 Oct 2022 04:27:12 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id de14-20020a05620a370e00b006e07228ed53sm5969368qkb.18.2022.10.10.04.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 04:27:11 -0700 (PDT)
Message-ID: <0f078a85-056a-c11e-377b-27764a34485d@linaro.org>
Date:   Mon, 10 Oct 2022 07:24:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 06/10] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Add MT6795
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221007125904.55371-1-y.oudjana@protonmail.com>
 <20221007125904.55371-7-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221007125904.55371-7-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2022 08:59, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Combine MT6795 pin controller document into MT6779 one. In the
> process, replace the current interrupts property description with
> the one from the MT6795 document since it makes more sense. Also
> amend property descriptions and examples with more detailed
> information that was available in the MT6795 document, and replace
> the current pinmux node name patterns with ones from it since they
> are more common across mediatek pin controller bindings.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../pinctrl/mediatek,mt6779-pinctrl.yaml      |  94 ++++++--
>  .../pinctrl/mediatek,pinctrl-mt6795.yaml      | 227 ------------------
>  2 files changed, 77 insertions(+), 244 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
> index a2141eb0854e..cada3530dd0a 100644
> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
> @@ -8,6 +8,7 @@ title: Mediatek MT6779 Pin Controller
>  
>  maintainers:
>    - Andy Teng <andy.teng@mediatek.com>
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>    - Sean Wang <sean.wang@kernel.org>
>  
>  description:
> @@ -18,6 +19,7 @@ properties:
>    compatible:
>      enum:
>        - mediatek,mt6779-pinctrl
> +      - mediatek,mt6795-pinctrl
>        - mediatek,mt6797-pinctrl
>  
>    reg:
> @@ -43,9 +45,10 @@ properties:
>    interrupt-controller: true
>  
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>      description: |
> -      Specifies the summary IRQ.
> +      The interrupt outputs to sysirq.

I am not sure if description is relevant now for all variants... what is
the sysirq? You have two interrupts so both go to one sysirq?

>  
>    "#interrupt-cells":
>      const: 2
> @@ -81,6 +84,30 @@ allOf:
>              - const: iocfg_lt
>              - const: iocfg_tl
>              - const: eint
> +
> +        interrupts:
> +          items:
> +            - description: EINT interrupt
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt6795-pinctrl
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2

What's the maxItems? You declared reg and reg-names in top-level
properties as accepting anything, therefore you cannot have loose
constraints here.


> +
> +        reg-names:
> +          items:
> +            - const: base
> +            - const: eint
> +
> +        interrupts:
> +          items:
> +            - description: EINT interrupt
> +            - description: EINT event_b interrupt

Blank line

>    - if:
>        properties:
>          compatible:
> @@ -111,32 +138,50 @@ allOf:
>          - "#interrupt-cells"
>  
>  patternProperties:
> -  '-[0-9]*$':
> +  '-pins$':
>      type: object
>      additionalProperties: false
>  
>      patternProperties:
> -      '-pins*$':
> +      '^pins':
>          type: object
>          description: |
>            A pinctrl node should contain at least one subnodes representing the
>            pinctrl groups available on the machine. Each subnode will list the
>            pins it needs, and how they should be configured, with regard to muxer
> -          configuration, pullups, drive strength, input enable/disable and input schmitt.
> -        $ref: "/schemas/pinctrl/pincfg-node.yaml"
> +          configuration, pullups, drive strength, input enable/disable and
> +          input schmitt.
> +        $ref: "pinmux-node.yaml"

Drop quotes

Why this one is not pincfg-node anymore? All your properties are not
valid then? You mix here so many changes it is a bit difficult to
understand the concept.

>  
>          properties:
>            pinmux:
>              description:
> -              integer array, represents gpio pin number and mux setting.
> -              Supported pin number and mux varies for different SoCs, and are defined
> -              as macros in boot/dts/<soc>-pinfunc.h directly.
> +              Integer array, represents gpio pin number and mux setting.
> +              Supported pin number and mux varies for different SoCs, and are
> +              defined as macros in dt-bindings/pinctrl/<soc>-pinfunc.h
> +              directly.
>  
>            bias-disable: true
>  
> -          bias-pull-up: true
> -
> -          bias-pull-down: true
> +          bias-pull-up:
> +            oneOf:
> +              - type: boolean
> +              - enum: [100, 101, 102, 103]

Missing ref

> +                description: Pull up PUPD/R0/R1 type define value.
> +            description: |
> +               For normal pull up type, it is not necessary to specify R1R0
> +               values; When pull up type is PUPD/R0/R1, adding R1R0 defines
> +               will set different resistance values.
> +
> +          bias-pull-down:
> +            oneOf:
> +              - type: boolean
> +              - enum: [100, 101, 102, 103]

Missing ref

> +                description: Pull down PUPD/R0/R1 type define value.
> +            description: |
> +               For normal pull down type, it is not necessary to specify R1R0
> +               values; When pull down type is PUPD/R0/R1, adding R1R0 defines
> +               will set different resistance values.
>  
>            input-enable: true
>  
> @@ -151,7 +196,7 @@ patternProperties:
>            input-schmitt-disable: true
>  
>            drive-strength:
> -            enum: [2, 4, 8, 12, 16]
> +            enum: [2, 4, 6, 8, 10, 12, 14, 16]

Now you are missing ref - you do not have a type now, because you
removed pincfg-node. Split the merging of different pinctrl bindings and
reorganization.

The drive strengths are also not valid for the other variant...

>  
>            slew-rate:
>              enum: [0, 1]
> @@ -218,8 +263,9 @@ examples:
>              #interrupt-cells = <2>;
>              interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
>  
> -            mmc0_pins_default: mmc0-0 {
> -                cmd-dat-pins {
> +            /* GPIOs 167-174, 176-178 set as multifunction MSDC0 */
> +            mmc0_pins_default: mmc0-pins {
> +                pins-cmd-dat {
>                      pinmux = <PINMUX_GPIO168__FUNC_MSDC0_DAT0>,
>                          <PINMUX_GPIO172__FUNC_MSDC0_DAT1>,
>                          <PINMUX_GPIO169__FUNC_MSDC0_DAT2>,
> @@ -232,15 +278,29 @@ examples:
>                      input-enable;
>                      mediatek,pull-up-adv = <1>;
>                  };
> -                clk-pins {
> +                pins-clk {
>                      pinmux = <PINMUX_GPIO176__FUNC_MSDC0_CLK>;
>                      mediatek,pull-down-adv = <2>;
>                  };
> -                rst-pins {
> +                pins-rst {
>                      pinmux = <PINMUX_GPIO178__FUNC_MSDC0_RSTB>;
>                      mediatek,pull-up-adv = <0>;
>                  };

Best regards,
Krzysztof

