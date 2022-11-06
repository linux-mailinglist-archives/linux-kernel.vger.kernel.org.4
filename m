Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADF661E171
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 10:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiKFJzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 04:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiKFJzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 04:55:17 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C203E091
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 01:55:14 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id r12so13085034lfp.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 01:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A9sIxIGzU5bgnadsIgrhBoIgiTY/hqhQgTZw5mkHZJI=;
        b=DNOD5yKVJhw1GynCN/4byM7C6Axn/+cf7SSbLN25uceX73SVMRXfaegFGN0uo7ahkx
         KalDh9s3jTAEsD/ES7FRMEe1UWBF9VRgjilG17HVEv3dsNfXza5whCKrXuDkjeKuJ2Bb
         tfrNrGiPAiPfH8EcC7QGzHJ42U+buC8b5lXRegnwXk9iH/GvBuxDcvGmeqNI4bKlad6u
         rWEoN6Dy16RzpTEe8mxaORDaj8WcNezaNh7Wg+NkikafPbPzFjUOU5f2tDnx1v30gWi2
         3/7VV1EQ5c09JIqkJaaPhCfJJ0MZhi09yjSvy/Z63UcHjnyG6bKtyHuFZQ0p+8ZWOsQz
         YsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9sIxIGzU5bgnadsIgrhBoIgiTY/hqhQgTZw5mkHZJI=;
        b=ujpguATvqx4jNII4++hrdwDIel4bNe8DxMQvWGc0+comJ7Jkh8deMeZjs378wmljR2
         EJVXKyW6qk6wmddOaduTDfH/RA0ESyzALfjm4esiOv27JlUqcUS9VgviadZUXyPASbHN
         sIu9QuFzA/atdk6JukOWgTdhixSa2GqkaAhNx6bFZH0Ay8iLl40GJB+pBCEQSwl4/wKL
         Fqb8tU+TUoRViqOMJ2zKNHe3oGQiKxKATAiATLwnPTDdfq701QBxErRzhMYnSucbDyYc
         bFWpyI1dTeY9Kvwqtj6MBciP0TOs6Acr8WDZuzsil4xlSCxK7Uhw/APRqyxjkiisaJn2
         sCPg==
X-Gm-Message-State: ACrzQf0DhJpieCcDevbqM6VEbt2rYjqb4IHk8dCByR78L0bdFHSQZ4UC
        hpDR3aP6zlRftISoCz8Mk5V/LA==
X-Google-Smtp-Source: AMsMyM5yi/EJLzBDmPs0Q3Gqa0smgTFukUbGe9Aes6+eMDpj4xEs3cyH2b9aYuyTNzb7r/TdAhfNCw==
X-Received: by 2002:a05:6512:22d3:b0:4a2:3b96:e980 with SMTP id g19-20020a05651222d300b004a23b96e980mr18205540lfu.352.1667728512874;
        Sun, 06 Nov 2022 01:55:12 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id i8-20020a2ea368000000b002770566d642sm615620ljn.17.2022.11.06.01.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 01:55:12 -0800 (PST)
Message-ID: <02c45ae9-61a4-9fc5-4daf-8c4c9df9a4a0@linaro.org>
Date:   Sun, 6 Nov 2022 10:55:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] dt-bindings: Convert active-semi PMIC docs to YAML
 schemas
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        list@opendingux.net
References: <20221105225803.39197-1-paul@crapouillou.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221105225803.39197-1-paul@crapouillou.net>
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

On 05/11/2022 23:58, Paul Cercueil wrote:
> Create YAML bindings for the Active-semi PMICs and remove the old text
> files.
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
> ---
> 
> Notes:
>     v2:
>     - Avoid | character in descriptions that can be single-line
>     - Remove unevaluatedProperties when additionalProperties is also present
>     - Remove useless inner parentheses in regular expressions
>     - Rename I2C nodes to just... i2c
>     - Remove node handles
>     
>     Note:
>     I set Liam Girdwood and Mark Brown as the maintainers by default, since
>     it doesn't appear that anybody is managing the Active-semi drivers, but
>     if anybody steps up I can update it.

