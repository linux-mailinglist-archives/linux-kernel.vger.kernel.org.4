Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7CD66D861
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbjAQIka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbjAQIkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:40:25 -0500
X-Greylist: delayed 376 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Jan 2023 00:40:20 PST
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C228A901C;
        Tue, 17 Jan 2023 00:40:20 -0800 (PST)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Tue, 17 Jan 2023 09:34:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1673944442; bh=kMwk25Pa4sf73B3ViO7ZeW5zKO+tJBR7mWWrhfli0aY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Exi2r7Cb7dAUxj2dbia0L2NZ0e2N47abL4qOxy1DLs3jJG5ZRkrDb3T8mbiacFM0q
         6r+0FMV1tA6LyDOY5EPgXXvqUaTaeWaGYdWSsHUrMgC7Kmz8Aqb7bqQEYPAGY185dd
         KH5z7QLVstlrhzYFD7oJ/YlhV+zhwbFCQD2zUUcM=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id 4193580AA6;
        Tue, 17 Jan 2023 09:34:02 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 3784B1816D2; Tue, 17 Jan 2023 09:34:02 +0100 (CET)
Date:   Tue, 17 Jan 2023 09:34:01 +0100
From:   Nicolas Schier <n.schier@avm.de>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] kernel/.gitignore: ignore temporary kheaders_data
 directory
Message-ID: <Y8ZdGIDj+0nSqjkF@buildd.core.avm.de>
References: <20230117-kernel-kheaders-gitignore-v1-1-2a3a070efd0d@weissschuh.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ty33j4u5WgmG6v6/"
Content-Disposition: inline
In-Reply-To: <20230117-kernel-kheaders-gitignore-v1-1-2a3a070efd0d@weissschuh.net>
X-purgate-ID: 149429::1673944442-A756973F-F5F3902E/0/0
X-purgate-type: clean
X-purgate-size: 2731
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ty33j4u5WgmG6v6/
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2023 09:34:01 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] kernel/.gitignore: ignore temporary kheaders_data
 directory

On Tue, Jan 17, 2023 at 05:15:25AM +0000, Thomas Wei=C3=9Fschuh wrote:
> If the kheaders archive generation is interrupted then this directory
> may be left. Ignore it, it will be deleted by the next run of
> kernel/gen_kheaders.sh.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  kernel/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/kernel/.gitignore b/kernel/.gitignore
> index c6b299a6b786..57ab1d703763 100644
> --- a/kernel/.gitignore
> +++ b/kernel/.gitignore
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  /config_data
>  /kheaders.md5
> +/kheaders_data.tar.xz.tmp/

What about removing the temporary directory on failure instead?  E.g.:

diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 473036b43c83..c656b72a3cdc 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -61,6 +61,8 @@ echo "  GEN     $tarfile"
 rm -rf $cpio_dir
 mkdir $cpio_dir
=20
+trap "rm -rf ${cpio_dir}" EXIT
+
 if [ "$building_out_of_srctree" ]; then
        (
                cd $srctree


Otherwise, I'd suggest to extent this .gitignore patch by also adding

   clean-files +=3D kheaders_data.tar.xz.tmp/

to kernel/Makefile.

Kind regards,
Nicolas

--Ty33j4u5WgmG6v6/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEDv+Fiet06YHnC6RpiMa8nIiabbgFAmPGXXkACgkQiMa8nIia
bbj14g//aT1UvWM7Aac9PChXlBal4d2NpCrojDoGrwUxmGX4tH0vwpaxBHeRe3lB
Txdmktd+PmlJnZ0YHpaTgyKIKottb26yOhCO9CcKwgw1UY27K34n4b7GrV8rpu4I
sWUDJb5hvfyraIh0n2YqQcRvIJIPRg3t24kc4ZrTS27GdYUMCq8hP3ykA7ol3K9g
sFDGrPrZF2CPrYEChq1xmbML39occib8ytoSpOxc/cQrent7LyYI3oopBYFV1FDI
KNMCbkvXgX96ZGJrjXdhMjODZ3apSBARMs67e9iS3BsTGjwPNHstWvkm3VTzmI+U
5kH2zwyPAdovU6I9iS92hgXZ+hHAem4jpNwBJJbAeB5EtRc3WcxPpcBDp6OxPxFd
kgQmc6MEB0BOURsipXmNAurxBwZWTYXQLZ6hM22e7G3mv5ZMjgrM4jZ8ZWuHzPRj
2QKZgXEwGd/w0gwi7ZeTzYEofi+NiRPimzk71a0nWIVo6vmX7QkBJQHrHbela/Ay
ghogsnAHxNAlYcsp3nXaOpfEUEDAn/oaCUFcQZEvGEjsWXz7vxbTTtAP7Xv9RE+t
2CuuyIEeRGj4WBF6yYstwY5hnw08X+9v3Vhb0OO1elQkycqyCwOKrtKA3ouPwot3
9vkqZxyeV8ihXJMHlkFT/j2AphRrlSNv2N8Q14tpg/UBfpHb15A=
=qPSK
-----END PGP SIGNATURE-----

--Ty33j4u5WgmG6v6/--
