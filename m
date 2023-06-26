Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7D273DEBC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjFZMS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjFZMSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:18:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8419E10C6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:18:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qDlAT-0007Pu-Az; Mon, 26 Jun 2023 14:18:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qDlAR-00ACvO-Lt; Mon, 26 Jun 2023 14:18:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qDlAQ-00HY4i-Ry; Mon, 26 Jun 2023 14:18:02 +0200
Date:   Mon, 26 Jun 2023 14:18:02 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Sahin, Okan" <Okan.Sahin@analog.com>
Cc:     Julien Panis <jpanis@baylibre.com>, Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH] mfd: Switch two more drivers back to use struct
 i2c_driver::probe
Message-ID: <20230626121802.qlvoiytzurrvd22z@pengutronix.de>
References: <20230626091941.557733-1-u.kleine-koenig@pengutronix.de>
 <MN2PR03MB516846A1A4FD31515D98FA4BE726A@MN2PR03MB5168.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h24k2dwwo42ljdm2"
Content-Disposition: inline
In-Reply-To: <MN2PR03MB516846A1A4FD31515D98FA4BE726A@MN2PR03MB5168.namprd03.prod.outlook.com>
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


--h24k2dwwo42ljdm2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2023 at 12:01:16PM +0000, Sahin, Okan wrote:
> >Sent: Monday, June 26, 2023 12:20 PM
> >To: Julien Panis <jpanis@baylibre.com>; Sahin, Okan <Okan.Sahin@analog.c=
om>; Lee
> >Jones <lee@kernel.org>
> >Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; linux-
> >kernel@vger.kernel.org; kernel@pengutronix.de
> >Subject: [PATCH] mfd: Switch two more drivers back to use struct i2c_dri=
ver::probe
> >
> >[External]
> >
> >struct i2c_driver::probe_new is about to go away. Switch the driver to
> >use the probe callback with the same prototype.
> >
> >Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >---
> > drivers/mfd/max77541.c    | 2 +-
> > drivers/mfd/tps6594-i2c.c | 2 +-
> > 2 files changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/mfd/max77541.c b/drivers/mfd/max77541.c
> >index 4a3bad3493b3..e147e949c2b3 100644
> >--- a/drivers/mfd/max77541.c
> >+++ b/drivers/mfd/max77541.c
> >@@ -214,7 +214,7 @@ static struct i2c_driver max77541_driver =3D {
> > 		.name =3D "max77541",
> > 		.of_match_table =3D max77541_of_id,
> > 	},
> >-	.probe_new =3D max77541_probe,
> >+	.probe =3D max77541_probe,
> > 	.id_table =3D max77541_id,
> > };
> > module_i2c_driver(max77541_driver);
> >diff --git a/drivers/mfd/tps6594-i2c.c b/drivers/mfd/tps6594-i2c.c
> >index 50a3cd03b3b0..899c88c0fe77 100644
> >--- a/drivers/mfd/tps6594-i2c.c
> >+++ b/drivers/mfd/tps6594-i2c.c
> >@@ -235,7 +235,7 @@ static struct i2c_driver tps6594_i2c_driver =3D {
> > 		.name =3D "tps6594",
> > 		.of_match_table =3D tps6594_i2c_of_match_table,
> > 	},
> >-	.probe_new =3D tps6594_i2c_probe,
> >+	.probe =3D tps6594_i2c_probe,
> > };
> > module_i2c_driver(tps6594_i2c_driver);
> >
> >
> >base-commit: e0cbc202388af454eb771043b20db6dfe68199ec
> >--
> >2.39.2
>=20
> Should I update the code then resend patch again? Or should I send anothe=
r patch after merge is completed?

I'm not Lee, but I'll try an answer anyhow: Your patch is in next (via
Lee's tree) as commit e0cbc202388af454eb771043b20db6dfe68199ec. So I
guess Lee will keep the patch as is and send it to Linus. There is
nothing grave wrong, so no need to revert or rewrite the tree. I expect
Lee to just apply my patch on top of his tree.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--h24k2dwwo42ljdm2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSZgfkACgkQj4D7WH0S
/k4mPAf+MO4zy+XZ/oZnFPS9xxEvsMPBm5uEti29PF/k2eKmAeODtNZY9Gzz9lO1
5DLpfaQ8xtrLipBF6nOx6K6n6LcPvJ0YC7Sg85GmlknqUcw6YsKxS7WFECEFIKGv
SrXizYxJ+d6LVPBC7JGw3uSFSHJzzPZlZcz/MyJz8qAtPEv+7Fvi7kzNOKopOkgT
vPoyQ3xt2Ek87GMZVMGbJZ33ai2GYRKdXzhiIItWr8TnuzikUS5gw4POV+HwPykE
+SccGbxtMz4OyMhrIab4H/wZoYE6+kX6vm6XFQMovzhzb/b5rgvNL9PouH7hvgyP
tsCV6YsF6EuDjIWy0FDP6UDFfN5cnw==
=3eSK
-----END PGP SIGNATURE-----

--h24k2dwwo42ljdm2--
