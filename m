Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CE66685C0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240310AbjALVpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbjALVpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:45:08 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05E85B15C;
        Thu, 12 Jan 2023 13:37:36 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NtHvg0km2z4xMh;
        Fri, 13 Jan 2023 08:37:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673559455;
        bh=QXmd9kgVPVbkMVfNnf7hMkTxRe1w/AdYH54oIsEdvMM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LoQHl/NTPT7R3fq3PU5dfiaVrUByV0CVfzDp3oViPZ98utU+GQxHPTaM/wYtPB4hw
         8Us2EfXEMYN6w3gJS/IcTVFOQkabyZFGsGwmjSjCgfo9+ySW9vd4zpRDMOygLwc+za
         m+7ioA4W1HDvhUNFB6G/it/1B5lTCkDEXXRhCCK4qjSE3jMb/Jtjk93eA+V6iiQFuq
         2WZ4QJuIZ0ej31Jy/8CwkxQgypSnZWYkeK88UNzCm9fk6ftclhbvBJrGW4SJkzE1/N
         M811lauLLXUW9EB5d2isP7LnmswU+zoqoG3GMJ5pGUXUQQg7zYCRMlP189mm37YKwS
         N5uDLltVYapjA==
Date:   Fri, 13 Jan 2023 08:37:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the spi-fixes tree
Message-ID: <20230113083734.7710b339@canb.auug.org.au>
In-Reply-To: <20230113082433.08cf19a0@canb.auug.org.au>
References: <20230113082433.08cf19a0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zkphzAuzB7ApQbNrtFGyK=f";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zkphzAuzB7ApQbNrtFGyK=f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 13 Jan 2023 08:24:33 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
>=20
>   1f4d2dd45b6e ("spi: spidev: fix a race condition when accessing spidev-=
>spi")
>   50028988403a ("spi: spidev: remove debug messages that access spidev->s=
pi without locking")

Those 2 commits are also in the spi tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/zkphzAuzB7ApQbNrtFGyK=f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPAfZ4ACgkQAVBC80lX
0GyhXQf+Lc7x4LIHlCCIIwgU86T7DXoK3MR2AG31EaAXwZPH7go6dz/4bVANwD/2
+tTRnec3yqAXVuGIkDPOk88ng43PuDZ+fqsGWm1lJdahzw3iCKydrP47L6E5GClx
m6QJWx6cPcCM6yaBwS9E5OXwtwibqjWoFDOOffkr9oI1aq5/z50TAr4q78ybJfRM
aRnmjrGh6yXdFK7DTU6Y3CG0wliFx/wsj8Pr0jP+JcwDAVfRrZIXhs0HnUa7gpP9
d5OlUk5i0uFazu9fPvF7QpaT5YmUmtCTpAH9w3KncsWYRTbdUjF9BOrmYJcklxUW
ctE1vJnugA9vfoVXhf6LMb4tKlJq5w==
=c5PI
-----END PGP SIGNATURE-----

--Sig_/zkphzAuzB7ApQbNrtFGyK=f--
