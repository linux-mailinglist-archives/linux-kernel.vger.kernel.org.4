Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B74966853B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240426AbjALVXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240737AbjALVWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:22:32 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB32C81107;
        Thu, 12 Jan 2023 13:02:34 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id d16-20020a4a5210000000b004f23d1aea58so1349462oob.3;
        Thu, 12 Jan 2023 13:02:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfY+++CNANdJFoCSPyaMORoeKsaEA9plzaHJ+dY2V7w=;
        b=oTE+T914VSlIE/RQuTQsEvFpDxRWE2A8e9GN+NauiayDBBjSBvxpubXAf/Y8oDZcUW
         aZjlPdC5pQZeMYJSSIecuZ+/SNbnBDMCpoMlgjJzmQ0N9AIb//1w+AKZQh+hMh0N+qg+
         TwFrqYYz0LLaZtC3UvKbbDrS6YvperSSHrVI3+Utca5QyNoaB05uFvxdg/p2ybpVqY1q
         mqhLC+b9IMWNzak4UNYUTz5rGOYnN/fewh/x7q4Z2hVLjg0gMAfmnSMR61UkVwcyIfPc
         1HxP0eix6iF+BKLNViSFf8dADpN5hG/LB/YfrJJyjx6k4bwbnoy20fgl4mBFivWkRbjN
         C8Qg==
X-Gm-Message-State: AFqh2kq+KlKzYYUPljSqwlTfg6HZrY1L9kzYFCAejLGBEf0tqI9PDtB9
        ID8Xfxk0OBUj7+0X7kIALxadOwQRCA==
X-Google-Smtp-Source: AMrXdXsGfWxNDyM3OTM69PkQpKWlf+Q8e8sFq+wBdINdSP4ZSEaFhr/b8wKUQ/02qYgehItNwZvGIw==
X-Received: by 2002:a4a:e2da:0:b0:49f:8814:e387 with SMTP id l26-20020a4ae2da000000b0049f8814e387mr37093371oot.9.1673557353873;
        Thu, 12 Jan 2023 13:02:33 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m11-20020a056820034b00b004f219b998eesm3486486ooe.43.2023.01.12.13.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 13:02:33 -0800 (PST)
Received: (nullmailer pid 228721 invoked by uid 1000);
        Thu, 12 Jan 2023 21:02:31 -0000
Date:   Thu, 12 Jan 2023 15:02:31 -0600
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
Subject: Re: [PATCH v2 6/9] dt-bindings: interrupt-controller: Add RISC-V
 advanced PLIC
Message-ID: <20230112210231.GA214515-robh@kernel.org>
References: <20230103141409.772298-1-apatel@ventanamicro.com>
 <20230103141409.772298-7-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103141409.772298-7-apatel@ventanamicro.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 07:44:06PM +0530, Anup Patel wrote:
> We add DT bindings document for RISC-V advanced platform level
> interrupt controller (APLIC) defined by the RISC-V advanced
> interrupt architecture (AIA) specification.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../interrupt-controller/riscv,aplic.yaml     | 159 ++++++++++++++++++
>  1 file changed, 159 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
> new file mode 100644
> index 000000000000..b7f20aad72c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
> @@ -0,0 +1,159 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/riscv,aplic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V Advanced Platform Level Interrupt Controller (APLIC)
> +
> +maintainers:
> +  - Anup Patel <anup@brainfault.org>
> +
> +description:
> +  The RISC-V advanced interrupt architecture (AIA) defines an advanced
> +  platform level interrupt controller (APLIC) for handling wired interrupts
> +  in a RISC-V platform. The RISC-V AIA specification can be found at
> +  https://github.com/riscv/riscv-aia.
> +
> +  The RISC-V APLIC is implemented as hierarchical APLIC domains where all
> +  interrupt sources connect to the root domain which can further delegate
> +  interrupts to child domains. There is one device tree node for each APLIC
> +  domain.
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - riscv,qemu-aplic

