Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9A0746AD0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjGDHje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjGDHjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:39:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F371CAD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688456368;
        bh=P+FUOIhz0bX95blpopj9Ibj5PvGgg0G/xLUG2zFsXz4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NLC6zO3HvahQO2FBmOS/EmIMBg4wSae0nlr8wuZfU7bVi6OG1oYuknfBxTnf5xfxn
         S+GY3struMF5M4may2oOylMdrgPiswxiW2M4nltBb9stIDIblxwuCHRYSaDQH5bJlW
         5ODad07AGcDHJKPCtPlqDIdqvVZb1SQgU5tsZOBpT0Tl00Na6PVpPaKMvqOR+zEfAq
         I3mgA+Pz7Y27/XwXEi0PCk9k1scJ0wXoyAOHzfy7VLahwdAJUiTgJT8rbMJpBs4Ura
         J3yh313oN//eBNPC2PvsK8IkOiEb1glx4tn7Xcn3DLjBjF942vPE5yOSnFdko34B5w
         4awRfTNOaA21w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QwF6m3Mcjz4wZw;
        Tue,  4 Jul 2023 17:39:28 +1000 (AEST)
Date:   Tue, 4 Jul 2023 17:39:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] MAINTAINERS: add linux-next info
Message-ID: <20230704173926.4e36b414@canb.auug.org.au>
In-Reply-To: <20230704054410.12527-1-rdunlap@infradead.org>
References: <20230704054410.12527-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/E0GL_0heHxoeB00p=7w4IuJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/E0GL_0heHxoeB00p=7w4IuJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Randy,

That has been a long time coming :-)

On Mon,  3 Jul 2023 22:44:10 -0700 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> Add linux-next info to MAINTAINERS for ease of finding this data.
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  MAINTAINERS |    7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff -- a/MAINTAINERS b/MAINTAINERS
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12067,6 +12067,13 @@ F:	Documentation/litmus-tests/
>  F:	Documentation/memory-barriers.txt
>  F:	tools/memory-model/
> =20
> +LINUX-NEXT TREE
> +M:	Stephen Rothwell <sfr@canb.auug.org.au>
> +L:	linux-next@vger.kernel.org
> +S:	Supported
> +B:	mailto:linux-next@vger.kernel.org and the appropriate development tree
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
> +
>  LIS3LV02D ACCELEROMETER DRIVER
>  M:	Eric Piel <eric.piel@tremplin-utc.net>
>  S:	Maintained

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell

--Sig_/E0GL_0heHxoeB00p=7w4IuJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSjzK4ACgkQAVBC80lX
0Gzlfwf9Fyycvnxj+qOy6DOhMP0DJZaS4Rpfb6jqflMKnQA7J+stPjqG81Yg4d0N
K//vHQDMu7UdkvGCuI9tanbvRdQIc9VOGN8TT8cYqFKF55ilsOOqqRnCeb43DPCV
HqnbcSu99UGrYG5uBJ8Ubv2GvenWWz8z1UY7GXVJO7d3NdrON9vCaGwjLeLeEmuO
IQK5ILV/bj5ABYgubO0/7QZdieZGUkfOZ5nFkWK9Ng6kqyUcjouDLCeaFsMM++I/
zpNmMwKqtV0iP4ofGBHbGj6fiK+UbtN4odLvw7PPlRgGfDL4PT3o6AX17Qex+Lir
yNGtcGHaU4Bjfqe0Vk6gXv1EbkYiIQ==
=kUT/
-----END PGP SIGNATURE-----

--Sig_/E0GL_0heHxoeB00p=7w4IuJ--
