Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42B66C3736
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjCUQnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjCUQnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:43:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EFA52F55
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 09:43:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pef4e-0003Cx-Tg; Tue, 21 Mar 2023 17:43:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pef4e-005jSE-25; Tue, 21 Mar 2023 17:43:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pef4d-006oRj-BW; Tue, 21 Mar 2023 17:42:59 +0100
Date:   Tue, 21 Mar 2023 17:42:59 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, vireshk@kernel.org,
        thierry.reding@gmail.com, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-pwm@vger.kernel.org, Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH 2/3] staging: greybus: use inline function for macros
Message-ID: <20230321164259.nt6varbc6v6bavrz@pengutronix.de>
References: <cover.1679352669.git.eng.mennamahmoud.mm@gmail.com>
 <1274302b52ae905dab6f75377d625598facbbdf1.1679352669.git.eng.mennamahmoud.mm@gmail.com>
 <20230321154728.3r7ut3rl2pccmo2e@pengutronix.de>
 <7c883bac-382c-b429-ab21-4675dce02474@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ycczzpqu7aadwq6j"
Content-Disposition: inline
In-Reply-To: <7c883bac-382c-b429-ab21-4675dce02474@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ycczzpqu7aadwq6j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2023 at 06:25:29PM +0200, Menna Mahmoud wrote:
>=20
> On =D9=A2=D9=A1=E2=80=8F/=D9=A3=E2=80=8F/=D9=A2=D9=A0=D9=A2=D9=A3 =D9=A1=
=D9=A7:=D9=A4=D9=A7, Uwe Kleine-K=C3=B6nig wrote:
> > Hello,
> >=20
> > just some nitpicks:
> >=20
> > On Tue, Mar 21, 2023 at 01:04:33AM +0200, Menna Mahmoud wrote:
> > > Convert `to_gbphy_dev` and `to_gbphy_driver` macros into a
> > > static inline function.
> > >=20
> > > it is not great to have macro that use `container_of` macro,
> > s/it/It/; s/macro/macros/; s/use/use the/;
> Okay, I will fix it.
> >=20
> > > because from looking at the definition one cannot tell what type
> > > it applies to.
> > > [...]
> > > -#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
> > > +static inline struct gbphy_device *to_gbphy_dev(const struct device =
*d)
> > drivers/staging/greybus/gbphy.c always passes a variable named
> > "dev" to this macro. So I'd call the parameter "dev", too, instead of
> > "d". This is also a more typical name for variables of that type.
> >=20
> > > +{
> > > +	return container_of(d, struct gbphy_device, dev);
> > > +}
> > > [...]
> > >   };
> > > -#define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driv=
er)
> > > +static inline struct gbphy_driver *to_gbphy_driver(struct device_dri=
ver *d)
> > > +{
> > > +	return container_of(d, struct gbphy_driver, driver);
> > > +}
> > With a similar reasoning (and also to not have "d"s that are either
> > device or device_driver) I'd recommend "drv" here.
>=20
>=20
> please check this with Julia, because she said they should different.

At least use "_dev" instead of "d" which seems to be a common idiom,
too:

	$ git grep -P 'container_of\(_(?<ident>[A-Za-z_0-9-]*)\s*,[^,]*,\s*\g{iden=
t}\s*\)' | wc -l
	570

("drv" should be fine, because the third argument is "driver" there.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ycczzpqu7aadwq6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQZ3pIACgkQj4D7WH0S
/k5pUQf/XJUDV6EvqcrGxi++Gu/Dk83CxxiHdJnuv3linIJyLi93tZYagEMj773b
zxh1hIg8sW9OY0D/5HIkMjjhziTA432DNiFWW85/B+eOduuRE2fQHZ8kHOMiXH+R
P2k2cPlJLW9pV3n6odYFqmn0BGoQvgOAgDUfftIgZ6Wfc6bEX7cl7rOAXaPxrz+s
b0hgLYCkQJ5x19/n6JmO6eQq3IvCZyye8y2NgU28gHQ7tCDy3M4cy4o6rM+45GOP
QnptwPU1+WnnmOfztzLTGFZwVnQs/t0rKMn7yC6cu0WdbPtILq8ug+ZE5Rx4cRv5
VmFAwNr1gpOVs8Yix3vuHqXFhvTk6Q==
=iXWj
-----END PGP SIGNATURE-----

--ycczzpqu7aadwq6j--
