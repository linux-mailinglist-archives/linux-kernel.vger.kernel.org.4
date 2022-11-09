Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E6E6227AF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiKIJzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiKIJzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:55:32 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FF41FCEE;
        Wed,  9 Nov 2022 01:55:30 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4572F660299E;
        Wed,  9 Nov 2022 09:55:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667987729;
        bh=tqSAj7i9eJ7hbkEWeNSQsTS7ENW3LYaPNesgiYySff8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H7B/hEAnNYmUbN8RI01wuQoCpxbKZ1LND5aLvcJOs9fjGhBdASp/EZrx6rCijVYtb
         qUJDwgXj5Dt1/QpNZbE2pHiKaO8WRYiAD7QRkvtTGjLn0KCk9nuPy9ojfbHrtCfzvu
         TW6tfIZMpZD7wqOYskA6lEc8DRgKSrATnf+YIkQKADD0pF5LpZhlZbGY44lG+s5v9K
         Hdqfk2Ga/iQr1KTxBHZdunIhxR+A1KocjXfxRQnO4JbweQyXE/ZtyN+zFzJrWgZECU
         jKfoIo1np1st0d/+HBaF6bQwKGmzZ4T8FYT+bXrRZJcyGSrJuDSjXG+IgFqH8IjKwF
         1SFSxR5UuJa+Q==
Message-ID: <fe898d24-54fa-56bb-8067-b422a3a52ff5@collabora.com>
Date:   Wed, 9 Nov 2022 10:55:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4 5/9] dt-bindings: soc: mediatek: convert pwrap
 documentation
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-rtc@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
References: <20221005-mt6357-support-v4-0-5d2bb58e6087@baylibre.com>
 <20221005-mt6357-support-v4-5-5d2bb58e6087@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221005-mt6357-support-v4-5-5d2bb58e6087@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/11/22 19:43, Alexandre Mergnat ha scritto:
> - Convert soc/mediatek/pwrap.txt to soc/mediatek/mediatek,pwrap.yaml
> - MT8365 SoC has 2 additional clock items and a yaml schema for its PMIC
> - Remove pwrap.txt file
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>   .../devicetree/bindings/leds/leds-mt6323.txt       |   2 +-
>   Documentation/devicetree/bindings/mfd/mt6397.txt   |   2 +-
>   .../bindings/soc/mediatek/mediatek,pwrap.yaml      | 158 +++++++++++++++++++++
>   .../devicetree/bindings/soc/mediatek/pwrap.txt     |  75 ----------
>   4 files changed, 160 insertions(+), 77 deletions(-)
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
> index 000000000000..fe83458b801a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> @@ -0,0 +1,158 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/mediatek/mediatek,pwrap.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek PMIC Wrapper
> +
> +maintainers:
> +  - Alexandre Mergnat <amergnat@baylibre.com>

I say that the maintainer for pwrap is Flora Fu <flora.fu@mediatek.com>....

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

..snip..

> +  interrupts:
> +    maxItems: 1
> +    description: IRQ for pwrap in SOC

description: PMIC Wrapper interrupt

> +
> +  clocks: true
> +
> +  clock-names: true
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
> +
> +allOf:
> +  - if:

if `resets` is present, reset-names is *required*...

> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8365-pwrap
> +    then:
> +      properties:
> +        pmic:
> +          $ref: /schemas/mfd/mediatek,mt6357.yaml#
> +
> +        clocks:
> +          items:
> +            - description: SPI bus clock
> +            - description: Main module clock
> +            - description: System module clock
> +            - description: Timer module clock
> +        clock-names:
> +          items:
> +            - const: spi
> +            - const: wrap
> +            - const: sys
> +            - const: tmr

For clocks and clock-names... you can declare that globally and set
`minItems: 2` for both: this means that the first two items are mandatory,
but the last two are not.

If you really want to force a validation error when using mediatek,mt8365-pwrap
and not providing `sys` and `tmr` clocks, you can just override minItems.

> +    else:
> +      properties:
> +        pmic:
> +          description: |

You don't need this '|'.

> +            List of child nodes that specify the regulators.
> +            See ../../mfd/mt6397.txt for more details.
> +
> +        clocks:
> +          items:
> +            - description: SPI bus clock
> +            - description: Main module clock
> +        clock-names:
> +          items:
> +            - const: spi
> +            - const: wrap
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/reset/mt8135-resets.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +      pwrap@1000f000 {
> +          compatible = "mediatek,mt8135-pwrap";
> +          reg = <0 0x1000f000 0 0x1000>, <0 0x11017000 0 0x1000>;
> +          reg-names = "pwrap", "pwrap-bridge";
> +          interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
> +          resets = <&infracfg MT8135_INFRA_PMIC_WRAP_RST>,
> +              <&pericfg MT8135_PERI_PWRAP_BRIDGE_SW_RST>;

Fix indentation please

           resets = <&infracfg MT8135_INFRA_PMIC_WRAP_RST>,
                    <&pericfg MT8135_PERI_PWRAP_BRIDGE_SW_RST>;

> +          reset-names = "pwrap", "pwrap-bridge";
> +          clocks = <&clk26m>, <&clk26m>;

...and also, clocks/clock-names before resets/reset-names please.

> +          clock-names = "spi", "wrap";
> +
> +          pmic {
> +            compatible = "mediatek,mt6397";
> +          };
> +      };
> +    };

Regards,
Angelo

