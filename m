Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907AD7193D0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjFAHCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjFAHBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:01:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF155134
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 00:01:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4cJO-0007Dw-Vh; Thu, 01 Jun 2023 09:01:31 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4cJN-004IDz-79; Thu, 01 Jun 2023 09:01:29 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4cJM-00A4Tj-Ho; Thu, 01 Jun 2023 09:01:28 +0200
Date:   Thu, 1 Jun 2023 09:01:28 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 16/43] pwm: ep93xx: add DT support for Cirrus EP93xx
Message-ID: <20230601070128.ejvigvxwm6cg4izf@pengutronix.de>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-17-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dt4scfjwkljqxhzi"
Content-Disposition: inline
In-Reply-To: <20230601053546.9574-17-nikita.shubin@maquefel.me>
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


--dt4scfjwkljqxhzi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jun 01, 2023 at 08:34:07AM +0300, Nikita Shubin wrote:
> - find register range from the device tree
> - provide clock access via of
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Looks good to me,

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

There don't seem to be dependencies interdependencies to other patches
in this series?! What is the merge plan here. Should this patch go in
via the PWM tree, or will the whole series go in via armsoc?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dt4scfjwkljqxhzi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmR4QkcACgkQj4D7WH0S
/k7Ppgf9FE8ViunZriA8NiwQZBRDAbOoeEfMRRVEJCnnl2nGe9fkiIvnlxySyCKR
gU6/vMYFiG8ZA79hGpOKRbYgBnAfzC7UKa9rlw6aEBT9EhFglyROB8aSt4nnyAD6
7auM9CixNVWVK7kuTx+hJDGY/cL8u41msjKfN7ydLPGZx6s7m5qZOyihT1VtPEPH
0UrqZQXLqqC3GowyVQ88Ms8/vp6jPCb4uDNgd+D8sAJccLQlrqM9j+Lyo3+fACOG
v73usLULZ/dJzOxP94G5HQb2r+eLcwVCMtFcUalcGQn9W/cJIxx3OC0V/t+/91xJ
z6BtZid6W1DR0jMpcjPBMP6eCULj+g==
=CipR
-----END PGP SIGNATURE-----

--dt4scfjwkljqxhzi--
