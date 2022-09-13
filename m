Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33E25B6E06
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 15:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbiIMNMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 09:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiIMNMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 09:12:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EEA2E9CC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 06:12:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oY5i9-0002KX-3p; Tue, 13 Sep 2022 15:12:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oY5i9-000Vda-K8; Tue, 13 Sep 2022 15:12:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oY5i7-000bV9-67; Tue, 13 Sep 2022 15:12:19 +0200
Date:   Tue, 13 Sep 2022 15:12:19 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, kernel@pengutronix.de,
        linux-spdx@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] SPDX tags for copyright
Message-ID: <20220913131219.27haxojlq5jbmycv@pengutronix.de>
References: <20220908223850.13217-1-u.kleine-koenig@pengutronix.de>
 <YyAPsqKNSwdHccLj@infradead.org>
 <YyA9S9KD47D6Hoce@kroah.com>
 <20220913094635.g2gtqrpveknjusup@pengutronix.de>
 <YyBl/FUVndtEFkW9@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4ehefs4yetqhw4as"
Content-Disposition: inline
In-Reply-To: <YyBl/FUVndtEFkW9@kroah.com>
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


--4ehefs4yetqhw4as
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

On Tue, Sep 13, 2022 at 01:14:04PM +0200, Greg KH wrote:
> On Tue, Sep 13, 2022 at 11:46:35AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Sep 13, 2022 at 10:20:27AM +0200, Greg KH wrote:
> > > On Mon, Sep 12, 2022 at 10:05:54PM -0700, Christoph Hellwig wrote:
> > > > On Fri, Sep 09, 2022 at 12:38:48AM +0200, Uwe Kleine-K=F6nig wrote:
> > > > > for Debian packaging having SPDX license tags already simplifies
> > > > > creating the required copyright documentation considerably. Anoth=
er
> > > > > information that is needed for Debian packaging is the copyright
> > > > > information. There is an SPDX way for copyright information, too.=
 The
> > > > > second patch converts scripts/kallsyms.c to that mechanism as an =
example
> > > > > to maybe discuss if we want to do that in the kernel.
> > > > >=20
> > > > > While the SPDX-FileCopyrightText is officially a free-form field,=
 I
> > > > > suggest to just stick to the format
> > > > >=20
> > > > > 	(<year> )?<copyright holder>
> > > > >=20
> > > > > to simplify machine consumption even further.
> > > >=20
> > > > (which doesn't sound bad), we'll clearly need to document the format
> > > > we want, and that people should use it.
> > >=20
> > > There is a well-agreed-apon legal format for copyright lines already,
> > > and those lines should be fine in the comment text at the top of the
> > > file.  No need to mess with SPDX-FileWhateverTagWeWant type of stuff
> > > here at all as all of our tools can easily find those lines if they
> > > really want to extract the copyright information.
> >=20
> > I didn't find a tool that can extract these informations in the
> > collection of scripts (i.e. below scripts/). Did I miss anything?
>=20
> It's not in the kernel tree, sorry, there are external tools that can do
> this if you really want to.  Like 'grep' as you found :)
>=20
> > What is that "well-agreed-upon legal format for copyright lines"?
>=20
> There's a whole LF presentation that goes into all of the details on
> this that is free:
> 	https://training.linuxfoundation.org/training/open-source-licensing-basi=
cs-for-software-developers/
> and a short summary:
> 	https://www.linuxfoundation.org/blog/copyright-notices-in-open-source-so=
ftware-projects/

Thanks for the link, will look into these.

> But many company legal departments have their own format and
> requirements so there might be variations.  Talk to your lawyers for
> what they require/recommend if you work for a company and want to put a
> copyright line in a file.

Just for the background: My focus is currently on consuming end of these
copyright lines. I want to package barebox for Debian and several files
in barebox are inherited from the kernel. Debian requires to sumarize
all licenses and copyrights in the package meta data. So formalizing
copyrights would simplify that copyright collecting.

