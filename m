Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3851B5F5033
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 09:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJEHMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 03:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJEHMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 03:12:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09A41DA62
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 00:12:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ofyZx-0000sn-8Q; Wed, 05 Oct 2022 09:12:29 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ofyZw-004iI1-Ny; Wed, 05 Oct 2022 09:12:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ofyZu-005hvF-AQ; Wed, 05 Oct 2022 09:12:26 +0200
Date:   Wed, 5 Oct 2022 09:12:26 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wolfram Sang <wsa@kernel.org>, broonie@kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: linux-next: manual merge of the pm tree with the i2c tree
Message-ID: <20221005071226.4ounaaq42frkdpa3@pengutronix.de>
References: <20220929121853.100271-1-broonie@kernel.org>
 <20221005111836.1d43b228@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d7wx7pxlkn2m3xij"
Content-Disposition: inline
In-Reply-To: <20221005111836.1d43b228@canb.auug.org.au>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d7wx7pxlkn2m3xij
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 05, 2022 at 11:18:36AM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> On Thu, 29 Sep 2022 13:18:53 +0100 broonie@kernel.org wrote:
> >
> > Today's linux-next merge of the pm tree got a conflict in:
> >=20
> >   drivers/platform/x86/intel/int3472/tps68470.c
> >=20
> > between commit:
> >=20
> >   ed5c2f5fd10dd ("i2c: Make remove callback return void")
> >=20
> > from the i2c tree and commit:
> >=20
> >   06a659d1f0a0a ("platform/x86: int3472: Support multiple gpio lookups =
in board data")
> >=20
> > from the pm tree.
> >=20
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> >=20
> > diff --cc drivers/platform/x86/intel/int3472/tps68470.c
> > index 5dd81bb05255b,49fc379fe680a..0000000000000
> > --- a/drivers/platform/x86/intel/int3472/tps68470.c
> > +++ b/drivers/platform/x86/intel/int3472/tps68470.c
> > @@@ -178,13 -227,18 +227,16 @@@ static int skl_int3472_tps68470_probe(s
> >   	return ret;
> >   }
> >  =20
> >  -static int skl_int3472_tps68470_remove(struct i2c_client *client)
> >  +static void skl_int3472_tps68470_remove(struct i2c_client *client)
> >   {
> >   	const struct int3472_tps68470_board_data *board_data;
> > + 	int i;
> >  =20
> >   	board_data =3D int3472_tps68470_get_board_data(dev_name(&client->dev=
));
> > - 	if (board_data)
> > - 		gpiod_remove_lookup_table(board_data->tps68470_gpio_lookup_table);
> > + 	if (board_data) {
> > + 		for (i =3D 0; i < board_data->n_gpiod_lookups; i++)
> > + 			gpiod_remove_lookup_table(board_data->tps68470_gpio_lookup_tables[=
i]);
> > + 	}
> >  -
> >  -	return 0;
> >   }
> >  =20
> >   static const struct acpi_device_id int3472_device_id[] =3D {
>=20
> This is now a conflict between the i2c tree and Linus' tree.

In the meantime the i2c tree is pulled, too and Linus solved the
conflict in the same way in b86406d42ae3c41ae0ce332ea24350829b88af51.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--d7wx7pxlkn2m3xij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmM9LlcACgkQwfwUeK3K
7Ak8Jwf+N6Hjj989m4OAPECZi9fVsUL6Wrs+3sKLCMCOfMZ7iWwhrd959ho5Hi/g
p9VdOoYhtdE6FYiXo1XktMWUoCP063Mc6tyCQFH5F6nPNt6OXeehDhlUaqitEbwK
IvVaLYcm6Tuv6UuGZcNBYMGeECwbWVdGyfNWg1X8BWbYzlSdvatY8TC4EP+aOkDQ
Xx/CiyWr3UCfdL57zMgA0qmzwR5Aoq/mV+Nf1V/499QErVYn+WTmfyvHGtCkEYZO
muO2gsDyFm679HGwyha0Q4oQUS3rSmYoPmP20X0ftvXynoeIn4Ebi8yMrGE4gCK+
yuurpS9Tk9X2TIUh+gKbkXXKXI5A2A==
=izQm
-----END PGP SIGNATURE-----

--d7wx7pxlkn2m3xij--
