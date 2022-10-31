Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD45B613E80
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiJaTnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJaTnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:43:41 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C5C65CA;
        Mon, 31 Oct 2022 12:43:39 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29VJhZiZ066105;
        Mon, 31 Oct 2022 14:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667245415;
        bh=E4/XqI68hgTr9u4QRp9FIQLVyYZxnimzcjygXJlxaZ0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Jtn+Hyt43uQGBnh7W7ptGwv2SVajDd74sG7K1V4trvRWA/yU+iJZTL25PqWvie0Gf
         CaZxT7y8UE2FgouOotyfnnQF+Up2B0JjMqgpKYLpzGSKV/PiCzaQh6GPyLbj6u2c7x
         CXLAVTcZC3rHOVSaaedwyliaOslsEdakB5+/0U7E=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29VJhZJU030466
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Oct 2022 14:43:35 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 31
 Oct 2022 14:43:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 31 Oct 2022 14:43:34 -0500
Received: from [10.250.35.234] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29VJhYSE121609;
        Mon, 31 Oct 2022 14:43:34 -0500
Message-ID: <7bbea2c1-f67d-c03e-1191-e2fd73832be1@ti.com>
Date:   Mon, 31 Oct 2022 14:43:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] dt-bindings: input: Convert ti,drv260x to DT schema
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, <linux-input@vger.kernel.org>
CC:     <phone-devel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221031164141.919134-1-luca@z3ntu.xyz>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20221031164141.919134-1-luca@z3ntu.xyz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/22 11:41 AM, Luca Weiss wrote:
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

Sure, I can take them,

Acked-by: Andrew Davis <afd@ti.com>

> Changes since v1:
> * add $ref to types as suggested by Rob
> * change maintainer
> 
>   .../devicetree/bindings/input/ti,drv260x.txt  |  50 ---------
>   .../devicetree/bindings/input/ti,drv260x.yaml | 102 ++++++++++++++++++
>   2 files changed, 102 insertions(+), 50 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/input/ti,drv260x.txt
>   create mode 100644 Documentation/devicetree/bindings/input/ti,drv260x.yaml
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
> +
> +  vib-rated-mv:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      The rated voltage of the actuator in millivolts.
> +      If this is not set then the value will be defaulted to 3200 mV.
> +
> +  vib-overdrive-mv:
> +    $ref: /schemas/types.yaml#/definitions/uint32
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
