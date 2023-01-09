Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022B166292E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjAIO7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbjAIO7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:59:35 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D5F186A9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 06:59:33 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7A5D51C09F6; Mon,  9 Jan 2023 15:59:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1673276371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3N0YypGB5FR8jmXU/zlMwee5sTdJ2IYXfAvNqLFDCmc=;
        b=E9FxY7NcAmeyouB8/Bp/QA6JhhiikqOdQt+32HGrP5Sp+LtJPEShtfM71Dceye3hYmc9AW
        2MzGRzlT9KSTwG5UjkqmuUVh0H1qkZRjHi2C4O+bNLv9lxscxKyLNZkr+TnT1JNTp6DcMG
        wEs0nlgYgronjcoBtoh6vOBcn4bsm5c=
Date:   Mon, 9 Jan 2023 15:59:31 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>
Subject: Re: Dhrystone -- userland version
Message-ID: <Y7wr08Zs/sSjWizU@duo.ucw.cz>
References: <Y7nyd4hPeXsdiibH@duo.ucw.cz>
 <Y7pRw47hidw+s6+g@mit.edu>
 <Y7pzbnlXgv+asekg@amd.ucw.cz>
 <CAMuHMdVvVoEs8yjNLmK=_shmGkyz1zYc8ZMi-vmP4aee0yKoPQ@mail.gmail.com>
 <Y7sPq3Tmm6vI/RAJ@duo.ucw.cz>
 <Y7tjnhs77o4TL5ey@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pgmVVIHcPVVTV7XJ"
Content-Disposition: inline
In-Reply-To: <Y7tjnhs77o4TL5ey@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pgmVVIHcPVVTV7XJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > However, as this is not Linux-specific, how hard can it be to convince
> > > your distro to include https://github.com/qris/dhrystone-deb.git?
> > > Usually, when I have a full userspace available, I just clone the abo=
ve,
> > > and debuild it myself.
> >=20
> > Dunno. I'd not solve it if package was in Debian, but it is not.
>=20
> I would suspect the better long-term solution would be to get the
> package into Debian, since that will be easier for people to use.  I
> suspect the reason why most distros don't include it is because it
> really is a **terrible** benchmark for most use cases.

Yeah, so... every benchmark is terrible. Is this one worse than most?

I tried benchmarking using:
time factor $[65863223*65863159]
     - but that's division test, not a CPU test, and there are two
     versions of factor floating around
time cat /dev/urandom | head -c 10000000 |  bzip2 -9 - | wc -c
     - but that seems to be memory test, not a CPU test.

Dhrystone seems to be making some kind of comeback in RISC-V land. Is
there something better? Something better that is still reasonably small?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--pgmVVIHcPVVTV7XJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY7wr0wAKCRAw5/Bqldv6
8gfwAJ9jQcuWAQlbpDwARXR+3HLrO2KmSgCgt9Q3DDs4C2QhY6L7GZ7QQ3XoT+A=
=6mf6
-----END PGP SIGNATURE-----

--pgmVVIHcPVVTV7XJ--
