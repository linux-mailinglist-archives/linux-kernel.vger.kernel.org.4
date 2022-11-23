Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59C7636BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 22:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbiKWVCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 16:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiKWVCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 16:02:09 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D59726AC5;
        Wed, 23 Nov 2022 13:02:01 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.96.241]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MnpP8-1pH6KI0U9K-00pKDQ; Wed, 23 Nov 2022 22:01:36 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id A16203C0EF;
        Wed, 23 Nov 2022 22:01:34 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 785271C7; Wed, 23 Nov 2022 22:01:32 +0100 (CET)
Date:   Wed, 23 Nov 2022 22:01:32 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 3/5] kbuild: add read-file macro
Message-ID: <Y36KLFArg5etHRD8@bergen.fjasle.eu>
References: <20221123151828.509565-1-masahiroy@kernel.org>
 <20221123151828.509565-3-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IStGSYRrJzEGCFD2"
Content-Disposition: inline
In-Reply-To: <20221123151828.509565-3-masahiroy@kernel.org>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:zG9e9X8a39B8rnpM3o8B7wMFo/xQBlRAYlQFb5XP9+aCkowEr4u
 deBfRhF7R9Utj3eyxgT4EJ1Yc14VF+Y6XyTMA0dR6/rJKcadlLIngS78Bf1JQ20VmIjNWyi
 +dvjfkHYBHU9EZuB3ry7HfcI5+5zGmsyoRMn5PhcU7hRdB5hx0o/Zn0/tAs6vbu2LW5A1sM
 T938MWsnbH5qJD9eITi3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A87XWYxTB/M=:S4waD9FV4TdudxxkXKzqHp
 3UxrnQunlA3Gic/nYJ+oT3HI+Ik37JHz/VZU31NnhX2QiRRG7buyzPUm4NmusUk5h9DMtcbeI
 UnbWcGOo/qv8hCeczXUKb/fdNbBx9IiHOMe3P3apnNfyHY4vJjFlzjzjsgllE4/xtIk2LWFTS
 yFD3ACkUkCWAbZFIBmA13l8mJBVMPX1c9vsq4AxPBYdnooSNU8B2Sq7KI4l5n/T4JjWsvlvr5
 /AHSZethJvM1o01Uz8GalZ4lQz8gRYLdd09GjaTCKaKVZ2uSBwioy84kHAHDPmucaGsHDVseT
 d5HeWXOzbRZjNU9DwrmiuSVAJa4bKcdCl7nc4avOpirgHne4V/006bSORbWtS4tiqyyS6PaJ8
 98FVSaX5FsB8PcPsovAJno936sdjvRRwB4U/XrvHHy/JrcFl6OYzhWSNWtz/1NN83NgXQvS68
 ccNcKWz1ftE8sKj/ZykOdLqulOdm5xdP14VXjBZas/biJ04Lmxl16K0Foelohr4CkQl6c/e4L
 mgwvWsNBNEtmF9kmLmexbCaSqVzj0DDuxmby0uj0UvmoaWE6KOSLp1PGm9wiyroOXdEghpOev
 FARUKLAKuFJFKxqTlWA6h4TwznNyGyuR6seirDqrD/Iz32yQ9mclNhPbMEEWZspwMeP4jMsaq
 q93QK/2+u/KtmQV32nB5cnzlRi44rxsjApSv9ycqL2cyedaHGx9M0BstsaRk7ZPScnZ7I3JL+
 iT9xH+vGduOiS8UORROeJCOql1GSDxSsRtfPRR2/qpCSO2WLk48Qp95B9Isl5OaZmf1O+8mXP
 IkyQKwc
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IStGSYRrJzEGCFD2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 24 Nov 2022 00:18:26 GMT, Masahiro Yamada wrote:
> Since GMU Make 4.2, $(file ...) supports the read operater '<', which is
> useful to read a file without forking any process. No warning is shown ev=
en
> if the input file is missing.
>=20
> For older Make versions, it falls back to the cat command.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
> (no changes since v1)
>=20
>  Makefile                  |  2 +-
>  scripts/Kbuild.include    | 12 ++++++++++++
>  scripts/Makefile.modfinal |  2 +-
>  scripts/Makefile.modinst  |  2 +-
>  4 files changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index eb80332f7b51..60ce9dcafc72 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -369,7 +369,7 @@ else # !mixed-build
>  include $(srctree)/scripts/Kbuild.include
> =20
>  # Read KERNELRELEASE from include/config/kernel.release (if it exists)
> -KERNELRELEASE =3D $(shell cat include/config/kernel.release 2> /dev/null)
> +KERNELRELEASE =3D $(call read-file, include/config/kernel.release)
>  KERNELVERSION =3D $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBL=
EVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
>  export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
> =20
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index 9996f34327cb..722846c23264 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -10,6 +10,10 @@ empty   :=3D
>  space   :=3D $(empty) $(empty)
>  space_escape :=3D _-_SPACE_-_
>  pound :=3D \#
> +define newline
> +
> +
> +endef
> =20
>  ###
>  # Comparison macros.
> @@ -55,6 +59,14 @@ stringify =3D $(squote)$(quote)$1$(quote)$(squote)
>  kbuild-dir =3D $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
>  kbuild-file =3D $(or $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Make=
file)
> =20
> +###
> +# Read a file, replacing newlines with spaces
> +ifeq ($(call test-ge, $(MAKE_VERSION), 4.2),y)
> +read-file =3D $(subst $(newline),$(space),$(file < $1))
> +else
> +read-file =3D $(shell cat $1 2>/dev/null)
> +endif
> +

