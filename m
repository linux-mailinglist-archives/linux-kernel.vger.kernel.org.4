Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF7D636C29
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 22:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237385AbiKWVO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 16:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbiKWVOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 16:14:55 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F28E99E99;
        Wed, 23 Nov 2022 13:14:47 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.96.241]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N0Fl9-1p9ipK3S23-00xN0U; Wed, 23 Nov 2022 22:14:25 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id A32F03C0EF;
        Wed, 23 Nov 2022 22:14:24 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id D17FE1C7; Wed, 23 Nov 2022 22:14:22 +0100 (CET)
Date:   Wed, 23 Nov 2022 22:14:22 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] kconfig: refactor Makefile to reduce process forks
Message-ID: <Y36NLneaeXYYsPbK@bergen.fjasle.eu>
References: <20221123151828.509565-1-masahiroy@kernel.org>
 <20221123151828.509565-4-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Wr/NaX0zy4z36HtY"
Content-Disposition: inline
In-Reply-To: <20221123151828.509565-4-masahiroy@kernel.org>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:iyRv0ARNyPRD80Q6tpty6/xzzUinv+q7K+TN4MJCf+AfYc/6skT
 JuQ1stRx1Ku6jFw9/q223cvyxYyVN+H+NXQTPwCt/JIcBTjGGfW3JuDs9Rih+5atcDj6iSH
 +HFwVKYwhA1BEn6t9qlD6f9WhVcJudB2lZb0UQvVfyPqWGxJGLz425v0K46WsMusa8unsKB
 h3MzG/KTqNksw+qIOdTKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/66uLQKDS+g=:tY1JK1PMUj8WYgDdx0c9uR
 GTEh826b/Ydbyl92jVeUgjaSOtgQqXBCg/9vpE8prdQ8VxGZqJdwovTPoqtX24eE9PDWQSsLm
 mDLwV+c+i6fhJlEc6ALSYmsPZfEpujbt99KC5mDTTirjtB5CcCSXryn5dv19Breh5ePLEBiV1
 snTOQSm5mNagNF/Iop/ofFRYdEDFN/x0+6GQJjZlRyb3Xoo6YqjQvrfXLYOFqu5ORBK/lTKDI
 24WUSkJXcMJ8WH8yA6TgguRq5Hrjh6MZj3jXRhKojnbPppBVrEf6vCBBgHy3adCZ4/ir3Bnew
 yr6+d0dAvIRrIJWPjsx3ZjubI0Iyvn/IwuGlBOqHyErmVjjFmTYOQ1SEFL8FPAPz7otiYZMLc
 f/DuIaVjgodNHNJagCzzCHbmd03bdZmRT4Snvtu1YoixlqrZvllyI9w7xWJ6hl+xcC3Fh0CLl
 rL7DWo6bA4pLVBEcOEN0zHAzlBnjSYizyBAA0MIIw/0bdwTqsoq25umgLtrZifoP1QzoB22Eo
 4dQxvqGndKeIKVxPP6PaQ2f0kaKHaPfwWpF63B87PKC8BQQXfL1pnfZsxi4vxbThNdSD2Jr6s
 aslpNb/rNzLAq0NSXYYlT4vRDJJomd4LegU4jYkkkg2TQEUpyOJxnfhJYQ7gPOi0E1JeFdeES
 CR6XxlWeqU4G+v9AW2OX3YdztDwPL6tSfmPjnBeqzrS41xgIJ0LTmk6cLJVmTE1I1QWmI3rzw
 wXWZfeEqC1NJ0bJBq6Z9ioeK3k5G3BFjddNDb5I1ij3D3aTL4kat8gOnxpMTfvfvPtvsrDDiK
 ZV/qYb9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Wr/NaX0zy4z36HtY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 24 Nov 2022 00:18:27 GMT, Masahiro Yamada wrote:
> Refactor Makefile and use read-file macro. For Make >=3D 4.2, it can=20
> read
> out a file by using the built-in function.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

