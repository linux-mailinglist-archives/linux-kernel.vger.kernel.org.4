Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5337C69B66D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 00:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjBQXXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 18:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjBQXXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 18:23:30 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C2D11EA1;
        Fri, 17 Feb 2023 15:23:29 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-171872a792fso2972583fac.3;
        Fri, 17 Feb 2023 15:23:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6Yd+sodJQYe42BYBBvb8iBAW4GssmfegnCeFVst0HU=;
        b=WisbSKRmORIbfDrzOjBrCHCU2xsuu2nbcI+yUjuPhSGCcKv2zFXwKmFZHpG0xFOKxo
         2qCku0hcOPhN/AMq8RfyqVEKFSffLM256RoPyZD58nwRPgrJkoqccxw3/5JIOuXY5Oix
         VYByzhdM06JQ2CPRbc4Jxc0ijfxuA8X9ZO10UBuafuHi0zQE3oFXUEyVsDkIqvwLqOkZ
         nyBtoULeaIgz0oHrUH7i1kUCCSB682SPyN1t5IPWAsHGJowSKMq25DY25bXSj5hc5/Ed
         SV6YxK70CTJNj6bnB2xcy3J25Gkeb8w8Pp1V7YPIIG/2eoOTo8TMSqIGNADXs39f2yAH
         I2NQ==
X-Gm-Message-State: AO0yUKXJoxY72oOiF/mcm9E6NwLNuJUig2iBegvAzs78i6Fs5AkpbcUU
        Vr+tyZssylbNg6OUjZNRLw==
X-Google-Smtp-Source: AK7set9uI4W1g2C/4zLiiVPKiVE1XhOgTAe+PEaeY8yYLkF4qDghjty3XEUYzNeEr5fw7J5mdUp28w==
X-Received: by 2002:a05:6870:78e:b0:16e:19a7:6241 with SMTP id en14-20020a056870078e00b0016e19a76241mr1218711oab.10.1676676208681;
        Fri, 17 Feb 2023 15:23:28 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u3-20020a05687036c300b00171920ca53esm515359oak.0.2023.02.17.15.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 15:23:28 -0800 (PST)
Received: (nullmailer pid 2254552 invoked by uid 1000);
        Fri, 17 Feb 2023 23:23:27 -0000
Date:   Fri, 17 Feb 2023 17:23:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc:     Angelo Compagnucci <angelo@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: leds: servo-pwm: Add new bindings
 for servo-pwm
Message-ID: <20230217232327.GA2243296-robh@kernel.org>
References: <20230217145731.3018148-1-angelo@amarulasolutions.com>
 <20230217145731.3018148-3-angelo@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217145731.3018148-3-angelo@amarulasolutions.com>
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

On Fri, Feb 17, 2023 at 03:57:30PM +0100, Angelo Compagnucci wrote:
> This binding describes the binding for controlling servo motors through
> pwm.
> 
> Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
> ---
>  .../devicetree/bindings/misc/servo-pwm.yaml   | 59 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/servo-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/servo-pwm.yaml b/Documentation/devicetree/bindings/misc/servo-pwm.yaml
> new file mode 100644
> index 000000000000..faa8d4734817
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/servo-pwm.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/servo-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Servo motor connected to PWM
> +
> +maintainers:
> +  - Angelo Compagnucci <angelo@amarulasolutions.com>
> +
> +description:
> +  Each servo is represented as a servo-pwm device.
> +  The 20ms period is the accepted standard and so most of the motors
> +  support it, while the positioning min/max duty cycle or the motor
> +  degrees aperture vary lot between manufacturers.
> +  The most common type of servo (SG90) has 180 degrees of movement
> +  and moves between 0.5ms and 2.5ms duty cycle.
> +
> +properties:
> +  compatible:
> +    const: servo-pwm
> +
> +patternProperties:
> +  properties:
> +    pwms:
> +      maxItems: 1
> +
> +    pwm-names: true

Drop. '-names' is for when there is more than 1.
> +
> +    degrees:

Kind of vague: servo-degrees

> +      description:
> +        How many degrees the motor can move.
> +      $ref: /schemas/types.yaml#/definitions/uint32

0-2^32 are valid degrees?

> +
> +    duty-min:
> +      description:
> +        Duty cycle for position the motor at 0 degrees.

Units are ms? percent? Use standard unit suffix.

> +      $ref: /schemas/types.yaml#/definitions/uint32
> +
> +    duty-max:
> +      description:
> +        Duty cycle for positioning the motor at "degrees" angle.
> +      $ref: /schemas/types.yaml#/definitions/uint32
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    servo: servo@0 {
> +      compatible = "servo-pwm";
> +      pwms = <&pwm 0 20000000 0>;
> +      degrees = <180>;
> +      duty-min = <500000>;
> +      duty-max = <2500000>;
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 356daea0861d..8f41daee62fc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8742,6 +8742,7 @@ M:	"Angelo Compagnucci" <angelo@amarulasolutions.com>
>  L:	linux-pwm@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-driver-servo-pwm
> +F:	Documentation/devicetree/bindings/misc/servo-pwm.yaml
>  F:	drivers/misc/servo-pwm.c
>  
>  GENERIC RESISTIVE TOUCHSCREEN ADC DRIVER
> -- 
> 2.34.1
> 
