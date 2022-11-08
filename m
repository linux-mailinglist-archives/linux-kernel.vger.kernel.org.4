Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A840620F70
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbiKHLsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbiKHLsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:48:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2985E7677
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:48:35 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1osN5c-0004G3-TY; Tue, 08 Nov 2022 12:48:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1osN5a-0032nL-Gu; Tue, 08 Nov 2022 12:48:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1osN5a-00FAkq-8O; Tue, 08 Nov 2022 12:48:22 +0100
Date:   Tue, 8 Nov 2022 12:48:22 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: Re: [PATCH v6 00/10] Designware PWM driver updates for OF
Message-ID: <20221108114822.7aktlzgbz7xziudb@pengutronix.de>
References: <20221020151610.59443-1-ben.dooks@sifive.com>
 <623284c8-f4bb-1020-2f2e-a475f424c5b5@linux.intel.com>
 <bcd96d79-71b2-9d6a-6397-a47162e52acc@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uk7th4v7jksyqa5r"
Content-Disposition: inline
In-Reply-To: <bcd96d79-71b2-9d6a-6397-a47162e52acc@sifive.com>
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


--uk7th4v7jksyqa5r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 08, 2022 at 11:19:44AM +0000, Ben Dooks wrote:
> On 24/10/2022 09:39, Jarkko Nikula wrote:
> > Hi
> >=20
> > On 10/20/22 18:16, Ben Dooks wrote:
> > > This is an updated version of the Designware PWM driver updates
> > > for OF support, which now splits the driver into PCI and OF parts
> > > as well as tries to sort out the review comments.
> > >=20
> > > Hopefully this can now be queued for the next kernel version.
> > >=20
> > > v6:
> > > =A0 - fix removal ordering of DWC_PERIOD_NS
> >=20
> > I did a quick test on our HW and PWM was counting as before.
> >=20
> > Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>=20
> Just to follow up on this, should I post a v7 of this (given
> I think it is all just updates for review/tested) ?

Just to add the tags doesn't justify a resend.

Reviewing this is in my todo list, I hope to come to it later this week.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uk7th4v7jksyqa5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNqQgMACgkQwfwUeK3K
7AkETQf/RblT34D1zc1x6a69+2ynE5hvgoKtdk6F0NfPyZwUe4GP67DEtg6NMvOw
mhpqrVNR8LlxZ1RT55YruAJMGDaoCYaw6syw3KOyVU0d9vlDh8wJ7IUsBUADtxzY
uGhPmqoa2DdghZZj1Pk4fwr9KL52pB0bh8ciUK+899e53nb632fIk0daicYtXrWO
HiatrZIlxfr/7x5W7IzqnssTOTHP89RigbDfOoG4bYG5yN/++IxzhCYAfUmJ4n4J
T0BZhL7Qul3YDzdc58pKQ0YxAWeQwjt3IWeluTT+UZdTEflwhOzHCinRiZ5IZYpm
DU6DBQT/01s8L0lQuqcUUAGIPTV1lw==
=5KdU
-----END PGP SIGNATURE-----

--uk7th4v7jksyqa5r--
