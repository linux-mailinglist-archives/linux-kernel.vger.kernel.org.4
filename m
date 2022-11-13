Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E16162701C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 15:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbiKMOsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 09:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiKMOsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 09:48:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6687BC3D;
        Sun, 13 Nov 2022 06:48:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D805B80945;
        Sun, 13 Nov 2022 14:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EE4C433C1;
        Sun, 13 Nov 2022 14:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668350910;
        bh=w5m0TCHObmqhvWCvsEi/mHUBLY7Vp+pmyFwDm9FPnws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o76Tg4NceKEhHyPVkfpWhrIG38uSedqWLp9fDIOYPVQ+h3OWQGeOhPwhewH1EBHj2
         0ioZsckiidxXo/UjnhzaNzBTkr5KLRoIT+7IlxlR7lu9Ea9/5kaatre1Xs9SM+J0h8
         WkbhdYxS7Bw+XopVoNkrzZal82OwjUM5G8iqTHLs3OVa4ik/RmNHYkPKIObd6wBjLR
         iTPB5ka23ux1jCr5aEGAbmOdv6v8Pxs5mCEpOw10AhSfRXpgr4M40l+UYWlgnfvihv
         7kKXGYL0Xvg5cNM/sAuqRmog0awmFd9rB9H1FXKAtbpe8i915DuqN7YtCUC5anmcPd
         qPfdnpQMmY8dQ==
Date:   Sun, 13 Nov 2022 14:48:25 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/9] dt-bindings: Add RISC-V incoming MSI controller
 bindings
Message-ID: <Y3EDuaW0zQSSfiQ/@spud>
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
 <20221111044207.1478350-5-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111044207.1478350-5-apatel@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Anup,

On Fri, Nov 11, 2022 at 10:12:02AM +0530, Anup Patel wrote:
> dt-bindings: Add RISC-V incoming MSI controller bindings

nit: it looks like the usual prefix here is "dt-bindings:
interrupt-controller".

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

Is this one of the situations where we want to have a | after
"description:" to preserve formatting?

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

Is it valid to have a dummy here? I did a bit of grepping & could not
see a single other yaml binding which used a placeholder like this -
other than the example schema itself. I assume you're trying to get
across the point that using the bare riscv,imsics is not okay and a
vendor should create a custom string for their implementation?

Also, the file name says "riscv,imsic", the description says "IMSIC" but
you've used "imsics" in the compatible. Is this a typo, or a plural?

Thanks,
Conor.

> +      - const: riscv,imsics
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 128
> +    description:
> +      Base address of each IMSIC group.
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 0
> +
> +  msi-controller: true
> +
> +  interrupts-extended:
> +    minItems: 1
> +    maxItems: 32768
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
> +
> +  riscv,group-index-shift:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 24
> +    maximum: 55
> +    description:
> +      Specifies the least significant bit of the group index bits in the
> +      MSI target address. When not specified it is assumed to be 24.
> +
> +additionalProperties: false
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
> +      interrupts-extended = <&cpu1_intc 9>,
> +                            <&cpu2_intc 9>,
> +                            <&cpu3_intc 9>,
> +                            <&cpu4_intc 9>;
> +      reg = <0x28000000 0x2000>, /* Group0 IMSICs */
> +            <0x29000000 0x2000>; /* Group1 IMSICs */
> +      interrupt-controller;
> +      #interrupt-cells = <0>;
> +      msi-controller;
> +      riscv,num-ids = <127>;
> +      riscv,group-index-bits = <1>;
> +      riscv,group-index-shift = <24>;
> +    };
> +...
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
