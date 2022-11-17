Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6841862E0A6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239956AbiKQQAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbiKQQAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:00:43 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96728167FF;
        Thu, 17 Nov 2022 08:00:39 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id l127so2308289oia.8;
        Thu, 17 Nov 2022 08:00:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1iYFV/pk3VtxO2Vv/uRHQvi4wu62XG1HbiVw4tLmgA=;
        b=Ube61iOK6nv4L9b0waxDPQqb6rTflRHew2dno5HjNlH4gEKGPixrF6UIpLN1chc2mF
         IEaIU0OP0BZls/l+MGdtdNCq5w0nJCQOOkk84vF1k+Fd70lyl6PXR+Ed1WMR0BLZ8xkm
         +FGOzftTr8kqqhaGcmyg3flIyD1hxEPoguX9UdeTrspkMAMCxeOtt1NF8otfDQQRWO3V
         iekPTYjxP+cFHsJ4hLnFpT3YqFoFei0n1QVg/CfxbGkHCJQUzFpXxwTYVX6MoJLk4N5m
         wNCGiVBSR99fIaFPXZn1ZKuo/VBkOM8+k/Y40OBJkxQk8TiYgqKKsbKesPcqQTKf95hJ
         kmDQ==
X-Gm-Message-State: ANoB5pmhvLJEwwQDMI3kdocChfn5Qu8rkeP7xu+yPx3K9mmAhUXfjqMH
        Ozc8C8CKBiDpy+E5iom6TA==
X-Google-Smtp-Source: AA0mqf5qHLQTURJi2r+QuYwmtK6l/Uins36ngd8s4Y3T/DUk0YNW/CdISa+Z16Dhzxc3RQDy3uZlng==
X-Received: by 2002:aca:1308:0:b0:354:94c3:2b33 with SMTP id e8-20020aca1308000000b0035494c32b33mr4405489oii.247.1668700839047;
        Thu, 17 Nov 2022 08:00:39 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p15-20020a056870568f00b0014185b2b3d5sm579786oao.18.2022.11.17.08.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:00:38 -0800 (PST)
Received: (nullmailer pid 2943020 invoked by uid 1000);
        Thu, 17 Nov 2022 16:00:40 -0000
Date:   Thu, 17 Nov 2022 10:00:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Flora Fu <flora.fu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-leds@vger.kernel.org, Fabien Parent <fparent@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-rtc@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v5 06/10] dt-bindings: soc: mediatek: convert pwrap
 documentation
Message-ID: <20221117160040.GB2913522-robh@kernel.org>
References: <20221005-mt6357-support-v5-0-8210d955dd3d@baylibre.com>
 <20221005-mt6357-support-v5-6-8210d955dd3d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005-mt6357-support-v5-6-8210d955dd3d@baylibre.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 01:33:00PM +0100, Alexandre Mergnat wrote:
