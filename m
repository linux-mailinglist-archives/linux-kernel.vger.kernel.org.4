Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CED66140D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 08:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjAHHkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 02:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjAHHke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 02:40:34 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61F8BE18
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 23:40:32 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D771D1C09F4; Sun,  8 Jan 2023 08:40:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1673163630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cyp3UEEKF+h3KLwkYlIyErX4/yhvSv1NJSCucbp5NKo=;
        b=BZcTP13DxPc60Pe8afTZWqmTssQx01RaUw+jiPFzLk2eMw8m0zAJYomow55yGVRSzwfaSX
        u7z3/gu/f+bsQi7xbk8afx980BRBP6MJrnQY87rfXXD8+I+jNRsYxgtuionaBT5GJvq9V8
        wYotgCPjXUBrU060O47keiWuzsr/Mfw=
Date:   Sun, 8 Jan 2023 08:40:30 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        geert+renesas@glider.be, Andrew Morton <akpm@osdl.org>
Subject: Re: Dhrystone -- userland version
Message-ID: <Y7pzbnlXgv+asekg@amd.ucw.cz>
References: <Y7nyd4hPeXsdiibH@duo.ucw.cz>
 <Y7pRw47hidw+s6+g@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="i3UURa/w1L52u2HJ"
Content-Disposition: inline
In-Reply-To: <Y7pRw47hidw+s6+g@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i3UURa/w1L52u2HJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Distributions do not usually carry dhrystone, and I don't think anyone
> > really maintains it. It is useful tool, and it seems we'll maintain
> > it.
> >=20
> > I'd like to add enough glue so that it would be runnable from
> > userspace, too? Userland version is what is actually useful to me, and
> > it should not be hard.
>=20
> I don't see whatever message you were replying to, and it doesn't seem
> to be archived in lore[1], so I'm not sure about the context.  But you
> are talking about the Dhrystone benchmark[2], right?
>=20
> [1] https://lore.kernel.org/all/Y7nyd4hPeXsdiibH@duo.ucw.cz/T/#u
> [2] https://wiki.cdot.senecacollege.ca/wiki/Dhrystone_howto
>=20
> If so, I'm confused what you mean by "add enough glue so that it would
> be runnable from userspace" --- Dhrystone is a userspace benchmark,
> dating from the 1980's, although what it benchmarks is often more about
> the compiler than the CPU's performace.

Yes, I'm talking about Dhrystone benchmark. We are carrying
kernel-only version in lib/dhry_*.c, it is in -next now.

commit cfbd4cc940275240e97f8b922c8f18a44fe15c07
Author: Geert Uytterhoeven <geert+renesas@glider.be>
Date:   Thu Dec 8 15:31:28 2022 +0100

    lib: add Dhrystone benchmark test

I'd like userspace-too version, at the same place :-).

Best regards,
								Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--i3UURa/w1L52u2HJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY7pzbQAKCRAw5/Bqldv6
8mBdAKCB+s9skaJn7bwxrK8IvAap0mNecQCfUp6TUf7qXFHU4dIVVxn4vsKdZa0=
=DGt3
-----END PGP SIGNATURE-----

--i3UURa/w1L52u2HJ--
