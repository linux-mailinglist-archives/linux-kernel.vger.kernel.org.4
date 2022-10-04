Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B10A5F4260
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJDLvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiJDLum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:50:42 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1184A51A30;
        Tue,  4 Oct 2022 04:50:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mhbc92RC8z4xFv;
        Tue,  4 Oct 2022 22:50:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664884217;
        bh=+DRDaNohrM/Soqm2UqZOWqj7AxZRXAGOMY1YpMVLa6Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hom4NfAiqslgvEJH4epr2G6KAISgSeRvIInEwWhMgTrQeWEK0yzshD1hSeiQi48KC
         0r7jbsP9/Zszsn7IuhSZ45MDOl9ui37UPHPJa12PS892RTgLkdxjPQPLfmbvdoGAup
         QLHUr6P3SpjcpbdfLCKHCmEomV/7l7Djqxzh2VQdkTq1sXX8wSH/67arObla6ziJ1b
         TouiXGUiz2JFbN6uxY/djJoH5XrPFe3XLgkXTCIt1N2JarzIRQ+xz5UOhN0vfvgA9z
         tv72FJPJFvOverWWOYOf2ytoSuI/QFL4lsspXVpsWz0msjRWauPYe2ICoKeyaY+An7
         fh8tR/T6yQQqw==
Date:   Tue, 4 Oct 2022 22:50:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Stephen Zhang <starzhangzsd@gmail.com>,
        Shida Zhang <zhangshida@kylinos.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the xfs tree
Message-ID: <20221004225012.501e11ed@canb.auug.org.au>
In-Reply-To: <20221003222103.GM3600936@dread.disaster.area>
References: <20221004072302.345bfd4a@canb.auug.org.au>
        <20221003222103.GM3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ib3YZiwGdgXiXVkvXyv/JJR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ib3YZiwGdgXiXVkvXyv/JJR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Tue, 4 Oct 2022 09:21:03 +1100 Dave Chinner <david@fromorbit.com> wrote:
>
> The commit matches exactly what was sent to the list. It's just
> that the patch was sent from a personal email address with a
> corporate signoff.
>=20
> Since when has that been an issue?  I -personally- have been doing
> this for well over a decade and I'm pretty sure there are lots of
> other people who also do this.

If you are happy (as the maintainer), then fine.  My script just could
not connect those 2 email addresses.  I check for matches between the
address itself (the part between the <>) or a match between the "name"
part (before the <>).  If either matches (or it is obvious) then I
don't report it.

I have reported very few of these.

> Hence if this is wrong, then we've got a tooling problem with b4.
> Why does b4 allow this rather than warn/fail if it's not actually
> allowed in the linux-next tree?

These reports are more of "is this right/was this a slipup?" rather
than "this is not allowed" i.e.. there are circumstances under which
the actual author does not (or cannot) provide a Signed-off-by and that
is OK.
--=20
Cheers,
Stephen Rothwell

--Sig_/Ib3YZiwGdgXiXVkvXyv/JJR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM8HfQACgkQAVBC80lX
0Gy3pwf/cMAIaArvSzuxPZW7Ukbfi+Q94kZevrN8DrTCdF4ZPVOnlK3FftiQUjVg
TOtH3lRHFpRHxMIT/YLis5fgDlnhjXxk5rRM5iD8v9v/O+VhbmhfYxXKCUmJsI6v
EPTGP6Ogyqz29P8G223zI46+rOzY2u117ICnKpRa7v3bqHJGDlUWQFEgDMJqZjbW
UJGupQyFmuV6tN2wd4apZegM4wIBeGP0cLwCdL8Lv69afYy/EzTl09fLuevtF0rK
bbib1IXbkjADfoSGKUI4lRbHobxyqVfx9mSycY6kmw/Fe/mp0Ykdq3b5LLWvsvcs
737eINxrchZpQ++GsXZ3kFR/Y+W48Q==
=K9Ou
-----END PGP SIGNATURE-----

--Sig_/Ib3YZiwGdgXiXVkvXyv/JJR--
