Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAE6629AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiKONq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiKONq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:46:26 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D44209B1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:46:25 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id s8so7342068lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iVWBDh2ESILH47IArWNXnpY9VbwBg6U8zn7yHMsyUzo=;
        b=uGUu0NJDpOuNSGlrvQR6PGvysE+8Y0TqlO6B5BSNh5Vg//TseHeAUUTZ3t4pNX0LGr
         Cs5CsALf5rSlwuLpVKmNoQAL71yC2LUaSpTEX+UllfKTncfrJ2Hh2J22u1gcCTN1vF0r
         U9LtmUWpOkjIISnUV9jxNEJKMqmu7Z+4TSAUgZnvQaTjHz0StT+B5ACs4oKYvlad0sN2
         XkDJ8Xcflxa59q1aftKR4CALKdB/JJGQD3e32XzR/eJrGqNRqHecM0YUVUWZnVYbHmdT
         u33HeoZvCNWIWAMwsmxpL5PDGk/pYP+XvpOl9yFXQkD4GCAT0zgbXEns7mTnVo5kqRQU
         meyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVWBDh2ESILH47IArWNXnpY9VbwBg6U8zn7yHMsyUzo=;
        b=D1vHw/ye3787EWnNPVVTIjL8q+INHOjvOZxIhG5f+lWD8Jwxu6+cxqa/94WADckmzK
         c0LEPfdVwlibf4d+e62BV30BGoehp7K3Fw/Hfr2SaHe93Msg9FSCNHZ8e0TZ3azHCTtS
         T5zsbUU1yv/ZgmBdlGtagN/M5NT1MrDDizbf5y0bUPnwtpycYMtluEg279MTGZBuEEH7
         L/V04ADzf7q3k0GXU+k5iDQja5GsdzSLwyIxWRUWr2iA9jKP1NHk2G7mzq3G1/Ip9TSF
         Fc+1K8+dndYzJVgNn0r1CFUCZP2PDjMjG+soM5X2FOm50A7JF8nf104ET/SQeSJlr4dk
         yGtA==
X-Gm-Message-State: ANoB5pmADmFWd0jZcPx7k4/WE6/wgfkiU1MnQfg4cuVU2EDc0v03oWwn
        /6En3VG4oDDn0128E+3XeCC3BQ==
X-Google-Smtp-Source: AA0mqf5F8qJ3Cj6P8s51T4MgO4sCnx0c/8riCXL/dp3sp7p845uTgzNI2vcXAhDiaa9kdTdmAdAxKQ==
X-Received: by 2002:a05:6512:794:b0:4b3:ac9d:9354 with SMTP id x20-20020a056512079400b004b3ac9d9354mr5410403lfr.85.1668519983370;
        Tue, 15 Nov 2022 05:46:23 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y20-20020ac24214000000b004b384ae61absm2214656lfh.198.2022.11.15.05.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 05:46:23 -0800 (PST)
Message-ID: <417bfdea-ed41-6468-ec16-f54480cfe2f6@linaro.org>
Date:   Tue, 15 Nov 2022 14:46:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] dt-bindings: spi: convert Freescale DSPI to dt-schema
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        linux-spi@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
References: <20221111224651.577729-1-vladimir.oltean@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111224651.577729-1-vladimir.oltean@nxp.com>
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

On 11/11/2022 23:46, Vladimir Oltean wrote:
> From: Kuldeep Singh <kuldeep.singh@nxp.com>
> 
> Convert the Freescale DSPI binding to DT schema format.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v1 (from more than 1 year ago) at:
> https://patchwork.kernel.org/project/spi-devel-general/patch/20210315121518.3710171-1-kuldeep.singh@nxp.com/
> 
>  .../fsl,spi-fsl-dspi-peripheral-props.yaml    |  28 +++++
>  .../bindings/spi/fsl,spi-fsl-dspi.yaml        | 118 ++++++++++++++++++
>  .../devicetree/bindings/spi/spi-fsl-dspi.txt  |  65 ----------
>  .../bindings/spi/spi-peripheral-props.yaml    |   1 +
>  MAINTAINERS                                   |   3 +-
>  5 files changed, 149 insertions(+), 66 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi-peripheral-props.yaml
>  create mode 100644 Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi-peripheral-props.yaml
> new file mode 100644
> index 000000000000..d15f77c040d1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi-peripheral-props.yaml
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/fsl,spi-fsl-dspi-peripheral-props.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Peripheral-specific properties for Freescale DSPI controller
> +
> +maintainers:
> +  - Vladimir Oltean <olteanv@gmail.com>
> +
> +description:
> +  See spi-peripheral-props.yaml for more info.
> +
> +properties:
> +  fsl,spi-cs-sck-delay:
> +    description:
> +      Delay in nanoseconds between activating chip select and the start of
> +      clock signal, at the start of a transfer.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  fsl,spi-sck-cs-delay:
> +    description:
> +      Delay in nanoseconds between stopping the clock signal and
> +      deactivating chip select, at the end of a transfer.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml
> new file mode 100644
> index 000000000000..8a790c0ed95f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml
> @@ -0,0 +1,118 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/fsl,spi-fsl-dspi.yaml#

