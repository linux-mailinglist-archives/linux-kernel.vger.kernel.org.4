Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53ADC60B371
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbiJXRFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbiJXREN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:04:13 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC437E324;
        Mon, 24 Oct 2022 08:40:03 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id z17so3630316qkj.8;
        Mon, 24 Oct 2022 08:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOUr8vKGqEWk39crx6gBwH6ieHL8arm1vSqANMxY3zA=;
        b=LvyIIQTXIEg/BA3CAYzOWGXMJjNCorfEsMLOX7fUS3VispZDJx7AhYlai9sTP/MaFU
         GIPYuh03VBGJ2K2atkA6yCOAhIc474EFMfyeuHFOBLp3Alsm1k66uDgYqRbkL4EYnOS+
         gk1e/P/9Uy8J0P53QX3as0/uo0bO2YaR+d/7/NJzZmm68KMfHDcDDLw6bNxideu2tfid
         rCbbKL1CKAlcFAd4P7CyzP1ShKcLNiS+N4vTnyUVhyey1RJ/W5/h+Iy9y5UQaivQvsnE
         2gm36k5ucsmgkZye9YwwXvvUH2CB3CFkR72FCCY8++n/r5j8Bcaf05FgWbC0hqd2LSDl
         F8yA==
X-Gm-Message-State: ACrzQf2fnB6D5UT6b2pDsmGcLrwnhk0n6uZULGreDZ4xpA4cj/V2BuzD
        OxDUCklL1GfHNBQ63KNRNslR7fJst1CeqQ==
X-Google-Smtp-Source: AMsMyM6V9GpFdBVsAvJFJvDpUUuxm7k92sCv6iAHVCdeIA89KNpPcu9pNesifpvhdJsyV0vpnqiBwg==
X-Received: by 2002:a05:620a:4310:b0:6ac:f9df:178d with SMTP id u16-20020a05620a431000b006acf9df178dmr23150286qko.773.1666619235241;
        Mon, 24 Oct 2022 06:47:15 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id cf17-20020a05622a401100b0039c7b9522ecsm12926068qtb.35.2022.10.24.06.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 06:47:14 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-36a4b86a0abso69897237b3.7;
        Mon, 24 Oct 2022 06:47:14 -0700 (PDT)
X-Received: by 2002:a0d:de43:0:b0:349:31bd:e8d5 with SMTP id
 h64-20020a0dde43000000b0034931bde8d5mr28384338ywe.283.1666619233755; Mon, 24
 Oct 2022 06:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221019220242.4746-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221019220242.4746-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221019220242.4746-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Oct 2022 15:47:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVVzUN1ScY4vh3d8=XvshOjc0C4G2duFRHSPms3S+2yeA@mail.gmail.com>
Message-ID: <CAMuHMdVVzUN1ScY4vh3d8=XvshOjc0C4G2duFRHSPms3S+2yeA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/2] dt-bindings: cache: r9a07g043f-l2-cache: Add
 DT binding documentation for L2 cache controller
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.co>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Thu, Oct 20, 2022 at 12:02 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add DT binding documentation for L2 cache controller found on RZ/Five SoC.
>
> The Renesas RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
> Single) from Andes. The AX45MP core has an L2 cache controller, this patch
> describes the L2 cache block.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

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

large

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

This is fixed here, but the driver accepts (and uses) whatever value specified?

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

According to Section 8.1.2 ("L2-Cache Prefetch"), this should be
[ 0, 2, 4, 8 ].

> +  andestech,tag-ram-ctl:
> +    description: Tag RAM output cycle. First tuple indicates output cycle and the
> +      second tuple indicates setup cycle.

Nit: to me it sounds more logical to have the setup cycle first.
See also the order in the comment in the driver code:

     /* tag RAM and data RAM setup and output cycle */

> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    items:
> +      - minimum: 0
> +        maximum: 2
> +      - minimum: 0
> +        maximum: 2
> +
> +  andestech,data-ram-ctl:
> +    description: Data RAM output cycle. First tuple indicates output cycle and the
> +      second tuple indicates setup cycle.

Likewise.

> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    items:
> +      - minimum: 0
> +        maximum: 2
> +      - minimum: 0
> +        maximum: 2

Do we really need these andestech-specific properties?
If yes, how much (if any) of this do we want to be handled by the boot
loader, and how much (if any) by Linux?
If Linux is responsible, we might have to boot with L2 disabled, right?

For ARM Cortex A15/A7, we also have arm,{data,tag}-latency properties
defined, but no DTS specifies them (my patches to add them on R-Car
Gen2 were rejected).  Note that this is different for e.g. older PL310.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
