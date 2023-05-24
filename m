Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920E070FEFF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 22:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbjEXULV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 16:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEXULT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 16:11:19 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB5913A;
        Wed, 24 May 2023 13:11:08 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.48.113]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MWiYi-1pdceH1TbM-00X0aU; Wed, 24 May 2023 22:10:49 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 2F5543E718;
        Wed, 24 May 2023 22:10:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1684959048; bh=NEnzPrnR4uCWFs5+0u/hAF23Csd9DpkegHKFPhmi5nI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nP0mp5LnadS79bKA4L3f46NyX2VsyOtgTS6WuxhpjungYgIcln3beD/SbsWZtaWZk
         XIUKFPhnI2n0jmDTGC6pNRbQ8mvZ5X30xCgCMs9Kh02zFxMKU0tyRmAESqB/hmn4Va
         3h4Gf8mSDJDz2V1XGlGFOVucfC+FXsCPI9jK+zgE=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id E4300F85; Wed, 24 May 2023 22:10:47 +0200 (CEST)
Date:   Wed, 24 May 2023 22:10:47 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "kheaders: substituting --sort in archive
 creation"
Message-ID: <ZG5vR6ZWa+J0fVLA@bergen.fjasle.eu>
References: <20230521132336.1279523-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3+NM5pJFDRZYr9k4"
Content-Disposition: inline
In-Reply-To: <20230521132336.1279523-1-masahiroy@kernel.org>
X-Operating-System: Debian GNU/Linux 12.0
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:4WXS4PSLY5uzQo9usKP7ejEcycIBzTzuj086sD9jjGoxnrGgGG8
 yuiF8EHct95ROxU7AUd4WJUjmje5VFo4GOrkoEJQJD9+O0yZlnsfycDPvlXriq3PRVALnNP
 znqfuOkJhETok7+D086eyKXMDGJxj11jzXvICdKx5EHmT0zgHBqZu1KcOuJ+rJ7VyCVkeSV
 szCMlpzoqveZIFlAgsoVQ==
UI-OutboundReport: notjunk:1;M01:P0:/iiGzhFs4D0=;mn3FGmt7jgOlYcFgGwV2Ha/He7x
 ugFzUaLn1Jv1ynESz5wiP7p7eA7FRmkLG5/YQatdZ2mCktWr3Vdi2UJClI6+cYMxDE8v/JxQl
 jxUbPZuCe+YAC4EXn5433LH8SZCL16FRHyrATvW1RgMfLPVqhACr6J08SeHR5Utpgbqxl7tLu
 ZSz5GiQAFobR8lCs/fNlPzjzR1112HwZc+zuHIM54qubWaUs23qeYkfq9zSDF7rAPXhP5OBm/
 rhK/GJ1/aaVfvWP+tZXh6VxRwOuzxp+8LDOnT3LE2jLSwvnVokDsysvAbbB71mGcjK4ouQSSo
 +a+fU/uRFiTyXjXUiN4zXypvaWu+HbWE8WXEdFo3XsY0DaiUkZK9KnatG3PKMKR3EXIn4jjwi
 6fDFY3l2zKqIBihP4Q1dl7kYVV6svXZPQX+ss3AEgSIhroY4QZPQG+/jSxPDuxkTGelkEGC5E
 deoR4Yfd8NZur48nBMcDLuSgct0FpbYHbxeuBJx5AnTsQrYxLHFdJ5wK2/Y3XRXU3kurzA5PN
 ugZ10ifpsOs9Y7S5k9gq8Cl4OGGCJrvFxvLTDkZwMuUYWPDl2SKdvSpz2rlsWQxZTBGKguX1+
 /SqCAMl27U3NHmGdVu9D7H+MNkZ8rJF4+n4CTqj9vmjQoLNuliTfA9tgZuUqkL8RZZDZSKbvh
 CUEj2RsrNtwynmYd8kZlsom9DvMH802Nffym76FlDA==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3+NM5pJFDRZYr9k4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 21 May 2023 22:23:35 GMT, Masahiro Yamada wrote:
> This reverts commit 700dea5a0bea9f64eba89fae7cb2540326fdfdc1.
>=20
> The reason for that commit was --sort=3DORDER introduced in
> tar 1.28 (2014). More than 3 years have passed since then.
>=20
> Requiring GNU tar 1.28 should be fine now because we require
> GCC 5.1 (2015).
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>


>=20
>  kernel/gen_kheaders.sh | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
> index 1ef9a87511f5..6d443ea22bb7 100755
> --- a/kernel/gen_kheaders.sh
> +++ b/kernel/gen_kheaders.sh
> @@ -83,12 +83,9 @@ find $cpio_dir -type f -print0 |
>  	xargs -0 -P8 -n1 perl -pi -e 'BEGIN {undef $/;}; s/\/\*((?!SPDX).)*?\*\=
///smg;'
> =20
>  # Create archive and try to normalize metadata for reproducibility.
> -# For compatibility with older versions of tar, files are fed to tar
> -# pre-sorted, as --sort=3Dname might not be available.
> -find $cpio_dir -printf "./%P\n" | LC_ALL=3DC sort | \
> -    tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=3D$KBUILD_BUILD_TIMESTAMP}" \
> -    --owner=3D0 --group=3D0 --numeric-owner --no-recursion \
> -    -I $XZ -cf $tarfile -C $cpio_dir/ -T - > /dev/null
> +tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=3D$KBUILD_BUILD_TIMESTAMP}" \
> +    --owner=3D0 --group=3D0 --sort=3Dname --numeric-owner \
> +    -I $XZ -cf $tarfile -C $cpio_dir/ . > /dev/null
> =20
>  echo $headers_md5 > kernel/kheaders.md5
>  echo "$this_file_md5" >> kernel/kheaders.md5
> --=20
> 2.39.2

--=20
Nicolas Schier
=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--3+NM5pJFDRZYr9k4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmRub0IACgkQB1IKcBYm
Emmegw//ZPS0pesaF4rgNSTunDOe/fMbQ1/bobbJQX1IxgoRSF4GNWbhTVLeSN6L
ZqGdKkkhc4RbrsBT9o3tHjEHaO44orUvrb1fqpTcVl9NTZtsI2qLjC8hPCzO0bTI
IuQl6yinPSDElO+ZE7zZFalk0BFykxezgtYzZeEyajFVJsPJVb7cIb8RHf8chEud
MLNDWqIk63/85LRVaO4bTRPeGFGP+wpM1DvBz1k3tVFGVz4kVcB+0PdEyuMtiykS
Z0R4aXcyEJodY6rlIvp23AIzTA/1XoxIWd/Eg44yvvC11J3oUzwOXTh480FuABDQ
TzRMlRJdLLkyUz5q4u+zus4QfguVTJGEnXKdms4oJdW0EIOOeIugQob+ZmH3Ds+A
sSTqD89dRe1ga4QjnqhNHRb+CleraLj911oKm6dKAJIq153Kr7TTA5vxmXcdHJ1U
t/4idQvY5SV2wezcr//BKb6pRUOemcB1mRmSCrTO0iY5S1gZYw6O0m071oPG9uY9
mGIoN04dUvOVRfsY5IfGsEL3hJFemnAkyviWG49s5ZyWlq0/QmoeurQykHzQ6iFy
PbD3wQxbpPYyfU14fT1Rx71Wx5AaLvR8ny27vdAH0RSayC3IhzPCqjewjc1m4NYc
e64tPr/T49SFk7Ar2FGlLVDrV/kgDuX0HPZxZv8hHX/IKhQuh1o=
=OYQM
-----END PGP SIGNATURE-----

--3+NM5pJFDRZYr9k4--
