Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA10468C1FF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjBFPnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjBFPna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:43:30 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CB01814D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 07:42:57 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a2so10510763wrd.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 07:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W1rmMGWM7aksF5L0VhN0hng96AmwJQmBgJkYeuHcTuM=;
        b=eUivaHJ0jtk9IWS0bvVWDSWywjwYk5UB4FE53XcrSGCVqpcgbb4/hbj182pPavI6XD
         1jL/Pzsvcgd5HGmgD/5CW6w/pUxViztOiOcALe6aWgZZXSnBUx10Tn8++pz2fctcB6rr
         /kFKsBf3t8fRYchlajl75pWf9V+UCNHBqzLStOidhoiro4hiWUK2ii2h4E5fpUP9QSsi
         dxpaoHbyU35Jx32PofG5+T/bLOQ1afOvoB2OB/cSAU00NHlbsqMbMLC8R0es1WM/QooR
         R6Tl7uOs4h2ZZsNfBAfkPhwvAX2Nmd4IoDUIuk3//OJzj97ndYi+LIlnmgykktNp4z5B
         4FkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1rmMGWM7aksF5L0VhN0hng96AmwJQmBgJkYeuHcTuM=;
        b=bx0ETNK4iObNtboETyKuMM5i0Tx2NnmYzdZa036U9F/Xf+JDbGBQWbrLOIUUVsMo0M
         S2XCHNzEWL3zDN3FpjPW5ZKx5EVPeuR6hhEaJkJ8NkscfGJ35z3yoPBA6s1nrHjbpxMn
         tThLAv/KX0UhY+EN203HnRT4ebuEEllSDPn087P9TExugWz1QrDSSreYsI2+4LijmAHI
         L3nedqpfd+nIcRIl1aezhbdKeBDwHZRB9uTTn/b3UNd9QKPuGcyaigT71XVYnH9LXPtk
         b+H5IxClRoX6iVWZB/ebYwkR/tgRyMDkY8Q4UOsd96234MNQtE+mHuH7UhIuBJgQhwJ9
         YoBA==
X-Gm-Message-State: AO0yUKWy2cprzPUzNXF/YbotesHl/RzdaWd79+Rw2Lt48sPE0UALrhu4
        SJj53a4Ib7lVzTZ632DUt0Z5cg==
X-Google-Smtp-Source: AK7set8IA3MEZbh+5u3YvK+B/yEpB076Ei6+jP+uA5+zZcW4IbMJdR2TCrTzSRvBwRayAY0ZaLu6Vw==
X-Received: by 2002:a5d:6b89:0:b0:2bf:ae2f:c6ff with SMTP id n9-20020a5d6b89000000b002bfae2fc6ffmr17416492wrx.31.1675698171248;
        Mon, 06 Feb 2023 07:42:51 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e2-20020a5d5002000000b002c3be6ae0b1sm9092299wrt.65.2023.02.06.07.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 07:42:50 -0800 (PST)
Message-ID: <f44fd173-07f3-6e08-8d3d-2a5bf538259a@linaro.org>
Date:   Mon, 6 Feb 2023 16:42:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings : misc : aspeed,cvic interrupt controller :
 convert the binding document to yaml
Content-Language: en-US
To:     Vijaya Anand <sunrockers8@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230206153325.43692-1-sunrockers8@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230206153325.43692-1-sunrockers8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: incorrect format. Use style consistent with subsystem (git log).


On 06/02/2023 16:33, Vijaya Anand wrote:
>     Convert the binding document for ASPEED AST2400 and AST2500 coprocessor interrupt controller
>     from txt to yaml so one could validate dt-entries correctly and any future additions can go
>     into yaml format. The options for compatability described according to the example given.

Weird commit msg indentation, wrong wrapping.
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

typo - compatibility

> ---
>  .../devicetree/bindings/misc/aspeed,cvic.txt  | 35 ----------
>  .../devicetree/bindings/misc/aspeed,cvic.yaml | 67 +++++++++++++++++++
>  2 files changed, 67 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/aspeed,cvic.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/aspeed,cvic.yaml

It is interrupt controller, so move it to interrupt-controller directory.

