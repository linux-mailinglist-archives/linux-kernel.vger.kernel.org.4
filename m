Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443216CB77F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjC1Gvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjC1Gvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:51:49 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28051706
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:51:47 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h8so45409651ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679986306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P5ai3EYkM1htB+W2lgmdBChBKino/fBN7wu+IJkBf/M=;
        b=UdYFGK8Dsy6fjsiSr2VmZApUCTVc7n/Y7v34yCmBKrS1PLukfe7pGEgv7MhluBi/An
         G+UHnXkv6q60byOEn0pHRqbuXZZIx4pGDVsXSQ40BHM24Oc5/R0QIfuz9iwITKtBvARH
         bRNTH/DlAq6tg/JrHNdev5Zj9OheXfnOJH0o6HaRokVQC0fdTIC2tc6i2sbVBCvBQ574
         gKI7ByrO1j5fySExohKe9lliLWFFVUXTHpK7tXvxrgGA78EX6isva64UKOp3VOUZY0Rc
         7DleNtk8PA0A8ZVlhPC9h7yoytkZoXQ+nQbM5WRcT6LBhxlk7WymmI/y797PCxFOXSIl
         2RLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679986306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5ai3EYkM1htB+W2lgmdBChBKino/fBN7wu+IJkBf/M=;
        b=eDcISNuEWIuFtUnwxcT/iCYqnmAfEZAanv0NFnNWivKYADSRyC7UUInm0S44vUOxIn
         UxLvIRx7JknASJJBgs2ufgyujmdZ8PVRkqEk+kfITiZVUEX8M2E0BRR6ThdpnL1R9H0g
         VFc6iiEWprB52r5PfmCyR4N3BlveQybETneqchDsI0tFly/wUcEcBcymR0IejFCxK08h
         U/uM8WN40koSAU8qtmm/wPJrer1C9Z9kTLRc80jR+3O0hMf8jPv4RobSBv4TfLOde0vG
         Wu/yImEiSYaNkcHYAxMAY44hA0dTgzmKXryazMfQP4ZXVVhM9PawmCYsW24RLRfgVZob
         yMWg==
X-Gm-Message-State: AAQBX9cnwNx3z6EXJwEcPKduz98YDUofAenilIpe2cmkA4jA9DUOznpL
        g3vwI2U7GcYtJkn8V5E5GcM+jg==
X-Google-Smtp-Source: AKy350Zzo4VoLlBwYgn25E5+Q22AB3MpaPFtNJQGeySHsRKY+0thqa7kSW05eNBCmVcs1f1ALHSbOw==
X-Received: by 2002:a05:6402:1110:b0:500:50f6:dd33 with SMTP id u16-20020a056402111000b0050050f6dd33mr15366328edv.2.1679986306082;
        Mon, 27 Mar 2023 23:51:46 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9e92:dca6:241d:71b6? ([2a02:810d:15c0:828:9e92:dca6:241d:71b6])
        by smtp.gmail.com with ESMTPSA id y2-20020a50ce02000000b004c0057b478bsm15598870edi.34.2023.03.27.23.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 23:51:45 -0700 (PDT)
Message-ID: <a0c18c3a-4f9e-f491-582f-8d3ca56ec26f@linaro.org>
Date:   Tue, 28 Mar 2023 08:51:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: Add TI TPS6594 PMIC
Content-Language: en-US
To:     Julien Panis <jpanis@baylibre.com>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        corbet@lwn.net, arnd@arndb.de, gregkh@linuxfoundation.org,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com
Cc:     eric.auger@redhat.com, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, davem@davemloft.net,
        christian.koenig@amd.com, contact@emersion.fr,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, sterzik@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, jneanne@baylibre.com
References: <20230327154101.211732-1-jpanis@baylibre.com>
 <20230327154101.211732-2-jpanis@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230327154101.211732-2-jpanis@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 17:40, Julien Panis wrote:
> TPS6594 is a Power Management IC which provides regulators and others
> features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
> PFSM (Pre-configurable Finite State Machine) managing the state of the
> device.
> TPS6594 is the super-set device while TPS6593 and LP8764X are derivatives.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---
>  .../devicetree/bindings/mfd/ti,tps6594.yaml   | 231 ++++++++++++++++++
>  1 file changed, 231 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
> new file mode 100644
> index 000000000000..4498e6361b34
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
> @@ -0,0 +1,231 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ti,tps6594.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI TPS6594 Power Management Integrated Circuit
> +
> +maintainers:
> +  - Julien Panis <jpanis@baylibre.com>
> +
> +description:
> +  TPS6594 is a Power Management IC which provides regulators and others
> +  features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
> +  PFSM (Pre-configurable Finite State Machine) managing the state of the device.
> +  TPS6594 is the super-set device while TPS6593 and LP8764X are derivatives.

LP8764X? Compatible says LP8764.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,lp8764

It's confusing. If x was wildcard, didn't you remove part of model name?