It should not be Liam and Mark, but someone having/knowing this
particular hardware.

> 
>  .../bindings/regulator/act8865-regulator.txt  | 117 --------
>  .../bindings/regulator/act8945a-regulator.txt | 113 --------
>  .../regulator/active-semi,act8600.yaml        | 141 ++++++++++
>  .../regulator/active-semi,act8846.yaml        | 207 ++++++++++++++
>  .../regulator/active-semi,act8865.yaml        | 162 +++++++++++
>  .../regulator/active-semi,act8945a.yaml       | 261 ++++++++++++++++++
>  6 files changed, 771 insertions(+), 230 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/act8865-regulator.txt
>  delete mode 100644 Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/active-semi,act8600.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/active-semi,act8846.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/active-semi,act8865.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/active-semi,act8945a.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt b/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
> deleted file mode 100644
> index b9f58e480349..000000000000
> --- a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
> +++ /dev/null
> @@ -1,117 +0,0 @@
> -ACT88xx regulators
> --------------------
> -
> -Required properties:
> -- compatible: "active-semi,act8846" or "active-semi,act8865" or "active-semi,act8600"
> -- reg: I2C slave address
> -
> -Optional properties:
> -- system-power-controller: Telling whether or not this pmic is controlling
> -  the system power. See Documentation/devicetree/bindings/power/power-controller.txt .
> -- active-semi,vsel-high: Indicates the VSEL pin is high.
> -  If this property is missing, assume the VSEL pin is low(0).
> -
> -Optional input supply properties:
> -- for act8600:
> -  - vp1-supply: The input supply for DCDC_REG1
> -  - vp2-supply: The input supply for DCDC_REG2
> -  - vp3-supply: The input supply for DCDC_REG3
> -  - inl-supply: The input supply for LDO_REG5, LDO_REG6, LDO_REG7 and LDO_REG8
> -  SUDCDC_REG4, LDO_REG9 and LDO_REG10 do not have separate supplies.
> -- for act8846:
> -  - vp1-supply: The input supply for REG1
> -  - vp2-supply: The input supply for REG2
> -  - vp3-supply: The input supply for REG3
> -  - vp4-supply: The input supply for REG4
> -  - inl1-supply: The input supply for REG5, REG6 and REG7
> -  - inl2-supply: The input supply for REG8 and LDO_REG9
> -  - inl3-supply: The input supply for REG10, REG11 and REG12
> -- for act8865:
> -  - vp1-supply: The input supply for DCDC_REG1
> -  - vp2-supply: The input supply for DCDC_REG2
> -  - vp3-supply: The input supply for DCDC_REG3
> -  - inl45-supply: The input supply for LDO_REG1 and LDO_REG2
> -  - inl67-supply: The input supply for LDO_REG3 and LDO_REG4
> -
> -Any standard regulator properties can be used to configure the single regulator.
> -regulator-initial-mode, regulator-allowed-modes and regulator-mode could be specified
> -for act8865 using mode values from dt-bindings/regulator/active-semi,8865-regulator.h
> -file.
> -
> -The valid names for regulators are:
> -	- for act8846:
> -	REG1, REG2, REG3, REG4, REG5, REG6, REG7, REG8, REG9, REG10, REG11, REG12
> -	- for act8865:
> -	DCDC_REG1, DCDC_REG2, DCDC_REG3, LDO_REG1, LDO_REG2, LDO_REG3, LDO_REG4.
> -	- for act8600:
> -	DCDC_REG1, DCDC_REG2, DCDC_REG3, SUDCDC_REG4, LDO_REG5, LDO_REG6, LDO_REG7,
> -	LDO_REG8, LDO_REG9, LDO_REG10,
> -
> -Example:
> ---------
> -
> -#include <dt-bindings/regulator/active-semi,8865-regulator.h>
> -
> -		i2c1: i2c@f0018000 {
> -			pmic: act8865@5b {
> -				compatible = "active-semi,act8865";
> -				reg = <0x5b>;
> -				active-semi,vsel-high;
> -
> -				regulators {
> -					vcc_1v8_reg: DCDC_REG1 {
> -						regulator-name = "VCC_1V8";
> -						regulator-min-microvolt = <1800000>;
> -						regulator-max-microvolt = <1800000>;
> -						regulator-always-on;
> -					};
> -
> -					vcc_1v2_reg: DCDC_REG2 {
> -						regulator-name = "VCC_1V2";
> -						regulator-min-microvolt = <1100000>;
> -						regulator-max-microvolt = <1300000>;
> -						regulator-always-on;
> -
> -						regulator-allowed-modes = <ACT8865_REGULATOR_MODE_FIXED>,
> -									  <ACT8865_REGULATOR_MODE_LOWPOWER>;
> -						regulator-initial-mode = <ACT8865_REGULATOR_MODE_FIXED>;
> -
> -						regulator-state-mem {
> -							regulator-on-in-suspend;
> -							regulator-suspend-min-microvolt = <1150000>;
> -							regulator-suspend-max-microvolt = <1150000>;
> -							regulator-changeable-in-suspend;
> -							regulator-mode = <ACT8865_REGULATOR_MODE_LOWPOWER>;
> -						};
> -					};
> -
> -					vcc_3v3_reg: DCDC_REG3 {
> -						regulator-name = "VCC_3V3";
> -						regulator-min-microvolt = <3300000>;
> -						regulator-max-microvolt = <3300000>;
> -						regulator-always-on;
> -					};
> -
> -					vddana_reg: LDO_REG1 {
> -						regulator-name = "VDDANA";
> -						regulator-min-microvolt = <3300000>;
> -						regulator-max-microvolt = <3300000>;
> -						regulator-always-on;
> -
> -						regulator-allowed-modes = <ACT8865_REGULATOR_MODE_NORMAL>,
> -									  <ACT8865_REGULATOR_MODE_LOWPOWER>;
> -						regulator-initial-mode = <ACT8865_REGULATOR_MODE_NORMAL>;
> -
> -						regulator-state-mem {
> -							regulator-off-in-suspend;
> -						};
> -					};
> -
> -					vddfuse_reg: LDO_REG2 {
> -						regulator-name = "FUSE_2V5";
> -						regulator-min-microvolt = <2500000>;
> -						regulator-max-microvolt = <2500000>;
> -					};
> -				};
> -			};
> -		};
> diff --git a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
> deleted file mode 100644
> index 4017527619ab..000000000000
> --- a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
> +++ /dev/null
> @@ -1,113 +0,0 @@
> -Device-Tree bindings for regulators of Active-semi ACT8945A Multi-Function Device
> -
> -Required properties:
> - - compatible: "active-semi,act8945a", please refer to ../mfd/act8945a.txt.
> -
> -Optional properties:
> -- active-semi,vsel-high: Indicates if the VSEL pin is set to logic-high.
> -  If this property is missing, assume the VSEL pin is set to logic-low.
> -
> -Optional input supply properties:
> -  - vp1-supply: The input supply for REG_DCDC1
> -  - vp2-supply: The input supply for REG_DCDC2
> -  - vp3-supply: The input supply for REG_DCDC3
> -  - inl45-supply: The input supply for REG_LDO1 and REG_LDO2
> -  - inl67-supply: The input supply for REG_LDO3 and REG_LDO4
> -
> -Any standard regulator properties can be used to configure the single regulator.
> -regulator-initial-mode, regulator-allowed-modes and regulator-mode could be
> -specified using mode values from dt-bindings/regulator/active-semi,8945a-regulator.h
> -file.
> -
> -The valid names for regulators are:
> -	REG_DCDC1, REG_DCDC2, REG_DCDC3, REG_LDO1, REG_LDO2, REG_LDO3, REG_LDO4.
> -
> -Example:
> -
> -#include <dt-bindings/regulator/active-semi,8945a-regulator.h>
> -
> -	pmic@5b {
> -		compatible = "active-semi,act8945a";
> -		reg = <0x5b>;
> -
> -		active-semi,vsel-high;
> -
> -		regulators {
> -			vdd_1v35_reg: REG_DCDC1 {
> -				regulator-name = "VDD_1V35";
> -				regulator-min-microvolt = <1350000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-always-on;
> -
> -				regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
> -							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
> -				regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-min-microvolt=<1400000>;
> -					regulator-suspend-max-microvolt=<1400000>;
> -					regulator-changeable-in-suspend;
> -					regulator-mode=<ACT8945A_REGULATOR_MODE_LOWPOWER>;
> -				};
> -			};
> -
> -			vdd_1v2_reg: REG_DCDC2 {
> -				regulator-name = "VDD_1V2";
> -				regulator-min-microvolt = <1100000>;
> -				regulator-max-microvolt = <1300000>;
> -				regulator-always-on;
> -
> -				regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
> -							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
> -				regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_3v3_reg: REG_DCDC3 {
> -				regulator-name = "VDD_3V3";
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-always-on;
> -			};
> -
> -			vdd_fuse_reg: REG_LDO1 {
> -				regulator-name = "VDD_FUSE";
> -				regulator-min-microvolt = <2500000>;
> -				regulator-max-microvolt = <2500000>;
> -				regulator-always-on;
> -
> -				regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_NORMAL>,
> -							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
> -				regulator-initial-mode = <ACT8945A_REGULATOR_MODE_NORMAL>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_3v3_lp_reg: REG_LDO2 {
> -				regulator-name = "VDD_3V3_LP";
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-always-on;
> -			};
> -
> -			vdd_led_reg: REG_LDO3 {
> -				regulator-name = "VDD_LED";
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-always-on;
> -			};
> -
> -			vdd_sdhc_1v8_reg: REG_LDO4 {
> -				regulator-name = "VDD_SDHC_1V8";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -			};
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/regulator/active-semi,act8600.yaml b/Documentation/devicetree/bindings/regulator/active-semi,act8600.yaml
> new file mode 100644
> index 000000000000..ca0ac316dff2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/active-semi,act8600.yaml
> @@ -0,0 +1,141 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/active-semi,act8600.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Active-semi ACT8600 regulator
> +
> +maintainers:
> +  - Liam Girdwood <lgirdwood@gmail.com>
> +  - Mark Brown <broonie@kernel.org>
> +
> +properties:
> +  compatible:
> +    const: active-semi,act8600
> +
> +  reg:
> +    description: I2C address

Drop description, it's obvious. The same in other files.

> +    maxItems: 1
> +
> +  system-power-controller:
> +    description:
> +      Indicates that the ACT8600 is responsible for powering OFF
> +      the system.
> +    type: boolean
> +

(...)

> +examples:
> +  - |
> +    #include <dt-bindings/regulator/active-semi,8865-regulator.h>
> +
> +    i2c1 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pmic: act8865@5b {
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

Align it with previous <.

> +            regulator-initial-mode = <ACT8865_REGULATOR_MODE_NORMAL>;


(...)

> +
> +        charger {
> +          compatible = "active-semi,act8945a-charger";
> +          pinctrl-names = "default";
> +          pinctrl-0 = <&pinctrl_charger_chglev &pinctrl_charger_lbo &pinctrl_charger_irq>;
> +          interrupt-parent = <&pioA>;
> +          interrupts = <45 IRQ_TYPE_EDGE_RISING>;
> +
> +          active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;
> +          active-semi,lbo-gpios = <&pioA 72 GPIO_ACTIVE_LOW>;
> +          active-semi,input-voltage-threshold-microvolt = <6600>;
> +          active-semi,precondition-timeout = <40>;
> +          active-semi,total-timeout = <3>;
> +          status = "okay";

Drop status

> +        };
> +      };
> +    };

Best regards,
Krzysztof

