Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4948C63D2D1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbiK3KIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbiK3KIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:08:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B463B248EB;
        Wed, 30 Nov 2022 02:08:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BF5261AA2;
        Wed, 30 Nov 2022 10:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7617C433D7;
        Wed, 30 Nov 2022 10:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669802896;
        bh=9FvSvVLzySD8LbTfnoYpcK38CCZwnNYjsIckhInqktQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P0Yd5YZnMurOBSMnc+1boBGbX7+HW/x6DAtfPeXD3vOX+NZu9c/rTJbwa3nYtQfC1
         5jh51yyT0/rdJ4UyhXfKtJHzmPV9i89AaDWJnydAV4vGaKLbcY0Y5LlPeXTqt9cqvP
         jFQownQSEWgOAUhX3swf4M67FWa8XssUy2yhee7Z2hpva2KCXq/6vWJSqS59m1nf3W
         Dze7SR7/FcFULDdvElVuJkbbbgDokuz4ek9aJFqaI2NpZ/nXNu7gNbWqdh2W2b+6AS
         2nDwZOiWdgh8LV5V5V48cKLdEvX2/0sglK4kNObcAoltdrMboWzfzMN0uXeG2yndoH
         POpULBl8lpocA==
Date:   Wed, 30 Nov 2022 10:08:07 +0000
From:   Lee Jones <lee@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabien Parent <fabien.parent@linaro.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-rtc@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Fabien Parent <fparent@baylibre.com>,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v7 4/8] dt-bindings: mfd: mediatek: Add bindings for
 MT6357 PMIC
Message-ID: <Y4crh0Ob3sz20s5T@google.com>
References: <20221005-mt6357-support-v7-0-477e60126749@baylibre.com>
 <20221005-mt6357-support-v7-4-477e60126749@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221005-mt6357-support-v7-4-477e60126749@baylibre.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2022, Alexandre Mergnat wrote:

> Currently, almost all MT63XX PMIC are documented mfd/mt6397.txt.
> Unfortunately, the PMICs haven't always similar HW sub-features.
> To have a better human readable schema, I chose to make one PMIC schema
> to match the exact HW capabilities instead of convert mt6397.txt to
> mediatek,mt63xx.yaml and put a bunch of properties behind
> "if contain ... then ..."
> 
> - add interrupt property
> - change property refs to match with new yaml documentation
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Acked-by: Lee Jones <lee@kernel.org>

> ---
>  .../devicetree/bindings/mfd/mediatek,mt6357.yaml   | 111 +++++++++++++++++++++
>  1 file changed, 111 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
> new file mode 100644
> index 000000000000..837a77013d57
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
> @@ -0,0 +1,111 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/mediatek,mt6357.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT6357 PMIC
> +
> +maintainers:
> +  - Flora Fu <flora.fu@mediatek.com>
> +  - Alexandre Mergnat <amergnat@baylibre.com>
> +
> +description: |
> +  MT6357 is a power management system chip containing 5 buck
> +  converters and 29 LDOs. Supported features are audio codec,
> +  USB battery charging, fuel gauge, RTC
> +
> +  This is a multifunction device with the following sub modules:
> +  - Regulator
> +  - RTC
> +  - Keys
> +
> +  It is interfaced to host controller using SPI interface by a proprietary hardware
> +  called PMIC wrapper or pwrap. This MFD is a child device of pwrap.
> +  See the following for pwrap node definitions:
> +  Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6357
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  regulators:
> +    type: object
> +    $ref: /schemas/regulator/mediatek,mt6357-regulator.yaml
> +    description:
> +      List of MT6357 BUCKs and LDOs regulators.
> +
> +  rtc:
> +    type: object
> +    $ref: /schemas/rtc/rtc.yaml#
> +    description:
> +      MT6357 Real Time Clock.
> +    properties:
> +      compatible:
> +        const: mediatek,mt6357-rtc
> +      start-year: true
> +    required:
> +      - compatible
> +
> +  keys:
> +    type: object
> +    $ref: /schemas/input/mediatek,pmic-keys.yaml
> +    description:
> +      MT6357 power and home keys.
> +
> +required:
> +  - compatible
> +  - regulators
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    pwrap {
> +        pmic {
> +            compatible = "mediatek,mt6357";
> +
> +            interrupt-parent = <&pio>;
> +            interrupts = <145 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-controller;
> +            #interrupt-cells = <2>;
> +
> +            regulators {
> +                mt6357_vproc_reg: buck-vproc {
> +                    regulator-name = "vproc";
> +                    regulator-min-microvolt = <518750>;
> +                    regulator-max-microvolt = <1312500>;
> +                    regulator-ramp-delay = <6250>;
> +                    regulator-enable-ramp-delay = <220>;
> +                    regulator-always-on;
> +                };
> +
> +                // ...
> +
> +                mt6357_vusb33_reg: ldo-vusb33 {
> +                    regulator-name = "vusb33";
> +                    regulator-min-microvolt = <3000000>;
> +                    regulator-max-microvolt = <3100000>;
> +                    regulator-enable-ramp-delay = <264>;
> +                };
> +            };
> +
> +            rtc {
> +                compatible = "mediatek,mt6357-rtc";
> +            };
> +
> +            keys {
> +                compatible = "mediatek,mt6357-keys";
> +            };
> +        };
> +    };
> 

-- 
Lee Jones [李琼斯]
