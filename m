Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438956E3A6A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 19:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjDPRFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 13:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjDPRFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 13:05:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEA91FFE
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:05:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1po5ol-0000EQ-90; Sun, 16 Apr 2023 19:05:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1po5ok-00BgcE-Jg; Sun, 16 Apr 2023 19:05:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1po5oj-00DgzC-BQ; Sun, 16 Apr 2023 19:05:33 +0200
Date:   Sun, 16 Apr 2023 19:05:33 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: clk: Use the devm_clk_get_prepared() helper function
Message-ID: <20230416170533.raji7rbawg6b4jpv@pengutronix.de>
References: <9281571825c365c1591fcf31527d45ec576c19b4.1681635694.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v6eywzs64ccbnngs"
Content-Disposition: inline
In-Reply-To: <9281571825c365c1591fcf31527d45ec576c19b4.1681635694.git.christophe.jaillet@wanadoo.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v6eywzs64ccbnngs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Apr 16, 2023 at 11:02:13AM +0200, Christophe JAILLET wrote:
> Use the devm_clk_get_prepared() helper function instead of hand-writing i=
t.
> It saves some line of codes.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--v6eywzs64ccbnngs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQ8KtwACgkQj4D7WH0S
/k4B5gf6A9VivW1m+6DUJHhfWnBMes4HsyzomWZ4Jw+pzaVfZ4ADBtXUH+L84Op+
WomdnsDMifEhRRDk6DyG/Q9qFB+fawNmqmadg8XwvvwjLYXfID1TIBOgVaaSgFnz
OtyOql/PzfeeJGl50pTPrb3TgYFphEpT1NB2K3jkLfO/sxOZAquMq0GlY8tOmwTT
XeQNHpQi7693H7RMrpr+4vi8iLqqHrxX07oTahk1ZES8G4HHLgsxwpXdGoODOhxZ
5B/LtsX/gjxFbX72mFHD5KKRDeU9hBZXO8XIDNlyN3y0zYdEE+XHpeVIqHmFqRdp
ufZ07fkpFUF6njMVf7Yzg/uSXtg8kg==
=jt+G
-----END PGP SIGNATURE-----

--v6eywzs64ccbnngs--
