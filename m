Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C274627975
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbiKNJty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbiKNJta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:49:30 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9424C1DF27
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:49:27 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id d20so12379620ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ImTXzzSRjgHWFzodYSl0ZMauOmNHYIoqH7O3oNlMHPk=;
        b=NroDRhTgo9wX5eizp2mXtqzT+gIHYAyCHL/etgKCWWm7igL97ZDymZ9wfSlUb43o2P
         yPQldjUy1un1+xybodXFw0wnxgistkdTprOj2oa79UsQ5l8UyArcnhk9Uo1vPPivgMTT
         YN/upmWp1iIq0C+Tj2124iY3zIb9zs4maob0gcKLDoFdCdMjTEPzaaW7ml1XIHCbzJWf
         WlWU5RoVKYpeCD68mcGQNB508m3J6rJtTXO7GER6QcsufmpBH4NoI5CcDuYdZDBgUC93
         QrZ575im0XSTb4hi9rgujHhhoCOlAHwaBjfoqnZSOCMc7a4eSVHea8oHog2loLfvvhrO
         BSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImTXzzSRjgHWFzodYSl0ZMauOmNHYIoqH7O3oNlMHPk=;
        b=eQzoOKgxasXR1SAXe5e3/TCUErPICQ2rUCHlP7NFXFxEVrDcAmOtbtlZeHc8YgIoLs
         6nQf7uOna7ySaLs+fV2PAcc8jz2CPxXQed7sKKyG0dsFKOZyr5uf2cc9Vysw8/XFTkId
         c5mJz6ECWMvYQUxKGuxn+HnGaPRMu9iB30cL0tqF7PbxB4deAMbjHcyE8s/nGEoaTR0Y
         srWR6dtQxQW2ffuFznc5MaY6l9Q4NUSlL0ESRiVQiwKNPZ7HDjoM5vemAsHioRu1Onas
         gb/YeTvpi8KvEv3o91lhU2Oz+OErl13vA1/oeYYWfigNTSsdl58+M5isbIZ8H9+yHSQu
         HNXQ==
X-Gm-Message-State: ANoB5plH5o4cJmE3uPlA+slCp+unWiRE+o49yXIeA2spEtT7aWgrFEQV
        VZSHX7KghgxNB5J+a/oohSxjLo96pVep6Rt1
X-Google-Smtp-Source: AA0mqf6W/2H1XkevKiNWP5a3u3J4ww5Uic6TNPQb8nzLTT3yvz7U7ewCDsZ5Dl09YpvgfAGUpej1oA==
X-Received: by 2002:a2e:a602:0:b0:277:8a07:521c with SMTP id v2-20020a2ea602000000b002778a07521cmr3602767ljp.335.1668419365869;
        Mon, 14 Nov 2022 01:49:25 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z10-20020a05651c11ca00b002773ac59697sm1954760ljo.0.2022.11.14.01.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 01:49:25 -0800 (PST)
Message-ID: <9be58cb4-4ee8-a6e0-7a0a-f2f581e394d3@linaro.org>
Date:   Mon, 14 Nov 2022 10:49:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/9] dt-bindings: Add RISC-V incoming MSI controller
 bindings
Content-Language: en-US
To:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
 <20221111044207.1478350-5-apatel@ventanamicro.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111044207.1478350-5-apatel@ventanamicro.com>
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

On 11/11/2022 05:42, Anup Patel wrote:
> We add DT bindings document for RISC-V incoming MSI controller (IMSIC)
> defined by the RISC-V advanced interrupt architecture (AIA) specification.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../interrupt-controller/riscv,imsic.yaml     | 174 ++++++++++++++++++
>  1 file changed, 174 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,imsic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,imsic.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsic.yaml
> new file mode 100644
> index 000000000000..05106eb1955e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsic.yaml
> @@ -0,0 +1,174 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/riscv,imsic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V Incoming MSI Controller (IMSIC)
> +
> +maintainers:
> +  - Anup Patel <anup@brainfault.org>
> +
> +description:
> +  The RISC-V advanced interrupt architecture (AIA) defines a per-CPU incoming
> +  MSI controller (IMSIC) for handling MSIs in a RISC-V platform. The RISC-V
> +  AIA specification can be found at https://github.com/riscv/riscv-aia.
> +
> +  The IMSIC is a per-CPU (or per-HART) device with separate interrupt file
> +  for each privilege level (machine or supervisor). The configuration of
> +  a IMSIC interrupt file is done using AIA CSRs and it also has a 4KB MMIO
> +  space to receive MSIs from devices. Each IMSIC interrupt file supports a
> +  fixed number of interrupt identities (to distinguish MSIs from devices)
> +  which is same for given privilege level across CPUs (or HARTs).
> +
> +  The arrangement of IMSIC interrupt files in MMIO space of a RISC-V platform
> +  follows a particular scheme defined by the RISC-V AIA specification. A IMSIC
> +  group is a set of IMSIC interrupt files co-located in MMIO space and we can
> +  have multiple IMSIC groups (i.e. clusters, sockets, chiplets, etc) in a
> +  RISC-V platform. The MSI target address of a IMSIC interrupt file at given
> +  privilege level (machine or supervisor) encodes group index, HART index,
> +  and guest index (shown below).
> +
> +  XLEN-1           >=24                                 12    0
> +  |                  |                                  |     |
> +  -------------------------------------------------------------
> +  |xxxxxx|Group Index|xxxxxxxxxxx|HART Index|Guest Index|  0  |
> +  -------------------------------------------------------------
> +
> +  The device tree of a RISC-V platform will have one IMSIC device tree node
> +  for each privilege level (machine or supervisor) which collectively describe
> +  IMSIC interrupt files at that privilege level across CPUs (or HARTs).
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - vendor,chip-imsics

