Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97ED638799
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiKYKei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiKYKee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:34:34 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36D7421BA;
        Fri, 25 Nov 2022 02:34:32 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x102so5873921ede.0;
        Fri, 25 Nov 2022 02:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEpkuQXuvOiX23moyFDnFxgEP2HnqxVQhoNAx7KzG+8=;
        b=g1drplUkwDolDWizuLqHCWwBVIFGtE+j/n5Lv8jrj37Q8V/JRxyrr1uYt74+0IYE94
         tR9HaIOul/fQMbrNbfwHfiXpA7au8Eij7h2sLqEkXI9qrKnCCTuApCnwFgDmw50zkCRS
         hjnG5nMXWkEqYVxce8AsTogPE20iIRc/PPa+zBx8bwZbZo7m2QbL/blE81mphmiLnMr5
         OxTZIneoDveMDLoaiz8fxoK/S41clLqxsOxJ+ztYpT1GVGriwc9MXjW+Q/ls9ZJl1xtq
         M8PDUfwJ8DLHVyQiBY4J8OC+sM/ffE2bYWJO5HYsVLcenkKxOsjHzu2KfzIMxrKd4AjO
         jy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEpkuQXuvOiX23moyFDnFxgEP2HnqxVQhoNAx7KzG+8=;
        b=4ElweRLE693ghiacl2y+/47wdBDq8n6k4dnQM48lAGwtA+nVDg1YopgqqIRmDStlbQ
         mtbYNgo9sZUl9U37DcmKa99RaEc+6oFhHLBUOW/F5K3FnTj8zmbYWPUhCLfSVU/a82Yl
         TflWn2isQvqoOpCv6d3HxumpkNLmQEZNy/f+rpsR4ZrG4hckUEk/p9CS6Q7lwjsCQ0XI
         8poXLj706DXDDw2H6KdSLcTwHo8njCiWQbuiAfGN/ElsrzcqWjuQkdIAOjhhi5R4XgSS
         PadtD55brPhsfI7jTtX4fYQrtAyjljFsIGvpwLx/0rjkwxyLi3YCan54PO8BsySmfGja
         uUqw==
X-Gm-Message-State: ANoB5pkpTj3ZcATGtVG+dMz7mJZ3oB91shChy+09vRGc5a/irkoVKNKZ
        68g2oIdGQ8JIXSawQ8K0UYdemiptRjzE+IWBois=
X-Google-Smtp-Source: AA0mqf5HrlCFHGWi4MUGdrjcLpjKY5UhP4x39kSPBoAH0e6ijoZRD3oKw6heUDDA+5j983c7sUpuxvy2UVbKyB+BAAE=
X-Received: by 2002:aa7:d156:0:b0:468:51b0:295 with SMTP id
 r22-20020aa7d156000000b0046851b00295mr34445349edo.319.1669372471204; Fri, 25
 Nov 2022 02:34:31 -0800 (PST)
MIME-Version: 1.0
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-7-prabhakar.mahadev-lad.rj@bp.renesas.com> <70d1bfde-f57f-1741-08d3-23e362793595@linaro.org>
In-Reply-To: <70d1bfde-f57f-1741-08d3-23e362793595@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 25 Nov 2022 10:34:04 +0000
Message-ID: <CA+V-a8s2awLp=YvbhA1Ohe500Oh1easLUcG9V4_FWov7Pf2i6g@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] dt-bindings: cache: r9a07g043f-l2-cache: Add DT
 binding documentation for L2 cache controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for the review.