> > Grepping a bit around, here are some examples:
> >=20
> >  * Portions Copyright (c) 2004-2006 Silicon Graphics, Inc.
> >  * - Copyright (C) 2001 Junichi Morita <jun1m@mars.dti.ne.jp>
> >  * **Copyright** |copy| 1999-2020 : LinuxTV Developers
> >  * Copyright: |copy| 1995--1999 Martin Mares, <mj@ucw.cz>
> >  * Copyright (c) 2000
> >    - Jorge Nerin <comandante@zaralinux.com>
> >  * Ben Dooks, Copyright 2006 Simtec Electronics
> >  * Copyright, IBM Corp. 1999-2002
> >  * :copyright:  Copyright (C) 2016  Markus Heiser
> >  * Copyright (C) 2015 Atmel,
> >                  2015 Nicolas Ferre <nicolas.ferre@atmel.com>
> >=20
> > and this is just the unusal stuff I found in a few minutes.
>=20
> And you need to get approval from all of those owners to change that
> text.  And the SPDX-Tag format will not help with this at all.

Oh really. I wouldn't consider it critical to replace

	Copyright (C) 2015 Atmel,
	              2015 Nicolas Ferre <nicolas.ferre@atmel.com>

by

	SPDX-FileCopyrightText: 2015 Atmel
	SPDX-FileCopyrightText: 2015 Nicolas Ferre <nicolas.ferre@atmel.com>

=2E But maybe that's only because I didn't consume the above presentation
yet.

> As you did a simple grep to find the above, finding copyright lines is
> not as difficult as determining license text variations that we
> currently are dealing with.
>=20
> So what's the benefit of changing anything right now as no one is saying
> we have Copyright line identification issues?

The benefit is that parsing formalized information is easier, so I'd
prefer to invest time into getting the copyright information into
machine readable format instead of creating a script in a similar
timeframe that can determine all the variants available in the kernel
plus some checking by hand to convince myself I did it right.

> > > SPDX is great for license declarations, let's stick with only using t=
hat
> > > for now until we finish the whole kernel and then maybe we can worry
> > > about adding additional meta information if it's really decided it can
> > > benifit anyone.
> >=20
> > When converting a file to use SPDX-License-Identifier adding the SPDX
> > copyright stuff in the same commit might save some churn?!
>=20
> Again, we aren't recommending to touch copyright lines at all with the
> current SPDX stuff.  Let's focus on licenses first please, that effort
> is not yet complete.
>=20
> > Wasn't the situation with licenses similar before SPDX was in use? i.e.
> > there are scripts that more or less reliably determine the license of a
> > given file. But the "more or less" part results in some unease and so a
> > formalism was introduced.
>=20
> License and copyright are two different things, and different groups
> interact with them.  The SPDX effort on the kernel was started to
> resolve the license questions that people had.  If you wish to also
> address any potential copyright issue, wonderful, please work with the
> legal groups involved to get them to agree that using the SPDX tag is an
> ok thing to do.  But until that happens, let's leave that alone and just
> stick with the text lines for now.

Getting some discussion about what is a sensible way forward was the
intention of my patch.=20

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4ehefs4yetqhw4as
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMggbAACgkQwfwUeK3K
7AkeFAf/eoMcq/VZoki0f+GKIEKAY8sarqbEfJr6YDzw9ei4g+BvIzqh4y8Fv7wW
xP6nK8efKiIijxFynpT+W2z1DXEj+InOkXW74qB6TnASohPyLNRY1fo7G3gCp/MA
jDjh2jr/wKw597O//BqRSH2Ev7OsooPd3Ccr/n1dtl+YkSCqp99fw5u9fsCrP2lQ
CFEOYl7RSf+LsqcxSZLp05IPcV7hLL0lOXdNpgDQfD9aAZI9MuCbsuePnde2VOMy
w1FYFTRJ7gZMphxsHYuyAHQGoZHrQ5QmYPeps4g6upukfHt1GFnv+04v7syf9ooG
rDu43F/a2oFcSEbU0ulplLf4oaP9RA==
=A1PN
-----END PGP SIGNATURE-----

--4ehefs4yetqhw4as--
