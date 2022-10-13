Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9E45FE348
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJMU3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJMU3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:29:15 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64746585;
        Thu, 13 Oct 2022 13:29:14 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id n130so2996946oia.6;
        Thu, 13 Oct 2022 13:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVoG15DGYHXUYXpp1vGHqTCfoD2DJxUKJDFtDtEjdiQ=;
        b=6vkWjJs0a5WsaLOr9vTQDCWXcrTkmJb0fNTEi9LPpDNfblzYkgpOwXk5oTMmovyOdJ
         0VhQ+iG20pHoCU1RUsf3HPQ7d041z2xC7hzx353ic/22sBp9YTYldnRSt3Otb9T9mwsX
         NcuhvVO/iytipO7XOpMW+GLBvgAXoJrjd8SFlEgBNxpisFl4f40/JQE8IDgL+k1nd6oo
         mT2+HDQubhMfDqJraVBQ2e5//OOhZ4RCi4m/b0pcOAhzkWngvr+qDFzRD/fo170SooG9
         e/cMhGDfg5Cj6uZsu/gfckcvruaOa8qGaAl4nsMwmKMLMPtK4/qWYRg8HH0Z/P/ppBbg
         KDJA==
X-Gm-Message-State: ACrzQf3WphdT2O82yz4J4sk6Y1RqrnPUPRmhgb90WPBy5D/x6ivl6aQR
        Z3h1rfqP6GeOMbczUna9yvS7AC0Uwg==
X-Google-Smtp-Source: AMsMyM7yLuYiVZfTvf/FCS89TslSEOV/C8bxuG/l4XaKKAatdepdd241qF2CbHWKZTe0soib7W020A==
X-Received: by 2002:a05:6808:1706:b0:351:8703:2271 with SMTP id bc6-20020a056808170600b0035187032271mr5972293oib.76.1665692953998;
        Thu, 13 Oct 2022 13:29:13 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k4-20020a9d7604000000b0066194b13fe9sm351102otl.73.2022.10.13.13.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 13:29:13 -0700 (PDT)
Received: (nullmailer pid 178041 invoked by uid 1000);
        Thu, 13 Oct 2022 20:29:14 -0000
Date:   Thu, 13 Oct 2022 15:29:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-input@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: Convert ti,drv260x to DT schema
Message-ID: <20221013202914.GA175270-robh@kernel.org>
References: <20221012214219.28976-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012214219.28976-1-luca@z3ntu.xyz>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 11:42:16PM +0200, Luca Weiss wrote:
> Convert the drv260x haptics binding to DT schema format.
> 
> The only notable change from .txt format is that vbat-supply is not
> actually required, so don't make it a required property.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  .../devicetree/bindings/input/ti,drv260x.txt  | 50 ----------
>  .../devicetree/bindings/input/ti,drv260x.yaml | 98 +++++++++++++++++++
>  2 files changed, 98 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/ti,drv260x.txt
>  create mode 100644 Documentation/devicetree/bindings/input/ti,drv260x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/ti,drv260x.txt b/Documentation/devicetree/bindings/input/ti,drv260x.txt
> deleted file mode 100644
> index 4c5312eaaa85..000000000000
> --- a/Documentation/devicetree/bindings/input/ti,drv260x.txt
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -* Texas Instruments - drv260x Haptics driver family
> -
> -Required properties:
> -	- compatible - One of:
> -		"ti,drv2604" - DRV2604
> -		"ti,drv2605" - DRV2605
> -		"ti,drv2605l" - DRV2605L
> -	- reg -  I2C slave address
> -	- vbat-supply - Required supply regulator
> -	- mode - Power up mode of the chip (defined in include/dt-bindings/input/ti-drv260x.h)
> -		DRV260X_LRA_MODE - Linear Resonance Actuator mode (Piezoelectric)
> -		DRV260X_LRA_NO_CAL_MODE - This is a LRA Mode but there is no calibration
> -				sequence during init.  And the device is configured for real
> -				time playback mode (RTP mode).
> -		DRV260X_ERM_MODE - Eccentric Rotating Mass mode (Rotary vibrator)
> -	- library-sel - These are ROM based waveforms pre-programmed into the IC.
> -				This should be set to set the library to use at power up.
> -				(defined in include/dt-bindings/input/ti-drv260x.h)
> -		DRV260X_LIB_EMPTY - Do not use a pre-programmed library
> -		DRV260X_ERM_LIB_A - Pre-programmed Library
> -		DRV260X_ERM_LIB_B - Pre-programmed Library
> -		DRV260X_ERM_LIB_C - Pre-programmed Library
> -		DRV260X_ERM_LIB_D - Pre-programmed Library
> -		DRV260X_ERM_LIB_E - Pre-programmed Library
> -		DRV260X_ERM_LIB_F - Pre-programmed Library
> -		DRV260X_LIB_LRA - Pre-programmed LRA Library
> -
> -Optional properties:
> -	- enable-gpio - gpio pin to enable/disable the device.
> -	- vib-rated-mv - The rated voltage of the actuator in millivolts.
> -			  If this is not set then the value will be defaulted to
> -			  3.2 v.
> -	- vib-overdrive-mv - The overdrive voltage of the actuator in millivolts.
> -			  If this is not set then the value will be defaulted to
> -			  3.2 v.
> -Example:
> -
> -haptics: haptics@5a {
> -	compatible = "ti,drv2605l";
> -	reg = <0x5a>;
> -	vbat-supply = <&vbat>;
> -	enable-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> -	mode = <DRV260X_LRA_MODE>;
> -	library-sel = <DRV260X_LIB_LRA>;
> -	vib-rated-mv = <3200>;
> -	vib-overdrive-mv = <3200>;
> -}
> -
> -For more product information please see the link below:
> -http://www.ti.com/product/drv2605
> diff --git a/Documentation/devicetree/bindings/input/ti,drv260x.yaml b/Documentation/devicetree/bindings/input/ti,drv260x.yaml
> new file mode 100644
> index 000000000000..7d67e815f80d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/ti,drv260x.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/ti,drv260x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments - drv260x Haptics driver family
> +
> +maintainers:
> +  - Dmitry Torokhov <dmitry.torokhov@gmail.com>

