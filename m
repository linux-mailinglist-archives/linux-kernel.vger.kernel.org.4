Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C588E6F8A17
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjEEUUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjEEUUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:20:15 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D173744A4;
        Fri,  5 May 2023 13:20:13 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6a5e8baad21so1725961a34.2;
        Fri, 05 May 2023 13:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683318013; x=1685910013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeVjl15EmXwPrSoTLLJ5uHm4Jcc6syTLqrZaF+h77Ng=;
        b=Gwj+lp7adFR/kbVms44riGUemS64d7oBUEBp9UGrxvbJcI7L/V49WU/wPFTkFAVc8R
         2t7xi6xgie04iuudkjXPSRq/i7Pi0FJj1yBGe7/1g3nui8VoLIAoEbNk2jo7P5VYXpna
         FFuPURl/U0vGDMH5/cnruyX57EUD9MB8LodNedlG7SJb2YxU0mIkujy6vWMXwztDrPR2
         vIC5lJcZZnVaEdp6JucvYtNhL4zZUCWQFfT2LRjIKz+s0hTNdDEMDZjrH+Q0kp+FfeG+
         pm2dVy+KVwKbxGbRgPbTkoc0ZRkmRM3UfTjjJqGC5PK9tXWIA6oYRFVHo7rH8G23bURj
         7qXQ==
X-Gm-Message-State: AC+VfDw5S0ib8HP/W52ttaiokLEWw0JxGhb866AHTOoIe29IRYdnayBd
        lVJAlBmFslLJ6GHAAVScyw==
X-Google-Smtp-Source: ACHHUZ7X8aQNmpfMIMdOoP0/+wzyXQXke+6RJNTzYtkQr3VDmT0W1LeWUqibheXdp6rvT1lPprIs3w==
X-Received: by 2002:a05:6870:e28c:b0:187:baaf:fb24 with SMTP id v12-20020a056870e28c00b00187baaffb24mr1409070oad.29.1683318012756;
        Fri, 05 May 2023 13:20:12 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p5-20020a056870868500b00172ac40356csm2218324oam.50.2023.05.05.13.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 13:20:12 -0700 (PDT)
Received: (nullmailer pid 3501013 invoked by uid 1000);
        Fri, 05 May 2023 20:20:10 -0000
Date:   Fri, 5 May 2023 15:20:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Helge Deller <deller@gmx.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-pwm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/4] dt-bindings: backlight: lp855x: convert to YAML and
 modernize
Message-ID: <20230505202010.GA3494651-robh@kernel.org>
References: <20230429104534.28943-1-aweber.kernel@gmail.com>
 <20230429104534.28943-2-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230429104534.28943-2-aweber.kernel@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2023 at 12:45:31PM +0200, Artur Weber wrote:
> Notable changes:
> - ROM child nodes use dashes instead of underscores; the driver
>   reads all child nodes regardless of their names, so this doesn't
>   break ABI.
> - pwm-period argument is deprecated, as it effectively duplicates
>   the period value provided in pwms. The driver continues to accept
>   the property, so this should not break ABI.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
>  .../leds/backlight/lp855x-backlight.yaml      | 148 ++++++++++++++++++
>  .../bindings/leds/backlight/lp855x.txt        |  72 ---------
>  2 files changed, 148 insertions(+), 72 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/lp855x-backlight.yaml
>  delete mode 100644 Documentation/devicetree/bindings/leds/backlight/lp855x.txt
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/lp855x-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lp855x-backlight.yaml
> new file mode 100644
> index 000000000000..dfe8131d2a32
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/lp855x-backlight.yaml
> @@ -0,0 +1,148 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/lp855x-backlight.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments LP855X backlight controllers
> +
> +maintainers:
> +  - Artur Weber <aweber.kernel@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,lp8550
> +      - ti,lp8551
> +      - ti,lp8552
> +      - ti,lp8553
> +      - ti,lp8555
> +      - ti,lp8556
> +      - ti,lp8557
> +
> +  reg:
> +    maxItems: 1
> +
> +  dev-ctrl:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description:
> +      Value of device control register. This is a device-specific value.
> +
> +  bl-name:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: Backlight device name.
> +
> +  init-brt:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description: Initial value of backlight brightness.
> +
> +  power-supply:
> +    description: Regulator which controls the 3V rail.
> +
> +  enable-supply:
> +    description: Regulator which controls the EN/VDDIO input.
> +
> +  pwms:
> +    maxItems: 1
> +    description: |
> +      PWM channel to use for controlling the backlight; setting this
> +      enables the PWM-based backlight control mode.
> +
> +  pwm-names: true
> +
> +  pwm-period:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      PWM period value. Deprecated; set the period value in the pwms
> +      property instead.
> +    deprecated: true
> +
> +patternProperties:
> +  "^rom-[0-9a-f]{2}h$":
> +    type: object
> +    description: Nodes containing the values of configuration registers.

       additionalProperties: false

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +    properties:
> +      rom-addr:
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        description: Register address of ROM area to be updated.
> +
> +      rom-val:
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        description: Value to write to the ROM register.
> +
> +required:
> +  - compatible
> +  - reg
> +  - dev-ctrl
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        backlight@2c {
> +            compatible = "ti,lp8555";
> +            reg = <0x2c>;
> +
> +            dev-ctrl = /bits/ 8 <0x00>;
> +
> +            pwms = <&pwm 0 10000>;
> +            pwm-names = "lp8555";
> +
> +            /* 4V OV, 4 output LED0 string enabled */
> +            rom-14h {
> +              rom-addr = /bits/ 8 <0x14>;
> +              rom-val = /bits/ 8 <0xcf>;
> +            };
> +
> +            /* Heavy smoothing, 24ms ramp time step */
> +            rom-15h {
> +              rom-addr = /bits/ 8 <0x15>;
> +              rom-val = /bits/ 8 <0xc7>;
> +            };
> +
> +            /* 4 output LED1 string enabled */
> +            rom-19h {
> +              rom-addr = /bits/ 8 <0x19>;
> +              rom-val = /bits/ 8 <0x0f>;
> +            };
> +        };
> +    };
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        backlight@2c {
> +            compatible = "ti,lp8556";
> +            reg = <0x2c>;
> +
> +            bl-name = "lcd-bl";
> +            dev-ctrl = /bits/ 8 <0x85>;
> +            init-brt = /bits/ 8 <0x10>;
> +        };
> +      };
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        backlight@2c {
> +            compatible = "ti,lp8557";
> +            reg = <0x2c>;
> +            enable-supply = <&backlight_vddio>;
> +            power-supply = <&backlight_vdd>;
> +
> +            dev-ctrl = /bits/ 8 <0x41>;
> +            init-brt = /bits/ 8 <0x0a>;
> +
> +            /* 4V OV, 4 output LED string enabled */
> +            rom-14h {
> +              rom-addr = /bits/ 8 <0x14>;
> +              rom-val = /bits/ 8 <0xcf>;
> +            };
> +        };
> +    };