On Fri, Nov 25, 2022 at 8:16 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 24/11/2022 18:22, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add DT binding documentation for L2 cache controller found on RZ/Five SoC.
> >
> > The Renesas RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
> > Single) from Andes. The AX45MP core has an L2 cache controller, this patch
> > describes the L2 cache block.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > RFC v3 -> v4
> > * Dropped l2 cache configuration parameters
> > * s/larger/large
> > * Added minItems/maxItems for andestech,pma-regions
> > ---
> >  .../cache/andestech,ax45mp-cache.yaml         | 93 +++++++++++++++++++
> >  .../cache/andestech,ax45mp-cache.h            | 38 ++++++++
> >  2 files changed, 131 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
> >  create mode 100644 include/dt-bindings/cache/andestech,ax45mp-cache.h
> >
> > diff --git a/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
> > new file mode 100644
> > index 000000000000..bf255b177d0a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
> > @@ -0,0 +1,93 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright (C) 2022 Renesas Electronics Corp.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/cache/andestech,ax45mp-cache.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Andestech AX45MP L2 Cache Controller
> > +
> > +maintainers:
> > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > +
> > +description:
> > +  A level-2 cache (L2C) is used to improve the system performance by providing
> > +  a large amount of cache line entries and reasonable access delays. The L2C
> > +  is shared between cores, and a non-inclusive non-exclusive policy is used.
> > +
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - andestech,ax45mp-cache
> > +
> > +  required:
> > +    - compatible
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: andestech,ax45mp-cache
> > +      - const: cache
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  cache-line-size:
> > +    const: 64
> > +
> > +  cache-level:
> > +    const: 2
> > +
> > +  cache-sets:
> > +    const: 1024
> > +
> > +  cache-size:
> > +    enum: [131072, 262144, 524288, 1048576, 2097152]
> > +
> > +  cache-unified: true
> > +
> > +  next-level-cache: true
> > +
> > +  andestech,pma-regions:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +    minItems: 1
> > +    maxItems: 16
> > +    items:
> > +      minItems: 3
> > +      maxItems: 3
>
> Instead:
> items:
>   items:
>     - description: Explain
>     - description: what is
>     - description: here
>
Ok, I will do that in the next version.

- description: Memory region offset to be set up in the PMA
- description: Size of the PMA region
- description: Flags indicating how the region should be set up in the
PMA. (ETYP[1:0] | MTYP[5:2]) use the macros
defined in include/dt-bindings/cache/andestech,ax45mp-cache.h.

> > +    description: Optional array of memory regions to be set in the PMA.
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - cache-line-size
> > +  - cache-level
> > +  - cache-sets
> > +  - cache-size
> > +  - cache-unified
> > +  - interrupts
> > +  - reg
>
> Keep the same order as properties appear in the "properties:"
>
Agreed, will do.


> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/cache/andestech,ax45mp-cache.h>
> > +
> > +    cache-controller@2010000 {
> > +        reg = <0x13400000 0x100000>;
> > +        compatible = "andestech,ax45mp-cache", "cache";
> > +        interrupts = <508 IRQ_TYPE_LEVEL_HIGH>;
> > +        cache-line-size = <64>;
> > +        cache-level = <2>;
> > +        cache-sets = <1024>;
> > +        cache-size = <262144>;
> > +        cache-unified;
> > +        andestech,pma-regions = <0x58000000 0x08000000
> > +                                 (AX45MP_PMACFG_ETYP_NAPOT | AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF)>;
> > +    };
> > diff --git a/include/dt-bindings/cache/andestech,ax45mp-cache.h b/include/dt-bindings/cache/andestech,ax45mp-cache.h
> > new file mode 100644
> > index 000000000000..aa1cad24075d
> > --- /dev/null
> > +++ b/include/dt-bindings/cache/andestech,ax45mp-cache.h
> > @@ -0,0 +1,38 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +/*
> > + * This header provides constants for Andes AX45MP PMA configuration
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corp.
> > + */
> > +
> > +#ifndef __DT_BINDINGS_ANDESTECH_AX45MP_CACHE_H
> > +#define __DT_BINDINGS_ANDESTECH_AX45MP_CACHE_H
> > +
> > +/* OFF: PMA entry is disabled */
> > +#define AX45MP_PMACFG_ETYP_DISABLED                  0
> > +/* Naturally aligned power of 2 region */
> > +#define AX45MP_PMACFG_ETYP_NAPOT                     3
> > +
> > +/* Device, Non-bufferable */
> > +#define AX45MP_PMACFG_MTYP_DEV_NON_BUF                       (0 << 2)
> > +/* Device, bufferable */
> > +#define AX45MP_PMACFG_MTYP_DEV_BUF                   (1 << 2)
> > +/* Memory, Non-cacheable, Non-bufferable */
> > +#define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_NON_BUF     (2 << 2)
> > +/* Memory, Non-cacheable, Bufferable */
> > +#define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF         (3 << 2)
>
> What are all these? They don't look like flags, because 3 = 1 | 2...
> they don't look like constants, because we do not use shifts in
> constants. Are these some register values? I also do not see the header
> being used in the code, so why having a bindings header if it is not
> used (DTS is not usage...)?
>
These are register bit values for the MTYP[5:2] field. The DTS example
in the binding doc (above) uses these macros. I haven't included the
DTS/I patches with this patchset yet do think I should?

Cheers,
Prabhakar
