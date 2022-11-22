Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08ED663354B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 07:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiKVG2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 01:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiKVG20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 01:28:26 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E78913D1D;
        Mon, 21 Nov 2022 22:28:08 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.98.54]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mth79-1pCYBg1mwB-00v9MC; Tue, 22 Nov 2022 07:27:15 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 48AF13C0C9;
        Tue, 22 Nov 2022 07:27:14 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 0028C1D3; Tue, 22 Nov 2022 07:27:11 +0100 (CET)
Date:   Tue, 22 Nov 2022 07:27:11 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 3/3] [pending] kbuild: make forbid sharing objects among
 multiple modules
Message-ID: <Y3xrv58jyppN+MN+@bergen.fjasle.eu>
References: <20221113111525.3762483-1-masahiroy@kernel.org>
 <20221113111525.3762483-4-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VjckZX2DhrSKOq/T"
Content-Disposition: inline
In-Reply-To: <20221113111525.3762483-4-masahiroy@kernel.org>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:9dSva6jiUOlws9q+ec0atEE4wQ6uTOGhuZQu1zuRFeaUxMFeO7d
 SXTs+YXw6d1TEKXNgBlcF8dUM1W/a68g/JdSW+lD3e1a5AhaUyqizpprlANcBDuPd1jJKsg
 zmb1gootE75UO9T7EnzkP8J9maHClkq37Ri5q89okd8Mr3Ij408bWzkE8rWyYDCfW/ETqo3
 K7Nrl7FqjbBUbkdS4vWGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JkMHNWBrBl4=:uxgVJCwY12KX83fMAh1338
 JD5Zd+KRELqtuTkHTLn6AQN1JMnImlbSpmh693TNOA/ggSXtOJBHcnvE8Ga2DnvWwen1yxzmC
 1ImVdBWCfxauQRbtffWm172/zQRPq1OsbhZKTex9wOizaJYJkGDhlfJ8/VgMl4JTHqgYa+2tW
 yvUGRZ9Fs4U99oB/IqEo9VRB6w0cPFbFk4lPSbYQPJhZqRpyNyLb/428UfyxVIOkOb2OQXoWI
 iejPpAjAuq2pbN8B1MO9Bxg90kD0BhbmWOkX3B8pUo842rhOyvmFDFAsLp6FKgaGnJm2KxVBP
 +/4teWqfX1vDOo7XDo027TG6ILGaIm8UssLvmA/oihW/GRhOncSmxQk/GBnopvMFYRdGgoPUu
 bK9o8fX6QCyJEx7v4hB6cA9Zt0N4Z2RDrHnLq4KF/0lZjQcqGpaYJUKh4tQyBDueFIPaGN+20
 0bcla7R+V7nXxc+GoEZt6AosvyIaUw36jwamGBMtMfOIPvniONQYwfXugi337E2vC7whddBIw
 tXNKJQ10nn1vyR3PFmslPcnWFS7zLh5z6+2x8OvIu5hvwz8HlNa+W2oyImaoHBWG3piRFr/Wj
 Kd/hvUPzIpGl0QBtTDX0MBhU9e/4Fnt0ZWRY4QH2vu6f8LSYzNaYcWBgGPVGl5eoNnrCFJJ3w
 sJir1rH8zqftQ95DSrNia2YfEcycac4PXN8ZeraGpRy85IpCKObo5hu5x6WNVxIhWCzVsD6jX
 Tlk4CU2vjJlgVwDgfH+GSBoiyYNYVP4F0qEckSfq+DY/xYG/OIsUXU7YHPoIGbe0sz9dRaaoj
 GbYDnIs
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VjckZX2DhrSKOq/T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 13 Nov 2022 20:15:25 GMT, Masahiro Yamada wrote:
>=20
>  *** This patch is applicable after all the warnings are fixed.
>  *** It may take a couple of development cycles.
>=20
> Now that all the warnings are fixed, the warning can be promoted to
> an error.
>=20
> Simplify the modules.builtin rule because modname always consists of
> a single word.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

