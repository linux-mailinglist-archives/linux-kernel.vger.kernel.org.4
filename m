Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B4469C471
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 04:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjBTDUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 22:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjBTDUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 22:20:43 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03740C14A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 19:20:42 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id k17so1088680vkr.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 19:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IVyxrcqyhvEqcJnk25l7mMKS619HzfCIN9oUYklNXO4=;
        b=Hsi4KSoHUL3ldJNfqVhHQV+jfZ8b9o2ZthQpGd0zRRNjL0A6Vzqx0ApdN/HJvmSMhy
         5w5IDjg1c4DOLkSdQZls7yuioOQQNXo+NdD8JePMwPn2kRYIQ9R53l1Pw5i2FZqqx0Lm
         +IeEU0/qY2liYoj+KEFJNoL5tKJODbK69wSxGD/v9thJzVLTyUvqzWuUaw1rf4wR4OVr
         g4Bm7X+7TOmSqimMmTAneZWc2e3BD/RUoP4153I1N6q5WBFOvmWtg9ejiFqmA+XCW7FA
         1DNeBnV1gDHxaMUHeB4XN1y82uB03KT9JM+4PyhOlX0fR9QTzEVGd63JcI6zCb6LEwjh
         dgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVyxrcqyhvEqcJnk25l7mMKS619HzfCIN9oUYklNXO4=;
        b=BXP7oqW0alyk1XdgIuMkU0764wgutYzmREAXA4NGsVQiAK7fgGISWWGAPMW8+BSTvE
         aLAN1dgmIk7yBti5I3qOP1hMHhj1gajVhWq6JVu79D/YugX5NP3uAV8dBA0kmBv2JANx
         bbmyQAPHg5rf5GVXhJqdfcDyJyZUfqz+uCo0ryh+Qzfoh9ShwsX1gJOTHPcx0Vt8RPZ+
         TOPrJ/QMXVFrlZHvlA7ca+2VuKnlinMO/S3t9CWE6Q4IEDxH4KHF8ftLRdK1/II6qzw4
         DFTBpAJC86QlOY7KC1CK/b+1BRM4NmGKG5h2/PlsUjW0QqS5mliLpbgRtKjKIWeKUbXG
         skzg==
X-Gm-Message-State: AO0yUKUo6CXkVHOg+FOTzaFa3myBQH6HTCpO3amPS23BwaKwnW+D4imw
        XqXSIeBmMbtUMlBsi9fdKjeZIWQ8IYLHyAHCXeBONA==
X-Google-Smtp-Source: AK7set9TV/8v8G4HWGDI+IojD/JqK2y1niqljmzxWt0uXdugO4mMtuM+B5Q8cNWiuLuloviLjFbMKzJYY0kv+HcF9Go=
X-Received: by 2002:a1f:a682:0:b0:3d5:9b32:7ba4 with SMTP id
 p124-20020a1fa682000000b003d59b327ba4mr86677vke.15.1676863240854; Sun, 19 Feb
 2023 19:20:40 -0800 (PST)
MIME-Version: 1.0
References: <20230103141409.772298-1-apatel@ventanamicro.com>
 <20230103141409.772298-5-apatel@ventanamicro.com> <20230112204913.GA126944-robh@kernel.org>
In-Reply-To: <20230112204913.GA126944-robh@kernel.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Mon, 20 Feb 2023 08:50:29 +0530
Message-ID: <CAK9=C2X+H+cv-eHW2uG4Az9LAJ+C75m7jm=dRLgW0db85E7OZQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] dt-bindings: interrupt-controller: Add RISC-V
 incoming MSI controller
To:     Rob Herring <robh@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 2:19 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jan 03, 2023 at 07:44:04PM +0530, Anup Patel wrote:
> > We add DT bindings document for the RISC-V incoming MSI controller
> > (IMSIC) defined by the RISC-V advanced interrupt architecture (AIA)
> > specification.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  .../interrupt-controller/riscv,imsics.yaml    | 168 ++++++++++++++++++
> >  1 file changed, 168 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
> > new file mode 100644
> > index 000000000000..b9db03b6e95f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
> > @@ -0,0 +1,168 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/interrupt-controller/riscv,imsics.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RISC-V Incoming MSI Controller (IMSIC)
> > +
> > +maintainers:
> > +  - Anup Patel <anup@brainfault.org>
> > +
> > +description: |
> > +  The RISC-V advanced interrupt architecture (AIA) defines a per-CPU incoming
> > +  MSI controller (IMSIC) for handling MSIs in a RISC-V platform. The RISC-V
> > +  AIA specification can be found at https://github.com/riscv/riscv-aia.
> > +
> > +  The IMSIC is a per-CPU (or per-HART) device with separate interrupt file
> > +  for each privilege level (machine or supervisor). The configuration of
> > +  a IMSIC interrupt file is done using AIA CSRs and it also has a 4KB MMIO
> > +  space to receive MSIs from devices. Each IMSIC interrupt file supports a
> > +  fixed number of interrupt identities (to distinguish MSIs from devices)
> > +  which is same for given privilege level across CPUs (or HARTs).
> > +
> > +  The device tree of a RISC-V platform will have one IMSIC device tree node
> > +  for each privilege level (machine or supervisor) which collectively describe
> > +  IMSIC interrupt files at that privilege level across CPUs (or HARTs).
> > +
> > +  The arrangement of IMSIC interrupt files in MMIO space of a RISC-V platform
> > +  follows a particular scheme defined by the RISC-V AIA specification. A IMSIC
> > +  group is a set of IMSIC interrupt files co-located in MMIO space and we can
> > +  have multiple IMSIC groups (i.e. clusters, sockets, chiplets, etc) in a
> > +  RISC-V platform. The MSI target address of a IMSIC interrupt file at given
> > +  privilege level (machine or supervisor) encodes group index, HART index,
> > +  and guest index (shown below).
> > +
> > +  XLEN-1           >=24                                 12    0
> > +  |                  |                                  |     |
> > +  -------------------------------------------------------------
> > +  |xxxxxx|Group Index|xxxxxxxxxxx|HART Index|Guest Index|  0  |
> > +  -------------------------------------------------------------
> > +
> > +allOf:
> > +  - $ref: /schemas/interrupt-controller.yaml#
> > +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - riscv,qemu-imsics
>
> The implmentation/vendor is qemu, so: qemu,imsics (or qemu,riscv-imsics?)

