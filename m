Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B875B58AF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiILKrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiILKq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:46:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2BA3134E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:46:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oXgxc-0008D1-QD; Mon, 12 Sep 2022 12:46:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oXgxW-000HXz-Og; Mon, 12 Sep 2022 12:46:33 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oXgxU-000MJM-Il; Mon, 12 Sep 2022 12:46:32 +0200
Date:   Mon, 12 Sep 2022 12:46:31 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Denys Zagorui <dzagorui@cisco.com>, Meng.Li@windriver.com,
        lars@metafoo.de, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: ltc2497: Fix reading conversion results
Message-ID: <20220912104631.zysrv2qqxvsjfbxc@pengutronix.de>
References: <20220815091647.1523532-1-dzagorui@cisco.com>
 <20220820130648.5b9bc66f@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ezvf3oge3bxykhco"
Content-Disposition: inline
In-Reply-To: <20220820130648.5b9bc66f@jic23-huawei>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
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


--ezvf3oge3bxykhco
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 20, 2022 at 01:06:48PM +0100, Jonathan Cameron wrote:
> On Mon, 15 Aug 2022 09:16:47 +0000
> Denys Zagorui <dzagorui@cisco.com> wrote:
>=20
> > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > After the result of the previous conversion is read the chip
> > automatically starts a new conversion and doesn't accept new i2c
> > transfers until this conversion is completed which makes the function
> > return failure.
>=20
> That's rather nasty.
>=20
> Could we add a cheeky sleep in the other path to ensure there is always
> time for the conversion to be done?  Not ideal, but might ensure
> there isn't a known problem path without introducing much complexity.

FTR: While the patch was originally authored by me, I don't currently
have access to a machine with that chip. So currently there will be no
incentive on my side to address this feedback.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ezvf3oge3bxykhco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMfDgQACgkQwfwUeK3K
7AmQ6gf+NR1FwVMFUWi//G/dOvI5TtKnE0cBWo/3lgdWKrl4gI23fUrjPzLtj6NL
gFNMKWNV9IXtcAlgqsupSgijpP1Z7Ekyy+J8tEmFEoxpSVwLD4f+teYSQfSsuufa
GougDEpKASI4zg+IICkN1d7aqKb6oDbGEZgZyO1AxwveJka7h+Fs58m6dOd1F0LE
VtxTJtNeQa5ZiNJBu51a6xKatwM/bksdyjDYhLbC7bH6pGZWxeHBQBt5o/3fNBVi
L7gqYWoAhSvUMooGJaTOlJjtxsGvNBL1l4krxpsvhkjDWclfa+d3D2IUKklTWxGh
y3WVQ5YzOb9nDZachCn/42qSkaE29Q==
=4MJU
-----END PGP SIGNATURE-----

--ezvf3oge3bxykhco--
