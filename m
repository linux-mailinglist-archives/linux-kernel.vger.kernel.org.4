Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841296207E4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiKHD5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiKHD5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:57:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1E42FFF8;
        Mon,  7 Nov 2022 19:57:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CD4F61440;
        Tue,  8 Nov 2022 03:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D6DC433D6;
        Tue,  8 Nov 2022 03:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667879870;
        bh=+EdeUVZWzM6tGPByItIkYHRcg8Djxf8WDkFOqvAHYSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oT3vkECnt+jcxluwIaA7tlbifQNhFterDzW8TMG3kGTJ5zTj5hZKm5o2OCd05yTcV
         6OHa/mRuoVJYiIXThiZdehOplFitM/Cm8FcLnkglZnWhaJraY8oWUSbmO0rch6Qe8H
         gAUJotcZDD6GxUsXHTI0RKbu6mKRZQe/sxcud4evQL9J2BCQa1p62TxfhO2s1onxrV
         CIc0nUow8gSnNZcFWIuv++79yLd2iaJzXgmdUeIBabeIHaZEHXCZofxOpMA6D9WhvQ
         YvQwky395T1HyX6+dNfOX/Ht7+kiJIc29+ZnfZNDsYgeGU6QqVmaXeTTL9D4iP+7D/
         2Kuodl4gfi5BQ==
Date:   Mon, 7 Nov 2022 21:57:47 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom,msm8660: convert to
 dtschema
