Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9508862E113
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240147AbiKQQHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240396AbiKQQGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:06:53 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796467990C;
        Thu, 17 Nov 2022 08:06:41 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j15so4062998wrq.3;
        Thu, 17 Nov 2022 08:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DlkvAywvSOZOTHLHgCQs8OyQfQVVx2d97f+6Pgy24kg=;
        b=HM+bLkYeUx6aUjLQoJYA1sWuTr1elr63hEZh7Dbd8UxFAdm+Wi8/mStf58xsA5wxGe
         +9fReIsdYl8XO2UEyREsGCwsV89q1uMqYsGZV+2kuut/dGyVYaP90VLBUELKpk2LUc9N
         T2/YZUISZjwwVxacwkJMI3SCDQfyPllUl2IrNY00RgUsgochWCIgUylKYMq49c/aoWdc
         3hpHgx7GHht5/eEW6zXDL9ovpJq+mlvubSKq4lFSkldLsQgRYArnjLrLgX2cdll8ZsRp
         AYb7Ahit8puRg2CclW5REDpA2cS+HQTlMcjPWC9CWd1RTvObD+G+ALP82TJQICdbT1J1
         AjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlkvAywvSOZOTHLHgCQs8OyQfQVVx2d97f+6Pgy24kg=;
        b=OS20CHRgjCKbcy7DqJhFKEboCcmfmpaRC1Xzh55mNXVZhzRs9h16kbRkgshihf4LHO
         5bUeAezVHvaUW5IaZrIdYMKBCB0WClJw+fBMmLvXlLAfwA6IPW4EPChcJ3uhlQxJTfdi
         Kd3E1GyQRpERfBMUa0UewqErwqbBanpLSKmU9ue3VztMSrBWkJAXo6IRjkwvgZqZG36m
         yXTRoj+0IauWKiRfdG2OYJTWlvLjblydlQbolqR3xlhTQq2b4xY/1YGNrKawr35SivBC
         OJ4WMegweGXDOG2KxFxvCDBOHw0zpPpYUiKLNO3/1cOmA6QGe45p9zUbK/aMi6u+Irgj
         ri6A==
X-Gm-Message-State: ANoB5pm0It3+GPHVLLYajBpn9uNCOqjDOyFkszhwgCCd+jE+if+I3ros
        CHeLjdSwLbHBlEvZ1uxA4f5xM57tKTQ=
X-Google-Smtp-Source: AA0mqf5UsX9GwwIMXlJzCtHiCt+jOgn//1XR50Pgc0TaEcTcU/oDW9diEMKODUDueEIuEojL7pvCqw==
X-Received: by 2002:adf:ee0d:0:b0:22c:c8cb:486f with SMTP id y13-20020adfee0d000000b0022cc8cb486fmr1825364wrn.402.1668701199692;
        Thu, 17 Nov 2022 08:06:39 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b003c6b7f5567csm11282104wms.0.2022.11.17.08.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 08:06:38 -0800 (PST)
Message-ID: <47ae0770-1cd4-cfea-7222-f91d1d85f133@gmail.com>
Date:   Thu, 17 Nov 2022 17:06:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Flora Fu <flora.fu@mediatek.com>,
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
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-leds@vger.kernel.org, Fabien Parent <fparent@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-rtc@vger.kernel.org, linux-input@vger.kernel.org
References: <20221005-mt6357-support-v5-0-8210d955dd3d@baylibre.com>
 <20221005-mt6357-support-v5-6-8210d955dd3d@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v5 06/10] dt-bindings: soc: mediatek: convert pwrap
 documentation
In-Reply-To: <20221005-mt6357-support-v5-6-8210d955dd3d@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/11/2022 13:33, Alexandre Mergnat wrote:
> - Convert soc/mediatek/pwrap.txt to soc/mediatek/mediatek,pwrap.yaml
> - MT8365 SoC has 2 additional clock items and a yaml schema for its PMIC

Should be an extra commit.

> - Remove pwrap.txt file

Implicit to the first line.

> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>   .../devicetree/bindings/leds/leds-mt6323.txt       |   2 +-
>   Documentation/devicetree/bindings/mfd/mt6397.txt   |   2 +-
>   .../bindings/soc/mediatek/mediatek,pwrap.yaml      | 145 +++++++++++++++++++++
>   .../devicetree/bindings/soc/mediatek/pwrap.txt     |  75 -----------
>   4 files changed, 147 insertions(+), 77 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-mt6323.txt b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
> index 45bf9f7d85f3..73353692efa1 100644
> --- a/Documentation/devicetree/bindings/leds/leds-mt6323.txt
> +++ b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
> @@ -9,7 +9,7 @@ MT6323 PMIC hardware.
>   For MT6323 MFD bindings see:
>   Documentation/devicetree/bindings/mfd/mt6397.txt
>   For MediaTek PMIC wrapper bindings see:
> -Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> +Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
>   
>   Required properties:
>   - compatible : Must be "mediatek,mt6323-led"
> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
> index 79aaf21af8e9..3bee4a42555d 100644
> --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
> +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
> @@ -13,7 +13,7 @@ MT6397/MT6323 is a multifunction device with the following sub modules:
>   It is interfaced to host controller using SPI interface by a proprietary hardware
>   called PMIC wrapper or pwrap. MT6397/MT6323 MFD is a child device of pwrap.
>   See the following for pwarp node definitions:
> -../soc/mediatek/pwrap.txt
> +../soc/mediatek/mediatek,pwrap.yaml
>   
>   This document describes the binding for MFD device and its sub module.
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

