Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7040C6B505B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjCJSs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjCJSsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:48:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A0EFD29A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 10:48:23 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pahms-0008G3-CF; Fri, 10 Mar 2023 19:48:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pahmr-003EbG-9O; Fri, 10 Mar 2023 19:48:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pahmq-003rel-KD; Fri, 10 Mar 2023 19:48:16 +0100
Date:   Fri, 10 Mar 2023 19:48:15 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Munehisa Kamata <kamatam@amazon.com>,
        Jeff LaBundy <jeff@labundy.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 3/4] pwm: iqs620a: Explicitly set .polarity in
 .get_state()
Message-ID: <20230310184815.x5v2ysyeyshnapm5@pengutronix.de>
References: <20230228135508.1798428-1-u.kleine-koenig@pengutronix.de>
 <20230228135508.1798428-4-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="urnuj6hhjjyzctov"
Content-Disposition: inline
In-Reply-To: <20230228135508.1798428-4-u.kleine-koenig@pengutronix.de>
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


--urnuj6hhjjyzctov
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[To +=3D Jeff LaBundy]

On Tue, Feb 28, 2023 at 02:55:07PM +0100, Uwe Kleine-K=F6nig wrote:
> The driver only supports normal polarity. Complete the implementation of
> .get_state() by setting .polarity accordingly.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I think we should apply this patch as a fix to prevent similar failures
as reported for the meson driver. To justify that:

Fixes: 6f0841a8197b ("pwm: Add support for Azoteq IQS620A PWM generator")

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--urnuj6hhjjyzctov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQLe2wACgkQwfwUeK3K
7Am9oQf+I5fTetCUNCq/nWdbgg/pRPZdkPQ5KvuuzxIgJaDgHTcJWbuak1Kzp2eD
BVwMxOwu2xqa6dnfxgTOrjRokZX3+l14Yi34bbWWGYlxRwHDI8Aa+HEUg2gJRqdE
d+BkQc8PquottmutKxdX8LY/hvbViGucbK24PyDGUhMi/+kKb8wOGPOtbW1s9YJ2
MlmbouNRVaFubZ3g8+MSvd9sQ5rjGlRKlwpL3W4vYxkYSiuBg6IUPXLfnvyLb9yP
ARZhhCxuXFE1ptVZuMp6bQdn9vipmlqabS9s6SIG6z3vEtAh2oNXj64rj45PNzlf
jr/ykwYrxgIVRVQUHIQHyYeStEa9Ww==
=PVCG
-----END PGP SIGNATURE-----

--urnuj6hhjjyzctov--
