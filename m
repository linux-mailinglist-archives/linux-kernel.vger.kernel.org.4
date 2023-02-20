Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B3269C3AA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 01:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjBTAdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 19:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBTAdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 19:33:37 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E83FA25B;
        Sun, 19 Feb 2023 16:33:35 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PKk1B1sVjz4x81;
        Mon, 20 Feb 2023 11:33:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676853214;
        bh=ApASluTziQDk9afKuSHsqgBJh+IGSZg0ib5EfoC4bn4=;
        h=Date:From:To:Cc:Subject:From;
        b=ri7gjoWHnYTWAqqnMufNhuvYY6/bKwvwr1RBxo7cc0d98VOW2Z6nifMLl6s2OckV5
         wZqrGhX/rEAc9hHaUT53g4ijipKNbm4fFf+6amvyXQ6RfxNJ/QeOhWnpZmpoLrqLOJ
         W+VIOmEsGv5QL7gE2+eBsxXGgSaEji9OXR2SqhP4QMh/3jiFaCj6mhnGnwT4+4daEi
         VEUuzFTChIX9OzXVqr0Wsc/QNYGxBLCx/UQOEpSWXuF9QmR0xHer3L8qZimbyH1NF9
         D/yRs4tzRJMbbrQ1PuINkE01rD2e3q2fZdKHeyjiEhHkeXvWi0t/VAhDlleELXdTtV
         jiOK3kZQwqPOw==
Date:   Mon, 20 Feb 2023 11:33:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: linux-next: manual merge of the block tree with the cifs tree
Message-ID: <20230220113333.16a38bbd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Fqt4cW+V3nFgtx/_pEaFB=K";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Fqt4cW+V3nFgtx/_pEaFB=K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  fs/cifs/file.c

between commit:

  8378eea2e41f ("cifs: Change the I/O paths to use an iterator rather than =
a page list")

from the cifs tree and commit:

  45b94876f54e ("iov_iter: Kill ITER_PIPE")

from the block tree.

I fixed it up (the former removed the function updated by the latter,
so I did that) and can carry the fix as necessary. This is now fixed as
far as linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Fqt4cW+V3nFgtx/_pEaFB=K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPyv90ACgkQAVBC80lX
0GyUPQf/WBWjv2MKg8Ynn1fAUhwsLPQoJgyQoJ27UxcE1xR2K2zthmgLE75RJwYi
aMWNeFNa1D/EHOXwn0jjwQua8YVJanGmCv2kuYw3vF20ltydphsr2noVWtmH9uXZ
ZW6BIrpNdFiCQ/wuCbhDDdW2WjDtwGti4pAhx69nGAsbyZwJDBJUz9N9FMtyIwNl
WowZu/68csxYMfWZMAKMF53DO8eIUIxPLnlD8SEr8hETHUfgNS798FeLxZdZLlo7
zlBuVa69+sT8LLLkQlec3mO7KpKv5o/vrflQ/TG+yW04cBtvux1sv3qoRQ5ih7N5
qVE2Pvs49FKqHQChoE8WOL639edszA==
=F0GM
-----END PGP SIGNATURE-----

--Sig_/Fqt4cW+V3nFgtx/_pEaFB=K--
