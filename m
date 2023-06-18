Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32BF7345A2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 10:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjFRI4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 04:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFRI4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 04:56:10 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D231BDD;
        Sun, 18 Jun 2023 01:56:05 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2E8811C0DE7; Sun, 18 Jun 2023 10:56:03 +0200 (CEST)
Date:   Sun, 18 Jun 2023 10:56:02 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 08/10] MIPS: Alchemy: fix dbdma2
Message-ID: <ZI7GorATfHRiqOn9@duo.ucw.cz>
References: <20230531134606.3385210-1-sashal@kernel.org>
 <20230531134606.3385210-8-sashal@kernel.org>
 <ZIy4GjSrV654NsBw@duo.ucw.cz>
 <CAOLZvyHQL7T33O9fSdBZMtjrLKO2uN6Gr6g_p0oKVUtnMuXheQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="65KtI6CNQfLwOUBP"
Content-Disposition: inline
In-Reply-To: <CAOLZvyHQL7T33O9fSdBZMtjrLKO2uN6Gr6g_p0oKVUtnMuXheQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--65KtI6CNQfLwOUBP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2023-06-18 07:43:10, Manuel Lauss wrote:
> On Fri, Jun 16, 2023 at 9:33=E2=80=AFPM Pavel Machek <pavel@denx.de> wrot=
e:
>=20
> > Hi!
> >
> > > From: Manuel Lauss <manuel.lauss@gmail.com>
> > >
> > > [ Upstream commit 2d645604f69f3a772d58ead702f9a8e84ab2b342 ]
> > >
> > > Various fixes for the Au1200/Au1550/Au1300 DBDMA2 code:
> > >
> > > - skip cache invalidation if chip has working coherency circuitry.
> > > - invalidate KSEG0-portion of the (physical) data address.
> > > - force the dma channel doorbell write out to bus immediately with
> > >   a sync.
> > >
> > > Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> > I believe author's signoff is missing here.
> >
>=20
> As the author, I say this patch should not be applied to 4.xx at all.  Sa=
me
> for my other 2 MIPS patches.

Thanks for info, where is the threshold, do we need them for 5.10?

Sasha, please drop.

Best regards,
									Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--65KtI6CNQfLwOUBP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZI7GogAKCRAw5/Bqldv6
8qKtAKChGL5IEmgti7Kfa1jRnUDX3FM+bQCdFVU4lf2+lc6bH4yb1R5jUFXytes=
=yOuy
-----END PGP SIGNATURE-----

--65KtI6CNQfLwOUBP--
