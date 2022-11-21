Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0982E6318DB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 04:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiKUDUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 22:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKUDUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 22:20:19 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F7632BA0;
        Sun, 20 Nov 2022 19:20:18 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NFt1X0DJkz4x1D;
        Mon, 21 Nov 2022 14:20:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669000816;
        bh=16AM/+wdJvZHFRUEDz16oCj710GWv8k0bxYD89hl7Wc=;
        h=Date:From:To:Cc:Subject:From;
        b=RnTUiXYOVBgjEIHUwcg5rhoYt5O0EchLUWOcegIlLhmEkllm3T/OWeCVhPyXPuZx+
         b6AoFVMYK8jnGKwTWuy1bMyE/Rax/r8LaGJKAVjU15SRFJlIFKcF5UCf8ftHzCx/en
         o+wWU3113uUB1dn46Y2fSkvh3m+UW8nRJNlk81FsomNzNDjcHJAY4I+XeKs5kjmuj3
         YKgcgXVRo9Q4l6fYH0SZDnm0VrtfNGLpp5U18QmJx7y/sU8Sjtf0JuDS/yrKfYiBGU
         zQXjJ6bE+XZGuHn+St5pMy0UcapVgwPJHyJA4lOwQLLnGgsvq4KCDKDFx+VO5IJe3H
         eCax7c7Td+plg==
Date:   Mon, 21 Nov 2022 14:20:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Gaosheng Cui <cuigaosheng1@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the security tree with Linus' tree
Message-ID: <20221121142014.0ae7c8ff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2QCuX=a+BnI3/e5VWm+HwLb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2QCuX=a+BnI3/e5VWm+HwLb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the security tree got a conflict in:

  security/commoncap.c

between commit:

  8cf0a1bc1287 ("capabilities: fix potential memleak on error path from vfs=
_getxattr_alloc()")

from Linus' tree and commit:

  f6fbd8cbf3ed ("lsm,fs: fix vfs_getxattr_alloc() return type and caller er=
ror paths")

from the security tree.

I fixed it up (I just used the latter) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/2QCuX=a+BnI3/e5VWm+HwLb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN67m8ACgkQAVBC80lX
0Gyhawf/U5EJj+aylv5HycPOhAsEkOSpqqT+bNZWLLKp0mmpeOYseEorogQYxseV
/Zj0DNKu9EYXWPXicoRRsTomxzKoH5sbGBLfWggLd8sJNQsFethQPzuZWzC/bANq
VGMNHKRKwo47LvBoMdyVg/0SsLmJeaWl0Bh5gd9guAYEe22fkO7xYfR5gRBB3CAJ
61sILPDicluX4ewGXSzLANAhTRHu+Af/LzP4WG1Ao+62JVB14jIQpvj/+8ih2i+k
ivnKDJbvyr6RmUluLJ89NCHe29TryIdeXWlNwzyKn3NN+mTvrWl/OTdXC6EhUoxV
KIOc3jx6zYF1EhS/Mc/0tHcCnEEnlw==
=fCSw
-----END PGP SIGNATURE-----

--Sig_/2QCuX=a+BnI3/e5VWm+HwLb--
