Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236475B8A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiINORC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiINOQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:16:59 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0C111461;
        Wed, 14 Sep 2022 07:16:57 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1274ec87ad5so41421747fac.0;
        Wed, 14 Sep 2022 07:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=LqWwwMgkG7q5ptOWydu1eZtOteFgp2ChgqWkwJBq1/Y=;
        b=QyRcxR/1I67iRc4JOMrM1UHyd9ELBkgR2k5LY1Vwa277XUMq9wY9ugUsw1qdwSEZhN
         Pu5s+07Yo67EPyU3fknadJKfAe/Evrb5ibhkpyzSKauJUbyfUIPYa1+7EcOvvoti/D3W
         tLlM3yGRrD6Fz9K8mLvqG3mkFG1+rsqr4LxN3Nd1nSHzS/quucz1LCPwdVShHqYkNkdr
         UVuLKGKWfMXQfJ7mfomzUUcqvOqikFsaW9CadJTWZU4j8Oo7LZmCI6uGFXMKI8SrcgSE
         CjPlaeQcDbuJDr3YlDcGljLFaU4U30YfmIQhI5SCPTvKFMy6r7IappuHDXeTFDhOGSmc
         J7dQ==
X-Gm-Message-State: ACgBeo3JSXUaFRtRrk3eL561sDmL8yI26ZMZ2WQYx5zqc3C0qQ+UTDGL
        MfrsOqDt8QhmEFC8sZc1QQ==
X-Google-Smtp-Source: AA6agR7phoLpgx1eeplqQalugb9TIpdhbmJA6tTFog1tvBunzcuMFods958BQm82BxYmhHzdK6ybAg==
X-Received: by 2002:a05:6808:bca:b0:344:ef42:930f with SMTP id o10-20020a0568080bca00b00344ef42930fmr1919902oik.0.1663165017098;
        Wed, 14 Sep 2022 07:16:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 59-20020a9d0141000000b0063695ad0cbesm7221742otu.66.2022.09.14.07.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:16:56 -0700 (PDT)
Received: (nullmailer pid 2138104 invoked by uid 1000);
        Wed, 14 Sep 2022 14:16:55 -0000
Date:   Wed, 14 Sep 2022 09:16:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] media: dt-bindings: ov5645: Convert OV5645 binding to a
 schema
Message-ID: <20220914141655.GA2131586-robh@kernel.org>
References: <20220913160224.14951-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913160224.14951-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

What are you using from here?

(Answer below)

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
> +
> +additionalProperties: false

You are not because this prevents it. Either remove the ref or use 
unevaluatedProperties.

Rob
