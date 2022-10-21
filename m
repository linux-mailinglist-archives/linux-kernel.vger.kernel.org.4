Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C68060816E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 00:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiJUWUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 18:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiJUWTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:19:49 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE5132AB0;
        Fri, 21 Oct 2022 15:19:39 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id g130so4732541oia.13;
        Fri, 21 Oct 2022 15:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaDCUBlhETv/pAlAxVQXaOAmr/Wrz9Ky5dC48/wYAOY=;
        b=JlqGHmnl3+YaVlkjZzzn50x1DTzGeC8PIBK6+tLQJ7NbSzYeWgdTNYIBzEufXs5xEl
         bieiujg56KP7wq4FzySDDCstyEeTJxNVrwyMJO7MKEtJP5cZicaR+QrmTYDRXh+f7L7P
         aEFlEUnIha+A0kH79ChskeDYE5nLQSyTGzUBsRGRcers4FxOT4gkZfQ9xqb59V6JfIGM
         0ZEgwb2FYf3Faqt5BHHtzu08XGTK3t092BfSycKqnram0/sok22+iOYhjD9mEVasqWBt
         lnnE3QT53xwBw2cgfK5gRUBeQtp8RDehcKgqTX0siOrcywfWOsss+9e9AfPlZ1lInGgN
         A9hQ==
X-Gm-Message-State: ACrzQf2gQz3Q/v6mqpxD+xOzp/JEYvNGbzPBBBbNIXw0aO3WQ/TWQEE0
        4O0zLf+L4VjHn/Lm9keMbQ==
X-Google-Smtp-Source: AMsMyM60Qu8hOm5TeTeUQRGjAI7TvJfk1JIW72XRt8HbhXE9pd3SuFQpfC6Ob21EVg8VyImG9MxiHw==
X-Received: by 2002:a05:6808:eca:b0:353:f32b:a892 with SMTP id q10-20020a0568080eca00b00353f32ba892mr11129994oiv.274.1666390778883;
        Fri, 21 Oct 2022 15:19:38 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o206-20020acabed7000000b00344a22e71a9sm1592916oif.9.2022.10.21.15.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 15:19:38 -0700 (PDT)
Received: (nullmailer pid 563026 invoked by uid 1000);
        Fri, 21 Oct 2022 22:19:39 -0000
Date:   Fri, 21 Oct 2022 17:19:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv4 08/13] dt-bindings: mfd: add rk806 binding
Message-ID: <20221021221939.GA523931-robh@kernel.org>
References: <20221020204251.108565-1-sebastian.reichel@collabora.com>
 <20221020204251.108565-9-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020204251.108565-9-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:42:46PM +0200, Sebastian Reichel wrote:
> Add DT binding document for Rockchip's RK806 PMIC.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/mfd/rockchip,rk806.yaml          | 405 ++++++++++++++++++
>  1 file changed, 405 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
> new file mode 100644
> index 000000000000..4e907dd1f7a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
> @@ -0,0 +1,405 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/rockchip,rk806.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RK806 Power Management Integrated Circuit
> +
> +maintainers:
> +  - Sebastian Reichel <sebastian.reichel@collabora.com>
> +
> +description: |

Don't need '|' if no formatting to preserve.

