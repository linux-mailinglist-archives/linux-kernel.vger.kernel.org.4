Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B806D32FA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 19:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjDARxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 13:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjDARxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 13:53:44 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51D51C1E7;
        Sat,  1 Apr 2023 10:53:37 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.98.92]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MTRdK-1pqFcV2iuy-00TomE; Sat, 01 Apr 2023 19:53:23 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id C95533C1CB; Sat,  1 Apr 2023 19:53:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1680371602; bh=Nr3Qt/2kmFekCAdMneGsfLlSp8CzAgpG58KJ+qxfk7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NK4pxFbsTYfhNEtoFbhhgZI0F+deMbuaW80CVsX1sSnwK3eZTRC/dxFNFKwEKCweM
         ZTbrKRqun5s8X9fn7CPSmlM3F+114l1grONWgXwpOF0Ptt+r/07AIEqwC8HTdfNEmd
         BP+g01owU8upMxgWaz4+cTrDzJftlCTmnGQKJyUQ=
Date:   Sat, 1 Apr 2023 19:53:21 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] kbuild: fix package build error due to broken symlinks
Message-ID: <ZChvkdnWpYkzKKQ5@fjasle.eu>
References: <20230325141909.2512452-1-masahiroy@kernel.org>
 <ZCSZTLjhLshLBKWM@bergen.fjasle.eu>
 <CAK7LNAQkKE8X3n6Tyw1oX2g-TsLqpY54yi=ObCHfARdm02Gvyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uaDgQRGjlcyLhGFm"
Content-Disposition: inline
In-Reply-To: <CAK7LNAQkKE8X3n6Tyw1oX2g-TsLqpY54yi=ObCHfARdm02Gvyw@mail.gmail.com>
X-Provags-ID: V03:K1:Z84sC0jYJAhvR+kII3NCy7Cd4I6uTEshmznX+Ru6+mPHt89oG42
 o2HH2LypnNtwiwpU/le+L6T2EfvcFvXxL8IPPPCupBpwVgjiBxgdm3ZnTAf9xUOI0Kz/Xb+
 OQ+bnFKTwKag31OsWn0xoKwBoSx/kWif+B8vdpkUrWG/OFj/wZ+bUgyxah62JmRXWw20Rg/
 Be8yz1lX6rSotCZJo0hcw==
