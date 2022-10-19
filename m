Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E08B60470C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiJSN1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiJSN1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:27:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01635D73F0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:13:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ol8ra-0005Jo-Df; Wed, 19 Oct 2022 15:12:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ol8rV-0007lp-EF; Wed, 19 Oct 2022 15:11:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ol8rU-009585-KG; Wed, 19 Oct 2022 15:11:56 +0200
Date:   Wed, 19 Oct 2022 15:11:55 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     xinlei.lee@mediatek.com
Cc:     thierry.reding@gmail.com, matthias.bgg@gmail.com,
        jitao.shi@mediatek.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v4] pwm: mtk-disp: Fix the parameters calculated by the
 enabled flag of disp_pwm
Message-ID: <20221019131155.52d2yr34f6zapz5d@pengutronix.de>
References: <1666172538-11652-1-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xhy4bguvzu5lob7d"
Content-Disposition: inline
In-Reply-To: <1666172538-11652-1-git-send-email-xinlei.lee@mediatek.com>
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


--xhy4bguvzu5lob7d
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 19, 2022 at 05:42:18PM +0800, xinlei.lee@mediatek.com wrote:
> From: xinlei lee <xinlei.lee@mediatek.com>
>=20
> In the original mtk_disp_pwm_get_state() function wrongly uses bit 0 of
> CON0 to judge if the PWM is enabled.
> However that is indicated by a bit (at a machine dependent position) in
> the DISP_PWM_EN register. Fix this accordingly.
>=20
> Fixes: 3f2b16734914 ("pwm: mtk-disp: Implement atomic API .get_state()")
> Signed-off-by: xinlei lee <xinlei.lee@mediatek.com>

Nice commit log text :-)

This now matches the bit that the .apply() callback sets, so looks
right.

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xhy4bguvzu5lob7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNP95YACgkQwfwUeK3K
7AnmNgf/R5fc4bTc7jwlwiPYCqu6y2+9CwYzDaBQRKTTm07Wn728qFUCf+/PMfDh
xMoThPYZRd8iLccDFydMRHavS82UrvIvMAKkh3Utf0j9luEriB3mOZCEw4PkkZ90
xoAj7F0avheWNPHDwapjS45TMfVOSwIDHaAxA9y9irVZmCt50ICb2SDAakk+nB8j
4d4MnpUv/N9uYGEKK2iLrH3pNpcdkq9EX4/6JC324ok7c17blRNG73RJzfFAJLYx
qzSXyi3BqRnCo1FUHDMbM/x79jR6gR9jMKju/+Dw1y9jEIK13//2PxmhrsatUGQv
R6OtXDe92i4kXdVbwHR2BKZl/xYWDQ==
=JPEN
-----END PGP SIGNATURE-----

--xhy4bguvzu5lob7d--
