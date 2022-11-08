Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1604621878
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbiKHPib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbiKHPi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:38:28 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38E472736;
        Tue,  8 Nov 2022 07:38:24 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 96C4FB86;
        Tue,  8 Nov 2022 16:38:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1667921901;
        bh=QmFrYew7uldCRdEfnY237r/8E+rgbEnHjVQjjnRiroM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rAckSJb0Nvd8f9bLqB/jNx/HbGoh4z5cUQgYfixAmFnBkKcZmhLyagtO9wUERm1wW
         sXfmAL2985EWoB6SDCHvTV5+gTT5951NfRemZlHJEn+eY1hw0UjSEs5aFzhfnzfjVD
         43TBQdL6BsdCfZJd+ApJD2X/Pa97gWIOI+DAQcCWXKsG0dh04KlUFzqj92BtITJQiN
         9BvCsmOHKCg6bhGPls+bvJFTGsAiMSoiaB9Isu97wtgdMhPglIjv+v5CDmSAOn0mye
         wRCIYaiqhzZFJM0Eaur/Alx0FJwKRirko3rwoyP3DEAV1x6bMdFKaTppuamEDL9Y+5
         afuW7YfxXTb311b1E3HbbgnbAa25ca1PwfS5dw+0eIPWLzKrVc47+ER1bVeNGeTZf8
         Zv5Gr4vDraGTqSNNokTG/zcWotNAAE07fp1BIHsAKp9b9X7mjhN7UQi9cU08FC74R4
         H1rZYtiSRtmE8dCVU2frn2llbCoYe/x3/xnkSg0foazxLsxqkHxHOrluONEdgjAs70
         jpibf1xyVKrIcNwXW+SMDbR2Iu2OuV8c+ixwICHBkHxPL1ngiDeyQ0VXJreeOPyuQY
         ZKqqdziapgXRPdK+r05sH+KBfj0hj2CJmvDlrAhU0s1U9oUK42Vq2VvS86seW2PSaA
         fWi1uQpl9AgI0mbcN24ar4r0=
Date:   Tue, 8 Nov 2022 16:38:20 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 07/15] MIPS: IP27: clean out sn/nmi.h
Message-ID: <20221108153820.fp5du7p7zr7pc7cs@tarta.nabijaczleweli.xyz>
References: <cover.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
 <534e0e7e4f2b0cc1cb35d5024192473635ed1b94.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
 <20221104145002.GA16099@alpha.franken.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h7xzdhf5opgoap56"
Content-Disposition: inline
In-Reply-To: <20221104145002.GA16099@alpha.franken.de>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h7xzdhf5opgoap56
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 04, 2022 at 03:50:02PM +0100, Thomas Bogendoerfer wrote:
> On Wed, Nov 02, 2022 at 12:05:30AM +0100, Ahelenia Ziemia=C5=84ska wrote:
> > The only user is arch/mips/sgi-ip27/ip27-nmi.c; this file was imported
> > wholesale in 2.3.99pre9-1, and received only whitespace updates since
> > then.
> >=20
> > NMI_MAGIC isn't a magic number; it's unclear if it's actually used by
> > the firmware in some capacity or if it's a holdover from copying the SGI
> > code, but in the former case it's API and in the latter it's dead cruft.
>=20
> it's used by firmware and Linux code to register the NMI exception
> handler.
Great, I'll put that in the message.

> Please leave arch/mips/include/asm/sn/nmi.h untouched as
> it's documents firmware NMI handler usage (even when we don't use it, yet=
).
"Yet".
This file appeared in 2.3.99pre9-1, and hasn't changed since.
I removed hard-coded assembly struct offsets, which we'll never use,
because we /haven't/ used them, and this part is implemented in C.
This file's my age, and these parts have been dead for just as long.

Yet.

--h7xzdhf5opgoap56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmNqd+kACgkQvP0LAY0m
WPGGpg//dLU8hnK9tZdfcpo5GV0ERzxD2jSaCqx+7GtOPqi06pMv+x1W9p+DtT+R
yjWlIz7bfhLM+cK9Foh9xE4fw6q1OMLMxj+OTAgHvymPnMKqw+eTKvNA5Pli46wp
knBbflMGUCyUT8y8U8vT7wL49xYTRsdH5h27yz+wjRvgaBYz9x8iExttM8M3pVaR
j7sbzS9U3I3/y4TyJ+jySOix3zGmB3J9gOcYIv2226tUUSLWHn9x7RHO593pbWEv
mGH+5sVG3jrCUZA9mriR4RI2ztrqse1RsvxSJYROJtoQh4so5zR0I796HHP+FLeh
i0aDcILPce0YFKO/3wz/XgntV5k1CK5s0niqP2aTcscM5DGJHjkjZvXnacQFYp/I
isf/2zz/XTmMuDehzC48hoGEkBtFFVIUm5JKiE361PxGtlh8EmpCLu1CN/jb/9Yy
ZcOWYsRWezri/Y897k/IpQo54iwvVCrOuQmCkhfrXyqoSugVUC3Y/G2yMEU9vMij
lz1c4e+FSzH8zZNqG06mKfo23JkFhJn5GcHKEdcqVrH/R18u+qEOue1Zzlamrqnf
D4W9jdUUKCkvGGSpxyztm1Vvx5kTvTWF1yJevCoL/uYRVFpiLbUzkptSI3Ww5Q9e
bU1YDGV3U1bCxT9a0pvGl3EzdN1fSf7cwDWsEae9agiRRS6+1UM=
=FWO/
-----END PGP SIGNATURE-----

--h7xzdhf5opgoap56--
