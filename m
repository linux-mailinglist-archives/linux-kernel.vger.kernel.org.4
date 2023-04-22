Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD41F6EB8BD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 13:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjDVLEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 07:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVLEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 07:04:38 -0400
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AC5198D;
        Sat, 22 Apr 2023 04:04:37 -0700 (PDT)
Received: from [46.183.248.101] (helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1pqB2f-0005XR-91; Sat, 22 Apr 2023 13:04:33 +0200
Received: from ben by deadeye with local (Exim 4.96)
        (envelope-from <ben@decadent.org.uk>)
        id 1pqB2e-001pFG-1N;
        Sat, 22 Apr 2023 13:04:32 +0200
Message-ID: <3a5c0f51d120bb11cb5fdf9b7e2925d8a5c1dbe2.camel@decadent.org.uk>
Subject: Re: [PATCH 2/2] kbuild: deb-pkg: add KDEB_SOURCE_COMPRESS to
 specify compression type
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bastian Germann <bage@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Date:   Sat, 22 Apr 2023 13:04:32 +0200
In-Reply-To: <CAK7LNAQjXTZhObuZ6R159kaOcsjTnTHftqnZe6GMfk0ibCkOkw@mail.gmail.com>
References: <20230417142548.249610-1-masahiroy@kernel.org>
         <20230417142548.249610-2-masahiroy@kernel.org>
         <ZEBQPeihAuP4jVYG@bergen.fjasle.eu>
         <CAK7LNAQjXTZhObuZ6R159kaOcsjTnTHftqnZe6GMfk0ibCkOkw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-gRCz5fKy5ML0UmVBw4B5"
User-Agent: Evolution 3.46.4-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 46.183.248.101
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gRCz5fKy5ML0UmVBw4B5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2023-04-20 at 16:17 +0900, Masahiro Yamada wrote:
> On Thu, Apr 20, 2023 at 5:34=E2=80=AFAM Nicolas Schier <nicolas@fjasle.eu=
> wrote:
[...]
> > > +KDEB_SOURCE_COMPRESS ?=3D gzip
> >=20
> > According to dpkg-source(1), xz is the default compression for deb
> > source format >=3D 2.  Shouldn't we use xz here by default as well?
>=20
>=20
> Yes.
> xz is the default because we switched to format 3.0 (quilt).
>=20
> But, we used gzip for a long time, so I did not change it
> in this commit.
>=20
>=20
> I do not have a strong opinion.
>=20
> Ben (debian kernel maintainer) is in the CC list,
> perhaps he has some preference.

I think it makes sense to keep source compression unchanged in this
commit, but you could add another commit to change the default.

Ben.

--=20
Ben Hutchings
Theory and practice are closer in theory than in practice - John Levine

--=-gRCz5fKy5ML0UmVBw4B5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmRDv0AACgkQ57/I7JWG
EQkGCxAA1cIcv2n+iNlzdNkD3TXplfCPY2IJ+MyDgJd7ZyzPBgiLzEQhFerPx/AN
2no1/wPPJVANsbOSj+CLkW7pQjJPxbGseKf6NLIEEvNd3W+PAjbHGYEIWrF+rKeJ
qGntjbnbL7cvtIkSFDWuxMgT5tw6MlJQqdjt3kiUM8xhYjc7rZORHxIO/0QlfbDq
74YATuYBUaM4/S6C1seRfC1jLwKyySh+aikb0i5fxtyh2vlmnfuQkS7OI2dFrLtT
nDHLKhxyt1Rq52ULRrcc6wPHNsOeXEe5QEgiaDZzbbTnPeFXRJm1zpQ2Vxk/TDfO
9fbd8ohN5pNklVDvGzST0sjI+y905IhbiS7KlDq3il79SYEKlcC5PTop+8w2K1gf
gqoV7MvhPysELXj69a4x7B7qkOP7w8MwYlowS7vccozSBoceAySW9LvAOc2Ybz5C
jx+VWo1K9M2L2pvwrJPc1EM6DFQhsBclkV3ldATDPCzpA1/OC6Awh/iorRKWyAET
Rk04jkZsCQHNa7qsrVm2odBqAAgC97xQEll2Uj1pXCiDG6cd82SwIfCtnGvgRAab
zDbdacrqJ8cSKWwR6li50MrZwo2lumWSHb2j5hGnC7/5nHmZBieuHqUTCQTTo0UF
jd9is0HyMpOfzXYiHrBGDOSyv82zeN4/HbPDfcXO/XrbIrjo9js=
=rQFw
-----END PGP SIGNATURE-----

--=-gRCz5fKy5ML0UmVBw4B5--
