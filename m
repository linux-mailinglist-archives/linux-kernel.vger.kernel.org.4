Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F43E637197
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 05:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiKXEvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 23:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKXEvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 23:51:12 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1167E7ECA9;
        Wed, 23 Nov 2022 20:51:05 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.96.241]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MTAJl-1oTzZq3dzb-00Uc8d; Thu, 24 Nov 2022 05:45:09 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 33E353C087;
        Thu, 24 Nov 2022 05:45:06 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id D0527337; Thu, 24 Nov 2022 05:45:04 +0100 (CET)
Date:   Thu, 24 Nov 2022 05:45:04 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 3/5] kbuild: add read-file macro
Message-ID: <Y3720EmaIzOOEjgP@bergen.fjasle.eu>
References: <20221123151828.509565-1-masahiroy@kernel.org>
 <20221123151828.509565-3-masahiroy@kernel.org>
 <Y36KLFArg5etHRD8@bergen.fjasle.eu>
 <CAK7LNASWd-8awDOwE3iU9nx8QPj3VnoFtnUiX3NLyT+fx3BfjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+p/BTl9eSoZP7JEN"
Content-Disposition: inline
In-Reply-To: <CAK7LNASWd-8awDOwE3iU9nx8QPj3VnoFtnUiX3NLyT+fx3BfjQ@mail.gmail.com>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:F+92PvJf0CRwmPG6FLqcgOxiJcCGaEuNWen6SfiFTexUW0YH3p3
 9Y30FGJJ34S12CYPkXQcfTppHuEIFliMHqNn8mRWlLyRyl0FlCliqFW3WI0kXJOdf0ISvcL
 CLPCHf+lSon8LB8A28K2hpllffwQiPxw9O9YE0lO6UuErS5bLHysNtIlOdnAjlXePRRLEnA
 NHXr8LXsOzkkbwpCPfCHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9+MdR+FBUKU=:sHmxTrkQsxn8alpRHM1cNJ
 WGAN25ZuOxICjttHdtA6jsasTbfGERuiTZldIQi5XUHIDBZvgi3azoq+qFaiTw/5P/uv6uGQl
 MGbOViM7F9b+smSMCPamjcjnQpgpD3KoUcFm8O8vJc2g2keLxMk27ndO1OQsxE+42Ksop65VR
 /2W2wulqf2glI4tXLYxnyQW/e6RcRF+44zCmC0lfCg8Ndwz587AI2cgrG4go02yXBlaTrGzwV
 CXvq3/zzofrDzOcE9pYpPxkC/hYkzsevn/zcppFudHdYLrHJtcNtvv5x18BZHYYsnpiDmb5SF
 dr2vT7G2OvjlUyH8MUOcoxYL1CU39c6dzy0B9YEBmHU9VKl/Npqw0yJtzasS0f4Z9HloMX8FU
 cHTD+8sJGDhpqsXmwRT1EUkAtDMmblaataa9rcebyRTSSQRGXYf+a4UEyZ41vdUt1HuiJ0+hv
 zzf2GUI9CRUSmmA2urdkeMUXnRUfGLzeHcaFY2REZ5a4ENZzL+k49tDRYAM50oBRK6AMiCSTu
 F349y1UrIe8lAk/1KcNwztI8gTX/LF6Hc/0gNyRYgcd3EZQv0e2i+6HJ4oxYRo0tot2CP9tqB
 iLecht+D3ZAtJEUbSSyp0K7HUGCEeu9o9SWgbhRE+HNambrNT/RXjQ+CA9P/K2tbU4YoAagpX
 13mWizl2+VNqVhq0Iu37dSQPPhpl/vBHtfOuR+xFm4IBXJqDvH/FacXAXAut3My7xfQR4BV6C
 27UKDMp605bpnAuy2iF8iG/+23f0DgQaIklENlVj4T8FND8Ps6LggqUcyWdI4JTL+e1gzLJJi
 BVEYQWT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+p/BTl9eSoZP7JEN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 24 Nov 2022 06:52:06 GMT, Masahiro Yamada wrote:
> On Thu, Nov 24, 2022 at 6:02 AM Nicolas Schier <nicolas@fjasle.eu> wrote:
> >
> > On Thu 24 Nov 2022 00:18:26 GMT, Masahiro Yamada wrote:
> > > Since GMU Make 4.2, $(file ...) supports the read operater '<', which=
 is
