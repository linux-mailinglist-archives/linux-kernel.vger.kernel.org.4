Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE6563E5DA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiK3XzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiK3XzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:55:18 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A9526D8;
        Wed, 30 Nov 2022 15:55:16 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMx0954xdz4xN1;
        Thu,  1 Dec 2022 10:55:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669852505;
        bh=wjSyXhJqjg3XQ6u/nMMOLaIbGfciTKIS2WdgtnLluEg=;
        h=Date:From:To:Cc:Subject:From;
        b=HcYBuLDZfKCTinnWmwHbhVmLjj6syPBxQSqEA/WWzt2p86ZhW0AQCExANsfooVU0t
         8JZ8aKAC8lmfPgie/YEBmOeiifQaH4RrW7JzkisnmZQfcbUypGswf5lEYIOBuDr6AC
         mTRX+oVJF/RZdLMDWlic+wZR4tDoGGjqOe5OsbYUO5k9HVhJ4FhwG2ailQlGKuziRk
         xlZVL7JSRl8fB84lPOwB/sWLM2C5zDn1ItvsKg+a0FtrZ/0ja1GGbkipKISKuk25xh
         JN0Zdv9QVeI51qYJjQR4b/y1uw4LRBc+CCOq5xbrS0n2m0KWw5ZICeq5/8/a2R9DTE
         FhqrxGZrsbEbw==
Date:   Thu, 1 Dec 2022 10:55:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the rcu tree with the printk tree
Message-ID: <20221201105504.71c318f0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ny5NuynQG_ROh8XH/p3vud8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ny5NuynQG_ROh8XH/p3vud8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rcu tree got a conflict in:

  kernel/rcu/update.c

between commit:

  64e838679e14 ("rcu: Make SRCU mandatory")

from the printk tree and commit:

  0cd7e350abc4 ("rcu: Make SRCU mandatory")

from the rcu tree.

I fixed it up (I just used the latter - it kept the WARN_ON_ONCE) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

Maybe you could share a (non rebasing) topic branch?

--=20
Cheers,
Stephen Rothwell

--Sig_/ny5NuynQG_ROh8XH/p3vud8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOH7VgACgkQAVBC80lX
0Gy70Af/c7c+pBTLywaOBuHlGPKhfQ6NB3rWMMFTnLUwcQYMLR9OjdZO/PUDLhIE
IrGqRsP+Q8902n1qAxJ8P1LmmoerRKXPKLaA7zH+Py/N8oNROofecQNcDV69riBY
yrTlGX7+mpw1a0VK6fiUQb3YJLd6msfzlS3AkoxAFBCZufdCFcJ95RpSqiF40ZSG
XFMW2cTlcvz9wh7znqLIW0tLI/uE8LHAJL3aufPkuwuMEZG4k0cfnCXy6T1rCAGa
+y896PqSLGmXIUSnLN6TIPtKBpgrqeCclx5kR1kg2B71PBkKdvLtAIW5HN2AtIN4
LLAEnkAfmzzJoqRueMssSN1i/HO0xA==
=JFLZ
-----END PGP SIGNATURE-----

--Sig_/ny5NuynQG_ROh8XH/p3vud8--
