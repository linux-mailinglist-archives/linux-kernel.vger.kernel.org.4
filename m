Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A5A6C1ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCTQFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjCTQE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:04:59 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D8220565;
        Mon, 20 Mar 2023 08:54:24 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id v2-20020a056830090200b0069c6952f4d3so6972673ott.7;
        Mon, 20 Mar 2023 08:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679327636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmajzwKQ27IaG+SvB6h9L8PkvI+NSZehwwVkiXfw6Wc=;
        b=bEGmuIftgySM4Q4748/zTvhW/v2pxfJ8d7XQzgi6lKK+LDKE6iO4prfIlYf+Z8qvY4
         n+Zt0CtNhD5d29/tkkF5Q6EJla3Ee7/9GOBfRu6RY8F5wO/nb3W6QDxglbXIkvHDZfeT
         DyRhEOKM+tGztPjWBA4LlSAg01NiNo1iro/f3j7fxrpU7KuKovGtG0ldQ1aqS6SxAaia
         L6wt2vyAE/RRjn6dXl8z/sdYh35kcikdhSUvTvLVD+loc9mMlCwMb91EyW7LnjDuigNX
         Yde4Pv6X5vs1SzWodCu68GnzjkWNATp+vncNaobMEcGrQ3OLDMJn6FOgZ2ivdTRyPVWr
         IdRA==
X-Gm-Message-State: AO0yUKUixQ40r5273iEQla6W1h4U3viWHBr5JmVahmCa/5LHFFcsASam
        XNNKBTKKrwp2VIpkoC8u9phljM3bZg==
X-Google-Smtp-Source: AK7set90CdO59qXJ4IlzGk/4w+mlZuMP0bJSIPTWgVPYG3JnCmqE0fVwWUIagAi1YZdBFoDt6NDoEA==
X-Received: by 2002:a9d:65cd:0:b0:69f:1c2c:8f8c with SMTP id z13-20020a9d65cd000000b0069f1c2c8f8cmr208362oth.25.1679327635832;
        Mon, 20 Mar 2023 08:53:55 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g1-20020a4ab041000000b00529cc3986c8sm3871829oon.40.2023.03.20.08.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 08:53:55 -0700 (PDT)
Received: (nullmailer pid 1754258 invoked by uid 1000);
        Mon, 20 Mar 2023 15:53:54 -0000
Date:   Mon, 20 Mar 2023 10:53:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     lee@kernel.org, krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com,
        eric.auger@redhat.com, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, davem@davemloft.net,
        christian.koenig@amd.com, contact@emersion.fr,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, sterzik@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, jneanne@baylibre.com
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: Add TI TPS6594 PMIC
Message-ID: <20230320155354.GB1733616-robh@kernel.org>
References: <20230315110736.35506-1-jpanis@baylibre.com>
 <20230315110736.35506-2-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315110736.35506-2-jpanis@baylibre.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 12:07:33PM +0100, Julien Panis wrote:
> TPS6594 is a Power Management IC which provides regulators and others
> features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
> PFSM (Pre-configurable Finite State Machine) managing the state of the
> device.
> TPS6594 is the super-set device while TPS6593 and LP8764X are derivatives.

As mentioned, the binding needs to be complete. It's missing GPIO at 
least. RTC and watchdog may or may not need binding changes.

> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---
>  .../devicetree/bindings/mfd/ti,tps6594.yaml   | 191 ++++++++++++++++++
>  1 file changed, 191 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
> new file mode 100644
> index 000000000000..18f47cd6a2f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
> @@ -0,0 +1,191 @@
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
> +description: |

Don't need '|'.

> +  TPS6594 is a Power Management IC which provides regulators and others
> +  features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
> +  PFSM (Pre-configurable Finite State Machine) managing the state of the device.
> +  TPS6594 is the super-set device while TPS6593 and LP8764X are derivatives.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,lp8764x
> +      - ti,tps6593
> +      - ti,tps6594
> +
> +  reg:
> +    description: I2C slave address or SPI chip select number.
> +    maxItems: 1
> +
> +  ti,spmi-controller:
> +    type: boolean
> +    description: |
> +      Identify the primary PMIC on SPMI bus.

Perhaps the property name should include 'primary' and 'pmic'. 
Otherwise, it looks like it is just marked as 'a SPMI controller'.


> +      A multi-PMIC synchronization scheme is implemented in the PMIC device
> +      to synchronize the power state changes with other PMIC devices. This is
> +      accomplished through a SPMI bus: the primary PMIC is the controller
> +      device on the SPMI bus, and the secondary PMICs are the target devices
> +      on the SPMI bus.

Is this a TI specific feature?

> +
> +  system-power-controller: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ti,multi-phase-id:
> +    description: |
> +      Describes buck multi-phase configuration, if any. For instance, XY id means
> +      that outputs of buck converters X and Y are combined in multi-phase mode.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [12, 34, 123, 1234]

coupled regulator stuff doesn't work here?

> +
> +  regulators:
> +    type: object
> +    description: List of regulators provided by this controller.
> +
> +    patternProperties:
> +      "^buck([1-5]|12|34|123|1234)$":
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
> +            ti,spmi-controller;
> +            system-power-controller;
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
> +        };
> +    };
> -- 
> 2.37.3
> 
