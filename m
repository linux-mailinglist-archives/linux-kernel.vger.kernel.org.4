Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE44E5B9027
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 23:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiINVlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 17:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiINVlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 17:41:40 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECC37E325
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 14:41:37 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bz13so27753821wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 14:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=dJBMWqAoD425WmZpBoL2iVG1R9TS8rIDI+wnZ+EHS08=;
        b=crnKzEVwiNAICu1JTVyVuS8qkwtdrbZVF4fXL4lQiQcf1uf/m03DZ90Sbqu8XLQnCU
         CtuhnRZbmY9frmlgrfrPaZY0MZVcfo+YTnKTlWCts1Y6xjtfOw/3vg18Z2D8v9uBaiwI
         MkQkfmNyXhNtIJV3BRm3Ce3BQAvKuq9lEddpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=dJBMWqAoD425WmZpBoL2iVG1R9TS8rIDI+wnZ+EHS08=;
        b=OihwTM7VC+ScZSy/NFYTB3t3gkBUWE+LlV/XLKe2lFFnE9oWi3RTh86Jgf4ZQhoyQ+
         +qHvD3dTo+XY2AqjXqx47B/olS4GdC+KQPgEFFTPPA5S1BrpyjJsnSpdwUb3JPuAzedp
         DjDAPeW16Cc5wNW0Xprs42NkwwZvZFgPO39OXUqTrUvRbPiuyO3A8NZ6iWXcY4cFRbbN
         7ZOPPtAcASFvUcb51+9aBw27uJTKrL1WrpSgc79RSxYkxHKJLrgtBXRMeL2JAjub757Q
         j1p5tb9NlEVZIGPoeedSBUT86l001Epa+zPVbz5mHm2VphTcOu2euKrajoHzBNeF1Gmu
         eDhQ==
X-Gm-Message-State: ACgBeo1Wev/q6GAW3pdQtYCA7lfcOTvnboYaOy4Zxh/WnY4YZHVogenk
        QuSBJ28wsuBDZZYFuhF3t0QYnQ==
X-Google-Smtp-Source: AA6agR4AbWOEHie2xqoqLtD3nL+zuOB6oM2HbRcpPVp+Z0KnHfJaD12MLF4DRxtbqmt6fxXPQ7U5NA==
X-Received: by 2002:a5d:628e:0:b0:228:6961:aa6f with SMTP id k14-20020a5d628e000000b002286961aa6fmr24027761wru.36.1663191696195;
        Wed, 14 Sep 2022 14:41:36 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i ([93.107.34.250])
        by smtp.gmail.com with ESMTPSA id az6-20020a05600c600600b003a5f54e3bbbsm308512wmb.38.2022.09.14.14.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 14:41:34 -0700 (PDT)
Date:   Wed, 14 Sep 2022 23:41:32 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] media: dt-bindings: ov5645: Convert OV5645 binding to a
 schema