There is no such vendor... As Conor pointed out, this does not look
correct. Compatibles must be real and specific.

> +      - const: riscv,imsics
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 128

Is there a DTS with 128 reg items?

> +    description:
> +      Base address of each IMSIC group.
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 0
> +
> +  msi-controller: true

You want then msi-controller.yaml schema and you can drop properties
described there.

> +
> +  interrupts-extended:
> +    minItems: 1
> +    maxItems: 32768

I just wonder if you are not putting some random stuff here... just like
this "vendor" company.

32768 inputs it is quite a big chip. Are you sure you have so many pins
or internal connections?

> +    description:
> +      This property represents the set of CPUs (or HARTs) for which given
> +      device tree node describes the IMSIC interrupt files. Each node pointed
> +      to should be a riscv,cpu-intc node, which has a riscv node (i.e. RISC-V
> +      HART) as parent.
> +
> +  riscv,num-ids:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 63
> +    maximum: 2047
> +    description:
> +      Specifies how many interrupt identities are supported by IMSIC interrupt
> +      file.
> +
> +  riscv,num-guest-ids:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 63
> +    maximum: 2047
> +    description:
> +      Specifies how many interrupt identities are supported by IMSIC guest
> +      interrupt file. When not specified the number of interrupt identities
> +      supported by IMSIC guest file is assumed to be same as specified by
> +      the riscv,num-ids property.
> +
> +  riscv,slow-ipi:
> +    type: boolean
> +    description:
> +      The presence of this property implies that software interrupts (i.e.
> +      IPIs) using IMSIC software injected MSIs is slower compared to other
> +      software interrupt mechanisms (such as SBI IPI) on the underlying
> +      RISC-V platform.

Is this a property of software or hardware?

> +
> +  riscv,guest-index-bits:
> +    minimum: 0
> +    maximum: 7
> +    description:
> +      Specifies number of guest index bits in the MSI target address. When
> +      not specified it is assumed to be 0.
> +
> +  riscv,hart-index-bits:
> +    minimum: 0
> +    maximum: 15
> +    description:
> +      Specifies number of HART index bits in the MSI target address. When
> +      not specified it is estimated based on the interrupts-extended property.
> +
> +  riscv,group-index-bits:
> +    minimum: 0
> +    maximum: 7
> +    description:
> +      Specifies number of group index bits in the MSI target address. When
> +      not specified it is assumed to be 0.

Then default: 0.

> +
> +  riscv,group-index-shift:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 24
> +    maximum: 55
> +    description:
> +      Specifies the least significant bit of the group index bits in the

Please drop everywhere "Specifies the" and instead just describe the
hardware.

> +      MSI target address. When not specified it is assumed to be 24.
> +
> +additionalProperties: false

unevaluatedProperties: false and drop all properties already described
by other schemas.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - msi-controller
> +  - interrupts-extended
> +  - riscv,num-ids
> +
> +examples:
> +  - |
> +    // Example 1 (Machine-level IMSIC files with just one group):
> +
> +    imsic_mlevel: interrupt-controller@24000000 {
> +      compatible = "vendor,chip-imsics", "riscv,imsics";
> +      interrupts-extended = <&cpu1_intc 11>,
> +                            <&cpu2_intc 11>,
> +                            <&cpu3_intc 11>,
> +                            <&cpu4_intc 11>;
> +      reg = <0x28000000 0x4000>;
> +      interrupt-controller;
> +      #interrupt-cells = <0>;
> +      msi-controller;
> +      riscv,num-ids = <127>;
> +    };
> +
> +  - |
> +    // Example 2 (Supervisor-level IMSIC files with two groups):
> +
> +    imsic_slevel: interrupt-controller@28000000 {
> +      compatible = "vendor,chip-imsics", "riscv,imsics";

Please run scripts/checkpatch.pl and fix reported warnings.

Best regards,
Krzysztof

