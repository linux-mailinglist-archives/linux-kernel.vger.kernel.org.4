Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA266B503E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjCJSoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjCJSoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:44:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4D6118820
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 10:44:03 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pahif-0007Qj-BF; Fri, 10 Mar 2023 19:43:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pahie-003Eag-4u; Fri, 10 Mar 2023 19:43:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pahic-003re9-9R; Fri, 10 Mar 2023 19:43:54 +0100
Date:   Fri, 10 Mar 2023 19:43:52 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Munehisa Kamata <kamatam@amazon.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 4/4] pwm: sprd: Explicitly set .polarity in .get_state()
Message-ID: <20230310184352.rqdc7oirzwhtj6fy@pengutronix.de>
References: <20230228135508.1798428-1-u.kleine-koenig@pengutronix.de>
 <20230228135508.1798428-5-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s36ewetkwq53ykaq"
Content-Disposition: inline
In-Reply-To: <20230228135508.1798428-5-u.kleine-koenig@pengutronix.de>
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


--s36ewetkwq53ykaq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2023 at 02:55:08PM +0100, Uwe Kleine-K=F6nig wrote:
> The driver only supports normal polarity. Complete the implementation of
> .get_state() by setting .polarity accordingly.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I think we should apply this patch as a fix to prevent similar failures
as reported for the meson driver. To justify that:

Fixes: 8aae4b02e8a6 ("pwm: sprd: Add Spreadtrum PWM support")

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--s36ewetkwq53ykaq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQLemUACgkQwfwUeK3K
7AnxBAf+MMTLjVc9dRtCeZKhwZ8QhBasZzAJnWIhcmFDKtKBuDQiR1f2WDj9S/n9
2cuyOZwB2PXbVyjbWe2orpcNuno/7xuIIwPbgMhiEUv4+7DM7Yd4Y0rXHJeFx9aO
ePb8m/WFQwgkGg4D1DTJkuS0MefHAkckMC6BmpQVcdgzJjn59iUaesitUfYHxPoM
VcY8KPs9MhamccK69Jxe7R3TIpI5kPqFLrM7QC2eGnMpt2TWVh5xh8hh984wiNVO
yU7w3oJih4oK5LxDpzAhQm1ceUJawNH/5cXOo36dvqZi5gcqgxmcKnLUDX6xtWlx
RC/aCcZZXvxC94glNsr7tglkvFA6rQ==
=F3JG
-----END PGP SIGNATURE-----

--s36ewetkwq53ykaq--