> 
> diff --git a/Documentation/devicetree/bindings/misc/aspeed,cvic.txt b/Documentation/devicetree/bindings/misc/aspeed,cvic.txt
> deleted file mode 100644
> index d62c783d1d5e..000000000000
> --- a/Documentation/devicetree/bindings/misc/aspeed,cvic.txt
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -* ASPEED AST2400 and AST2500 coprocessor interrupt controller
> -
> -This file describes the bindings for the interrupt controller present
> -in the AST2400 and AST2500 BMC SoCs which provides interrupt to the
> -ColdFire coprocessor.
> -
> -It is not a normal interrupt controller and it would be rather
> -inconvenient to create an interrupt tree for it as it somewhat shares
> -some of the same sources as the main ARM interrupt controller but with
> -different numbers.
> -
> -The AST2500 supports a SW generated interrupt
> -
> -Required properties:
> -- reg: address and length of the register for the device.
> -- compatible: "aspeed,cvic" and one of:
> -		"aspeed,ast2400-cvic"
> -	      or
> -		"aspeed,ast2500-cvic"
> -
> -- valid-sources: One cell, bitmap of supported sources for the implementation
> -
> -Optional properties;
> -- copro-sw-interrupts: List of interrupt numbers that can be used as
> -		       SW interrupts from the ARM to the coprocessor.
> -		       (AST2500 only)
> -
> -Example:
> -
> -	cvic: copro-interrupt-controller@1e6c2000 {
> -		compatible = "aspeed,ast2500-cvic";
> -		valid-sources = <0xffffffff>;
> -		copro-sw-interrupts = <1>;
> -		reg = <0x1e6c2000 0x80>;
> -	};
> diff --git a/Documentation/devicetree/bindings/misc/aspeed,cvic.yaml b/Documentation/devicetree/bindings/misc/aspeed,cvic.yaml
> new file mode 100644
> index 000000000000..bbff0418fa2c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/aspeed,cvic.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/aspeed,cvic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED AST2400 and AST2500 coprocessor interrupt controller
> +
> +maintainers: 
> +  - Benjamin Herrenschmidt <benh@kernel.crashing.org>
> +  - Rob Herring <robh@kernel.org>

These should be people having/knowing/responsible for hardware. I doubt
Rob has any interest in Aspeed...

> +
> +description: |
> +  This file describes the bindings for the interrupt controller present

Drop "This file describes the bindings for the" but instead rephrase it
and describe the hardware.

> +  in the AST2400 and AST2500 BMC SoCs which provides interrupt to the
> +  ColdFire coprocessor.
> +
> +  It is not a normal interrupt controller and it would be rather
> +  inconvenient to create an interrupt tree for it as it somewhat shares
> +  some of the same sources as the main ARM interrupt controller but with
> +  different numbers.
> +
> +  The AST2500 supports a SW generated interruptThe Soft Decision Forward Error Correction (SDFEC) Engine is a Hard IP block

Fix your wrapping and sentences.

> +  which provides high-throughput LDPC and Turbo Code implementations.
> +  The LDPC decode & encode functionality is capable of covering a range of
> +  customer specified Quasi-cyclic (QC) codes. The Turbo decode functionality
> +  principally covers codes used by LTE. The FEC Engine offers significant
> +  power and area savings versus implementations done in the FPGA fabric.
> +
> +properties:
> +

Drop blank line.

> +  compatible:
> +    enum: 
> +      - aspeed,ast2400-cvic
> +      - aspeed,ast2500-cvic
> +
> +  reg:
> +    maxItems: 1
> +    description: address and length of the register for the device.

Drop description

> +  
> +  valid-sources:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: One cell, bitmap of supported sources for the implementation
> +
> +  copro-sw-interrupts:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |

Drop | and do fix wrapping.

> +                  List of interrupt numbers that can be used as
> +                  SW interrupts from the ARM to the coprocessor.
> +                  (AST2500 only)
> +
> +required:
> +  - compatible
> +  - reg
> +  - valid-sources
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    cvic: copro-interrupt-controller@1e6c2000 

That's not DT coding style. Open DTS and look how this is coded in ARM.

Node name: interrupt-controller
Drop label.

> +    {
> +        compatible = "aspeed,ast2500-cvic";
> +        valid-sources = <0xffffffff>;
> +        copro-sw-interrupts = <1>;
> +        reg = <0x1e6c2000 0x80>;

reg is second property

> +    };

Best regards,
Krzysztof

