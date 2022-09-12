Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FE15B5566
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiILHfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiILHfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:35:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D9313DF7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:35:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oXdyB-0004uo-Rf; Mon, 12 Sep 2022 09:35:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oXdyC-000FzI-AF; Mon, 12 Sep 2022 09:35:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oXdyA-000KQB-3I; Mon, 12 Sep 2022 09:35:02 +0200
Date:   Mon, 12 Sep 2022 09:34:55 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: linux-next: manual merge of the battery tree with the i2c tree
Message-ID: <20220912073455.rlqf6q4rsgydk46h@pengutronix.de>
References: <20220912130344.2e635cd5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="blckbo5i5mv4j6kq"
Content-Disposition: inline
In-Reply-To: <20220912130344.2e635cd5@canb.auug.org.au>
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


--blckbo5i5mv4j6kq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Sep 12, 2022 at 01:03:44PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the battery tree got a conflict in:
>=20
>   drivers/power/supply/cw2015_battery.c
>=20
> between commit:
>=20
>   ed5c2f5fd10d ("i2c: Make remove callback return void")
>=20
> from the i2c tree and commit:
>=20
>   ed5c2f5fd10d ("i2c: Make remove callback return void")
>=20
> from the battery tree.

The commit from the battery tree is

	0cb172a4918e ("power: supply: cw2015: Use device managed API to simplify t=
he code")

> I fixed it up (the latter removed the code modified by the former, so
> I just did that)

I don't see today's tag in git yet, but removing the code sounds right.

> and can carry the fix as necessary. This is now fixed as far as
> linux-next is concerned, but any non trivial conflicts should be
> mentioned to your upstream maintainer when your tree is submitted for
> merging.  You may also want to consider cooperating with the
> maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

@Sebastian: You might want to pull

	https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux i2c/make_remove_=
callback_void-immutable

into your tree to prepare a smooth merging experience for Linus.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--blckbo5i5mv4j6kq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMe4QoACgkQwfwUeK3K
7AmmwAf/VOi5lCUUa3xbiG0QAST1k1xoG020R0+rYgbT6/n6fN69wri6wLImLRBC
myCx7URUQVvH5kMnt/vrD+Kfoy4MAsUKXz5nnYtVHoWakdVD+qo5BMjjkFUweZGK
budPINOnCwdHtKUy7RTuDnawvFxPhyQpV9gOpmarnGgr2On10+Yu+j1iLSoOpSpM
FkzKBjp8HtrsjxvSiicysK+etZjGaCvtga07cvZWtcZQ0ix1iwL+kYffYvUW6CV5
CeUpNLM3rXoteybClqHG8vwgLxc6ygQSu+I+ZK9Nva5saHHlKNAPhFWwz9pwYXUy
HE622WjH1mNGIKPgf4uIJVHC0uCMkg==
=CQOX
-----END PGP SIGNATURE-----

--blckbo5i5mv4j6kq--
