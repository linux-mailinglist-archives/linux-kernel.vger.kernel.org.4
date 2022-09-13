Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4235B6A42
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiIMJF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiIMJFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:05:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E74D543C5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:05:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oY1rE-0007zx-K3; Tue, 13 Sep 2022 11:05:28 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oY1rC-000SnT-KM; Tue, 13 Sep 2022 11:05:25 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oY1rA-000YSD-HX; Tue, 13 Sep 2022 11:05:24 +0200
Date:   Tue, 13 Sep 2022 11:05:21 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     xinlei.lee@mediatek.com
Cc:     thierry.reding@gmail.com, matthias.bgg@gmail.com,
        jitao.shi@mediatek.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH] pwm: mtk-disp: Fix the parameters calculated  by the
 enabled flag of disp_pwm.
Message-ID: <20220913090521.6ybohvgbehua4rgv@pengutronix.de>
References: <1661745852-27323-1-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ss3zheu2y6khfn6n"
Content-Disposition: inline
In-Reply-To: <1661745852-27323-1-git-send-email-xinlei.lee@mediatek.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ss3zheu2y6khfn6n
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Aug 29, 2022 at 12:04:12PM +0800, xinlei.lee@mediatek.com wrote:
> From: xinlei lee <xinlei.lee@mediatek.com>
>=20
> In the original mtk_disp_pwm_get_state() function, the result of reading
> con0 & BIT(0) is enabled as disp_pwm.=20
> In order to conform to the register table, we should use the disp_pwm=20
> base address as the enabled judgment.

Do you want to say:

	The enable bit of the hardware is bit 0 of the DISP_PWM_EN
	register at offset 0 for all supported hardwares. Up to now the
	bit was wrongly assumed to be in the CON0 register.

?

> Fixes: 3f2b16734914 ("pwm: mtk-disp: Implement atomic API .get_state()")
>=20

This newline is unusal.

> Signed-off-by: xinlei lee <xinlei.lee@mediatek.com>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---
> Base on the branch of Linux-next/master.
> Split from series [1].
> [1] https://patchwork.kernel.org/project/linux-mediatek/cover/1661239875-=
19841-1-git-send-email-xinlei.lee@mediatek.com/
> ---
> ---
>  drivers/pwm/pwm-mtk-disp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> index c605013..50425cd 100644
> --- a/drivers/pwm/pwm-mtk-disp.c
> +++ b/drivers/pwm/pwm-mtk-disp.c
> @@ -197,7 +197,7 @@ static void mtk_disp_pwm_get_state(struct pwm_chip *c=
hip,
>  	rate =3D clk_get_rate(mdp->clk_main);
>  	con0 =3D readl(mdp->base + mdp->data->con0);
>  	con1 =3D readl(mdp->base + mdp->data->con1);
> -	state->enabled =3D !!(con0 & BIT(0));
> +	state->enabled =3D !!(readl(mdp->base) & BIT(0));

I would expect this to better be:

	state->enabled =3D !!(readl(mdp->base + DISP_PWM_EN) & BIT(0));

which is the same for the compiler but a bit more descriptive for the
human reader.

>  	clk_div =3D FIELD_GET(PWM_CLKDIV_MASK, con0);
>  	period =3D FIELD_GET(PWM_PERIOD_MASK, con1);
>  	/*

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ss3zheu2y6khfn6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMgR84ACgkQwfwUeK3K
7AmsfQf/TlNRXjA19E2+0tCASjyiQWsjnKiN3D+nPd9q8hTxXDbGyQ5KOtZWuUDZ
+D4joVtIozL0FvlLaR/c745PZm3evjT1S4ZfjgMb+f1/ZSwAX3CyUR0DyRvLubMU
niChOnS0K063Q8RShrCG8qaphmlSrp82HNKfyjt5aT2dvHBKkNo90llkn4BI5h2G
p3t5fRn/OtbymDjCt7LsFtZqr5Fck5WiW7aTEkZrT5Wz6FQZ9TMbIgmC3X+wNenK
cbCPPBfFPDADycZjWaZk3HYfG7P2O1cB595u3i87XeuTIZVAZg9F483lA9z7s4MT
RecWGzcRbCOwRPgtwcI+jSK2WtP1jA==
=JSbz
-----END PGP SIGNATURE-----

--ss3zheu2y6khfn6n--
