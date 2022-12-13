Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DD464AE9E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 05:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbiLMESr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 23:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLMESm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 23:18:42 -0500
X-Greylist: delayed 1168 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Dec 2022 20:18:36 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C725192BD;
        Mon, 12 Dec 2022 20:18:35 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.49.245]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M5wTt-1p1tgF13Gt-007R4o; Tue, 13 Dec 2022 05:18:12 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id C93C83C0EE;
        Tue, 13 Dec 2022 05:18:10 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 2820A381; Tue, 13 Dec 2022 05:18:04 +0100 (CET)
Date:   Tue, 13 Dec 2022 05:18:04 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] kbuild: do not sort after reading modules.order
Message-ID: <Y5f8/BCOpJAqKgcd@bergen.fjasle.eu>
References: <20221211094919.2717594-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Upav2svuIRAE6goJ"
Content-Disposition: inline
In-Reply-To: <20221211094919.2717594-1-masahiroy@kernel.org>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:dusdd3ZvI66iLKPsiSw3XRx26yaF1bifpOM6avUoVkxvjA3PrmW
 xf4OiDO2NYPqmaNcH2u+PcvmAAE+4WQL5rj5fjRUmS4B4BrzkNvAZ3IZaCNcxoqVgGjZrs8
 IZ2m9Gz4runfFIriqQ9JjZ86bafdc6yu6pAFI2HdZpF2nifekeCrybDPIpTdKwqKFRLzYQ/
 nLtlsZhskvZpHeUnZVWXQ==
UI-OutboundReport: notjunk:1;M01:P0:Zt+MErAqjeQ=;V+gC71bwH++jfPY3DSYatp17Kgc
 ezu2trfwFLvE1xZh5Q4Cc51DIDkNo3o7TupAYqAih4D9xYhS5V+iSaDVncPhhq+2YOEwqUW7Z
 tB1FJHx1SUU5rhfoimjqs5mfqrpAeXw6AuDMtSvD+rb7xfuCX/95taIYAIz7H/bN1Inxoo/0A
 7lucphi4kGcCn0TkenjL2Zm2foih9TY8wWD8/42ymWCTQgxx1NKFOScTK37dz3jgSnRUFJGiX
 9KYu5a8ABxd8tbT4jB/HOMu4KrnzXp1771ttrOqRKri25xn2RjlSxrNjX5TLhkCT+Klc/+Rt7
 0KE1NgYrErx77eTr6TZsRInA9A0PWZxw0wfAqXx3Zq/NfUvTDpmDz6BCzea+22Kty0IeJ9Fme
 W5YZQMS4Qwcx2eJxH5tGcMMHMmsJeJz3vKJWnAtNSagMoo7UC/medJAQ3bCbabbEvGT3z1xRp
 3IlWvDqE8oh9C5s3DqnDyeLJ85XYUyzaVJSCTyl30+UvuzXOftYrKqo8Y5rJ24K85mT/1Y3DF
 TfXmcbs8sLppLpqbQ2VyHm+wvcwmBfKHgOzSc6ethZcnhVNMMr1/IW7cvXeQAaXjG8G/SHKgs
 o9JDwvQ/y452wdQkuX8TRg3Wv4J29r9fxK/lvB/HRoEgrLwGL/yUsUsVovhJN/zx72F+UyipK
 V+vc5FhMpjgQRRy+Bh7UeyNd6D3fE5UDSpKi/haNXQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Upav2svuIRAE6goJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 11 Dec 2022 18:49:18 GMT, Masahiro Yamada wrote:
> modules.order lists modules in the deterministic order (that is why
> "modules order"), and there is no duplication in the list.

Isn't a subdirectory's modules.order just created by
concatenation of $(obj-m) (w/ respect to mentioned subdirs)?
Thus, "no duplication" seems to be true, as long as there is no obj-m=20
containing duplicated entries.  Do we ensure unique entries in obj-m=20
only?

Kind regards,
Nicolas

>=20
> $(sort ) is pointless.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  scripts/Makefile.modfinal | 2 +-
>  scripts/Makefile.modinst  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 25bedd83644b..4705d32388f3 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -13,7 +13,7 @@ include $(srctree)/scripts/Kbuild.include
>  include $(srctree)/scripts/Makefile.lib
> =20
>  # find all modules listed in modules.order
> -modules :=3D $(sort $(shell cat $(MODORDER)))
> +modules :=3D $(shell cat $(MODORDER))
> =20
>  __modfinal: $(modules)
>  	@:
> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> index a4c987c23750..f4cff42069ad 100644
> --- a/scripts/Makefile.modinst
> +++ b/scripts/Makefile.modinst
> @@ -9,7 +9,7 @@ __modinst:
>  include include/config/auto.conf
>  include $(srctree)/scripts/Kbuild.include
> =20
> -modules :=3D $(sort $(shell cat $(MODORDER)))
> +modules :=3D $(shell cat $(MODORDER))
> =20
>  ifeq ($(KBUILD_EXTMOD),)
>  dst :=3D $(MODLIB)/kernel
> --=20
> 2.34.1

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--Upav2svuIRAE6goJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmOX/PcACgkQB1IKcBYm
Eml6exAAsCxV0lz3EyMp9YaivYDv2cQ601+Et58gZhXxNwrvi+pOBg+3lqRPdkaM
D5v+O/fCiAKmYf9rDMUyaS+OFiyKjOTzWAHCR62goP5TQK2jgmRNEl74CUjAXxlD
10QKNQe/tOyK9MFgZzVzO0ineDDXLTqzTy7+jdmS8xK0Xssm1U2XkDQgMYvO4Np3
PFS5Hd989d03bjUQSc2gL7cSOzUeMrs2rXOwVFF6su92nbm/a17XcdsDniE+YKl8
VNT1Vuf4p22ZilJCd1+C/oJrW+fUhCXBw7heI7/jCkUCNESrQiyx16xb9QznS9gn
kh2rzmfrCbZZisBdgtF5Mp5FaFJMNxEQ1nGIgOc179Rzc/0I2KYa2o3aYXmIuFxh
wA7H2ytwXeALWb1mGiQ5Vc9YVvp+qFlhX8beX7yY/6XbPvTgF0lLOguaMCXYXW88
bqZ3rFHLIuP6sYAvQltXkfHkerF29hv4YRseazminlEYk3fgjTSQr0CG4rK5JZ+g
hwhUYpOTY07qKOLHRBNXZVQwlAA9F0foLbB3xFwRaCs4KbzbdcadGlO5MM+BA/Ws
o/+O3Jxu9coedlBVsLTl4caYGN/jaK/pXjiaEn4u5AVGgsDrQ4zjCdNbCKGfktoJ
xWpl9+gxeZrjPMnsYPtGBNn4d4VTyETwPYo/I9oKxPfeylrWpUE=
=mA0S
-----END PGP SIGNATURE-----

--Upav2svuIRAE6goJ--
