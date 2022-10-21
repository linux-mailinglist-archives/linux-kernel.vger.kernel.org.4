Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2EA606D6B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiJUCKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiJUCKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:10:08 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFBDD57D9;
        Thu, 20 Oct 2022 19:10:07 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-13af2d12469so1824515fac.13;
        Thu, 20 Oct 2022 19:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3gPdPwM5JXUY46ySF95882khroatjgZybGKy2kbf8k=;
        b=BEPWE/QYHe6VyXsOoVLx+nChxbZSTowGYxLcj0vNEHapAgftARw85+fSJbETKs8zAC
         tEkMdJCPIB0vQZq/nqjJ3NHgMRixVq3t+I/J1FbFQ32K2O+9soeiQeQ5s1O/ojgbORgY
         7mTJC5tgWFA1VSvnAuJ9N/MUluEPVWrAye/G+3QPuvPGGTWiawKVtknGr0MFr5O6Qdr3
         vCZBjg8jXwucXJva6pb+8yKCDUcrei8l9K5tjOucyHituhu2A6sb6puhSXRs67egYDuY
         3KVZMTpqKUbAPhIH9N2mdZesI/0JYHNpewSrCrkiAqwY3vUK9BX+sXbjYoqTemIXfbfv
         dRsg==
X-Gm-Message-State: ACrzQf2P+8bA4zoqspd2oXhmlmOvPqn6xrCh3rSlzfVlTT9M2iPgURwa
        s/9qzcRJrN6E7q8Bgd8Dvg==
X-Google-Smtp-Source: AMsMyM66J0lwPobWTLFAIZsIIR66ZF3b9NunC8s3qZPusDH17D3YlnOCjJacNXrwExoPRa+m6QQ8Nw==
X-Received: by 2002:a05:6870:c59d:b0:12c:25bc:f205 with SMTP id ba29-20020a056870c59d00b0012c25bcf205mr10461481oab.177.1666318205358;
        Thu, 20 Oct 2022 19:10:05 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 42-20020a9d02ad000000b0066194e0e1casm538169otl.75.2022.10.20.19.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 19:10:04 -0700 (PDT)
Received: (nullmailer pid 2180682 invoked by uid 1000);
        Fri, 21 Oct 2022 02:10:06 -0000
Date:   Thu, 20 Oct 2022 21:10:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.co>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [RFC PATCH v3 1/2] dt-bindings: cache: r9a07g043f-l2-cache: Add
 DT binding documentation for L2 cache controller
Message-ID: <20221021021006.GA2171731-robh@kernel.org>
References: <20221019220242.4746-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221019220242.4746-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019220242.4746-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 11:02:41PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Add DT binding documentation for L2 cache controller found on RZ/Five SoC.
> 
> The Renesas RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
> Single) from Andes. The AX45MP core has an L2 cache controller, this patch
> describes the L2 cache block.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../cache/andestech,ax45mp-cache.yaml         | 125 ++++++++++++++++++
>  .../cache/andestech,ax45mp-cache.h            |  38 ++++++
>  2 files changed, 163 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
>  create mode 100644 include/dt-bindings/cache/andestech,ax45mp-cache.h
> 
> diff --git a/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
> new file mode 100644
> index 000000000000..4c86a15bda5f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2022 Renesas Electronics Corp.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/cache/andestech,ax45mp-cache.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Andestech AX45MP L2 Cache Controller
> +
> +maintainers:
> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> +
> +description:
> +  A level-2 cache (L2C) is used to improve the system performance by providing
> +  a larger amount of cache line entries and reasonable access delays. The L2C
> +  is shared between cores, and a non-inclusive non-exclusive policy is used.
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - andestech,ax45mp-cache
> +
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: andestech,ax45mp-cache
> +      - const: cache
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  cache-line-size:
> +    const: 64
> +
> +  cache-level:
> +    const: 2
> +
> +  cache-sets:
> +    const: 1024
> +
> +  cache-size:
> +    enum: [131072, 262144, 524288, 1048576, 2097152]
> +
> +  cache-unified: true
> +
> +  next-level-cache: true
> +
> +  andestech,pma-regions:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    minItems: 1
> +    maxItems: 16

What is the inner dimension of the matrix?

items:
  minItems: ?
  maxItems: ?

