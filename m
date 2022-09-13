Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5913B5B6B22
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbiIMJre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiIMJrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:47:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D525E642
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:46:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oY2V7-0005Rg-0m; Tue, 13 Sep 2022 11:46:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oY2V6-000TJO-JV; Tue, 13 Sep 2022 11:46:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oY2V4-000YxK-Dm; Tue, 13 Sep 2022 11:46:38 +0200
Date:   Tue, 13 Sep 2022 11:46:35 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-spdx@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] SPDX tags for copyright
Message-ID: <20220913094635.g2gtqrpveknjusup@pengutronix.de>
References: <20220908223850.13217-1-u.kleine-koenig@pengutronix.de>
 <YyAPsqKNSwdHccLj@infradead.org>
 <YyA9S9KD47D6Hoce@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l3adkypon5wehkcy"
Content-Disposition: inline
In-Reply-To: <YyA9S9KD47D6Hoce@kroah.com>
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


--l3adkypon5wehkcy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[dropped Kai Germaschewski as his email address doesn't work]

On Tue, Sep 13, 2022 at 10:20:27AM +0200, Greg KH wrote:
> On Mon, Sep 12, 2022 at 10:05:54PM -0700, Christoph Hellwig wrote:
> > On Fri, Sep 09, 2022 at 12:38:48AM +0200, Uwe Kleine-K=F6nig wrote:
> > > Hello,
> > >=20
> > > for Debian packaging having SPDX license tags already simplifies
> > > creating the required copyright documentation considerably. Another
> > > information that is needed for Debian packaging is the copyright
> > > information. There is an SPDX way for copyright information, too. The
> > > second patch converts scripts/kallsyms.c to that mechanism as an exam=
ple
> > > to maybe discuss if we want to do that in the kernel.
> > >=20
> > > While the SPDX-FileCopyrightText is officially a free-form field, I
> > > suggest to just stick to the format
> > >=20
> > > 	(<year> )?<copyright holder>
> > >=20
> > > to simplify machine consumption even further.
> >=20
> > Adding the linux-spdx list and Linus.  If we go with this format

Ah, didn't know about the spdx list (and didn't dare to bother Linus
with that). Thanks!

> > (which doesn't sound bad), we'll clearly need to document the format
> > we want, and that people should use it.
>=20
> There is a well-agreed-apon legal format for copyright lines already,
> and those lines should be fine in the comment text at the top of the
> file.  No need to mess with SPDX-FileWhateverTagWeWant type of stuff
> here at all as all of our tools can easily find those lines if they
> really want to extract the copyright information.

I didn't find a tool that can extract these informations in the
collection of scripts (i.e. below scripts/). Did I miss anything?

What is that "well-agreed-upon legal format for copyright lines"?
Grepping a bit around, here are some examples:

 * Portions Copyright (c) 2004-2006 Silicon Graphics, Inc.
 * - Copyright (C) 2001 Junichi Morita <jun1m@mars.dti.ne.jp>
 * **Copyright** |copy| 1999-2020 : LinuxTV Developers
 * Copyright: |copy| 1995--1999 Martin Mares, <mj@ucw.cz>
 * Copyright (c) 2000
   - Jorge Nerin <comandante@zaralinux.com>
 * Ben Dooks, Copyright 2006 Simtec Electronics
 * Copyright, IBM Corp. 1999-2002
 * :copyright:  Copyright (C) 2016  Markus Heiser
 * Copyright (C) 2015 Atmel,
                 2015 Nicolas Ferre <nicolas.ferre@atmel.com>

and this is just the unusal stuff I found in a few minutes.

> SPDX is great for license declarations, let's stick with only using that
> for now until we finish the whole kernel and then maybe we can worry
> about adding additional meta information if it's really decided it can
> benifit anyone.

When converting a file to use SPDX-License-Identifier adding the SPDX
copyright stuff in the same commit might save some churn?!

Wasn't the situation with licenses similar before SPDX was in use? i.e.
there are scripts that more or less reliably determine the license of a
given file. But the "more or less" part results in some unease and so a
formalism was introduced.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--l3adkypon5wehkcy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMgUXgACgkQwfwUeK3K
7AmOvwgAji8uKSs/IPFcALvH6zvoyDunpy9zv9LhASYTexqk3SC5he8YfZFVvkx1
dOhbgSeBROA0FC/rWFULkERpvKnJ2OnIQho84vsb0QElRphyLG51DOEyuACOsYj7
QPGqB2t8b1UjOyGh0DUYINZDWIbOjzSiZ15yl2PC0+0Xl3w0SU9bjQacLsdCVMDv
+tiq9UhSYSovFuhlbZs6CxitHBSc/bI+d65ndqVF8uD6rAX8cjCHwpabMpAn6lKF
olQ3Ent3NgT9xa/JWQMRzgpIgQjmBmOyz1s58aBFIP0A/18FGDe1YiCK8LP34em9
O4t3U40funwoRi0G9lCDS1WO8Xi5aA==
=SoPo
-----END PGP SIGNATURE-----

--l3adkypon5wehkcy--
