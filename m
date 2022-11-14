Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25E2628950
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbiKNT3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237262AbiKNT3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:29:35 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2361720F66;
        Mon, 14 Nov 2022 11:29:35 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AA4AD1C09DB; Mon, 14 Nov 2022 20:29:33 +0100 (CET)
Date:   Mon, 14 Nov 2022 20:29:33 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Pavel Machek <pavel@denx.de>
Cc:     Daniel Wagner <wagi@monom.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [ANNOUNCE] 4.19.261-rt116
Message-ID: <Y3KXHRz9qzzok/yH@duo.ucw.cz>
References: <166845241635.12044.11510831858945534704@beryllium.lan>
 <Y3KSiYf2WAct0Oks@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="v7dgziAAOUbZdIix"
Content-Disposition: inline
In-Reply-To: <Y3KSiYf2WAct0Oks@duo.ucw.cz>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NEUTRAL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v7dgziAAOUbZdIix
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> >=20
> > I'm pleased to announce the 4.19.261-rt116 stable release.
> >=20
> > This is just an update to the latest stable release. No RT specific cha=
nges.
> >=20
> > You can get this release via the git tree at:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> >=20
> >   branch: v4.19-rt
> >   Head SHA1: edd6d572bf0f165405ed98d1b5ed3f191a9fb33b
> >=20
> > Or to build 4.19.261-rt116 directly, the following patches should be ap=
plied:
> >=20
> >   https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz
> >=20
> >   https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.261.xz
> >=20
> >
> https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19=
=2E261-rt116.patch.xz
>=20
> Thank you, I'll take a look.
>=20
> Just out of curiosity, what happened to -rt115? I see announcements
> for -rt114 and then -rt116.

I see the -rt115 in git. I guess 4.19.265-based -rt release can be
expected soon?

Thanks and best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--v7dgziAAOUbZdIix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY3KXHQAKCRAw5/Bqldv6
8rn0AJ4lbIlddmXBwrWguHG96F9CqWqo0wCeIZZSKJNiCs/4UmwgS2uOjCX5lR8=
=i3Pu
-----END PGP SIGNATURE-----

--v7dgziAAOUbZdIix--
