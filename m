Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44792736023
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 01:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjFSX3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 19:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFSX3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 19:29:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D23E60;
        Mon, 19 Jun 2023 16:29:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QlQw55Yr6z4x1R;
        Tue, 20 Jun 2023 09:29:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687217381;
        bh=jhOVKnEaZMKjBhqSPop9rv8my2xjIJo0FpFGz7SVjzI=;
        h=Date:From:To:Cc:Subject:From;
        b=hHWzihn8uzpZ6QnKUnzsup620Vb0uPJHv1yuSTCR7k2bMHos6mOb7vl+8h/0wTCU/
         zIe5t+3jK783KLh4N/FO7efoaHR//YzhyNN2B1l7KLJZbtk2MlziCSnC36iQCiiHEd
         NE0b34WT6+1TE4QWDzqVUeN/XOdUx59UuFoLNaQHENzQKwjNYLVbvnRrsnxjr6JFTR
         z+sL9OPkw56Zw4YzEKSZ3lII1tbLOuw+SbCXlSorrDWiKCMvtSROd1YQfKxMhVCKwe
         N1tFYLV3OAfaE0SJaM4JB9HI8k9LAF6LMZTG9RtfUjva/EnjDWvRhWhKNFoc2pYNnW
         lpQCveDgiih0A==
Date:   Tue, 20 Jun 2023 09:29:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: linux-next: manual merge of the mm-hotfixes tree with Linus' tree
Message-ID: <20230620092940.3597ace2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I+YfrT7_wMEEU0v0N8q3VEq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I+YfrT7_wMEEU0v0N8q3VEq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm-hotfixes tree got a conflict in:

  fs/afs/write.c

between commits:

  a2b6f2ab3e14 ("afs: Fix dangling folio ref counts in writeback")
  819da022dd00 ("afs: Fix waiting for writeback then skipping folio")

from Linus' tree and commits:

  4f243fa208e8 ("afs: fix dangling folio ref counts in writeback")
  c548e38a7cc3 ("afs: fix waiting for writeback then skipping folio")

from the mm-hotfixes tree.

I fixed it up (I used the version from Linus' tree) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/I+YfrT7_wMEEU0v0N8q3VEq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSQ5OQACgkQAVBC80lX
0Gys1Af/fqLgPnhsAaN+TlmHLbrHXQkbgXKiluCYcUO4GDgKsc7KAzs7f1J+kg3a
kuLuppsP5/swB6XbjI5SxCduWRVmFsEDQqEGc8+kgZ9gTPRB8g6jdu4TbO+Pgqgo
mhB+b9A3v/UAItAT4WzLdXE8zGVXqO3NyS3sv8s4p0076wB6xxJZYBfXGyZYw6Dj
7cywcnisbOkgdT8EGnVJiMqbqGWEAEjqjEMuS3nkEwRltw/UTTzdPVw679hSy5+A
8jwjX6XAVht8LdHHojU/DC9r4zVqVGsPiVV54OaCVOW1jajSKUeOIeUbQXROQCTO
/B8JnJSk1uatMb1D75Zg/igdtMAC7g==
=ba9P
-----END PGP SIGNATURE-----

--Sig_/I+YfrT7_wMEEU0v0N8q3VEq--
