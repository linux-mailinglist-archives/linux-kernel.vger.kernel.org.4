Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB4F69778C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjBOHrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbjBOHrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:47:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCF935249
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:47:35 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSCVp-0006se-BM; Wed, 15 Feb 2023 08:47:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSCVn-0053mC-38; Wed, 15 Feb 2023 08:47:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSCVn-003giY-Jn; Wed, 15 Feb 2023 08:47:31 +0100
Date:   Wed, 15 Feb 2023 08:47:31 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Sumit Gupta <sumitg@nvidia.com>
Subject: Re: [PATCH 3/3] soc: tegra: cbb: Drop empty platform remove function
Message-ID: <20230215074731.xsfqkmtzrer7sfuj@pengutronix.de>
References: <20221212222549.3779846-1-u.kleine-koenig@pengutronix.de>
 <20221212222549.3779846-4-u.kleine-koenig@pengutronix.de>
 <20230112215511.gjmplw4kcq55g6zy@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dqinbp6fhph7umcv"
Content-Disposition: inline
In-Reply-To: <20230112215511.gjmplw4kcq55g6zy@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dqinbp6fhph7umcv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[adding Sumit Gupta to Cc who authored all commits to this driver so
far, context available at
https://lore.kernel.org/r/20221212222549.3779846-4-u.kleine-koenig@pengutro=
nix.de]

On Thu, Jan 12, 2023 at 10:55:11PM +0100, Uwe Kleine-K=F6nig wrote:
> On Mon, Dec 12, 2022 at 11:25:49PM +0100, Uwe Kleine-K=F6nig wrote:
> > A remove callback just returning 0 is equivalent to no remove callback
> > at all. So drop the useless function.
>=20
> the other two patches in this series were applied individually to their
> matching trees. For this one I didn't get feedback yet.

Did this patch fell through the cracks? Is it just -ENOMAINTAINERTIME?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dqinbp6fhph7umcv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPsjhAACgkQwfwUeK3K
7Alwngf/fUXHd6rry3K+acBZQ+FyczcRZzJpvDrczWKTb5w+aCnqiiK1uh3Gc1vD
uN6bf24jkFykbqrBPiyut9kx/i31M617WS9mltkZ/mcGflhqIzenNs3nq6g0uRCN
SFSPYxoZpz0sXxvC9FjaMt2sjBlFQJA6kvyKS5ar4nhtyWy7FIaaKpd6Apwb/kYz
ajH70K/WEClnRqdGGylI2uRtyzHTJRsXsAhueM16HQOqZT2RNHsLJl1jst2svVc5
s0PmO4zTvofvTW9hdNvE/cRJk823DIk8jHUuBZHY7KNnPeNZ+oSMKSCPcwO8TOOP
0EX4fuigNroU4+11nBGotlOS252Hpg==
=hRjx
-----END PGP SIGNATURE-----

--dqinbp6fhph7umcv--
