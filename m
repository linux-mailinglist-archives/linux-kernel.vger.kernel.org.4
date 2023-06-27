Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BBE73F415
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 07:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjF0Fu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 01:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF0FuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 01:50:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9625E19A1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:50:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qE1ak-0006z0-7r; Tue, 27 Jun 2023 07:50:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qE1ai-00ANCf-8q; Tue, 27 Jun 2023 07:50:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qE1ah-0009ps-Ed; Tue, 27 Jun 2023 07:50:15 +0200
Date:   Tue, 27 Jun 2023 07:50:15 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peng Fan <peng.fan@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Abel Vesa <abelvesa@kernel.org>
Subject: Re: [PATCH] clk: imx: Drop inclusion of unused header
 <soc/imx/timer.h>
Message-ID: <20230627055015.z37tqywbwykb6erp@pengutronix.de>
References: <20230623071948.3254789-1-arnd@kernel.org>
 <3a843f15dda68375870c622869836e5c.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oawwlp5mnvgmgmlb"
Content-Disposition: inline
In-Reply-To: <3a843f15dda68375870c622869836e5c.sboyd@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oawwlp5mnvgmgmlb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jun 26, 2023 at 04:44:00PM -0700, Stephen Boyd wrote:
> Quoting Arnd Bergmann (2023-06-23 00:19:19)
> > From: Arnd Bergmann <arnd@arndb.de>
> >=20
> > After removing this header in the clocksource tree, the clk drivers no
> > longer build:
> >=20
> > drivers/clk/imx/clk-imx1.c:13:10: fatal error: 'soc/imx/timer.h' file n=
ot found
> > drivers/clk/imx/clk-imx27.c:11:10: fatal error: 'soc/imx/timer.h' file =
not found
> >=20
> > This patch was originally posted as part of a three-patch series, but o=
nly
> > patches 1 and 3 got applied.
> >=20
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Fixes: 9e9d7570485d7 ("clocksource/drivers/imx-gpt: Fold <soc/imx/timer=
=2Eh> into its only user")
> > Link: https://lore.kernel.org/all/20230328100531.879485-2-u.kleine-koen=
ig@pengutronix.de/
> > Signed-off-by: "Uwe Kleine-K=F6nig" <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
>=20
> Acked-by: Stephen Boyd <sboyd@kernel.org>

Just for the record, the original patch is already in

	https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core

as 011da162da2f915989a571b557867f7eea699000.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--oawwlp5mnvgmgmlb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSaeJYACgkQj4D7WH0S
/k7xbQf/W45axEIXoDFnjWO3e7TYO/k6XChVN0LePYVfneRIcr3+XqjHIuBz3Nrg
cAyTBo4276hr8In3dFw3rORyd4ZGFyo5N5kG50JnQFQ7zEy1VH+iOyW+2v3F6xtQ
0SMiZt1SW3bkmG5InhlYdL3O02iLYDaqcPiwS7HVad2w2KlzGrc8UeVXXi3l/Ujo
pGPu+0buShD7rFzWI7eIzAbLtvzWF1DhyrkEQLmnNyi61VSrBR832bvKTd7n4qeG
f5QH9vrC60PIm1yHxrGa1XchSWwalPQBR35WgBBIHLnaCvPzXN1smi7tHRUAXTIs
C/tl4fuDODyO54lkzPL8cu0hQlP1eg==
=cYCp
-----END PGP SIGNATURE-----

--oawwlp5mnvgmgmlb--
