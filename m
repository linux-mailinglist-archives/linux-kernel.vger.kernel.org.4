Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6A06A1638
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 06:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjBXFZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 00:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBXFZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 00:25:01 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEAF4C6E5;
        Thu, 23 Feb 2023 21:25:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PNJHZ5RYSz4x1N;
        Fri, 24 Feb 2023 16:24:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677216299;
        bh=rhjdBJJMMUIf7pCqoU0gxsi3p+DJzGKwDndvV6hZbHE=;
        h=Date:From:To:Cc:Subject:From;
        b=ZUR/GpnveY2wsmX1/XlX9Qzw5Yy8Dv8ZgEYtqmccxl7Mk23UUtyoKXPCqrLpKKcK7
         lRW8o1ANhFECRY+5v1TJJVuPpUfVIHF6EYGQDDbYSRzjUbI/aM7YNHpf/Rb6M7eKJH
         6oZYKjWDtD+6awopCBariVNbuItJxvL74yenajbVEzyLuOguthPIbEaMAMwlSGcyU1
         t1M8Xyr2wivzniLGItxKtP/5KJMT2Do7n8Gm5p0ZXQIOsHce5gNxD5HZAqF+X2pGX/
         EYFkfDWOFDrQ55DBdSct7V1l0rfQrSmREFvg2u2XGTWoREGd90sANLvPUbOrbPP2Nd
         VW91Gd5mztmeg==
Date:   Fri, 24 Feb 2023 16:24:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the ntfs3 tree
Message-ID: <20230224162457.6ce06c1d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_UD7Ix0TK2NHdseVWXKLpO1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_UD7Ix0TK2NHdseVWXKLpO1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  893e952fe440 ("ntfs3: Stop using generic_writepages")
  529b4da2915d ("ntfs3: Remove ->writepage")

These are commits

  d4428bad14dd ("ntfs3: stop using generic_writepages")
  25a89826f270 ("ntfs3: remove ->writepage")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/_UD7Ix0TK2NHdseVWXKLpO1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP4SikACgkQAVBC80lX
0GxxXwgAm09D6NsD7ohgLkqrQCfC9uVVXS6rjsFmKVgSSukJwDUsfAIM86YWSWlq
lGArjxOy+2G+65klEY4+bHnqVSv96P8NdPknDMQs8HO2gliq7r+twAiJUgFf3xuE
XjwzgfMUDm79pSMTnoBN2ZEiIHno+PAPgYvWPUgbLqfrdkk/4cqjn5ERFg//uuJv
n8mrBVPw/ksWE6pn1T9t20aEfOvzTbTdUqGdSN+KAaySuRv2Cd0ru00g9SzUn+d8
MjNOIf4czM1b/pE6i+ppSyH0GatavkRFcqN7RI+IFPjPqw0HAX88xk7p39PVZpq8
8Br+tWqu96jLqG1/7aRB6DuCxCx20Q==
=paqy
-----END PGP SIGNATURE-----

--Sig_/_UD7Ix0TK2NHdseVWXKLpO1--
