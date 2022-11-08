Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C77620E60
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiKHLPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiKHLPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:15:19 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1759611C17
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:15:15 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id s24so20566761ljs.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 03:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P3ZLCmxWvOh6TEjZjrnrV0zDBY9aQOqVbQrPCQaVAEk=;
        b=WlHPlygiKtyT62slIvPbpfz+YDg3uwUYL7kuUpr0P4ikg+xjHYRdvsRpoOUFMUl/VR
         nNCxYLM/ia4qVZuLlr3QB76vsCqD7JhhbJYMBPjbnWpAlgzMj9fMGLvuS99I4Myqtl48
         AOBOIU2yFSAwSycSlW1K49U30XNmOudUQNtQn8YN4lVVXY5cvwzCoyR2vGBfzmpH9P2P
         mfmw9WqVyD0BQ1Ko2O+I45oVecEwoSIm7KP/7n3tvTy6r1f//lr8HPLCj7LO5K3ZbjH7
         vVvEFRiiSiLDHI9Gpc4FZVwIrZGSgGvPNuUZXqffZJMiL2SpsCasBtzLxvFL3DfvE0aL
         7h/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P3ZLCmxWvOh6TEjZjrnrV0zDBY9aQOqVbQrPCQaVAEk=;
        b=Wcr+V4HFEwvzMFKePqD7VCujrnKMZN9FV8glxL9N3QLz6deo54WbeQWoE7yn+7MhWz
         wWfQF7Taby2CBeI0gE0WNSpjGii5qgVD8jKkoXU/KOhV2A6xnWblPkr88WHtPwtyzcJC
         Yfq41sjgp+Ylgq2Kd8iKDZi4jA47kEft/ZtrDnwoyPYmJOybyKA4OA4scRts8CWQvCMU
         8SI9qseGsd0+xAKyFFzrXdgVJuisVekPI448XTYrNTnE4oUFqwpTOkhSzq6CWGHQqIAp
         Sq/URB7XDbsLlB5SWOaLF/0M8CItMuGLLE361jy8jbb5xYlwIvFmYWWEQDmfeDdMbZ8l
         m36Q==
X-Gm-Message-State: ACrzQf1WlNDvL/wfCtQ6Ko4fnEWpQUaod/LuMPoetRnZnsvW1dXlKME9
        BlGHKGSA89Ws6EO1pTX1bpMt1A==
X-Google-Smtp-Source: AMsMyM6C8QkOCZEfi1KXMfCOZLj5buP/8v1j6qCGkx9gYNA11mZiiiWjFjNA7/XWUJ6g/M4rGe+7OA==
X-Received: by 2002:a05:651c:1c4:b0:277:5059:8298 with SMTP id d4-20020a05651c01c400b0027750598298mr17627642ljn.325.1667906113246;
        Tue, 08 Nov 2022 03:15:13 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id f8-20020a2ea0c8000000b0025ebaef9570sm1698045ljm.40.2022.11.08.03.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 03:15:12 -0800 (PST)
Message-ID: <1166e892-d630-fcd4-6931-212081819493@linaro.org>
Date:   Tue, 8 Nov 2022 12:15:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] dt-bindings: input: Convert ti,drv260x to DT schema
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-input@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andrew Davis <afd@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221105141707.92652-1-luca@z3ntu.xyz>
 <Y2ldc33ByZB/T+kZ@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y2ldc33ByZB/T+kZ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2022 20:33, Dmitry Torokhov wrote:
