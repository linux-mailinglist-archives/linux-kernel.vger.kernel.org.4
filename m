Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6B86BBE0B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 21:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjCOUjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 16:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjCOUjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 16:39:05 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E835B12BF9;
        Wed, 15 Mar 2023 13:38:55 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.97.62]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N3bnP-1qc2cj2Idv-010djW; Wed, 15 Mar 2023 21:38:18 +0100
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id A9A123C1C5;
        Wed, 15 Mar 2023 21:38:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1678912694; bh=N+mbbfFNn6CMjDTf08cZjncaJpXxk50D8DOBGI3wZzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FbGTjHZRy6CXya8L2+ld7y+r8j1c2LFy65faNNPwvXJ7mqrpgffhwOHrwXvbMYLSn
         IbN39dK20hkUZu7fJMZYxH6OtlNU8W4bjhodbtQtE6fySyjLvF0+t3UBChSxjpcRJ1
         HMTv6GV/o02IsG3KAkum9PIQYkVzrVwPLApnUtD0=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id B24C93312; Wed, 15 Mar 2023 21:18:08 +0100 (CET)
Date:   Wed, 15 Mar 2023 21:18:08 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Riad Abo Raed <riada@nvidia.com>
Subject: Re: [PATCH -rc] kbuild: properly exclude linux.tar.gz from tar
 archive
Message-ID: <ZBIoACq0+FGN4752@bergen.fjasle.eu>
References: <e0b06d9aa9f37156c4317f9915a7a0e247edb70f.1678907179.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZNfAOrrj7+0vzv2+"
Content-Disposition: inline
In-Reply-To: <e0b06d9aa9f37156c4317f9915a7a0e247edb70f.1678907179.git.leon@kernel.org>
X-Operating-System: Debian GNU/Linux 12.0
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:8/8C4R9WR1S5bKh5MGTjJ1voTNH/zZ9vVMuGgu85maP2Oe0+GYH
 Xfe8lFmHnw4MzQYjlKBQKuiJbvyp/0BlB3C6wXIpbBOAjJ/bC2/w3pjwUCrpB4wBUaQFHYe
 SQEyZgAA9xbSAKx1x+9p4mtW+QC2BA2teurHsJzHvy4hgiiwa2BwtStm87NWXJSkTVyO6JO
 xnGCxjJueUiP1l2kLN3BA==
UI-OutboundReport: notjunk:1;M01:P0:dgqh4BN1fTE=;oFYw92yhXBfQg7IyXpCl5hMTwCe
 Px2fz1PSVRx0F5JNttoR/d6mPt47g5EZKXhM/Yldsh6dI1FylNlPXnsB7qzTwJ5mjT8ITBUjO
 DheIE2gObfNUewU3tupDpqreyaFvQMlOHIW6Ch+0hTuLOb9gqyCiGqBL7ma5ONznlWqYhFBfk
 Rk+fcRP+DYIGBkbuPmx7RZZWuk9e/IX5xQ0o6a+BcOr8BFlADjcbsHOlhexlftgreTQIxcQaV
 G0LkhXWowjjKvtZGPXgzwjslkYM5fOA2nSTFMu5GgkFzEWtczHyCZIvCuqP9sI2ZchQcd9tta
 9nJxHaEjZmOhCmqSurATQ6oUmtAxtrhJ8nGgFyaxNq6gjH1Z7xQkxZPXf2s0i+ssawt+JV/Iv
 xx5TJ+62bn6ylmcXec4QFML1yGddh3ag1i5gYfI9wqPMv0PqiVgPHvz6Xa04qluIEQZ9xsm6P
 CG84Gfix/si+qwCbX3cuMJ37jbJX9l2gs6RuN5dVq7hyVHFUHiCdH7UARZuRov6Y3ak5sAEt8
 bWjy36YT4uGpgdkBc8K3jXT0aFO7Gz6hppuFzN6QLiILsuIdrcXIw23ZwqECrasv3BVY5bnlj
 7FBGyseARpJirnL/y7CXiZuRvT/AsB3gdLFVDyYqxjjBSNj9zHGK4j79Dpvlsl8IFey1m2MNI
 zyk9PwQCQ7RCvzqKwvKh+Ntwz8BN3Khntfpz2JhqIA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZNfAOrrj7+0vzv2+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 15 Mar 2023 21:09:33 GMT, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Attempt to build rpm-pkg randomly fails in tar stage, with same error
