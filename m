Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B154C62E391
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239965AbiKQRz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239853AbiKQRzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:55:24 -0500
X-Greylist: delayed 1800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Nov 2022 09:55:16 PST
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE56B30549
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:55:16 -0800 (PST)
Received: from 213.219.160.184.adsl.dyn.edpnet.net ([213.219.160.184] helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1ovi6C-0002Ml-VT; Thu, 17 Nov 2022 17:50:48 +0100
Received: from ben by deadeye with local (Exim 4.96)
        (envelope-from <ben@decadent.org.uk>)
        id 1ovi68-000AcN-2M;
        Thu, 17 Nov 2022 17:50:44 +0100
Message-ID: <51c845f30cfb74420b176be96bdd1f8de4079393.camel@decadent.org.uk>
Subject: Re: [PATCH] kbuild: deb-pkg: get rid of |flex:native workaround
 from Build-Depends
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Date:   Thu, 17 Nov 2022 17:50:40 +0100
In-Reply-To: <20221117013033.1105289-1-masahiroy@kernel.org>
References: <20221117013033.1105289-1-masahiroy@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-erCn4oDPeuaBLJvFvaSk"
User-Agent: Evolution 3.46.1-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 213.219.160.184
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-erCn4oDPeuaBLJvFvaSk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2022-11-17 at 10:30 +0900, Masahiro Yamada wrote:
> "| flex:native" was a workaround (suggested by Ben, see Link) because
> "MultiArch: foreign" was missing in the flex package on some old distros
> when commit e3a22850664f ("deb-pkg: generate correct build dependencies")
> was applied.
>=20
> It seems fixing the flex package has been completed. Get rid of the
> workaround.
>=20
> Link: https://lore.kernel.org/linux-kbuild/ab49b0582ef12b14b1a68877263b81=
813e2492a2.camel@decadent.org.uk/
> Link: https://wiki.debian.org/CrossBuildPackagingGuidelines
> Cc: Ben Hutchings <ben@decadent.org.uk>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Ben Hutchings <ben@decadent.org.uk>

> ---
>=20
>  scripts/package/mkdebian | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index 60a2a63a5e90..852d13e738c5 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -175,7 +175,7 @@ Section: kernel
>  Priority: optional
>  Maintainer: $maintainer
>  Rules-Requires-Root: no
> -Build-Depends: bc, rsync, kmod, cpio, bison, flex | flex:native $extra_b=
uild_depends
> +Build-Depends: bc, rsync, kmod, cpio, bison, flex $extra_build_depends
>  Homepage: https://www.kernel.org/
> =20
>  Package: $packagename-$version

--=20
Ben Hutchings
Larkinson's Law: All laws are basically false.

--=-erCn4oDPeuaBLJvFvaSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmN2ZmAACgkQ57/I7JWG
EQmDLA//SyyQ2S2LEaIwtjn1XNZon0gqi/7H2hz6wrGPuXSxMtb6SMk10DEen08V
/JESjQ6/pf9t6xXEtt2WlM0ZZHrwYqjzd6/rwDYe3/lfyL2/Ad6cvPPQNLzj57Bd
8MYqm6A+cd1P0cqPf5AaX52kpgZMUlaO3WiMpcrmmUriljnyrcEp7tm0Tj+lLZ3c
PTIRZGzT41fBeuQVgpU4Ij3MgP06j7cp/0lzwT7SOlN7phdzDCuaO8ovF46yYe7F
caMdJ8SMiO3xNcaLbEXU7ZntNJJKJkfSWTxeGndCuoRrkIrKfYjEhjWnDIAjByqP
ss7Nes1IZBC6s0JWbf4itF3jV0F8ijXkJON/q3U67VEaXU0+XCrW1p6k5mBdDbW/
yL5fNK234kJ707wCTmbAfIK6+96DxAL/Iv9ZYGgQLoeAXtUSG8UoXtugDJaHqHnx
as8IZpIJViE9n7Y8yplEZzI7OHV5jPoFWj6x7xZYPPOu/n+MExexw2UM5+Fs7XlC
X51wnmTD+OWgSgRUAIN5TMKuoepmdJBVLubDdp+W36KyK2J+Ov6hLUy7yC1xH3bY
TAc+viisiU36dtUCKnB7cnQA6ny1BPXmfEzZ01m13u/3WHligYLrfih1Oe3MtJMP
gbfce4YpENXGM0gZo++a5cW6DbE9yM4IIvkeMgcRZYpPDF68JXM=
=Ijuf
-----END PGP SIGNATURE-----

--=-erCn4oDPeuaBLJvFvaSk--
