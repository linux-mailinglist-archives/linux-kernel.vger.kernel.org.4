Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F47F60815B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 00:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiJUWNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 18:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJUWNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:13:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4360D2441B8;
        Fri, 21 Oct 2022 15:13:10 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id m15so10816602edb.13;
        Fri, 21 Oct 2022 15:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hjvmw72+jg+DsIKSh1utr1OBPgBsXbl/oMeJG09/SV0=;
        b=lVVznKdsNy9DoOtyaoNzOXvV+CA4XIHhe12oB2nxluu6+Zn74jmBrt7IhVlAiNOC6r
         THKSgsfUT/c7HU1e2i6Ps5KOPemnDoZ00hIyZfW5cWEgSEV2+Q0+vjDegLFO3iOINYtb
         3JPDos5qggIJQbUu/CLIn3eP079shfr1AyzE16M4S2FkEbDkpnGIJ49NYCcWjO5R5t95
         ydEyWOrKnJwsM6qg7pXcQjWv51K/+it5COoTHb5gLE49isEWGrSd353nXxQr3joHNqIV
         Eb5LWoczMe3HYAbxlzKccxL/72mrvyAZMMEoiflxOVddfHRNicbghk0sITjxvTrrw04Q
         cRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hjvmw72+jg+DsIKSh1utr1OBPgBsXbl/oMeJG09/SV0=;
        b=zsp8jKJLaoZJrSzpqfqci7hhyjl5FJ//2jZQ6rU0mj1hova8yIwTQjedb5q0isnZwk
         Xlu/dTU0RgyG4DOLZTLEBXisMhCY1VgtL+u2jingmz2ybSHoH/M7tEzdqxoL75DHMy5l
         0NHo7aakGKLR4AnbIrFcTCTi9/AWdiFIj+hVF5lkeRF2+9yuFu3lF02lbumx2F+ke0xf
         LbFT5Ii0n8U2+xkbCHM63vb0q8gNnRYgFH9+9YK098Bfn6qT2T4f85eaw++zb4XQMfYq
         BE3BmY4XWttek4gT+YeGD1VHVpETPlVjLmpbkOAkdZR+57HXoNgWNECqqXcpEL6X8IHR
         8keg==
X-Gm-Message-State: ACrzQf0p/e2RY/8PedpezVVxvkoO0Nb4OjRgAtXuWtwdoPYWwWGpA05P
        0ZCtton6JWwAnvvq97+J4bZxYXTJSJ0kJ1E9+e0=
X-Google-Smtp-Source: AMsMyM7tVViOUvuari02fIONQYzlg8jdd0EECyRiJpb3iJ/LEjcS03V19gkGHtZgK+gVX/2RKWfxEi7jOsdCA9Xs4gM=
X-Received: by 2002:a17:906:5a4b:b0:78d:4e5a:d101 with SMTP id
 my11-20020a1709065a4b00b0078d4e5ad101mr16967374ejc.196.1666390388943; Fri, 21
 Oct 2022 15:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221019220242.4746-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221019220242.4746-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221021021006.GA2171731-robh@kernel.org>
In-Reply-To: <20221021021006.GA2171731-robh@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 21 Oct 2022 23:12:42 +0100
Message-ID: <CA+V-a8uMQrM75qxyFjz_x+V9+Se9JsPE0D=2yrgUkNRA7r2tew@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/2] dt-bindings: cache: r9a07g043f-l2-cache: Add
 DT binding documentation for L2 cache controller
To:     Rob Herring <robh@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
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

Hi Rob,

Thank you for the review.

On Fri, Oct 21, 2022 at 3:10 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Oct 19, 2022 at 11:02:41PM +0100, Prabhakar wrote:
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
> >  .../cache/andestech,ax45mp-cache.yaml         | 125 ++++++++++++++++++
> >  .../cache/andestech,ax45mp-cache.h            |  38 ++++++
> >  2 files changed, 163 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
> >  create mode 100644 include/dt-bindings/cache/andestech,ax45mp-cache.h
> >
> > diff --git a/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
> > new file mode 100644
> > index 000000000000..4c86a15bda5f
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
>
> What is the inner dimension of the matrix?
>
> items:
>   minItems: ?
>   maxItems: ?
>
minItems = maxItems = 6

i.e. the first two entries are the address, next two is the size and
last two is the flag.
<0x0 0x58000000 0x0 0x08000000 0x0 (AX45MP_PMACFG_ETYP_NAPOT |
AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF)>;
                                                          ^^ This is
dummy and always be 0x0

Is the above OK?

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
> > +
> > +  andestech,tag-ram-ctl:
> > +    description: Tag RAM output cycle. First tuple indicates output cycle and the
> > +      second tuple indicates setup cycle.
> > +    $ref: /schemas/types.yaml#/definitions/uint8-array
> > +    items:
> > +      - minimum: 0
> > +        maximum: 2
> > +      - minimum: 0
> > +        maximum: 2
>
> maxItems: 2
> items:
>   maximum: 2
>
> 'items' without the '-' applies to all items.
>
> And the minimum is already 0.
>
Thanks for the suggestion, I'll fix it in the next version.

> > +
> > +  andestech,data-ram-ctl:
> > +    description: Data RAM output cycle. First tuple indicates output cycle and the
> > +      second tuple indicates setup cycle.
> > +    $ref: /schemas/types.yaml#/definitions/uint8-array
> > +    items:
> > +      - minimum: 0
> > +        maximum: 2
> > +      - minimum: 0
> > +        maximum: 2
>
> Same here.
>
Ditto.

Cheers,
Prabhakar