Okay, I will update.

>
> > +      - const: riscv,imsics
> > +
> > +  reg:
> > +    minItems: 1
> > +    maxItems: 16384
> > +    description:
> > +      Base address of each IMSIC group.
> > +
> > +  interrupt-controller: true
> > +
> > +  "#interrupt-cells":
> > +    const: 0
> > +
> > +  msi-controller: true
> > +
> > +  interrupts-extended:
> > +    minItems: 1
> > +    maxItems: 16384
> > +    description:
> > +      This property represents the set of CPUs (or HARTs) for which given
> > +      device tree node describes the IMSIC interrupt files. Each node pointed
> > +      to should be a riscv,cpu-intc node, which has a riscv node (i.e. RISC-V
> > +      HART) as parent.
> > +
> > +  riscv,num-ids:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 63
> > +    maximum: 2047
> > +    description:
> > +      Number of interrupt identities supported by IMSIC interrupt file.
> > +
> > +  riscv,num-guest-ids:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 63
> > +    maximum: 2047
> > +    description:
> > +      Number of interrupt identities are supported by IMSIC guest interrupt
> > +      file. When not specified it is assumed to be same as specified by the
> > +      riscv,num-ids property.
> > +
> > +  riscv,guest-index-bits:
> > +    minimum: 0
> > +    maximum: 7
> > +    default: 0
> > +    description:
> > +      Number of guest index bits in the MSI target address. When not
> > +      specified it is assumed to be 0.
>
> No need to repeat what 'default: 0' defines.

Okay, I will update.

>
> > +
> > +  riscv,hart-index-bits:
> > +    minimum: 0
> > +    maximum: 15
> > +    description:
> > +      Number of HART index bits in the MSI target address. When not
> > +      specified it is estimated based on the interrupts-extended property.
>
> If guessing works, why do you need the property? Perhaps
> s/estimated/calculated/?

Okay, I will fix the wording.

We need this property because IMSIC files of two consecutive HARTs
are not required to be contiguous since there could be holes (unused
space) in between.

>
> > +
> > +  riscv,group-index-bits:
> > +    minimum: 0
> > +    maximum: 7
> > +    default: 0
> > +    description:
> > +      Number of group index bits in the MSI target address. When not
> > +      specified it is assumed to be 0.
> > +
> > +  riscv,group-index-shift:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 55
> > +    default: 24
> > +    description:
> > +      The least significant bit position of the group index bits in the
> > +      MSI target address. When not specified it is assumed to be 24.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupt-controller
> > +  - msi-controller
>
> #msi-cells should be defined (as 0) and required. Best to be explicit
> #and not rely on the default.

Okay, I will update.

>
> > +  - interrupts-extended
> > +  - riscv,num-ids
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    // Example 1 (Machine-level IMSIC files with just one group):
> > +
> > +    imsic_mlevel: interrupt-controller@24000000 {
>
> Drop unused labels.

Okay, I will update.

>
> > +      compatible = "riscv,qemu-imsics", "riscv,imsics";
> > +      interrupts-extended = <&cpu1_intc 11>,
> > +                            <&cpu2_intc 11>,
> > +                            <&cpu3_intc 11>,
> > +                            <&cpu4_intc 11>;
> > +      reg = <0x28000000 0x4000>;
> > +      interrupt-controller;
> > +      #interrupt-cells = <0>;
> > +      msi-controller;
> > +      riscv,num-ids = <127>;
> > +    };
> > +
> > +  - |
> > +    // Example 2 (Supervisor-level IMSIC files with two groups):
> > +
> > +    imsic_slevel: interrupt-controller@28000000 {
> > +      compatible = "riscv,qemu-imsics", "riscv,imsics";
> > +      interrupts-extended = <&cpu1_intc 9>,
> > +                            <&cpu2_intc 9>,
> > +                            <&cpu3_intc 9>,
> > +                            <&cpu4_intc 9>;
> > +      reg = <0x28000000 0x2000>, /* Group0 IMSICs */
> > +            <0x29000000 0x2000>; /* Group1 IMSICs */
> > +      interrupt-controller;
> > +      #interrupt-cells = <0>;
> > +      msi-controller;
> > +      riscv,num-ids = <127>;
> > +      riscv,group-index-bits = <1>;
> > +      riscv,group-index-shift = <24>;
> > +    };
> > +...
> > --
> > 2.34.1
> >

Regards,
Anup
