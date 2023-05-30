Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93686716725
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjE3Pev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjE3Pet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:34:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D2C10C
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:34:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q41Mu-0001MW-8K; Tue, 30 May 2023 17:34:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q41Mt-003uKI-8k; Tue, 30 May 2023 17:34:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q41Ms-009Xgu-3n; Tue, 30 May 2023 17:34:38 +0200
Date:   Tue, 30 May 2023 17:34:38 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] clocksource/drivers/imx-gpt: Drop unused function
 mxc_timer_init()
Message-ID: <20230530153438.yomexkg2uypjtov7@pengutronix.de>
References: <20230328100531.879485-1-u.kleine-koenig@pengutronix.de>
 <CAOMZO5AHrXrJZJ2NY3GN56zf=meA5r3rWpD7GVuszBL7zcye5Q@mail.gmail.com>
 <20230328103136.xafgjdkvdwnn7pwi@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kmpiepxdigxle443"
Content-Disposition: inline
In-Reply-To: <20230328103136.xafgjdkvdwnn7pwi@pengutronix.de>
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


--kmpiepxdigxle443
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2023 at 12:31:36PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Mar 28, 2023 at 07:14:24AM -0300, Fabio Estevam wrote:
> > Hi Uwe,
> >=20
> > On Tue, Mar 28, 2023 at 7:06=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > The last caller is gone since v5.10-rc1~28.
> > >
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > I have already submitted this change:
> > https://lore.kernel.org/linux-arm-kernel/20230307124313.708255-1-festev=
am@denx.de/
>=20
> I don't care much which of them is included. Before patch #3 of my
> series is applied, either of the two must be applied first.

OK, Fabio's patch got in. So now the way is clear for patches #2 and #3
of this series.

FTR: b4 am -l -P2,3 20230328103136.xafgjdkvdwnn7pwi@pengutronix.de
does the right thing.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kmpiepxdigxle443
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmR2F40ACgkQj4D7WH0S
/k7W5wgAm56HBYpURHtWuuuJkYozxEkuJnktJYE7ZTY4bS/WhPP0JZaItvbhYrdz
8weMX2zH0d0s7t02rHWpRwEzsufbCWlEJduSqzQhhwjXF2Z1W1vwyjbL2NBe1Ip4
ibeHLnqPNYKRWbJdrMxAgXQIL63YRbQ5EOwuTOxaE8WreGPnbdjgazA9MIxEkSGj
cszRNJWqBjcAb0ikRuRY7APgDS9hbFqPXJGLWV62rOQfHRRGNxaBfe1eT0g9EUCj
ksw/2fY1Qq/1hX/a6yKa0QZhzCThNUXd47TCAc3m+NLtY6WzKSfZQH9zwHBwDKcv
ahuTmFFOw+SHrpOfsoel2N1nF1U0iw==
=dkH7
-----END PGP SIGNATURE-----

--kmpiepxdigxle443--
