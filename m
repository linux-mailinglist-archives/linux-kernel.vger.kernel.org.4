Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2FB65B556
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbjABQvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236440AbjABQvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:51:05 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CDB306
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:51:01 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id t17so67710420eju.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 08:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fz5XKty1bGWzTgMdRfuqQ/JzAqvCNClq4tW8DRBWnFM=;
        b=geBvjeXV1ZKZXEGQ679wIPmLmr4bJJC3ogIccCGJwmP37nQajWF4xabENZhe1D2qcl
         BtzUgXfcQVGJ3dQwKj1BTT57gdnm8JWrDF/skiXTxllsaqPvhvgBR2Yw5j6D4tAVt4xu
         M7tk5pZ10nHxpZmGprCNJRK4NZBwcC5FiaEjHYWKz0xP/8FpAhEEwO5k/lrMxebTR15z
         CkJdSx7IMMe2fS/PloFI5UR4+3THa8slwkz80jcIDq3FIKrC1g2c4a9FSdioi01TjAyR
         Mdm2thfnBiiZZE6LhMiy71+hluu/xL4XugkSjpxfXy6yxxmK0gZN2L4eiWE05BHQgcjf
         0AhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fz5XKty1bGWzTgMdRfuqQ/JzAqvCNClq4tW8DRBWnFM=;
        b=z8vx5N+P7gCxfwBISKUy2tx0YN7nEpDBFFoGvizC3EDPtQaEaC56wU4xyeHv/Y43td
         ZYEv2TbedzgoDUvY+qTW4ALuy89wfRVaUW9xQjdaJjH+od0MQ8lS7yiDrxwXAtSHduUn
         AAwF4LQ9h/hh00bWQtXZuZQiYeBWJC+oFjDsaQqeM48wru0OxYW+M48P8OrAmf4tCCu8
         t4/dyMikQ4ooDeyguvtFQjASHiQlsSeVuhNEp+BuBh6xFTBdeFAVPVyXIBP9obSeAlxC
         hLmq8JNyal5AtRJvgjVTw8JHI2qslCRZp9QEbKEq0NTUMCCZcjBNQz63zYsrccfnfxMH
         5ITw==
X-Gm-Message-State: AFqh2kq0EqFeovIIYmNNhmZpSR385hURMLsaOvMEA6Yb6j6LA/NYKBtZ
        KlJC8wUH/sR/NgI3WuDkpBVRdcHjUsZxq1bHCoalww==
X-Google-Smtp-Source: AMrXdXuvrIBtLF2vV2Ytg4fEMIMLSY8mHIn5GlyCPTYTEsGfYkCd2GvolLXDpImkaIk6wKFf7QU0Tpb+cgiVO1eoGHo=
X-Received: by 2002:a17:906:e095:b0:7c0:a880:dc71 with SMTP id
 gh21-20020a170906e09500b007c0a880dc71mr4239097ejb.705.1672678259591; Mon, 02
 Jan 2023 08:50:59 -0800 (PST)
MIME-Version: 1.0
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
 <20221111044207.1478350-7-apatel@ventanamicro.com> <Y3EQ4JU7uGbIMGiW@spud>
In-Reply-To: <Y3EQ4JU7uGbIMGiW@spud>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 2 Jan 2023 22:20:48 +0530
Message-ID: <CAAhSdy2UAMmX+W5Cm3DuTJzZ0jJ3=CW4PhjctQNdfeS+4hqWqg@mail.gmail.com>
Subject: Re: [PATCH 6/9] dt-bindings: Add RISC-V advanced PLIC bindings
To:     Conor Dooley <conor@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 9:14 PM Conor Dooley <conor@kernel.org> wrote:
>
> Hey Anup,
>
> Ditto the $subject nit here.

Adding "interrupt-controller:" to subject makes it longer than 80 characters.

>
> On Fri, Nov 11, 2022 at 10:12:04AM +0530, Anup Patel wrote:
> > We add DT bindings document for RISC-V advanced platform level interrupt
> > controller (APLIC) defined by the RISC-V advanced interrupt architecture
> > (AIA) specification.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  .../interrupt-controller/riscv,aplic.yaml     | 136 ++++++++++++++++++
> >  1 file changed, 136 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
> > new file mode 100644
> > index 000000000000..0aa48571f3bc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
> > @@ -0,0 +1,136 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/interrupt-controller/riscv,aplic.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RISC-V Advancded Platform Level Interrupt Controller (APLIC)
>
> Typo: Advanced

Okay, I will update.

>
> > +
> > +maintainers:
> > +  - Anup Patel <anup@brainfault.org>
> > +
> > +description:
> > +  The RISC-V advanced interrupt architecture (AIA) defines advanced platform
>                                                              ^
> Missing an article here?

Okay, I will update.

>
> > +  level interrupt controller (APLIC) for handling wired interrupts in a
> > +  RISC-V platform. The RISC-V AIA specification can be found at
> > +  https://github.com/riscv/riscv-aia.
> > +
> > +  The RISC-V APLIC is implemented as hierarchical APLIC domains where all
> > +  interrupt sources connect to the root domain which can further delegate
> > +  interrupts to child domains. We have one device tree node for each APLIC
>
> While I am nitpicking, s/We have/There is/ ?

Okay, I will update.

