Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50FA651035
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 17:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiLSQUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 11:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiLSQU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 11:20:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22FBCC2;
        Mon, 19 Dec 2022 08:20:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5ED9860ECA;
        Mon, 19 Dec 2022 16:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6E8C433F2;
        Mon, 19 Dec 2022 16:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671466824;
        bh=TCDRHXSCue+6gNvdNI3YHH1hpd/QB4Bg6cEJ8MRAxS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lCj9bDituBOnf8/UyeCcmKZTTL3vt3syeJvtt+7cUyKhRqhOKkRfiC0KvgxKwglYw
         NJkdgeyDbZ/k6YOWa8oISFpyghnrPfbEFqYKjXo7bc0k1yT9WJZ9IVt462XfQvkBOW
         pJbgMJMHdKOweN9bKa7kWy5uerXAAPmTbO8zcBQlUNTKgPVH7E9V65k6KiLbZC2FIb
         YFKvX4s6oCKXU8xD57RlS0SWDffbQcLLlu34vSqfB715tTVY0siFFC27JNoitx3x9i
         9QVXSs138Yh6HGy9OkZobqE9lJ18BMgDX/ObiO3NOrXwb3+G/wZeDLeAgtVRc7Kdv0
         RKU6qyhLfEvGQ==
Date:   Mon, 19 Dec 2022 16:20:17 +0000
From:   Conor Dooley <conor@kernel.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v5 3/6] riscv: errata: Add Andes alternative ports
Message-ID: <Y6CPQWHrPLk1O6jB@spud>
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221212115505.36770-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y54ycZdMLjU5QVn5@spud>
 <CA+V-a8sa1H=Hh2SzbKDWhiAO=C+Y2YN7sk9APBeqktBeHf49jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a/Wc8u+smEWp2mxo"
Content-Disposition: inline
In-Reply-To: <CA+V-a8sa1H=Hh2SzbKDWhiAO=C+Y2YN7sk9APBeqktBeHf49jA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a/Wc8u+smEWp2mxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2022 at 11:19:13AM +0000, Lad, Prabhakar wrote:
> Hi Conor,
>=20
> Thank you for the review.
>=20
> On Sat, Dec 17, 2022 at 9:19 PM Conor Dooley <conor@kernel.org> wrote:
> >
> > On Mon, Dec 12, 2022 at 11:55:02AM +0000, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Add required ports of the Alternative scheme for Andes CPU cores.
> > >
> > > I/O Coherence Port (IOCP) provides an AXI interface for connecting ex=
ternal
> > > non-caching masters, such as DMA controllers. IOCP is a specification
> > > option and is disabled on the Renesas RZ/Five SoC due to this reason =
cache
> > > management needs a software workaround.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > > v4 -> v5
> > > * Sorted the Kconfig/Makefile/Switch based on Core name
> > > * Added a comments
> > > * Introduced RZFIVE_SBI_EXT_IOCP_SW_WORKAROUND SBI EXT ID to check if
> > >   CMO needs to be applied. Is there a way we can access the DTB while=
 patching
