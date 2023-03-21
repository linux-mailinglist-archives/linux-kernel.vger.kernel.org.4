Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EBD6C36E7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCUQ0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCUQ0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:26:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98AB33471
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 09:26:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1peeoh-0001Tm-NK; Tue, 21 Mar 2023 17:26:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1peeog-005jOR-PC; Tue, 21 Mar 2023 17:26:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1peeof-006oMY-H4; Tue, 21 Mar 2023 17:26:29 +0100
Date:   Tue, 21 Mar 2023 17:26:29 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, vireshk@kernel.org,
        thierry.reding@gmail.com, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: greybus: use inline function for macros
Message-ID: <20230321162629.rjmivzhbdy4pcgii@pengutronix.de>
References: <cover.1679352669.git.eng.mennamahmoud.mm@gmail.com>
 <1274302b52ae905dab6f75377d625598facbbdf1.1679352669.git.eng.mennamahmoud.mm@gmail.com>
 <20230321154728.3r7ut3rl2pccmo2e@pengutronix.de>
 <82a4e5f1-a1f2-c70-3645-9464ccb17bab@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d5lucct4g3gdijlv"
Content-Disposition: inline
In-Reply-To: <82a4e5f1-a1f2-c70-3645-9464ccb17bab@inria.fr>
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


--d5lucct4g3gdijlv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2023 at 04:59:49PM +0100, Julia Lawall wrote:
>=20
>=20
> On Tue, 21 Mar 2023, Uwe Kleine-K=F6nig wrote:
>=20
> > Hello,
> >
> > just some nitpicks:
> >
> > On Tue, Mar 21, 2023 at 01:04:33AM +0200, Menna Mahmoud wrote:
> > > Convert `to_gbphy_dev` and `to_gbphy_driver` macros into a
> > > static inline function.
> > >
> > > it is not great to have macro that use `container_of` macro,
> >
> > s/it/It/; s/macro/macros/; s/use/use the/;
> >
> > > because from looking at the definition one cannot tell what type
> > > it applies to.
> > > [...]
> > > -#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
> > > +static inline struct gbphy_device *to_gbphy_dev(const struct device =
*d)
> >
> > drivers/staging/greybus/gbphy.c always passes a variable named
> > "dev" to this macro. So I'd call the parameter "dev", too, instead of
> > "d". This is also a more typical name for variables of that type.
>=20
> I argued against that.  Because then there are two uses of dev
> in the argument of container_of, and they refer to completely different
> things.  It's true that by the way container_of works, it's fine, but it
> may be misleading.

Hmm, that seems to be subjective, but I have less problems with that
than with using "d" for a struct device (or a struct device_driver).
I'd even go so far as to consider it nice if they are identical.

Maybe that's because having the first and third argument identical is
quite common:

	$ git grep -P 'container_of\((?<ident>[A-Za-z_0-9-]*)\s*,[^,]*,\s*\g{ident=
}\s*\)' | wc -l
	5940

which is >44% of all the usages

	$ git grep -P 'container_of\((?<ident>[A-Za-z_0-9-]*)\s*,[^,]*,\s*(?&ident=
)\s*\)' | wc -l
	13362

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--d5lucct4g3gdijlv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQZ2rQACgkQj4D7WH0S
/k5Wjwf9GmB1nEoIhAtbkSezDUMGtnRIA0mIAQmDVWMFAWrWo0IhdD4gZoKb2hCr
cEG/usN3hNJoAnAHWzqmj20sOmxunSQjZzQKu1bxVf15CWKctvGeuX5aV41O8dTf
oJjy7kz1tYX431ygPRw0ntOmU+M5r4C8qoABawI7WPKZF0BEDq74a1R7FHd4zU9t
apiR76rkekQ2ZCMoOrilxTwCvJxjPcDNiKRugqOVWTKw324hhH+CnOqJIVF7fJ/8
v3F8hUC8WDFEYxjBlXk+YIINGFArv4hJpZOQsJcenURyv/s0WEzAsf0h+W/WFvOA
zD6QBpes1fBCwoRoC7uQ5vkI2aDHJg==
=Wojb
-----END PGP SIGNATURE-----

--d5lucct4g3gdijlv--
