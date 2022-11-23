Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCFB6360C4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbiKWN7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236016AbiKWN6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:58:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6941D5A6CF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:53:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oxqBL-0000GM-HC; Wed, 23 Nov 2022 14:52:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oxqBJ-0063uu-5s; Wed, 23 Nov 2022 14:52:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oxqBJ-0011bN-B2; Wed, 23 Nov 2022 14:52:53 +0100
Date:   Wed, 23 Nov 2022 14:52:53 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     thierry.reding@gmail.com, alexandre.torgue@foss.st.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        olivier.moysan@foss.st.com
Subject: Re: [PATCH] pwm: stm32-lp: fix the check on arr and cmp registers
 update
Message-ID: <20221123135253.dcuxxuyqvqtdwz5b@pengutronix.de>
References: <20221123133652.465724-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cvhlradggud6ocvy"
Content-Disposition: inline
In-Reply-To: <20221123133652.465724-1-fabrice.gasnier@foss.st.com>
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


--cvhlradggud6ocvy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2022 at 02:36:52PM +0100, Fabrice Gasnier wrote:
> The ARR (auto reload register) and CMP (compare) registers are
> successively written. The status bits to check the update of these
> registers are polled together with regmap_read_poll_timeout().
> The condition to end the loop may become true, even if one of the
> register isn't correctly updated.
> So ensure both status bits are set before clearing them.
>=20
> Fixes: e70a540b4e02 ("pwm: Add STM32 LPTimer PWM driver")
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Looks reasonable

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cvhlradggud6ocvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN+JbIACgkQwfwUeK3K
7AnTrAf9H/ODBQF61mFT1V6ZbR5uR/JCsCZBHrsNck9itpnzc6LvJO8K68jaVEVj
2c58ekTJ7mhqz/UF7tk5fNdQlUDvLRPG8IX3LDWjrEDSQVaEH30nw4y0CBKU8lVh
5LcMu/oe7KtSAj/bxp1AdYViZ/YHMZPPDJgpqgrQPxAWWQAcZRj0aRsEgPdi0FTU
DD+wCZTfu5NgVgHvH2rEF+AqEE1L2dU1TU5FSLN2gUTWsBKgqJyQheebazCJkC6H
vR3vLWxSRtxhs59VZdXxdyJ5m+s4aWzsroclCFtu8A0ubijprskO5aAtef8MJhMy
wCymEGzXOGRdQNHgJ8RGfqo2acVpsg==
=LlXc
-----END PGP SIGNATURE-----

--cvhlradggud6ocvy--
