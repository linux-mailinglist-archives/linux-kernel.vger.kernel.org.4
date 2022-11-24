Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C21D637BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiKXOtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiKXOtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:49:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA8012EBF4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:48:44 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oyDWs-0003Kx-6A; Thu, 24 Nov 2022 15:48:42 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:5507:4aba:5e0a:4c27])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5CC5C12868B;
        Thu, 24 Nov 2022 14:48:41 +0000 (UTC)
Date:   Thu, 24 Nov 2022 15:48:39 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Heiko Schocher <hs@denx.de>
Cc:     linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] can: sja1000: fix size of OCR_MODE_MASK define
Message-ID: <20221124144839.bydrxcq25jeii6zi@pengutronix.de>
References: <20221123071636.2407823-1-hs@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="heofdz7wefweg7ur"
Content-Disposition: inline
In-Reply-To: <20221123071636.2407823-1-hs@denx.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
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


--heofdz7wefweg7ur
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23.11.2022 08:16:36, Heiko Schocher wrote:
> bitfield mode in ocr register has only 2 bits not 3, so correct
> the OCR_MODE_MASK define.
>=20
> Signed-off-by: Heiko Schocher <hs@denx.de>

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--heofdz7wefweg7ur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmN/hEUACgkQrX5LkNig
0128HggAhm6PhXn0StY6lxVojlEWmBbSHdS9vJhy8JrzPpnEdb3m7TuGOjPxBiox
LIVPTLLYKSwM9lAJDtXustIpLdgLAu3cT5yqQ90+V8LRM6zE+SZjv9mb6ciuo68p
E0rCtq8OTqwXRHaKzh7KVhTfokxFpvBAlu073kWTMsP3H0U1Sb7YnU0aYGoB1+rl
4FxBQ/L7yr/VVCc3jMAEIXgOiLwP9/xcGOOir6QQiiexvXqG/rKwJKa8gjjMxLxV
itaQYMmxbTqzefTmodUe0hhGRV+WLzCVE2Nps29KVPi1yLFcaE9A0cOegqvbapKi
b+VVORxbyjLX5TeN47/1kgmNG2i9tQ==
=txCp
-----END PGP SIGNATURE-----

--heofdz7wefweg7ur--
