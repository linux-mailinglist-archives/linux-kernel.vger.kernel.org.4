Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7EE608E66
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 18:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJVQTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 12:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJVQTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 12:19:04 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE5313589A
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:18:56 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1364357a691so7194489fac.7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=br+HnS22isyDTm0T0WKGrqcorfoSfii9AXXj0ko/jkg=;
        b=GnRU0N9fVf/mVBhAHbuyEOC9wrQXeKfjaaUP1h6IBql8j3JnQHljnf3W9QeKGRXEGX
         iRMbsdsEp5DAFJpsdvVKayYxlT2jICNcluDcr1k05EoFzayaIcmQ8efe+Le0mWqxzDbF
         0pm3g3n55Q5V/4RBcXb7L9pCSGeONWOuIlY0+Dq73CUKFCbkLde5t2Iq4zBQXE+JNrue
         IBZjvA5W3twyqCQ7XNS3MzqBL5aU/zXX+vMtGjuwDpnF+V3hqgIcPb9YocxQ4QNFzvsY
         rn4O+DqilHeDAmZwCzwEtPtGuDZq+tBw/KeJmE2SBWUXhjzlZf9VraIizGYlvAqJBnxo
         Gijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=br+HnS22isyDTm0T0WKGrqcorfoSfii9AXXj0ko/jkg=;
        b=Qt70zFEJWaC5kuLD0wNCeOWXmGV3FWyMnEYl0kSuioBTSlViKfj+bGq3d4LzkrxrgX
         BKBZPUfQahFvWm36fEKVMpNwsmTuAjxrgpooh2gss5sTDelP00IkVuwKC+nqYjGEmfbf
         LGEw8e9VCk60WqzCxNBE+UQkYy/JEbu2VbC019Gq5ygMsfivrzpRlKnGn4nRr1r2bVY9
         pv+3DtKhSgZzJM3Zc7oJToQn7d+vJ55rcY4VDBi+nFgeix8+SBHt8EewmEiUEWEHwPDZ
         1GXgzMugKT+ua0vBtLLc2zKisaXaL13zNjJuSNaerpHMo/bBM3GjBxJz21wMOrSVvCCo
         i2YQ==
X-Gm-Message-State: ACrzQf1Ngg1w/GlkJIYyJHvNqqfpudKwbS6IDmpAGAdxbuXFfzrTh1Ei
        MqXbSVbxLK5gFx8Mj/bQ0dlq7w==
X-Google-Smtp-Source: AMsMyM5LBTbSQmhRB3iN1nczIfrXMxrWAUYJE4+PUysGP/rfOMrysmsCkNiSRND3aYiduPG3kahmMA==
X-Received: by 2002:a05:6870:d107:b0:137:11e5:6a95 with SMTP id e7-20020a056870d10700b0013711e56a95mr16305190oac.146.1666455535738;
        Sat, 22 Oct 2022 09:18:55 -0700 (PDT)
Received: from [10.203.8.70] ([205.153.95.177])
        by smtp.gmail.com with ESMTPSA id d6-20020aca3606000000b0034d14c6ce3dsm2293236oia.16.2022.10.22.09.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 09:18:54 -0700 (PDT)
Message-ID: <a46c6a18-903d-2120-4876-509ce8ad19d5@linaro.org>
Date:   Sat, 22 Oct 2022 12:18:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
Content-Language: en-US
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Elad Nachman <enachman@marvell.com>
References: <20221021194552.683-1-vadym.kochan@plvision.eu>
 <20221021194552.683-2-vadym.kochan@plvision.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021194552.683-2-vadym.kochan@plvision.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 15:45, Vadym Kochan wrote:
> Switch the DT binding to a YAML schema to enable the DT validation.
> 
> Dropped deprecated compatibles and properties described in txt file.
> 
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
>  .../bindings/mtd/marvell,nand-controller.yaml | 199 ++++++++++++++++++
>  .../devicetree/bindings/mtd/marvell-nand.txt  | 126 -----------
>  2 files changed, 199 insertions(+), 126 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> new file mode 100644
> index 000000000000..535b7f8903c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> @@ -0,0 +1,199 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/marvell,nand-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell NAND Flash Controller (NFC)
> +
> +maintainers:
> +  - Miquel Raynal <miquel.raynal@bootlin.com>

