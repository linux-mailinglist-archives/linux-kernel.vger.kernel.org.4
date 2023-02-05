Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2662568B241
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 23:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjBEWs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 17:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBEWs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 17:48:26 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909D41205B;
        Sun,  5 Feb 2023 14:48:25 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P94LJ1LQHz4xP9;
        Mon,  6 Feb 2023 09:48:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675637304;
        bh=zK2oP2Zokngjohl/ZYy8D9NhQrXVeMrmZcwD8ZFgmC4=;
        h=Date:From:To:Cc:Subject:From;
        b=ZamB0Lh79P5SBKfD2m0zm+H++ZugGP+J7HduTIW0Wmrk0NRm6jaC6GKXEoJ+yjbTl
         MZ58YeKc0u0ZtYp7NHU5bHsPH1Px5BgU01rxXb+pSDP4urS5xXog/2hcdKq+8PBSxd
         aoM6Z1yyvejIdBKv2+VGkTQE+zZaa8GafbgGGgGmk0JKM7Acv7bstHrsOfRZXNQn+f
         1DAmyXV82PGF1ImW95SvkkshpJvmLXv/AriaADec77l6/BkqZpVHOkEcV0GOCDY5N8
         bmnrfStFUm64nm8ZEP+ScSplDG3pGYX9WLiR7x/1jN7t1NPR6MSOyYjaN25JTYHIiS
         StPCX8Rp//BOQ==
Date:   Mon, 6 Feb 2023 09:48:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Samuel Holland <samuel@sholland.org>
Subject: linux-next: manual merge of the risc-v tree with Linus' tree
Message-ID: <20230206094823.48197098@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vRO0/EEK+qHdckKv4h0e=+T";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vRO0/EEK+qHdckKv4h0e=+T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the risc-v tree got a conflict in:

  arch/riscv/include/asm/vdso/processor.h

between commit:

  0b1d60d6dd9e ("riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy")

from Linus' tree and commit:

  95bc69a47be2 ("riscv: cpu_relax: switch to riscv_has_extension_likely()")

from the risc-v tree.

I fixed it up (the former removed the line modified by the latter,
so I just used the former) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/vRO0/EEK+qHdckKv4h0e=+T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPgMjcACgkQAVBC80lX
0Gxxzwf/d3Pdi8D8iFQxVl9y5jG9nP1uqMMqRnHeLnhHoposYilae/wrsDFnOXiL
h5P+QVyMQfcxhRVNkY9MJlh6/d0a8valkxd3PmTshtfH9LURpg4jlt/bBhvfi/Dx
nclWIrbRg0CaMv/29wW8nlRBdeapy0kcncuKw28tp8S71aANsz5StXCHUflbTOk7
z0hFz/AbiVj2xwbAiJrL7NrNnnWsfhhv6weZnr7pkfJ2Mi+f6CJb3mL1I6/VPLtz
MpU4UM6YnK+OZvLpESbxuERKZI0psAAKMyLjTARBqs1LmzlUI7Lp0cF4vZsuJDqv
RgmeCoNsiutot9+RIcRJIdgqA8O8lA==
=J/cJ
-----END PGP SIGNATURE-----

--Sig_/vRO0/EEK+qHdckKv4h0e=+T--
