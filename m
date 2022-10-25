Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD4160D796
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiJYW7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 18:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbiJYW7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:59:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B537CA899;
        Tue, 25 Oct 2022 15:59:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z97so38676265ede.8;
        Tue, 25 Oct 2022 15:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=udy479ObjWYY5CFX9ZP0gGul3ib61HsEaOXglQsZUR8=;
        b=kRiPEyk2E7S0EkCO/J07RPKhy/NhdmvHvaLaff/l5T/RAR1qGg59zpFrXUDOU/m0DR
         BSXuRAzPYAw49Pg4UBKrS50JHKHe2GrUwXFH4LWAa9HhLPtCkatZdMXA0eVwaZujnCNW
         J+Q92e1VnvtpKgkItdw1G1zOcyskidwZccW/lQhhwwFKef35yL6BnWEUm7Q4oLjtxStg
         NKft7Vm8Gedm1bSS72iIRJSaLReOdpt3RGtE4tTBaofRTFTfusTdE5spkdWAJYTy64zy
         eDftWn/qWifn7P5a+uvUuOi/LNqLyH+x0t31WApUmVZxSc7Q6iLJd5o7lbkrKjq9Og2N
         GIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udy479ObjWYY5CFX9ZP0gGul3ib61HsEaOXglQsZUR8=;
        b=CHJypcTbgoMGt6GTBdy8n3vK0VwwMf++3wf8bcufm0L6GYFUDlFz/lvqL6G1e//azB
         p9F/nOyS+unOm1emw4HwLevp51mnZ4us8jMnmzRCNSI/sqyd5z1V9w79ikctz8LwF8aQ
         baZYhXygfBQadD12CX9tJJLBxMNBgMYHYoqzbTkLKTb06TLZpWLbbJZh/dpiy8DV8k+v
         iuuHQsrTavBm6SZdT/ZFj3qIxQW1ImSWcGozLdwfsops1yS5y/m2lo1Us5qZbksagn5b
         3gg5ekqL1/nxvjuo+zHxSZB+RyH6lFM5cU3lAS3zV4xHULC1DaVQYdyLmeOmrfwg7/cB
         a7Jg==
X-Gm-Message-State: ACrzQf2sLSuX8s4lQJurshoeCSW/AMZH+eAda/3URAQKukSavAGhjZ/I
        zCnU99SkSNkacbU+CftMv4Y/i4dw6fPG3yYZv7M=
X-Google-Smtp-Source: AMsMyM6qiQz41DTYKHnjjT5v9wPef/t11I6GH1qwMNjA79NgdVe3Lov+5CqFbMmrBeZBknHbcrg0WSUcZOo9RqPZSNw=
X-Received: by 2002:a05:6402:5485:b0:459:147a:d902 with SMTP id
 fg5-20020a056402548500b00459147ad902mr39292630edb.263.1666738753824; Tue, 25
 Oct 2022 15:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221019220242.4746-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221019220242.4746-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVVzUN1ScY4vh3d8=XvshOjc0C4G2duFRHSPms3S+2yeA@mail.gmail.com>
In-Reply-To: <CAMuHMdVVzUN1ScY4vh3d8=XvshOjc0C4G2duFRHSPms3S+2yeA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 25 Oct 2022 23:58:46 +0100
Message-ID: <CA+V-a8vAf93uyD6o7vEKjb1ghrWh9iY+LDGkgz=e149MdoSZnQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/2] dt-bindings: cache: r9a07g043f-l2-cache: Add
 DT binding documentation for L2 cache controller
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the review.

On Mon, Oct 24, 2022 at 2:47 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Oct 20, 2022 at 12:02 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add DT binding documentation for L2 cache controller found on RZ/Five SoC.
> >
> > The Renesas RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
> > Single) from Andes. The AX45MP core has an L2 cache controller, this patch
> > describes the L2 cache block.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
> > @@ -0,0 +1,125 @@
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
> > +  a larger amount of cache line entries and reasonable access delays. The L2C
>
> large
>
OK.

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
>
> This is fixed here, but the driver accepts (and uses) whatever value specified?
>
Right, I'll add a check in the driver.

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
> > +    description: Optional array of memory regions to be set as non-cacheable
> > +                 bufferable regions which will be setup in the PMA.
> > +
> > +  andestech,inst-prefetch:
> > +    description: Instruction prefetch depth
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [ 0, 1, 2, 3 ]
> > +
> > +  andestech,data-prefetch:
> > +    description: Data prefetch depth
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [ 0, 1, 2, 3 ]
>
> According to Section 8.1.2 ("L2-Cache Prefetch"), this should be
> [ 0, 2, 4, 8 ].
>
I was directly fetching the value, but as you pointed out I'll switch
to the request count and convert the value accordingly in the driver.

> > +  andestech,tag-ram-ctl:
> > +    description: Tag RAM output cycle. First tuple indicates output cycle and the
> > +      second tuple indicates setup cycle.
>
> Nit: to me it sounds more logical to have the setup cycle first.
> See also the order in the comment in the driver code:
>
>      /* tag RAM and data RAM setup and output cycle */
>
> > +    $ref: /schemas/types.yaml#/definitions/uint8-array
> > +    items:
> > +      - minimum: 0
> > +        maximum: 2
> > +      - minimum: 0
> > +        maximum: 2
> > +
> > +  andestech,data-ram-ctl:
> > +    description: Data RAM output cycle. First tuple indicates output cycle and the
> > +      second tuple indicates setup cycle.
>
> Likewise.
>
> > +    $ref: /schemas/types.yaml#/definitions/uint8-array
> > +    items:
> > +      - minimum: 0
> > +        maximum: 2
> > +      - minimum: 0
> > +        maximum: 2
>
> Do we really need these andestech-specific properties?
> If yes, how much (if any) of this do we want to be handled by the boot
> loader, and how much (if any) by Linux?
> If Linux is responsible, we might have to boot with L2 disabled, right?
>
> For ARM Cortex A15/A7, we also have arm,{data,tag}-latency properties
> defined, but no DTS specifies them (my patches to add them on R-Car
> Gen2 were rejected).  Note that this is different for e.g. older PL310.
>
OK, I think we can get rid of the below properties completely from
here and have them configured earlier (ie in u-boot).

       -   andestech,inst-prefetch
       -   andestech,data-prefetch
       -   andestech,tag-ram-ctl
       -   andestech,data-ram-ctl

Cheers,
Prabhakar