>
> > +  domain.
> > +
> > +allOf:
> > +  - $ref: /schemas/interrupt-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - vendor,chip-aplic
>
> Same comment here about the validity of this placeholder.

Okay, I will add "riscv,qemu-aplic" as QEMU specific compatible string.

>
> > +      - const: riscv,aplic
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupt-controller: true
> > +
> > +  "#interrupt-cells":
> > +    const: 2
> > +
> > +  interrupts-extended:
> > +    minItems: 1
> > +    maxItems: 16384
> > +    description:
> > +      The presence of this property implies that given APLIC domain directly
>                                                    ^
> Missing indefinite article here (and in msi-parent)?
>
> > +      injects external interrupts to a set of RISC-V HARTS (or CPUs). Each
> > +      node pointed to should be a riscv,cpu-intc node, which has a riscv node
> > +      (i.e. RISC-V HART) as parent.
> > +
> > +  msi-parent:
> > +    description:
> > +      The presence of this property implies that given APLIC domain forwards
> > +      wired interrupts as MSIs to a AIA incoming message signaled interrupt
> > +      controller (IMSIC). This property should be considered only when the
> > +      interrupts-extended property is absent.
>
> This mutual exclusion can be represented, can't it?
> IIRC it is some sort of oneOf thing, somewhat like below:
> oneOf:
>   - required:
>       - msi-parent
>   - required:
>       - interrupts-extended
>
> AFAIR from doing the i2c ocores binding, this will force the addition of
> one, but not both, to a node.
>
> Or is this not actually mutually exclusive & the msi-parent property is
> permitted but just left unused if interrupts-extended is present?

If both are present then interrupts-extended is preferred.

>
> > +  riscv,num-sources:
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > +    minimum: 1
> > +    maximum: 1023
> > +    description:
> > +      Specifies how many wired interrupts are supported by this APLIC domain.
> > +
> > +  riscv,children:
> > +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> > +    minItems: 1
> > +    maxItems: 1024
> > +    description:
> > +      This property represents a list of child APLIC domains for the given
> > +      APLIC domain. Each child APLIC domain is assigned child index in
> > +      increasing order with the first child APLIC domain assigned child
> > +      index 0. The APLIC domain child index is used by firmware to delegate
> > +      interrupts from the given APLIC domain to a particular child APLIC
> > +      domain.
> > +
> > +  riscv,delegate:
> > +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> > +    minItems: 1
> > +    maxItems: 1024
> > +    description:
> > +      This property represents a interrupt delegation list where each entry
> > +      is a triple consisting of child APLIC domain phandle, first interrupt
> > +      number, and last interrupt number. The firmware will configure interrupt
> > +      delegation registers based on interrupt delegation list.
>
> What is the inter dependence of the children and delegate?
> Is it valid to have a delegate property without children?
> Can the firmware delegate interrupts without the delegation list, based
> on the children property alone? Or is it effectively useless without a
> children property?

Both properties convey different information. The "riscv,childen" describes
the association of child indexes with child APLIC domains whereas the
"riscv,delegate" describes the interrupt delegation to few of the child
APLIC domains.


>
> In your examples, the second has msi-parent but neither of these custom
> properties. Do the children/delegate properties have a meaning in the
> msi-parent case?

The "riscv,childern" and "riscv,delegate" are only useful when we have
hierarchy of multiple APLIC domains. The second example only has
one APLIC domain hence these custom properties are absent.

>
> I think the binding should enforce whatever dependency exists there.
> Thanks,
> Conor.
>
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupt-controller
> > +  - "#interrupt-cells"
> > +  - riscv,num-sources
> > +
> > +examples:
> > +  - |
> > +    // Example 1 (APIC domain directly injecting interrupt to HARTs):
> > +
> > +    aplic0: interrupt-controller@c000000 {
> > +      compatible = "vendor,chip-aplic", "riscv,aplic";
> > +      interrupts-extended = <&cpu1_intc 11>,
> > +                            <&cpu2_intc 11>,
> > +                            <&cpu3_intc 11>,
> > +                            <&cpu4_intc 11>;
> > +      reg = <0xc000000 0x4080>;
> > +      interrupt-controller;
> > +      #interrupt-cells = <2>;
> > +      riscv,num-sources = <63>;
> > +      riscv,children = <&aplic1>;
> > +      riscv,delegate = <&aplic1 1 63>;
> > +    };
> > +
> > +    aplic1: interrupt-controller@d000000 {
> > +      compatible = "vendor,chip-aplic", "riscv,aplic";
> > +      interrupts-extended = <&cpu1_intc 9>,
> > +                            <&cpu2_intc 9>,
> > +                            <&cpu3_intc 9>,
> > +                            <&cpu4_intc 9>;
> > +      reg = <0xd000000 0x4080>;
> > +      interrupt-controller;
> > +      #interrupt-cells = <2>;
> > +      riscv,num-sources = <63>;
> > +    };
> > +
> > +  - |
> > +    // Example 2 (APIC domain forwarding interrupts as MSIs):
> > +
> > +    interrupt-controller@d000000 {
> > +      compatible = "vendor,chip-aplic", "riscv,aplic";
> > +      msi-parent = <&imsics>;
> > +      reg = <0xd000000 0x4000>;
> > +      interrupt-controller;
> > +      #interrupt-cells = <2>;
> > +      riscv,num-sources = <63>;
> > +    };
> > +...
> > --
> > 2.34.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

Regards,
Anup
