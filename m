Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E5061FEBA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbiKGTdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiKGTdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:33:12 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63EF2AE1F;
        Mon,  7 Nov 2022 11:33:11 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id p12so6492882plq.4;
        Mon, 07 Nov 2022 11:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9FbCXu0bl7pZG6QFEHOS4TPpbj4WHgdP+NpROu90qrA=;
        b=Bw4C5UXM5QvJd9Ssl2Em7HdIiSbj1yOfUxj6eBfugEvDNJTZWhK9vHscDFxIh21xnP
         ydA9FbMAvm5EEz4Na7F/WFZqqmqV8/4mBZ3+rt3L3UjFBnXqmSkfz9d0ZVY5rT5IXKwp
         cleo2Nqtuj/L0N/MKBqsbOV4mvtb8Hz1rO4XO3aSkkmSyOYauyZ/PeI3VBLzMfYNdhN4
         JrxEde4EmzSuQIIWSrIsjbyIWhrxQ/Tk9FdJKcDVo110/kWBiEOTKoTcZ6K8q5a3DvvA
         bWOr5xZBRR1vLmidP3WNUNuPVmI+oTugwjW/R2dL6d2qsW3obgAwtvNHIFDDkMOSMVlV
         9oxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FbCXu0bl7pZG6QFEHOS4TPpbj4WHgdP+NpROu90qrA=;
        b=x4dvrVGktqYmJ3ta1EgjSPf7Bvl/RCIBibKjsdELZvFCzwo5pANel4x4Yj+Ht7MT7b
         YNsfyd2gBRYKhxc7/o1ko36uMq8f9CiS1DzFoficL2v247hhFbYRGGOQ/h+09S8Oy47j
         I5DEnTrv0mVa+38+xyRsjlTMvQ/KeqDIOzf/VHHeXoRJmXxM1n2ZzlQa8jRzAT+BfOqo
         n1Q7HC1YxwQCpCA4oGmT0bnrJTc72mD5AAHtAJkc7HF/QPNu4IDV3a0W3BP0sLxYq69H
         9sZl6qf5REmzQ8Ipb/cY9sTZFWuzzpEapYNmyTdN6lDdmNiiF8lwTFHR8aumJ+AzdVAK
         XK0A==
X-Gm-Message-State: ACrzQf0oeb29WYVSlRsoOihZIS5YcD5B4FA3dwXSYI2tS1IJg5fP4+SK
        4ChlPUVMiTGM3IwBsCkhNDzSX2AgWdM=
X-Google-Smtp-Source: AMsMyM4hob3NTD8fiz9IK/EAFcv9t9vhljBb3SVPQVXwJwpfFDF84zXLElZtwDu6eyUNucYDiH9xiw==
X-Received: by 2002:a17:902:ced2:b0:187:1dda:6897 with SMTP id d18-20020a170902ced200b001871dda6897mr44131130plg.83.1667849590952;
        Mon, 07 Nov 2022 11:33:10 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:626:eb80:9eb9:1fd7])
        by smtp.gmail.com with ESMTPSA id t10-20020a63224a000000b00460d89df1f1sm4502316pgm.57.2022.11.07.11.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 11:33:10 -0800 (PST)
Date:   Mon, 7 Nov 2022 11:33:07 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-input@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andrew Davis <afd@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: input: Convert ti,drv260x to DT schema
Message-ID: <Y2ldc33ByZB/T+kZ@google.com>
References: <20221105141707.92652-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221105141707.92652-1-luca@z3ntu.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 03:17:06PM +0100, Luca Weiss wrote:
> Convert the drv260x haptics binding to DT schema format.
> 
> The only notable change from .txt format is that vbat-supply is not
> actually required, so don't make it a required property.
> 
> Acked-by: Andrew Davis <afd@ti.com>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes since v2:
> * add default values for vib-*-mv
> * add note about 'mode' property
> * add enable-gpios, deprecate enable-gpio
> 
>  .../devicetree/bindings/input/ti,drv260x.txt  |  50 --------
>  .../devicetree/bindings/input/ti,drv260x.yaml | 109 ++++++++++++++++++
>  2 files changed, 109 insertions(+), 50 deletions(-)
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
> index 000000000000..63230977043e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/ti,drv260x.yaml
> @@ -0,0 +1,109 @@
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
> +  # TODO: Deprecate 'mode' in favor of differently named property
> +  mode:
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
> +    maxItems: 1
> +    deprecated: true
> +
> +  enable-gpios:
> +    maxItems: 1
> +
> +  vib-rated-mv:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      The rated voltage of the actuator in millivolts.
> +      If this is not set then the value will be defaulted to 3200 mV.
> +    default: 3200
> +
> +  vib-overdrive-mv:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      The overdrive voltage of the actuator in millivolts.
> +      If this is not set then the value will be defaulted to 3200 mV.
> +    default: 3200
> +
> +required:
> +  - compatible
> +  - reg
> +  - enable-gpio

It is weird to have a deprecated property listed in required list and
also in the example...

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

-- 
Dmitry
