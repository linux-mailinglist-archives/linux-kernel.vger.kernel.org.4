Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F18464E695
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 05:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiLPEDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 23:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLPEDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 23:03:32 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02292279;
        Thu, 15 Dec 2022 20:03:24 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.98.53]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MuUWi-1ong0L3kfq-00rURO; Fri, 16 Dec 2022 05:03:03 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 2A92D3C0C9;
        Fri, 16 Dec 2022 05:03:02 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 8D9DE37A; Fri, 16 Dec 2022 05:03:01 +0100 (CET)
Date:   Fri, 16 Dec 2022 05:03:01 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 2/2] kbuild: refactor the prerequisites of the modpost
 rule
Message-ID: <Y5vt9VAq+4ZwM+fD@bergen.fjasle.eu>
References: <20221211130408.2800314-1-masahiroy@kernel.org>
 <20221211130408.2800314-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="39CEQ8qs9h2jyTJl"
Content-Disposition: inline
In-Reply-To: <20221211130408.2800314-2-masahiroy@kernel.org>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:5o/3v4kYEaQ+ZrFMrrgwRNxwnzU7maA2ZAD1PJrtNdff4l0P06Y
 9sOCzTZ9QbmBZtCuOh2LeNbw05eOjVFplvaCZt5SLaqYa7rOFb2G07L9JDM8tT5Ltge4agZ
 wWFUbCSBWdYIj97IpFAqdj+rQc25pTdk++RHrWx3PPGeRsz4f/B8JiJ/i5Sf30DRDCNSTWi
 HOS3ypw0Hj0Aos0y6QqMg==
UI-OutboundReport: notjunk:1;M01:P0:DeK8m75Yuao=;TH7Icpne3O4bzUuNAxOQNtr2LsN
 uv/wzJQ85gU9uxKcKbtWLFPlQHwYI8RW/YxQinREQPPoVWVlmqW00m9cDl3u3yGwkc/fFVlg6
 aqv1H85M/NBkvGfcwrsAlwt5LkAjOIAwmigHFKLB/OWzpcbdLZvuykEjMjNlRKrYgiVwtfbKC
 AJJ93UERkefIvY4cFifutn7FeXbX15WMXtBwLRtD5fhy7uKTg4iDmg0Nmjb2/o6TxKxAuyeXL
 ZCwunWiLlHxy5FsIRt9UcaSxuS2r9zXHK71wqtVbwBU5IRZJNJg8nOl1zVreKO0TPGAN2eqLr
 5zqn1BBR5b5u/isuGd6II8PBUeqOJYzDYD59tiQiDTHJLUEkxom9B3YAc9BEqrsvOStoWY8r+
 DDbTRyzC+DT8kI80eRIg9mid0aD2+XhtCmLTOcSKgE2m+lqQJ8vDp5EnnL27IBNbHYGJFkzbU
 DpjQ7D4W8E5yVMntpVcRypEmXjtDmprQOi8l2JcRAexp1W0W0FgWR041PkchEmGTauSuQbb5m
 +XXGuAEfgkKcwHiq4itYOijxSGj/WJK/HT7pYsrA1/tvKcAlLll2i9Rhqk1tETU+RSwWyDn39
 HxDrRQwb40ECcaGwCuZ5QMeFj77FQ/N5W+hljzi2TJ6znrFrX8+Ahgh7AWdmJecQvAUsvxlJv
 iSaOLHPt+/eH/WVL/Fk+NmmI+QxvcFT4HZ7SaLppzg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--39CEQ8qs9h2jyTJl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 11 Dec 2022 22:04:08 GMT, Masahiro Yamada wrote:
> The prerequisites of modpost are cluttered. The variables=20
> *-if-present
> and *-if-needed are unreadable.
>=20
> It is cleaner to append them into modpost-deps.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>




