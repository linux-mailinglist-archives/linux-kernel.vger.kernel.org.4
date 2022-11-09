Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5389862271E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiKIJfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiKIJfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:35:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B33E12AC4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:35:42 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oshUV-0006Z1-Ox; Wed, 09 Nov 2022 10:35:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oshUT-003DxS-Ue; Wed, 09 Nov 2022 10:35:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oshUU-00FOAE-0O; Wed, 09 Nov 2022 10:35:26 +0100
Date:   Wed, 9 Nov 2022 10:35:25 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 4/4] MAINTAINERS: add pwm to PolarFire SoC entry
Message-ID: <20221109093525.kx4tyvha7y3sikxw@pengutronix.de>
References: <20221007113512.91501-1-conor.dooley@microchip.com>
 <20221007113512.91501-5-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j2hqheguodcnpfxl"
Content-Disposition: inline
In-Reply-To: <20221007113512.91501-5-conor.dooley@microchip.com>
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


--j2hqheguodcnpfxl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 07, 2022 at 12:35:13PM +0100, Conor Dooley wrote:
> Add the newly introduced pwm driver to the existing PolarFire SoC entry.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I assume you will rework the series and resend this one with the driver
patche. Applying patch #4 alone doesn't make sense, so I'm marking this
one as "changes requested", too, in the PWM patchwork instance.

IMHO patches #1 and #2 make sense to be applied already without the
driver given the binding is already there. I assume they will go in via
the riscv tree, so I will mark these two as "handled elsewhere".

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--j2hqheguodcnpfxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNrdFoACgkQwfwUeK3K
7AnGmQf+K1H9/LKM8GH76W5yD7l8pEgea9lXFSIw38y1pSWhAJemyAAnDrJ/HBSk
8nfOg4/te1A53/p/hQE8h3aWO/dss2KZ5vf34eWW1HxqOkY2f3omiIP9lbga4f0X
D5RcmILzHg7zuaHnKJvxc9UlmYvvR30Ch2LzCKRFelU2TM1mZzy9TZWQzhT6muJD
B2CYuSYctcl0RGpG4vMHXlMoUFXEisnzuNNxRJU8laqbd3j8LGrppoddfBvq1SVU
8A063KezW1wvPpyCx+fRWKhubEvWtwAYSDOcaKtZI4hcHSEi+MAubfEr72PVLh9p
Y/O5HARWBMrgha+PVS42IvYC0RwGRw==
=l2SM
-----END PGP SIGNATURE-----

--j2hqheguodcnpfxl--
