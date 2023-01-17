Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3843670D19
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjAQXSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjAQXRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:17:53 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027324A1EA;
        Tue, 17 Jan 2023 13:04:31 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.49.134]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N6bsM-1of5Wn2RZe-0184To; Tue, 17 Jan 2023 22:04:03 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id F04C23C1B9; Tue, 17 Jan 2023 22:03:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1673989440; bh=fWkVLmnSaT9GUYQ87FRAKJFTIoqGhHq4regmTTqLF+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SLzEDFcZgRf51sfi0FtCXAQXcsoI9RhfqroKuym71mDPyYGwyElN2+Jx64gFtlASv
         BItGVXgVLGtfGxgkdXmsXSQ1Y1xLfbPFwbgjhcv2XYcNXGoQxXwLfNvGOFZbWLKpm3
         Zcb18LDWysXyiX53UbIGHYtmyQINcqbqSrj/vNrk=
Date:   Tue, 17 Jan 2023 22:03:59 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Nicolas Schier <n.schier@avm.de>
Subject: Re: [PATCH v2] kheaders: ignore and clean temporary kheaders_data
 directory
Message-ID: <Y8cNP6GgoB9HH8Y2@fjasle.eu>
References: <20230117-kernel-kheaders-gitignore-v2-1-1c29b3adf04a@weissschuh.net>
 <CAK7LNARi8Gm7n0nRidyf++YmW9zZ1qv7huN8nP3MCNzWGK42Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nRidOz5qv/+nO5MN"
Content-Disposition: inline
In-Reply-To: <CAK7LNARi8Gm7n0nRidyf++YmW9zZ1qv7huN8nP3MCNzWGK42Cg@mail.gmail.com>
X-Provags-ID: V03:K1:epy0qM5jWP1hLOLD/eYXKFPEK1SoKErjusesVxPUjAc+E4ATFNG
 bivhI4oQjjk+gkkpXdFznVIvVDN/QJDqG0aivTx4d8iy/5wCXtfxvzrXYuIOgMBxAmFX9k0
 9t3rTQpzaVDNy2RNNtSu3vHDtUAbtZQDt83BBBh3AVCb4eR7n9iSnGJUB9Rx8WVfDN8v1fl
 7kZhiM29md/+Lv0v9Fmyw==
UI-OutboundReport: notjunk:1;M01:P0:2U2oNyets0g=;dTMomRJvvl4g54cVcY1JlRC5P4h
 4uRRD5IVvNjowSIF9JLgL+DYriCsDL9LgasCeQvPZPcehXBTQDq3E+LAagMmvmnn2NPj0pE31
 ytOl9VIBiq+vGaUxtFc0Ph3jLYgAiM1zkg+8lzsqnTVF8CAuDghgtb5loUIFjKOsPYfbCGkxS
 8cuEeYo5Jai4XDoRssR0Z2J4+IfQjvlbAUDkdP4YZKTrax/BQIh+I2dCvXkq6/z0odahb8m4L
 nwxyz/FsMSCYqZCT8DydGBAyQ2S2d+4PLpCN91AW8xrE63qYbHkNwwYsomcsZ6q0ng0NkJCfX
 K8SbHyTzvC/eunr4vN2IEt6K9rbAvdZfUAfZKufedhf79oTmqUb4tpCcpF6GHftDASpdcAaRd
 7kmJ6iwzK88bEQxRrdH3r/LKFnHT8b9leMCBdI7MH4MgycYPgL0f42ggYwPiZmpwmPA+q88XY
 iWE12Csw+tcWs2I5HXhl78duR/PFfIUlHkiNhvKdmHrn8S8pQ8Ddsu1xgtPAwNdv14kMmRUjF
 4R2qProgq1lXGo0BOWV58elEre343Jfn5Xsx6bal4TzKq5qOsofTedLhVakwz7PQ3Bnj6JvcA
 BI6c+XksFEQtNvm0oBmloyFDwk3nNQw0DDVNa3Q1bwBZZdeqNfkYR6efvoMv2mTp6UI4D1v/5
 weXHRKtNIuYXueQdKHwElPd823bLgz0wYKCU+CX14w==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nRidOz5qv/+nO5MN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 17, 2023 at 11:24:47PM +0900 Masahiro Yamada wrote:
