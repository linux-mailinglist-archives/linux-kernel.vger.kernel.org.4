Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7306D6C7587
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 03:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjCXCVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 22:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjCXCVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 22:21:08 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CA62A175;
        Thu, 23 Mar 2023 19:20:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PjQtC4WRmz4xDr;
        Fri, 24 Mar 2023 13:20:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679624452;
        bh=exnALh0tsJi9M6nMCIRST+svU39hd/lV5lwtMCzYb7Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fw5oiDSwrE21yxyXMzXqICEA5qlqI0QSNIXfRXBWrqmvms1zfvCZ22pDBFJuAuNE8
         gpZCBSdM+0wL78lsq5wEHyATQRbW5VL88DI3cMoFR4GUaBBSJo5LKvK2+Lx8whg8AA
         QrhYcttHOOfexpiWEItTamBkQ/FpOluYdmk+gPthv2IxxRAfVOGM0c3Ioxi7V+OYke
         9E9xVPdCKQovvlEoO0DIHV3nXHBXHl4N9y7fu6RpkMdsPMGki7dfo5lkbaDg+PgR/z
         5EM/imjxpAouDdkJ3kWFvnqdrCzgofmjrXb7h4+V+PISI7ihaXy9YZlhspHwDHaeiV
         prHPJ+moot/fg==
Date:   Fri, 24 Mar 2023 13:20:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tpmdd tree
Message-ID: <20230324132050.050d4780@canb.auug.org.au>
In-Reply-To: <20230321115413.106fa139@canb.auug.org.au>
References: <20230321115413.106fa139@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/F4VH1hU34KpDmZLtMkgTgJN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/F4VH1hU34KpDmZLtMkgTgJN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 21 Mar 2023 11:54:13 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the tpmdd tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>=20
> drivers/char/tpm/tpm-chip.c: In function 'tpm_amd_is_rng_defective':
> drivers/char/tpm/tpm-chip.c:531:15: error: too many arguments to function=
 'tpm_request_locality'
>   531 |         ret =3D tpm_request_locality(chip, 0);
>       |               ^~~~~~~~~~~~~~~~~~~~
> drivers/char/tpm/tpm-chip.c:35:12: note: declared here
>    35 | static int tpm_request_locality(struct tpm_chip *chip)
>       |            ^~~~~~~~~~~~~~~~~~~~
>=20
> Caused by commit
>=20
>   923c8dfa9a36 ("tpm: fix build break in tpm-chip.c caused by AMD fTPM qu=
irk")
>=20
> I have used the tmpdd tree from next-20230320 for today.

I am still getting this build failure.

The commit above is trying to fix a build failure that does not exist
in the tmpdd tree!

--=20
Cheers,
Stephen Rothwell

--Sig_/F4VH1hU34KpDmZLtMkgTgJN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQdCQIACgkQAVBC80lX
0GwUkgf9HZbQTnYxg5xw88OvtOnQPi8MQzOX0HQm4fOlljM3/1dM5PCQQ85ja4qo
9/L8lH1OQvIiajmZ59gjI7k16QWhKty9STzLanV7OZdo43Gh67DaTWU7ptil6TjR
B8Iu7ycE9/fYCyQ06iLy6E3CyFLamPB1qjgAzi/PAaz7lUJYVNAv0JEhFSH2yT+j
Z2E8AxopgYSimQttq3zHlYlhT5Fol6HJ/HnkfWEgp2O2AiHI+5CGJbcjcdieN3aw
6HcHIaI1cmjjogksmrxK/u3IIyssj7oSozkRkDMipBEPg+4DGDzUXfMjSeCKZUKR
mB9O19XwtbnG1OVJFu827Uc4y1TtQw==
=6lFG
-----END PGP SIGNATURE-----

--Sig_/F4VH1hU34KpDmZLtMkgTgJN--
