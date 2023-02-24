Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A3A6A1AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjBXK4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjBXK4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:56:17 -0500
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB8530E0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:55:47 -0800 (PST)
X-KPN-MessageId: c61093c4-b431-11ed-a286-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id c61093c4-b431-11ed-a286-005056ab378f;
        Fri, 24 Feb 2023 11:55:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=subject:to:from:message-id:date;
        bh=RJx/5miEEl7ATiBreX1Ka8eC6+Qnya3odTkxawnV0s4=;
        b=t70F/WwqgOq+6vTGgmhKeGWGGFYzgRpH4PRUMX1Ej6jSZHpgik8vi3ieG9XzNjzqD2WOt3Lmhpu72
         ALsSEPT9wkgCL+6QFGCsifajUZxjVHfMtek74m7Yh4LM4Z/tcjR2konV/9kiAo16M0UlC213vEOS9n
         hO42tZTuJkqqL7tUrdm59TukKnmowghqj96F+oEEcOlMw0YbQzBkFRG624b3I/dgyQ/DzBhYh923zW
         No2rXoXSp5a6qQHzRB7zfCLdCP7qH/UNg43Df6QHm9/OaLTgpZ9oY9eYcIHQsQKtcYms+Tg8b6v+/L
         mUODz+cWdAEbL+PbpWE/PjgFup3h3dA==
X-KPN-MID: 33|LW3smREh+fz2rqxMvkiE7yvX7H+U5iog9wzq7EOEoaKpb7VT5qqIEQys+oTKA6s
 jA53IiSf5/zwhYREOYfvUcKKWR+ZuBmGwQUoP7FKZYT4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|4amO9HCyQ/rbm7nIi+U7uLe43otuC/mwMMYAGQFuQ2DW9aKnvwQ3Cm3RrfqxOkg
 S7jfvNYA1U9CQ84JFUjZA8w==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net [80.61.163.207])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id c90cb214-b431-11ed-927e-005056ab7584;
        Fri, 24 Feb 2023 11:55:44 +0100 (CET)
Date:   Fri, 24 Feb 2023 11:55:43 +0100
Message-Id: <87r0ufs574.fsf@bloch.sibelius.xs4all.nl>
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     fnkl.kernel@gmail.com
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, asahi@lists.linux.dev,
        rydberg@bitmath.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, fnkl.kernel@gmail.com
In-Reply-To: <20230223-z2-for-ml-v1-1-028f2b85dc15@gmail.com> (message from
        Sasha Finkelstein via B4 Relay on Fri, 24 Feb 2023 11:20:06 +0100)
Subject: Re: [PATCH RFC 1/4] dt-bindings: input: touchscreen: Add Z2 controller
 bindings.
References: <20230223-z2-for-ml-v1-0-028f2b85dc15@gmail.com> <20230223-z2-for-ml-v1-1-028f2b85dc15@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Fri, 24 Feb 2023 11:20:06 +0100
> From: Sasha Finkelstein <fnkl.kernel@gmail.com>

Hi Sasha,

> Add bindings for touchscreen controllers attached using the Z2 protocol.
> Those are present in most Apple devices.
> 
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  .../input/touchscreen/apple,z2-touchscreen.yaml    | 81 ++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/apple,z2-touchscreen.yaml b/Documentation/devicetree/bindings/input/touchscreen/apple,z2-touchscreen.yaml
> new file mode 100644
> index 000000000000..695594494b1e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/apple,z2-touchscreen.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/apple,z2-touchscreen.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple touchscreens attached using the Z2 protocol.
> +
> +maintainers:
> +  - asahi@lists.linux.dev
> +  - Sasha Finkelstein <fnkl.kernel@gmail.com>
> +
> +description: A series of touschscreen controllers used in Apple products.
> +
> +allOf:
> +  - $ref: touchscreen.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: apple,z2-touchscreen
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts-extended:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  cs-gpios:
> +    maxItems: 1
> +
> +  firmware-name:
> +    maxItems: 1

What is the motivation for including the firmware name in the device
tree rather than constructing it in the driver like what is done for
the broadcom wireless?

In your example the firmware name includes the directory name.  I
think that is a bad idea since it makes assumptions about the
directory layout used for the firmware files on the OS level.  And in
particular, forcing the firmware to be in a subdirectory named "apple"
would be awkward for the way we handle firmware in OpenBSD.

> +
> +  apple,z2-device-name:
> +    description: The name to be used for the input device
> +    $ref: /schemas/types.yaml#/definitions/string
> +
> +  touchscreen-size-x: true
> +  touchscreen-size-y: true
> +  spi-max-frequency: true
> +
> +required:
> +  - compatible
> +  - interrupts-extended
> +  - reset-gpios
> +  - cs-gpios
> +  - firmware-name
> +  - apple,z2-device-name
> +  - touchscreen-size-x
> +  - touchscreen-size-y
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            touchscreen@0 {
> +                    compatible = "apple,z2-touchscreen";
> +                    reg = <0>;
> +                    spi-max-frequency = <11500000>;
> +                    reset-gpios = <&pinctrl_ap 139 0>;
> +                    cs-gpios = <&pinctrl_ap 109 0>;
> +                    interrupts-extended = <&pinctrl_ap 194 IRQ_TYPE_EDGE_FALLING>;
> +                    firmware-name = "apple/dfrmtfw-j293.bin";
> +                    touchscreen-size-x = <23045>;
> +                    touchscreen-size-y = <640>;
> +                    apple,z2-device-name = "MacBookPro17,1 Touch Bar";
> +            };
> +    };
> +
> +...
> 
> -- 
> Git-137.1)
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