> > > useful to read a file without forking any process. No warning is show=
n even
> > > if the input file is missing.
> > >
> > > For older Make versions, it falls back to the cat command.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  Makefile                  |  2 +-
> > >  scripts/Kbuild.include    | 12 ++++++++++++
> > >  scripts/Makefile.modfinal |  2 +-
> > >  scripts/Makefile.modinst  |  2 +-
> > >  4 files changed, 15 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index eb80332f7b51..60ce9dcafc72 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -369,7 +369,7 @@ else # !mixed-build
> > >  include $(srctree)/scripts/Kbuild.include
> > >
> > >  # Read KERNELRELEASE from include/config/kernel.release (if it exist=
s)
> > > -KERNELRELEASE =3D $(shell cat include/config/kernel.release 2> /dev/=
null)
> > > +KERNELRELEASE =3D $(call read-file, include/config/kernel.release)
> > >  KERNELVERSION =3D $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(=
SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
> > >  export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
> > >
> > > diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> > > index 9996f34327cb..722846c23264 100644
> > > --- a/scripts/Kbuild.include
> > > +++ b/scripts/Kbuild.include
> > > @@ -10,6 +10,10 @@ empty   :=3D
> > >  space   :=3D $(empty) $(empty)
> > >  space_escape :=3D _-_SPACE_-_
> > >  pound :=3D \#
> > > +define newline
> > > +
> > > +
> > > +endef
> > >
> > >  ###
> > >  # Comparison macros.
> > > @@ -55,6 +59,14 @@ stringify =3D $(squote)$(quote)$1$(quote)$(squote)
> > >  kbuild-dir =3D $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
> > >  kbuild-file =3D $(or $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/=
Makefile)
> > >
> > > +###
> > > +# Read a file, replacing newlines with spaces
> > > +ifeq ($(call test-ge, $(MAKE_VERSION), 4.2),y)
> > > +read-file =3D $(subst $(newline),$(space),$(file < $1))
> > > +else
> > > +read-file =3D $(shell cat $1 2>/dev/null)
> > > +endif
> > > +
> >
> > I like the implementation of read-file, but I am afraid that the
> > MAKE_VERSION comparison breaks all make versions w/ a minor version
> > number: 3.99.9x, 4.2.x, 4.3.x.
>=20
>=20
> I think these should work correctly
> unless I missed something terribly.
>=20
>=20
> In the ASCII-sorting, they are sorted like this:
>=20
> 3.99.9x  4.2   4.2.x  4.3.x
>=20
>=20
>=20
>=20
>=20
>=20
> The bad scenarios I came up with is GNU Make 4.10
> and GNU Make 10.0 because $(sort ) will sort
>=20
> 10  4.10  4.2
>=20
>=20
>=20
>=20
> GNU Make 4.3 was released in Jan 2020
> GNU Make 4.4 was released in Oct 2022
>=20
>=20
>=20
> If the current release pace continues,
> we will have about 10 years until GNU Make hits 4.10
>=20
> Until then, we can remove this ifeq.
>=20

yes, you're right.  I should have checked my assumption before=20
bothering you with it.

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

>=20
>=20
> --=20
> Best Regards
> Masahiro Yamada

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--+p/BTl9eSoZP7JEN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmN+9tAACgkQB1IKcBYm
EmmsvBAAraEKgAN0vJRVUL5PmaBzALW4Py4VZAd9gCTwDpGdYXDrkMTLBzIg3qKo
k4T1A+9Ax5cPz2UaazS4nzye4eztt+lRGOYsM0P6U6JSkXRkZZ5ToL3uhmUcNASs
aoMqshKyVALj+vZiBExMFIMQfwIcB/jVTWQo/0YK9nEGKVbcPtms6jcEXxBI53BA
MApA9adU4ZjSYPNb8J6PLkwmqOQLVB/EcJ3VrwoEDQ14iNs/XB7CvDuLVLTxC8+b
+9dAJoUU0wyB3qYo6I4nje+Ng9vOnvRcPuodQvpH3JAkl3pUoLvAT5jvnqpcwddq
0qvzLBBAR14XNsdlEs1/OXvOuoPVkDR0lbHC6JZW2QBPlESspDABj1kKioMc0ViV
oZff4fm6Uuj5tM1GzYp1yqfGgfDO4nxVTr7bSN/V0018FR6+IrscHJ6/0MQWq0Om
A41XbxqqHUgWNcXLsnSVJJf1TxOj8Zi4h40ARDo3/J7+5gfrZJ2DwVB5PUr/hk+/
Y9TZ/RnYHZxWHQvATZQ5xSpljsypQgZxAPDDl+ldtzI4xkjqNVYjuwxFj+80BXo9
2qlt5ag6zaoGoPuCROVbrfL6e7bmEJWKDqy77OlplLsUpwPwhIN9D+vtWwRWo+aV
K+2ILwFKpB6CJvjpXKnBcOtcf961qrGHV1e4aBModDrhAz25MDc=
=SIqb
-----END PGP SIGNATURE-----

--+p/BTl9eSoZP7JEN--
