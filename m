Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4700862D46C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbiKQHxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiKQHxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:53:17 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37F2B6B39A;
        Wed, 16 Nov 2022 23:53:15 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8Dxvrdp6HVjgDYIAA--.18611S3;
        Thu, 17 Nov 2022 15:53:13 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxXuBm6HVjyc0VAA--.56814S2;
        Thu, 17 Nov 2022 15:53:11 +0800 (CST)
Subject: Re: [PATCH v10 2/2] dt-bindings: pinctrl: add loongson-2 pinctrl
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
References: <20221114024942.8111-1-zhuyinbo@loongson.cn>
 <20221114024942.8111-2-zhuyinbo@loongson.cn>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <bdfabfac-7280-a9bd-ba5b-6d14096df757@loongson.cn>
Date:   Thu, 17 Nov 2022 15:53:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221114024942.8111-2-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxXuBm6HVjyc0VAA--.56814S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxGryfZFy8ZryfWw17Wr4fAFb_yoWrtF1kpF
        Z3C393GF12qa1xCry3Ca40yw13Jan7CasF9FsFg34jyr4DKw1IvrW3Kw4DurZrCrWxArWU
        Xa45uryUXF1DArJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bTAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq
        07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwI
        xGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
        wI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
        CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
        WIevJa73UjIFyTuYvjxUc4EEUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi maintainer,

This patch has also changed recently. Please help merge it.

Thanks,
Yinbo.
ÔÚ 2022/11/14 ÉÏÎç10:49, Yinbo Zhu Ð´µÀ:
> Add the Loongson-2 pinctrl binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v10:
> 		1. Remove lio/uart2/uart1/carmera/dvo1/dvo0 pins resue configuration.
> Change in v9:
> 		1. NO change, but other patch in this series patches set has
> 		   change.
> Change in v8:
> 		1. NO change, but other patch in this series patches set has
> 		   change.
> Change in v7:
> 		1. Add all change log information.
> Change in v6:
> 		1. NO change, but other patch in this series patches set has
> 		   change.
> Change in v5:
> 		1. Drop dependencies.
> 		2. Add spaces after '='.
> 		3. Replace string loongson2 with loongson-2 in title.
> Change in v4:
> 		1. Replace Loongson2 with Loongson-2.
> Change in v3:
> 		1. Drop the quotes in "pinctrl.yaml#".
> 		2. Remove the items in function node.
> 		3. Add requird node for "group" and "function" in properties.
> Change in v2:
>                  1. Add "$ref to pinctrl.yaml".
>                  2. Put required after patternProperties.
>                  3. Add "additionalProperties: false" after '-pins$'
>                  4. Add "unevaluatedProperties: false" after 'pinmux$'
>                  5. Fixup the broken indentation in patternProperties node.
>                  6. Use 4 spaces for example indentation.
> 
>   .../pinctrl/loongson,ls2k-pinctrl.yaml        | 123 ++++++++++++++++++
>   MAINTAINERS                                   |   1 +
>   2 files changed, 124 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
> new file mode 100644
> index 000000000000..bd8a45843566
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
> @@ -0,0 +1,123 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/loongson,ls2k-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson-2 SoC Pinctrl Controller
> +
> +maintainers:
> +  - zhanghongchen <zhanghongchen@loongson.cn>
> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
> +
> +allOf:
> +  - $ref: pinctrl.yaml#
> +
> +properties:
> +  compatible:
> +    const: loongson,ls2k-pinctrl
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  '-pins$':
> +    type: object
> +
> +    additionalProperties: false
> +
> +    patternProperties:
> +      'pinmux$':
> +        type: object
> +        description: node for pinctrl.
> +        $ref: pinmux-node.yaml#
> +
> +        unevaluatedProperties: false
> +
> +        properties:
> +          groups:
> +            description:
> +              One or more groups of pins to mux to a certain function
> +            items:
> +              enum: [gpio, sdio, can1, can0, pwm3, pwm2, pwm1, pwm0, i2c1, i2c0,
> +                     nand, sata_led, i2s, hda]
> +          function:
> +            description:
> +              The function that a group of pins is muxed to
> +            enum: [gpio, sdio, can1, can0, pwm3, pwm2, pwm1, pwm0, i2c1, i2c0,
> +                   nand, sata_led, i2s, hda]
> +
> +        required:
> +          - groups
> +          - function
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pctrl: pinctrl@1fe00420 {
> +        compatible = "loongson,ls2k-pinctrl";
> +        reg = <0x1fe00420 0x18>;
> +        sdio_pins_default: sdio-pins {
> +            sdio-pinmux {
> +                groups = "sdio";
> +                function = "sdio";
> +            };
> +
> +            sdio-det-pinmux {
> +                groups = "pwm2";
> +                function = "gpio";
> +            };
> +        };
> +
> +        pwm1_pins_default: pwm1-pins {
> +            pinmux {
> +                groups = "pwm1";
> +                function = "pwm1";
> +            };
> +        };
> +
> +        pwm0_pins_default: pwm0-pins {
> +            pinmux {
> +                groups = "pwm0";
> +                function = "pwm0";
> +            };
> +        };
> +
> +        i2c1_pins_default: i2c1-pins {
> +            pinmux {
> +                groups = "i2c1";
> +                function = "i2c1";
> +            };
> +        };
> +
> +        i2c0_pins_default: i2c0-pins {
> +            pinmux {
> +                groups = "i2c0";
> +                function = "i2c0";
> +            };
> +        };
> +
> +        nand_pins_default: nand-pins {
> +            pinmux {
> +                groups = "nand";
> +                function = "nand";
> +            };
> +        };
> +
> +        hda_pins_default: hda-pins {
> +            grp0-pinmux {
> +                groups = "hda";
> +                function = "hda";
> +            };
> +
> +            grp1-pinmux {
> +                groups = "i2s";
> +                function = "gpio";
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0e493b4d6e39..e85b0c1aeebb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12041,6 +12041,7 @@ M:	zhanghongchen <zhanghongchen@loongson.cn>
>   M:	Yinbo Zhu <zhuyinbo@loongson.cn>
>   L:	linux-gpio@vger.kernel.org
>   S:	Maintained
> +F:	Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
>   F:	drivers/pinctrl/pinctrl-loongson2.c
>   
>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
> 

