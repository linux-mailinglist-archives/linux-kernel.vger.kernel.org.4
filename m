Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BBF64AD71
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 03:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbiLMCF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 21:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiLMCF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 21:05:26 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523D217881;
        Mon, 12 Dec 2022 18:05:24 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NWMJy5g0yz4xP9;
        Tue, 13 Dec 2022 13:05:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670897122;
        bh=8gpohpkKaPEZLK0i7Vn/D1MJecGEbxxND6wGrwvVEIs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EcpGbiIboZ/k1QOIyMCk6GecOqmLCs0iD2mPe4H9FA227wnDgs34C5AMQJHX57j9v
         nD4RfM8L3LCrWWEewNyFcLF7X/SEYCiPyLDVn2BqsnHcZJ+ezIn1Hx6dr/ymX8R2Ek
         rHWmjMH2AtxS/PLZIpBdDkHkEeAsiccGDgOADM3bdhILfs0pfFgVHn4Z0pC+/ZBTTI
         E0BO15tB8/Rh36MUaOuG0nyI/37j6Lb4OEK4OeFtvmkYOL+vcW3/PCS5Iveq9VQJQm
         /eD9+W/C34CEvWFWWqtO8WCLH70Zqf/W+tl5+dclOcL5lX/XqUAyjfHqOIE0LI/CiH
         1ONgBAoqPqldw==
Date:   Tue, 13 Dec 2022 13:05:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: failed to fetch the unsigned-char tree
Message-ID: <20221213130521.5a7af75b@canb.auug.org.au>
In-Reply-To: <CAHmME9oT+g2oSRK_1s4+dUmBOW9LTVGuT8pYByp=k2YzAc9cpQ@mail.gmail.com>
References: <20221213115125.51bb83ae@canb.auug.org.au>
        <CAHmME9oT+g2oSRK_1s4+dUmBOW9LTVGuT8pYByp=k2YzAc9cpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dem81hDXNVmd6TEATi4UHyp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dem81hDXNVmd6TEATi4UHyp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Mon, 12 Dec 2022 18:43:20 -0700 "Jason A. Donenfeld" <Jason@zx2c4.com> w=
rote:
>
> Was going to write you this evening. Yes, the tree is done (merged to
> Linus'), and so you can remove it.

No worries, I will remove it.

--=20
Cheers,
Stephen Rothwell

--Sig_/dem81hDXNVmd6TEATi4UHyp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOX3eEACgkQAVBC80lX
0GyNSwf/f2Dr8gDqd1uVYM4a2VZq7XzD2zd3u5I4M6ehTd24Oy/xqAQDE68OIu5X
0sDQ2Qy1x79pf8UzkUnn7LsCrzkifhxYXReddYHOs/KmyrZLyTicChGZ95d8BNjx
1lC4lpMkrif2dDr+lXK1Nnz9zkQIjcJJNHh8teaBLFqMFzJO+id267PZlkUqH19U
4CUhdzSz/6cLzM4JS7dQuJ2KDNkDgKKu4Q1hPpxQ+cIDwblW5jiF/g0+zZ6HSUq9
Yby/OXIkUPwC/R/KPN1ew7Lj9SnnaRqoF6iCcAeSYp4ZJ2U3wM274wEa8fFOBE/M
itBVv/xsPDhku5ruSF7vzC/iJXE0LQ==
=XW7N
-----END PGP SIGNATURE-----

--Sig_/dem81hDXNVmd6TEATi4UHyp--
