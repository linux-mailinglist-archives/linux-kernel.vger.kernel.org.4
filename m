Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B3D68F8C0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 21:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjBHUVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 15:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjBHUVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 15:21:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35667EF3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 12:21:13 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pPqwD-0004hI-34; Wed, 08 Feb 2023 21:21:05 +0100
Received: from pengutronix.de (hardanger-9.fritz.box [IPv6:2a03:f580:87bc:d400:16b8:5a69:e1a3:52e9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2BFE1173C84;
        Wed,  8 Feb 2023 20:21:04 +0000 (UTC)
Date:   Wed, 8 Feb 2023 21:21:03 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: bittiming: fix can_calc_bittiming() dummy helper
Message-ID: <20230208202103.6v2lus6q63l4wg6i@pengutronix.de>
References: <20230208163726.2154311-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7azmtzcxoxiibchb"
Content-Disposition: inline
In-Reply-To: <20230208163726.2154311-1-arnd@kernel.org>
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


--7azmtzcxoxiibchb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.02.2023 17:37:12, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The prototype for this function changed, but the alternative
> implementation needs the same change:

ACK - I've posted this fix this morning already.

| https://lore.kernel.org/all/20230207201734.2905618-1-mkl@pengutronix.de/

Will send a PR now, before this annoys more people :)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--7azmtzcxoxiibchb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmPkBCgACgkQvlAcSiqK
BOhJdwf/T5iD9MQXgU86uvNhocGDwvkWQEgybA3V5gc/aty7sbmTfJJTHthXAd6r
mKH/zuUmET/Oyibpj8IUHe5ufT5tIgVPEgl+2EyugjcH+0jRsU+K/SKsqcTzghqf
kEeJpHsyRLxse7WDzuOUf4LQuTcPkY9oGHtZ784J7qbGFYApiyGULDz8HzwRBFv+
Ll/YLPz9goDmHb7tdeu6mW16i3ecJCxB/gG29IAZTatfn+x7uHwP15B7iNwHOIuo
c2/PxyJSygOpwvgKPaITiiCyI+kKho7yd5cTkr6soiaEMNc05z/k7jbyq693UDGJ
P4iDbtuht4gsv29KzAl6QJdgezEIQw==
=F0Dx
-----END PGP SIGNATURE-----

--7azmtzcxoxiibchb--