This should be someone responsible for hardware, not subsystem
maintainer. Unless by coincidence Miquel matches both. :)

> +
> +properties:
> +
> +  compatible:
> +    oneOf:
> +      - items:
> +        - const: marvell,armada-8k-nand-controller
> +        - const: marvell,armada370-nand-controller

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> +      - const: marvell,armada370-nand-controller
> +      - const: marvell,pxa3xx-nand-controller

These two are just enum.

> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1

Drop, comes with nand-controller.yaml

> +
> +  "#size-cells":
> +    const: 0

Ditto

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +    description: |

No need for |

> +     Shall reference the NAND controller clocks, the second one is
> +     is only needed for the Armada 7K/8K SoCs

You need allOf:if:then restricting it further per variant.

> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: reg
> +    description: |
> +      Mandatory if there is a second clock, in this case there
> +      should be one clock named "core" and another one named "reg"

The message is confusing. What is mandatory if there is a second clock?
Plus, the binding requires two clocks.

Drop entire description.

minItems: 1


> +
> +  dmas:
> +    maxItems: 1
> +    description: rxtx DMA channel

Drop description.

> +
> +  dma-names:
> +    items:
> +      - const: rxtx
> +
> +  marvell,system-controller:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Syscon node that handles NAND controller related registers
> +
> +patternProperties:
> +  "^nand@[0-3]$":
> +    type: object
> +    properties:
> +

Drop blank line.

> +      reg:
> +        minimum: 0
> +        maximum: 3
> +
> +      nand-rb:
> +        minimum: 0
> +        maximum: 1
> +
> +      nand-ecc-strength:
> +        enum: [1, 4, 8]
> +
> +      nand-on-flash-bbt: true
> +
> +      nand-ecc-mode: true
> +
> +      nand-ecc-algo:
> +        description: |
> +          This property is essentially useful when not using hardware ECC.
> +          Howerver, it may be added when using hardware ECC for clarification
> +          but will be ignored by the driver because ECC mode is chosen depending
> +          on the page size and the strength required by the NAND chip.
> +          This value may be overwritten with nand-ecc-strength property.
> +
> +      nand-ecc-step-size:
> +        const: 512

Why this is const?

> +        description: |
> +          Marvell's NAND flash controller does use fixed strength
> +          (1-bit for Hamming, 16-bit for BCH), so the actual step size
> +          will shrink or grow in order to fit the required strength.
> +          Step sizes are not completely random for all and follow certain
> +          patterns described in AN-379, "Marvell SoC NFC ECC".
> +
> +      label:
> +        $ref: /schemas/types.yaml#/definitions/string
> +
> +      partitions:
> +        type: object
> +        $ref: "/schemas/mtd/partitions/partition.yaml"

Drop quotes

        unevalautedProperties: false

and then you will see errors, because you referenced schema for one
partition.


> +
> +      marvell,nand-keep-config:
> +        description: |
> +          Orders the driver not to take the timings from the core and
> +          leaving them completely untouched. Bootloader timings will then
> +          be used.
> +        $ref: /schemas/types.yaml#/definitions/flag
> +
> +      marvell,nand-enable-arbiter:
> +        description: |
> +          To enable the arbiter, all boards blindly used it,
> +          this bit was set by the bootloader for many boards and even if
> +          it is marked reserved in several datasheets, it might be needed to set
> +          it (otherwise it is harmless) so whether or not this property is set,
> +          the bit is selected by the driver.
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        deprecated: true
> +
> +    additionalProperties: false
> +
> +    required:
> +      - reg
> +      - nand-rb
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"

Drop these two - required by nand-controller.

> +  - interrupts
> +  - clocks
> +
> +allOf:
> +  - $ref: "nand-controller.yaml#"

Drop quotes.

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: marvell,pxa3xx-nand-controller
> +    then:
> +      required:
> +        - dmas
> +        - dma-names
> +    else:
> +      properties:
> +        dmas: false
> +        dma-names: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: marvell,armada-8k-nand-controller
> +    then:
> +      required:
> +        - marvell,system-controller
> +    else:
> +      properties:
> +        marvell,system-controller: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    nand_controller: nand-controller@d0000 {
> +            compatible = "marvell,armada370-nand-controller";
> +            reg = <0xd0000 0x54>;

Use 4 spaces for example indentation.

> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&coredivclk 0>;
> +

Best regards,
Krzysztof

