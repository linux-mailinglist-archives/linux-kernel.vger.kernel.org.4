Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D33D6B6239
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 00:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCKXuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 18:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCKXua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 18:50:30 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB806A1EB;
        Sat, 11 Mar 2023 15:50:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PZ0651s8Nz4x1R;
        Sun, 12 Mar 2023 10:50:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678578621;
        bh=6zS9HL5+zOuldhKavorCuZk9Q4ILZQfJhOytuIRXATw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b+OwOxWgHgGY2pZp5OAHExX8noKlzcq1GnnqCVEdeI8xJUFhcQNRLqTAEBLbVDRvl
         hJNCsc6XoKSX1tZjUTXWkJu6L5wXOO4Ed+wVm+akFKnCBwqO2YQ8oi4sN7FiIMY8dC
         n2RZjaHvzo1/VK7Yu5FQebXFzrKosnarTUveIJGuaMlgN+uuDAA9YMcFJLrfOCtmpf
         u8p0hKN50JGGxq05UNWPS9nuVjAvCv6fjMANXV2qgVIO0dLdoZgFIFLCdTvBLchk5X
         pkmkV9E6cDqFOoz3LR3oG116q/DYHuLZaRAZaSwOyYYyfRxiLQJZeATLM8q3VvdHSQ
         r4EUhxmSQzafg==
Date:   Sun, 12 Mar 2023 10:50:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: linux-next: Tree for Mar 10 (drivers/spi/spi-mpc512x-psc.c:)
Message-ID: <20230312105006.6c46df35@canb.auug.org.au>
In-Reply-To: <ed382974-1613-8a60-913c-60cfc27f8ab3@infradead.org>
References: <20230310124850.245ba584@canb.auug.org.au>
        <ed382974-1613-8a60-913c-60cfc27f8ab3@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=UG9yRm=znQfNWeBT6YN1ur";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=UG9yRm=znQfNWeBT6YN1ur
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Sat, 11 Mar 2023 15:36:10 -0800 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> On 3/9/23 17:48, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Changes since 20230309:
> >=20
> > Non-merge commits (relative to Linus' tree): 2087
> >  2412 files changed, 75248 insertions(+), 89600 deletions(-)
> >=20
> > -----------------------------------------------------------------------=
----- =20
>=20
> on ppc32:
>=20
> drivers/spi/spi-mpc512x-psc.c: In function 'mpc512x_psc_spi_of_probe':
> drivers/spi/spi-mpc512x-psc.c:518:17: error: label 'free_ipg_clock' used =
but not defined
>   518 |                 goto free_ipg_clock;
>       |                 ^~~~
>=20
>=20
> on allmodconfig.

Caused by commit

  9e21720a4958 ("spi: mpc5xxx-psc: use devm_clk_get_enabled() for core cloc=
k")

from the spi tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/=UG9yRm=znQfNWeBT6YN1ur
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQNE64ACgkQAVBC80lX
0GxN2Af+NmlJrOkXtoSL2eIJ8S9gKvRRSQyzncI0XlaWLVl/b05pc7Z467B8Hbdf
qLv99bVV0fHWJFHFdjO14fjUEJ+sJspXoERFGcsjResQm3bhG6yauG2PCo2FSyBP
2/aLAlllvUiG5XXata2/GU0yTl4GXArZAYsWm/9g5UFDLczr4apstWNc1R+tzBVJ
135cYJ4W+uN5gxjH5JY81zNSIBSMdGw4amItwoMpO1N9TvDrmgU5GbGPaEuwXMWo
xrS1FBToLNSWPAy3/CjzKiNJEe00jEnyAY6C3tBTw3xUBg6zY/Vvx0ohO6Gzd2/I
vRZjsJ6tfXbTQzi0sfnmIZ/TvO8QFA==
=ISA1
-----END PGP SIGNATURE-----

--Sig_/=UG9yRm=znQfNWeBT6YN1ur--
