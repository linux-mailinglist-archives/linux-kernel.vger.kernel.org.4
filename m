Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776F172F886
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243406AbjFNJAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243948AbjFNI76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:59:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906D41BEF
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:59:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q9MM1-00014K-C3; Wed, 14 Jun 2023 10:59:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q9MM0-007JWG-EF; Wed, 14 Jun 2023 10:59:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q9MLz-00E9bd-R7; Wed, 14 Jun 2023 10:59:47 +0200
Date:   Wed, 14 Jun 2023 10:59:47 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     thierry.reding@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: imx-tpm: force 'real_period' to be zero in suspend
Message-ID: <20230614085947.d4b2iaopcbit624w@pengutronix.de>
References: <20230505065839.3973693-1-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7kagizhkcqmlnfyb"
Content-Disposition: inline
In-Reply-To: <20230505065839.3973693-1-xiaoning.wang@nxp.com>
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


--7kagizhkcqmlnfyb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2023 at 02:58:39PM +0800, Clark Wang wrote:
> From: Fancy Fang <chen.fang@nxp.com>
>=20
> During suspend, all the tpm registers will lose values.
> So the 'real_period' value of struct 'imx_tpm_pwm_chip'
> should be forced to be zero to force the period update
> code can be executed after system resume back.
>=20
> Signed-off-by: Fancy Fang <chen.fang@nxp.com>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
Fixes: 738a1cfec2ed ("pwm: Add i.MX TPM PWM driver support")

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7kagizhkcqmlnfyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSJgYIACgkQj4D7WH0S
/k5g7Qf+LGUIPWUN0qs0os0bldq4CY07sUjFXHnyD9Fz1VQToZnF/7iCbdGRbJ5X
PIdn1utW5NCLVxqvtwJpIT/Se9DcejX56Nmi4TutiyqyD4gFrujzVJDFxwdJBWby
QU7DFMrcx923Rqw8tR1kW4ClY3lIUw1tcJbDCc7CAEpjwhrXp5iSMB6Hkf9d7dqC
9pGXRkSiJOU9oZKEhRa9sV+5YAX9DWyIMtvswGmJ+evEtP/RfETZg3Ps9U0yIf9a
5QXe+HPLHxgRwVDfxOCcHM64jVwB0mTbCy/n+o+gBdfFdioIyaPJpbtTwlZyYFRV
vKRgGk504ydR2Xc/YWQaBNb4uh7JXg==
=Nhqn
-----END PGP SIGNATURE-----

--7kagizhkcqmlnfyb--
