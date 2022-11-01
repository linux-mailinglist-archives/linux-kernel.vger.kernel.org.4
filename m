Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853D0614AA5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 13:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiKAM2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 08:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiKAM21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 08:28:27 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7662B88;
        Tue,  1 Nov 2022 05:28:23 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-13bd2aea61bso16663450fac.0;
        Tue, 01 Nov 2022 05:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BXaX2PuvODMt+hQIE2C5R9rDaS5s+S5reta3LCFrno=;
        b=R5g/JvHBZbIY3Xsre005kbPvZ4bDc8O0Kr3B8VYs1dBkSmKkNKS2qwro3RV5qiT7YU
         0M7eZ/OhdwVjZQZo4AH8+zcvmD3JgmNVk5O2hWAQhOxuW+3EF0/5I1c9LixUNTGONdJ5
         K5Td0T+XFloFEN02Arh9JFD+V8bEcbjqMtFJXWPqWB+5UerSN1YjHqsxrPz6+2iBOvCH
         wk/rfPGTTunOy8OdS+RqgnXCXgn3JH3uxWTjGVwoHdWEyLxijMTNTkMag32mo+5BCGr7
         lkLHpfgHyIuHcC0YPk8zD2BStd1kHbDdy/VD1iVp1sGFdCN5/5hdfOZ+65JsKHONgGKR
         1yMA==
X-Gm-Message-State: ACrzQf0ybKRJ8B4XFjqoM15c78i+qAL/vQh9TwY7B5x7g577GtoOOhiy
        Nus6vyf+n9bYabO1Ul6IWCXSJMF0mg==
X-Google-Smtp-Source: AMsMyM5DMSdeSNMIKv56E9KmRtmo51l9n+/wZyFog5A10Qux5W50lZDW+zEkkywMNFO2Q6AxM7w/VQ==
X-Received: by 2002:a05:6870:b4a4:b0:13b:bc46:287e with SMTP id y36-20020a056870b4a400b0013bbc46287emr20527674oap.161.1667305702973;
        Tue, 01 Nov 2022 05:28:22 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a13-20020a4ad5cd000000b0049427725e62sm3325649oot.19.2022.11.01.05.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 05:28:22 -0700 (PDT)
Received: (nullmailer pid 946940 invoked by uid 1000);
        Tue, 01 Nov 2022 12:28:24 -0000
Date:   Tue, 1 Nov 2022 07:28:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>
Cc:     kernel@pengutronix.de, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add TI LMP92064 controller
Message-ID: <20221101122824.GA944982-robh@kernel.org>
References: <20221101064804.720050-1-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221101064804.720050-1-l.goehrs@pengutronix.de>
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

On Tue, Nov 01, 2022 at 07:48:03AM +0100, Leonard Göhrs wrote:
> Add binding documentation for the TI LMP92064 dual channel SPI ADC.
> 
> Changes from v1 -> v2:
> 
>  - Rename the "shunt-resistor" devicetree property to
>    "shunt-resistor-micro-ohms".
>  - Add supply regulator support for the two voltage domains of the chip
>    (vdd and vdig).
>  - Add reference to spi-peripheral-props.yaml
> 
> Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
> ---
>  .../bindings/iio/adc/ti,lmp92064.yaml         | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,lmp92064.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,lmp92064.yaml b/Documentation/devicetree/bindings/iio/adc/ti,lmp92064.yaml
> new file mode 100644
> index 000000000000..357b15ebd897
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,lmp92064.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,lmp92064.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments LMP92064 Precision Current and Voltage Sensor.
> +
> +maintainers:
> +  - Leonard Göhrs <l.goehrs@pengutronix.de>
> +
> +description: |
> +  The LMP92064 is a two channel ADC intended for combined voltage and current
> +  measurements.
> +
> +  The device contains two ADCs to allow simultaneous sampling of voltage and
> +  current and thus of instantaneous power consumption.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,lmp92064
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator that provides power to the main part of the chip
> +
> +  vdig-supply:
> +    description: |
> +      Regulator that provides power to the digital I/O part of the chip
> +
> +  shunt-resistor-micro-ohms:
> +    description: |
> +      Value of the shunt resistor (in µΩ) connected between INCP and INCN,
> +      across which current is measured. Used to provide correct scaling of the
> +      raw ADC measurement.
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - shunt-resistor-micro-ohms
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +additionalProperties: false

This should be unevaluatedProperties instead.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "ti,lmp92064";
> +            reg = <0>;
> +            vdd-supply = <&vdd>;
> +            vdig-supply = <&vdd>;
> +            spi-max-frequency = <20000000>;
> +            shunt-resistor-micro-ohms = <15000>;
> +            reset-gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
> +        };
> +    };
> +...
> -- 
> 2.30.2
> 
> 
