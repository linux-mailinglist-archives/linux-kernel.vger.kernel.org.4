Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF783673715
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjASLkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjASLj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:39:29 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F0178A89;
        Thu, 19 Jan 2023 03:38:28 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C8D331C09F6; Thu, 19 Jan 2023 12:38:25 +0100 (CET)
Date:   Thu, 19 Jan 2023 12:38:25 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [ANNOUNCE] 5.10.162-rt78
Message-ID: <Y8krsVFguwWLy+zT@duo.ucw.cz>
References: <Y8VSslRJZpFbo1/u@uudg.org>
 <40de655e-26f3-aa7b-f1ec-6877396a9f1e@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Cfp9a2B4eltLvtv1"
Content-Disposition: inline
In-Reply-To: <40de655e-26f3-aa7b-f1ec-6877396a9f1e@ti.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NEUTRAL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Cfp9a2B4eltLvtv1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I'm pleased to announce the 5.10.162-rt78 stable release.
> >=20
> > You can get this release via the git tree at:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> >=20
> >   branch: v5.10-rt
> >   Head SHA1: 143ef105f40a65f3ddd57121d4b4bc36eb10cc06
> >=20
> > Or to build 5.10.162-rt78 directly, the following patches should be app=
lied:

> I see that vanilla 5.10.162-rt78 fails to build with arm64 defconfig. [0]=
 Full log [1]
> Any pointers on what maybe wrong?

We see the same failure.=20

>   AS      arch/arm64/kernel/entry.o
> arch/arm64/kernel/entry.S: Assembler messages:
> arch/arm64/kernel/entry.S:763: Error: immediate out of range at operand 3=
 -- `and x2,x19,#((1<<1)|(1<<0)|(1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(1<<13)|=
(1<<7))'
> make[2]: *** [scripts/Makefile.build:367: arch/arm64/kernel/entry.o] Erro=
r 1
> make[1]: *** [scripts/Makefile.build:503: arch/arm64/kernel] Error 2
> make: *** [Makefile:1837: arch/arm64] Error 2

The line is:

>        and     x2, x19, #_TIF_WORK_MASK

And I believe there were some cleanups in stable in that area. Let me
search for them.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Cfp9a2B4eltLvtv1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY8krsQAKCRAw5/Bqldv6
8vT7AJ9jFg3/8RRnxGSeF124ebi5x6X7KACgu7fIwA3SBuZR/RoUGxsZqM/2q68=
=+Nem
-----END PGP SIGNATURE-----

--Cfp9a2B4eltLvtv1--
