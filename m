Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85175F6E32
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiJFT1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiJFT0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:26:49 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8080B1144ED;
        Thu,  6 Oct 2022 12:26:43 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-134072c15c1so104080fac.2;
        Thu, 06 Oct 2022 12:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCfIAU4XMb60O7MjbbgmUxqie2tF6HVTSGKTzk1Ue+E=;
        b=y/z5fUXoU5lGDv3V2F8KQsYajZ8Ze8QXweL8/phAuI9NhKMbFrezIkmJxJSP9/XE45
         tok+AJrpH31xMRtXfuV3/qLlLCJFntdh9o3aFqyM1ZKxerU2JHSes9ONO4/pm/VZI3Bd
         4is4QC5COBSSvDX4lqJiSIrslk/gqMyC+zoumMnKYv1twcgC422bj9TMM3yMtEOnwp/X
         IHn8QAJnhqs2gl/tbdATUdk2fMZG2bbWm3A/PM/ClSVOUepOSnMdjA3OR7oc7njU8wuL
         hm9VVU36FtuRhMgra8DDWZX00dD/dd+1//PV7ymZKjeRYngwpc8FpZ9174AinD2VnQrf
         pfGg==
X-Gm-Message-State: ACrzQf05bjY8GToqiNBxfX+ebG8RL2POsbYmCjeC4uynhUHKUDC11VbA
        8wygv15De4+P7c/oSxlp0w==
X-Google-Smtp-Source: AMsMyM5+kBzVXKb8H9EzrAFDhADJ7Hy2DKKeEGGr/zYiwPbbTryldTxJ9M2hbxNwHxbnQldxlJq8pA==
X-Received: by 2002:a05:6870:5810:b0:127:a331:1e76 with SMTP id r16-20020a056870581000b00127a3311e76mr747672oap.292.1665084402259;
        Thu, 06 Oct 2022 12:26:42 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id 127-20020a4a1185000000b0044df311eee1sm8038ooc.33.2022.10.06.12.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:26:41 -0700 (PDT)
Received: (nullmailer pid 55788 invoked by uid 1000);
        Thu, 06 Oct 2022 19:26:39 -0000
Date:   Thu, 6 Oct 2022 14:26:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
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
Subject: Re: [PATCH v2 06/10] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Add MT6795
Message-ID: <20221006192639.GA49589-robh@kernel.org>
References: <20221005174343.24240-1-y.oudjana@protonmail.com>
 <20221005174343.24240-7-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005174343.24240-7-y.oudjana@protonmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 08:43:39PM +0300, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Combine MT6795 pin controller document into MT6779 one. In the
> process, replace the current interrupts property description with
> the one from the MT6795 document since it makes more sense. Also
> amend property descriptions with more detailed information that
> was available in the MT6795 document, and replace the current
> pinmux node name patterns with ones from it since they are more
> common across mediatek pin controller bindings.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../pinctrl/mediatek,mt6779-pinctrl.yaml      |  90 +++++--
>  .../pinctrl/mediatek,pinctrl-mt6795.yaml      | 225 ------------------
>  2 files changed, 73 insertions(+), 242 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
> index a2141eb0854e..64d4b6a3b5bd 100644
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
> @@ -43,9 +45,8 @@ properties:
>    interrupt-controller: true
>  
>    interrupts:
> -    maxItems: 1

minItems: 1
maxItems: 2

>      description: |
> -      Specifies the summary IRQ.
> +      The interrupt output to sysirq.
>  
>    "#interrupt-cells":
>      const: 2
> @@ -81,6 +82,28 @@ allOf:
>              - const: iocfg_lt
>              - const: iocfg_tl
>              - const: eint
> +
> +        interrupts:
> +          maxItems: 1
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
> +
> +        reg-names:
> +          items:
> +            - const: base
> +            - const: eint
> +
> +        interrupts:
> +          minItems: 2
> +          maxItems: 2

Just 'minItems: 2'

>    - if:
>        properties:
>          compatible:
> @@ -111,32 +134,65 @@ allOf:
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

Seems like these 2 changes would break a bunch of cases.

>          type: object
>          description: |
>            A pinctrl node should contain at least one subnodes representing the
>            pinctrl groups available on the machine. Each subnode will list the
>            pins it needs, and how they should be configured, with regard to muxer
> -          configuration, pullups, drive strength, input enable/disable and input schmitt.
> -        $ref: "/schemas/pinctrl/pincfg-node.yaml"
> +          configuration, pullups, drive strength, input enable/disable and
> +          input schmitt.
> +          An example of using macro:
> +          pincontroller {
> +            /* GPIO0 set as multifunction GPIO0 */
> +            gpio-pins {
> +              pins {
> +                pinmux = <PINMUX_GPIO0__FUNC_GPIO0>;
> +              }
> +            };
> +            /* GPIO45 set as multifunction SDA0 */
> +            i2c0-pins {
> +              pins {
> +                pinmux = <PINMUX_GPIO45__FUNC_SDA0>;
> +              }
> +            };
> +          };

Just put this in the actual example.

> +        $ref: "pinmux-node.yaml"
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
> +                description: Pull down PUPD/R0/R1 type define value.
> +            description: |
> +               For normal pull down type, it is not necessary to specify R1R0
> +               values; When pull down type is PUPD/R0/R1, adding R1R0 defines
> +               will set different resistance values.
>  
>            input-enable: true
>  
> @@ -151,7 +207,7 @@ patternProperties:
>            input-schmitt-disable: true
>  
>            drive-strength:
> -            enum: [2, 4, 8, 12, 16]
> +            enum: [2, 4, 6, 8, 10, 12, 14, 16]
>  
>            slew-rate:
>              enum: [0, 1]
> @@ -218,8 +274,8 @@ examples:
>              #interrupt-cells = <2>;
>              interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
>  
> -            mmc0_pins_default: mmc0-0 {
> -                cmd-dat-pins {
> +            mmc0_pins_default: mmc0-pins {
> +                pins-cmd-dat {
>                      pinmux = <PINMUX_GPIO168__FUNC_MSDC0_DAT0>,
>                          <PINMUX_GPIO172__FUNC_MSDC0_DAT1>,
>                          <PINMUX_GPIO169__FUNC_MSDC0_DAT2>,
> @@ -232,11 +288,11 @@ examples:
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
