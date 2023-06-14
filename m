Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC09730551
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbjFNQoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbjFNQoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:44:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38FFE62;
        Wed, 14 Jun 2023 09:44:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BC94638D6;
        Wed, 14 Jun 2023 16:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EFBC433C8;
        Wed, 14 Jun 2023 16:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686761042;
        bh=AbksTDj0Cr11HjVk9ndl4fxdbz4KeyrvhEW07BZm7RE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fzMgfRjaZkDQ+FOJ6dtazBXiBUyBQCh5OuId0BfGCJL6lwjfCnuwyySZ6oF/kRRVj
         bC28i264sOrYpVyv9CDTbe+Tj+Fb2J3UomvZo3csfGfI4QJ62D2+rxExs8Fy1WECG0
         tK2DLmgufO1pwcMdXBcFfkQFFxYpm9Bbuv+ZU3HgyRyQuleaZb+ZKvk8kjgwp+rJ78
         e00zb1dnuGAj3/nE4JH7iE2JEo4SfF5MPjrJ1h+KYTI83kIWY+yf61KwTDXOvo+dhd
         gNVCTNWO0yQaHeW3KBkDeW0/IG/rw03pvu5HAdbaINuqwnNlQ4afRKvPrAvlZeW9dX
         76SQ9ok++D/vA==
Date:   Wed, 14 Jun 2023 17:43:57 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [PATCH v9 3/6] riscv: mm: dma-noncoherent: nonstandard cache
 operations support
Message-ID: <20230614-bundle-greedless-91581fdbdce8@spud>
References: <20230614104759.228372-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230614104759.228372-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdWApGKsS8DU7-=6j6WaRBDZ8Amig2NtA8f8=PbGKoFQjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l7qMsMb3x+g0a+Wz"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWApGKsS8DU7-=6j6WaRBDZ8Amig2NtA8f8=PbGKoFQjQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l7qMsMb3x+g0a+Wz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2023 at 02:53:26PM +0200, Geert Uytterhoeven wrote:
> Hi Prabhakar,
>=20
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
>=20
> Thanks for your patch!
>=20
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
>=20
> I guess the naming can be improved?
>=20
> .clean() is used by arch_dma_cache_wback() / arch_wb_cache_pmem(),
> .inval() is used by arch_dma_cache_inv() / arch_invalidate_pmem(),
> .flush() is used by arch_dma_cache_wback_inv() / arch_dma_prep_coherent().
>=20
> Perhaps .wback(), .inv(), .wback_inv() are more clear?
>=20
> I understand this is subject to bikeshedding...
> But hey, how many innocent bits of data have already been lost due
> to cache semantic mismatches?

Given this is based on Arnd's stuff, +1 on the bikeshed. The names have
been chosen I guess to match the CBOM extensions naming.

Otherwise, I had it in my head that the next revision of this was going
to take patches 8 & 9 from Arnd's series, to align the semantics. Not
that it really bothers me, just means this will have to wait for the
cross-arch series, when pretty sure Arnd suggested not depending on that
any more... Am I missing something Prabhakar?

Other than the bikeshedding, no objections.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--l7qMsMb3x+g0a+Wz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZInuTAAKCRB4tDGHoIJi
0mehAP0QJVAWl4QlY0rgtJuCCW2wWXiwHW7Opw7NAhq2tdzsMwD9FPKY2ISdjIAj
wLfm2XMMYQuqT1og8iUEnl0XhGDPGgA=
=FBZR
-----END PGP SIGNATURE-----

--l7qMsMb3x+g0a+Wz--