> On Sat, Nov 05, 2022 at 03:17:06PM +0100, Luca Weiss wrote:
>> Convert the drv260x haptics binding to DT schema format.
>>
>> The only notable change from .txt format is that vbat-supply is not
>> actually required, so don't make it a required property.
>>
>> Acked-by: Andrew Davis <afd@ti.com>
>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>> ---
>> Changes since v2:
>> * add default values for vib-*-mv
>> * add note about 'mode' property
>> * add enable-gpios, deprecate enable-gpio
>>
>>  .../devicetree/bindings/input/ti,drv260x.txt  |  50 --------
>>  .../devicetree/bindings/input/ti,drv260x.yaml | 109 ++++++++++++++++++
>>  2 files changed, 109 insertions(+), 50 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/input/ti,drv260x.txt
>>  create mode 100644 Documentation/devicetree/bindings/input/ti,drv260x.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/input/ti,drv260x.txt b/Documentation/devicetree/bindings/input/ti,drv260x.txt
>> deleted file mode 100644
>> index 4c5312eaaa85..000000000000
>> --- a/Documentation/devicetree/bindings/input/ti,drv260x.txt
>> +++ /dev/null
>> @@ -1,50 +0,0 @@
>> -* Texas Instruments - drv260x Haptics driver family
>> -
>> -Required properties:
>> -	- compatible - One of:
>> -		"ti,drv2604" - DRV2604
>> -		"ti,drv2605" - DRV2605
>> -		"ti,drv2605l" - DRV2605L
>> -	- reg -  I2C slave address
>> -	- vbat-supply - Required supply regulator
>> -	- mode - Power up mode of the chip (defined in include/dt-bindings/input/ti-drv260x.h)
>> -		DRV260X_LRA_MODE - Linear Resonance Actuator mode (Piezoelectric)
>> -		DRV260X_LRA_NO_CAL_MODE - This is a LRA Mode but there is no calibration
>> -				sequence during init.  And the device is configured for real
>> -				time playback mode (RTP mode).
>> -		DRV260X_ERM_MODE - Eccentric Rotating Mass mode (Rotary vibrator)
>> -	- library-sel - These are ROM based waveforms pre-programmed into the IC.
>> -				This should be set to set the library to use at power up.
>> -				(defined in include/dt-bindings/input/ti-drv260x.h)
>> -		DRV260X_LIB_EMPTY - Do not use a pre-programmed library
>> -		DRV260X_ERM_LIB_A - Pre-programmed Library
>> -		DRV260X_ERM_LIB_B - Pre-programmed Library
>> -		DRV260X_ERM_LIB_C - Pre-programmed Library
>> -		DRV260X_ERM_LIB_D - Pre-programmed Library
>> -		DRV260X_ERM_LIB_E - Pre-programmed Library
>> -		DRV260X_ERM_LIB_F - Pre-programmed Library
>> -		DRV260X_LIB_LRA - Pre-programmed LRA Library
>> -
>> -Optional properties:
>> -	- enable-gpio - gpio pin to enable/disable the device.
>> -	- vib-rated-mv - The rated voltage of the actuator in millivolts.
>> -			  If this is not set then the value will be defaulted to
>> -			  3.2 v.
>> -	- vib-overdrive-mv - The overdrive voltage of the actuator in millivolts.
>> -			  If this is not set then the value will be defaulted to
>> -			  3.2 v.
>> -Example:
>> -
>> -haptics: haptics@5a {
>> -	compatible = "ti,drv2605l";
>> -	reg = <0x5a>;
>> -	vbat-supply = <&vbat>;
>> -	enable-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>> -	mode = <DRV260X_LRA_MODE>;
>> -	library-sel = <DRV260X_LIB_LRA>;
>> -	vib-rated-mv = <3200>;
>> -	vib-overdrive-mv = <3200>;
>> -}
>> -
>> -For more product information please see the link below:
>> -http://www.ti.com/product/drv2605
>> diff --git a/Documentation/devicetree/bindings/input/ti,drv260x.yaml b/Documentation/devicetree/bindings/input/ti,drv260x.yaml
>> new file mode 100644
>> index 000000000000..63230977043e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/ti,drv260x.yaml
>> @@ -0,0 +1,109 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/input/ti,drv260x.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments - drv260x Haptics driver family
>> +
>> +maintainers:
>> +  - Andrew Davis <afd@ti.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,drv2604
>> +      - ti,drv2605
>> +      - ti,drv2605l
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  vbat-supply:
>> +    description: Power supply to the haptic motor
>> +
>> +  # TODO: Deprecate 'mode' in favor of differently named property
>> +  mode:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Power up mode of the chip
>> +      (defined in include/dt-bindings/input/ti-drv260x.h)
>> +
>> +      DRV260X_LRA_MODE
>> +        Linear Resonance Actuator mode (Piezoelectric)
>> +
>> +      DRV260X_LRA_NO_CAL_MODE
>> +        This is a LRA Mode but there is no calibration sequence during init.
>> +        And the device is configured for real time playback mode (RTP mode).
>> +
>> +      DRV260X_ERM_MODE
>> +        Eccentric Rotating Mass mode (Rotary vibrator)
>> +    enum: [ 0, 1, 2 ]
>> +
>> +  library-sel:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      These are ROM based waveforms pre-programmed into the IC.
>> +      This should be set to set the library to use at power up.
>> +      (defined in include/dt-bindings/input/ti-drv260x.h)
>> +
>> +      DRV260X_LIB_EMPTY - Do not use a pre-programmed library
>> +      DRV260X_ERM_LIB_A - Pre-programmed Library
>> +      DRV260X_ERM_LIB_B - Pre-programmed Library
>> +      DRV260X_ERM_LIB_C - Pre-programmed Library
>> +      DRV260X_ERM_LIB_D - Pre-programmed Library
>> +      DRV260X_ERM_LIB_E - Pre-programmed Library
>> +      DRV260X_ERM_LIB_F - Pre-programmed Library
>> +      DRV260X_LIB_LRA - Pre-programmed LRA Library
>> +    enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
>> +
>> +  enable-gpio:
>> +    maxItems: 1
>> +    deprecated: true
>> +
>> +  enable-gpios:
>> +    maxItems: 1
>> +
>> +  vib-rated-mv:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      The rated voltage of the actuator in millivolts.
>> +      If this is not set then the value will be defaulted to 3200 mV.
>> +    default: 3200
>> +
>> +  vib-overdrive-mv:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      The overdrive voltage of the actuator in millivolts.
>> +      If this is not set then the value will be defaulted to 3200 mV.
>> +    default: 3200
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - enable-gpio
> 
> It is weird to have a deprecated property listed in required list and
> also in the example...

Yep, this should be fixed.

Best regards,
Krzysztof

