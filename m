Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5262863850C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiKYIQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiKYIQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:16:15 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936B8303DA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:16:13 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b3so5758790lfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N+VqwQA0ACSOHUN95caT7MOy4QsSBG574lC0jyV4pT8=;
        b=m0mzFThbUlv8y9i5L6R9m6xTXf/K9T8scg4/1yMpDP0SG8fMA3utdjWye6zPasnDsG
         PvA4m5+sfvYm59Tyk0G3lUOd2YtTyRG8hKeYbQj+M19+OFSjbvhm5yT4nRTEb6dYXcYD
         sihPMgJn2RNfHzv4eUiZGZDDx77+IajNNLSL8LFVw8mkMWPsH2Izq+5lmSrFLS7+06AQ
         jZksOItOh5A7nngow+DFdTLG2YbJZg61yhnNlGeEBylpy7GpJSxHsAs9mcwZl27O5R0m
         dABAdbOk0WtBjXmiqYt+E5xCJDlMtmDJr1JpYXm5Dm5lzS+r7ghQgiyrXl1ap+3EJP3H
         jFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N+VqwQA0ACSOHUN95caT7MOy4QsSBG574lC0jyV4pT8=;
        b=bCEcPrUbM4iI/aSKx3Bqfot36xKap9hlkUiqx81xTe3bFdHdmDkILpHzKx8OdCJkAH
         mcWyvnVrhyGxvxV1i53gGq8lIHh4R1EnpjcA9XX/6zbwsViQM18GkDKxk8iAUhvNQ62I
         tsmdNonxn25XAPweJOFIcgbo1xcrBlcK5nv4+Cg94Ty0HVxxWB6QOl9boxzchZ3DJrBL
         TiVUsE9/v55f34McQrLna79BED4gKlhY1lXsB0eCm0uGsfKyNzLcbIHBeIrkwEC3A6UP
         rrXc4xi9Z38n196MTWpAPGnQWU8ATobNBoR2cCN4KR4u9LhLuch1n/PsqvX1B5TVtiNb
         LrZw==
X-Gm-Message-State: ANoB5pnNpQpYpjdPFnLKK803RjTdQM0vZP+XO34mz9TR1VqKz2PfIqCn
        UpKidrQWLoTasF6NLxYTaskuTQ==
X-Google-Smtp-Source: AA0mqf4iaewyz6Uvj5Y0H3Db+e4I6RPK2U+Ekg8QFcNrOfYlB2u1eoC7Fz9f7pu7oXoec1WtyRkI3w==
X-Received: by 2002:ac2:5f6c:0:b0:4a2:bca5:76bc with SMTP id c12-20020ac25f6c000000b004a2bca576bcmr6118153lfc.123.1669364171902;
        Fri, 25 Nov 2022 00:16:11 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m4-20020a056512014400b004aa543f3748sm41444lfo.130.2022.11.25.00.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 00:16:11 -0800 (PST)
Message-ID: <70d1bfde-f57f-1741-08d3-23e362793595@linaro.org>
Date:   Fri, 25 Nov 2022 09:16:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 6/7] dt-bindings: cache: r9a07g043f-l2-cache: Add DT
 binding documentation for L2 cache controller
Content-Language: en-US
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221124172207.153718-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2022 18:22, Prabhakar wrote:
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
> RFC v3 -> v4
> * Dropped l2 cache configuration parameters
> * s/larger/large
> * Added minItems/maxItems for andestech,pma-regions
> ---
>  .../cache/andestech,ax45mp-cache.yaml         | 93 +++++++++++++++++++
>  .../cache/andestech,ax45mp-cache.h            | 38 ++++++++
>  2 files changed, 131 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
>  create mode 100644 include/dt-bindings/cache/andestech,ax45mp-cache.h
> 
> diff --git a/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
> new file mode 100644
> index 000000000000..bf255b177d0a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
> @@ -0,0 +1,93 @@
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
> +  a large amount of cache line entries and reasonable access delays. The L2C
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
> +    items:
> +      minItems: 3
> +      maxItems: 3

Instead:
items:
  items:
    - description: Explain
    - description: what is
    - description: here

> +    description: Optional array of memory regions to be set in the PMA.
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

Keep the same order as properties appear in the "properties:"

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

What are all these? They don't look like flags, because 3 = 1 | 2...
they don't look like constants, because we do not use shifts in
constants. Are these some register values? I also do not see the header
being used in the code, so why having a bindings header if it is not
used (DTS is not usage...)?


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

Best regards,
Krzysztof