> as was reported by Nicolas [1]
>=20
> tar -c -f linux.tar.gz -I pigz --exclude=3D./linux.tar.gz --exclude-from=
=3D.tmp_filelist_exclude --owner=3D0 --group=3D0 --sort=3Dname --transform =
's:^\.:linux:S' -C . .
> tar: .: file changed as we read it
> make[1]: *** [scripts/Makefile.package:58: linux.tar.gz] Error 1
> make[1]: *** Deleting file 'linux.tar.gz'
> make: *** [Makefile:1657: rpm-pkg] Error 2
>=20
> The reason to it that tar is dependent on order of command line
> arguments and needs to have excluded file before creating it. So as a
> solution, touch that file to create it and move --exclude list before
> any tar arguments.

thanks for digging into and proposing a solution!  I'm afraid it will=20
not be taken because of [2] will make the whole cmd_tar definition=20
redundant due to the use of 'git archive'.

Nevertheless, this works for me.

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

Kind regards,
Nicolas


[2]: https://lore.kernel.org/linux-kbuild/20230312200731.599706-7-masahiroy=
@kernel.org/

> [1] https://lore.kernel.org/all/Y%2Fk+v%2FYj8VQ6q32H@fjasle.eu/
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Fixes: 7bf4582d7aad ("kbuild: deb-pkg: create source package without clea=
ning")
> Signed-off-by: Riad Abo Raed <riada@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  scripts/Makefile.package | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index b941e6341b36..be4623481ca2 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -44,7 +44,7 @@ filechk_filelist =3D \
>  # ----------------------------------------------------------------------=
-----
> =20
>  quiet_cmd_tar =3D TAR     $@
> -      cmd_tar =3D tar -c -f $@ $(tar-compress-opt) $(tar-exclude-opt) \
> +      cmd_tar =3D touch ./$@ && tar $(tar-exclude-opt) -c -f $@ $(tar-co=
mpress-opt) \
>                  --owner=3D0 --group=3D0 --sort=3Dname \
>                  --transform 's:^\.:$*:S' -C $(tar-rootdir) .
> =20
> --=20
> 2.39.2

--=20
Nicolas Schier
=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--ZNfAOrrj7+0vzv2+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmQSJ/8ACgkQB1IKcBYm
Emkf8xAAhJC8w5JrlgSoLHDujX1Aet6I+oAEFvnxuC+Kwt+rZC3hN+CHoVGepv3v
7QX/TkJlfvS7Kli3qQZfZ0t2a3rG19bsWaElKBOs5cvBy0Py4AXvDRigxYUN6Rio
2DcBIHDr4336RjNeoQrIVqd1I0D16l6FyLQyHpts90XdEaIWdzjp5GZmd29RIDpB
b1TYQSzTIK0n/R+rNK0rblC2kjVtQBILoh5uWPdsxl0YrPMBPVZhQ+4lfeiBs+uv
+voc7IEdmmqqkziAEkOb1VvV9g7BjGmQDUpV2Yp8lkkVTA0vNF1JgCu9/fubpYV5
Rt0ArRm4eo95i6ow2sJ45l15ICneR+AJ3u+FFGqXK87gWY1Ho9vunxbYgJPnqR9d
dfCbwbCSsBs4UUMU3vjsbboozl0xb9Kl2or4PKVXG7vHiloiwIu8yQ8uerUbXZ6P
jnTB4cp0sH+oO1bZ7s5rt8Zq8Ryw4BvZxpPj3AZJfvl4htRT0bwtdPplKDukqOG3
qSa4IzMDtPW5wWTAuOiGah8fhY3iNqo54JvRj/UDVii3Wv/p0H2YSWm31QiVbnn2
zzA8QgPBL5HrpfCx1Mec0KjzFilh1QBAwIHhUEwv3xOy965/DGeyNcfzSqxiR25w
cANuF9oxr7Z5l/rdWBc+GU0Z1D7ZlvWnWLv2adaVkLkxPJnRJMw=
=qWQz
-----END PGP SIGNATURE-----

--ZNfAOrrj7+0vzv2+--
