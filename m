Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB1B68B234
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 23:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjBEWkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 17:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBEWkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 17:40:09 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0C712F0C;
        Sun,  5 Feb 2023 14:40:07 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P948h1wc5z4x2c;
        Mon,  6 Feb 2023 09:40:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675636805;
        bh=7QQ8WLvHlUgVlodMAD45lcdYowe1GvTcz6fYz/fBSsA=;
        h=Date:From:To:Cc:Subject:From;
        b=Pul6BB46M8Mzb28AH5UpYqHEkIb1hKZHKvf02iiEzTHYVEuHFdLIvd6zGEOIOsE2E
         8Dkd1q72CWHUKsvhy8bOm7STiMIcpxy/1gcdiDZSaQjC5tQSt322QzDcqbvkr15mzW
         39mv+xdbS4zXsrQeTM3AGunHfVRnY+Cvw4Oi9govCQNIUlXY0f3Vb80znFCaKjExo3
         QBbK7UfOBdLP493WZj1xlcGTUWHMZQL6UrUY9GfYBYK7E/We96aQrCrS1MabmSc0Eu
         g8ha9JghLwjLX3P6Uipv9wcW2IW1iEGgziILF8O5gmW7UQa71v9qd8p1IjcbCYjLEz
         IRVA2WSsVSQ+A==
Date:   Mon, 6 Feb 2023 09:40:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Samuel Holland <samuel@sholland.org>
Subject: linux-next: manual merge of the risc-v tree with Linus' tree
Message-ID: <20230206094003.5438e04a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MQaMNkF9H.iFoI_3IdAXoHp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MQaMNkF9H.iFoI_3IdAXoHp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the risc-v tree got a conflict in:

  arch/riscv/include/asm/hwcap.h

between commit:

  0b1d60d6dd9e ("riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy")

from Linus' tree and commits:

  80c200b34ee8 ("RISC-V: resort all extensions in consistent orders")
  d8a3d8a75206 ("riscv: hwcap: make ISA extension ids can be used in asm")
  bdda5d554e43 ("riscv: introduce riscv_has_extension_[un]likely()")
  03966594e117 ("riscv: remove riscv_isa_ext_keys[] array and related usage=
")

from the risc-v tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/MQaMNkF9H.iFoI_3IdAXoHp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPgMEMACgkQAVBC80lX
0GyFSwf+N3kHPnZDMGkF19blKgcfuHXXVHjRBj3KL7Q0nWMpolaHyUsbC4boHwiC
CyHOXwb92g5ElhSpCKEZJiVLilK/4sNP3KKQyDrZwG7Hip+T31xJjWjL/ulaLNOk
GmfQ0c+WVHm8okobfRj6Xru+vRUw8j9NwwanZwM09BeCwI84znmSWH1jI+HRpyca
7kE2qEX4Hkp8RMMT0wHVXebrb40Q8ALw1rmFMq6Nh6Y4FXTcDprWlLsuQi8N6sas
QlF2qSniZqv6o7iuW7UAPGf/9muM5RPi2oLEFEP7X0DQXJw0nwE06YqoR8lOhzSu
9Ikcmy1mW1tJ2vh9qy0495ZF0q75oQ==
=9wfQ
-----END PGP SIGNATURE-----

--Sig_/MQaMNkF9H.iFoI_3IdAXoHp--
