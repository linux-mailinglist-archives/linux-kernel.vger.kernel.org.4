Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85998677DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjAWOI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjAWOIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:08:54 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6BC10AAA;
        Mon, 23 Jan 2023 06:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674482928; x=1706018928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8ObvRqVylT5Y0CrgMD6U+JwuzhIio+nMTbmkoUPgXik=;
  b=qn/mQ9mqS5TMkcWdan56yiJ35KH/fP1eeBvilNmp2mE4d01ozK5zPIYX
   FViYKCcQwVaxc3c4bpaOR6WKqi5gFv/z0UiBYJdWDztcmXG4KDK8iHKRc
   8Mi2LrjtKF+Le57py/+JR+evhtIKQca/FLBV4zgDu8RLIGGV7eG+/f9n9
   IRxrW8BlFQodnpIkFDxMu4gRWVrXe8CYqUQFLQ24HHfJ6uwlq8FKsc4uR
   LHdhlSqBVcyNhRd95PaTQt/ZjJ5jaZmUl2Jhxejjprog4vgbJFFir6Uih
   O4Rnny7eLPnUbUgGdYue6eEZteoMCKPN8A7EkNH6lIohhlCPACl+szz0e
   w==;
X-IronPort-AV: E=Sophos;i="5.97,239,1669100400"; 
   d="asc'?scan'208";a="197739226"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jan 2023 07:08:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 07:08:45 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 23 Jan 2023 07:08:43 -0700
Date:   Mon, 23 Jan 2023 14:08:20 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alex@ghiti.fr>
CC:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Subject: Re: [PATCH v3] riscv: Allow to downgrade paging mode from the command
Message-ID: <Y86U1OUqlo05Co+2@wendy>
References: <20230123104841.813999-1-alexghiti@rivosinc.com>
 <Y851L2KgfIF3V6of@wendy>
 <95d81c9a-11de-7f92-cb76-e4492e9faba8@ghiti.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UiaEVa5YDx4RQv/n"
Content-Disposition: inline
In-Reply-To: <95d81c9a-11de-7f92-cb76-e4492e9faba8@ghiti.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--UiaEVa5YDx4RQv/n
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 23, 2023 at 02:39:35PM +0100, Alexandre Ghiti wrote:
> Hi Conor,
>=20
> On 1/23/23 12:53, Conor Dooley wrote:
> > Hey Alex,
> >=20
> > On Mon, Jan 23, 2023 at 11:48:41AM +0100, Alexandre Ghiti wrote:
> > > Add 2 early command line parameters that allow to downgrade satp mode
> > > (using the same naming as x86):
> > > - "no5lvl": use a 4-level page table (down from sv57 to sv48)
> > > - "no4lvl": use a 3-level page table (down from sv57/sv48 to sv39)
> > >=20
> > > Note that going through the device tree to get the kernel command line
> > > works with ACPI too since the efi stub creates a device tree anyway w=
ith
> > > the command line.
> > >=20
> > > Also, as those params are treated very early in the boot process and =
we
> > > use standard device tree functions that may be kasan instrumented, we
> > > only enable them for !KASAN configurations.
> > >=20
> > > Reviewed-by: Bj=F6rn T=F6pel <bjorn@kernel.org>
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > ---
> > A changelog would be nice here, especially since this is a resend.
>=20
>=20
> I think you may have commented the wrong patch, this one is wrong, hence =
the
> resend!

Oh, sorry about that Alex! For some reason the resend never landed in my
mailbox (I had just seen that there were two on patchwork).

> > >   .../admin-guide/kernel-parameters.txt         |  9 ++-
> > >   arch/riscv/mm/init.c                          | 72 ++++++++++++++++=
+--
> > >   2 files changed, 74 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docume=
ntation/admin-guide/kernel-parameters.txt
> > > index 6cfa6e3996cf..fd647412ec91 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -3578,8 +3578,15 @@
> > >   			emulation library even if a 387 maths coprocessor
> > >   			is present.
> > > -	no5lvl		[X86-64] Disable 5-level paging mode. Forces
> > > +	no4lvl		[RISCV] Disable 4-level and 5-level paging modes. Forces
> > > +			kernel to use 3-level paging instead.
> > > +			Note: On RISC-V, this can't be used when KASAN is
> > > +			enabled.
> > > +
> > > +	no5lvl		[X86-64,RISCV] Disable 5-level paging mode. Forces
> > >   			kernel to use 4-level paging instead.
> > > +			Note: On RISC-V, this can't be used when KASAN is
> > > +			enabled.
> > >   	nofsgsbase	[X86] Disables FSGSBASE instructions.
> > For the improved descriptions & commit message:
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>=20
>=20
> Thanks for that, would you mind adding that to the resend patch?

Yah, no problem.



--UiaEVa5YDx4RQv/n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY86U1AAKCRB4tDGHoIJi
0imrAQDr67fpe2CRsNEFP9GsTsQ0z2nPPr0ABLhuiUAxIx7oSQEA7Hc3dTb6PuoN
cjZOoZgwfZCavRbAR0WI1222Xo1v5gE=
=74yN
-----END PGP SIGNATURE-----

--UiaEVa5YDx4RQv/n--