> - Convert soc/mediatek/pwrap.txt to soc/mediatek/mediatek,pwrap.yaml
> - MT8365 SoC has 2 additional clock items and a yaml schema for its PMIC
> - Remove pwrap.txt file
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  .../devicetree/bindings/leds/leds-mt6323.txt       |   2 +-
>  Documentation/devicetree/bindings/mfd/mt6397.txt   |   2 +-
>  .../bindings/soc/mediatek/mediatek,pwrap.yaml      | 145 +++++++++++++++++++++
>  .../devicetree/bindings/soc/mediatek/pwrap.txt     |  75 -----------
>  4 files changed, 147 insertions(+), 77 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-mt6323.txt b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
> index 45bf9f7d85f3..73353692efa1 100644
> --- a/Documentation/devicetree/bindings/leds/leds-mt6323.txt
> +++ b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
> @@ -9,7 +9,7 @@ MT6323 PMIC hardware.
>  For MT6323 MFD bindings see:
>  Documentation/devicetree/bindings/mfd/mt6397.txt
>  For MediaTek PMIC wrapper bindings see:
> -Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> +Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
>  
>  Required properties:
>  - compatible : Must be "mediatek,mt6323-led"
> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
> index 79aaf21af8e9..3bee4a42555d 100644
> --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
> +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
> @@ -13,7 +13,7 @@ MT6397/MT6323 is a multifunction device with the following sub modules:
>  It is interfaced to host controller using SPI interface by a proprietary hardware
>  called PMIC wrapper or pwrap. MT6397/MT6323 MFD is a child device of pwrap.
>  See the following for pwarp node definitions:
> -../soc/mediatek/pwrap.txt
> +../soc/mediatek/mediatek,pwrap.yaml
>  
>  This document describes the binding for MFD device and its sub module.
>  
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> new file mode 100644
> index 000000000000..6d19f534e994
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> @@ -0,0 +1,145 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/mediatek/mediatek,pwrap.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek PMIC Wrapper
> +
> +maintainers:
> +  - Flora Fu <flora.fu@mediatek.com>
> +  - Alexandre Mergnat <amergnat@baylibre.com>
> +
> +description: |
> +  On MediaTek SoCs the PMIC is connected via SPI. The SPI master interface
> +  is not directly visible to the CPU, but only through the PMIC wrapper
> +  inside the SoC. The communication between the SoC and the PMIC can
> +  optionally be encrypted. Also a non standard Dual IO SPI mode can be
> +  used to increase speed.
> +
> +  IP Pairing
> +
> +  On MT8135 the pins of some SoC internal peripherals can be on the PMIC.
> +  The signals of these pins are routed over the SPI bus using the pwrap
> +  bridge. In the binding description below the properties needed for bridging
> +  are marked with "IP Pairing". These are optional on SoCs which do not support
> +  IP Pairing
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - mediatek,mt2701-pwrap
> +              - mediatek,mt6765-pwrap
> +              - mediatek,mt6779-pwrap
> +              - mediatek,mt6797-pwrap
> +              - mediatek,mt6873-pwrap
> +              - mediatek,mt7622-pwrap
> +              - mediatek,mt8135-pwrap
> +              - mediatek,mt8173-pwrap
> +              - mediatek,mt8183-pwrap
> +              - mediatek,mt8188-pwrap
> +              - mediatek,mt8365-pwrap
> +              - mediatek,mt8516-pwrap
> +      - items:
> +          - enum:
> +              - mediatek,mt8186-pwrap
> +              - mediatek,mt8195-pwrap
> +          - const: syscon
> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description: PMIC wrapper registers
> +      - description: IP pairing registers
> +
> +  reg-names:
> +    minItems: 1
> +    items:
> +      - const: pwrap
> +      - const: pwrap-bridge
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +    items:
> +      - description: SPI bus clock
> +      - description: Main module clock
> +      - description: System module clock
> +      - description: Timer module clock
> +
> +  clock-names:
> +    minItems: 2
> +    items:
> +      - const: spi
> +      - const: wrap
> +      - const: sys
> +      - const: tmr
> +
> +  resets:
> +    minItems: 1
> +    items:
> +      - description: PMIC wrapper reset
> +      - description: IP pairing reset
> +
> +  reset-names:
> +    minItems: 1
> +    items:
> +      - const: pwrap
> +      - const: pwrap-bridge
> +
> +  pmic:
> +    type: object
> +    $ref: /schemas/regulator/mediatek,mt6357-regulator.yaml

Drop the $ref. It will get validated by matching the pmic compatible.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +dependentRequired:
> +  resets: [reset-names]
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8365-pwrap
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 4
> +
> +        clock-names:
> +          minItems: 4
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/mediatek,mt8365-clk.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        pwrap: pwrap@1000d000 {

Drop unused labels.

> +            compatible = "mediatek,mt8365-pwrap";
> +            reg = <0 0x1000d000 0 0x1000>;
> +            reg-names = "pwrap";
> +            interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&infracfg CLK_IFR_PWRAP_SPI>,
> +                     <&infracfg CLK_IFR_PMIC_AP>,
> +                     <&infracfg CLK_IFR_PWRAP_SYS>,
> +                     <&infracfg CLK_IFR_PWRAP_TMR>;
> +            clock-names = "spi", "wrap", "sys", "tmr";
> +        };
> +    };
