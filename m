Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5317E712721
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243519AbjEZNAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjEZNAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:00:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8EB114
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:00:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2X34-0000m4-2T; Fri, 26 May 2023 15:00:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2X32-002xVz-Mu; Fri, 26 May 2023 15:00:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2X31-0089wv-MR; Fri, 26 May 2023 14:59:59 +0200
Date:   Fri, 26 May 2023 14:59:59 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] auxdisplay: Switch i2c drivers back to use .probe()
Message-ID: <20230526125959.jksnrsvtokqkdcqs@pengutronix.de>
References: <20230525205840.734432-1-u.kleine-koenig@pengutronix.de>
 <CANiq72=qi4yXH+24zFHFatBdUHy_ekNrFoYnpZL0fSMa76kpug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vbzhlfakrt7l2rio"
Content-Disposition: inline
In-Reply-To: <CANiq72=qi4yXH+24zFHFatBdUHy_ekNrFoYnpZL0fSMa76kpug@mail.gmail.com>
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


--vbzhlfakrt7l2rio
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello Miguel,

On Fri, May 26, 2023 at 12:39:55PM +0200, Miguel Ojeda wrote:
> On Thu, May 25, 2023 at 10:58=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> > call-back type"), all drivers being converted to .probe_new() and then
> > 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")
> > convert back to (the new) .probe() to be able to eventually drop
> > .probe_new() from struct i2c_driver.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> Thanks for this! The conversion has taken a while given the date of
> the first commit :)
>=20
> The wording of the message was a bit confusing, perhaps a ";
> finally/now" before "convert" would have helped, but no big deal.
>=20
> If somebody is taking all the patches treewide, then:
>=20
>     Acked-by: Miguel Ojeda <ojeda@kernel.org>
>=20
> Otherwise, I will queue it.

The overall idea was to make the changes in a way to require no
coordination between maintainers. So adding this change to your tree
would be great.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vbzhlfakrt7l2rio
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRwrU4ACgkQj4D7WH0S
/k7BKwf9F7yM9uTPWznmuh8NLBo8KZ59+SUqC4iOI0eBaOSCwIHO4rJh6W+MXinM
yx6kp+g1U2TTDXYbRFIdSdOJko8F5EOIKbB6PGpgYOAHFbE/7jbNcsUbwBUkZ50k
0BWVmP3nV5AHQ/8z7Ep737ti8O0euWKZuKUvW50UNDNZkf5wZ5ivGc5ijXA302cc
zb7TDzo1DoX/BPZDtw+A98nTMKPTbGggqgoZLFXy6nhQpakhomAyjHW5sl5p8rjU
nW2KnZROMeqsPOluc3yxl4rvkcUfC+V/PG01WEwFrPOqXHE+hLGVGZD5KorNhvsj
GGB2TKDJlznQyE15IBBSjo+3fenhPA==
=EC5I
-----END PGP SIGNATURE-----

--vbzhlfakrt7l2rio--
