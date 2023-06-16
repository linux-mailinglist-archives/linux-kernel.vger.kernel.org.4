Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B887339E0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346149AbjFPTaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346317AbjFPT3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:29:55 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAFB35A7;
        Fri, 16 Jun 2023 12:29:32 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 11AB01C0E73; Fri, 16 Jun 2023 21:29:31 +0200 (CEST)
Date:   Fri, 16 Jun 2023 21:29:30 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 08/10] MIPS: Alchemy: fix dbdma2
Message-ID: <ZIy4GjSrV654NsBw@duo.ucw.cz>
References: <20230531134606.3385210-1-sashal@kernel.org>
 <20230531134606.3385210-8-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="j6iQPQcGGfmXX591"
Content-Disposition: inline
In-Reply-To: <20230531134606.3385210-8-sashal@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j6iQPQcGGfmXX591
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Manuel Lauss <manuel.lauss@gmail.com>
>=20
> [ Upstream commit 2d645604f69f3a772d58ead702f9a8e84ab2b342 ]
>=20
> Various fixes for the Au1200/Au1550/Au1300 DBDMA2 code:
>=20
> - skip cache invalidation if chip has working coherency circuitry.
> - invalidate KSEG0-portion of the (physical) data address.
> - force the dma channel doorbell write out to bus immediately with
>   a sync.
>=20
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I believe author's signoff is missing here.

Best regards,
							Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--j6iQPQcGGfmXX591
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZIy4GgAKCRAw5/Bqldv6
8il4AJwMOzHzrCN2tYG2fnEXSLgB13xUCgCgp9ir+HaT9CgnDtuCUFF2kfDHbWA=
=D/+s
-----END PGP SIGNATURE-----

--j6iQPQcGGfmXX591--
