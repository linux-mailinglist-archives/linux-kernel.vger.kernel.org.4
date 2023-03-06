Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4506AC933
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjCFRG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjCFRGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:06:10 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D73859E5A;
        Mon,  6 Mar 2023 09:05:32 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.97.228]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N0o7f-1qTmjM1i8z-00wjTi; Mon, 06 Mar 2023 18:04:33 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 6C0133C1C5; Mon,  6 Mar 2023 18:04:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1678122271; bh=/QhdHt+oCasOCh3Dkbd+vJMlKi/bswqXbEm0k+oIQdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kchi/EqHGTOW7hPBvh/EQ0HKEVzsYFv2KtAvclEKxpqsWcp9vp2flB2+UKCuvaNM0
         HCupKvwAHZzvg1ixzxxDtTscSeS4Z/5ULMKgviVQKXSiOziyyGGux8b4vDEFs+H2zu
         +HhcVXBhled/FUMlhma37jkayLNm4gC0wtXCHuXs=
Date:   Mon, 6 Mar 2023 18:04:31 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Bastian Germann <bage@linutronix.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] kbuild: deb-pkg: default dpkg-buildpackage --build
Message-ID: <ZAYdH6huDB9QtNdR@fjasle.eu>
References: <20230305232536.19528-1-bage@linutronix.de>
 <20230305232536.19528-2-bage@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JerCWPahw1HPxYCf"
Content-Disposition: inline
In-Reply-To: <20230305232536.19528-2-bage@linutronix.de>
X-Provags-ID: V03:K1:5oosnOkcAKuDEMOKTaPVFu/+T4F9WxzsYIhaq3L7QxE+m038W48
 8HSWibJEkraVGhaZ+rY8z06gErwphoYWpvsbWdiljHh7+lmjGhDpGussijrETKUql/tljxJ
 XZIhz5+oidPh6gPv0+Y5bAU9nU0UMiibklRNeyV8MwU1K0hX2zEoeUTs3XyxBM1++O1lFmv
 R5Mq0PWM8lwj7yKZe1LqQ==
UI-OutboundReport: notjunk:1;M01:P0:CkMiTDBNPaY=;6HKX4a7VANrtBTHkSkBOk1SwpQG
 9qyV3zs1tGs8xHgApdYl000lseuzeyVRtEmx7q7+4Hvm7h4mAxyEzABIlPEQrESzAxmxKaZw5
 SuUAzBEbbocPziElsooiAekCUqYzIkuf84jranGSApVHPvG2G1hyicpVxbviI1tJUK6v3wwzC
 YuD9VjpZgFIlP6Pkldxesmcrt0pnWq3skbbcBjzL0VanDrSL4si4llasJOaJSppxFdxmPY+XB
 m/PXXb40e9OFwYEQr66zRM4SxT0fOjypCmcKg73tXEmowOnjG2tfj2gv7N/xKbE4FHW/EzJ66
 h6XhDZm1bl2k0zuz8diCzOGzuyWlmB2FnBjaZtDz/aA5kRMt/afQ4hYOw14Gb3nbTvWTHFE5H
 rJHaUlrhauhEBaRIMX1Ys7SNOng3bJ12z0DKSuCgfW3fzQaNh8fCFiwYqxyJQuc3yUIK0a1JL
 PZvR/XL3sSeUzVPoWsxEHzp3qMUWuI80MXRSqEZjVypYmk1ygLGmJLubSA0mmKEwcd0MUX0JG
 0KGplVi53T8bW+eMD8Wk2TlPkG5P6egWq8aZOyNqip8XuKmOppbpjhK7embH69B8/UMbul5Dx
 Vu/wG7v2zJW+AsKp5mAmXrUy1pL4PRgPdSYdEFOJRnL6c4vb4OT8yAt2uENRlKSXa8pHm9AZq
 ymoysNpZuslqxNPEqJoALQ7GEUluPqyuHt8XBfuD6A==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JerCWPahw1HPxYCf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2023 at 12:25:35AM +0100 Bastian Germann wrote:
> deb-pkg's dpkg-buildpackage invocation was added --build=3Dsource,binary
> recently. Before, it relied on the default, which is
> --build=3Dsource,binary,all and makes no difference for the built packages
> as there is no "Arch: all" package.
>=20
> However, the explicit --build eliminates overriding it via DPKG_FLAGS,
> which used to fill the gap of generating only a source package without
> building it.
>=20
> Recover the old, default behavior.
>=20
> Fixes: 7bf4582d7aad ("kbuild: deb-pkg: create source package without clea=
ning")
> Signed-off-by: Bastian Germann <bage@linutronix.de>
> ---
>  scripts/Makefile.package | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index b941e6341b36..fe1721915a59 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -120,7 +120,7 @@ debian-orig: linux.tar.gz debian
>  PHONY +=3D deb-pkg
>  deb-pkg: debian-orig
>  	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG=
_FLAGS) \
> -		--build=3Dsource,binary -nc -us -uc
> +		-nc -us -uc
> =20
>  PHONY +=3D bindeb-pkg
>  bindeb-pkg: debian
> --=20
> 2.39.2

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--JerCWPahw1HPxYCf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmQGHR4ACgkQB1IKcBYm
EmlwyA/+JkqQ67j709PRCYeg61NYLHpE462WunWAub1qwetq9r823k0XuNHOWkGg
8g0M7M8IApnx00o9N6sjiQvvek1nAxLeXGdAs0IFWZadjayqwrntNtp6jMBM4mQo
zIu84SzA56+dT5Ujus5C+ny6D4nOqyPWhkAOjFE2mMzLyurt4E4spAYdfjije+9K
AVo2vZf0vA+Ejmw83QYuxV1T/EV3Uo2nlvfnPPLepPHhaZ6c8hi4s7awE7D0dFDm
vzrpNyipQKM8j1tdylOz1y4HO2M+tUG0alqcWXml0UYtKnK7LfI9UiJO3AfTgifX
tNdqt62tWdyUlu6fjzmRu8Lrp7FTnId3KEQCMeRGIZjddYXvQ+uuOaRPz+/VWSrt
C6Twk6/eC4xUWNDZU8LvVb13ZNy055saaG3V3qQKcAPtXybEVUgSX/Dt6R1BEdbr
wAmBO0RVM4N6pEtNbyrj7EOgMkRBcv99yap0cOaAK/8Ig9mRlaiNdTUkfEjFJFRD
NvuIrME98OQqi9qFwKV4qlsvKTpSeIgHF22LzVxpxs/qqgGq+lA9U3Xxr22toJgO
/Z6IrNhSTgkgCMa6bER8ygxpj0zCgfqaEBz/2systx4+BuXdTQ7i1UYKJ12dWo0F
Pkj7ioBuXfYabazu8C2WAZCPk2R24dU+uM3n+ACfOZwumVBxWVU=
=EsWY
-----END PGP SIGNATURE-----

--JerCWPahw1HPxYCf--
