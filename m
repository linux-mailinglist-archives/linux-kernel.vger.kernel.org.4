Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9A670EF31
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239480AbjEXHQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239768AbjEXHQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:16:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ABBB6
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:15:49 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1q1iin-0008Vs-V2; Wed, 24 May 2023 09:15:46 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id CF1751CAECB;
        Wed, 24 May 2023 07:15:44 +0000 (UTC)
Date:   Wed, 24 May 2023 09:15:44 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Frank Jungclaus <frank.jungclaus@esd.eu>
Cc:     linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] can: esd_usb: More preparation before supporting esd
 CAN-USB/3 (addendum)
Message-ID: <20230524-brownnose-spinster-6f4a9d600b21-mkl@pengutronix.de>
References: <20230523173105.3175086-1-frank.jungclaus@esd.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zezrvyawup3qxqy4"
Content-Disposition: inline
In-Reply-To: <20230523173105.3175086-1-frank.jungclaus@esd.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zezrvyawup3qxqy4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23.05.2023 19:31:03, Frank Jungclaus wrote:
> While trying to again merge my code changes for CAN-USB/3, I came
> across some more places where it could make sense to change them
> analogous to the previous clean-up patch series [1].
>=20
> [1] [PATCH v2 0/6] can: esd_usb: More preparation before supporting esd C=
AN-USB/3
> Link: https://lore.kernel.org/all/20230519195600.420644-1-frank.jungclaus=
@esd.eu/

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zezrvyawup3qxqy4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRtuZ0ACgkQvlAcSiqK
BOiaDAgAk8zZ0dPy7U85VzvgRKUxB9JKLi/zjcsbhjpgfZTB84AmOPgiOLNU1z2r
G1C5FoTH4SKl6v1gICkNMp+6X67g3V+hnP6inrpRMs1Z5Ki2p/MWy3g8GTWMkMOZ
0qU0dc0TwGqQ++/AAl+zKSa9MkBieo7dsGWdqYW4CDPgeaElDNliLE12/D3G3YZR
sSpRdHgpLmowBPSI7x/FtowfRkGp0CctwrYywVERR+jmfacSH/sKwK+nX525zk+Z
i6GnvF+yabuXJtpR3ztzmPe1K5CVjH7mXTqLEWam1WOMN7aJm588b8+7AMD8c4Yh
I1WFL110Kjp1DXEAt/7/i2jX2LzidQ==
=wh88
-----END PGP SIGNATURE-----

--zezrvyawup3qxqy4--