Message-ID: <20221108035747.twcypv7ibqnvuuqj@builder.lan>
References: <20221107185931.22075-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107185931.22075-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 07:59:30PM +0100, Krzysztof Kozlowski wrote:
> Convert Qualcomm MSM8660 pin controller bindings to DT schema.  Keep the
> parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, their children with
> '-pins').
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  .../bindings/pinctrl/qcom,msm8660-pinctrl.txt |  96 --------------
>  .../pinctrl/qcom,msm8660-pinctrl.yaml         | 125 ++++++++++++++++++
>  2 files changed, 125 insertions(+), 96 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.txt
> deleted file mode 100644
> index f095209848c8..000000000000
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.txt
> +++ /dev/null
> @@ -1,96 +0,0 @@
> -Qualcomm MSM8660 TLMM block
> -
> -Required properties:
> -- compatible: "qcom,msm8660-pinctrl"
> -- reg: Should be the base address and length of the TLMM block.
> -- interrupts: Should be the parent IRQ of the TLMM block.
> -- interrupt-controller: Marks the device node as an interrupt controller.
> -- #interrupt-cells: Should be two.
> -- gpio-controller: Marks the device node as a GPIO controller.
> -- #gpio-cells : Should be two.
> -                The first cell is the gpio pin number and the
> -                second cell is used for optional parameters.
> -- gpio-ranges: see ../gpio/gpio.txt
> -
> -Optional properties:
> -
> -- gpio-reserved-ranges: see ../gpio/gpio.txt
> -
> -Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
> -a general description of GPIO and interrupt bindings.
> -
> -Please refer to pinctrl-bindings.txt in this directory for details of the
> -common pinctrl bindings used by client devices, including the meaning of the
> -phrase "pin configuration node".
> -
> -Qualcomm's pin configuration nodes act as a container for an arbitrary number of
> -subnodes. Each of these subnodes represents some desired configuration for a
> -pin, a group, or a list of pins or groups. This configuration can include the
> -mux function to select on those pin(s)/group(s), and various pin configuration
> -parameters, such as pull-up, drive strength, etc.
> -
> -The name of each subnode is not important; all subnodes should be enumerated
> -and processed purely based on their content.
> -
> -Each subnode only affects those parameters that are explicitly listed. In
> -other words, a subnode that lists a mux function but no pin configuration
> -parameters implies no information about any pin configuration parameters.
> -Similarly, a pin subnode that describes a pullup parameter implies no
> -information about e.g. the mux function.
> -
> -
> -The following generic properties as defined in pinctrl-bindings.txt are valid
> -to specify in a pin configuration subnode:
> -
> - pins, function, bias-disable, bias-pull-down, bias-pull-up, drive-strength,
> - output-low, output-high.
> -
> -Non-empty subnodes must specify the 'pins' property.
> -
> -Valid values for pins are:
> -  gpio0-gpio172, sdc3_clk, sdc3_cmd, sdc3_data sdc4_clk, sdc4_cmd, sdc4_data
> -
> -Valid values for function are:
> -  gpio, cam_mclk, dsub, ext_gps, gp_clk_0a, gp_clk_0b, gp_clk_1a, gp_clk_1b,
> -  gp_clk_2a, gp_clk_2b, gp_mn, gsbi1, gsbi1_spi_cs1_n, gsbi1_spi_cs2a_n,
> -  gsbi1_spi_cs2b_n, gsbi1_spi_cs3_n, gsbi2, gsbi2_spi_cs1_n, gsbi2_spi_cs2_n,
> -  gsbi2_spi_cs3_n, gsbi3, gsbi3_spi_cs1_n, gsbi3_spi_cs2_n, gsbi3_spi_cs3_n,
> -  gsbi4, gsbi5, gsbi6, gsbi7, gsbi8, gsbi9, gsbi10, gsbi11, gsbi12, hdmi, i2s,
> -  lcdc, mdp_vsync, mi2s, pcm, ps_hold, sdc1, sdc2, sdc5, tsif1, tsif2, usb_fs1,
> -  usb_fs1_oe_n, usb_fs2, usb_fs2_oe_n, vfe, vsens_alarm, ebi2, ebi2cs
> -
> -Example:
> -
> -	msmgpio: pinctrl@800000 {
> -		compatible = "qcom,msm8660-pinctrl";
> -		reg = <0x800000 0x4000>;
> -
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -		gpio-ranges = <&msmgpio 0 0 173>;
> -		interrupt-controller;
> -		#interrupt-cells = <2>;
> -		interrupts = <0 16 0x4>;
> -
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&gsbi12_uart>;
> -
> -		gsbi12_uart: gsbi12-uart {
> -			mux {
> -				pins = "gpio117", "gpio118";
> -				function = "gsbi12";
> -			};
> -
> -			tx {
> -				pins = "gpio118";
> -				drive-strength = <8>;
> -				bias-disable;
> -			};
> -
> -			rx {
> -				pins = "gpio117";
> -				drive-strength = <2>;
> -				bias-pull-up;
> -			};
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.yaml
> new file mode 100644
> index 000000000000..ad0cad4694c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.yaml
> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/qcom,msm8660-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm MSM8660 TLMM pin controller
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> +
> +description:
> +  Top Level Mode Multiplexer pin controller in Qualcomm MSM8660 SoC.
> +
> +properties:
> +  compatible:
> +    const: qcom,msm8660-pinctrl
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts: true
> +  interrupt-controller: true
> +  "#interrupt-cells": true
> +  gpio-controller: true
> +  "#gpio-cells": true
> +  gpio-ranges: true
> +  wakeup-parent: true
> +
> +  gpio-reserved-ranges:
> +    minItems: 1
> +    maxItems: 86
> +
> +  gpio-line-names:
> +    maxItems: 173
> +
> +patternProperties:
> +  "-state$":
> +    oneOf:
> +      - $ref: "#/$defs/qcom-msm8660-tlmm-state"
> +      - patternProperties:
> +          "-pins$":
> +            $ref: "#/$defs/qcom-msm8660-tlmm-state"
> +        additionalProperties: false
> +
> +$defs:
> +  qcom-msm8660-tlmm-state:
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
> +
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in this
> +          subnode.
> +        items:
> +          oneOf:
> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-6][0-9]|17[0-2])$"
> +            - enum: [ sdc3_clk, sdc3_cmd, sdc3_data, sdc4_clk, sdc4_cmd, sdc4_data ]
> +        minItems: 1
> +        maxItems: 36
> +
> +      function:
> +        description:
> +          Specify the alternative function to be configured for the specified
> +          pins.
> +
> +        enum: [ gpio, cam_mclk, dsub, ext_gps, gp_clk_0a, gp_clk_0b, gp_clk_1a,
> +                gp_clk_1b, gp_clk_2a, gp_clk_2b, gp_mn, gsbi1, gsbi1_spi_cs1_n,
> +                gsbi1_spi_cs2a_n, gsbi1_spi_cs2b_n, gsbi1_spi_cs3_n, gsbi2,
> +                gsbi2_spi_cs1_n, gsbi2_spi_cs2_n, gsbi2_spi_cs3_n, gsbi3,
> +                gsbi3_spi_cs1_n, gsbi3_spi_cs2_n, gsbi3_spi_cs3_n, gsbi4,
> +                gsbi5, gsbi6, gsbi7, gsbi8, gsbi9, gsbi10, gsbi11, gsbi12,
> +                hdmi, i2s, lcdc, mdp_vsync, mi2s, pcm, ps_hold, sdc1, sdc2,
> +                sdc5, tsif1, tsif2, usb_fs1, usb_fs1_oe_n, usb_fs2,
> +                usb_fs2_oe_n, vfe, vsens_alarm, ebi2, ebi2cs ]
> +
> +
> +      bias-pull-down: true
> +      bias-pull-up: true
> +      bias-disable: true
> +      drive-strength: true
> +      input-enable: true
> +      output-high: true
> +      output-low: true
> +
> +    required:
> +      - pins
> +
> +    additionalProperties: false
> +
> +allOf:
> +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    tlmm: pinctrl@800000 {
> +        compatible = "qcom,msm8660-pinctrl";
> +        reg = <0x800000 0x4000>;
> +
> +        gpio-controller;
> +        gpio-ranges = <&tlmm 0 0 173>;
> +        #gpio-cells = <2>;
> +        interrupts = <0 16 0x4>;
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +
> +        gsbi3-i2c-state {
> +            pins = "gpio43", "gpio44";
> +            function = "gsbi3";
> +            drive-strength = <8>;
> +            bias-disable;
> +        };
> +    };
> -- 
> 2.34.1
> 
