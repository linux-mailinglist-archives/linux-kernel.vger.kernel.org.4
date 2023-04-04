Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600F96D6505
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbjDDORy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbjDDORx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:17:53 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5FC12D;
        Tue,  4 Apr 2023 07:17:51 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id k14-20020a9d700e000000b0069faa923e7eso17384609otj.10;
        Tue, 04 Apr 2023 07:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680617871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOEr2FRMEJDIcIVaiqrL4wvmGuw4tgVUj9P4taVN6p0=;
        b=dHFgv/ZxLlhmVu31L58A6iX1oAaROhvaScv2FiGIaFb70th6CnjqyqnfjDw0VA188O
         6pypUsnSy7CHKQwiSR9aY4pEIlCz/BeA6UGHr0ejyYXWaCp4ZNlzmgdvvoQFcRnsm0tS
         fszUa1lqlrPiAYPa49kxwj9+GdgrpaEpyRAQWEO04FrlT3pdfT3WjpKMj7ZCs5TEfjy/
         UeH+eFdSwuDg/A1vtpcOUijzq+mimr+WRu1/LQc4bH1dyH+mDZvZfP/Eeir59OBjsYzM
         WxXNgv9TPuBdZknxjpWWi3yzAn0BjddRhbhToPog4HcVHthUO6/46JKrgXBDAUdqK4GN
         lyEQ==
X-Gm-Message-State: AAQBX9cwxdrCtOLfv9EOXBgQ5EQTzwxGDBumUci3sL3NRoTIu/So/vSQ
        WKXNmpXw6fG+mQoUdbXWZg==
X-Google-Smtp-Source: AKy350Z/4gJSmyDUUAdCoeKmLMeui7C5qh7SE2KQHAsJHQNlgvDDTup3xYyfg3dlRNRtJcarP2VRaA==
X-Received: by 2002:a05:6830:1be4:b0:69f:91db:51f1 with SMTP id k4-20020a0568301be400b0069f91db51f1mr1462046otb.29.1680617870999;
        Tue, 04 Apr 2023 07:17:50 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s1-20020a056830124100b0069f02111b11sm5500646otp.75.2023.04.04.07.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:17:50 -0700 (PDT)
Received: (nullmailer pid 3824624 invoked by uid 1000);
        Tue, 04 Apr 2023 14:17:49 -0000
Date:   Tue, 4 Apr 2023 09:17:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: pwm-fan: Convert to DT schema
Message-ID: <20230404141749.GB3793612-robh@kernel.org>
References: <20230403105052.426135-1-cristian.ciocaltea@collabora.com>
 <20230403105052.426135-2-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403105052.426135-2-cristian.ciocaltea@collabora.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 01:50:51PM +0300, Cristian Ciocaltea wrote:
> Convert the PWM fan bindings to DT schema format.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  .../devicetree/bindings/hwmon/pwm-fan.txt     |  68 +----------
>  .../devicetree/bindings/hwmon/pwm-fan.yaml    | 109 ++++++++++++++++++
>  2 files changed, 110 insertions(+), 67 deletions(-)
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
> index 000000000000..448b48ec5d73
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
> @@ -0,0 +1,109 @@
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
> +    description:
> +      PWM duty cycle values in a range from 0 to 255 which correspond to

Don't put constraints in plain text:

items:
  maximum: 255

> +      thermal cooling states.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array

Unfortunately, looks like we've wound up with same property with 2 
differing types. A problem for another day...

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

How many entries? I'm not sure how more than 1 makes sense.

> +
> +  pulses-per-revolution:
> +    description:
> +      Define the number of pulses per fan revolution for each tachometer
> +      input as an integer (default is 2 interrupts per revolution).

default: 2

> +      The value must be greater than zero.

minimum: 1

maximum: ??? I assume there's some practical limit here much less than 
2^32.

> +    $ref: /schemas/types.yaml#/definitions/uint32-array

Isn't this a scalar? 
> +
> +  pwms:
> +    description: The PWM that is used to control the fan.
> +    maxItems: 1
> +
> +  pwm-names: true
> +
> +  "#cooling-cells":
> +    description: The PWM fan can be referenced as a cooling-device.

Not that useful. What would be is what's in the 2 cells.

> +    const: 2
> +
> +required:
> +  - compatible
> +  - pwms
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwm-fan {
> +      compatible = "pwm-fan";
> +      cooling-levels = <0 102 170 230>;
> +      pwms = <&pwm 0 10000 0>;
> +      #cooling-cells = <2>;
> +    };
> +
> +    thermal-zones {
> +      cpu_thermal: cpu-thermal {
> +        thermal-sensors = <&tmu 0>;
> +        polling-delay-passive = <0>;
> +        polling-delay = <0>;
> +
> +        trips {
> +          cpu_alert1: cpu-alert1 {
> +            temperature = <100000>; /* millicelsius */
> +            hysteresis = <2000>; /* millicelsius */
> +            type = "passive";
> +          };
> +        };
> +
> +        cooling-maps {
> +          map0 {
> +            trip = <&cpu_alert1>;
> +            cooling-device = <&fan0 0 1>;
> +          };
> +        };
> +      };
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    pwm-fan {
> +      compatible = "pwm-fan";
> +      pwms = <&pwm 0 40000 0>;
> +      fan-supply = <&reg_fan>;
> +      interrupt-parent = <&gpio5>;
> +      interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> +      pulses-per-revolution = <2>;
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    pwm-fan {
> +      compatible = "pwm-fan";
> +      pwms = <&pwm1 0 25000 0>;
> +      interrupts-extended = <&gpio1 1 IRQ_TYPE_EDGE_FALLING>,
> +                            <&gpio2 5 IRQ_TYPE_EDGE_FALLING>;
> +      pulses-per-revolution = <2>, <1>;
> +    };
> -- 
> 2.40.0
> 