> +    description: Optional array of memory regions to be set as non-cacheable
> +                 bufferable regions which will be setup in the PMA.
> +
> +  andestech,inst-prefetch:
> +    description: Instruction prefetch depth
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1, 2, 3 ]
> +
> +  andestech,data-prefetch:
> +    description: Data prefetch depth
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1, 2, 3 ]
> +
> +  andestech,tag-ram-ctl:
> +    description: Tag RAM output cycle. First tuple indicates output cycle and the
> +      second tuple indicates setup cycle.
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    items:
> +      - minimum: 0
> +        maximum: 2
> +      - minimum: 0
> +        maximum: 2

maxItems: 2
items:
  maximum: 2

'items' without the '-' applies to all items.

And the minimum is already 0.

> +
> +  andestech,data-ram-ctl:
> +    description: Data RAM output cycle. First tuple indicates output cycle and the
> +      second tuple indicates setup cycle.
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    items:
> +      - minimum: 0
> +        maximum: 2
> +      - minimum: 0
> +        maximum: 2

Same here.

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - cache-line-size
> +  - cache-level
> +  - cache-sets
> +  - cache-size
> +  - cache-unified
> +  - interrupts
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/cache/andestech,ax45mp-cache.h>
> +
> +    cache-controller@2010000 {
> +        reg = <0x13400000 0x100000>;
> +        compatible = "andestech,ax45mp-cache", "cache";
> +        interrupts = <508 IRQ_TYPE_LEVEL_HIGH>;
> +        cache-line-size = <64>;
> +        cache-level = <2>;
> +        cache-sets = <1024>;
> +        cache-size = <262144>;
> +        cache-unified;
> +        andestech,pma-regions = <0x58000000 0x08000000
> +                                 (AX45MP_PMACFG_ETYP_NAPOT | AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF)>;
> +        andestech,inst-prefetch = <0x3>;
> +        andestech,data-prefetch = <0x3>;
> +        andestech,tag-ram-ctl = /bits/ 8 <0x1 0x0>;
> +        andestech,data-ram-ctl = /bits/ 8 <0x1 0x0>;
> +    };
> diff --git a/include/dt-bindings/cache/andestech,ax45mp-cache.h b/include/dt-bindings/cache/andestech,ax45mp-cache.h
> new file mode 100644
> index 000000000000..aa1cad24075d
> --- /dev/null
> +++ b/include/dt-bindings/cache/andestech,ax45mp-cache.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * This header provides constants for Andes AX45MP PMA configuration
> + *
> + * Copyright (C) 2022 Renesas Electronics Corp.
> + */
> +
> +#ifndef __DT_BINDINGS_ANDESTECH_AX45MP_CACHE_H
> +#define __DT_BINDINGS_ANDESTECH_AX45MP_CACHE_H
> +
> +/* OFF: PMA entry is disabled */
> +#define AX45MP_PMACFG_ETYP_DISABLED			0
> +/* Naturally aligned power of 2 region */
> +#define AX45MP_PMACFG_ETYP_NAPOT			3
> +
> +/* Device, Non-bufferable */
> +#define AX45MP_PMACFG_MTYP_DEV_NON_BUF			(0 << 2)
> +/* Device, bufferable */
> +#define AX45MP_PMACFG_MTYP_DEV_BUF			(1 << 2)
> +/* Memory, Non-cacheable, Non-bufferable */
> +#define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_NON_BUF	(2 << 2)
> +/* Memory, Non-cacheable, Bufferable */
> +#define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF		(3 << 2)
> +/* Memory, Write-back, No-allocate */
> +#define AX45MP_PMACFG_MTYP_MEM_WB_NA			(8 << 2)
> +/* Memory, Write-back, Read-allocate */
> +#define AX45MP_PMACFG_MTYP_MEM_WB_RA			(9 << 2)
> +/* Memory, Write-back, Write-allocate */
> +#define AX45MP_PMACFG_MTYP_MEM_WB_WA			(10 << 2)
> +/* Memory, Write-back, Read and Write-allocate */
> +#define AX45MP_PMACFG_MTYP_MEM_WB_R_WA			(11 << 2)
> +
> +/* AMO instructions are supported */
> +#define AX45MP_PMACFG_NAMO_AMO_SUPPORT			(0 << 6)
> +/* AMO instructions are not supported */
> +#define AX45MP_PMACFG_NAMO_AMO_NO_SUPPORT		(1 << 6)
> +
> +#endif /* __DT_BINDINGS_ANDESTECH_AX45MP_CACHE_H */
> -- 
> 2.25.1
> 
> 
