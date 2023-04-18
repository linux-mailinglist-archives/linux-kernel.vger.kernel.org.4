Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A6A6E67E3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjDRPS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDRPS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:18:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE4E83C3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:18:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pon61-0006Ax-VV; Tue, 18 Apr 2023 17:18:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pon5z-00C8YW-SZ; Tue, 18 Apr 2023 17:18:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pon5y-00EGkp-PW; Tue, 18 Apr 2023 17:18:14 +0200
Date:   Tue, 18 Apr 2023 17:18:14 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v16 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20230418151814.xawtejnsoguelrwq@pengutronix.de>
References: <20230411-wizard-cautious-3c048db6b4d2@wendy>
 <20230411-bronzing-crust-d302408a1259@wendy>
 <20230411105547.ypkktubgfx4jfen3@pengutronix.de>
 <20230411-ligament-wagon-6c8cacb966e8@wendy>
 <20230411162554.4tl2z2tcbfg5hb7e@pengutronix.de>
 <20230418-armhole-cartwheel-cee37778a840@wendy>
 <20230418130837.zfueixeuxrallhtc@pengutronix.de>
 <20230418-octagon-epilepsy-4d8516f91145@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eqzeemqexvwxupmj"
Content-Disposition: inline
In-Reply-To: <20230418-octagon-epilepsy-4d8516f91145@wendy>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eqzeemqexvwxupmj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Conor,

On Tue, Apr 18, 2023 at 02:27:09PM +0100, Conor Dooley wrote:
> On Tue, Apr 18, 2023 at 03:08:37PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Apr 18, 2023 at 12:27:33PM +0100, Conor Dooley wrote:
> > > I'm quite obviously missing something that you may think is obvious
> > > here, but is not immediately clear to me.
> >=20
> > That would be an explanation, yes. :-)
>=20
> Right, it makes a lot more sense now. Definitely was not clear to me
> that that was what you were suggesting.

I reread what I wrote and maybe I wouldn't have understood it either :-)

> I'm not sure that disallowing tmp < 255 is something I want to do
> though, as this is mainly used as a "soft" IP core in the FPGA fabric,
> the clock provided to it may not be particularly high.
> Probably not the end of the world though, once added to the limitations.
>=20
> The implemented period is also going to be quite a ways off with this
> method (compared to the method I have been using until now) - although
> it is of course far simpler.

"simpler" is in my eyes a good approach until someone comes who has
stronger needs than can be done with a simple approach. Until this
happens a simple approach is good for everyone.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--eqzeemqexvwxupmj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQ+tLUACgkQj4D7WH0S
/k63jAgAk7+euErd/rScGYReNxFE09ohTUb0Enh+ADA//kK8jamTQNA7NL2yyIbr
eb2DkTerLJuu+v0Vn6k6QdDRCNqSonxldm3rXpkZ1+9ybODgByztA34nr/aS5VHA
yNqwvDPh0aa0cr/2PKfJ7WpnT6UcplUw8zifqRLDUpwyprlc2Q94bYDb7MfZza0J
H2OHNKmx3ZN/bZSgmG6liYnl07tnv9ZVJ+KE1C1LwNpx1Ds9uFx0PpWYamPCFviP
iGcMLTu815AeXTN+jIKU+v8kx5Da0IpImDwBltP0rEKLIReJNIZpDvPGBQzqqvuE
eGK2DXGsDAN0PQcFNAr4NZVcMJP8Kg==
=5Bvy
-----END PGP SIGNATURE-----

--eqzeemqexvwxupmj--