Message-ID: <20220914214132.GA2173@tom-ThinkPad-T14s-Gen-2i>
References: <20220913160224.14951-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913160224.14951-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Tue, Sep 13, 2022 at 05:02:24PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Convert the simple OV5645 Device Tree binding to json-schema.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../devicetree/bindings/media/i2c/ov5645.txt  |  54 --------
>  .../bindings/media/i2c/ovti,ov5645.yaml       | 119 ++++++++++++++++++
>  2 files changed, 119 insertions(+), 54 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/i2c/ov5645.txt
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5645.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ov5645.txt b/Documentation/devicetree/bindings/media/i2c/ov5645.txt
> deleted file mode 100644
> index 72ad992f77be..000000000000
> --- a/Documentation/devicetree/bindings/media/i2c/ov5645.txt
> +++ /dev/null
> @@ -1,54 +0,0 @@
> -* Omnivision 1/4-Inch 5Mp CMOS Digital Image Sensor
> -
> -The Omnivision OV5645 is a 1/4-Inch CMOS active pixel digital image sensor with
> -an active array size of 2592H x 1944V. It is programmable through a serial I2C
> -interface.
> -
> -Required Properties:
> -- compatible: Value should be "ovti,ov5645".
> -- clocks: Reference to the xclk clock.
> -- clock-names: Should be "xclk".
> -- clock-frequency: Frequency of the xclk clock.
> -- enable-gpios: Chip enable GPIO. Polarity is GPIO_ACTIVE_HIGH. This corresponds
> -  to the hardware pin PWDNB which is physically active low.
> -- reset-gpios: Chip reset GPIO. Polarity is GPIO_ACTIVE_LOW. This corresponds to
> -  the hardware pin RESETB.
> -- vdddo-supply: Chip digital IO regulator.
> -- vdda-supply: Chip analog regulator.
> -- vddd-supply: Chip digital core regulator.
> -
> -The device node must contain one 'port' child node for its digital output
> -video port, in accordance with the video interface bindings defined in
> -Documentation/devicetree/bindings/media/video-interfaces.txt.
> -
> -Example:
> -
> -	&i2c1 {
> -		...
> -
> -		ov5645: ov5645@3c {
> -			compatible = "ovti,ov5645";
> -			reg = <0x3c>;
> -
> -			enable-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
> -			reset-gpios = <&gpio5 20 GPIO_ACTIVE_LOW>;
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&camera_rear_default>;
> -
> -			clocks = <&clks 200>;
> -			clock-names = "xclk";
> -			clock-frequency = <24000000>;
> -
> -			vdddo-supply = <&camera_dovdd_1v8>;
> -			vdda-supply = <&camera_avdd_2v8>;
> -			vddd-supply = <&camera_dvdd_1v2>;
> -
> -			port {
> -				ov5645_ep: endpoint {
> -					clock-lanes = <1>;
> -					data-lanes = <0 2>;
> -					remote-endpoint = <&csi0_ep>;
> -				};
> -			};
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5645.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5645.yaml
> new file mode 100644
> index 000000000000..7f407c988f87
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5645.yaml
> @@ -0,0 +1,119 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/ovti,ov5645.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OmniVision OV5645 Image Sensor Device Tree Bindings
> +
> +maintainers:
> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> +
> +allOf:
> +  - $ref: /schemas/media/video-interface-devices.yaml#
> +
> +properties:
> +  compatible:
> +    const: ovti,ov5645
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description: XCLK Input Clock
> +
> +  clock-names:
> +    const: xclk
> +
> +  clock-frequency:
> +    description: Frequency of the xclk clock in Hz.
> +
> +  vdda-supply:
> +    description: Analog voltage supply, 2.8 volts
> +
> +  vddd-supply:
> +    description: Digital core voltage supply, 1.5 volts
> +
> +  vdddo-supply:
> +    description: Digital I/O voltage supply, 1.8 volts
> +
> +  enable-gpios:
> +    maxItems: 1
> +    description:
> +      Reference to the GPIO connected to the PWDNB pin, if any.
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      Reference to the GPIO connected to the RESETB pin, if any.
> +
> +  port:
> +    description: Digital Output Port
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    additionalProperties: false
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          clock-lanes:
> +            const: 0
> +
> +          bus-type:
> +            const: 4
> +
> +          data-lanes:
> +            minItems: 1
> +            maxItems: 2
> +            items:
> +              enum: [1, 2]
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - clock-frequency
> +  - vdda-supply
> +  - vddd-supply
> +  - vdddo-supply
> +  - enable-gpios
> +  - reset-gpios
> +  - port

I think we don't need all of these properties as required.
The only "really" required are:

  - compatible
  - reg
  - clocks
  - port

Regards,
Tommaso

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +      #include <dt-bindings/gpio/gpio.h>
> +
> +      i2c {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          camera@3c {
> +              compatible = "ovti,ov5645";
> +              pinctrl-names = "default";
> +              pinctrl-0 = <&pinctrl_ov5645>;
> +              reg = <0x3c>;
> +              clocks = <&clks 1>;
> +              clock-names = "xclk";
> +              clock-frequency = <24000000>;
> +              vdddo-supply = <&ov5645_vdddo_1v8>; /* 1.8v */
> +              vdda-supply = <&ov5645_vdda_2v8>;  /* 2.8v */
> +              vddd-supply = <&ov5645_vddd_1v5>;  /* 1.5v */
> +              enable-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
> +              reset-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
> +
> +              port {
> +                  ov5645_ep: endpoint {
> +                      remote-endpoint = <&csi0_ep>;
> +                      clock-lanes = <0>;
> +                      data-lanes = <1 2>;
> +                  };
> +              };
> +          };
> +      };
> +...
> -- 
> 2.25.1
> 

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