Make 'qemu' the vendor.

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
> +      Given APLIC domain directly injects external interrupts to a set of
> +      RISC-V HARTS (or CPUs). Each node pointed to should be a riscv,cpu-intc
> +      node, which has a riscv node (i.e. RISC-V HART) as parent.
> +
> +  msi-parent:
> +    description:
> +      Given APLIC domain forwards wired interrupts as MSIs to a AIA incoming
> +      message signaled interrupt controller (IMSIC). This property should be
> +      considered only when the interrupts-extended property is absent.
> +
> +  riscv,num-sources:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 1023
> +    description:
> +      Specifies how many wired interrupts are supported by this APLIC domain.

We don't normally need to how many interrupts, why here?

> +
> +  riscv,children:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    minItems: 1
> +    maxItems: 1024
> +    items:
> +      maxItems: 1
> +    description:
> +      A list of child APLIC domains for the given APLIC domain. Each child
> +      APLIC domain is assigned child index in increasing order with the
> +      first child APLIC domain assigned child index 0. The APLIC domain
> +      child index is used by firmware to delegate interrupts from the
> +      given APLIC domain to a particular child APLIC domain.
> +
> +  riscv,delegate:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    minItems: 1
> +    maxItems: 1024
> +    items:
> +      items:
> +        - description: child APLIC domain phandle
> +        - description: first interrupt number (inclusive)
> +        - description: last interrupt number (inclusive)
> +    description:
> +      A interrupt delegation list where each entry is a triple consisting
> +      of child APLIC domain phandle, first interrupt number, and last
> +      interrupt number. The firmware will configure interrupt delegation
> +      registers based on interrupt delegation list.

The node's domain it delegating its interrupts to the child domain or 
the other way around? The interrupt numbers here are this domain's or 
the child's?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - riscv,num-sources
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    // Example 1 (APLIC domains directly injecting interrupt to HARTs):
> +
> +    aplic0: interrupt-controller@c000000 {
> +      compatible = "riscv,qemu-aplic", "riscv,aplic";
> +      interrupts-extended = <&cpu1_intc 11>,
> +                            <&cpu2_intc 11>,
> +                            <&cpu3_intc 11>,
> +                            <&cpu4_intc 11>;
> +      reg = <0xc000000 0x4080>;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +      riscv,num-sources = <63>;
> +      riscv,children = <&aplic1>, <&aplic2>;
> +      riscv,delegate = <&aplic1 1 63>;
> +    };
> +
> +    aplic1: interrupt-controller@d000000 {
> +      compatible = "riscv,qemu-aplic", "riscv,aplic";
> +      interrupts-extended = <&cpu1_intc 9>,
> +                            <&cpu2_intc 9>;
> +      reg = <0xd000000 0x4080>;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +      riscv,num-sources = <63>;
> +    };
> +
> +    aplic2: interrupt-controller@e000000 {
> +      compatible = "riscv,qemu-aplic", "riscv,aplic";
> +      interrupts-extended = <&cpu3_intc 9>,
> +                            <&cpu4_intc 9>;
> +      reg = <0xe000000 0x4080>;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +      riscv,num-sources = <63>;
> +    };
> +
> +  - |
> +    // Example 2 (APLIC domains forwarding interrupts as MSIs):
> +
> +    aplic3: interrupt-controller@c000000 {
> +      compatible = "riscv,qemu-aplic", "riscv,aplic";
> +      msi-parent = <&imsic_mlevel>;
> +      reg = <0xc000000 0x4000>;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +      riscv,num-sources = <63>;
> +      riscv,children = <&aplic4>;
> +      riscv,delegate = <&aplic4 1 63>;
> +    };
> +
> +    aplic4: interrupt-controller@d000000 {
> +      compatible = "riscv,qemu-aplic", "riscv,aplic";
> +      msi-parent = <&imsic_slevel>;
> +      reg = <0xd000000 0x4000>;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +      riscv,num-sources = <63>;
> +    };
> +...
> -- 
> 2.34.1
> 
