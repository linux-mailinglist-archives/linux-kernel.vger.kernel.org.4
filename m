Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B325BC405
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiISIIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiISIIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:08:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9974AE5C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:08:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oaBpR-00024Z-23; Mon, 19 Sep 2022 10:08:33 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oaBpQ-001cYn-Um; Mon, 19 Sep 2022 10:08:31 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oaBpO-001tgj-NS; Mon, 19 Sep 2022 10:08:30 +0200
Date:   Mon, 19 Sep 2022 10:08:30 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     xinlei.lee@mediatek.com
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jitao.shi@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH] dt-bindings: pwm: Add compatible for Mediatek MT8188
Message-ID: <20220919080830.cmuzuuk5h564ouz6@pengutronix.de>
References: <1661744916-15441-1-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="axihye5zdoc3qesl"
Content-Disposition: inline
In-Reply-To: <1661744916-15441-1-git-send-email-xinlei.lee@mediatek.com>
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


--axihye5zdoc3qesl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 29, 2022 at 11:48:36AM +0800, xinlei.lee@mediatek.com wrote:
> From: xinlei lee <xinlei.lee@mediatek.com>
>=20
> Base on the branch of Linux-next/master.
> Split from series [1].
> [1] https://patchwork.kernel.org/project/linux-mediatek/cover/1661239875-=
19841-1-git-send-email-xinlei.lee@mediatek.com/
>=20
> Add dt-binding documentation of pwm for MediaTek MT8188 SoC.
>=20
> Signed-off-by: xinlei lee <xinlei.lee@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

The change looks fine, the commit log isn't that informative. I'd just
write:

	Subject: dt-bindings: pwm/mediatek: Add compatible for Mediatek MT8188

	Add dt-binding documentation for PWM found on MediaTek MT8188 SoC.

	Signed-off-by: ...

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--axihye5zdoc3qesl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMoI3sACgkQwfwUeK3K
7AmQLggAn7bjuR94Q+/jw6sBzjXrsF/ycisR1aBRBuWDMeG7mNOXhsX/VkNdcxg/
7dO9DsVR1a+3uYfvmaJuRYfygimAizemmBw2xeWohdl6lUXykVU9kkp55iIJEEaQ
wRIjD1xH2tpTLODGTRWM7LCVRsDO/DHOgs2MY2axGybI4X+DR6ya9ss5neU4V3WF
QCqOU/9vy74I0FzsxRF+pRNqFxDh/2ZLFN/2Jmp6If3NGi3rRtH1EfVL/pm1t+kj
d+XvXny1oDY5cJa4rcAX5oSHUAcOeoVqXUkfCOmGEe8FNxBWi1UJIELu+c8/DQhF
G3DEwhZAfgzPsxAaiCW4NOuRNhqazQ==
=I8Y5
-----END PGP SIGNATURE-----

--axihye5zdoc3qesl--
