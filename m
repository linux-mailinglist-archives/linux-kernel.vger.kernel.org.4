Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2283F65B5C6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 18:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjABRSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 12:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjABRSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 12:18:30 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA54AE6B
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 09:18:29 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id kw15so67834375ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 09:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1TMZ0x9PqurByAgv4IaQ4yW9+aLQK0OBu3LDtfMFSsg=;
        b=w3fJ2NVy3ybW4J12RYpo6AuPi5mn32czSWBXEVbNXs4w0q0iNt+QeXpZXeH1RX5KN1
         97nFkdOdU/by3MN81JgOvnuFZBRo326LiQfllIyefyoQydINXQPAL5+iTwIfrolvjNIu
         bZ2dbpXEwv6ChVXyBaoR4i+GELUUECfx3doT+0x/mLuoZIbPmNdlZdTkttkxBiIjGipN
         JG2gaPfcDIF6skQIuqUw1gk7t5P4uNN0yNyBAs4/rhpz4nrKcPB7ekxakNtWaX9FMI+d
         Dqlutmz3tpNsemkxJ1rtyZHweIiffIiMxZJjc+Le7P7+a+Hf6nmnOogR0Ej2QlBsFntS
         bGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1TMZ0x9PqurByAgv4IaQ4yW9+aLQK0OBu3LDtfMFSsg=;
        b=MWu/+698JcdoF5wrnjoEhyA+Lr/YdSgY7+qic6pk7v+d6XSPW5Yo2oO7hXIyClwGL4
         P3LdqLbd187ajPQj29Nh2U26h4Vk22xv4HvXtKMH84sd2r98wkU2cm90Wkw1694fPl5g
         jkL6mLV0zwq6aZNVgXrFPTeDcM+PGtoQwA7ORP9YbDl8OJF5GtOnHbJ6ohXVxuVDM5Ue
         RhdHcRpSBK1C/PsxHgrXAX8oGQu9MfFCRY3KTdhdx81vpOX5ODQpsCZQsRThKZo5tfic
         KeHKfOU2GBeXaXemRi0XlzJeshHYxHkJAUp+EBO3CPV9acWxAloou0gd89XPMgOsOjMY
         ev5A==
X-Gm-Message-State: AFqh2krlDTQPHvU88C3gI5qsv/xqO/NKaUJ8G9gLauSCpo6eo3yJ/q6i
        Bi35jKetGQWhxIZcSBGJ6IL5BD6aQ2xP8cIGQCKCDuLpzdSqJg==
X-Google-Smtp-Source: AMrXdXutiBd/Xq4LFn6w0DCoNgQtytv0Gx4gzk/hzQo1b3LTpVg/ZK5UuclH+SgA0jMzpAnnUSNinCG1Ma6lBJE607E=
X-Received: by 2002:a17:907:76f4:b0:7c0:c836:e586 with SMTP id
 kg20-20020a17090776f400b007c0c836e586mr3093627ejc.750.1672679907904; Mon, 02
 Jan 2023 09:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
 <20221111044207.1478350-7-apatel@ventanamicro.com> <20221116192759.GA743769-robh@kernel.org>
In-Reply-To: <20221116192759.GA743769-robh@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 2 Jan 2023 22:48:16 +0530
Message-ID: <CAAhSdy20DgoNLRtPw2TgTJSupxuco1NWWOWMN-97tpsnx9DLqg@mail.gmail.com>
Subject: Re: [PATCH 6/9] dt-bindings: Add RISC-V advanced PLIC bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
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

On Thu, Nov 17, 2022 at 12:57 AM Rob Herring <robh@kernel.org> wrote:
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
> > +      wired interrupts as MSIs to a AIA incoming message signaled interrupt
> > +      controller (IMSIC). This property should be considered only when the
> > +      interrupts-extended property is absent.
> > +
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
>
> As each entry is a single phandle:
>
>        items:
>          maxItems: 1

Okay, I will update.

>
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
>
>        items:
>          items:
>            - description: child APLIC domain phandle
>            - description: ...
>            - description: ...

Okay, I will update.

>
> > +    description:
> > +      This property represents a interrupt delegation list where each entry
> > +      is a triple consisting of child APLIC domain phandle, first interrupt
> > +      number, and last interrupt number. The firmware will configure interrupt
> > +      delegation registers based on interrupt delegation list.
>
> First and last are inclusive?

Yes, first and last are inclusive. I will clarify this in the description.

>
> Couldn't riscv,children and riscv,delegate be combined? How would they
> be different? If some children don't have any delegated interrupts, you
> could use -1 for the cells for example.

The "riscv,children" describes the hierarchy of APLIC domains in HW
whereas "riscv,delegate" describes the system choices of delegating
interrupts from a parent APLIC domain to one of its children. I feel
it's not natural to combine these two properties.

>
> An example showing the need would be nice.
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
>
> Is than an x86 APIC or a typo?
>
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

Regards,
Anup
