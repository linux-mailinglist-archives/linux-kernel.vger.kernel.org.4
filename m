Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B766B807F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjCMS2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjCMS2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:28:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBD072B4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:27:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbmtS-0001kx-KQ; Mon, 13 Mar 2023 19:27:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbmtQ-003uMr-GO; Mon, 13 Mar 2023 19:27:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbmtP-004cQD-2V; Mon, 13 Mar 2023 19:27:31 +0100
Date:   Mon, 13 Mar 2023 19:27:30 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-clk@vger.kernel.org, kernel@pengutronix.de,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] clk: expand clk_ignore_unused mechanism to keep only
 a few clks on
Message-ID: <20230313182730.cx4n7lvhbtcs4hpn@pengutronix.de>
References: <20221026151812.1042052-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xgfwba3jlkbdegto"
Content-Disposition: inline
In-Reply-To: <20221026151812.1042052-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xgfwba3jlkbdegto
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Oct 26, 2022 at 05:18:12PM +0200, Uwe Kleine-K=F6nig wrote:
> Allow to pass an integer n that results in only keeping n unused clocks
> enabled.
>=20
> This helps to debug the problem if you only know that clk_ignore_unused
> helps but you have no clue yet which clock is the culprit.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> compared to v2 sent in August 2021 this is a trivial rebase on top of
> v6.1-rc1. I pinged that one repeatedly, I'm now trying with resending
> and calling the rebased patch v3 to maybe get some feedback. :-\

I didn't get any feedback on this patch and still consider it useful.

Any insights from your side?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xgfwba3jlkbdegto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQPaw8ACgkQwfwUeK3K
7Al3PAf8DpEgu09BjbaLoin1vOdceJBfVEzZVAdzpCgLxVciSav2Hy2QfZAxtsuM
J07SVb+T06jMVy1Nd/xPUvr1R/+PkBcXKeKA1ZRc5AXUoY3IMuAx6FdcV2r2K9+X
sV4ysQfTGq0GT2UDAgpexKwyKBrE4TwrPArjh42v7RMmUX5OVOTN82NrXGrGVFYH
BQ8rOmE1up9v5K/wZ79s7flc0ZB3hmzTso7uHJc68bnRs2tukvCzeHNGMXh5q88e
FmQ7zPpRZd42zwN8wlfx98algYFa+O/+Qkx3ryCrHweojJx5xNDgJj+iHHnUUx2A
UARE4pBbsGXlsIjwFS8hy3M7fcpfqw==
=PdGy
-----END PGP SIGNATURE-----

--xgfwba3jlkbdegto--
