Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E190862DA01
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239378AbiKQL5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbiKQL5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:57:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48392CC5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:57:37 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovdWP-0007Uu-Oq; Thu, 17 Nov 2022 12:57:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovdWN-004qBu-A0; Thu, 17 Nov 2022 12:57:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovdWN-00HGdU-63; Thu, 17 Nov 2022 12:57:31 +0100
Date:   Thu, 17 Nov 2022 12:57:31 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Daniel Golle <daniel@makrotopia.org>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        Zhi Mao <zhi.mao@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>
Subject: Re: [PATCH] pwm: mediatek: always use bus clock for PWM on MT7622
Message-ID: <20221117115731.ryourz6nclatx4dw@pengutronix.de>
References: <Y1iF2slvSblf6bYK@makrotopia.org>
 <eb47aba9-e5d9-9f27-06ae-cf386b291b05@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="isvrtb75uwxrlbmv"
Content-Disposition: inline
In-Reply-To: <eb47aba9-e5d9-9f27-06ae-cf386b291b05@collabora.com>
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


--isvrtb75uwxrlbmv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2022 at 10:39:31AM +0200, AngeloGioacchino Del Regno wrote:
> Il 26/10/22 02:56, Daniel Golle ha scritto:
> > According to MT7622 Reference Manual for Development Board v1.0 the PWM
> > unit found in the MT7622 SoC also comes with the PWM_CK_26M_SEL register
> > at offset 0x210 just like other modern MediaTek ARM64 SoCs.
> > And also MT7622 sets that register to 0x00000001 on reset which is
> > described as 'Select 26M fix CLK as BCLK' in the datasheet.
> > Hence set has_ck_26m_sel to true also for MT7622 which results in the
> > driver writing 0 to the PWM_CK_26M_SEL register which is described as
> > 'Select bus CLK as BCLK'.
> >=20
> > Fixes: 0c0ead76235db0 ("pwm: mediatek: Always use bus clock")
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>=20
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--isvrtb75uwxrlbmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN2IagACgkQwfwUeK3K
7AkUEQgAkSTP01iZik0R1H9BlFL8PfBxuv4XRkY+HdOduJzVWMXaU21tFylYCFyU
vfuYv9V3+6Kz22JhpYi91wDxDLxWB+2f4NiSYyu/6s3HG41MX2h1rC93YIqprUKK
EheP4j6fd6w6sbyQHpEivOeX4rSKtub5FWmcRqxc+EY+GjV5eAXH48v+ree+sf4I
uX7PgS2LVDjjYVMc6Cszv7rUb6c5mE1Yulx0tc5wp5vZOVD+JTJIB8NNDPKdAvaF
6vNGTeXd86BnWCW+lPy905SPSTNTjdECc4o2Efctjuwrup630RUBuxY+sqoDmDTg
gviXeg2hK01EmcXzHJEvd/sHfhUZrA==
=VoOy
-----END PGP SIGNATURE-----

--isvrtb75uwxrlbmv--
