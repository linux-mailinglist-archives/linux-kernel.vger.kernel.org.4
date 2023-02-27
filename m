Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8E36A4B9A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjB0Tvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjB0Tvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:51:45 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F98279B6;
        Mon, 27 Feb 2023 11:51:41 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-172094e10e3so8570155fac.10;
        Mon, 27 Feb 2023 11:51:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2w9C/mXgb39nbWWzCANJLsyjZIuLsO8IPSpBBNMA04=;
        b=3PaR5v/q1IAU/yANfWVnSUMwatMh4sus2Lzt3t2ZqoHB7zBP4oCG/uA/Rq4VZVzBZp
         KutZQLFREkwZGBfEgZU8xfDlPTHfpKgrC1nkejaSiuFMpTtrcPng6o08Uu/q6iUyTdir
         bPhMHIwjafpPgQmw6zHkcReqsOcsXWXh6nDWQgUj9nPvHizAaPcIt3R/1az/HeAE+v+t
         SlpOTB/queCmJaaUUSRU3yXre7LBx3Ufoy/hOnxC1dm+P6tWmFxDnOxUnex6qZS9Oy94
         r8moX5JgMcITmZlmV2JOC+tZ0r3nZuaKtK9vprsIaG3IDrxeW7rzlwEPjobAQeNrCQQH
         j+vw==
X-Gm-Message-State: AO0yUKXQcgUNMHOHEIyfBDQNh5ntlhhziojJ/GyNYMn1amo4p9l1CENC
        6kkIP9qjw+khzEKaSQ2yGA==
X-Google-Smtp-Source: AK7set8+QjpptCrKzerYds+IQtpA5ahwHgQ9R+U8uqnkDEbcdthD+ZZB5YTwTiygb3cfDhitheANoA==
X-Received: by 2002:a05:6871:586:b0:172:64f3:8430 with SMTP id u6-20020a056871058600b0017264f38430mr11660397oan.28.1677527500430;
        Mon, 27 Feb 2023 11:51:40 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m2-20020a056870194200b001727c3bf124sm2578392oak.31.2023.02.27.11.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 11:51:39 -0800 (PST)
Received: (nullmailer pid 749238 invoked by uid 1000);
        Mon, 27 Feb 2023 19:51:39 -0000
Date:   Mon, 27 Feb 2023 13:51:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <asahi@lists.linux.dev>, Henrik Rydberg <rydberg@bitmath.org>,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] dt-bindings: input: touchscreen: Add Z2
 controller bindings.
Message-ID: <20230227195139.GA677578-robh@kernel.org>
References: <20230223-z2-for-ml-v1-0-028f2b85dc15@gmail.com>
 <20230223-z2-for-ml-v1-1-028f2b85dc15@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223-z2-for-ml-v1-1-028f2b85dc15@gmail.com>
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

On Fri, Feb 24, 2023 at 11:20:06AM +0100, Sasha Finkelstein wrote:
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

Is 'z2' anything other than a touchscreen? If not, '-touchscreen' is 
redundant. If so, then what else is there? You should be describing 
physical devices, not just a protocol for touchscreen.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts-extended:

Just 'interrupts' here. 'interrupts-extended' is implicitly supported.

> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  cs-gpios:

There is a standard way to do GPIO based chip-selects. It happens to be 
'cs-gpios', but this is in the wrong place. It goes in the SPI 
controller node.

> +    maxItems: 1
> +
> +  firmware-name:
> +    maxItems: 1
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

4 space indentation is preferred here.

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

Why do we need this string? If you want a human consumed label for 
some identification, we have a property for that purpose. It's called 
'label'. But when there is only 1 instance, I don't really see the 
point.

Rob