> +  Rockchip RK806 series PMIC. This device consists of an spi or
> +  i2c controlled MFD that includes multiple switchable regulators.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk806
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +  vcc1-supply:
> +    description:
> +      The input supply for dcdc-reg1.
> +
> +  vcc2-supply:
> +    description:
> +      The input supply for dcdc-reg2.
> +
> +  vcc3-supply:
> +    description:
> +      The input supply for dcdc-reg3.
> +
> +  vcc4-supply:
> +    description:
> +      The input supply for dcdc-reg4.
> +
> +  vcc5-supply:
> +    description:
> +      The input supply for dcdc-reg5.
> +
> +  vcc6-supply:
> +    description:
> +      The input supply for dcdc-reg6.
> +
> +  vcc7-supply:
> +    description:
> +      The input supply for dcdc-reg7.
> +
> +  vcc8-supply:
> +    description:
> +      The input supply for dcdc-reg8.
> +
> +  vcc9-supply:
> +    description:
> +      The input supply for dcdc-reg9.
> +
> +  vcc10-supply:
> +    description:
> +      The input supply for dcdc-reg10.
> +
> +  vcc11-supply:
> +    description:
> +      The input supply for pldo-reg1, pldo-reg2 and pldo-reg3.
> +
> +  vcc12-supply:
> +    description:
> +      The input supply for pldo-reg4 and pldo-reg5.
> +
> +  vcc13-supply:
> +    description:
> +      The input supply for nldo-reg1, nldo-reg2 and nldo-reg3.
> +
> +  vcc14-supply:
> +    description:
> +      The input supply for nldo-reg4 and nldo-reg5.
> +
> +  vcca-supply:
> +    description:
> +      The input supply for pldo-reg6.
> +
> +  regulators:
> +    type: object
> +    patternProperties:
> +      "^(dcdc-reg([1-9]|10)|pldo-reg[1-6]|nldo-reg[1-5])$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +    additionalProperties: false

In the indented cases, this is a bit easier to read if placed before 
patternProperties.

> +
> +patternProperties:
> +  '-pins$':
> +    type: object

       additionalProperties: false

(or unevaluatedProperties if other properties besides function and pins 
apply.)

> +    $ref: /schemas/pinctrl/pinmux-node.yaml
> +
> +    properties:
> +      function:
> +        enum: [pin_fun0, pin_fun1, pin_fun2, pin_fun3, pin_fun4, pin_fun5]
> +
> +      pins:
> +        $ref: "/schemas/types.yaml#/definitions/string"

Can drop quotes.

