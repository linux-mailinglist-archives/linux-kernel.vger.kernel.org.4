Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D62A70ED9A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239630AbjEXGHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239623AbjEXGHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:07:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7735713E
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:07:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1heI-0008Qp-TJ; Wed, 24 May 2023 08:07:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1heH-002QIl-HW; Wed, 24 May 2023 08:07:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1heG-007SLT-IB; Wed, 24 May 2023 08:07:00 +0200
Date:   Wed, 24 May 2023 08:07:00 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Peter Rosin <peda@axentia.se>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-pwm@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: PWM regression causing failures with the pwm-atmel driver
Message-ID: <20230524060700.ryvnijygnitogesx@pengutronix.de>
References: <a2ed99b3-ee2a-6393-de98-3305c57dacc4@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oxlupnh4pauvhwhq"
Content-Disposition: inline
In-Reply-To: <a2ed99b3-ee2a-6393-de98-3305c57dacc4@axentia.se>
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


--oxlupnh4pauvhwhq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2023 at 10:42:34PM +0200, Peter Rosin wrote:
> 2023-05-23 at 01:34, Peter Rosin wrote:
> > So, I took a step back and can only conclude that there must be some
> > another regression to find, and I was confused by that other regression.
> > In short, I was on 6.1.<foo> and everything was fine, and then I bumped
> > to 6.3 and a process crashed. I went to 6.2 and that same process also
> > crashed. I then totally focused on v6.1..v6.2 to figure out the problem.
> > I simply assumed v6.3 had the same problem because the symptom from
> > 30.000ft was the same (that process died). I failed to go back to v6.3
> > to confirm that it was indeed the same problem as I had found in the
> > v6.1..v6.2 range.
> >=20
> > My bad, it seems I have another day of bisections lined up.
>=20
> For closure, I ended up with this:
> https://lore.kernel.org/lkml/221d19e2-6b92-7f38-7d8a-a730f54c33ea@axentia=
=2Ese/
>=20
> I.e. another v6.1..v6.2 regression that caused sound failures.
> The two problems looked very similar to the suffering application.
>=20
> Anyway, sorry again for the noise.

OK. After your first mail I had the impression there is another PWM
releated problem to be reported, but it seems this isn't the case.

Just to have that explicit: Did I understand you right?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--oxlupnh4pauvhwhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRtqYMACgkQj4D7WH0S
/k7fEAf/QD0gr/JbtP1v3i8kSntZM0anRhQ6wf9aFVPfg5/B1hdw6a8s/TKnd1eT
XDkIRXadpX+YtwRuDv2DDVlRsD6sUXeG3RjLKxvRrl9OLdPMgITZgDxPryov8knl
7zX6shTndE2/lvp8hDPJwsagfUabVX3LnvFemxUGrdwLBrOMCy4w6ZU488Q/XFP6
mBAeX/mNo5ZDpz/kgLEGe6xO+fvQozFhJ0tqeDQEA6Uc1VL2vTBzX2tyXS54X4Qn
1ovufE/egRL7cGQjOrhySL6Fp7OAMw2rhwwgVRLdkimWvnOLvyPvm/roz96ZBm+v
5Eb0Uux5ITrpDSDD7gr1G1Qj1mtQHw==
=yHAY
-----END PGP SIGNATURE-----

--oxlupnh4pauvhwhq--
