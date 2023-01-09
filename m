Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198EB6630C9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbjAITw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbjAITwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:52:06 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D38B1868E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:51:46 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A49621C0A11; Mon,  9 Jan 2023 20:51:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1673293904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DWq0SZ79s+SaoYdcQ2Lj4BMZF7mqwSGo8Vowg6siQvo=;
        b=NX3CXEmaCA4E85Ou2EmJUOdYTWiGUnKt2ViEXVS04Xbx/+ewnAciRjVEuGou7tb29NTgrl
        1t0OzKobVLOR3DSfkrJ2V255VuFyVxhQWt45SxlKeN8V269P/V2C26fVt5aLvdREqJ9H3J
        n9uVx8dgOzMAB96/Sdpg/pq3YsE60T4=
Date:   Mon, 9 Jan 2023 20:51:44 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Willy Tarreau <w@1wt.eu>, Theodore Ts'o <tytso@mit.edu>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>
Subject: Re: Dhrystone -- userland version
Message-ID: <Y7xwUKE64PfPRMt7@duo.ucw.cz>
References: <Y7nyd4hPeXsdiibH@duo.ucw.cz>
 <Y7pRw47hidw+s6+g@mit.edu>
 <Y7pzbnlXgv+asekg@amd.ucw.cz>
 <CAMuHMdVvVoEs8yjNLmK=_shmGkyz1zYc8ZMi-vmP4aee0yKoPQ@mail.gmail.com>
 <Y7sPq3Tmm6vI/RAJ@duo.ucw.cz>
 <Y7tjnhs77o4TL5ey@mit.edu>
 <CAMuHMdXP8ycxE_Sny0q+SAzLTwnaA3hks=ErW-ZfiMBw7ZMSgg@mail.gmail.com>
 <20230109143059.GB25476@1wt.eu>
 <CAMuHMdWm8Z-xkDUTjppbPT_uxFqfdOZPrPYxgBNgFRL6E=sN3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VsORvAF1Yc5f5643"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWm8Z-xkDUTjppbPT_uxFqfdOZPrPYxgBNgFRL6E=sN3w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VsORvAF1Yc5f5643
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >   count=3D1666675 us50=3D20178 us250=3D99913 diff=3D79735 cpu_MHz=3D418=
0.536 tsc50=3D42614718 tsc250=3D211016124 diff=3D101 rdtsc_MHz=3D2112.014
> >
> > It's also what's used by sbc-bench to verify that CPU vendors are not
> > cheating in the embedded world. It's very simple, and not arch-dependent
> > nor compiler-dependent (at least as long as you don't build at -O0 :-)).
>=20
> Seeing the rdtsc stuff, I was a bit skeptical, but it seems to work
> fine on arm32 and rv64.
>=20
> Unfortunately you forgot to add a LICENSE file ;-)
>=20
> Alternatively, I can use the C version of BogoMIPS.  Which has its
> own merits and reputation.

I'd expect BogoMIPS to be _much_ worse than Dhrystone. If all the
cores are same, it should be good enough, but...

> The nice thing about Dhrystones is that people still publish numbers
> for comparison, also DMIPS/MHz and DMIPS/mW.

=2E..and there seems to be no replacement for that. Dhrystones seem to
become the standard in RISC-V community at least.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--VsORvAF1Yc5f5643
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY7xwUAAKCRAw5/Bqldv6
8uzGAJ9z8KFcrH+do8dyqDy4rnhqr3OnowCgrPUcz68YUTovc951wVDN9S8TCEM=
=T64f
-----END PGP SIGNATURE-----

--VsORvAF1Yc5f5643--