>=20
> (no changes since v1)
>=20
>  scripts/kconfig/.gitignore   |  4 +++-
>  scripts/kconfig/Makefile     | 43 +++++++++++++++++++-----------------
>  scripts/kconfig/gconf-cfg.sh |  7 ++++--
>  scripts/kconfig/mconf-cfg.sh | 25 ++++++++++++---------
>  scripts/kconfig/nconf-cfg.sh | 23 ++++++++++---------
>  scripts/kconfig/qconf-cfg.sh | 10 ++++++---
>  scripts/remove-stale-files   |  2 ++
>  7 files changed, 67 insertions(+), 47 deletions(-)
>=20
> diff --git a/scripts/kconfig/.gitignore b/scripts/kconfig/.gitignore
> index 500e7424b3ef..c8a3f9cd52f0 100644
> --- a/scripts/kconfig/.gitignore
> +++ b/scripts/kconfig/.gitignore
> @@ -1,5 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  /conf
>  /[gmnq]conf
> -/[gmnq]conf-cfg
> +/[gmnq]conf-cflags
> +/[gmnq]conf-libs
> +/qconf-bin
>  /qconf-moc.cc
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index b8ef0fb4bbef..da7da9775a4b 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -159,11 +159,12 @@ conf-objs	:=3D conf.o $(common-objs)
>  hostprogs	+=3D nconf
>  nconf-objs	:=3D nconf.o nconf.gui.o $(common-objs)
> =20
> -HOSTLDLIBS_nconf	=3D $(shell . $(obj)/nconf-cfg && echo $$libs)
> -HOSTCFLAGS_nconf.o	=3D $(shell . $(obj)/nconf-cfg && echo $$cflags)
> -HOSTCFLAGS_nconf.gui.o	=3D $(shell . $(obj)/nconf-cfg && echo $$cflags)
> +HOSTLDLIBS_nconf       =3D $(call read-file, $(obj)/nconf-libs)
> +HOSTCFLAGS_nconf.o     =3D $(call read-file, $(obj)/nconf-cflags)
> +HOSTCFLAGS_nconf.gui.o =3D $(call read-file, $(obj)/nconf-cflags)
> =20
> -$(obj)/nconf.o $(obj)/nconf.gui.o: $(obj)/nconf-cfg
> +$(obj)/nconf: | $(obj)/nconf-libs
> +$(obj)/nconf.o $(obj)/nconf.gui.o: | $(obj)/nconf-cflags
> =20
>  # mconf: Used for the menuconfig target based on lxdialog
>  hostprogs	+=3D mconf
> @@ -171,27 +172,28 @@ lxdialog	:=3D $(addprefix lxdialog/, \
>  		     checklist.o inputbox.o menubox.o textbox.o util.o yesno.o)
>  mconf-objs	:=3D mconf.o $(lxdialog) $(common-objs)
> =20
> -HOSTLDLIBS_mconf =3D $(shell . $(obj)/mconf-cfg && echo $$libs)
> +HOSTLDLIBS_mconf =3D $(call read-file, $(obj)/mconf-libs)
>  $(foreach f, mconf.o $(lxdialog), \
> -  $(eval HOSTCFLAGS_$f =3D $$(shell . $(obj)/mconf-cfg && echo $$$$cflag=
s)))
> +  $(eval HOSTCFLAGS_$f =3D $$(call read-file, $(obj)/mconf-cflags)))
> =20
> -$(addprefix $(obj)/, mconf.o $(lxdialog)): $(obj)/mconf-cfg
> +$(obj)/mconf: | $(obj)/mconf-libs
> +$(addprefix $(obj)/, mconf.o $(lxdialog)): | $(obj)/mconf-cflags
> =20
>  # qconf: Used for the xconfig target based on Qt
>  hostprogs	+=3D qconf
>  qconf-cxxobjs	:=3D qconf.o qconf-moc.o
>  qconf-objs	:=3D images.o $(common-objs)
> =20
> -HOSTLDLIBS_qconf	=3D $(shell . $(obj)/qconf-cfg && echo $$libs)
> -HOSTCXXFLAGS_qconf.o	=3D $(shell . $(obj)/qconf-cfg && echo $$cflags)
> -HOSTCXXFLAGS_qconf-moc.o =3D $(shell . $(obj)/qconf-cfg && echo $$cflags)
> -
> -$(obj)/qconf.o: $(obj)/qconf-cfg
> +HOSTLDLIBS_qconf         =3D $(call read-file, $(obj)/qconf-libs)
> +HOSTCXXFLAGS_qconf.o     =3D -std=3Dc++11 -fPIC $(call read-file, $(obj)=
/qconf-cflags)
> +HOSTCXXFLAGS_qconf-moc.o =3D -std=3Dc++11 -fPIC $(call read-file, $(obj)=
/qconf-cflags)
> +$(obj)/qconf: | $(obj)/qconf-libs
> +$(obj)/qconf.o $(obj)/qconf-moc.o: | $(obj)/qconf-cflags
> =20
>  quiet_cmd_moc =3D MOC     $@
> -      cmd_moc =3D $(shell . $(obj)/qconf-cfg && echo $$moc) $< -o $@
> +      cmd_moc =3D $(call read-file, $(obj)/qconf-bin)/moc $< -o $@
> =20
> -$(obj)/qconf-moc.cc: $(src)/qconf.h $(obj)/qconf-cfg FORCE
> +$(obj)/qconf-moc.cc: $(src)/qconf.h FORCE | $(obj)/qconf-bin
>  	$(call if_changed,moc)
> =20
>  targets +=3D qconf-moc.cc
> @@ -200,15 +202,16 @@ targets +=3D qconf-moc.cc
>  hostprogs	+=3D gconf
>  gconf-objs	:=3D gconf.o images.o $(common-objs)
> =20
> -HOSTLDLIBS_gconf    =3D $(shell . $(obj)/gconf-cfg && echo $$libs)
> -HOSTCFLAGS_gconf.o  =3D $(shell . $(obj)/gconf-cfg && echo $$cflags)
> +HOSTLDLIBS_gconf   =3D $(call read-file, $(obj)/gconf-libs)
> +HOSTCFLAGS_gconf.o =3D $(call read-file, $(obj)/gconf-cflags)
> =20
> -$(obj)/gconf.o: $(obj)/gconf-cfg
> +$(obj)/gconf: | $(obj)/gconf-libs
> +$(obj)/gconf.o: | $(obj)/gconf-cflags
> =20
>  # check if necessary packages are available, and configure build flags
> -filechk_conf_cfg =3D $(CONFIG_SHELL) $<
> +cmd_conf_cfg =3D $< $(addprefix $(obj)/$*conf-, cflags libs bin)
> =20
> -$(obj)/%conf-cfg: $(src)/%conf-cfg.sh FORCE
> -	$(call filechk,conf_cfg)
> +$(obj)/%conf-cflags $(obj)/%conf-libs $(obj)/%conf-bin: $(src)/%conf-cfg=
=2Esh
> +	$(call cmd,conf_cfg)
> =20
>  clean-files +=3D *conf-cfg
> diff --git a/scripts/kconfig/gconf-cfg.sh b/scripts/kconfig/gconf-cfg.sh
> index cbd90c28c05f..040d8f338820 100755
> --- a/scripts/kconfig/gconf-cfg.sh
> +++ b/scripts/kconfig/gconf-cfg.sh
> @@ -1,6 +1,9 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
> =20
> +cflags=3D$1
> +libs=3D$2
> +
>  PKG=3D"gtk+-2.0 gmodule-2.0 libglade-2.0"
> =20
>  if [ -z "$(command -v ${HOSTPKG_CONFIG})" ]; then
> @@ -26,5 +29,5 @@ if ! ${HOSTPKG_CONFIG} --atleast-version=3D2.0.0 gtk+-2=
=2E0; then
>  	exit 1
>  fi
> =20
> -echo cflags=3D\"$(${HOSTPKG_CONFIG} --cflags $PKG)\"
> -echo libs=3D\"$(${HOSTPKG_CONFIG} --libs $PKG)\"
> +${HOSTPKG_CONFIG} --cflags ${PKG} > ${cflags}
> +${HOSTPKG_CONFIG} --libs ${PKG} > ${libs}
> diff --git a/scripts/kconfig/mconf-cfg.sh b/scripts/kconfig/mconf-cfg.sh
> index 025b565e0b7c..1e61f50a5905 100755
> --- a/scripts/kconfig/mconf-cfg.sh
> +++ b/scripts/kconfig/mconf-cfg.sh
> @@ -1,19 +1,22 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
> =20
> +cflags=3D$1
> +libs=3D$2
> +
>  PKG=3D"ncursesw"
>  PKG2=3D"ncurses"
> =20
>  if [ -n "$(command -v ${HOSTPKG_CONFIG})" ]; then
>  	if ${HOSTPKG_CONFIG} --exists $PKG; then
> -		echo cflags=3D\"$(${HOSTPKG_CONFIG} --cflags $PKG)\"
> -		echo libs=3D\"$(${HOSTPKG_CONFIG} --libs $PKG)\"
> +		${HOSTPKG_CONFIG} --cflags ${PKG} > ${cflags}
> +		${HOSTPKG_CONFIG} --libs ${PKG} > ${libs}
>  		exit 0
>  	fi
> =20
> -	if ${HOSTPKG_CONFIG} --exists $PKG2; then
> -		echo cflags=3D\"$(${HOSTPKG_CONFIG} --cflags $PKG2)\"
> -		echo libs=3D\"$(${HOSTPKG_CONFIG} --libs $PKG2)\"
> +	if ${HOSTPKG_CONFIG} --exists ${PKG2}; then
> +		${HOSTPKG_CONFIG} --cflags ${PKG2} > ${cflags}
> +		${HOSTPKG_CONFIG} --libs ${PKG2} > ${libs}
>  		exit 0
>  	fi
>  fi
> @@ -22,22 +25,22 @@ fi
>  # (Even if it is installed, some distributions such as openSUSE cannot
>  # find ncurses by pkg-config.)
>  if [ -f /usr/include/ncursesw/ncurses.h ]; then
> -	echo cflags=3D\"-D_GNU_SOURCE -I/usr/include/ncursesw\"
> -	echo libs=3D\"-lncursesw\"
> +	echo -D_GNU_SOURCE -I/usr/include/ncursesw > ${cflags}
> +	echo -lncursesw > ${libs}
>  	exit 0
>  fi
> =20
>  if [ -f /usr/include/ncurses/ncurses.h ]; then
> -	echo cflags=3D\"-D_GNU_SOURCE -I/usr/include/ncurses\"
> -	echo libs=3D\"-lncurses\"
> +	echo -D_GNU_SOURCE -I/usr/include/ncurses > ${cflags}
> +	echo -lncurses > ${libs}
>  	exit 0
>  fi
> =20
>  # As a final fallback before giving up, check if $HOSTCC knows of a defa=
ult
>  # ncurses installation (e.g. from a vendor-specific sysroot).
>  if echo '#include <ncurses.h>' | ${HOSTCC} -E - >/dev/null 2>&1; then
> -	echo cflags=3D\"-D_GNU_SOURCE\"
> -	echo libs=3D\"-lncurses\"
> +	echo -D_GNU_SOURCE > ${cflags}
> +	echo -lncurses > ${libs}
>  	exit 0
>  fi
> =20
> diff --git a/scripts/kconfig/nconf-cfg.sh b/scripts/kconfig/nconf-cfg.sh
> index 3a10bac2adb3..f871a2160e36 100755
> --- a/scripts/kconfig/nconf-cfg.sh
> +++ b/scripts/kconfig/nconf-cfg.sh
> @@ -1,19 +1,22 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
> =20
> +cflags=3D$1
> +libs=3D$2
> +
>  PKG=3D"ncursesw menuw panelw"
>  PKG2=3D"ncurses menu panel"
> =20
>  if [ -n "$(command -v ${HOSTPKG_CONFIG})" ]; then
>  	if ${HOSTPKG_CONFIG} --exists $PKG; then
> -		echo cflags=3D\"$(${HOSTPKG_CONFIG} --cflags $PKG)\"
> -		echo libs=3D\"$(${HOSTPKG_CONFIG} --libs $PKG)\"
> +		${HOSTPKG_CONFIG} --cflags ${PKG} > ${cflags}
> +		${HOSTPKG_CONFIG} --libs ${PKG} > ${libs}
>  		exit 0
>  	fi
> =20
>  	if ${HOSTPKG_CONFIG} --exists $PKG2; then
> -		echo cflags=3D\"$(${HOSTPKG_CONFIG} --cflags $PKG2)\"
> -		echo libs=3D\"$(${HOSTPKG_CONFIG} --libs $PKG2)\"
> +		${HOSTPKG_CONFIG} --cflags ${PKG2} > ${cflags}
> +		${HOSTPKG_CONFIG} --libs ${PKG2} > ${libs}
>  		exit 0
>  	fi
>  fi
> @@ -22,20 +25,20 @@ fi
>  # (Even if it is installed, some distributions such as openSUSE cannot
>  # find ncurses by pkg-config.)
>  if [ -f /usr/include/ncursesw/ncurses.h ]; then
> -	echo cflags=3D\"-D_GNU_SOURCE -I/usr/include/ncursesw\"
> -	echo libs=3D\"-lncursesw -lmenuw -lpanelw\"
> +	echo -D_GNU_SOURCE -I/usr/include/ncursesw > ${cflags}
> +	echo -lncursesw -lmenuw -lpanelw > ${libs}
>  	exit 0
>  fi
> =20
>  if [ -f /usr/include/ncurses/ncurses.h ]; then
> -	echo cflags=3D\"-D_GNU_SOURCE -I/usr/include/ncurses\"
> -	echo libs=3D\"-lncurses -lmenu -lpanel\"
> +	echo -D_GNU_SOURCE -I/usr/include/ncurses > ${cflags}
> +	echo -lncurses -lmenu -lpanel > ${libs}
>  	exit 0
>  fi
> =20
>  if [ -f /usr/include/ncurses.h ]; then
> -	echo cflags=3D\"-D_GNU_SOURCE\"
> -	echo libs=3D\"-lncurses -lmenu -lpanel\"
> +	echo -D_GNU_SOURCE > ${cflags}
> +	echo -lncurses -lmenu -lpanel > ${libs}
>  	exit 0
>  fi
> =20
> diff --git a/scripts/kconfig/qconf-cfg.sh b/scripts/kconfig/qconf-cfg.sh
> index ad652cb53947..117f36e568fc 100755
> --- a/scripts/kconfig/qconf-cfg.sh
> +++ b/scripts/kconfig/qconf-cfg.sh
> @@ -1,6 +1,10 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
> =20
> +cflags=3D$1
> +libs=3D$2
> +bin=3D$3
> +
>  PKG=3D"Qt5Core Qt5Gui Qt5Widgets"
> =20
>  if [ -z "$(command -v ${HOSTPKG_CONFIG})" ]; then
> @@ -11,9 +15,9 @@ if [ -z "$(command -v ${HOSTPKG_CONFIG})" ]; then
>  fi
> =20
>  if ${HOSTPKG_CONFIG} --exists $PKG; then
> -	echo cflags=3D\"-std=3Dc++11 -fPIC $(${HOSTPKG_CONFIG} --cflags $PKG)\"
> -	echo libs=3D\"$(${HOSTPKG_CONFIG} --libs $PKG)\"
> -	echo moc=3D\"$(${HOSTPKG_CONFIG} --variable=3Dhost_bins Qt5Core)/moc\"
> +	${HOSTPKG_CONFIG} --cflags ${PKG} > ${cflags}
> +	${HOSTPKG_CONFIG} --libs ${PKG} > ${libs}
> +	${HOSTPKG_CONFIG} --variable=3Dhost_bins Qt5Core > ${bin}
>  	exit 0
>  fi
> =20
> diff --git a/scripts/remove-stale-files b/scripts/remove-stale-files
> index ccadfa3afb2b..64b14aa5aebf 100755
> --- a/scripts/remove-stale-files
> +++ b/scripts/remove-stale-files
> @@ -47,3 +47,5 @@ rm -f arch/riscv/purgatory/kexec-purgatory.c
>  rm -f scripts/extract-cert
> =20
>  rm -f arch/x86/purgatory/kexec-purgatory.c
> +
> +rm -f scripts/kconfig/[gmnq]conf-cfg
> --=20
> 2.34.1

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--Wr/NaX0zy4z36HtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmN+jSkACgkQB1IKcBYm
Emm/bBAA7kItv72TyhqsrK9InUKnoQzKgNjkCV9zcdYMcfQFVvsC3WCwQEHi9Q7e
snMEKAglCvxjXGnayVfPvMuPlpAzk1NUhCgrB2dVMSH5zOMHF/JXMvcWH+evNJSE
F0J0fUvxnIqxEOKV4YImwpdvpxdAEMhmPhYca9AQeZPitRt3e1ddtnZaNZoH1vL0
mEEssyNbp+ij3CGmuMZnMdC/jh7Cizt25jPDEMHeWIx4DhR9wRHQ0Jn3gsb7EIrp
aUE6ak5V2a8NxUGInAnDVnpLVtMrfcjajj1Umv76yNRRQ7tPowVH8LnmalxPsTDt
Y/eNAMimOBbV30ROJtUGSX0n2UxRGRBLbHyWIggcv783yd11WNctSpThXm5j9Fzk
SfjK6woaja0r+5G0R9UzBcjX23XF8GO7Nt6QrMCAWwb9B7HIW07YyA9fqbKf0w4Q
b5awfV9sM+SaS0JdB8QzMEMcPZuUPx/UG6v4DFeCDwFhbJJf0y75lmpj5qXgLrb/
4WuVrsrMCC/znJrKS8krw7+0AGsEV6ANibUYJg0FbgwP4HpuX3seY0nyeUPM5zMI
9hiFvANXqI1qursZ+PQ7b4pZZZCteaZDgu/8iFWWOGINIIAkDG4qQ+1CpoHJQY2S
+8NSLbIr1TJW5V6zgeFYGzRN6wxdBU4/Blo9LXX8+KF8c0/sD2A=
=a/BE
-----END PGP SIGNATURE-----

--Wr/NaX0zy4z36HtY--
