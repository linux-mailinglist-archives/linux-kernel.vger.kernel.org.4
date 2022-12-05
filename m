Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D1A642FA3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiLESOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiLESOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:14:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5402CC30
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 10:14:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p2FyS-0002ph-5Y; Mon, 05 Dec 2022 19:13:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p2FyO-002Wur-Ea; Mon, 05 Dec 2022 19:13:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p2FyO-002qP9-DL; Mon, 05 Dec 2022 19:13:48 +0100
Date:   Mon, 5 Dec 2022 19:13:48 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v12 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20221205181348.3bvugpjr7xgf6uk5@pengutronix.de>
References: <20221117164950.cssukd63fywzuwua@pengutronix.de>
 <Y3Zxkt3OSPQc46Q2@spud>
 <20221117210433.n5j7upqqksld42mu@pengutronix.de>
 <Y3avobkvYK3ydKTS@spud>
 <Y3uZY5mt/ZIWk3sS@wendy>
 <Y4coL74qQX80TNaT@wendy>
 <20221130103755.lhil2jaw3oufr2sf@pengutronix.de>
 <Y44Mk2nGu1Zeq7QQ@wendy>
 <20221205160328.wn4rcs6uxuuaxftd@pengutronix.de>
 <Y44mxp9Wr/aEdaxE@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kjxhhs4q4yv2cfmm"
Content-Disposition: inline
In-Reply-To: <Y44mxp9Wr/aEdaxE@spud>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kjxhhs4q4yv2cfmm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Conor,

On Mon, Dec 05, 2022 at 05:13:42PM +0000, Conor Dooley wrote:
> Figured I was better off doing something quickly & asking rather than
> polishing only to find out it was disliked ;)

:-)

> >  - in .apply() check the current time, add the current period and store
> >    the result to ddata->updatetimestamp
> >  - in .get_state do:
> >      if (current_time >=3D ddata->updatetimestamp)
> >        process fine
> >      else:
> >        timeout (or wait until ddata->updatetimestamp?)
> >=20
> > Actually I'd prefer to wait instead of -ETIMEOUT.
>=20
> Prefer to wait in get_state() or in both it & apply()?

Prefer to wait where it's necessary ...

> Depending on how far away updatetimestamp is, would we still not want to
> time out if it is going to be a long time, no?

I'd prefer a slow but right value over a quick error.

The sun4i driver has in its .apply():

        /* We need a full period to elapse before disabling the channel. */
        delay_us =3D DIV_ROUND_UP_ULL(cstate.period, NSEC_PER_USEC);
        if ((delay_us / 500) > MAX_UDELAY_MS)
                msleep(delay_us / 1000 + 1);
        else
                usleep_range(delay_us, delay_us * 2);

so it's at least not new in general to have a waiting time in O(period).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kjxhhs4q4yv2cfmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOONNkACgkQwfwUeK3K
7AmE2wgAk2sWVpLdReSy1pSzeYCZ6ioUVHCTzslq0tljPK15BnT/FAMYPMhSozRS
I6ZEmm3iRyJ4TiOgFbUVYIpNIe4UUvrAA8kfQ5zViM3mKKL9zXdpRXaG+cQPwl+p
RM8KE2Yzd9wJWFCwx951zMBGxCfIqj2I06vCnBbi2rbBUzZbMy5dzFiyw/IKaMiv
u8ylSqijubQSOQQ7gsZbp2MqpZO2ZH1IAdFyCslAeIoIUo6I9UnGLJS0fYG6fmLX
2iMjTiml+SfLnob6YfDQiwTLv+WOOVPhDwmx0f/FCeugOftF5jyJyVIy+TJ9EB9m
/c9nw3rglCUesb6zI6guMd7nlr5ZqQ==
=OBsk
-----END PGP SIGNATURE-----

--kjxhhs4q4yv2cfmm--