> > >   as we can drop this SBI EXT ID and add a DT property instead for cm=
o?
> > >
> > > RFC v3 -> v4
> > > * New patch
> > > ---
> > >  arch/riscv/Kconfig.erratas           | 22 +++++++
> > >  arch/riscv/errata/Makefile           |  1 +
> > >  arch/riscv/errata/andes/Makefile     |  1 +
> > >  arch/riscv/errata/andes/errata.c     | 93 ++++++++++++++++++++++++++=
++
> > >  arch/riscv/include/asm/alternative.h |  3 +
> > >  arch/riscv/include/asm/errata_list.h |  5 ++
> > >  arch/riscv/kernel/alternative.c      |  5 ++
> > >  7 files changed, 130 insertions(+)
> > >  create mode 100644 arch/riscv/errata/andes/Makefile
> > >  create mode 100644 arch/riscv/errata/andes/errata.c
> > >
> > > diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
> > > index 69621ae6d647..f0f0c1abd52b 100644
> > > --- a/arch/riscv/Kconfig.erratas
> > > +++ b/arch/riscv/Kconfig.erratas
> > > @@ -1,5 +1,27 @@
> > >  menu "CPU errata selection"
> > >
> > > +config ERRATA_ANDES
> > > +     bool "Andes AX45MP errata"
> > > +     depends on !XIP_KERNEL
> > > +     select RISCV_ALTERNATIVE
> > > +     help
> > > +       All Andes errata Kconfig depend on this Kconfig. Disabling
> > > +       this Kconfig will disable all Andes errata. Please say "Y"
> > > +       here if your platform uses Andes CPU cores.
> > > +
> > > +       Otherwise, please say "N" here to avoid unnecessary overhead.
> > > +
> > > +config ERRATA_ANDES_CMO
> > > +     bool "Apply Andes cache management errata"
> > > +     depends on ERRATA_ANDES && MMU && ARCH_R9A07G043
> > > +     select RISCV_DMA_NONCOHERENT
> > > +     default y
> > > +     help
> > > +       This will apply the cache management errata to handle the
> > > +       non-standard handling on non-coherent operations on Andes cor=
es.
> > > +
> > > +       If you don't know what to do here, say "Y".
> > > +
> > >  config ERRATA_SIFIVE
> > >       bool "SiFive errata"
> > >       depends on !XIP_KERNEL
> > > diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
> > > index a1055965fbee..6f1c693af92d 100644
> > > --- a/arch/riscv/errata/Makefile
> > > +++ b/arch/riscv/errata/Makefile
> > > @@ -1,2 +1,3 @@
> > > +obj-$(CONFIG_ERRATA_ANDES) +=3D andes/
> > >  obj-$(CONFIG_ERRATA_SIFIVE) +=3D sifive/
> > >  obj-$(CONFIG_ERRATA_THEAD) +=3D thead/
> > > diff --git a/arch/riscv/errata/andes/Makefile b/arch/riscv/errata/and=
es/Makefile
> > > new file mode 100644
> > > index 000000000000..2d644e19caef
> > > --- /dev/null
> > > +++ b/arch/riscv/errata/andes/Makefile
> > > @@ -0,0 +1 @@
> > > +obj-y +=3D errata.o
> > > diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/and=
es/errata.c
> > > new file mode 100644
> > > index 000000000000..3d04f15df8d5
> > > --- /dev/null
> > > +++ b/arch/riscv/errata/andes/errata.c
> > > @@ -0,0 +1,93 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Erratas to be applied for Andes CPU cores
> > > + *
> > > + *  Copyright (C) 2022 Renesas Electronics Corporation.
> > > + *
> > > + * Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > + */
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +
> > > +#include <asm/alternative.h>
> > > +#include <asm/cacheflush.h>
> > > +#include <asm/errata_list.h>
> > > +#include <asm/patch.h>
> > > +#include <asm/sbi.h>
> > > +#include <asm/vendorid_list.h>
> > > +
> > > +#define ANDESTECH_AX45MP_MARCHID     0x8000000000008a45UL
> > > +#define ANDESTECH_AX45MP_MIMPID              0x500UL
> > > +#define ANDESTECH_SBI_EXT_ANDES              0x0900031E
> > > +
> > > +#define RZFIVE_SBI_EXT_IOCP_SW_WORKAROUND    0
> > > +
> > > +static long ax45mp_iocp_sw_workaround(void)
> > > +{
> > > +     struct sbiret ret;
> > > +
> > > +     ret =3D sbi_ecall(ANDESTECH_SBI_EXT_ANDES, RZFIVE_SBI_EXT_IOCP_=
SW_WORKAROUND,
> > > +                     0, 0, 0, 0, 0, 0);
> >
> > Seeing as you need a new version for some of the other bits, I think it
> > would be good to add a minor comment here somewhere (be it here or the
> > commit message) that links to the SBI specs for this.
> > I think this looks pretty good though.
> Sure I'll add a comment here.
>=20
> I was wondering if we can get rid of this vendor specific extension
> here if we get access to the DT here (for example having a DT property
> which would indicate if IOCP CMO should be applied or not). Do you
> think that would be good approach?  ATM we dont have a pointer here
> for FDT whie early patching.

I dunno. I think it is fine to use the ECALL to be honest - I'd rather
that than a property that someone may omit.

That said, for the cache management stuff we are gonna need for
PolarFire SoC, we will need to have info from the DT AFAICT - marchid
etc are all set to zero on our platform so cannot be used.

I was thinking about using the compatible instead, but...
we've not tried to "forward"-port our stuff from 5.15 yet as we have
not yet completed testing testing on our vendor tree (and need some PCI
changes accepted upstream first anyway), as a result I have not looked
into what's needed there for use with alternatives. We've been using a
pre-alternatives version of that patchset from around the 5.15
development point in time instead.

Thanks,
Conor.


--a/Wc8u+smEWp2mxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6CPQQAKCRB4tDGHoIJi
0lZ9AQCOYZeG/oRfDujddYGIWFAf2ZJf64Ns/lFe7GdcCKveKwEArKQAQZukjH2r
31D53uaNNDyHGMmKJVq7A7fFO+yeSg4=
=s444
-----END PGP SIGNATURE-----

--a/Wc8u+smEWp2mxo--
