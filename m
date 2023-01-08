Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E840666184E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbjAHSrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjAHSrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:47:11 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A36DEE1E
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 10:47:09 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1EE181C0A11; Sun,  8 Jan 2023 19:47:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1673203628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fy35OIA7dD231ryZrod0YuOrENQ6nEhnCctLtmGOVsU=;
        b=UdEALVT1yYonfMtThDGq8vHjlmpstL07wfnCTGTQdfXQjy8+/LWgpcFldhn/4JCaQ0mpwN
        fOPUFqqLyrCulRrKfKHs0RXrwosW6oqOEBy0kEW/SKD18zGf5dV4Jsbp4dxjTUqE8hyMjk
        pESMuNfN/oeR+aX9zwYXZViuNsVv/m0=
Date:   Sun, 8 Jan 2023 19:47:07 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>
Subject: Re: Dhrystone -- userland version
Message-ID: <Y7sPq3Tmm6vI/RAJ@duo.ucw.cz>
References: <Y7nyd4hPeXsdiibH@duo.ucw.cz>
 <Y7pRw47hidw+s6+g@mit.edu>
 <Y7pzbnlXgv+asekg@amd.ucw.cz>
 <CAMuHMdVvVoEs8yjNLmK=_shmGkyz1zYc8ZMi-vmP4aee0yKoPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="n8dz6Xie3ejRSxA2"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVvVoEs8yjNLmK=_shmGkyz1zYc8ZMi-vmP4aee0yKoPQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8dz6Xie3ejRSxA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Sun, Jan 8, 2023 at 8:40 AM Pavel Machek <pavel@ucw.cz> wrote:
> > > > Distributions do not usually carry dhrystone, and I don't think any=
one
> > > > really maintains it. It is useful tool, and it seems we'll maintain
> > > > it.
> > > >
> > > > I'd like to add enough glue so that it would be runnable from
> > > > userspace, too? Userland version is what is actually useful to me, =
and
> > > > it should not be hard.
> > >
> > > I don't see whatever message you were replying to, and it doesn't seem
> > > to be archived in lore[1], so I'm not sure about the context.  But you
> > > are talking about the Dhrystone benchmark[2], right?
> > >
> > > [1] https://lore.kernel.org/all/Y7nyd4hPeXsdiibH@duo.ucw.cz/T/#u
> > > [2] https://wiki.cdot.senecacollege.ca/wiki/Dhrystone_howto
> > >
> > > If so, I'm confused what you mean by "add enough glue so that it would
> > > be runnable from userspace" --- Dhrystone is a userspace benchmark,
> > > dating from the 1980's, although what it benchmarks is often more abo=
ut
> > > the compiler than the CPU's performace.
> >
> > Yes, I'm talking about Dhrystone benchmark. We are carrying
> > kernel-only version in lib/dhry_*.c, it is in -next now.
> >
> > commit cfbd4cc940275240e97f8b922c8f18a44fe15c07
> > Author: Geert Uytterhoeven <geert+renesas@glider.be>
> > Date:   Thu Dec 8 15:31:28 2022 +0100
> >
> >     lib: add Dhrystone benchmark test
> >
> > I'd like userspace-too version, at the same place :-).
>=20
> So you want to add some glue code to tools/testing/, for building a
> userspace version?

Yes, that would be the plan.

> However, as this is not Linux-specific, how hard can it be to convince
> your distro to include https://github.com/qris/dhrystone-deb.git?
> Usually, when I have a full userspace available, I just clone the above,
> and debuild it myself.

Dunno. I'd not solve it if package was in Debian, but it is not.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--n8dz6Xie3ejRSxA2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY7sPqwAKCRAw5/Bqldv6
8hqIAJ4g6x0efgUqfwmdE75AMdaHlarmgQCeKfoVratXPGMtDBIpijeOU+gAgdI=
=cVIi
-----END PGP SIGNATURE-----

--n8dz6Xie3ejRSxA2--
