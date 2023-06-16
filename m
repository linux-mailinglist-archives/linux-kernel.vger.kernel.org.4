Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4FC733119
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344563AbjFPMXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbjFPMX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:23:28 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBA930DD;
        Fri, 16 Jun 2023 05:23:27 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-77b6e2f0c9fso21361839f.1;
        Fri, 16 Jun 2023 05:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686918206; x=1689510206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZhz7YgM6JWkeN2t67VeqyPX8iJ9vmsDBYbVnAPaL3g=;
        b=QY+V/f+bBr4PSt/2Ht9ot0Pj7xPZSgS9tVHbR9hM9bW2P7gxbWhIsdYOsAA5bhxT4g
         FRnIoATqDvRWV/doaQxv7UlK8n0Is/d4y+zaT09Q04M+rHhvyRmWVbuXAdEUTq1wmnX5
         k7O6cViMk3YnaX8lf0Q+iDibpkrRFIGBxGHhEcO/J8pFGMPxp4xDqLkG9JlWoOmvw/mS
         3T3qPmNOdQOQKQCYkHxAB+xtUQxgIdz2t6wLlooEurHATTY7Zpa1YC2RMSRXSLFmZ+tb
         4qfM42pqXK2ezqhsOZZJg213skJido04lgsvo0PNwfZI7EvjHDnv85UQT5zeCTSXYu7A
         p5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686918206; x=1689510206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZhz7YgM6JWkeN2t67VeqyPX8iJ9vmsDBYbVnAPaL3g=;
        b=FCtB6gWIeJfmaaVTcivMBBydwZ09Ac5WzP/FfwTtarYRsfA1rAzJTh3VbuAX/91BJ7
         230SDg81NoU+SzNr7Lza1SDso7gDqL14A6LKQrbilAxcHW1HEOClwWbgWAdJpZxU2G1l
         m8OpRHbNFk47i2v4pjmL8li9ADuSKJtG7TJ9kNRCfUDpjEHKVahVDLGAQ+uO0phTVBys
         rsM6b0MHQMfNmCghWSbB+6QAnrOP/RlYSU46BFAAqkCycBoKUkUYEwhwjjnMep1P3tdu
         y4AU8JwYDXR3ofScPQAVBFGmQF+CDAKuY30xIl0zbrZf2Xgvlv1OOvHAhnkaUtZsz3Eq
         6d6A==
X-Gm-Message-State: AC+VfDzczsnrRYbpzyz5L5K5zmtPomiABN17dVRY2WKGYttbXuvHzpqB
        anw9KLDjqeNt7AUVEdmPkWFMEtYHG5oLpTAjvDg=
X-Google-Smtp-Source: ACHHUZ6UP2QhxkudXsSJQadW+DwhGcn3wuF7ALSz5Z8Exzm26iTW42trlXQmqDsa51Wcscjd25D4r1uRN9wS/MYetew=
X-Received: by 2002:a6b:6d0d:0:b0:77a:c494:b4b9 with SMTP id
 a13-20020a6b6d0d000000b0077ac494b4b9mr1932815iod.20.1686918206451; Fri, 16
 Jun 2023 05:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230614104759.228372-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230614104759.228372-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdWApGKsS8DU7-=6j6WaRBDZ8Amig2NtA8f8=PbGKoFQjQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWApGKsS8DU7-=6j6WaRBDZ8Amig2NtA8f8=PbGKoFQjQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 16 Jun 2023 13:23:00 +0100
Message-ID: <CA+V-a8sLmqy0h5vKq5u-f1rsBo7HGhYg-m3vMO+UxSk1EiynDQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/6] riscv: mm: dma-noncoherent: nonstandard cache
 operations support
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the review.

On Wed, Jun 14, 2023 at 1:53=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, Jun 14, 2023 at 12:48=E2=80=AFPM Prabhakar <prabhakar.csengg@gmai=
l.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Introduce support for nonstandard noncoherent systems in the RISC-V
> > architecture. It enables function pointer support to handle cache
> > management in such systems.
> >
> > This patch adds a new configuration option called
> > "RISCV_NONSTANDARD_CACHE_OPS." This option is a boolean flag that
> > depends on "RISCV_DMA_NONCOHERENT" and enables the function pointer
> > support for cache management in nonstandard noncoherent systems.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v8 -> v9
> > * New patch
>
> Thanks for your patch!
>
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/dma-noncoherent.h
> > @@ -0,0 +1,28 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2023 Renesas Electronics Corp.
> > + */
> > +
> > +#ifndef __ASM_DMA_NONCOHERENT_H
> > +#define __ASM_DMA_NONCOHERENT_H
> > +
> > +#include <linux/dma-direct.h>
> > +
> > +/*
> > + * struct riscv_cache_ops - Structure for CMO function pointers
> > + *
> > + * @clean: Function pointer for clean cache
> > + * @inval: Function pointer for invalidate cache
> > + * @flush: Function pointer for flushing the cache
> > + */
> > +struct riscv_cache_ops {
> > +       void (*clean)(phys_addr_t paddr, unsigned long size);
> > +       void (*inval)(phys_addr_t paddr, unsigned long size);
> > +       void (*flush)(phys_addr_t paddr, unsigned long size);
> > +};
>
> I guess the naming can be improved?
>
> .clean() is used by arch_dma_cache_wback() / arch_wb_cache_pmem(),
> .inval() is used by arch_dma_cache_inv() / arch_invalidate_pmem(),
> .flush() is used by arch_dma_cache_wback_inv() / arch_dma_prep_coherent()=
.
>
> Perhaps .wback(), .inv(), .wback_inv() are more clear?
>
Ok I will update pointer names in the next version.

Cheers,
Prabhakar
