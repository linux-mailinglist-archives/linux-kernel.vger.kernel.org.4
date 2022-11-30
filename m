Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E62563D929
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiK3PUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiK3PUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:20:44 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73017CAA9;
        Wed, 30 Nov 2022 07:20:43 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id v82so19085531oib.4;
        Wed, 30 Nov 2022 07:20:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jM4V3HsCT7rorlCWcJ+dqKKOi0VzU8rHkgsnq8OiKN8=;
        b=N6xz/caGQ0FgkbHFGFieH7MD4usUZpHJi01Jq409xlQHWHgPqjo0VUQgnqPXutOTYB
         MZ8Fdo/JcQOgN5uN9vKQ3IlgrK0FkTcj9O8gtSB+nrF3pMGkhhky/Camv2I6LKiGfPBY
         tr7sbK/NlixqYEamVs9umZRFotLFjptu/f5TGBjUWV24+pXsbBIg2LCuAlbmdAL72+xo
         6zPciI1dZFMXYC0Ef7k96jInBknYG/vRPaVikE46rkJ2XzJLQsSmd41bawJv108Sd/kc
         fqIAaFLPKX7SX/HLSljxj7FEH6Fz++nRZRXkesmdgqcj68BtzEBFsuHcsJviezJl8/bf
         CDvg==
X-Gm-Message-State: ANoB5pkMfF+/D0PEXpl7GtXSb88cq8weoDtYoGQgeRIZmkJYnMjMxy3N
        sUWvJM05pkzTzd1GrHdekA==
X-Google-Smtp-Source: AA0mqf7ApQ5kvzIDzKBVe+cAtlPGoe5vVxWFF49PaZMb322Wqs6APaQzCb6e5snjskmEj/P1TDyBzA==
X-Received: by 2002:a05:6808:1592:b0:35a:e1a7:c3b2 with SMTP id t18-20020a056808159200b0035ae1a7c3b2mr19792205oiw.223.1669821643133;
        Wed, 30 Nov 2022 07:20:43 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t32-20020a05687063a000b00132784a3a1fsm1245231oap.46.2022.11.30.07.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 07:20:42 -0800 (PST)
Received: (nullmailer pid 2187928 invoked by uid 1000);
        Wed, 30 Nov 2022 15:20:41 -0000
Date:   Wed, 30 Nov 2022 09:20:41 -0600
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
Subject: Re: [PATCH v5 1/7] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Pull pinctrl node changes from MT6795 document
Message-ID: <20221130152041.GA2183918-robh@kernel.org>
References: <20221118113028.145348-1-y.oudjana@protonmail.com>
 <20221118113028.145348-2-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118113028.145348-2-y.oudjana@protonmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 02:30:22PM +0300, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> mediatek,pinctrl-mt6795.yaml has different node name patterns which match
> bindings of other MediaTek pin controllers, ref for pinmux-node.yaml which
> has a description of the pinmux property, as well as some additional
> descriptions for some pin configuration properties. Pull those changes
> into mediatek,mt6779-pinctrl.yaml and adjust the example DTS to match in
> preparation to combine the MT6795 document into it.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 38 ++++++++++++++-----
>  1 file changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
> index a2141eb0854e..d6231d11e949 100644
> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
> @@ -111,19 +111,21 @@ allOf:
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
>            configuration, pullups, drive strength, input enable/disable and input schmitt.
> -        $ref: "/schemas/pinctrl/pincfg-node.yaml"
> +        allOf:
> +          - $ref: pinmux-node.yaml
> +          - $ref: pincfg-node.yaml
>  
>          properties:
>            pinmux:
> @@ -134,9 +136,25 @@ patternProperties:
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
> +              For normal pull up type, it is not necessary to specify R1R0
> +              values; When pull up type is PUPD/R0/R1, adding R1R0 defines
> +              will set different resistance values.
> +
> +          bias-pull-down:
> +            oneOf:
> +              - type: boolean
> +              - enum: [100, 101, 102, 103]

'bias-pull-down' is defined to be in Ohms. This doesn't look like it's 
Ohms.

> +                description: Pull down PUPD/R0/R1 type define value.
> +            description: |
> +              For normal pull down type, it is not necessary to specify R1R0
> +              values; When pull down type is PUPD/R0/R1, adding R1R0 defines
> +              will set different resistance values.
>  
>            input-enable: true
>  
> @@ -218,8 +236,8 @@ examples:
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
> @@ -232,11 +250,11 @@ examples:
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
> -- 
> 2.38.1
> 
> 