Should be someone that knows about and has this h/w, not who applies 
patches. 

> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,drv2604
> +      - ti,drv2605
> +      - ti,drv2605l
> +
> +  reg:
> +    maxItems: 1
> +
> +  vbat-supply:
> +    description: Power supply to the haptic motor
> +
> +  mode:
> +    description: |
> +      Power up mode of the chip
> +      (defined in include/dt-bindings/input/ti-drv260x.h)
> +
> +      DRV260X_LRA_MODE
> +        Linear Resonance Actuator mode (Piezoelectric)
> +
> +      DRV260X_LRA_NO_CAL_MODE
> +        This is a LRA Mode but there is no calibration sequence during init.
> +        And the device is configured for real time playback mode (RTP mode).
> +
> +      DRV260X_ERM_MODE
> +        Eccentric Rotating Mass mode (Rotary vibrator)
> +    enum: [ 0, 1, 2 ]

Needs a type $ref.

> +
> +  library-sel:
> +    description: |
> +      These are ROM based waveforms pre-programmed into the IC.
> +      This should be set to set the library to use at power up.
> +      (defined in include/dt-bindings/input/ti-drv260x.h)
> +
> +      DRV260X_LIB_EMPTY - Do not use a pre-programmed library
> +      DRV260X_ERM_LIB_A - Pre-programmed Library
> +      DRV260X_ERM_LIB_B - Pre-programmed Library
> +      DRV260X_ERM_LIB_C - Pre-programmed Library
> +      DRV260X_ERM_LIB_D - Pre-programmed Library
> +      DRV260X_ERM_LIB_E - Pre-programmed Library
> +      DRV260X_ERM_LIB_F - Pre-programmed Library
> +      DRV260X_LIB_LRA - Pre-programmed LRA Library
> +    enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]

Needs a type $ref.

> +
> +  enable-gpio:
> +    maxItems: 1
> +
> +  vib-rated-mv:

As 'mv' is not the standard unit suffix, this needs a type $ref.

> +    description: |
> +      The rated voltage of the actuator in millivolts.
> +      If this is not set then the value will be defaulted to 3200 mV.
> +
> +  vib-overdrive-mv:

Ditto.

> +    description: |
> +      The overdrive voltage of the actuator in millivolts.
> +      If this is not set then the value will be defaulted to 3200 mV.
> +
> +required:
> +  - compatible
> +  - reg
> +  - enable-gpio
> +  - mode
> +  - library-sel
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/input/ti-drv260x.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        haptics@5a {
> +            compatible = "ti,drv2605l";
> +            reg = <0x5a>;
> +            vbat-supply = <&vbat>;
> +            enable-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> +            mode = <DRV260X_LRA_MODE>;
> +            library-sel = <DRV260X_LIB_LRA>;
> +            vib-rated-mv = <3200>;
> +            vib-overdrive-mv = <3200>;
> +        };
> +    };
> -- 
> 2.38.0
> 
> 
