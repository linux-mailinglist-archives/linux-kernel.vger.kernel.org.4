Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DE9636C5C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 22:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238191AbiKWV04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 16:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbiKWV0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 16:26:54 -0500
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697536338;
        Wed, 23 Nov 2022 13:26:53 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id p141so38308iod.6;
        Wed, 23 Nov 2022 13:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNNdoJeqYo/kComx1YbP9s6gKIBcu0yuJ+BzJcv/vyg=;
        b=bDDC+dPxJ95nTueXRll+SAoUQ1CzwVb7NC4mcIjTteNnR8A5gQAgbhNUOeb6Xu9EcT
         c14dfhq1yFIX6VPZLEisEO0CjfDRZoNF76byWZzg0fz5oAKoZTiYgCbA/2P4ZRh1ZDG0
         gs8BjF2A6bSdElj5F5nc9UmUCwdVrqanz1NS8dR1M9A0mzVIlGyeR0RQh48sbRf8K20V
         YbQMveyiyeku8zwn+XZsfIm/ICJ6h2g9X4rx2huZaMpnhX7ooAaKJwLQZJGE2KNOmLXG
         ZRVmvj5IK/qQfOPpK97zDNimqSzF3YlS7j5H7O6/tvjYr+34Cw5I9/DP2BuilAaV78H+
         wcMg==
X-Gm-Message-State: ANoB5pnn1sY2aB97336LsJbEnjw08g+x4N8JsH4jTCUoeOCpxp7NOldh
        yVvgjuel3fzCSh0TKV/zow==
X-Google-Smtp-Source: AA0mqf4ZNN23EtyXT/bNptvcVXYi5TbrYsSAvHkTpzabpbJp2wXWE7hAAlPOuAea/jH9BstfCC5q0Q==
X-Received: by 2002:a6b:c411:0:b0:6dd:dac4:7d4d with SMTP id y17-20020a6bc411000000b006dddac47d4dmr6326049ioa.208.1669238812586;
        Wed, 23 Nov 2022 13:26:52 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id r24-20020a02b118000000b00363b7cec211sm6383911jah.135.2022.11.23.13.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 13:26:52 -0800 (PST)
Received: (nullmailer pid 2523801 invoked by uid 1000);
        Wed, 23 Nov 2022 21:26:51 -0000
Date:   Wed, 23 Nov 2022 15:26:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-lgm-soc@maxlinear.com,
        andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v4 1/4] dt-bindings: x86: apic: Convert Intel's APIC
 bindings to YAML schema
Message-ID: <20221123212651.GA2519263-robh@kernel.org>
References: <20221123100850.22969-1-rtanwar@maxlinear.com>
 <20221123100850.22969-2-rtanwar@maxlinear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123100850.22969-2-rtanwar@maxlinear.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 06:08:47PM +0800, Rahul Tanwar wrote:
> Intel's APIC family of interrupt controllers support local APIC
> (lapic) & I/O APIC (ioapic). Convert existing bindings for lapic
> & ioapic from text to YAML schema. Separate lapic & ioapic schemas.
> Addditionally, add description which was missing in text file and
> add few more required standard properties which were also missing
> in text file.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
> ---
>  .../intel,ce4100-ioapic.txt                   | 26 --------
>  .../intel,ce4100-ioapic.yaml                  | 62 +++++++++++++++++++
>  .../intel,ce4100-lapic.yaml                   | 49 +++++++++++++++
>  3 files changed, 111 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.yaml
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.txt b/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.txt
> deleted file mode 100644
> index 7d19f494f19a..000000000000
> --- a/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.txt
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -Interrupt chips
> ----------------
> -
> -* Intel I/O Advanced Programmable Interrupt Controller (IO APIC)
> -
> -  Required properties:
> -  --------------------
> -     compatible = "intel,ce4100-ioapic";
> -     #interrupt-cells = <2>;
> -
> -  Device's interrupt property:
> -
> -     interrupts = <P S>;
> -
> -  The first number (P) represents the interrupt pin which is wired to the
> -  IO APIC. The second number (S) represents the sense of interrupt which
> -  should be configured and can be one of:
> -    0 - Edge Rising
> -    1 - Level Low
> -    2 - Level High
> -    3 - Edge Falling
> -
> -* Local APIC
> -  Required property:
> -
> -     compatible = "intel,ce4100-lapic";
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.yaml b/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.yaml
> new file mode 100644
> index 000000000000..25d549220c2a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/interrupt-controller/intel,ce4100-ioapic.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Intel I/O Advanced Programmable Interrupt Controller (IO APIC)
> +
> +maintainers:
> +  - Rahul Tanwar <rtanwar@maxlinear.com>
> +
> +

One blank line.

> +description: |
> +  Intel's Advanced Programmable Interrupt Controller (APIC) is a
> +  family of interrupt controllers. The APIC is a split
> +  architecture design, with a local component (LAPIC) integrated
> +  into the processor itself and an external I/O APIC. Local APIC
> +  (lapic) receives interrupts from the processor's interrupt pins,
> +  from internal sources and from an external I/O APIC (ioapic).
> +  And it sends these to the processor core for handling.
> +  See [1] Chapter 8 for more details.
> +
> +  Many of the Intel's generic devices like hpet, ioapic, lapic have
> +  the ce4100 name in their compatible property names because they
> +  first appeared in CE4100 SoC.
> +
> +  This schema defines bindings for I/O APIC interrupt controller.
> +
> +  [1] https://pdos.csail.mit.edu/6.828/2008/readings/ia32/IA32-3A.pdf
> +
> +properties:
> +  compatible:
> +    const: intel,ce4100-ioapic
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ioapic1: interrupt-controller@fec00000 {
> +        compatible = "intel,ce4100-ioapic";
> +        reg = <0xfec00000 0x1000>;
> +        #interrupt-cells = <2>;
> +        #address-cells = <0>;
> +        interrupt-controller;
> +    };
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.yaml b/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.yaml
> new file mode 100644
> index 000000000000..88f320ef4616
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/interrupt-controller/intel,ce4100-lapic.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Intel Local Advanced Programmable Interrupt Controller (LAPIC)
> +
> +maintainers:
> +  - Rahul Tanwar <rtanwar@maxlinear.com>
> +
> +
> +description: |
> +  Intel's Advanced Programmable Interrupt Controller (APIC) is a
> +  family of interrupt controllers. The APIC is a split
> +  architecture design, with a local component (LAPIC) integrated
> +  into the processor itself and an external I/O APIC. Local APIC
> +  (lapic) receives interrupts from the processor's interrupt pins,
> +  from internal sources and from an external I/O APIC (ioapic).
> +  And it sends these to the processor core for handling.
> +  See [1] Chapter 8 for more details.
> +
> +  Many of the Intel's generic devices like hpet, ioapic, lapic have
> +  the ce4100 name in their compatible property names because they
> +  first appeared in CE4100 SoC.
> +
> +  This schema defines bindings for local APIC interrupt controller.
> +
> +  [1] https://pdos.csail.mit.edu/6.828/2008/readings/ia32/IA32-3A.pdf
> +
> +properties:
> +  compatible:
> +    const: intel,ce4100-lapic
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    lapic0: interrupt-controller@fee00000 {
> +        compatible = "intel,ce4100-lapic";
> +        reg = <0xfee00000 0x1000>;

What about interrupt-controller and #interrupt-cells properties?

> +    };
> -- 
> 2.17.1
> 
> 
