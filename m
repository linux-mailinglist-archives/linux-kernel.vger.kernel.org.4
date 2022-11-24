Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DD76372B9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 08:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiKXHMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 02:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKXHMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 02:12:14 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D4ECDFE4;
        Wed, 23 Nov 2022 23:14:12 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.96.241]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MA88C-1oma1f1qQM-00BdGQ; Thu, 24 Nov 2022 08:08:13 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id D27F83C080;
        Thu, 24 Nov 2022 08:08:11 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 3B75E463; Thu, 24 Nov 2022 08:08:10 +0100 (CET)
Date:   Thu, 24 Nov 2022 08:08:10 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 5/5] kbuild: check Make version
Message-ID: <Y38YWrlPTpB7LoIY@bergen.fjasle.eu>
References: <20221123151828.509565-1-masahiroy@kernel.org>
 <20221123151828.509565-5-masahiroy@kernel.org>
 <Y36OZVnAZBqxcrBw@bergen.fjasle.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OSEL46hI/6K+vX1j"
Content-Disposition: inline
In-Reply-To: <Y36OZVnAZBqxcrBw@bergen.fjasle.eu>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:JX0I0lhJDp/CMa7drMJI6pazmnCf088UlK1G+QrVL67D+eF5SJc
 N/DcD1e/du76JKVq/x72l0nXn7vmiDzCnqDD3fM2dtuCqwyWaFbImocZtW8pd8Hc2yC0Wms
 iLbZd9emRJJ58UgCWXXn/z1t5pwc1PIzCtkdUutZLAOd7edU1Uoqw0Js7PWwMXOcACFVRWO
 GveM51/dM/qjnM4ZAlg/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yKOmiwQGI24=:11a/5aiIz094OY6CGEU3gv
 HKtRSpYVx5XxiKT4Jd/0bzUUVBeGqbUt2K8kOXnilvnJa1sY3F42L67M11ysF1qglI4FX1c0I
 yrKCOtRHeAcSWixtoezt5DYPGzPGDsQygt4p2Icj7v8DJ8kzHlfJEzEAGjXDe4HkT7b4npr8f
 gizpUxUBfl3ovsB14CzSuD4PALDLk1mwrS0odU/K4ocsOQTy8Xc23Tlwg4shZGveXX1aJzh4s
 lzKR2V1Ufv8fnqGWuSwgjpDhs0RGEan+Rqy6eJf03EKhqN9onShXcs4AbwZOLZQK6AEb2Fi1i
 yiZwy0DSrEdwjwjuh/kooJzPP4XI2g9IPRqxHWAhAKcZei5ZklFfxWWDTdShO2nVUT90+zF8L
 DZoHUADnxVd48h4rICEkWPUxBF2PutsQOQkQwL+oPYqDOS1kSwHnkHieL8zgR7q/I3ZtxGbFV
 i/M7jzMcEvTJNUy2qald+Gf7JQSWXF2xF9oMDbHYz96l1IfqtkrU86zUszRlKuszfGwODGXYi
 iC+ngnyZXyhVcbpe7/lh/xPRgcDX79t+8sPr49NtoPtr3Tz+acY60kB4vpJGUcmM4Ft83/tpr
 x648NV0FdSyEwNCkQ1yi/wCJpzFBSThOlRpqfexG45d86bzbyVPC/yrD3iRlZriuhqdHDoDXX
 4UIC2OE3Qdqms5U09dqrKlpBfvX2qPVSHoCN/nccJBEgyopUJldx4jfeH5dod3y+lNO3Axlv5
 YR/uGJRKGcamBHRI+IrJ1ZwYynX4IIz88iO4wAURSNcBltiBQjLP/JQb6VjtQBbCQa5uN4KhS
 cU7FEN5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OSEL46hI/6K+vX1j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 23 Nov 2022 22:19:33 GMT, Nicolas Schier wrote:
> On Thu 24 Nov 2022 00:18:28 GMT, Masahiro Yamada wrote:
> > This is implemented based on test-le. It will work until GNU Make 10
> > is released.
>=20
> ... and as long as nobody uses make versions w/ minor version numbers,=20
> cp. patch 3/5.
>=20

I had a wrong understanding of the ASCII sort and forgot to re-check my=20
own assumptions.

Thanks for that whole patch set!

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>


>=20
> >=20
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >=20
> > (no changes since v1)
> >=20
> >  Makefile | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/Makefile b/Makefile
> > index 60ce9dcafc72..797fafbc1b45 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -368,6 +368,9 @@ else # !mixed-build
> > =20
> >  include $(srctree)/scripts/Kbuild.include
> > =20
> > +# Check for the minimal Make version
> > +$(if $(call test-lt, $(MAKE_VERSION), 3.82), $(error Make $(MAKE_VERSI=
ON) is too old))
> > +
> >  # Read KERNELRELEASE from include/config/kernel.release (if it exists)
> >  KERNELRELEASE =3D $(call read-file, include/config/kernel.release)
> >  KERNELVERSION =3D $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SU=
BLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
> > --=20
> > 2.34.1
>=20
> --=20
> epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
> =E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
>      -- frykten for herren er opphav til kunnskap --



--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--OSEL46hI/6K+vX1j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmN/GFUACgkQB1IKcBYm
EmlIyw/+Idg8UnMhykjqhkYbuAoQX6yYOWfIZ9HyPHVkn4RuFJgiZnzjsDGOsfY9
H1dthbFSDhuyet1/cnns7NwPiSJx4nhHIHKe0hxUkQgjjmoFoUUUGbx/q7cS6nNX
V1FN9rD/M5xfCxJKkresr8NNifvyy1POZFt0b8hE0wWx1cWEtN9p/0r0+C5hSHwU
uNDQiv6IbL0GtUgBRogfx5w3kXSk0ja86SNcumcKJHCnAf3SlAAORvynpzfsZ0Ea
NQjLlUx0ZczIL+O4koBo5tyo2QV4v9ChOhsjVH4QaPz6oXpHUG35+qiKH6GQEgCK
Nfgjv9UzcsNarbOHAn/DGCk/u5p2k8zmJbr0KeMlZ4dab9l7k+ySzT31DccvL55W
4Qxa7yJcpgMgJ3Il/p4eldCo+6rWRL5uDs4NELYjPS4bCi49dzXuqu2qE2fZoDwK
sCrRv45IRjRzIlN85mjxvlFXB4FSOGgB5V035McTcJh+mbyQCUh8jLeJ4uvM3sUD
zk6fgb5N6xU4iVsfEbMavfRzHlsyuv294XLGOz9Gg+usu1ZpWO5xVEoMZlk1aY1o
+PDUjtvuKVhYWp7wal1WegyBOX7nwsfwrqY83boEjd5RwhMV7xe5LBjpvMnyF2IC
Plktpd1qfQ6ex3Keh0xrkQUKLMn+DSu9BnlsXTMZ5TYrq4w4USI=
=+eIc
-----END PGP SIGNATURE-----

--OSEL46hI/6K+vX1j--
