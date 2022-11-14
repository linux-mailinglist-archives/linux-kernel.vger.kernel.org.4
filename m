Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF39F627D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbiKNML0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbiKNMLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:11:24 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628BDFE6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:11:22 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id b124so11175604oia.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=51YFDdldLWkCPyi/+N2IbUoBaeV61YgUrojaD9xxJ1s=;
        b=J3St4sktMa3iurTc+z0Tba9fevpIBznXb/x2UYKW/39VNybPbXfLfW2CxBFluwpeTB
         hqnyCZqCGDcBu2+iiTvmoDMUcKLE46Oe91AmejGDySx23LHScXs0dA0fguwxJA9ExjNB
         vTqXBOA/OCiP8r6z3/LILh1I1L8dc3Ab5UbpIoUM7aCYbsq9gmzSyxLtBTphLWx9IizO
         ypAnq/1H7WwEhF7QfqVjGOrS8sWTIiHZhg6AG7ueN17kGkT81rfsoMYS3UUOmMqhGwSU
         O7rRHPZdGA28sncJWKeDTE0bkdU06Ul//RYx+/yLKb5uF1vVQT6mVYmDOj+qzW5QAw5X
         TuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=51YFDdldLWkCPyi/+N2IbUoBaeV61YgUrojaD9xxJ1s=;
        b=U4oiWkmgeyTz0+KGcmgAudNWU6WMtMs64HX2J/TLzhHafhQ7Gw0RHqTfwz3a+Cr8uX
         OX1dFpoNEXfFK82P8J/X7g6DxeZW/iF7AHcTz5riBSuTYKG/2lIRahei3lnIWaz7BchL
         78WYllet6kE5qIem17EGSPXe5ugznZ/1oenr5FQB3sxv4MkNsJqP0rB+eaYVeoB2u2G5
         MLSeBOXkDSnbFPqNWGGqNEhvOtdvmbe6bTXhQKHXfeNfjICReSHAyb3RrLLj3UGMg6lp
         JVMfaow4e3Pbc+z2B6ftQEkL+T3OO//MfNxhtCuKy5pktCWrfTyC/r6HTdXq6W58OyLc
         0+nQ==
X-Gm-Message-State: ANoB5plBnhD9S77n6JR+iRRwdICuma8DpwkS0QQhmYtDvMxSaUMSUTnA
        HXY8/C2BuDgWUzKUhgp8xtX+BOuEt5UH+Ng8Ma02Pw==
X-Google-Smtp-Source: AA0mqf4WiMo2j10zXoV/vztyAL1pL9S60FOe6gqVZ6spbmQS/jf0JrOVclKT2SRrV4nGRCVm5n7OzQizfNWK3g9rbXg=
X-Received: by 2002:aca:2b18:0:b0:359:ac8d:4227 with SMTP id
 i24-20020aca2b18000000b00359ac8d4227mr5429997oik.17.1668427881552; Mon, 14
 Nov 2022 04:11:21 -0800 (PST)
MIME-Version: 1.0
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
 <20221111044207.1478350-7-apatel@ventanamicro.com> <6da76cb0-428e-d35a-3b11-81c7efa22460@linaro.org>
In-Reply-To: <6da76cb0-428e-d35a-3b11-81c7efa22460@linaro.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Mon, 14 Nov 2022 17:41:10 +0530
Message-ID: <CAK9=C2XT3wu_fpC3zUzqtR+8161Vm0VcN9YP-1F7e4-JLDm6JQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] dt-bindings: Add RISC-V advanced PLIC bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 3:21 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 11/11/2022 05:42, Anup Patel wrote:
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
> > +
> > +maintainers:
> > +  - Anup Patel <anup@brainfault.org>
> > +
> > +description:
> > +  The RISC-V advanced interrupt architecture (AIA) defines advanced platform
> > +  level interrupt controller (APLIC) for handling wired interrupts in a
> > +  RISC-V platform. The RISC-V AIA specification can be found at
> > +  https://github.com/riscv/riscv-aia.
> > +
> > +  The RISC-V APLIC is implemented as hierarchical APLIC domains where all
> > +  interrupt sources connect to the root domain which can further delegate
> > +  interrupts to child domains. We have one device tree node for each APLIC
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
> > +      injects external interrupts to a set of RISC-V HARTS (or CPUs). Each
> > +      node pointed to should be a riscv,cpu-intc node, which has a riscv node
> > +      (i.e. RISC-V HART) as parent.
> > +
> > +  msi-parent:
> > +    description:
> > +      The presence of this property implies that given APLIC domain forwards
>
> Drop "The presence of this property" and make it a proper sentence
> describing hardware.

Okay, I will update.

>
> > +      wired interrupts as MSIs to a AIA incoming message signaled interrupt
> > +      controller (IMSIC). This property should be considered only when the
> > +      interrupts-extended property is absent.
> > +
> > +  riscv,num-sources:
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
>
> Drop quotes.

Okay, I will update.

>
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
>
> Drop "This property represents".

Okay, I will update.

>
> > +      is a triple consisting of child APLIC domain phandle, first interrupt
> > +      number, and last interrupt number. The firmware will configure interrupt
> > +      delegation registers based on interrupt delegation list.
> > +
> > +additionalProperties: false
>
> Same comments as in previous patch,

Okay, I will update.

>
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
>
> It's almost the same as previous... don't add unnecessary examples
> (difference in one property usually does not mean you need new example).

The second example shows the DT node of an APLIC in MSI-mode.
Most noteworthy part of this node is presence of "msi-parent" DT
property instead of "interrupts-extended" DT property to describe
an APLIC in MSI mode.

>
> > +    };
> > +...
>

Best Regards,
Anup