Missing mediatek,mt8186-pwrap

> +              - mediatek,mt8188-pwrap

mt8188 has mt8195 as fallback, that must be kept as otherwise the driver does 
not bind.

> +              - mediatek,mt8365-pwrap
> +              - mediatek,mt8516-pwrap
> +      - items:
> +          - enum:
> +              - mediatek,mt8186-pwrap
> +              - mediatek,mt8195-pwrap
> +          - const: syscon

Not in the original txt binding, maybe add that in a first patch and then convert.

Regards,
Matthias

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
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> deleted file mode 100644
> index 8424b93c432e..000000000000
> --- a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> +++ /dev/null
> @@ -1,75 +0,0 @@
> -MediaTek PMIC Wrapper Driver
> -
> -This document describes the binding for the MediaTek PMIC wrapper.
> -
> -On MediaTek SoCs the PMIC is connected via SPI. The SPI master interface
> -is not directly visible to the CPU, but only through the PMIC wrapper
> -inside the SoC. The communication between the SoC and the PMIC can
> -optionally be encrypted. Also a non standard Dual IO SPI mode can be
> -used to increase speed.
> -
> -IP Pairing
> -
> -on MT8135 the pins of some SoC internal peripherals can be on the PMIC.
> -The signals of these pins are routed over the SPI bus using the pwrap
> -bridge. In the binding description below the properties needed for bridging
> -are marked with "IP Pairing". These are optional on SoCs which do not support
> -IP Pairing
> -
> -Required properties in pwrap device node.
> -- compatible:
> -	"mediatek,mt2701-pwrap" for MT2701/7623 SoCs
> -	"mediatek,mt6765-pwrap" for MT6765 SoCs
> -	"mediatek,mt6779-pwrap" for MT6779 SoCs
> -	"mediatek,mt6797-pwrap" for MT6797 SoCs
> -	"mediatek,mt6873-pwrap" for MT6873/8192 SoCs
> -	"mediatek,mt7622-pwrap" for MT7622 SoCs
> -	"mediatek,mt8135-pwrap" for MT8135 SoCs
> -	"mediatek,mt8173-pwrap" for MT8173 SoCs
> -	"mediatek,mt8183-pwrap" for MT8183 SoCs
> -	"mediatek,mt8186-pwrap" for MT8186 SoCs
> -	"mediatek,mt8188-pwrap", "mediatek,mt8195-pwrap" for MT8188 SoCs
> -	"mediatek,mt8195-pwrap" for MT8195 SoCs
> -	"mediatek,mt8365-pwrap" for MT8365 SoCs
> -	"mediatek,mt8516-pwrap" for MT8516 SoCs
> -- interrupts: IRQ for pwrap in SOC
> -- reg-names: "pwrap" is required; "pwrap-bridge" is optional.
> -  "pwrap": Main registers base
> -  "pwrap-bridge": bridge base (IP Pairing)
> -- reg: Must contain an entry for each entry in reg-names.
> -- clock-names: Must include the following entries:
> -  "spi": SPI bus clock
> -  "wrap": Main module clock
> -  "sys": System module clock (for MT8365 SoC)
> -  "tmr": Timer module clock (for MT8365 SoC)
> -- clocks: Must contain an entry for each entry in clock-names.
> -
> -Optional properities:
> -- reset-names: Some SoCs include the following entries:
> -  "pwrap"
> -  "pwrap-bridge" (IP Pairing)
> -- resets: Must contain an entry for each entry in reset-names.
> -- pmic: Using either MediaTek PMIC MFD as the child device of pwrap
> -  See the following for child node definitions:
> -  Documentation/devicetree/bindings/mfd/mt6397.txt
> -  or the regulator-only device as the child device of pwrap, such as MT6380.
> -  See the following definitions for such kinds of devices.
> -  Documentation/devicetree/bindings/regulator/mt6380-regulator.txt
> -
> -Example:
> -	pwrap: pwrap@1000f000 {
> -		compatible = "mediatek,mt8135-pwrap";
> -		reg = <0 0x1000f000 0 0x1000>,
> -			<0 0x11017000 0 0x1000>;
> -		reg-names = "pwrap", "pwrap-bridge";
> -		interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
> -		resets = <&infracfg MT8135_INFRA_PMIC_WRAP_RST>,
> -				<&pericfg MT8135_PERI_PWRAP_BRIDGE_SW_RST>;
> -		reset-names = "pwrap", "pwrap-bridge";
> -		clocks = <&clk26m>, <&clk26m>;
> -		clock-names = "spi", "wrap";
> -
> -		pmic {
> -			compatible = "mediatek,mt6397";
> -		};
> -	};
> 
