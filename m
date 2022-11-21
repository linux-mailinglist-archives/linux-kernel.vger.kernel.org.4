Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905B06318B3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 03:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiKUCqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 21:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKUCqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 21:46:23 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC9320360;
        Sun, 20 Nov 2022 18:46:21 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NFsGM2WTxz4x1V;
        Mon, 21 Nov 2022 13:46:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668998779;
        bh=/74fFkbzdU4m3aSROJGwJUqVTGMlW34lthkjIqsq9tQ=;
        h=Date:From:To:Cc:Subject:From;
        b=pDY6hhySnzwSahYYu+keTU0ecSCpyyrPy350Z5PX9Ezt05yJyHUDB10pvO2/JVHHa
         08k2lnIEXlT6NEj0S4ZJQPnXhSWE30CkFlYY2rwfrcYf/s3l4xJ63oDpUWvpN/TJ1b
         +pPeQt9MHC0uMtSFJfz7CO5ZcZsBukha0X4N8+BZBTtY2ITnz3T6LS4BIB8iia0wZw
         N3iYeE9RitMD/ZHtAsqsGfXZ9x6vhaG9vh2GW1PA17zjkgDxcBMLQc3ZTrWiy9qyRV
         EbGJ37Czx57SZ5iATMnFx4PkquluaMqC1xG5FtZORpvjhVzSGmtlAchyOEAT9XR/jI
         bssVoJN2mHTwA==
Date:   Mon, 21 Nov 2022 13:46:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dylan Yudaken <dylany@meta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: linux-next: manual merge of the block tree with Linus' tree
Message-ID: <20221121134617.7eec695a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/E.iXFjAAJdD=BrK6+8bq1p8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/E.iXFjAAJdD=BrK6+8bq1p8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  io_uring/net.c

between commit:

  91482864768a ("io_uring: fix multishot accept request leaks")

from Linus' tree and commits:

  01661287389d ("io_uring: revert "io_uring fix multishot accept ordering"")
  6488182c989a ("io_uring: remove allow_overflow parameter")

from the block tree.

I fixed it up (I just used the latter version where they conflicted) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/E.iXFjAAJdD=BrK6+8bq1p8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN65nkACgkQAVBC80lX
0GyxMAgAibdOYxXZKnenSwTJHrD18Ub1J2unLr+UXETHKz1w8j0oMz085+j9GQYc
Xzoa+gDSH9IqBseH8ULgmywFICKJWMBBMT2pVbyTEszV+/Ib/zM+z6shB9oLAf9A
47Jzs0rWsKbISmQESCKe4tjZ6XCkeLwcCrRkG4x2jGXYkTAVmY6ZHVaSBMLNkjdq
JMTJf0L7xtB3V/AWu4akhdyJWUTgWWl2cli5axo/FPI4CfoI4MN3MEUNn9RADNEF
aB8MggQwpeAzmFpCu/QFwWRY3iF1SIWct+gEQuDJCscSrXAeSacpNj2SqQINabJJ
XgdWlbnwPqu2/2EZ8wk/+5jWOn/Khg==
=vYU1
-----END PGP SIGNATURE-----

--Sig_/E.iXFjAAJdD=BrK6+8bq1p8--