Why second "fsl" in file name? It does not patch compatibles and
duplicates the vendor. We do not have compatibles "nxp,imx6-nxp".

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale DSPI Controller
> +
> +maintainers:
> +  - Vladimir Oltean <olteanv@gmail.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"

Drop quotes.

> +
> +properties:
> +  compatible:
> +    description:
> +      Some integrations can have a single compatible string containing their
> +      SoC name (LS1012A, LS1021A, ...). Others require their SoC compatible
> +      string, plus a fallback compatible string (either on LS1021A or on
> +      LS2085A).

Why? The fsl,ls1012a-dspi device is either compatible with
fsl,ls1021a-v1.0-dspi or not. It cannot be both - compatible and not
compatible.


> +    oneOf:
> +      - enum:
> +          - fsl,ls1012a-dspi
> +          - fsl,ls1021a-v1.0-dspi
> +          - fsl,ls1028a-dspi
> +          - fsl,ls2085a-dspi
> +          - fsl,lx2160a-dspi
> +          - fsl,vf610-dspi
> +      - items:
> +          - enum:
> +              - fsl,ls1012a-dspi
> +              - fsl,ls1028a-dspi
> +              - fsl,ls1043a-dspi
> +              - fsl,ls1046a-dspi
> +              - fsl,ls1088a-dspi
> +          - const: fsl,ls1021a-v1.0-dspi
> +      - items:
> +          - enum:
> +              - fsl,ls2080a-dspi
> +              - fsl,lx2160a-dspi
> +          - const: fsl,ls2085a-dspi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: dspi
> +
> +  dmas:
> +    maxItems: 2
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +
> +  spi-num-chipselects:

Would be nice to deprecated it in separate patches. There is num-cs
property.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Number of available native Chip Select signals
> +
> +  bus-num:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: SoC-specific identifier for the SPI controller
> +
> +  little-endian: true
> +  big-endian: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - spi-num-chipselects
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/fsl,qoriq-clockgen.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        spi@2100000 {
> +            compatible = "fsl,ls1028a-dspi", "fsl,ls1021a-v1.0-dspi";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            reg = <0x0 0x2100000 0x0 0x10000>;

reg by convention is a second property.

> +            interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +            clock-names = "dspi";
> +            clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(2)>;
> +            dmas = <&edma0 0 62>, <&edma0 0 60>;
> +            dma-names = "tx", "rx";
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&pinctrl_dspi0_1>;
> +            spi-num-chipselects = <4>;
> +            little-endian;
> +
> +            flash@0 {
> +                compatible = "jedec,spi-nor";
> +                spi-max-frequency = <10000000>;
> +                fsl,spi-cs-sck-delay = <100>;
> +                fsl,spi-sck-cs-delay = <100>;
> +                reg = <0>;

Ditto.

> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> deleted file mode 100644

(...)

> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index dca677f9e1b9..a475e757f8da 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -101,6 +101,7 @@ properties:
>  # The controller specific properties go here.
>  allOf:
>    - $ref: cdns,qspi-nor-peripheral-props.yaml#
> +  - $ref: fsl,spi-fsl-dspi-peripheral-props.yaml#
>    - $ref: samsung,spi-peripheral-props.yaml#
>    - $ref: nvidia,tegra210-quad-peripheral-props.yaml#
>  
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c242098a34f9..c75ae49c85b5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8160,7 +8160,8 @@ FREESCALE DSPI DRIVER
>  M:	Vladimir Oltean <olteanv@gmail.com>
>  L:	linux-spi@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> +F:	Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml

Instead: Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi*

Best regards,
Krzysztof

