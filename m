Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC2F661A1E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjAHVmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjAHVmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:42:35 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F24654F;
        Sun,  8 Jan 2023 13:42:31 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NqrC169l6z4xP3;
        Mon,  9 Jan 2023 08:42:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673214146;
        bh=Md+/1V9BYTxro8zIrhgN/qAxG28rNuZo6a1LSFcjcB4=;
        h=Date:From:To:Cc:Subject:From;
        b=Es2/rRafc93kbcN1tRou+GrTZPzdG/+9lEZsu3QerEYIYVtF8LKjz1X/lYg+CH57W
         OsPtA3778Fq4GwDRepv3yZDi9V6KIrQtiDYLmSz0I2Skd0/bl19qAfNBVjrY/HtGXG
         5dZRq5I5G0m8qAkELEUBsnEIBD4jQyNn62ViJxaHAjhUUo5+awYf9b/fthOOfhJIlK
         k2SGN+6mo9PBJ/0Vd5StzKcQ/Q+MHK6UNMa9sTWoRL/KHZ48zZFTYx58KA/l8b/Ya7
         aNq9WqBGcEvcvQ3PAHFc1ncvMlWEWmI/QnvMXsaZIbUCFNt4y7VDa6DnawQPvBlxuk
         9XE5Zx9IbMhTw==
Date:   Mon, 9 Jan 2023 08:42:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: linux-next: manual merge of the risc-v tree with Linus' tree
Message-ID: <20230109084220.61314353@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J+l4581dVH4QLQCZ1=yhnNN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/J+l4581dVH4QLQCZ1=yhnNN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the risc-v tree got a conflict in:

  arch/riscv/kernel/probes/simulate-insn.h

between commit:

  b2d473a6019e ("riscv, kprobes: Stricter c.jr/c.jalr decoding")

from Linus' tree and commits:

  ec5f90877516 ("RISC-V: Move riscv_insn_is_* macros into a common header")
  c9c1af3f186a ("RISC-V: rename parse_asm.h to insn.h")

from the risc-v tree.

I fixed it up (The changes from the former are contained in the latter)
and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/J+l4581dVH4QLQCZ1=yhnNN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO7OLwACgkQAVBC80lX
0GyvnAf/RXxDckV5OYeRq0s/vMcpa268PUreS4PrPxoaGQgEIAMIzZWEnWcBrwCD
OS2x9/T/cvDzaZMWU46c+huNxHVgX4cLutDWeG5o9UE4+TL2mCYr/moktxERlEm5
vW1kbRPlSYwuLX6ybKfQCnJ/Z2oAn3AICGXY4k8FHnL8/Nj9D2kFgtRxa2b7p1+K
iKIkxlFGrb9gFjElLWKPiyFZ4QALy+XolYMQPKLqSJoTnUyugDJDF0jULr9L9I+y
ES49qrVTdYaLo7kj3c5fEErLfX209FXxtek1JWkKiYkHLKrLKCOVTrjRZXdNYONp
Gy8/PO0mhaWPLa4uLxRgQfgeS0RqPg==
=ZEWO
-----END PGP SIGNATURE-----

--Sig_/J+l4581dVH4QLQCZ1=yhnNN--
