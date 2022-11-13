Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC545627048
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 16:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbiKMPok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 10:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbiKMPoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 10:44:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF68633C;
        Sun, 13 Nov 2022 07:44:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0572F60BEE;
        Sun, 13 Nov 2022 15:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8E7C433C1;
        Sun, 13 Nov 2022 15:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668354277;
        bh=+np6BjdLB4FoW60WKA7TfzR9a9to1GXUs99jMYQqsIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TrbpvlicUFIA2xU9R/2jl+aNgW4hg3wEHJa38nzZwIeL0ZM5PJo7mI8nVqCOUWvIY
         U9z/n8RcC1RcR2y7OvpuXDpjp5kS81TymtITR6G5OfLy7ZXcZLsJNPQc6l88vktoVJ
         scy+yaraNR2rjXmw0GfgEZ40TrAgQkC+wpJTKSfNyFk9UHj03R03/qNQ+JkeTJmFCb
         kaCD5SDbmGfldhZFTFUicdVd6jVVz87DX2reLF56gt7mamyh77bpCxsRvQ6Jp/ieFt
         6lzco2U8G6wf5lAaGezFoCms5moT/argc8/ex4FDXlF2M4Yw6koRJMqPWkJWkIopeC
         WNUp+GfODpKqg==
Date:   Sun, 13 Nov 2022 15:44:32 +0000
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
Subject: Re: [PATCH 6/9] dt-bindings: Add RISC-V advanced PLIC bindings
Message-ID: <Y3EQ4JU7uGbIMGiW@spud>
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
 <20221111044207.1478350-7-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111044207.1478350-7-apatel@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Anup,

Ditto the $subject nit here.

On Fri, Nov 11, 2022 at 10:12:04AM +0530, Anup Patel wrote:
> We add DT bindings document for RISC-V advanced platform level interrupt
> controller (APLIC) defined by the RISC-V advanced interrupt architecture
> (AIA) specification.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../interrupt-controller/riscv,aplic.yaml     | 136 ++++++++++++++++++
>  1 file changed, 136 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
> new file mode 100644
> index 000000000000..0aa48571f3bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
> @@ -0,0 +1,136 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/riscv,aplic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V Advancded Platform Level Interrupt Controller (APLIC)

Typo: Advanced

> +
> +maintainers:
> +  - Anup Patel <anup@brainfault.org>
> +
> +description:
> +  The RISC-V advanced interrupt architecture (AIA) defines advanced platform
                                                             ^
Missing an article here?

> +  level interrupt controller (APLIC) for handling wired interrupts in a
> +  RISC-V platform. The RISC-V AIA specification can be found at
> +  https://github.com/riscv/riscv-aia.
> +
> +  The RISC-V APLIC is implemented as hierarchical APLIC domains where all
> +  interrupt sources connect to the root domain which can further delegate
> +  interrupts to child domains. We have one device tree node for each APLIC

While I am nitpicking, s/We have/There is/ ?

> +  domain.
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - vendor,chip-aplic

Same comment here about the validity of this placeholder.

> +      - const: riscv,aplic
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  interrupts-extended:
> +    minItems: 1
> +    maxItems: 16384
> +    description:
> +      The presence of this property implies that given APLIC domain directly
                                                   ^
Missing indefinite article here (and in msi-parent)?

> +      injects external interrupts to a set of RISC-V HARTS (or CPUs). Each
> +      node pointed to should be a riscv,cpu-intc node, which has a riscv node
> +      (i.e. RISC-V HART) as parent.
> +
> +  msi-parent:
> +    description:
> +      The presence of this property implies that given APLIC domain forwards
> +      wired interrupts as MSIs to a AIA incoming message signaled interrupt
> +      controller (IMSIC). This property should be considered only when the
> +      interrupts-extended property is absent.

This mutual exclusion can be represented, can't it?
IIRC it is some sort of oneOf thing, somewhat like below:
oneOf:
  - required:
      - msi-parent
  - required:
      - interrupts-extended

AFAIR from doing the i2c ocores binding, this will force the addition of
one, but not both, to a node.

Or is this not actually mutually exclusive & the msi-parent property is
permitted but just left unused if interrupts-extended is present?

> +  riscv,num-sources:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    minimum: 1
> +    maximum: 1023
> +    description:
> +      Specifies how many wired interrupts are supported by this APLIC domain.
> +
> +  riscv,children:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +    minItems: 1
> +    maxItems: 1024
> +    description:
> +      This property represents a list of child APLIC domains for the given
> +      APLIC domain. Each child APLIC domain is assigned child index in
> +      increasing order with the first child APLIC domain assigned child
> +      index 0. The APLIC domain child index is used by firmware to delegate
> +      interrupts from the given APLIC domain to a particular child APLIC
> +      domain.
> +
> +  riscv,delegate:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +    minItems: 1
> +    maxItems: 1024
> +    description:
> +      This property represents a interrupt delegation list where each entry
> +      is a triple consisting of child APLIC domain phandle, first interrupt
> +      number, and last interrupt number. The firmware will configure interrupt
> +      delegation registers based on interrupt delegation list.

What is the inter dependence of the children and delegate?
Is it valid to have a delegate property without children?
Can the firmware delegate interrupts without the delegation list, based
on the children property alone? Or is it effectively useless without a
children property?

In your examples, the second has msi-parent but neither of these custom
properties. Do the children/delegate properties have a meaning in the
msi-parent case?

I think the binding should enforce whatever dependency exists there.
Thanks,
Conor.

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - riscv,num-sources
> +
> +examples:
> +  - |
> +    // Example 1 (APIC domain directly injecting interrupt to HARTs):
> +
> +    aplic0: interrupt-controller@c000000 {
> +      compatible = "vendor,chip-aplic", "riscv,aplic";
> +      interrupts-extended = <&cpu1_intc 11>,
> +                            <&cpu2_intc 11>,
> +                            <&cpu3_intc 11>,
> +                            <&cpu4_intc 11>;
> +      reg = <0xc000000 0x4080>;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +      riscv,num-sources = <63>;
> +      riscv,children = <&aplic1>;
> +      riscv,delegate = <&aplic1 1 63>;
> +    };
> +
> +    aplic1: interrupt-controller@d000000 {
> +      compatible = "vendor,chip-aplic", "riscv,aplic";
> +      interrupts-extended = <&cpu1_intc 9>,
> +                            <&cpu2_intc 9>,
> +                            <&cpu3_intc 9>,
> +                            <&cpu4_intc 9>;
> +      reg = <0xd000000 0x4080>;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +      riscv,num-sources = <63>;
> +    };
> +
> +  - |
> +    // Example 2 (APIC domain forwarding interrupts as MSIs):
> +
> +    interrupt-controller@d000000 {
> +      compatible = "vendor,chip-aplic", "riscv,aplic";
> +      msi-parent = <&imsics>;
> +      reg = <0xd000000 0x4000>;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +      riscv,num-sources = <63>;
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