UI-OutboundReport: notjunk:1;M01:P0:7+q1R/oO+bg=;RzeBr7E8OWYhdf4CO1EmvH9R5eN
 ZN9TonKkjPIWf+izCTCCgUYRnEvEpOLqJBA/7R0a4C/PQjY04v1SOI8otE2EdYIjneR1XicW/
 KlcqkrkPA5ET76dDj+M63tx3uYlGbT3jYaekezzW/QF1rtR4gMmwVOteHM5h90fiXRjb/iDHe
 ksqWm2ruHAXngrYN1EEvmXvtwS7ewHplB1QpoKLmogOgUDOm4DzGoLPkTlB+NDmFOD7ZJm7G1
 SVTG1nsags/KhybLwuJh/6iauNXbtP4eGNzw40bDUfgd70HM/Nnl+X0Nbv0CQWhIRgRWpoQvM
 w/j4/UOMxpwdFrPeY2v6zNzV2iqsruc3TYnhJjy78BoMNVdg+Sp5HhwsnaMvSOeFXleOwWbsN
 KSCXtujI4gcRoumbvIMesRiD83GLkB584kbNXbEUoqTIDVetm+UXWiHYZBKxNFMEYjvb1Eh+I
 Qrr1jWQkvmPTp4kb/1mal+8GLYIRArj2HVsMvBPlXTuBigB8jb9JUqERWo546HlVF2j9HQjpI
 UmuqyNfXcvgXWDj0fbIoQPK9jIpDpG/leuxBxEFPnZPCTmUeRPe59s2S6V9SiMPRdQHOyMwxO
 XVtHDW598SaGUsRDDbyfkwLBUe5NA3PgyF6MMaR2hWH4YtIWWLem7onG+Pu37Ibj4XKL4AJMC
 JEQs2GQDCGkbAjb0qq80E2xRyx/oSH9XAp0FeukKuA==
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uaDgQRGjlcyLhGFm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 01, 2023 at 11:55:44PM +0900 Masahiro Yamada wrote:
> On Thu, Mar 30, 2023 at 5:02=E2=80=AFAM Nicolas Schier <nicolas@fjasle.eu=
> wrote:
> >
> > On Sat 25 Mar 2023 23:19:09 GMT, Masahiro Yamada wrote:
> > > 'make deb-pkg' and 'make rpm-pkg' fail if a broken symlink exists in
> > > a dirty source tree. Handle symlinks properly, and also, keep the
> > > executable permission.
> > >
> > > Fixes: 05e96e96a315 ("kbuild: use git-archive for source package crea=
tion")
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  scripts/package/gen-diff-patch | 36 +++++++++++++++++++++++++-------=
--
> > >  1 file changed, 27 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/scripts/package/gen-diff-patch b/scripts/package/gen-dif=
f-patch
> > > index f842ab50a780..23551de92e1b 100755
> > > --- a/scripts/package/gen-diff-patch
> > > +++ b/scripts/package/gen-diff-patch
> > > @@ -23,16 +23,34 @@ fi
> > >  git -C ${srctree} status --porcelain --untracked-files=3Dall |
> > >  while read stat path
> > >  do
> > > -     if [ "${stat}" =3D '??' ]; then
> > > -
> > > -             if ! diff -u /dev/null "${srctree}/${path}" > .tmp_diff=
 &&
> > > -                     ! head -n1 .tmp_diff | grep -q "Binary files"; =
then
> > > -                     {
> > > -                             echo "--- /dev/null"
> > > -                             echo "+++ linux/$path"
> > > -                             cat .tmp_diff | tail -n +3
> > > -                     } >> ${untracked_patch}
> > > +     if [ "${stat}" !=3D '??' ]; then
> > > +             continue
> > > +     fi
> > > +
> > > +     if [ -L "${path}" ]; then
> > > +             {
> > > +                     echo "diff --git a/${path} b/${path}"
> > > +                     echo "new file mode 120000"
> > > +                     echo "--- /dev/null"
> > > +                     echo "+++ b/$path"
> > > +                     echo "@@ -0,0 +1 @@"
> > > +                     printf "+"; readlink ${path}
> >
> > Better quote "${path}"?
>=20
>=20
> Thanks for the suggestion.
>=20
> Quoting variables are correct in most cases.
> But, that is not enough to generate a valid
> patch when a file path contains spaces.
>=20
>=20
>=20
> 'git format-patch' produces a patch that
> is accepted by GNU patch and also by dpkg-source.
>=20
> I learned a trick from GIT source code.
>=20
>=20
> If you are interested, what GIT does [1].
>=20
>=20
> [1] https://github.com/git/git/commit/1a9eb3b9d50367bee8fe85022684d812816=
fe531

thanks for the pointer, that is really interesting!

Kind regards,
Nicolas


> I will send v2 later, where I made some more efforts
> to fix several corner cases even if that is not perfect.
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> --=20
> Best Regards
> Masahiro Yamada

--uaDgQRGjlcyLhGFm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmQob5EACgkQB1IKcBYm
Emk3iw//QSfaO+UGzNpruOX0myJrkiBG7QHJjJD0zutU2yPKFK2YJu3qYF/IQeyo
iyQu+RNitcYmM1mTf/kO9dl8JLZgAakUxOfBFcFuL/e+1sOjIbQX6jfWjaFIS/g3
4g5lTSaeNjpjBp5KSTB27F/SzEpSCIidx3QBYF8D8+R+hq96qYaEWbQmbnVZEsSv
/TGde9RUCqM+9auCt5Fh/GdVD1rxfSnnc+UQZfpFdcVam2HTKOwMUSWfNUves2oX
VMtwsuxRp1ZbRDF5X7KRwI8EM3rv+NBuhdfq7NXKDcrbcvZPf7qc4obLYNK1l92G
sYcf/6xDEO1bINFTjBepcjSd/PNKAh32ajekA/mBpEODY8z1CoScgDvWlymoPee8
3trHD87z86boNHgiHMEkOupQYfiP+HhH72vzEYTvprkSMFtxaWAOiWpptc1j1OSS
uRkdSJMm2vpM0E6/BKhGuv2blowYX38dVRAllhl3cr3g7qZZ1aIOlgsiEp0tpAjx
v+n666w6ddK8iySWZTzRn7PZIimT+v8wzvTZRxMNb4hZ1QEkYT12SiA0pxX14Qbt
JcX84i892ZAYRbY+gu5hhuBszRUzXqSKm+Ebajz5fNh1q1NNuyggSZwd7vdx/IIv
UZUOhdaM5/CypBx+TAQDE0mf/FKbPp47vmEh2RqoDVzDWRYG0js=
=aaHM
-----END PGP SIGNATURE-----

--uaDgQRGjlcyLhGFm--
