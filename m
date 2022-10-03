Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619385F38B1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiJCWQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJCWQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:16:15 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603A34D254;
        Mon,  3 Oct 2022 15:16:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhFXm2JWFz4xGd;
        Tue,  4 Oct 2022 09:16:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664835368;
        bh=/ywn/hJ/rhTn2xvBQYEHB9QtHev1+jTnleFfK94jVz0=;
        h=Date:From:To:Cc:Subject:From;
        b=HZa29eeGup4/9cpjWUxrvUoxeahZgkZrk/zR4ACYDDP2vjPucOseIaUZi/Tjij/10
         z6pWIg24yMJb6S6gHVDS8wgKq4hr7XdbwiVin/Vhb3mZ2qndcoIKBDAvzr0hy1qZE+
         X1fMVeyVokgUfnFlei5pAl431oKJNpbiXYV1JT3/BzCB1nstpLFbjbLLb4/vxlWOFc
         JTMH05uPwLxs5LHkCOo/daV5hsj9WWX4KWT+6qWHFj1thUZa3+VSzsRpx1n1cX+IKn
         sxgAj0hM5+3TkqvpYPBNLa63e14Av9c8zew0fkm+VvaoA5iN7+KiN+gNYrxmnWZ8TS
         +lYic6ne/3LHg==
Date:   Tue, 4 Oct 2022 09:16:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the powerpc tree with the kbuild tree
Message-ID: <20221004091606.71418ddc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9HMZ9obeKa+3ea5v+n8bH7G";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9HMZ9obeKa+3ea5v+n8bH7G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in:

  arch/powerpc/Makefile

between commit:

  ce697ccee1a8 ("kbuild: remove head-y syntax")

from the kbuild tree and commit:

  dfc3095cec27 ("powerpc: Remove CONFIG_FSL_BOOKE")

from the powerpc tree.

I fixed it up (I used the former version of this file and added the
following merge fix patch) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 4 Oct 2022 09:13:46 +1100
Subject: [PATCH] powerpc: fix up for "kbuild: remove head-y syntax"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 scripts/head-object-list.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/head-object-list.txt b/scripts/head-object-list.txt
index dd2ba2eda636..e8219d65c3b7 100644
--- a/scripts/head-object-list.txt
+++ b/scripts/head-object-list.txt
@@ -34,7 +34,7 @@ arch/powerpc/kernel/head_44x.o
 arch/powerpc/kernel/head_64.o
 arch/powerpc/kernel/head_8xx.o
 arch/powerpc/kernel/head_book3s_32.o
-arch/powerpc/kernel/head_fsl_booke.o
+arch/powerpc/kernel/head_85xx.o
 arch/powerpc/kernel/entry_64.o
 arch/powerpc/kernel/fpu.o
 arch/powerpc/kernel/vector.o
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/9HMZ9obeKa+3ea5v+n8bH7G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM7XyYACgkQAVBC80lX
0GzpvQf+P5/iiucN2fRIfc3bLL+7KzxSdMuT1y/bgbpO7Zb2eO1zqdfJiuioOTPm
Gv9/OT/3RRZDty764WEwdyvLgnLoz/G2cfQv8kJ9UiR7wq8qVqwpnvedWnfMpIgi
Vzobx5AfhtAKR80z/ouKwa8T5GzEOfNkJK0DtAKrSi4NGPYqjcDwTdhJqLP8QxJE
eMOROgBNBgsJNJzgx9YhgwX/zBAiU7dIe+RAh1CEbyBEjqM72X34oLlhXQ1Qr6r0
76NJgMJEHztLLNDoGBRRu37qz6ZB+VU/cMBc+c/18lV2B85+Hf+Z8xeayogRqdvX
jBAIEBTQ0B8XSUxx1ljyolb3kV+xrA==
=qf9g
-----END PGP SIGNATURE-----

--Sig_/9HMZ9obeKa+3ea5v+n8bH7G--
