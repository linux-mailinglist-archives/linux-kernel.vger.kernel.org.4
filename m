Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117A06168B7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiKBQZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiKBQZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:25:16 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E2A11458;
        Wed,  2 Nov 2022 09:20:36 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id g10so19694859oif.10;
        Wed, 02 Nov 2022 09:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKKWK9K6CWf6w2to45DX20dIVqZ+sSvcl1JMYG3WwJw=;
        b=2cwmM/mykORhXQelZ1t3spURpVjHGV9+SNLB0CHZ095KP6s5HEr0VvBRhcfYkti2x0
         JI5Dv5uPJ69XN2vRmyPXYrcMcHH4I3vCui09yRxqHElis9mZNj5WZTPExJcuL2/8Ioy4
         6GglZaAE1yW4mr7x0Ewll+5r6qigX82tOoz+fGhblaTXi/7Jqqm9YhQ/1KWQD9OD5t5f
         XNueC2jv5DFpBPmtbKMEGGCblV0ZjAXlBrjNqxVIkIbk6TKVY3X3SNNt1WgJNx7hpVE4
         G3NfpWPukIXBHbmN27GJfYTyNtnkRGsUe9RboJ8AMey+9+/Z4yY7njxEHzwS2T3FggrG
         Xj5g==
X-Gm-Message-State: ACrzQf1puGs1g92RD0QxEWmZK19SP+dCHo5kOBgxUi17HtLDO4yPBASy
        6iS3zwmgeEiBQe4T0wmldQ==
X-Google-Smtp-Source: AMsMyM40sRtEjjTznRjTUSlJ/AMyd6lq/Qrlg2HZsJu/yKJD8fE0cDXMOs+hQOcJRZdvBmdC206SNQ==
X-Received: by 2002:aca:b954:0:b0:359:fb87:84f8 with SMTP id j81-20020acab954000000b00359fb8784f8mr10592816oif.19.1667406035152;
        Wed, 02 Nov 2022 09:20:35 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a9-20020a0568300b8900b00661a16f14a1sm1874828otv.15.2022.11.02.09.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:20:34 -0700 (PDT)
Received: (nullmailer pid 3993707 invoked by uid 1000);
        Wed, 02 Nov 2022 16:20:36 -0000
Date:   Wed, 2 Nov 2022 11:20:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-input@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, afd@ti.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: input: Convert ti,drv260x to DT schema
Message-ID: <20221102162036.GA3988703-robh@kernel.org>
References: <20221031164141.919134-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031164141.919134-1-luca@z3ntu.xyz>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 05:41:41PM +0100, Luca Weiss wrote:
> Convert the drv260x haptics binding to DT schema format.
> 
> The only notable change from .txt format is that vbat-supply is not
> actually required, so don't make it a required property.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> @Andrew Davis: You maintain some other TI bindings, would you be willing
> to also maintain this one? It was originally written by Dan Murphy but
> apparently Dan no longer works for TI.
> 
> Changes since v1:
> * add $ref to types as suggested by Rob
> * change maintainer
> 
>  .../devicetree/bindings/input/ti,drv260x.txt  |  50 ---------
>  .../devicetree/bindings/input/ti,drv260x.yaml | 102 ++++++++++++++++++
>  2 files changed, 102 insertions(+), 50 deletions(-)
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
> index 000000000000..d8b9b9d5d9d9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/ti,drv260x.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/ti,drv260x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments - drv260x Haptics driver family
> +
> +maintainers:
> +  - Andrew Davis <afd@ti.com>
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

This is somewhat problematic because we have multiple 'mode' properties 
with different meanings. We already have to handle that, but Would be 
nice to deprecate at some point given there is only 1 upstream dts using 
it.

> +    $ref: /schemas/types.yaml#/definitions/uint32
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
> +
> +  library-sel:
> +    $ref: /schemas/types.yaml#/definitions/uint32
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
> +
> +  enable-gpio:

Would be need to deprecate this and allow enable-gpios.

> +    maxItems: 1
> +
> +  vib-rated-mv:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      The rated voltage of the actuator in millivolts.
> +      If this is not set then the value will be defaulted to 3200 mV.

default: 3200

> +
> +  vib-overdrive-mv:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      The overdrive voltage of the actuator in millivolts.
> +      If this is not set then the value will be defaulted to 3200 mV.

default: 3200

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
> 2.38.1
> 
> 
