Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC135B5B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 15:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiILNkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 09:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiILNkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:40:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3823C0B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 06:40:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oXjfW-0002vR-3V; Mon, 12 Sep 2022 15:40:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oXjfT-000JPI-OK; Mon, 12 Sep 2022 15:40:06 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oXjfR-000NxN-Ls; Mon, 12 Sep 2022 15:40:05 +0200
Date:   Mon, 12 Sep 2022 15:40:04 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pinctrl tree
Message-ID: <20220912134004.bwdwnshk7xegytvu@pengutronix.de>
References: <20220826152650.2c55e482@canb.auug.org.au>
 <CACRpkdYZOK9NhEqqU4Wkg1XHCHEQk=AR6w9730qo_tHmgGrorA@mail.gmail.com>
 <YwiscXaIDER6SnBf@shikoro>
 <CACRpkdZZHFQLu3ZfPaSPdWBCNiR9Mmqwgz697XaMWWuAsyPW-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="at4pz37mukpabpqm"
Content-Disposition: inline
In-Reply-To: <CACRpkdZZHFQLu3ZfPaSPdWBCNiR9Mmqwgz697XaMWWuAsyPW-w@mail.gmail.com>
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


--at4pz37mukpabpqm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

On Fri, Aug 26, 2022 at 03:18:25PM +0200, Linus Walleij wrote:
> On Fri, Aug 26, 2022 at 1:20 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>=20
> > > How typical, the ideal way to resolve it is if there is an immutable
> > > branch with the basic changes I can pull in from the i2c tree
> >
> > It is already there:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/make_re=
move_callback_void-immutable
>=20
> Oh excellent, pulled this in and applied Stephens fixup on top.

Ideally you would have squashed the fixup into the merge commit. With
the history as it is now you introduced a commit (i.e.  1681956cb79c
("Merge branch 'i2c/make_remove_callback_void-immutable' of
git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux into devel"))
that fails to compile the pinctrl-cy8c95x0 driver. Also a better subject
line than "pinctrl: fixup for "i2c: Make remove callback return void""
would be nice, I would have mentioned 'cy8c95x0' at least. (But this is
mood of course if your tree is already stable or you remerge and
squash.)

> > Uwe (originator of the series) spread this information. Sorry that it
> > did not reach you.
>=20
> Don't worry about that, there is no perfect process.

This commit touches quite a lot of files and subsystems. In the first
revision I added all affected maintainers and lists. vger refused the
mail because the the headers got too long.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--at4pz37mukpabpqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMfNrEACgkQwfwUeK3K
7AlS2Af/bMaBSlYevYVGFQzSVdMobsIKe9oembDOe/g9NPdQ3Cs7PO92QRRcB6z8
3647Jc/rmgSeAJOAkvYKZXyYDxdnatVgQPYwRf9c7c+IJw9uV34uoZFUT3vT4omQ
Or9trei0waEsXP4medfbIkUm51NZe2XvbPBGs0ZpfHpKKZqaVjFJc3o5kn220PTu
UTwgtwAv8YRleIWinub47dk8NfNAPNDumOvHTdUVE9ilKp5YIyml3JyjrF/SGMPE
iRrbd82/sdiBXXsFrGDorrp64eQxEmawQXZLwizNVu0psfIxviDsPb9HA37EulqG
coXhP6Usoqs971Xue2R6cxKnHa4UCQ==
=wkpk
-----END PGP SIGNATURE-----

--at4pz37mukpabpqm--
