Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E497D677296
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 22:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjAVVLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 16:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjAVVLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 16:11:44 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4185314E82;
        Sun, 22 Jan 2023 13:11:43 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P0Qs93PlNz4y0L;
        Mon, 23 Jan 2023 08:11:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674421901;
        bh=VFGyaZU0+U3IK6BxTu6hOnHkbgpKk2/+iVz02uUdkJw=;
        h=Date:From:To:Cc:Subject:From;
        b=XGrKQq2jKMBzZ8tfXEmKL6jsSTgxhXqBfygN7Tyd6/fr9h8NcdX08q4PPVOm/e/wo
         qXCiBR+HdGgCGVv9cFpnC4PaCwqfjRD8qPLnUWoCVev4t1UTpFfQEOmyt0LG/7MqlZ
         pGz0cGnh5iHSbcT+mJ4vi8ekgtmJZZgaWrlBume8aAWpe3KNPuf1+1mPEvrcXfwtnK
         QwsDDB/IU9W0mjkgVfm1MhbwQUhNJIb2xi64LrbX+K9bi4Es/Y5RJHxHXNq27E7ZF/
         JWIWmZpiddmCd675wGehPYqovF5eSQU11/QAzFc1iYeawQKnAv9XghucDbp+EItGZP
         AnDrUj4ti1RWA==
Date:   Mon, 23 Jan 2023 08:11:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the tpmdd tree
Message-ID: <20230123081140.4fbc0aaa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/z2B1ge5rnTbp_SmZ/LBHV8O";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/z2B1ge5rnTbp_SmZ/LBHV8O
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  07e8ac925f39 ("xfs: fix off-by-one error in xfs_btree_space_to_height")
  3f5948c5cbb6 ("xfs: xfs_qm: remove unnecessary =E2=80=980=E2=80=99 values=
 from error")
  42131102fd2b ("xfs: make xfs_iomap_page_ops static")
  650db86fa92e ("xfs: get root inode correctly at bulkstat")
  81e251490768 ("xfs: fix extent busy updating")
  8c06bf34e6a4 ("Linux 6.2-rc3")
  9b56a9ba5a17 ("xfs: Fix deadlock on xfs_inodegc_worker")
  b8314b7eee32 ("xfs: don't assert if cmap covers imap after cycling lock")
  cb714cbd5150 ("powerpc/vmlinux.lds: Define RUNTIME_DISCARD_EXIT")
  d48aa1d1fa3e ("powerpc/vmlinux.lds: Don't discard .comment")
  ed70c7b3cd7e ("powerpc/vmlinux.lds: Don't discard .rela* for relocatable =
builds")

This is clearly caused by a bad rebase of the tpmdd tree :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/z2B1ge5rnTbp_SmZ/LBHV8O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPNpowACgkQAVBC80lX
0GzC4Qf6AjX+PoAG6BCQtrAWlfGJ2JwvXmmuVpckImqd4guOZU8jqXT5ssqgnuVv
V22UkoytXtx9V+e3DTOG66vBTUQtDzpbJhRiFoT1YlFuRcW7fPotoVn/XuABEyhY
CTo8AY49MoRA13ZdxX/H1soh1OSmg9raPjafBz3ZWWQNiZjijvuETIDPN6fNQE5H
fcRHzKfoIec8x2up/KU2skrsjJVn4nrf4yElsRdohQUtDvqK4BsgDg1ElA7d30YQ
caNV2hmXTQhA37bNnVbAdMlkrqKzcIcBpspYbHhyyXDSEMMV24Gi/M8z/GtHqish
3aoAbWTO+3QQ+TPPQ6tmJUmdFXaUxA==
=iaOi
-----END PGP SIGNATURE-----

--Sig_/z2B1ge5rnTbp_SmZ/LBHV8O--
