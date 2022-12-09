Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA39647FD4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 10:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiLIJFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 04:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLIJFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 04:05:35 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149FF1114A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 01:05:33 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id n1so4278543ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 01:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GwKYNzfl5yFLwm9nwpZvx4YULd6KDhGtfJ+NUxuhGMU=;
        b=nBhdKrIfDXakNZMaJHCzZdl/Ow221uRkAKiaSI6z8L4GCBhhNKVqFgXB49oiKOPAZ8
         Hlx1jkYkKwdAjasbcErEEtg/3aIUET+KS7vMq8frb2GOAhgIyvrsDZGMJXqcbe0615yh
         6E0XWDy2//xYf62N9iMDtv4cI/L7GJczaAspMm+ITOfpXguTt8Kp+l5phWGAwecD+dmY
         gbh4MNaT8alRCx/fZRWhpM3hHHO5s4DoNkaJbsJCiOUWXHz/8S4BvnWv98H7LAKLViIp
         koG1hdu/4UXMDJbytVFSf4UTbaXs9udUakHVhFioJBIlWdBKUPicFZ5xdtX+dcPchl15
         p0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GwKYNzfl5yFLwm9nwpZvx4YULd6KDhGtfJ+NUxuhGMU=;
        b=SsWdn8Suu7sl2x7+k2gnJgV3qws4BJSQi4E2YadTcH8m1SRs5zGXJLg25jyKQg4TH+
         DcVc7vvrjKaW6JVFPbbYhH33JR9Y5bJyZL78wIadn+Lf9xX4G2bvQNEcaykvyDnr8uKz
         GJQAraGPDXSxUttTNHOsXtBlmHxvBn4UNFwSD9D3uhLToa1mfcI+wKyVUn0TRML4FPI3
         47PbtX/XNUYhO8Vl2Yqp6egpzovNoHeVzsJUtf560BD8ybu5HJ/djgSMPOZEPKQs0a1A
         LYqw+317pfdGmBLczCoxIKeOKRnzrI11dmfaM/Hw8nTUGrvLwmpZ+pBoizEfJWvzniWL
         k0Rw==
X-Gm-Message-State: ANoB5pmAZhx7g7VR4d4nm6qDzoz8u6F2lAL+Xh62S+uTeqOT98kakjBW
        EITmuyVZPpDJW2bMOq7ZRvRnXr/I+MOoqqL0xR8=
X-Google-Smtp-Source: AA0mqf5toIzHjXXoeCB9lUjXIf4MZ++61zq8TBuCjidiw/YP/i/RKQ5iKYll95gaRKMaPMClLfSgxQ==
X-Received: by 2002:a05:651c:1944:b0:26f:db34:a161 with SMTP id bs4-20020a05651c194400b0026fdb34a161mr1641848ljb.36.1670576731328;
        Fri, 09 Dec 2022 01:05:31 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bg37-20020a05651c0ba500b00279c85d4400sm137018ljb.60.2022.12.09.01.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 01:05:30 -0800 (PST)
Message-ID: <12c375c4-d7d0-7a7b-5688-2210491df8e6@linaro.org>
Date:   Fri, 9 Dec 2022 10:05:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3] dt-bindings: Convert active-semi PMIC docs to YAML
 schemas
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20221207201341.191682-1-paul@crapouillou.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221207201341.191682-1-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2022 21:13, Paul Cercueil wrote:
> Create YAML bindings for the Active-semi PMICs and remove the old text
> files.

Use subject prefixes matching the subsystem (git log --oneline -- ...),
so: regulator: dt-bindings: Convert active-semi PMIC to DT schema

> 
> The bindings aren't perfect, for instance I couldn't find good
> descriptions for the vendor properties in the "charger" node of the
> ACT8945A because I am not familiar with the hardware and these
> properties were not documented anywhere.
> 
> The YAML schemas are a bit different than what is described in the old
> text files, because these were sometimes wrong or had missing
> information. This is the case for the ACT8600 documentation, which
> specified the valid node names for the regulators, while the driver was
> expecting different names. This led to the current situation where we
> have two different boards using different names for the regulators:
> - arch/mips/boot/dts/ingenic/ci20.dts uses the names documented in the
>   text file,
> - arch/mips/boot/dts/ingenic/gcw0.dts uses the names that the driver
>   expects.
> In theory, the driver should be fixed to follow the documentation, and
> accept both naming schemes. In practice though, when the PMIC node was
> added to the ci20.dts board file, the names were already wrong in
> regards to what the driver expected, so it never really worked
> correctly and wasn't tested properly. Furthermore, in that board the
> consumers of the regulators aren't working for various other reasons
> (invalid GPIOs, etc.).
> 
> For that reason, for the ACT8600 bindings I decided to only use the node
> names that the driver expects (and that gcw0.dts uses), instead of
> accepting both old and new names. A follow-up patch will update the CI20
> board to use the new regulator names.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> 
> ---
> v2:
> - Avoid | character in descriptions that can be single-line
> - Remove unevaluatedProperties when additionalProperties is also present
> - Remove useless inner parentheses in regular expressions
> - Rename I2C nodes to just... i2c
> - Remove node handles
> 
> v3:
> - Fix alignment in examples
> - Drop useless status = "okay"; in examples
> - I set myself as the maintainer, which I only did because nobody else
>   seems to care.
> 
> Cheers,
> -Paul

