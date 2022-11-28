Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759D163A02C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 04:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiK1DhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 22:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiK1DhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 22:37:10 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2AA10B8;
        Sun, 27 Nov 2022 19:37:08 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NLB3k08Ksz4xG6;
        Mon, 28 Nov 2022 14:37:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669606626;
        bh=bvBlrXIDKBHttLmLBQIxftmd1zZk2fvFGmTRXpNxqnQ=;
        h=Date:From:To:Cc:Subject:From;
        b=jHnwwmgp7FnzMRNiQJYiaYtbID6drPbxgffBQPZbVbQMa0F6R78XXp64m5JY5m0B1
         /jPN2BCoBrz8CMQBBCRL/fgWC60M+SscdY+wB+KAuHTfq45dlMMvdAKM08l2W1JDEA
         7lwwtOozPETq7kDoZJR8FyYtnmqUvTmzPj5bXx7vUd8eQjmzSO6Iaf0I9FCmJ/0kei
         1hguoR7jvTQ8MMx5c/BIZYuIQqwsR5aUFu3A6mvxF71kYIqwH8YVHcGeNHvY2dTK4M
         sAVt548hxxosy0O6Vkh8Oe1A8o8eYK/aBBz4cufq6GCCeV7YQQHI2VHmpzZdrF4R1f
         SrhZYgr9HTmig==
Date:   Mon, 28 Nov 2022 14:37:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the execve tree with the vfs tree
Message-ID: <20221128143704.3fe8f7b1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/S/x3kvRrkSP9t=t0VirgLpz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/S/x3kvRrkSP9t=t0VirgLpz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the execve tree got a conflict in:

  fs/binfmt_elf.c

between commit:

  9a938eba8d28 ("kill coredump_params->regs")

from the vfs tree and commit:

  8f6e3f9e5a0f ("binfmt: Fix whitespace issues")

from the execve tree.

I fixed it up (I just use the former where they conflicted, so may have
lost some white space fixups) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/S/x3kvRrkSP9t=t0VirgLpz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOELOAACgkQAVBC80lX
0GzKaAf/TucsqS0y9XoAxET3x8TJV+zAbXcmObQI+hZNVskQsZrUF2SaGPMUaJm1
xBl1CuqB3yCQ2xzWagfWlo+PU+eokSb9Q6E1TnIurH106W9LbpFe0AXUfqIpfzWP
pTUWdYztK26Evg4t9JlxX3cz7Qj8xvrkMGLl99zOfv8rY6YRLam9d62taDb643C/
Bp5cBHVaOnx+0kTQYnOghcb2NmFxjVAGpWNnOncQuw/RN/YgcTu4LUZElMZuOl4K
RTb45d2BM0HhOSAzc/t7uoYghWO6ZAKLKFpQfocbyg6Hq9JPjzyev9zRpppJFFqb
051hIBAnDCjH+ZMI31aeSc92Y3a/Bw==
=hyPR
-----END PGP SIGNATURE-----

--Sig_/S/x3kvRrkSP9t=t0VirgLpz--
