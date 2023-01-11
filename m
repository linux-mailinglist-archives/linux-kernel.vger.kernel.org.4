Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84331665F23
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbjAKPai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239110AbjAKPa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:30:29 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43F52DE7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:30:27 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 276551C0A1B; Wed, 11 Jan 2023 16:30:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1673451025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TBME/opWYBNkMwI9A2QPHtTLLghbyG3JGjLifeeCX5o=;
        b=IKsYIv609qcBaLYYbHC5UeGFgwGxsyLqVIccWd4ValsKjwP1ZC786GvxwSfRCDCJPDSyGQ
        e9hypRMMlpK02LKasDZ7bbTOjcvXxTzjWAB2sJWOaLTdBWVll9y46t5gWO/2aH1tM9XEvb
        bI19rUvFyEXsT/ez4orKW2HZqhsWYh0=
Date:   Wed, 11 Jan 2023 16:30:24 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>
Subject: Re: Dhrystone -- userland version
Message-ID: <Y77WEO43H8eIPA5U@duo.ucw.cz>
References: <Y7nyd4hPeXsdiibH@duo.ucw.cz>
 <Y7pRw47hidw+s6+g@mit.edu>
 <Y7pzbnlXgv+asekg@amd.ucw.cz>
 <CAMuHMdVvVoEs8yjNLmK=_shmGkyz1zYc8ZMi-vmP4aee0yKoPQ@mail.gmail.com>
 <Y7sPq3Tmm6vI/RAJ@duo.ucw.cz>
 <Y7tjnhs77o4TL5ey@mit.edu>
 <614os9n2-2sq1-2qnr-56q6-1qq628271175@vanv.qr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5LiFXUXtFUTUaBpw"
Content-Disposition: inline
In-Reply-To: <614os9n2-2sq1-2qnr-56q6-1qq628271175@vanv.qr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5LiFXUXtFUTUaBpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> > However, as this is not Linux-specific, how hard can it be to convin=
ce
> >> > your distro to include https://github.com/qris/dhrystone-deb.git?
> >> > Usually, when I have a full userspace available, I just clone the ab=
ove,
> >> > and debuild it myself.
> >>=20
> >> Dunno. I'd not solve it if package was in Debian, but it is not.
> >
> >I would suspect the better long-term solution would be to get the
> >package into Debian, since that will be easier for people to use.  I
> >suspect the reason why most distros don't include it is because it
> >really is a **terrible** benchmark for most use cases.
>=20
> (All of) you could install boinc-client and just exercise
> --run_cpu_benchmarks without (I think) attaching to any particular
> computing project. The package should be in distros and you get
> both Dhrystone and Whetstone.

Hehe, nice trick, but it does not work for me:

boinc --run_cpu_benchmarks

does not actually seem to run the benchmarks. Anyway, it is 3MB
project for few kilobytes of benchmarks...

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--5LiFXUXtFUTUaBpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY77WEAAKCRAw5/Bqldv6
8p5JAJ40fdLePneqR4/u2K9+2qGMLitCbQCgoo0GET2kQHH+UeOo0+euwRIX4Rc=
=7ZDy
-----END PGP SIGNATURE-----

--5LiFXUXtFUTUaBpw--