(...)


> diff --git a/Documentation/devicetree/bindings/regulator/active-semi,act8600.yaml b/Documentation/devicetree/bindings/regulator/active-semi,act8600.yaml
> new file mode 100644
> index 000000000000..d8cc9cd527ef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/active-semi,act8600.yaml
> @@ -0,0 +1,140 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/active-semi,act8600.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Active-semi ACT8600 regulator
> +
> +maintainers:
> +  - Paul Cercueil <paul@crapouillou.net>
> +
> +properties:
> +  compatible:
> +    const: active-semi,act8600
> +
> +  reg:
> +    description: I2C address

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

> +    maxItems: 1
> +
> +  system-power-controller:
> +    description:
> +      Indicates that the ACT8600 is responsible for powering OFF
> +      the system.
> +    type: boolean
> +
> +  active-semi,vsel-high:
> +    description:
> +      Indicates the VSEL pin is high. If this property is missing,
> +      the VSEL pin is assumed to be low.
> +    type: boolean
> +
> +  regulators:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      DCDC1:
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          vp1-supply:
> +            description: Handle to the VP1 input supply
> +
> +      DCDC2:
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          vp2-supply:
> +            description: Handle to the VP2 input supply
> +
> +      DCDC3:
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          vp3-supply:
> +            description: Handle to the VP3 input supply
> +
> +    patternProperties:
> +      "^(SUDCDC_REG4|LDO_REG9|LDO_REG10)$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +      "^LDO[5-8]$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          inl-supply:
> +            description: Handle to the INL input supply
> +
> +additionalProperties: false
> +
> +required:
> +  - reg
> +  - compatible
> +  - regulators
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pmic@5a {
> +        compatible = "active-semi,act8600";
> +        reg = <0x5a>;
> +
> +        regulators {
> +          SUDCDC_REG4 {
> +            regulator-min-microvolt = <5300000>;
> +            regulator-max-microvolt = <5300000>;
> +            inl-supply = <&vcc>;
> +          };
> +
> +          LDO5 {
> +            regulator-min-microvolt = <2500000>;
> +            regulator-max-microvolt = <2500000>;
> +            inl-supply = <&vcc>;
> +          };
> +
> +          LDO6 {
> +            regulator-min-microvolt = <3300000>;
> +            regulator-max-microvolt = <3300000>;
> +            inl-supply = <&vcc>;
> +          };
> +
> +          LDO7 {
> +            regulator-min-microvolt = <3300000>;
> +            regulator-max-microvolt = <3300000>;
> +            inl-supply = <&vcc>;
> +          };
> +
> +          LDO8 {
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <1800000>;
> +            regulator-always-on;
> +            inl-supply = <&vcc>;
> +          };
> +
> +          LDO_REG9 {
> +            regulator-min-microvolt = <3300000>;
> +            regulator-max-microvolt = <3300000>;
> +            regulator-always-on;
> +            inl-supply = <&vcc>;
> +          };
> +
> +          LDO_REG10 {
> +            inl-supply = <&vcc>;
> +          };
> +        };
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/regulator/active-semi,act8846.yaml b/Documentation/devicetree/bindings/regulator/active-semi,act8846.yaml
> new file mode 100644
> index 000000000000..f276dec59b3d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/active-semi,act8846.yaml
> @@ -0,0 +1,206 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/active-semi,act8846.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Active-semi ACT8846 regulator
> +
> +maintainers:
> +  - Paul Cercueil <paul@crapouillou.net>
> +
> +properties:
> +  compatible:
> +    const: active-semi,act8846
> +
> +  reg:
> +    description: I2C address

Ditto

> +    maxItems: 1
> +
> +  system-power-controller:
> +    description:
> +      Indicates that the ACT8846 is responsible for powering OFF
> +      the system.
> +    type: boolean
> +
> +  active-semi,vsel-high:
> +    description:
> +      Indicates the VSEL pin is high. If this property is missing,
> +      the VSEL pin is assumed to be low.
> +    type: boolean
> +
> +  regulators:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      REG1:
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          vp1-supply:
> +            description: Handle to the VP1 input supply
> +
> +      REG2:
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          vp2-supply:
> +            description: Handle to the VP2 input supply
> +
> +      REG3:
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          vp3-supply:
> +            description: Handle to the VP3 input supply
> +
> +      REG4:
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          vp4-supply:
> +            description: Handle to the VP4 input supply
> +
> +    patternProperties:
> +      "^REG[5-7]$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          inl1-supply:
> +            description: Handle to the INL1 input supply
> +
> +      "^REG[8-9]$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          inl2-supply:
> +            description: Handle to the INL2 input supply
> +
> +      "^REG1[0-2]$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          inl3-supply:
> +            description: Handle to the INL3 input supply
> +
> +additionalProperties: false
> +
> +required:
> +  - reg
> +  - compatible
> +  - regulators
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pmic@5a {
> +        compatible = "active-semi,act8846";
> +        reg = <0x5a>;
> +
> +        system-power-controller;
> +
> +        regulators {
> +          REG1 {
> +            regulator-name = "VCC_DDR";
> +            regulator-min-microvolt = <1200000>;
> +            regulator-max-microvolt = <1200000>;
> +            regulator-always-on;
> +          };
> +
> +          REG2 {
> +            regulator-name = "VCC_IO";
> +            regulator-min-microvolt = <3300000>;
> +            regulator-max-microvolt = <3300000>;
> +            regulator-always-on;
> +          };
> +
> +          REG3 {
> +            regulator-name = "VDD_LOG";
> +            regulator-min-microvolt = <1000000>;
> +            regulator-max-microvolt = <1000000>;
> +            regulator-always-on;
> +          };
> +
> +          REG4 {
> +            regulator-name = "VCC_20";
> +            regulator-min-microvolt = <2000000>;
> +            regulator-max-microvolt = <2000000>;
> +            regulator-always-on;
> +          };
> +
> +          REG5 {
> +            regulator-name = "VCCIO_SD";
> +            regulator-min-microvolt = <3300000>;
> +            regulator-max-microvolt = <3300000>;
> +            regulator-always-on;
> +          };
> +
> +          REG6 {
> +            regulator-name = "VDD10_LCD";
> +            regulator-min-microvolt = <1000000>;
> +            regulator-max-microvolt = <1000000>;
> +            regulator-always-on;
> +          };
> +
> +          REG7 {
> +            regulator-name = "VCC_WL";
> +            regulator-min-microvolt = <3300000>;
> +            regulator-max-microvolt = <3300000>;
> +            regulator-always-on;
> +          };
> +
> +          REG8 {
> +            regulator-name = "VCCA_33";
> +            regulator-min-microvolt = <3300000>;
> +            regulator-max-microvolt = <3300000>;
> +            regulator-always-on;
> +          };
> +
> +          REG9 {
> +            regulator-name = "VCC_LAN";
> +            regulator-min-microvolt = <3300000>;
> +            regulator-max-microvolt = <3300000>;
> +            regulator-always-on;
> +          };
> +
> +          REG10 {
> +            regulator-name = "VDD_10";
> +            regulator-min-microvolt = <1000000>;
> +            regulator-max-microvolt = <1000000>;
> +            regulator-always-on;
> +          };
> +
> +          REG11 {
> +            regulator-name = "VCC_18";
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <1800000>;
> +            regulator-always-on;
> +          };
> +
> +          REG12 {
> +            regulator-name = "VCC18_LCD";
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <1800000>;
> +            regulator-always-on;
> +          };
> +        };
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/regulator/active-semi,act8865.yaml b/Documentation/devicetree/bindings/regulator/active-semi,act8865.yaml
> new file mode 100644
> index 000000000000..cf36ab7c82c4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/active-semi,act8865.yaml
> @@ -0,0 +1,162 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/active-semi,act8865.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Active-semi ACT8865 regulator
> +
> +maintainers:
> +  - Liam Girdwood <lgirdwood@gmail.com>
> +  - Mark Brown <broonie@kernel.org>
> +
> +properties:
> +  compatible:
> +    const: active-semi,act8865
> +
> +  reg:
> +    description: I2C address

ditto

> +    maxItems: 1
> +
> +  system-power-controller:
> +    description: |
> +      Indicates that the ACT8865 is responsible for powering OFF
> +      the system.
> +    type: boolean
> +
> +  active-semi,vsel-high:
> +    description: |
> +      Indicates the VSEL pin is high. If this property is missing,
> +      the VSEL pin is assumed to be low.
> +    type: boolean
> +
> +  regulators:
> +    type: object
> +    unevaluatedProperties: false
> +
> +    properties:
> +      DCDC_REG1:
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          vp1-supply:
> +            description: Handle to the VP1 input supply
> +
> +      DCDC_REG2:
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          vp2-supply:
> +            description: Handle to the VP2 input supply
> +
> +      DCDC_REG3:
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          vp3-supply:
> +            description: Handle to the VP3 input supply
> +
> +    patternProperties:
> +      "^LDO_REG[1-2]$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          inl45-supply:
> +            description: Handle to the INL45 input supply
> +
> +      "^LDO_REG[3-4]$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          inl67-supply:
> +            description: Handle to the INL67 input supply
> +
> +    additionalProperties: false
> +
> +additionalProperties: false
> +
> +required:
> +  - reg
> +  - compatible
> +  - regulators
> +
> +examples:
> +  - |
> +    #include <dt-bindings/regulator/active-semi,8865-regulator.h>
> +
> +    i2c1 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pmic: act8865@5b {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +        compatible = "active-semi,act8865";
> +        reg = <0x5b>;
> +        active-semi,vsel-high;
> +
> +        regulators {
> +          vcc_1v8_reg: DCDC_REG1 {
> +            regulator-name = "VCC_1V8";
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <1800000>;
> +            regulator-always-on;
> +          };
> +
> +          vcc_1v2_reg: DCDC_REG2 {
> +            regulator-name = "VCC_1V2";
> +            regulator-min-microvolt = <1100000>;
> +            regulator-max-microvolt = <1300000>;
> +            regulator-always-on;
> +
> +            regulator-allowed-modes = <ACT8865_REGULATOR_MODE_FIXED>,
> +                                      <ACT8865_REGULATOR_MODE_LOWPOWER>;
> +            regulator-initial-mode = <ACT8865_REGULATOR_MODE_FIXED>;
> +
> +            regulator-state-mem {
> +              regulator-on-in-suspend;
> +              regulator-suspend-min-microvolt = <1150000>;
> +              regulator-suspend-max-microvolt = <1150000>;
> +              regulator-changeable-in-suspend;
> +              regulator-mode = <ACT8865_REGULATOR_MODE_LOWPOWER>;
> +            };
> +          };
> +
> +          vcc_3v3_reg: DCDC_REG3 {
> +            regulator-name = "VCC_3V3";
> +            regulator-min-microvolt = <3300000>;
> +            regulator-max-microvolt = <3300000>;
> +            regulator-always-on;
> +          };
> +
> +          vddana_reg: LDO_REG1 {
> +            regulator-name = "VDDANA";
> +            regulator-min-microvolt = <3300000>;
> +            regulator-max-microvolt = <3300000>;
> +            regulator-always-on;
> +
> +            regulator-allowed-modes = <ACT8865_REGULATOR_MODE_NORMAL>,
> +            <ACT8865_REGULATOR_MODE_LOWPOWER>;
> +            regulator-initial-mode = <ACT8865_REGULATOR_MODE_NORMAL>;
> +
> +            regulator-state-mem {
> +              regulator-off-in-suspend;
> +            };
> +          };
> +
> +          vddfuse_reg: LDO_REG2 {
> +            regulator-name = "FUSE_2V5";
> +            regulator-min-microvolt = <2500000>;
> +            regulator-max-microvolt = <2500000>;
> +          };
> +        };
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/regulator/active-semi,act8945a.yaml b/Documentation/devicetree/bindings/regulator/active-semi,act8945a.yaml
> new file mode 100644
> index 000000000000..b8c0ba8247ef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/active-semi,act8945a.yaml
> @@ -0,0 +1,259 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/active-semi,act8945a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Active-semi ACT8945a regulator
> +
> +maintainers:
> +  - Paul Cercueil <paul@crapouillou.net>
> +
> +properties:
> +  compatible:
> +    const: active-semi,act8945a
> +
> +  reg:
> +    description: I2C address

ditto

> +    maxItems: 1
> +
> +  system-power-controller:
> +    description:
> +      Indicates that the ACT8945a is responsible for powering OFF
> +      the system.
> +    type: boolean
> +

Best regards,
Krzysztof

