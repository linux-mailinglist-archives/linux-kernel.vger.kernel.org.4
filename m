Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B5B614049
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiJaV7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJaV7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:59:19 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD59F140D3;
        Mon, 31 Oct 2022 14:59:18 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id c18-20020a056830349200b0066c47e192f0so2808968otu.12;
        Mon, 31 Oct 2022 14:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkdVTAXCDXe7ReBNTe2yFOz15PzoA3zLKrdNQ4Vf8OQ=;
        b=VOTnc/KpxNA3oihXYGjWYqt38TxwOndb0rjgvibAhcgOzoUtqo15Iivq7X3vaZIvzm
         2Rsj6S94ZgotnFfggOX7Xszn0IsFOh6lsaCh53TZKhcX72hWShnNR0qhTLFpoIThE00j
         3gSkf1wy+ouT09DM2raZ4Oy9JD1rLge1OAE+Lr0R8Vqy67u+LBwYbBSpXeZLqfCwqf6O
         8sdmzHXyiPgyeRyyyLS3QPctMjUtq8lsVr16JUGZDNkMS9glwkXqkGuMQcGsI/zCPODN
         aFpzcOXWJOkPcAlRFss6laRlaGYb4uvmjfHRTOdF8GWVMfwNjAyBMuOC6A/cYQ9ESh/U
         /Agw==
X-Gm-Message-State: ACrzQf0Qc3KjJgYfEP/ZRkH4ZFCT59PYsuG4IY4LkdBKPN65gD2hSjH4
        DOeZ/MMSDN8CrTzUz5fLGnjFAhFfNg==
X-Google-Smtp-Source: AMsMyM7qXfBVn5FY18GmBmJGMZzpxZwKJ+wQQytn1101W33+9AcVgfbtHwIXXJtpXfujb3b3Q1TBYA==
X-Received: by 2002:a05:6830:2786:b0:66c:349d:bb51 with SMTP id x6-20020a056830278600b0066c349dbb51mr7477938otu.292.1667253558042;
        Mon, 31 Oct 2022 14:59:18 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x5-20020a05683000c500b00662228a27d3sm3181986oto.57.2022.10.31.14.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 14:59:17 -0700 (PDT)
Received: (nullmailer pid 3637501 invoked by uid 1000);
        Mon, 31 Oct 2022 21:59:19 -0000
Date:   Mon, 31 Oct 2022 16:59:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: Convert active-semi PMIC docs to YAML
 schemas
Message-ID: <20221031215919.GA3622880-robh@kernel.org>
References: <20221030113715.12067-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221030113715.12067-1-paul@crapouillou.net>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 11:37:15AM +0000, Paul Cercueil wrote:
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
>  Note:
>  I set Liam Girdwood and Mark Brown as the maintainers by default, since
>  it doesn't appear that anybody is managing the Active-semi drivers, but
>  if anybody steps up I can update it.
> 
>  Cheers,
>  -Paul
> 
>  .../bindings/regulator/act8865-regulator.txt  | 117 --------
>  .../bindings/regulator/act8945a-regulator.txt | 113 --------
>  .../regulator/active-semi,act8600.yaml        | 143 ++++++++++
>  .../regulator/active-semi,act8846.yaml        | 209 ++++++++++++++
>  .../regulator/active-semi,act8865.yaml        | 162 +++++++++++
>  .../regulator/active-semi,act8945a.yaml       | 263 ++++++++++++++++++
>  6 files changed, 777 insertions(+), 230 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/act8865-regulator.txt
>  delete mode 100644 Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/active-semi,act8600.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/active-semi,act8846.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/active-semi,act8865.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/active-semi,act8945a.yaml

[...]

> diff --git a/Documentation/devicetree/bindings/regulator/active-semi,act8600.yaml b/Documentation/devicetree/bindings/regulator/active-semi,act8600.yaml
> new file mode 100644
> index 000000000000..bf8c5145939e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/active-semi,act8600.yaml
> @@ -0,0 +1,143 @@
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
> +    maxItems: 1
> +
> +  system-power-controller:
> +    description: |

Don't need '|'.

> +      Indicates that the ACT8600 is responsible for powering OFF
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

Don't need both this and additionalProperties. As additionalProperties 
is sufficient here, use it, but move it here. It's easier to read that 
way IMO.

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
> +      "^((SUDCDC_REG4)|(LDO_REG9)|(LDO_REG10))$":

You can drop the inner parenthesis.

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
> +    i2c3 {

i2c {

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      act8600: pmic@5a {

Drop unused labels.

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

Similar comments on the rest.

Rob
