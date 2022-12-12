Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446DE64AB10
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiLLXDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbiLLXDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:03:36 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C321789C;
        Mon, 12 Dec 2022 15:03:34 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NWHH13hnMz4xP9;
        Tue, 13 Dec 2022 10:03:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670886209;
        bh=NCgE8+5Ez0w6THg439ugWeJQOoe4/Mn6dIFRYwNl0WE=;
        h=Date:From:To:Cc:Subject:From;
        b=gXCer509fBGzsF+tdyPj3AMSXcl1razUftnx7drHGmHiM46zpq7poMp4hiKl5vRC2
         uHayIEuOrTbI7d0d+EtJHPim5gJwM9xeTZkj6p8q3B7Uc8rbp67YYzmFJL9Qxui6AD
         FtmdPxjBktCKabD5Kvk2D30Ra5XJhurinW9Fa7jF3jWl/A9ETwmlOoioe0loSxgWFN
         h2Ue407D1HlToUUF94Io2RqnJJO0zQKMmH6kyIv46IMjapLl3MV5IRnjUXFCVTDnBz
         sniHIEZBnG4nEKMFvsj/daiU90CwRThBmtIYY2hQxi7CbXjauXlskMv+0BPxeVPH0s
         kzFUp3nLk/ZBA==
Date:   Tue, 13 Dec 2022 10:03:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: linux-next: manual merge of the risc-v tree with Linus' tree
Message-ID: <20221213100324.67fa5152@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GYnfjOrI7MBXYQWYKt2YHw7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GYnfjOrI7MBXYQWYKt2YHw7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the risc-v tree got a conflict in:

  arch/riscv/configs/defconfig

between commit:

  1776fca7fadb ("riscv: configs: defconfig: Enable Renesas RZ/Five SoC")

from Linus' tree and commit:

  497bcbe3ce04 ("RISC-V: Enable PMEM drivers")

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

diff --cc arch/riscv/configs/defconfig
index f7f32448f160,fea1b17dbbd3..000000000000
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@@ -123,8 -123,8 +124,9 @@@ CONFIG_MICROSEMI_PHY=3D
  CONFIG_INPUT_MOUSEDEV=3Dy
  CONFIG_SERIAL_8250=3Dy
  CONFIG_SERIAL_8250_CONSOLE=3Dy
+ CONFIG_SERIAL_8250_DW=3Dy
  CONFIG_SERIAL_OF_PLATFORM=3Dy
 +CONFIG_SERIAL_SH_SCI=3Dy
  CONFIG_VIRTIO_CONSOLE=3Dy
  CONFIG_HW_RANDOM=3Dy
  CONFIG_HW_RANDOM_VIRTIO=3Dy
@@@ -161,7 -161,7 +163,8 @@@ CONFIG_VIRTIO_MMIO=3D
  CONFIG_RPMSG_CHAR=3Dy
  CONFIG_RPMSG_CTRL=3Dy
  CONFIG_RPMSG_VIRTIO=3Dy
 +CONFIG_ARCH_R9A07G043=3Dy
+ CONFIG_LIBNVDIMM=3Dy
  CONFIG_EXT4_FS=3Dy
  CONFIG_EXT4_FS_POSIX_ACL=3Dy
  CONFIG_EXT4_FS_SECURITY=3Dy

--Sig_/GYnfjOrI7MBXYQWYKt2YHw7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOXszwACgkQAVBC80lX
0GwsnQf/ZO+io1MfQupCRf7aCUX90q2iBngkUsdQQRPM25uWh/j9HzaErUoy4vv0
QHPcXNnAWYf1u3KKP7BHYzZgV+DoPfDzG7dv1dvlFuyCrmWPJdSOydJuj/m3e2ga
t+akhPEBP0aeLfvurnF82+koVwQGihcpSDJnwuqYdT46CFeBSK5ZF1EyNmMEw2Hp
lh6ciU1vf06oPU+sMie65t9qAzxS1r03KGuJAMCUkvP+hge7Aq8R7eDqx8CiDWYe
8wRnrr5VCoA8SPB0YWPRcbCoh9BpAHlIAhZGXWddmUCyoaG9TxgV7cFBoFaoh0fP
2SpoC95ql6MJocyZRT//Bki4CSmcuw==
=XNyP
-----END PGP SIGNATURE-----

--Sig_/GYnfjOrI7MBXYQWYKt2YHw7--