> On Tue, Jan 17, 2023 at 10:50 PM Thomas Wei=C3=9Fschuh <linux@weissschuh.=
net> wrote:
> >
> > If the kheaders archive generation is interrupted then this directory
> > may be left.
> > Ignore it, it will be deleted by the next run of kernel/gen_kheaders.sh.
> > Also add it to clean-files so it can be cleaned up by make.
> >
> > Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>=20
>=20
> Or, just rename the temporary directory.
> For example,
>=20
>   cpio_dir=3D$outdir/$(dirname $tarfile)/.tmp_cpio_dir
>=20
>=20
>=20
> Dot files are ignored.
> 'make clean' removes the .tmp_* pattern.

yes, almost unbeatable.  Can we use '${tarfile%/*}' instead of '$(dirname
$tarfile)'?

Kind regards,
Nicolas



> > ---
> > Changes in v2:
> > - Also add the directory to clean-files
> > - Link to v1: https://lore.kernel.org/r/20230117-kernel-kheaders-gitign=
ore-v1-1-2a3a070efd0d@weissschuh.net
> > ---
> >  kernel/.gitignore | 1 +
> >  kernel/Makefile   | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/.gitignore b/kernel/.gitignore
> > index c6b299a6b786..57ab1d703763 100644
> > --- a/kernel/.gitignore
> > +++ b/kernel/.gitignore
> > @@ -1,3 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  /config_data
> >  /kheaders.md5
> > +/kheaders_data.tar.xz.tmp/
> > diff --git a/kernel/Makefile b/kernel/Makefile
> > index 10ef068f598d..f3535944f635 100644
> > --- a/kernel/Makefile
> > +++ b/kernel/Makefile
> > @@ -156,4 +156,4 @@ quiet_cmd_genikh =3D CHK     $(obj)/kheaders_data.t=
ar.xz
> >  $(obj)/kheaders_data.tar.xz: FORCE
> >         $(call cmd,genikh)
> >
> > -clean-files :=3D kheaders_data.tar.xz kheaders.md5
> > +clean-files :=3D kheaders_data.tar.xz kheaders.md5 kheaders_data.tar.x=
z.tmp
> >
> > ---
> > base-commit: d532dd102151cc69fcd00b13e5a9689b23c0c8d9
> > change-id: 20230117-kernel-kheaders-gitignore-f0d73456cb6b
> >
> > Best regards,
> > --
> > Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> >
>=20
>=20
> --
> Best Regards
>=20
>=20
> Masahiro Yamada

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--nRidOz5qv/+nO5MN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmPHDT4ACgkQB1IKcBYm
EmlZkA//dpaMeRKa+oIrty+NgvL5aqMZeZxMLTA2Yw2xrb3y3tHVO6eV06OeOf5I
gVKtut6PqB8dF7OAc0awHMPi0Ymdy2KRYFLfTJg4YatIWxZHyOoP9jQgQdSfy9qZ
V9NYCPBRQqxAHUuzR0p5xYF4ZWabrZypq6WYP6SLZmApKkbpUQv1svDy2BT1bl//
yeFxPdTHWs6GiIUuhewt3uhVeU0vaxqjdRWYiEo9Zp9tadM2W9D+ZmjOmto7mRig
VKCoDAK0MuOUmzV4BfCjKbSdQmnotsaNgIo1gL/hbYDNldXcCagkvghLhkQg+/dB
TO1gK+QlPgmwgyGPC/TFwhBtBn3pvLDhoPsyTmYB8/yMLtJgetjhWGkmJkzk92CU
DkNYUH6cstoVO/hEVsOsPEwYJo4aRFQV84PXSuEwcGyf1q1DA+fckn9sJ/wI3fbG
lNxj2IYZ0w8NAUZTh47Sf89jh5SMasFK4lz0q7tu6AmDJ2JW+zXjRsm7633XOeeB
7oHDRYOUr15LbFQ6lbr0uOsAE2+UtnH6jqL6M0rNKs2DePl2a4h07SBf557vOPDi
hKHH1mXzhduCN3KIUSC9Ds6rdPFvPNXm8nkIlZPauagXFGRYrN3cYadWs9lS7kZV
DkooWHSswiy3QLoaRHImbj23zLKnnVHbAIWbb6m0puVQc5TBLLE=
=BtkS
-----END PGP SIGNATURE-----

--nRidOz5qv/+nO5MN--
