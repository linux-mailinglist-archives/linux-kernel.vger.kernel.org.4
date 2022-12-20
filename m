Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E03B6526C0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiLTTGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiLTTGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:06:47 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391112AC9;
        Tue, 20 Dec 2022 11:06:46 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id t62so11371429oib.12;
        Tue, 20 Dec 2022 11:06:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAroOdFafdSPzLQwUTuMraqKacl3aj1aXlD6YFUl93A=;
        b=ZENqpbGol/QN1subyobWY3V7fCWYDCb+zZB6cGdx33TlfJR72sAAK03aWExbfuiVPK
         RgW2EDTspjP/nghWgaAs1Ev5Ct5MR2G71DsUvILm8bj22o2/ViXIHN18aDOk6cImmCTs
         OLob0Oan52sjjA3LAaCCHDs81y0jrXkRbVhx66VwoKI0n5pV7JtMCdmjNaj9VdFPtvKS
         bXqvh6OGcRtcM0basS1r1Pr6LtU4EfmjpH02guk/swQcp5wZWwrOVTWiQ88EodgXOY2/
         pJTn/JseCYSwAaHKiAPB2rdRPo9Sq65TmTdZ9O6euxwhA7RI5lmkx5uwa2wdq/AsTp5I
         9RvQ==
X-Gm-Message-State: ANoB5pmUiUYdWdsie9/YkCs2Gdoy16ioiVddZiMCmiDgZMLYoyDiYkS0
        0lRW5Xik6a7vFG7hAoYJf76maToRYg==
X-Google-Smtp-Source: AA0mqf7R3vpr3KBdxvczjHxtl3CvtMVqJ0nsz6a5O2A3cUCwllmDs8793shzQkYbN80xyG5OvURbag==
X-Received: by 2002:aca:1c19:0:b0:35e:2397:2211 with SMTP id c25-20020aca1c19000000b0035e23972211mr17867796oic.51.1671563205330;
        Tue, 20 Dec 2022 11:06:45 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q124-20020aca5c82000000b003509cc4ad4esm5802705oib.39.2022.12.20.11.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 11:06:44 -0800 (PST)
Received: (nullmailer pid 920145 invoked by uid 1000);
        Tue, 20 Dec 2022 19:06:44 -0000
Date:   Tue, 20 Dec 2022 13:06:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     jdelvare@suse.com, krzysztof.kozlowski+dt@linaro.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        conor@kernel.org
Subject: Re: [PATCH v2] dt-bindings: hwmon: gpio-fan: convert to YAML
Message-ID: <20221220190644.GA898302-robh@kernel.org>
References: <20221217210423.836948-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217210423.836948-1-clabbe@baylibre.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 09:04:23PM +0000, Corentin Labbe wrote:
> Converts hwmon/gpio-fan.txt to YAML

s/YAML/DT schema\./

> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Changes since v1:
> - Keeped only one example and simplified it
> 
>  .../devicetree/bindings/hwmon/gpio-fan.txt    | 41 -------------
>  .../devicetree/bindings/hwmon/gpio-fan.yaml   | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 41 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/gpio-fan.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/gpio-fan.txt b/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
> deleted file mode 100644
> index f4cfa350f6a1..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -Bindings for fan connected to GPIO lines
> -
> -Required properties:
> -- compatible : "gpio-fan"
> -
> -Optional properties:
> -- gpios: Specifies the pins that map to bits in the control value,
> -  ordered MSB-->LSB.
> -- gpio-fan,speed-map: A mapping of possible fan RPM speeds and the
> -  control value that should be set to achieve them. This array
> -  must have the RPM values in ascending order.
> -- alarm-gpios: This pin going active indicates something is wrong with
> -  the fan, and a udev event will be fired.
> -- #cooling-cells: If used as a cooling device, must be <2>
> -  Also see:
> -  Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> -  min and max states are derived from the speed-map of the fan.
> -
> -Note: At least one the "gpios" or "alarm-gpios" properties must be set.
> -
> -Examples:
> -
> -	gpio_fan {
> -		compatible = "gpio-fan";
> -		gpios = <&gpio1 14 1
> -			 &gpio1 13 1>;
> -		gpio-fan,speed-map = <0    0
> -				      3000 1
> -				      6000 2>;
> -		alarm-gpios = <&gpio1 15 1>;
> -	};
> -	gpio_fan_cool: gpio_fan {
> -		compatible = "gpio-fan";
> -		gpios = <&gpio2 14 1
> -			 &gpio2 13 1>;
> -		gpio-fan,speed-map =	<0    0>,
> -					<3000 1>,
> -					<6000 2>;
> -		alarm-gpios = <&gpio2 15 1>;
> -		#cooling-cells = <2>; /* min followed by max */
> -	};
> diff --git a/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml b/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
> new file mode 100644
> index 000000000000..c522072c0d07
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/gpio-fan.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bindings for fan connected to GPIO lines

Drop 'Bindings for'. Really, just 'GPIO controlled Fan' is good.

> +
> +maintainers:
> +  - OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>

Should be a person. You can put me.

> +
> +properties:
> +  compatible:
> +    const: gpio-fan
> +
> +  gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

Already has a type. Perhaps 'maxItems: N' where N is 'should be enough'. 
I'd guess 4 is more than enough. Any sane design would go with a PWM 
controlled fan if that much control is needed.

> +    description: Specifies the pins that map to bits in the control value,
> +      ordered MSB-->LSB.
> +
> +  gpio-fan,speed-map:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description: A mapping of possible fan RPM speeds and the
> +      control value that should be set to achieve them. This array
> +      must have the RPM values in ascending order.

Needs some constraints and the entries can be better described:

minItems: 2  (I would assume there is no point in 1 entry?)
maxItems: N
items:
  items:
    - description: Speed in RPM
    - description: GPIO Control value

> +
> +  alarm-gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

Drop.

maxItems: 1

> +    description: This pin going active indicates something is wrong with
> +      the fan, and a udev event will be fired.

'udev event' is way outside the scope of a binding.

> +
> +  "#cooling-cells":
> +    const: 2
> +    description: If used as a cooling device, must be <2>

If not used as a cooling device can be any number of cells? 

Don't repeat constraints in free form text.

> +      Also see Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml

No need to reference schema for common properties.

> +      min and max states are derived from the speed-map of the fan.

This IS unique to this binding, so it should stay.

> +
> +anyOf:
> +  - required:
> +      - gpios
> +  - required:
> +      - alarm-gpios
> +
> +additionalProperties: False
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/cortina,gemini-clock.h>
> +    #include <dt-bindings/reset/cortina,gemini-reset.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    gpio_fan {
> +      compatible = "gpio-fan";
> +        gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
> +        gpio-fan,speed-map = <0    0>,
> +                             <3000 1>,
> +                             <6000 2>;

How does a single GPIO encode 3 states?

> +        alarm-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
> +    };
> -- 
> 2.37.4
> 
> 
