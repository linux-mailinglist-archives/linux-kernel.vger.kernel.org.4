Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4976A6598
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCACfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjCACfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:35:52 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF5233461;
        Tue, 28 Feb 2023 18:35:48 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-172334d5c8aso13016582fac.8;
        Tue, 28 Feb 2023 18:35:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HCs0ro9EYBR2I3UnNfDR6MpwodWBY3h5gknIhOPdA0=;
        b=qZN1tGUUoGvr+yAm/Bn7G2REmb6KC5cSX99hSN1NxJHkklVr7fz9BP1MRuGDFSXavm
         +W7eGehf+DgX+l2fYqzrsLBJg5IbgnGgKFX0b1VGAg8Ea+FF0fQPQP94xCNF1ILJ0B2W
         0xs0hbM9Bu13NWxWH/4NEVLJPecKZnCEcTSia4Iha9eWr/jgiTrFVfA8YpPo1END0FbX
         0EItWLor/94LVu5Gv3x00DAobhagA7yn/t6pk3GaEP7Fu3pdNe+km/KidPXUCoht/kgS
         0At9W1SWHfJFIqJ0EKCvvPKy6irhdeyWy30ZyVtWSpdiYX7PRRmR7kKqeMPiKrDhfHQn
         VnPg==
X-Gm-Message-State: AO0yUKWxozw5mTDzDOmir6gO9f+SkUmjJv8Roz+mR0WW6kGSZcagrU9P
        5GLRJNBmZ5xuMT3B71h9pA==
X-Google-Smtp-Source: AK7set8nP/UTbDa8KEEwMlWE+JB6ySRp6o/RgfhHGUQ5GGIedBsp6rErgnVAyW4CJgUQZ9zjVKtFIw==
X-Received: by 2002:a05:6870:2198:b0:172:968d:9356 with SMTP id l24-20020a056870219800b00172968d9356mr3434334oae.17.1677638147134;
        Tue, 28 Feb 2023 18:35:47 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k22-20020a056820017600b00517a7ac36c8sm4485484ood.24.2023.02.28.18.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 18:35:46 -0800 (PST)
Received: (nullmailer pid 247084 invoked by uid 1000);
        Wed, 01 Mar 2023 02:35:45 -0000
Date:   Tue, 28 Feb 2023 20:35:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 10/10] dt-bindings: Add documentation for rt5033 mfd,
 regulator and charger
Message-ID: <20230301023545.GA235322-robh@kernel.org>
References: <cover.1677620677.git.jahau@rocketmail.com>
 <a698f524106e0eb7db5cbd7e73e77ecd5ac8ad7f.1677620677.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a698f524106e0eb7db5cbd7e73e77ecd5ac8ad7f.1677620677.git.jahau@rocketmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 11:32:27PM +0100, Jakob Hauser wrote:
> Add device tree binding documentation for rt5033 multifunction device, voltage
> regulator and battery charger.
> 
> Cc: Beomho Seo <beomho.seo@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
>  .../bindings/mfd/richtek,rt5033.yaml          | 102 ++++++++++++++++++
>  .../power/supply/richtek,rt5033-charger.yaml  |  76 +++++++++++++
>  .../regulator/richtek,rt5033-regulator.yaml   |  45 ++++++++
>  3 files changed, 223 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
>  create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5033-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml b/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
> new file mode 100644
> index 000000000000..f1a58694c81e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/richtek,rt5033.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RT5033 Power Management Integrated Circuit
> +
> +maintainers:
> +  - Jakob Hauser <jahau@rocketmail.com>
> +
> +description: |

Don't need '|' unless you care about line endings.