> +      - ti,tps6593
> +      - ti,tps6594
> +
> +  reg:
> +    description: I2C slave address or SPI chip select number.
> +    maxItems: 1
> +
> +  ti,primary-pmic:
> +    type: boolean
> +    description: |
> +      Identify the primary PMIC on SPMI bus.
> +      A multi-PMIC synchronization scheme is implemented in the PMIC device
> +      to synchronize the power state changes with other PMIC devices. This is
> +      accomplished through a SPMI bus: the primary PMIC is the controller
> +      device on the SPMI bus, and the secondary PMICs are the target devices
> +      on the SPMI bus.
> +
> +  system-power-controller: true
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +    description: |
> +      The first cell is the pin number, the second cell is used to specify flags.
> +      See ../gpio/gpio.txt for more information.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ti,multi-phase-id:
> +    description: |
> +      Describes buck multi-phase configuration, if any. For instance, XY id means
> +      that outputs of buck converters X and Y are combined in multi-phase mode.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    oneOf:
> +      - items:
> +          - const: 12
> +      - items:
> +          - const: 34
> +      - items:
> +          - const: 12
> +          - const: 34
> +      - items:
> +          - const: 123
> +      - items:
> +          - const: 1234
> +
> +  regulators:
> +    type: object
> +    description: List of regulators provided by this controller.
> +
> +    patternProperties:
> +      "^buck([1-5]|12|34|123|1234)$":

Why do you need ti,multi-phase-id property at all? Having buck123
implies ti,multi-phase-id=123.

> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +
> +        unevaluatedProperties: false
> +
> +      "^ldo[1-4]$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +
> +        unevaluatedProperties: false
> +
> +    allOf:
> +      - if:
> +          required:
> +            - buck12
> +        then:
> +          properties:
> +            buck123: false
> +            buck1234: false
> +      - if:
> +          required:
> +            - buck123
> +        then:
> +          properties:
> +            buck34: false
> +      - if:
> +          required:
> +            - buck1234
> +        then:
> +          properties:
> +            buck34: false
> +
> +    additionalProperties: false
> +
> +  rtc:
> +    type: object
> +    description: RTC provided by this controller.
> +    $ref: /schemas/rtc/rtc.yaml#

I doubt that you can have here any RTC and any watchdog (below). This
should be specific binding instead. Or list of compatibles if you have 3
or more possible bindings.

Additionally, judging by your DTS you do not have any resources in rtc
and watchdog, so these should not be nodes by themself in such case.

> +
> +  watchdog:
> +    type: object
> +    description: Watchdog provided by this controller.
> +    $ref: /schemas/watchdog/watchdog.yaml#
> +
> +patternProperties:
> +  "^buck([1-5]|12|34|123|1234)-supply$":
> +    description: Input supply phandle for each buck.
> +
> +  "^ldo[1-4]-supply$":
> +    description: Input supply phandle for each ldo.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        tps6593: pmic@48 {
> +            compatible = "ti,tps6593";
> +            reg = <0x48>;
> +            ti,primary-pmic;
> +            system-power-controller;
> +
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&pmic_irq_pins_default>;
> +            interrupt-parent = <&mcu_gpio0>;
> +            interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
> +
> +            ti,multi-phase-id = <123>;
> +
> +            buck123-supply = <&vcc_3v3_sys>;
> +            buck4-supply = <&vcc_3v3_sys>;
> +            buck5-supply = <&vcc_3v3_sys>;
> +            ldo1-supply = <&vcc_3v3_sys>;
> +            ldo2-supply = <&vcc_3v3_sys>;
> +            ldo3-supply = <&buck5>;
> +            ldo4-supply = <&vcc_3v3_sys>;
> +
> +            regulators {
> +                buck123: buck123 {
> +                    regulator-name = "vcc_core";
> +                    regulator-min-microvolt = <750000>;
> +                    regulator-max-microvolt = <850000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                };
> +
> +                buck4: buck4 {
> +                    regulator-name = "vcc_1v1";
> +                    regulator-min-microvolt = <1100000>;
> +                    regulator-max-microvolt = <1100000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                };
> +
> +                buck5: buck5 {
> +                    regulator-name = "vcc_1v8_sys";
> +                    regulator-min-microvolt = <1800000>;
> +                    regulator-max-microvolt = <1800000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                };
> +
> +                ldo1: ldo1 {
> +                    regulator-name = "vddshv5_sdio";
> +                    regulator-min-microvolt = <3300000>;
> +                    regulator-max-microvolt = <3300000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                };
> +
> +                ldo2: ldo2 {
> +                    regulator-name = "vpp_1v8";
> +                    regulator-min-microvolt = <1800000>;
> +                    regulator-max-microvolt = <1800000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                };
> +
> +                ldo3: ldo3 {
> +                    regulator-name = "vcc_0v85";
> +                    regulator-min-microvolt = <850000>;
> +                    regulator-max-microvolt = <850000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                };
> +
> +                ldo4: ldo4 {
> +                    regulator-name = "vdda_1v8";
> +                    regulator-min-microvolt = <1800000>;
> +                    regulator-max-microvolt = <1800000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                };
> +            };
> +
> +            rtc: rtc {
> +                wakeup-source;

No. We do not create nodes for single property.


> +            };
> +
> +            watchdog: watchdog {
> +                timeout-sec = <10>;

Same problem.



Best regards,
Krzysztof