>  scripts/Makefile.modpost | 36 ++++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
>=20
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index f814a6acd200..5eb5e8280379 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -38,6 +38,8 @@ __modpost:
>  include include/config/auto.conf
>  include $(srctree)/scripts/Kbuild.include
> =20
> +MODPOST =3D scripts/mod/modpost
> +
>  modpost-args =3D										\
>  	$(if $(CONFIG_MODVERSIONS),-m)							\
>  	$(if $(CONFIG_MODULE_SRCVERSION_ALL),-a)					\
> @@ -46,6 +48,8 @@ modpost-args =3D										\
>  	$(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS)$(KBUILD_NSDEPS),-=
N)	\
>  	-o $@
> =20
> +modpost-deps :=3D $(MODPOST)
> +
>  # 'make -i -k' ignores compile errors, and builds as many modules as pos=
sible.
>  ifneq ($(findstring i,$(filter-out --%,$(MAKEFLAGS))),)
>  modpost-args +=3D -n
> @@ -78,12 +82,13 @@ targets +=3D .vmlinux.objs
>  .vmlinux.objs: vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
>  	$(call if_changed,vmlinux_objs)
> =20
> -vmlinux.o-if-present :=3D $(wildcard vmlinux.o)
> -output-symdump :=3D vmlinux.symvers
> -
> -ifdef KBUILD_MODULES
> -output-symdump :=3D $(if $(vmlinux.o-if-present), Module.symvers, module=
s-only.symvers)
> -missing-input :=3D $(filter-out $(vmlinux.o-if-present),vmlinux.o)
> +ifeq ($(wildcard vmlinux.o),)
> +missing-input :=3D vmlinux.o
> +output-symdump :=3D modules-only.symvers
> +else
> +modpost-args +=3D vmlinux.o
> +modpost-deps +=3D vmlinux.o
> +output-symdump :=3D $(if $(KBUILD_MODULES), Module.symvers, vmlinux.symv=
ers)
>  endif
> =20
>  else
> @@ -95,11 +100,16 @@ src :=3D $(obj)
>  # Include the module's Makefile to find KBUILD_EXTRA_SYMBOLS
>  include $(kbuild-file)
> =20
> -module.symvers-if-present :=3D $(wildcard Module.symvers)
>  output-symdump :=3D $(KBUILD_EXTMOD)/Module.symvers
> -missing-input :=3D $(filter-out $(module.symvers-if-present), Module.sym=
vers)
> =20
> -modpost-args +=3D -e $(addprefix -i ,$(module.symvers-if-present) $(KBUI=
LD_EXTRA_SYMBOLS))
> +ifeq ($(wildcard Module.symvers),)
> +missing-input :=3D Module.symvers
> +else
> +modpost-args +=3D -i Module.symvers
> +modpost-deps +=3D Module.symvers
> +endif
> +
> +modpost-args +=3D -e $(addprefix -i , $(KBUILD_EXTRA_SYMBOLS))
> =20
>  endif # ($(KBUILD_EXTMOD),)
> =20
> @@ -108,12 +118,10 @@ modpost-args +=3D -w
>  endif
> =20
>  ifdef KBUILD_MODULES
> -modorder-if-needed :=3D $(MODORDER)
>  modpost-args +=3D -T $(MODORDER)
> +modpost-deps +=3D $(MODORDER)
>  endif
> =20
> -MODPOST =3D scripts/mod/modpost
> -
>  # Read out modules.order to pass in modpost.
>  # Otherwise, allmodconfig would fail with "Argument list too long".
>  quiet_cmd_modpost =3D MODPOST $@
> @@ -122,10 +130,10 @@ quiet_cmd_modpost =3D MODPOST $@
>  		echo >&2 "WARNING: $(missing-input) is missing."; \
>  		echo >&2 "         Modules may not have dependencies or modversions.";=
 \
>  		echo >&2 "         You may get many unresolved symbol warnings.";) \
> -	$(MODPOST) $(modpost-args) $(vmlinux.o-if-present)
> +	$(MODPOST) $(modpost-args)
> =20
>  targets +=3D $(output-symdump)
> -$(output-symdump): $(modorder-if-needed) $(vmlinux.o-if-present) $(modul=
e.symvers-if-present) $(MODPOST) FORCE
> +$(output-symdump): $(modpost-deps) FORCE
>  	$(call if_changed,modpost)
> =20
>  __modpost: $(output-symdump)
> --=20
> 2.34.1

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--39CEQ8qs9h2jyTJl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmOb7fUACgkQB1IKcBYm
EmnRdhAApbeSmFO/BP9UYo1HAbNFVfS81AhnYDZoR8zlABYo2NWWSqlHIHZTLZ1F
nzwabsqNogql15TavV6fwzD9ronCNZmrV2qlDRG3gz+XRlxR6MKoDh1BBekQ2o4Q
l9jQdFy9lyul/Pn8oK7CLEoBHUUMrqW8xqDI85R1QQcg9NnaGdkbIRFEBu9cvy6H
MP+Kwy3gO4Z48SfaUNLyEuEt8swZEwVJ+Eesp3CzZs8uTAjw7U+SIta2abY+ghD6
iVQBfNLwMuCF2eOkpRZuG8hlZg+sJL31OmkZKs9Nom74Gjrn55u4zLkOjEPxu3VW
G+9rf3kugP7OV7MKGJeFyfd6DimRj3y/8mnO1i8BgY5xtyIO91RT/tZJuUaNDFQl
LnJrckJRHDtmpiiS/CURnHlgsUB23d54EsjfkJ+IdQ3YqGndrI2mMxcwdF9y/m68
DpyLRRVg0aayvtnpS0SitlS2NcjSzYj5s02Ey2g5kxGlA9UX94GVmKQ/h1eMHbts
qXu6jk5A/XeCiHkeeLZX/GinCekqjAkLSz8uEzDzQzc3+HCLNDqv9sYTeFK7WJs+
e92b0AQwKoRmjHbQwgAgngl+5WzufFeTljKK5G4h9bNWolzwvSQqEWqFb9aN4+it
/NWF9VRJBEmkB98SAAjVM5uT8H37zsHDhrJjgyDyUJiIl4RkP+w=
=z3HE
-----END PGP SIGNATURE-----

--39CEQ8qs9h2jyTJl--
