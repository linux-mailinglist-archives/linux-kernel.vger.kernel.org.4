Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7367568630D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjBAJn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjBAJn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:43:57 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F31E6185A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 01:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675244603; x=1706780603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BbyQ3KX75X0GO7lZd2KrNFTCEFGR/uZgZrbiCMS8ncc=;
  b=bgTezmhZFTi5R9/qzcaWCaLaERcKMBOnHvJeFTLE4K5zARKjPmV7GnTg
   R42IukUy/AaUI1haBalHTK4O57uSUd91Fj9yYsthKDzXKuWyDa4HXNir5
   6LNJvukNC8aK4WELUzzR5wt0/m7JaoXvN4sltQ+V0QPVUO+moJgf7q+h2
   PRARoYjJLkUkYfzqk+0p/Y2On5OOitwDniGf8IS1MlJ9yks8GVwspfOOu
   JU1ZODjvLYutxbJfHGxwXjhnc3rHjDL7rZHW3hPRQaVE99gZ6e+emkfT/
   UhJhQk+c8MIOU+hBHnA76C7s3/UjIQxfmKTaQxxm+hO/CCCmT0KjsRoOp
   A==;
X-IronPort-AV: E=Sophos;i="5.97,263,1669100400"; 
   d="asc'?scan'208";a="198870411"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Feb 2023 02:42:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 02:42:56 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Wed, 1 Feb 2023 02:42:55 -0700
Date:   Wed, 1 Feb 2023 09:42:30 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     "liaochang (A)" <liaochang1@huawei.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <heiko.stuebner@vrull.eu>,
        <ajones@ventanamicro.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <jszhang@kernel.org>,
        <vincent.chen@sifive.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: Add header include guards to insn.h
Message-ID: <Y9o0Bv7VBM74ePHH@wendy>
References: <20230129094242.282620-1-liaochang1@huawei.com>
 <Y9fZ2ZxdMmXgO5aB@wendy>
 <9a4f98a7-fa03-7960-29ce-0bff018c0ac9@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GgcUcrZJ+3fZpfIE"
Content-Disposition: inline
In-Reply-To: <9a4f98a7-fa03-7960-29ce-0bff018c0ac9@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--GgcUcrZJ+3fZpfIE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 01, 2023 at 05:37:24PM +0800, liaochang (A) wrote:
> =E5=9C=A8 2023/1/30 22:53, Conor Dooley =E5=86=99=E9=81=93:
> > On Sun, Jan 29, 2023 at 05:42:42PM +0800, Liao Chang wrote:
> >> Add header include guards to insn.h to prevent repeating declaration of
> >> any identifiers in insn.h.
> >=20
> > I'm curious, did you spot this "by hand" while doing other work, or do
> > you have a tool that found it for you?
>=20
> I found this "by hand", inspired by scripts/checkdeclares.pl, i write a t=
iny tool
> to analyse the missing header guards in header file.

Ohh, cool! I'd love to add this one to the checks on patchwork so that
we do not end up adding any more of these. If this is based on
checkdeclares, is it GPLv2?

Thanks!

>=20
> #!/usr/bin/env perl
> use strict;
>=20
> sub usage {
>         print "Usage: checkguards.pl file1.h ...\n";
>         print "Warn of missing header guards\n";
>         exit 1;
> }
>=20
> if ($#ARGV < 0) {
>         usage();
> }
>=20
> foreach my $file (@ARGV) {
>         open(my $f, '<', $file)
>             or die "Cannot open $file: $!.\n";
>=20
>         my $scan_area =3D 1;
>         my $guards_warn =3D 0;
>=20
>         # The lines of header file are divided into several areas as foll=
ows:
>         #
>         # ... area1 ...
>         # #ifndef _HEADER_GUARD
>         # ... area2 ...
>         # #define _HEADER_GUARD
>         # ... area3 ...
>         # #endif /* _HEADER_GUARD */
>         # ... area4 ...
>         # EOF
>         #
>         # If any statement is found in area1, area2, and area4, it
>         # throws a warning of illegal usage of header guard usage.
>         while (<$f>) {
>                 if (m/^(.*);\s*$/o) {
>                         if ($scan_area =3D=3D 1 || $scan_area =3D=3D 2 ||=
 $scan_area =3D=3D 4) {
>                                 ++$guards_warn;
>                         }
>                 } elsif (m/^\s*(#ifndef\s+)[a-zA-Z0-9_]*_H[_]*\s*$/o) {
>                         ++$scan_area;
>                 } elsif (m/^\s*(#define\s+)[a-zA-Z0-9_]*_H[_]*\s*$/o) {
>                         ++$scan_area;
>                 } elsif (m/^\s*(#endif)\s*\/\*\s*[a-zA-Z0-9_]*_H[_]*\s*\*=
\/\s*$/o) {
>                         ++$scan_area;
>                 }
>         }
>=20
>         close($f);
>=20
>         if ($guards_warn) {
>                 print "Illegal usage of header guard found in $file.\n";
>         }
> }
>=20
> Thanks.
>=20
> >=20
> >> Fixes: edde5584c7ab ("riscv: Add SW single-step support for KDB")
> >=20
> > Heh, I appreciate you going back to the file's original name to find the
> > correct fixes tag!
> > I figure that it's probably worth adding a fixes tag for the rename too,
> > so that the stable bots don't get confused? That would be:
> > Fixes: c9c1af3f186a ("RISC-V: rename parse_asm.h to insn.h")
> >=20
> > Probably overkill when you have Drew's already for something so trivial,
> > but:
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
> >> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> >> ---
> >>  arch/riscv/include/asm/insn.h | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/in=
sn.h
> >> index 25ef9c0b19e7..22c7613bfda3 100644
> >> --- a/arch/riscv/include/asm/insn.h
> >> +++ b/arch/riscv/include/asm/insn.h
> >> @@ -3,6 +3,9 @@
> >>   * Copyright (C) 2020 SiFive
> >>   */
> >> =20
> >> +#ifndef _ASM_RISCV_INSN_H
> >> +#define _ASM_RISCV_INSN_H
> >> +
> >>  #include <linux/bits.h>
> >> =20
> >>  #define RV_INSN_FUNCT3_MASK	GENMASK(14, 12)
> >> @@ -365,3 +368,4 @@ static inline void riscv_insn_insert_utype_itype_i=
mm(u32 *utype_insn, u32 *itype
> >>  	*utype_insn |=3D (imm & RV_U_IMM_31_12_MASK) + ((imm & BIT(11)) << 1=
);
> >>  	*itype_insn |=3D ((imm & RV_I_IMM_11_0_MASK) << RV_I_IMM_11_0_OPOFF);
> >>  }
> >> +#endif /* _ASM_RISCV_INSN_H */
> >> --=20
> >> 2.25.1
> >>
> >>
>=20
> --=20
> BR,
> Liao, Chang
>=20

--GgcUcrZJ+3fZpfIE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9oz9wAKCRB4tDGHoIJi
0lhzAP0f/StBjw3jkSx5YFiHgbBt9xkqmoqW9zL1JQJQznaaXAEA8Rk0eN2/A/OC
fKFEALpEaUisfv54TQkl4mSfCJQ48wk=
=WRsw
-----END PGP SIGNATURE-----

--GgcUcrZJ+3fZpfIE--
