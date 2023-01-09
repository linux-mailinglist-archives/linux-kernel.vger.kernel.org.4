Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16252663450
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbjAIWus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbjAIWup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:50:45 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337881E3F7;
        Mon,  9 Jan 2023 14:50:44 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NrTgQ4M6pz4wgv;
        Tue, 10 Jan 2023 09:50:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673304643;
        bh=OvKztsoerse6l8exOnVHdWYPzP2a9WMO26vPOE1nJZA=;
        h=Date:From:To:Cc:Subject:From;
        b=n7wLU0kgho/TtH9pLKnEv8ZY/uVMn5QyIobxSvSqrXWQaf9ufiuoqXyIY+WJP5XYu
         lgDGLysG8/fyEVCWmZcGSV7xGe1Q43QG6StCWDRrIX05UKjlaaiJP0Mru3J1SmijrQ
         Dzau+tFWO5c6Cp2SpDcHyelY8dSk15TcenYyQo6N/0kFA7MVSKCsJfPIOZaJV2q+6G
         aty5Th7GB9PFaLR8sh+BBIQh//IMkZNCBFcORCDfs+q6m8C/mdjj/5pkBvmV2+n9tV
         UHNsCyTYrrRqyGcnMuoqtm8hOYMXA5Bbfhw1LBmZ1mAJVjGjyqMPYAse7vk0ZFG9pa
         0KQYcHGkQxIMQ==
Date:   Tue, 10 Jan 2023 09:50:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tony Lindgren <tony@atomide.com>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Juerg Haefliger <juergh@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the omap tree with the arm-soc tree
Message-ID: <20230110095041.0d6311d2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MerinwpLbe/lTj.Zhja5xiA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MerinwpLbe/lTj.Zhja5xiA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the omap tree got a conflict in:

  arch/arm/mach-omap1/Kconfig

between commit:

  67d3928c3df5 ("ARM: omap1: remove unused board files")

from the arm-soc tree and commit:

  609c1fabc7c5 ("ARM: omap1: Kconfig: Fix indentation")

from the omap tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm/mach-omap1/Kconfig
index 8df9a4de0e79,f833526aa7cd..000000000000
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@@ -118,8 -165,33 +118,8 @@@ config MACH_OMAP_OS
  	depends on ARCH_OMAP16XX
  	help
  	  TI OMAP 5912 OSK (OMAP Starter Kit) board support. Say Y here
-           if you have such a board.
+ 	  if you have such a board.
 =20
 -config OMAP_OSK_MISTRAL
 -	bool "Mistral QVGA board Support"
 -	depends on MACH_OMAP_OSK
 -	depends on UNUSED_BOARD_FILES
 -	help
 -	  The OSK supports an optional add-on board with a Quarter-VGA
 -	  touchscreen, PDA-ish buttons, a resume button, bicolor LED,
 -	  and camera connector.  Say Y here if you have this board.
 -
 -config MACH_OMAP_PERSEUS2
 -	bool "TI Perseus2"
 -	depends on ARCH_OMAP730
 -	depends on UNUSED_BOARD_FILES
 -	help
 -	  Support for TI OMAP 730 Perseus2 board. Say Y here if you have such
 -	  a board.
 -
 -config MACH_OMAP_FSAMPLE
 -	bool "TI F-Sample"
 -	depends on ARCH_OMAP730
 -	depends on UNUSED_BOARD_FILES
 -	help
 -	  Support for TI OMAP 850 F-Sample board. Say Y here if you have such
 -	  a board.
 -
  config MACH_OMAP_PALMTE
  	bool "Palm Tungsten E"
  	depends on ARCH_OMAP15XX

--Sig_/MerinwpLbe/lTj.Zhja5xiA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO8mkEACgkQAVBC80lX
0GycWAf7BkBy8+/53CoBELak+XV7Ky6Gj8MuopsD8I2mTVdErMTuJR1AfIPmpUil
hdBvRgJWJDjBHr8Uk0g2+ihEr8L6c1nGere0kgYxhLKJPsw9BsiSErQVU7lpdhH5
nM88P4trYsiGInoaAd+AevcQetsk3cVdHB+KxL24r8oFddCuVvfJgFSbcB9pVcQl
EHe3+dDL58rRnEgpbHTL0qspwiHo+D2tgcLqE1zbvrP4oKkIhsnc1gmVPEgUm8p8
Xnv+nraGDQEbuZJkbvPg/xa7T1jIOnqcerXS+Mv4Kyt04ka4EHbDMnbttZUqqfKh
9ciKFQEszdgG5Zs+jX+4mnPGz1LAXA==
=1UF9
-----END PGP SIGNATURE-----

--Sig_/MerinwpLbe/lTj.Zhja5xiA--
