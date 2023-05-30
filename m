Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D0C715F29
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjE3MZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjE3MZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:25:15 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD84E46
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:24:44 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f4f3ac389eso3423872e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685449465; x=1688041465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZmqQHgK2oKvKJ3i0nTHh0YlYTqhPDZR13cQC7G3a/Wc=;
        b=neDF1O85irLnlpQlEk3xwFJ6/dRh2Lk/naodpd1tWmi8+Rkux1bpS1OaHOxIRJ8dZK
         5Lx7nMR2heXiZNF8u45DgA+VwhsypvXUpEHzoP1In724lhQz1XL6dHSjSpa8QzAjH8TN
         DVng16gq6g8jAz2tAolpRfCgyywARcF33pax4pwo57JWvQNz9MPoTo9ElP9xyT1ZPJ0Q
         5EZovNDF55vrJhdryAWhLGtGLUJzILX0qF5TwqkQiELhE3da1hEUx/LqTTA1XSFt6Gpl
         zLd80C5RwHaDzgFdagi9FRjdn55HkWelgtLnTu1ZGeqkZ2KHpbPJXIlv8LZRzuxoOjt9
         7DuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685449465; x=1688041465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmqQHgK2oKvKJ3i0nTHh0YlYTqhPDZR13cQC7G3a/Wc=;
        b=TmpP0i/sFnoki3fjx4w9AkgRir2vleVxEH83K9z0PxpHupq6z7K7/flkr62AmlrmGY
         kt9SdCvYk6btuk9OxNrwbIw3yNWYa6aAeAbg1TEYKw2H73A2r/Jjajuu6hvY4pctsAfv
         G2D/1rnKxv2prdOM/I4p439sDF7yf6pG7QruFa3OZJtdCngAP2dkekZnTZlqGOtTIEFn
         xtXE1TY5Pb1KtjqYgwRZ7NF12+XaGbIYrcnucO0hdX9qiRT/n76RPto+AAMl5uVRZoR/
         7M0pkU6OL1HkrWuuQmy5mj3S237Xf1AHlm3YXMtVUKE4dV55Msvo35LLCVNZRFMIIIaD
         Krrw==
X-Gm-Message-State: AC+VfDxyvrBeMhUJqDsWliWUUYgKp8sR2QQTwH9+bnoMv3jeboE53Nql
        /PGG5TsJMW2sY1GUcEal2qvnRw==
X-Google-Smtp-Source: ACHHUZ5UukllPljPGioGEYuGWV3HvwCEG8DF0RQC5VFx0310+KYgEGpJmmLACvniUVfkFDx3rdK4xQ==
X-Received: by 2002:ac2:59dc:0:b0:4f1:4040:8143 with SMTP id x28-20020ac259dc000000b004f140408143mr729871lfn.60.1685449465306;
        Tue, 30 May 2023 05:24:25 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id w5-20020aa7da45000000b005148e981bd3sm4101904eds.12.2023.05.30.05.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 05:24:24 -0700 (PDT)
Message-ID: <a1b2caed-b314-59db-ee00-92fc983150f6@linaro.org>
Date:   Tue, 30 May 2023 14:24:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
Content-Language: en-US
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, vadym.kochan@plvision.eu
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        enachman@marvell.com
References: <20230530005337.3687938-1-chris.packham@alliedtelesis.co.nz>
 <20230530005337.3687938-2-chris.packham@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230530005337.3687938-2-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 02:53, Chris Packham wrote:
> From: Vadym Kochan <vadym.kochan@plvision.eu>
> 
> Switch the DT binding to a YAML schema to enable the DT validation.
> 
> Dropped deprecated compatibles and properties described in txt file.
> 
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v6:
>     - remove properties covered by nand-controller.yaml
>     - add example using armada-8k compatible
>     
>     earlier changes:
>     
>     v5:
>        1) Get back "label" and "partitions" properties but without

Where are they? Did you drop them in v6?


>           ref to the "partition.yaml" which was wrongly used.


>     
>        2) Add "additionalProperties: false" for nand@ because all possible
>           properties are described.

Where? This cannot be silently dropped!

>     
>     v4:
>        1) Remove "label" and "partitions" properties
>     
>        2) Use 2 clocks for A7K/8K platform which is a requirement
>     
>     v3:
>       1) Remove txt version from the MAINTAINERS list
>     
>       2) Use enum for some of compatible strings
>     
>       3) Drop:
>             #address-cells
>             #size-cells:
>     
>          as they are inherited from the nand-controller.yaml
>     
>       4) Add restriction to use 2 clocks for A8K SoC
>     
>       5) Dropped description for clock-names and extend it with
>          minItems: 1
>     
>       6) Drop description for "dmas"
>     
>       7) Use "unevalautedProperties: false"
>     
>       8) Drop quites from yaml refs.
>     
>       9) Use 4-space indentation for the example section
>     
>     v2:
>       1) Fixed warning by yamllint with incorrect indentation for compatible list
> 
>  .../bindings/mtd/marvell,nand-controller.yaml | 190 ++++++++++++++++++
>  .../devicetree/bindings/mtd/marvell-nand.txt  | 126 ------------
>  MAINTAINERS                                   |   1 -
>  3 files changed, 190 insertions(+), 127 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> new file mode 100644
> index 000000000000..c4b003f5fa9f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> @@ -0,0 +1,190 @@
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

Is it correct person for Marvell NAND? This should be not a subsystem
maintainer, but a device maintainer.

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: marvell,armada-8k-nand-controller
> +          - const: marvell,armada370-nand-controller
> +      - enum:
> +          - marvell,armada370-nand-controller
> +          - marvell,pxa3xx-nand-controller

You miss here deprecated compatibles, which are BTW still used. Don't
drop properties and compatibles during conversion.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Shall reference the NAND controller clocks, the second one is
> +      is only needed for the Armada 7K/8K SoCs
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:

Missing minItems: 1

> +    items:
> +      - const: core
> +      - const: reg
> +
> +  dmas:
> +    maxItems: 1
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

Missing unevaluatedProperties: false on this level.

> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 3
> +
> +      nand-rb:
> +        minimum: 0
> +        maximum: 1

It's an array, so this does not sound right. You might want to put it
under items:.  Then you also miss min/maxItems.

> +
> +      nand-ecc-step-size:
> +        const: 512
> +
> +      nand-ecc-strength:
> +        enum: [1, 4, 8]
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
> +    required:
> +      - reg
> +      - nand-rb
> +
> +allOf:
> +  - $ref: nand-controller.yaml
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
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: marvell,armada-8k-nand-controller
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2

Drop maxItems. You don't have it in clock-names.

> +
> +        clock-names:
> +          minItems: 2
> +
> +      required:
> +        - marvell,system-controller
> +    else:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +
> +        clock-names:
> +          maxItems: 1

I doubt that you tested it in above variant...

> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    nand_controller: nand-controller@d0000 {
> +        compatible = "marvell,armada370-nand-controller";
> +        reg = <0xd0000 0x54>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;


Best regards,
Krzysztof