> +        enum: [gpio_pwrctrl1, gpio_pwrctrl2, gpio_pwrctrl3]
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/pinctrl/rockchip.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic@0 {
> +            compatible = "rockchip,rk806";
> +            reg = <0x0>;
> +
> +            interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> +
> +            vcc1-supply = <&vcc5v0_sys>;
> +            vcc2-supply = <&vcc5v0_sys>;
> +            vcc3-supply = <&vcc5v0_sys>;
> +            vcc4-supply = <&vcc5v0_sys>;
> +            vcc5-supply = <&vcc5v0_sys>;
> +            vcc6-supply = <&vcc5v0_sys>;
> +            vcc7-supply = <&vcc5v0_sys>;
> +            vcc8-supply = <&vcc5v0_sys>;
> +            vcc9-supply = <&vcc5v0_sys>;
> +            vcc10-supply = <&vcc5v0_sys>;
> +            vcc11-supply = <&vcc_2v0_pldo_s3>;
> +            vcc12-supply = <&vcc5v0_sys>;
> +            vcc13-supply = <&vcc5v0_sys>;
> +            vcc14-supply = <&vcc_1v1_nldo_s3>;
> +            vcca-supply = <&vcc5v0_sys>;
> +
> +            regulators {
> +                vdd_gpu_s0: dcdc-reg1 {
> +                    regulator-always-on;
> +                    regulator-boot-on;
> +                    regulator-min-microvolt = <550000>;
> +                    regulator-max-microvolt = <950000>;
> +                    regulator-ramp-delay = <12500>;
> +                    regulator-name = "vdd_gpu_s0";
> +                    regulator-state-mem {
> +                        regulator-off-in-suspend;
> +                    };
> +                };
> +
> +                vdd_npu_s0: dcdc-reg2 {
> +                    regulator-always-on;
> +                    regulator-boot-on;
> +                    regulator-min-microvolt = <550000>;
> +                    regulator-max-microvolt = <950000>;
> +                    regulator-ramp-delay = <12500>;
> +                    regulator-name = "vdd_npu_s0";
> +                    regulator-state-mem {
> +                        regulator-off-in-suspend;
> +                    };
> +                };
> +
> +                vdd_log_s0: dcdc-reg3 {
> +                    regulator-always-on;
> +                    regulator-boot-on;
> +                    regulator-min-microvolt = <750000>;
> +                    regulator-max-microvolt = <750000>;
> +                    regulator-ramp-delay = <12500>;
> +                    regulator-name = "vdd_log_s0";
> +                    regulator-state-mem {
> +                        regulator-on-in-suspend;
> +                        regulator-suspend-microvolt = <750000>;
> +                    };
> +                };
> +
> +                vdd_vdenc_s0: dcdc-reg4 {
> +                    regulator-always-on;
> +                    regulator-boot-on;
> +                    regulator-min-microvolt = <550000>;
> +                    regulator-max-microvolt = <950000>;
> +                    regulator-ramp-delay = <12500>;
> +                    regulator-name = "vdd_vdenc_s0";
> +                    regulator-state-mem {
> +                        regulator-off-in-suspend;
> +                    };
> +                };
> +
> +                vdd_gpu_mem_s0: dcdc-reg5 {
> +                    regulator-always-on;
> +                    regulator-boot-on;
> +                    regulator-min-microvolt = <675000>;
> +                    regulator-max-microvolt = <950000>;
> +                    regulator-ramp-delay = <12500>;
> +                    regulator-name = "vdd_gpu_mem_s0";
> +                    regulator-state-mem {
> +                        regulator-off-in-suspend;
> +                    };
> +                };
> +
> +                vdd_npu_mem_s0: dcdc-reg6 {
> +                    regulator-always-on;
> +                    regulator-boot-on;
> +                    regulator-min-microvolt = <675000>;
> +                    regulator-max-microvolt = <950000>;
> +                    regulator-ramp-delay = <12500>;
> +                    regulator-name = "vdd_npu_mem_s0";
> +                    regulator-state-mem {
> +                        regulator-off-in-suspend;
> +                    };
> +                };
> +
> +                vcc_2v0_pldo_s3: dcdc-reg7 {
> +                    regulator-always-on;
> +                    regulator-boot-on;
> +                    regulator-min-microvolt = <2000000>;
> +                    regulator-max-microvolt = <2000000>;
> +                    regulator-ramp-delay = <12500>;
> +                    regulator-name = "vdd_2v0_pldo_s3";
> +                    regulator-state-mem {
> +                        regulator-on-in-suspend;
> +                        regulator-suspend-microvolt = <2000000>;
> +                    };
> +                };
> +
> +                vdd_vdenc_mem_s0: dcdc-reg8 {
> +                    regulator-always-on;
> +                    regulator-boot-on;
> +                    regulator-min-microvolt = <675000>;
> +                    regulator-max-microvolt = <950000>;
> +                    regulator-ramp-delay = <12500>;
> +                    regulator-name = "vdd_vdenc_mem_s0";
> +                    regulator-state-mem {
> +                        regulator-off-in-suspend;
> +                    };
> +                };
> +
> +                vdd2_ddr_s3: dcdc-reg9 {
> +                    regulator-always-on;
> +                    regulator-boot-on;
> +                    regulator-name = "vdd2_ddr_s3";
> +                    regulator-state-mem {
> +                        regulator-on-in-suspend;
> +                    };
> +                };
> +
> +                vcc_1v1_nldo_s3: dcdc-reg10 {
> +                    regulator-always-on;
> +                    regulator-boot-on;
> +                    regulator-min-microvolt = <1100000>;
> +                    regulator-max-microvolt = <1100000>;
> +                    regulator-ramp-delay = <12500>;
> +                    regulator-name = "vcc_1v1_nldo_s3";
> +                    regulator-state-mem {
> +                        regulator-on-in-suspend;
> +                        regulator-suspend-microvolt = <1100000>;
> +                    };
> +                };
> +
> +                avcc_1v8_s0: pldo-reg1 {
> +                    regulator-always-on;
> +                    regulator-boot-on;
> +                    regulator-min-microvolt = <1800000>;
> +                    regulator-max-microvolt = <1800000>;
> +                    regulator-ramp-delay = <12500>;
> +                    regulator-name = "avcc_1v8_s0";
> +                    regulator-state-mem {
> +                        regulator-off-in-suspend;
> +                    };
> +                };
> +
> +                vdd1_1v8_ddr_s3: pldo-reg2 {
> +                    regulator-always-on;
> +                    regulator-boot-on;
> +                    regulator-min-microvolt = <1800000>;
> +                    regulator-max-microvolt = <1800000>;
> +                    regulator-ramp-delay = <12500>;
> +                    regulator-name = "vdd1_1v8_ddr_s3";
> +                    regulator-state-mem {
> +                        regulator-on-in-suspend;
> +                        regulator-suspend-microvolt = <1800000>;
> +                    };
> +                };
> +
> +                vcc_1v8_s3: pldo-reg3 {
> +                    regulator-always-on;
> +                    regulator-boot-on;
> +                    regulator-min-microvolt = <1800000>;
> +                    regulator-max-microvolt = <1800000>;
> +                    regulator-ramp-delay = <12500>;
> +                    regulator-name = "vcc_1v8_s3";
> +                    regulator-state-mem {
> +                        regulator-on-in-suspend;
> +                        regulator-suspend-microvolt = <1800000>;
> +                    };
> +                };
> +
> +                vcc_3v3_s0: pldo-reg4 {
> +                    regulator-always-on;
> +                    regulator-boot-on;
> +                    regulator-min-microvolt = <3300000>;
> +                    regulator-max-microvolt = <3300000>;
> +                    regulator-ramp-delay = <12500>;
> +                    regulator-name = "vcc_3v3_s0";
> +                    regulator-state-mem {
> +                        regulator-off-in-suspend;
> +                    };
> +                };
> +
> +                vccio_sd_s0: pldo-reg5 {
> +                    regulator-always-on;
> +                    regulator-boot-on;
> +                    regulator-min-microvolt = <1800000>;
> +                    regulator-max-microvolt = <3300000>;
> +                    regulator-ramp-delay = <12500>;
> +                    regulator-name = "vccio_sd_s0";
> +                    regulator-state-mem {
> +                        regulator-off-in-suspend;
> +                    };
> +                };
> +
> +                master_pldo6_s3: pldo-reg6 {
> +                    regulator-always-on;
> +                    regulator-boot-on;
> +                    regulator-min-microvolt = <1800000>;
> +                    regulator-max-microvolt = <1800000>;
> +                    regulator-name = "master_pldo6_s3";
> +                    regulator-state-mem {
> +                        regulator-on-in-suspend;
> +                        regulator-suspend-microvolt = <1800000>;
> +                    };
> +                };
> +
> +                vdd_0v75_s3: nldo-reg1 {
> +                    regulator-always-on;
> +                    regulator-boot-on;
> +                    regulator-min-microvolt = <750000>;
> +                    regulator-max-microvolt = <750000>;
> +                    regulator-ramp-delay = <12500>;
> +                    regulator-name = "vdd_0v75_s3";
> +                    regulator-state-mem {
> +                        regulator-on-in-suspend;
> +                        regulator-suspend-microvolt = <750000>;
> +                    };
> +                };
> +
> +                vdd2l_0v9_ddr_s3: nldo-reg2 {
> +                    regulator-always-on;
> +                    regulator-boot-on;
> +                    regulator-min-microvolt = <900000>;
> +                    regulator-max-microvolt = <900000>;
> +                    regulator-name = "vdd2l_0v9_ddr_s3";
> +                    regulator-state-mem {
> +                        regulator-on-in-suspend;
> +                        regulator-suspend-microvolt = <900000>;
> +                    };
> +                };
> +
> +                master_nldo3: nldo-reg3 {
> +                    regulator-name = "master_nldo3";
> +                    regulator-state-mem {
> +                        regulator-off-in-suspend;
> +                    };
> +                };
> +
> +                avdd_0v75_s0: nldo-reg4 {
> +                    regulator-always-on;
> +                    regulator-boot-on;
> +                    regulator-min-microvolt = <750000>;
> +                    regulator-max-microvolt = <750000>;
> +                    regulator-name = "avdd_0v75_s0";
> +                    regulator-state-mem {
> +                        regulator-off-in-suspend;
> +                    };
> +                };
> +
> +                vdd_0v85_s0: nldo-reg5 {
> +                    regulator-always-on;
> +                    regulator-boot-on;
> +                    regulator-min-microvolt = <850000>;
> +                    regulator-max-microvolt = <850000>;
> +                    regulator-name = "vdd_0v85_s0";
> +                    regulator-state-mem {
> +                        regulator-off-in-suspend;
> +                    };
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.35.1
> 
> 
