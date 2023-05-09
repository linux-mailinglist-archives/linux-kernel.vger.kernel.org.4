Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A19F6FC619
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbjEIMTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbjEIMTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:19:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEBD423E
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 05:19:14 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pwMJC-00041Y-PX; Tue, 09 May 2023 14:19:10 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 10D761C0DCB;
        Tue,  9 May 2023 12:19:10 +0000 (UTC)
Date:   Tue, 9 May 2023 14:19:09 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Frank Jungclaus <Frank.Jungclaus@esd.eu>,
        Stefan =?utf-8?B?TcOkdGpl?= <Stefan.Maetje@esd.eu>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] can: esd_usb: Add support for esd CAN-USB/3
Message-ID: <20230509-superglue-hazy-38108aa66bfa-mkl@pengutronix.de>
References: <20230504154414.1864615-1-frank.jungclaus@esd.eu>
 <20230504154414.1864615-3-frank.jungclaus@esd.eu>
 <CAMZ6RqKgJs-yJaaqREmN1SkUzE1EkGtjBzXiATKx5WL+=J48dQ@mail.gmail.com>
 <ff1374d58d98a42d5f78a2685c748730b26926b9.camel@esd.eu>
 <CAMZ6RqLaDNy-fZ2G0+QMhUEckkXLL+ZyELVSDFmqpd++aBzZQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uhh5qae7tgsvriw6"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqLaDNy-fZ2G0+QMhUEckkXLL+ZyELVSDFmqpd++aBzZQg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
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


--uhh5qae7tgsvriw6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.05.2023 10:28:13, Vincent MAILHOL wrote:
> > >   ip --details link show canX
> > Yes, I know. But my intention was to exactly and directly see the
> > individual values passed to the USB set baudrate command without using
> > wireshark to sniff the USB, if anybody complains about problems with
> > the bitrate.
>=20
> That's my point, this is meant for troubleshooting, not for normal
> use. The calculation is not rocket science. If a user has an issue
> with the bitrate, the values provided by the ip tool are enough for
> you to recalculate the actual values passed to the device. You should
> not spam the user just to save you the time to do this calculation.
>=20
> > This netdev_info is similar to the "netdev_info(netdev,
> > "setting BTR=3D%#x\n", canbtr);" for CAN-USB/2.
>=20
> This one should also be removed.
>=20
> > So from my point of view this is an informational message too, and not
> > a debug message.
>=20
> NACK.

Please make it a debug message.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--uhh5qae7tgsvriw6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRaOjkACgkQvlAcSiqK
BOgycAgApYRXbll9dl2qMGc9KGKNISRW3MWQgapvVbKwNehDcKcXvE/Igkqp1Deu
HmuShJFWm1umBSopEnzpf5ybHMIRckpcF8gOS6trB/PYZvvTlShDA6FYyApvv+4n
kD0iwRL6obTAVA2CmTxMBnYICNHohsopKeDQxesBtsQ+s+tNDeP4sZx7xyWO/qiI
UdJuJBS3YHZOcFvxnPrmAh6gBELj8+i/yHg4QIhG4vPVmm2QqeIBlYgPaJqBNCc8
89Fd/xCrsLNH0vq2j2mAAjhmNx4/P41ObdyNbaP/owbwU7KrdvRlzRBD6gsY8UzQ
5SG9vDEKU6mz9iWo67JgGWt0KVym/Q==
=pdSt
-----END PGP SIGNATURE-----

--uhh5qae7tgsvriw6--
