Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3FC65C2C2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjACPEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjACPEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:04:06 -0500
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Jan 2023 07:04:05 PST
Received: from mail.sleepmap.de (sleepmap.de [85.10.206.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5836D11837;
        Tue,  3 Jan 2023 07:04:05 -0800 (PST)
Date:   Tue, 3 Jan 2023 15:46:44 +0100
From:   David Runge <dave@sleepmap.de>
To:     Clark Williams <williams@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [ANNOUNCE] 5.15.85-rt55
Message-ID: <Y7Q/3udZgxscrsq5@hmbx>
References: <167183636829.152847.13405480898195673998@puck.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rroYYypT0UA9ZuQj"
Content-Disposition: inline
In-Reply-To: <167183636829.152847.13405480898195673998@puck.lan>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rroYYypT0UA9ZuQj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 3 Jan 2023 15:46:44 +0100
From: David Runge <dave@sleepmap.de>
To: Clark Williams <williams@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Pavel Machek <pavel@denx.de>
Subject: Re: [ANNOUNCE] 5.15.85-rt55

On 2022-12-23 22:59:28 (-0000), Clark Williams wrote:
> Hello RT-list!
>=20
> I'm pleased to announce the 5.15.85-rt55 stable release.
>=20
> You can get this release via the git tree at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>=20
>   branch: v5.15-rt
>   Head SHA1: 167affb50e57a4e26fea150d28a49ff02ed0947b
>=20
> Or to build 5.15.85-rt55 directly, the following patches should be applie=
d:
>=20
>   https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz
>=20
>   https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.85.xz
>=20
>   https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.85-=
rt55.patch.xz
>=20
>=20
> Enjoy!
> Clark

Hi Clark,

thanks for the release!

Could I get a short comment on my previous mail [1] in regards to the
git repository?
The repository now tracks multiple newer kernel versions (sort of) and
there has been no reply to my questions yet (wildcard ignoring all v6,
v5.19, v5.18, v5.17, v5.16 tags in that repository is not a solution
that scales when it comes to downstream version tracking). Thanks!

Best,
David

[1] https://www.spinics.net/lists/linux-rt-users/msg26405.html

--=20
https://sleepmap.de

--rroYYypT0UA9ZuQj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQXk9rV2AOo/9dFFpe7mS+YZPrRaAUCY7Q/1AAKCRC7mS+YZPrR
aL4YAP9666QLhndyK7/Qj60udKH9OmCYdiaV5scxmNoGHnbrrAEAjKYYsGfr9ATj
gptentMeDB26HqyPkrg98flDF5lcdQM=
=tT/C
-----END PGP SIGNATURE-----

--rroYYypT0UA9ZuQj--
