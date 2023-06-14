Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B35872F92B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244054AbjFNJaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244047AbjFNJ3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:29:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B820E41
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:29:38 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q9Mod-0006Hu-CW; Wed, 14 Jun 2023 11:29:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q9Moa-007K2O-V4; Wed, 14 Jun 2023 11:29:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q9Moa-00EAN5-62; Wed, 14 Jun 2023 11:29:20 +0200
Date:   Wed, 14 Jun 2023 11:29:20 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Shuijing Li <shuijing.li@mediatek.com>
Cc:     thierry.reding@gmail.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com, Fei Shao <fshao@chromium.org>
Subject: Re: [PATCH v3] pwm: mtk_disp: Fix the disable flow of disp_pwm
Message-ID: <20230614092920.sl2qjdx3wbf7xtcm@pengutronix.de>
References: <20230531031001.7440-1-shuijing.li@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7wrtscz2pppnkeoz"
Content-Disposition: inline
In-Reply-To: <20230531031001.7440-1-shuijing.li@mediatek.com>
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


--7wrtscz2pppnkeoz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2023 at 11:10:01AM +0800, Shuijing Li wrote:
> There is a flow error in the original mtk_disp_pwm_apply() function.
> If this function is called when the clock is disabled, there will be a
> chance to operate the disp_pwm register, resulting in disp_pwm exception.
> Fix this accordingly.
>=20
> Fixes: 888a623db5d0 ("pwm: mtk-disp: Implement atomic API .apply()")
> Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Tested-by: Fei Shao <fshao@chromium.org>

When I sent my ack for v2, I missed there was already a v3, so here
again for the sake of easier maintenance:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

> ---
> Changes in v3:
> Add Fixes per suggestion from the previous thread:

Note that for that a new version isn't necessary, patchwork (and I think
also b4) pick up a fixes line from replies.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7wrtscz2pppnkeoz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSJiG8ACgkQj4D7WH0S
/k7apQf/QaFjN2bcdxDG3XjvUNxRfD7RzMDbbOJEbaqKBdj4v2M9frLXUojcBuu4
OEXHdWb10Ubr4+XXAFxEf/DEhL8ejeD+RCp3qGCThjEnjEpv1X9XuaUR4WdcplVJ
Aw1XlXDBIKULr/Mhmq9cvPQ7zJ0UYvLYDyKdK56QoItIoA60xHi37SSzWXWEzMCJ
Eiyav50MyLXNBzx8UciAX8xGnN/C58csjV+kcckEAhuG7bF+ge5h6CjZzcxbTI1v
hlzmQiRWt2NJsCd28aS4+7ibCtXW5GkYhGW1Gbxip8m/qlUw+CAelkrOBMK6ZQRL
86cczXryeWLJGY7qC8lzocKjBZdt1w==
=SoWt
-----END PGP SIGNATURE-----

--7wrtscz2pppnkeoz--
