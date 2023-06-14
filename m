Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E4272F88E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243838AbjFNJBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbjFNJBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:01:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128CF10E9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:01:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q9MNe-0001bM-Cx; Wed, 14 Jun 2023 11:01:30 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q9MNc-007JWQ-Bi; Wed, 14 Jun 2023 11:01:28 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q9MNb-00E9dX-Jd; Wed, 14 Jun 2023 11:01:27 +0200
Date:   Wed, 14 Jun 2023 11:01:27 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Shuijing Li <shuijing.li@mediatek.com>
Cc:     thierry.reding@gmail.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com
Subject: Re: [PATCH v2] pwm: mtk_disp: Fix the disable flow of disp_pwm
Message-ID: <20230614090127.6xynz6ti6cqptyy5@pengutronix.de>
References: <20230518115258.14320-1-shuijing.li@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g65y4tisr66ns5qu"
Content-Disposition: inline
In-Reply-To: <20230518115258.14320-1-shuijing.li@mediatek.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g65y4tisr66ns5qu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 07:52:58PM +0800, Shuijing Li wrote:
> There is a flow error in the original mtk_disp_pwm_apply() function.
> If this function is called when the clock is disabled, there will be a
> chance to operate the disp_pwm register, resulting in disp_pwm exception.
> Fix this accordingly.
>=20
> Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-kleine@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--g65y4tisr66ns5qu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSJgeYACgkQj4D7WH0S
/k4CfQf/dTzLQ5c2z/jSsZTIMPhUgJHtpEI+aFepaoUfNA4IRC+IrFVStQ8V/RJU
6dAFA3nAUYFHuzZpQLTcaENDfr6MabMfSAR4yXhOaPcslme9pIpTuRnUZIIO0qvR
42/AQxjcFCioGJAY0ARo4QLeKECZiK0U/ggPi3KRlqtd+XN78/q1Gc6483+0Eu4U
F9ggDwUAft504AudLQq1CcKqUI4r2DkzpgKxzdTTOGcUFGCdwdhfjE0AooUN2wOp
Fex3oZYrqkcw2WmUZydpEdSQ294jgNOBMG760VKK0mOrJDppOsPPRQN0jbK8J2i+
4fiBt05cMgr2YeSBI1T7Fxh4dU5SPw==
=mYin
-----END PGP SIGNATURE-----

--g65y4tisr66ns5qu--