>=20
>  scripts/Makefile.build     | 6 ------
>  scripts/Makefile.lib       | 8 ++++----
>  scripts/Makefile.vmlinux_o | 5 +----
>  3 files changed, 5 insertions(+), 14 deletions(-)
>=20
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 799df12b53f3..37cf88d076e8 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -222,10 +222,6 @@ endif
> =20
>  cmd_check_local_export =3D $(srctree)/scripts/check-local-export $@
> =20
> -ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
> -cmd_warn_shared_object =3D $(if $(word 2, $(modname-multi)),$(warning $(=
kbuild-file): $*.o is added to multiple modules: $(modname-multi)))
> -endif
> -
>  define rule_cc_o_c
>  	$(call cmd_and_fixdep,cc_o_c)
>  	$(call cmd,gen_ksymdeps)
> @@ -235,7 +231,6 @@ define rule_cc_o_c
>  	$(call cmd,gen_objtooldep)
>  	$(call cmd,gen_symversions_c)
>  	$(call cmd,record_mcount)
> -	$(call cmd,warn_shared_object)
>  endef
> =20
>  define rule_as_o_S
> @@ -244,7 +239,6 @@ define rule_as_o_S
>  	$(call cmd,check_local_export)
>  	$(call cmd,gen_objtooldep)
>  	$(call cmd,gen_symversions_S)
> -	$(call cmd,warn_shared_object)
>  endef
> =20
>  # Built-in and composite module parts
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 3aa384cec76b..d73bfe0fabda 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -106,13 +106,13 @@ endif
> =20
>  # Finds the multi-part object the current object will be linked into.
>  # If the object belongs to two or more multi-part objects, list them all.
> -modname-multi =3D $(sort $(foreach m,$(multi-obj-ym),\
> +__modname-multi =3D $(sort $(foreach m,$(multi-obj-ym),\
>  		$(if $(filter $*.o, $(call suffix-search, $m, .o, -objs -y -m)),$(m:.o=
=3D))))
> =20
> -__modname =3D $(or $(modname-multi),$(basetarget))
> +modname-multi =3D $(if $(word 2, $(__modname-multi)), $(error $(kbuild-f=
ile): $*.o is added to multiple modules: $(__modname-multi)))$(__modname-mu=
lti)
> =20
> -modname =3D $(subst $(space),:,$(__modname))
> -modfile =3D $(addprefix $(obj)/,$(__modname))
> +modname =3D $(or $(modname-multi),$(basetarget))
> +modfile =3D $(addprefix $(obj)/,$(modname))
> =20
>  # target with $(obj)/ and its suffix stripped
>  target-stem =3D $(basename $(patsubst $(obj)/%,%,$@))
> diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
> index 0edfdb40364b..2faf4960aa7a 100644
> --- a/scripts/Makefile.vmlinux_o
> +++ b/scripts/Makefile.vmlinux_o
> @@ -74,13 +74,10 @@ modules.builtin.modinfo: vmlinux.o FORCE
>  # module.builtin
>  # ----------------------------------------------------------------------=
-----
> =20
> -# The second line aids cases where multiple modules share the same objec=
t.
> -
>  quiet_cmd_modules_builtin =3D GEN     $@
>        cmd_modules_builtin =3D \
>  	tr '\0' '\n' < $< | \
> -	sed -n 's/^[[:alnum:]:_]*\.file=3D//p' | \
> -	tr ' ' '\n' | uniq | sed -e 's:^:kernel/:' -e 's/$$/.ko/' > $@
> +	sed -n 's@^[[:alnum:]:_]*\.file=3D\(.*\)@kernel/\1.ko@p' | uniq > $@
> =20
>  targets +=3D modules.builtin
>  modules.builtin: modules.builtin.modinfo FORCE
> --=20
> 2.34.1

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--VjckZX2DhrSKOq/T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmN8a78ACgkQB1IKcBYm
EmnhQg/9EEV5vZBzJLV4fQSonK2cdqsD/RbAYWllq4CTdaCKPVDSxnuv/brx1kBF
ARIor++8mlyD2UAp5/bUlza9aW+5wOzjJzwlr2g8ZnyU1W7p3TLEHrc+toDf0i6V
36RzQaLzRA7HriJoJtKBiJ83Q6ZTxgFaoVFvxMUlqbCKyBQweYadVrf6B8g0kW2S
KIvjxreL+17Yy09uYGkwpYe1ZZHz5SNv0eAdDf3y00xXOZ9ErUb+BYJoiN1G3NOf
VPaSZV4sXJfSd9XpKwvH7dBp5RZ2nHNxkeu07sEfJ34sfD3W0YY+EonBHBcuERUw
X1MQUfGtXxQoIsb0qWrDUOqAl+gyrTjR+5NJ9GQYad563fVPfZOR1CcA7vKTJg+z
tn0A0RFY//2nt16QoyXGVPaKodios2U5tywOXLfkHwgDlJl+s8UAjN3xKt92ZIx7
/WYgqz4ncKReifz+Ouu6fcWGtDCqFRQm45DFVQWF5RM+0Aa+J5Zz1U9exQON3Swn
MPsJvYPTsKIs9tpTHSL9DkA0u/MyueMbtzHK6uaXXln0QBTHdSOeutBb3Vkzp1If
x3pkZK17BGWM+XnWDM7rvqmz+R5Oo3mkold8bczA4I/KJnrsQmhzB3QPKX1CHFbl
tBICCEE3Xwh0EOodWbPhpEJw+IM3z/vQDFPC+b50jkqCC6fBXGI=
=w+we
-----END PGP SIGNATURE-----

--VjckZX2DhrSKOq/T--
