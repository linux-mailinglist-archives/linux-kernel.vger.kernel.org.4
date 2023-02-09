Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515FA68FDCD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjBIDOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjBIDOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:14:21 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CF112A;
        Wed,  8 Feb 2023 19:14:20 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PC25h69wQz4y06;
        Thu,  9 Feb 2023 14:14:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675912459;
        bh=87y5GNlJFxxI3vcUFZFlyaffXDazXgygOXWFk5kOo5Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OXRXlSglBu/npIp4wPMtJ4tSuhLQuiksNivayYfmRQ+wm/AuRLvzq5NUj5vpxourw
         +sGuVyxJZRRzo+b9QTkEU2ezXORhaSGfETXdEzPiNuXYNo28j5CBUPGVnULmkiclOe
         skFcbAojdiGrIwSZwurehPR9PifoLYwOIMTybih9bxwH35d8P+02ma/cm0HEND64fh
         c6ASnUMuhg06pe3Rcme2X/LhI14Cj+F3vHX2hwywa+Jkaz1Bcw9myEga9bM6Bvntmi
         BxgNHm0i1qSrZ0jO1pPDqNyunA7dgw6FZE/ZfLDsZu+i42ccicFd52otpmzRKbbbPK
         rKjkL8/Vz2e7g==
Date:   Thu, 9 Feb 2023 14:14:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the sound tree
Message-ID: <20230209141415.1e3cd221@canb.auug.org.au>
In-Reply-To: <20230209104823.45899e76@canb.auug.org.au>
References: <20230209104823.45899e76@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//IaMES=yrCWTZzYHZExL0Xj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//IaMES=yrCWTZzYHZExL0Xj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 9 Feb 2023 10:48:23 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the sound tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
>=20
> sound/ppc/snd_ps3.c: In function 'snd_ps3_driver_remove':
> sound/ppc/snd_ps3.c:1049:13: warning: unused variable 'ret' [-Wunused-var=
iable]
>  1049 |         int ret;
>       |             ^~~
>=20
> Introduced by commit
>=20
>   25a5a77ae0bc ("ALSA: core: Make snd_card_free() return void")

This became a build failure in my powerpc allyesconfig build, so I
applied the supplied patch for today.

--=20
Cheers,
Stephen Rothwell

--Sig_//IaMES=yrCWTZzYHZExL0Xj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPkZQcACgkQAVBC80lX
0GyjiQf/WHte8E26YzJaxZkkn7cbtyGzw1XHUA6W1haf2e/LbVAgz5btRMn1v79z
8m8rRzSi4WU6b2x0bB/kZZuiFtxtIFAtVd7e2BpUJUM3O9BV7CK8gOOh7CTYK0ou
1tNVH59ynJrjWHspZrgwlIlgw+v0mr5pINb+EF2niRWmK1oTjDklr+rVYJJWjH2+
G9kK0txkxUU2OvXlY8dcX9r/rp8UpERy1aHDibCAZv383zDWkdd45MiynoJqukHD
DVp3Y+8kQ6Z9hHAK7Jgcz4lPv8ptvgRsnxJGkgF/gBDtnRho1fRzUxKjwn26E9td
ZguYgtBh1RQcaSO9A2SrEBIGWsBNGQ==
=db3x
-----END PGP SIGNATURE-----

--Sig_//IaMES=yrCWTZzYHZExL0Xj--