> +  RT5033 is a multifunction device which includes battery charger, fuel gauge,
> +  flash LED current source, LDO and synchronous Buck converter for portable
> +  applications. It is interfaced to host controller using I2C interface. The
> +  battery fuel gauge uses a separate I2C bus.
> +
> +properties:
> +  compatible:
> +    const: richtek,rt5033
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  regulators:
> +    type: object
> +    $ref: /schemas/regulator/richtek,rt5033-regulator.yaml#
> +
> +  charger:
> +    type: object
> +    $ref: /schemas/power/supply/richtek,rt5033-charger.yaml#
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
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c@0 {

i2c {

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic@34 {
> +            compatible = "richtek,rt5033";
> +            reg = <0x34>;
> +
> +            interrupt-parent = <&msmgpio>;
> +            interrupts = <62 IRQ_TYPE_EDGE_FALLING>;
> +
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&pmic_int_default>;
> +
> +            regulators {
> +                safe_ldo_reg: SAFE_LDO {
> +                    regulator-name = "SAFE_LDO";
> +                    regulator-min-microvolt = <4900000>;
> +                    regulator-max-microvolt = <4900000>;
> +                    regulator-always-on;
> +                };
> +                ldo_reg: LDO {
> +                    regulator-name = "LDO";
> +                    regulator-min-microvolt = <2800000>;
> +                    regulator-max-microvolt = <2800000>;
> +                };
> +                buck_reg: BUCK {
> +                    regulator-name = "BUCK";
> +                    regulator-min-microvolt = <1200000>;
> +                    regulator-max-microvolt = <1200000>;
> +                };
> +            };
> +
> +            charger {
> +                compatible = "richtek,rt5033-charger";
> +                richtek,pre-uamp = <450000>;
> +                richtek,fast-uamp = <1000000>;
> +                richtek,eoc-uamp = <150000>;
> +                richtek,pre-threshold-uvolt = <3500000>;
> +                richtek,const-uvolt = <4350000>;
> +                extcon = <&muic>;
> +            };
> +        };
> +    };
> +
> +    i2c@1 {

This should be a separate example entry.

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        battery@35 {
> +            compatible = "richtek,rt5033-battery";
> +            reg = <0x35>;
> +            interrupt-parent = <&msmgpio>;
> +            interrupts = <121 IRQ_TYPE_EDGE_FALLING>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
> new file mode 100644
> index 000000000000..996c2932927d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/richtek,rt5033-charger.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RT5033 PIMC Battery Charger
> +
> +maintainers:
> +  - Jakob Hauser <jahau@rocketmail.com>
> +
> +description: |
> +  The battery charger of the multifunction device RT5033 has to be instantiated
> +  under sub-node named "charger" using the following format.
> +
> +properties:
> +  compatible:
> +    const: richtek,rt5033-charger
> +
> +  richtek,pre-uamp:

Use defined standard unit type suffixes.

> +    description: |
> +      Current of pre-charge mode. The pre-charge current levels are 350 mA to
> +      650 mA programmed by I2C per 100 mA.
> +    maxItems: 1
> +
> +  richtek,fast-uamp:
> +    description: |
> +      Current of fast-charge mode. The fast-charge current levels are 700 mA
> +      to 2000 mA programmed by I2C per 100 mA.
> +    maxItems: 1
> +
> +  richtek,eoc-uamp:
> +    description: |
> +      This property is end of charge current. Its level ranges from 150 mA to
> +      600 mA. Between 150 mA and 300 mA in 50 mA steps, between 300 mA and 600 mA
> +      in 100 mA steps.
> +    maxItems: 1
> +
> +  richtek,pre-threshold-uvolt:
> +    description: |
> +      Voltage of pre-charge mode. If the battery voltage is below the pre-charge
> +      threshold voltage, the charger is in pre-charge mode with pre-charge current.
> +      Its levels are 2.3 V to 3.8 V programmed by I2C per 0.1 V.
> +    maxItems: 1
> +
> +  richtek,const-uvolt:
> +    description: |
> +      Battery regulation voltage of constant voltage mode. This voltage levels from
> +      3.65 V to 4.4 V by I2C per 0.025 V.
> +    maxItems: 1
> +
> +  extcon:

This is deprecated. There's standard connector bindings now.

> +    description: |
> +      Phandle to the extcon device.
> +    maxItems: 1
> +
> +required:
> +  - richtek,pre-uamp
> +  - richtek,fast-uamp
> +  - richtek,eoc-uamp
> +  - richtek,pre-threshold-uvolt
> +  - richtek,const-uvolt
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    charger {
> +        compatible = "richtek,rt5033-charger";
> +        richtek,pre-uamp = <450000>;
> +        richtek,fast-uamp = <1000000>;
> +        richtek,eoc-uamp = <150000>;
> +        richtek,pre-threshold-uvolt = <3500000>;
> +        richtek,const-uvolt = <4350000>;
> +        extcon = <&muic>;
> +    };
> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5033-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5033-regulator.yaml
> new file mode 100644
> index 000000000000..61b074488db4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/richtek,rt5033-regulator.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/richtek,rt5033-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RT5033 PIMC Voltage Regulator
> +
> +maintainers:
> +  - Jakob Hauser <jahau@rocketmail.com>
> +
> +description: |
> +  The regulators of RT5033 have to be instantiated under a sub-node named
> +  "regulators". For SAFE_LDO voltage there is only one value of 4.9 V. LDO
> +  voltage ranges from 1.2 V to 3.0 V in 0.1 V steps. BUCK voltage ranges from
> +  1.0 V to 3.0 V in 0.1 V steps.
> +
> +patternProperties:
> +  "^(SAFE_LDO|LDO|BUCK)$":

Lowercase preferred for node names.

> +    type: object
> +    $ref: /schemas/regulator/regulator.yaml#
> +    unevaluatedProperties: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    regulators {

Just 1 complete example in the MFD binding please.

> +        safe_ldo_reg: SAFE_LDO {
> +            regulator-name = "SAFE_LDO";
> +            regulator-min-microvolt = <4900000>;
> +            regulator-max-microvolt = <4900000>;
> +            regulator-always-on;
> +        };
> +        ldo_reg: LDO {
> +            regulator-name = "LDO";
> +            regulator-min-microvolt = <2800000>;
> +            regulator-max-microvolt = <2800000>;
> +        };
> +        buck_reg: BUCK {
> +            regulator-name = "BUCK";
> +            regulator-min-microvolt = <1200000>;
> +            regulator-max-microvolt = <1200000>;
> +        };
> +     };
> -- 
> 2.39.1
> 
