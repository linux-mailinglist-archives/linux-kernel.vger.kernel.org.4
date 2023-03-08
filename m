Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C2B6B0E33
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjCHQI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjCHQIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:08:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D99B56C3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 08:07:40 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZwK7-00035i-Ai; Wed, 08 Mar 2023 17:07:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZwK4-002kXG-Q7; Wed, 08 Mar 2023 17:07:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZwK4-003KOq-0o; Wed, 08 Mar 2023 17:07:24 +0100
Date:   Wed, 8 Mar 2023 17:07:23 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        thierry.reding@gmail.com, matthias.bgg@gmail.com,
        weiqing.kong@mediatek.com, jitao.shi@mediatek.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 0/2] pwm: mtk-disp: Fix backlight configuration at boot
Message-ID: <20230308160723.rhgsghtxxkfhbsu6@pengutronix.de>
References: <20230123160615.375969-1-angelogioacchino.delregno@collabora.com>
 <06918fde-64ea-37b2-da1a-1c8316457223@collabora.com>
 <06909bd8-3da2-1cf0-82ac-3ed4f3e63def@collabora.com>
 <ZAigsHAgqkLlBD1y@kroah.com>
 <28142704-d82d-d533-d2a8-b1061182f1f6@collabora.com>
 <ZAitHYRCUHsIvZMk@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ktav3puihvogk7lj"
Content-Disposition: inline
In-Reply-To: <ZAitHYRCUHsIvZMk@kroah.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ktav3puihvogk7lj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2023 at 04:43:25PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Mar 08, 2023 at 03:55:59PM +0100, AngeloGioacchino Del Regno wrot=
e:
> > Il 08/03/23 15:50, Greg Kroah-Hartman ha scritto:
> > > On Wed, Mar 08, 2023 at 12:46:07PM +0100, AngeloGioacchino Del Regno =
wrote:
> > > > Il 23/02/23 15:16, AngeloGioacchino Del Regno ha scritto:
> > > > > Il 23/01/23 17:06, AngeloGioacchino Del Regno ha scritto:
> > > > > > Since the pwm-mtk-disp driver was fixed to get PWM_EN state fro=
m the
> > > > > > right register, an old two-wrongs-make-one-right issue emerged:=
 as a
> > > > > > result, MT8192 Asurada Spherion got no backlight at boot unless=
 a
> > > > > > suspend/resume cycle was performed.
> > > > > > Also, the backlight would sometimes not get updated with the re=
quested
> > > > > > value, requiring the user to change it back and forth until it =
worked.
> > > > > >=20
> > > > > > This series fixes both of the aforementioned issues found on MT=
8192.
> > > > > >=20
> > > > > > AngeloGioacchino Del Regno (2):
> > > > > >  =A0=A0 pwm: mtk-disp: Disable shadow registers before setting =
backlight
> > > > > >  =A0=A0=A0=A0 values
> > > > > >  =A0=A0 pwm: mtk-disp: Configure double buffering before readin=
g in
> > > > > >  =A0=A0=A0=A0 .get_state()
> > > > > >=20
> > > > > >  =A0 drivers/pwm/pwm-mtk-disp.c | 34 +++++++++++++++++++++++---=
--------
> > > > > >  =A0 1 file changed, 23 insertions(+), 11 deletions(-)
> > > > > >=20
> > > > >=20
> > > > > Gentle ping for this one: this is fixing backlight issues on mult=
iple MediaTek
> > > > > SoCs and was well tested.
> > > > >=20
> > > > > Thanks,
> > > > > Angelo
> > > >=20
> > > > Since this series was sent more than one month ago, and since this =
fixes broken
> > > > backlight on a number of Chromebooks with MT8183 and MT8192 SoCs, a=
nd seen the
> > > > urgency of getting these fixes in, I'm adding Greg to the loop.
> > >=20
> > > $ ./scripts/get_maintainer.pl drivers/pwm/pwm-mtk-disp.c
> > > Thierry Reding <thierry.reding@gmail.com> (maintainer:PWM SUBSYSTEM)
> > > "Uwe Kleine-K=F6nig" <u.kleine-koenig@pengutronix.de> (reviewer:PWM S=
UBSYSTEM)
> > > Matthias Brugger <matthias.bgg@gmail.com> (maintainer:ARM/Mediatek So=
C support)
> > > AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =
(reviewer:ARM/Mediatek SoC support)
> > > linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM)
> > > linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support)
> > > linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC=
 support)
> > > linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC s=
upport)
> > >=20
> > > I don't see my name in there, did I become the PWM maintainer somehow?
> > >=20
> > > What's wrong with Thierry taking this like normal?
> > >=20
> >=20
> > Nothing wrong with that. I felt like this series got ignored as I've ne=
ver
> > received any reply from Thierry, even though it's a Fixes series that I=
 deem
> > to be moderately urgent; that's why I added you to the loop.
>=20
> Then ask Thierry and Uwe, what would you want to have happen if you were
> the maintainer of a subsystem?
>=20
> > If that created unnecessary noise, I'm extremely sorry and won't happen=
 again.
>=20
> Not noise, just confusion on my part.  I'm glad to take patches that
> have no obvious maintainers, or maintainers that have disappeared, but
> that doesn't seem to be the case here.

I'm aware that there is a big backlog on PWM patches. I'm trying to
catch up but there is only so much time. Sorry this results in delays
for you (and others), I'm not happy with this situation either.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ktav3puihvogk7lj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQIsrgACgkQwfwUeK3K
7AmgSwf7B3y69Q4iYv/xi1xc6LYfsDU2LWsLiewM1J93Wig3bmxGsw2xu3z7LefN
YthxYf2xylEq1KstnkALgviEYrO2YMip5hehZmT0+oU1XV9aqo4MW3J0eGbnFu3H
B1eh5ek0N7wUoxaiEaAFo760STCtOdXtw1MMaLkw6STdz97Cja53X8B/zUIy7Fcl
Ptx2FXXXjcO2GE4FZOfaYwKhbxdpRAQ8tmwKq/3bNs2NmQ2vDWEpOkq47chVmx4s
+EAHKogcbAgHB6brcNqKytU/2G41l1VRNcbiHZsVjZ6cY5kSWVDyLxHG89dtN5Ej
17nXfuwFkQW7Jr1gGxyfLtx/Oir3AA==
=Ca5l
-----END PGP SIGNATURE-----

--ktav3puihvogk7lj--
