Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E59603A84
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 09:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJSHUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 03:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJSHU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:20:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3046276954
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 00:20:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ol3Ms-0003Jb-10; Wed, 19 Oct 2022 09:19:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ol3Mp-0003wC-Hu; Wed, 19 Oct 2022 09:19:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ol3Mo-00915M-S1; Wed, 19 Oct 2022 09:19:54 +0200
Date:   Wed, 19 Oct 2022 09:19:54 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     xinlei.lee@mediatek.com
Cc:     thierry.reding@gmail.com, matthias.bgg@gmail.com,
        jitao.shi@mediatek.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3] pwm: mtk-disp: Fix the parameters calculated by the
 enabled flag of disp_pwm
Message-ID: <20221019071954.qv67h3brj6vnhxpw@pengutronix.de>
References: <1664447209-19417-1-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jj2msqu4zaqgjq6h"
Content-Disposition: inline
In-Reply-To: <1664447209-19417-1-git-send-email-xinlei.lee@mediatek.com>
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


--jj2msqu4zaqgjq6h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Sep 29, 2022 at 06:26:49PM +0800, xinlei.lee@mediatek.com wrote:
> From: xinlei lee <xinlei.lee@mediatek.com>
>=20
> In the original mtk_disp_pwm_get_state() function, the result of reading
> con0 & BIT(0) is enabled as disp_pwm.
> In order to conform to the register table, we should use the disp_pwm
> base address as the enabled judgment.

I assume the change is fine. However I don't understand the commit log.
My guess is you mean:

	mtk_disp_pwm_get_state() wrongly uses bit 0 of CON0 to judge if the
	PWM is enabled. However that is indicated by a bit (at a machine
	dependent position) in the DISP_PWM_EN register. Fix this
	accordingly.

> Fixes: 3f2b16734914 ("pwm: mtk-disp: Implement atomic API .get_state()")
>=20
> Signed-off-by: xinlei lee <xinlei.lee@mediatek.com>

Nitpick: There is no empty line between Fixes: and S-o-b.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jj2msqu4zaqgjq6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNPpRcACgkQwfwUeK3K
7Amduwf7BvhwtNcAt4vuj9gzQ+s/NYxV/0QuR4vGcO6h4hfcHNuWqbVpQGG9pqCW
VnfbrDK2FJOvBAJaQt9n0sqOIkaYpml4m5MiTlFNIgg1fsPaNn1MmQ020iGaFl00
rbHXRjP/bzv95awJ0zBSircbNOJnKJMugspqSA5b6CRPv8vMm/yvJdMfqd6RSwTY
YJltkzqvoTip8ri837u8CQGQVNkPdChwScJQidAXkZeX3p53NQIUkcmhi4MoR6hr
dFe7FGm9v0YuEayovq5fsQjw7DVq4FCuEUhb6yiInlLG9cfK5/Rnsswb3tBa2Yof
RjLCMovkK7mZnvZz3AezADVH0/Kh4Q==
=aM7U
-----END PGP SIGNATURE-----

--jj2msqu4zaqgjq6h--
