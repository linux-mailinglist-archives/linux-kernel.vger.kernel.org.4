Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100426CBC94
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjC1Kdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbjC1Kds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:33:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D1B768F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:33:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ph6e6-00021E-4m; Tue, 28 Mar 2023 12:33:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ph6e5-007Hgj-57; Tue, 28 Mar 2023 12:33:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ph6e4-008f0h-Dr; Tue, 28 Mar 2023 12:33:40 +0200
Date:   Tue, 28 Mar 2023 12:33:39 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabio Estevam <festevam@denx.de>
Cc:     daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] clocksource/drivers/timer-imx-gpt: Remove non-DT function
Message-ID: <20230328103339.ycew6joobfgbcocb@pengutronix.de>
References: <20230307124313.708255-1-festevam@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j6tbprrgiwdb4ik6"
Content-Disposition: inline
In-Reply-To: <20230307124313.708255-1-festevam@denx.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j6tbprrgiwdb4ik6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 07, 2023 at 09:43:13AM -0300, Fabio Estevam wrote:
> mxc_timer_init() was originally only used by non-DT i.MX platforms.
>=20
> i.MX has already been converted to be a DT-only platform.
>=20
> Remove the unused mxc_timer_init() function.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Actually I created the same patch and have another patch that depends on
this one. See
https://lore.kernel.org/linux-arm-kernel/20230328100531.879485-1-u.kleine-k=
oenig@pengutronix.de/#t
=2E

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--j6tbprrgiwdb4ik6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQiwoIACgkQj4D7WH0S
/k6rHwgAnT5GkoCbf6nlkti4LNrAwPTTAIQQh/oDhpRHrdkEHUpjZ05Vz5kvz5OA
XMd6SsD4rrtRx0RA2lgW3VqHvJpUfjiwAFs4OPEeF61RBlHH8Md6OEHSCsmhrxw1
aD8L3FnYFxIIIm+OslCPrx08Y1KKBrMDsbzbWNF3xvSz8efdOa+iFaZTXoxd9IyS
vYXiMTBvXcdHEZij/CcClHdh4tFLQipyljEb/PsgZ7QqUE715EwOPJwDtsziNtRe
SpACXdQY9sJs8vTter4fMMvSIwm7pcgKEoK0AdN49nauFL5ThWwaJzFeZVkccXXi
vSaUBxwKv64xjtRgsbPiatNwaRjOeg==
=1BeK
-----END PGP SIGNATURE-----

--j6tbprrgiwdb4ik6--
