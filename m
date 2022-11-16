Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1353362C8F2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 20:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbiKPT2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 14:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbiKPT17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 14:27:59 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7DF5F868;
        Wed, 16 Nov 2022 11:27:58 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-12c8312131fso21276863fac.4;
        Wed, 16 Nov 2022 11:27:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddXhyxWoWR+WuCeBU1+8MsAASKTX24pGAhHTry1xkHY=;
        b=RlsFkQBUC9FYHbGlWpSz78Auzqwpx/21p73MiSt7Mm5w1o9SrnmU9kt9IRXY3CKVLX
         H9LfsFhZUC1SzeXPD9lqPARuaizbRDgrV5fWAM/YeBvRVDwkMo9Cf7kN1dBB5VriQuZW
         H27mBpTr6yD2Pvx/HYTk/HH760kbjAwSjui5ymp7ILXf2GKkZmsMwIuAZN12nJlDxeAb
         7d8nEjpyVP/V7djIplz+zDk7OSWJvvEuR/XrR5Y4Aj2sH3srgZxzl0ng5LqtC68HAQmV
         bbyvl3UyRKS7g6KzAxQZb9CiNtmKGO4JQQieQd1XGvOdrJ0QyhfE8kOOn++gj5WxHrpl
         NZOg==
X-Gm-Message-State: ANoB5pkuKdMF3pgPW9+0qF9avSz4Y75udLBiKGsrs+JHF4VEu/v6RB2Q
        OUOJEdRf8YLDB4KZsPIgnQ==
X-Google-Smtp-Source: AA0mqf4jU21nGD1Cah9qRaDMr7mqZE3Yy81FStzVZijy2j0rrHDWZ2yH/tP1NmDHcAc1cnaeHAQ2NQ==
X-Received: by 2002:a05:6870:4192:b0:141:ae05:159e with SMTP id y18-20020a056870419200b00141ae05159emr2594008oac.39.1668626877885;
        Wed, 16 Nov 2022 11:27:57 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z41-20020a056870c22900b001324315bb6asm8432984oae.29.2022.11.16.11.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 11:27:57 -0800 (PST)
Received: (nullmailer pid 759466 invoked by uid 1000);
        Wed, 16 Nov 2022 19:27:59 -0000
Date:   Wed, 16 Nov 2022 13:27:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
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
Subject: Re: [PATCH 6/9] dt-bindings: Add RISC-V advanced PLIC bindings
Message-ID: <20221116192759.GA743769-robh@kernel.org>
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
 <20221111044207.1478350-7-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111044207.1478350-7-apatel@ventanamicro.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> +
> +maintainers:
> +  - Anup Patel <anup@brainfault.org>
> +
> +description:
> +  The RISC-V advanced interrupt architecture (AIA) defines advanced platform
> +  level interrupt controller (APLIC) for handling wired interrupts in a
> +  RISC-V platform. The RISC-V AIA specification can be found at
> +  https://github.com/riscv/riscv-aia.
> +
> +  The RISC-V APLIC is implemented as hierarchical APLIC domains where all
> +  interrupt sources connect to the root domain which can further delegate
> +  interrupts to child domains. We have one device tree node for each APLIC
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
> +
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

As each entry is a single phandle:

       items:
         maxItems: 1

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

       items:
         items:
           - description: child APLIC domain phandle
           - description: ...
           - description: ...

> +    description:
> +      This property represents a interrupt delegation list where each entry
> +      is a triple consisting of child APLIC domain phandle, first interrupt
> +      number, and last interrupt number. The firmware will configure interrupt
> +      delegation registers based on interrupt delegation list.

First and last are inclusive?

Couldn't riscv,children and riscv,delegate be combined? How would they 
be different? If some children don't have any delegated interrupts, you 
could use -1 for the cells for example.

An example showing the need would be nice.

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

Is than an x86 APIC or a typo?

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
