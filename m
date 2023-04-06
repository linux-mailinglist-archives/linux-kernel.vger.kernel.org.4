Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0906D9DBD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239330AbjDFQpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbjDFQpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:45:30 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C17B55AE;
        Thu,  6 Apr 2023 09:45:29 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id q27so28757021oiw.0;
        Thu, 06 Apr 2023 09:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680799528; x=1683391528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okuqTE+nvv4kmh8nE7QP2fpvb7kyUn3ojSbnwLLBqII=;
        b=4Mni2m8PMfPAkrUL5W4HBcUkdqlFb6/UzcW4CohDJQad7Ff0eZQjtYcj+iXaMSHxo4
         xfmt2ClnbOiSsFIaMpU9M1qU3ug315kaGYXW+McA7NnnnySATvs8TJLbUNJRDPzC7AiA
         Al1JpR6TQ0aEqDZwNNG/kVOZNQxXD5KRadr6eOxEWcfuqVrVvnXR8EmgB9KzMXk/4bVm
         4+SOhVQ9nDhCWNnlQ96315ukDJG/vD7sn1MSguBrPS4OFPtfDeYcE/n9OkOo7vnKn0zl
         ijkGiFBpDbCemSBnhnEZj+LK0IPyOg48KXqbpiYA9te/b0iGyAcx3xDPEZhxATIyT0Z3
         l1gA==
X-Gm-Message-State: AAQBX9fuLZkjRn97Rm2FzeTpZDikdRJhIHQbOQjj86TVopuyQmGeNCYI
        0gY6RgQxSuJaktLIlGBTzx3hU94Dpw==
X-Google-Smtp-Source: AKy350bDAm/OI6lhG2rX/8wo60zHeGQhQM0V+MfK/nUW0KAC7GHqFW1OHbvJ9G8jYHlAKBWmHJFcTA==
X-Received: by 2002:a05:6808:2a8d:b0:38b:5e4:9d3b with SMTP id fc13-20020a0568082a8d00b0038b05e49d3bmr4665449oib.4.1680799528229;
        Thu, 06 Apr 2023 09:45:28 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l64-20020acabb43000000b00383ef58c15bsm847001oif.28.2023.04.06.09.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 09:45:27 -0700 (PDT)
Received: (nullmailer pid 3280156 invoked by uid 1000);
        Thu, 06 Apr 2023 16:45:27 -0000
Date:   Thu, 6 Apr 2023 11:45:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: pwm-fan: Convert to DT schema
Message-ID: <20230406164527.GA3263961-robh@kernel.org>
References: <20230404173807.490520-1-cristian.ciocaltea@collabora.com>
 <20230404173807.490520-2-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404173807.490520-2-cristian.ciocaltea@collabora.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 08:38:06PM +0300, Cristian Ciocaltea wrote:
> Convert the PWM fan bindings to DT schema format.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  .../devicetree/bindings/hwmon/pwm-fan.txt     |  68 +---------
>  .../devicetree/bindings/hwmon/pwm-fan.yaml    | 119 ++++++++++++++++++
>  2 files changed, 120 insertions(+), 67 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> index 4509e688623a..48886f0ce415 100644
> --- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> +++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> @@ -1,67 +1 @@
> -Bindings for a fan connected to the PWM lines
> -
> -Required properties:
> -- compatible	: "pwm-fan"
> -- pwms		: the PWM that is used to control the PWM fan
> -- cooling-levels      : PWM duty cycle values in a range from 0 to 255
> -			which correspond to thermal cooling states
> -
> -Optional properties:
> -- fan-supply		: phandle to the regulator that provides power to the fan
> -- interrupts		: This contains an interrupt specifier for each fan
> -			  tachometer output connected to an interrupt source.
> -			  The output signal must generate a defined number of
> -			  interrupts per fan revolution, which require that
> -			  it must be self resetting edge interrupts. See
> -			  interrupt-controller/interrupts.txt for the format.
> -- pulses-per-revolution : define the number of pulses per fan revolution for
> -			  each tachometer input as an integer (default is 2
> -			  interrupts per revolution). The value must be
> -			  greater than zero.
> -
> -Example:
> -	fan0: pwm-fan {
> -		compatible = "pwm-fan";
> -		#cooling-cells = <2>;
> -		pwms = <&pwm 0 10000 0>;
> -		cooling-levels = <0 102 170 230>;
> -	};
> -
> -	thermal-zones {
> -		cpu_thermal: cpu-thermal {
> -			     thermal-sensors = <&tmu 0>;
> -			     polling-delay-passive = <0>;
> -			     polling-delay = <0>;
> -			     trips {
> -					cpu_alert1: cpu-alert1 {
> -						    temperature = <100000>; /* millicelsius */
> -						    hysteresis = <2000>; /* millicelsius */
> -						    type = "passive";
> -					};
> -			     };
> -			     cooling-maps {
> -					map0 {
> -						    trip = <&cpu_alert1>;
> -						    cooling-device = <&fan0 0 1>;
> -					};
> -			     };
> -		};
> -
> -Example 2:
> -	fan0: pwm-fan {
> -		compatible = "pwm-fan";
> -		pwms = <&pwm 0 40000 0>;
> -		fan-supply = <&reg_fan>;
> -		interrupt-parent = <&gpio5>;
> -		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> -		pulses-per-revolution = <2>;
> -	};
> -
> -Example 3:
> -	fan0: pwm-fan {
> -		compatible = "pwm-fan";
> -		pwms = <&pwm1 0 25000 0>;
> -		interrupts-extended = <&gpio1 1 IRQ_TYPE_EDGE_FALLING>,
> -			<&gpio2 5 IRQ_TYPE_EDGE_FALLING>;
> -		pulses-per-revolution = <2>, <1>;
> -	};
> +This file has moved to pwm-fan.yaml.
> diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml b/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
> new file mode 100644
> index 000000000000..048b6ea794c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
> @@ -0,0 +1,119 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/pwm-fan.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Fan connected to PWM lines
> +
> +maintainers:
> +  - Jean Delvare <jdelvare@suse.com>
> +  - Guenter Roeck <linux@roeck-us.net>
> +
> +properties:
> +  compatible:
> +    const: pwm-fan
> +
> +  cooling-levels:
> +    description: PWM duty cycle values corresponding to thermal cooling states.
> +    items:
> +      maximum: 255
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  fan-supply:
> +    description: Phandle to the regulator that provides power to the fan.
> +
> +  interrupts:
> +    description:
> +      This contains an interrupt specifier for each fan tachometer output
> +      connected to an interrupt source. The output signal must generate a
> +      defined number of interrupts per fan revolution, which require that
> +      it must be self resetting edge interrupts.
> +    minItems: 1
> +    maxItems: 5

I'm not so sure I'd allow for more than 1 if the example is the only 
case we can find. More than 1 implies you have multiple fans controlled 
by 1 PWM. What do you do with the tach data other than display it or 
detect a stuck fan. You can't really implement any control loop unless 
you average the rpm's? I suppose there could be h/w, so okay.

> +
> +  pulses-per-revolution:
> +    description:
> +      Define the number of pulses per fan revolution for each tachometer
> +      input as an integer.
> +    items:
> +      minimum: 1
> +      maximum: 4
> +      default: 2
> +    minItems: 1
> +    maxItems: 5
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  pwms:
> +    description: The PWM that is used to control the fan.
> +    maxItems: 1
> +
> +  pwm-names: true

Not part of the original binding. It's not that useful in general if 
there's only 1 entry. It's completely useless if the name is not defined 
for the OS to use. So drop it.

> +
> +  "#cooling-cells":
> +    description:
> +      Must be 2, in order to specify minimum and maximum cooling state used in
> +      the cooling-maps reference. The first cell is the minimum cooling state
> +      and the second cell is the maximum cooling state requested.

Just duplicating the same text from thermal-cooling-devices.yaml is 
pointless.

> +    const: 2

As this is globally the only allowed value, you don't need to duplicate 
this either.

'"#cooling-cells": true"' is sufficient.

Rob