I like the implementation of read-file, but I am afraid that the=20
MAKE_VERSION comparison breaks all make versions w/ a minor version=20
number: 3.99.9x, 4.2.x, 4.3.x.

Not beautiful, but this might possibly work:
  ifneq ($(filter 3.% 4.0 4.0.% 4.1 4.1.%,$(MAKE_VERSION)),)
  read-file =3D ...


Kind regards,
Nicolas


>  ###
>  # Easy method for doing a status message
>         kecho :=3D :
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 25bedd83644b..7252f6cf7837 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -13,7 +13,7 @@ include $(srctree)/scripts/Kbuild.include
>  include $(srctree)/scripts/Makefile.lib
> =20
>  # find all modules listed in modules.order
> -modules :=3D $(sort $(shell cat $(MODORDER)))
> +modules :=3D $(sort $(call read-file, $(MODORDER)))
> =20
>  __modfinal: $(modules)
>  	@:
> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> index a4c987c23750..509d424dbbd2 100644
> --- a/scripts/Makefile.modinst
> +++ b/scripts/Makefile.modinst
> @@ -9,7 +9,7 @@ __modinst:
>  include include/config/auto.conf
>  include $(srctree)/scripts/Kbuild.include
> =20
> -modules :=3D $(sort $(shell cat $(MODORDER)))
> +modules :=3D $(sort $(call read-file, $(MODORDER)))
> =20
>  ifeq ($(KBUILD_EXTMOD),)
>  dst :=3D $(MODLIB)/kernel
> --=20
> 2.34.1

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--IStGSYRrJzEGCFD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmN+iicACgkQB1IKcBYm
Emlapw//dSlAM2i3DA+H2qGt+uzprRV1q12wKCcZB1ISKwHv17OCXfAk4PXdaP+k
mq47ASea8lA+OkYhY4ZS7Id51WzORDhVM8foKgOm9pgmtiD+oxenHi+PkAILZ3e+
SdFAptQNUV9lNl3xZNHWUlHkKw6qbRvyBBxN+Qu1JieWqvOpQwixT/SHFj/2WszG
3rNmePrbbfx70mtoefxOxtWvv2+H6G2eV5VrJsTy+naNPMRsXvXKOeMgP/YFXCxA
Jn3N26OJLr2Axx2gQytPIWWyvla3k6y7PIK8NRoYb0f+u8VRjGEqGstL1fMZM//i
rUw4yisUbiTzgj3AIKd3Oo5wKWX3rPKdlZbcSfwf7gjHV4zEAWg/ufv+wUnB+ZaC
T0ZYCq5G2ok05FdBnlQqDNoT58FnLrE98xgZ/AxGaTrB788O2Kw/rn4iCGZyegia
iLL/TTiJkxu/diNv8JIGHonZQJ36Hvi70T8CwZFleToO5120hCrt4D1CYPEZ1tym
LQQq3GwW5tIfHqJOgNTEp/LojXT90RAIR84yuDK4oJIK971L0RlteUA7WjnvmeZw
NZ7Of55lMBY5xTuPSUkSOBbm2NiVnNBuyDEllXBwv0qywRSHH24Ez1uIdIRTLGbp
70L37m/z1oLCpvSEQ7KrRC2/ZgnamBz3U53od6/kNF+gWOumEyA=
=PcKY
-----END PGP SIGNATURE-----

--IStGSYRrJzEGCFD2--
