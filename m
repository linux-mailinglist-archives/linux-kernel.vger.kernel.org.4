Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DD57330F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345309AbjFPMOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345320AbjFPMON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:14:13 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CB430E0;
        Fri, 16 Jun 2023 05:14:12 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-77d7f0ea1daso24391539f.0;
        Fri, 16 Jun 2023 05:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686917651; x=1689509651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVXfmE9xuqvJBkC+/tsNkqbXmSmcyqz9tBTp7H4fW+s=;
        b=Dm5UP0cq9vx0CoXvsXIryqw8idxJ2dtcwVacxjTrmAU9AR6CvAa9+/4i+scxeoC8Vo
         dfPkhHBacDXFYB/BCowsuEN6nyqZVA+z/TddxswHEMZ1IOjShH6gieq+VxwvGetmMKp4
         0l989bM/DyQJcCFMTOK+kEqHG8i8vt1Y1A903YL/Sp78hSXrciNgy0uHsDarFMKetsa3
         LqYiJCuW6gWs17nAg7Aak2DCjJPImSKAz45kewQUwE95OZLVDRMTmZCW1fgPgIa1qr2w
         ieuXTW2ROTAwUgwIQ06NV2F0Tvm98mk8CA32KhZkLm20BLGv7YQz0r/qHWK8ftVn0ViL
         mjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686917651; x=1689509651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVXfmE9xuqvJBkC+/tsNkqbXmSmcyqz9tBTp7H4fW+s=;
        b=I56MBreBcaRhEf2Jb/RJb5WlG+ZajgUva9EC/b/egqM7fg7QawBpPjlHuPojZ6Fdhd
         K1vVx12po5R5RzzUTh+L/PWhs7d65WaKVV08XfbpYRnDUKTy9NEWohMEnAsLJ6qipcPk
         ASdpbR6fuw4ASbJMfFbOAo1vX3jbitzihVuttA/d3oU9U5x0dJ3kKjF/il5JmdHmti9T
         CG+rMhXUCjIsTnjNtf8PSKfUT+wZxBGZZ3GQjp7W4yvP+ddqN66b1HTK1qO/LZyxH6iP
         nRrOqgiam3StkBqpEfpm6j1Pf8D1XCtRV+6fSe9qcaWtBE9Ve98+x+7Lu5jce6d+uohV
         g3wA==
X-Gm-Message-State: AC+VfDwoSyqPtWZi0fUXsJAAytmiqyF5jq3JkUzX9va5njo4w43mhWKo
        uUBGSHWda/ZavjPYcozocjMV3DNJofcPDKCK4gA=
X-Google-Smtp-Source: ACHHUZ5+cE31rc8cUVpUMXCOk4ewlhmB9UuvLujSALdXjEdrUSwm63nNo3tivuZ1BqaABQ7eapNgTyAZw+ETZDWWmGA=
X-Received: by 2002:a5e:c103:0:b0:753:42d:25ec with SMTP id
 v3-20020a5ec103000000b00753042d25ecmr2481529iol.20.1686917651264; Fri, 16 Jun
 2023 05:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230614104759.228372-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230614104759.228372-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <4f69fcfe-debb-4979-9070-1d58ba35032c@app.fastmail.com>
In-Reply-To: <4f69fcfe-debb-4979-9070-1d58ba35032c@app.fastmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 16 Jun 2023 13:13:44 +0100
Message-ID: <CA+V-a8utPvBdwR78NVxpnuUWgniVvopnK4PvmWGEfkfSv5AQHQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/6] riscv: mm: dma-noncoherent: nonstandard cache
 operations support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Conor.Dooley" <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        guoren <guoren@kernel.org>,
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
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Arnd,

Thank you for the review.

On Wed, Jun 14, 2023 at 1:36=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, Jun 14, 2023, at 12:47, Prabhakar wrote:
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
>
> I understand that Christoph will still not like this, but I think this
> is as good as it gets, making the standard variant the fast path,
> and using the function pointers only for the nonstandard cases.
>
>
> >  #include <asm/cacheflush.h>
> > +#include <asm/dma-noncoherent.h>
> >
> >  static bool noncoherent_supported;
> >
> > +struct riscv_cache_ops noncoherent_cache_ops =3D {
> > +     .clean =3D NULL,
> > +     .inval =3D NULL,
> > +     .flush =3D NULL,
> > +};
>
> This could be marked __read_mostly or __ro_after_init as
> a micro-optimization, if anyone cares.
>
Ok, I will do that in the next version.

Cheers,
Prabhakar
