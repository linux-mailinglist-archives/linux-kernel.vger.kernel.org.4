Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DEA6C7465
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjCXAPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXAPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:15:19 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A9014228;
        Thu, 23 Mar 2023 17:15:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PjN5H6w4Gz4wgv;
        Fri, 24 Mar 2023 11:15:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679616916;
        bh=8COmHSNZL6Mox6t+Ubz0o5GRzktg0YUvu+sMIkdmdlU=;
        h=Date:From:To:Cc:Subject:From;
        b=bT4Os49rLTPdWxWkvQPIMPM47eNDkzyTfb0KGhb1X4jjKVVNVQQxtoRRIeRuv5K9i
         7PPnot9ZpU2/aWqqvgesm/Ma1nnm5id0+VMrjJUj+PMH2VOse8gRGrnmm2GQ262oVi
         coj/wVobWZYqLjRZtoceJTRAS8O+qnZRSV51oxeaxFMAfxIpm41aHOUd+giDzlSpal
         l/aNNr1Xu87OSbj4942r5bWARQdTgLIfpK/pmKU/+zWh8X3EQTfmOF7vFTJUmSD2iH
         hyL35oHb0OFAM1eeSlbAIDcAT0mgMPKfxIzGeXsT8v5am9095f1Qout7SqS02vFWwf
         zG1zaHePStH6g==
Date:   Fri, 24 Mar 2023 11:15:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Helge Deller <deller@gmx.de>
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: linux-next: manual merge of the sh tree with the parisc-hd tree
Message-ID: <20230324111514.2bbcd64b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nfu/PxOKBd=2/+QYaKMX1RR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nfu/PxOKBd=2/+QYaKMX1RR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the sh tree got a conflict in:

  Documentation/kbuild/kbuild.rst

between commit:

  49deed336ef9 ("parisc: update kbuild doc. aliases for parisc64")

from the parisc-hd tree and commit:

  644a9cf0d2a8 ("sh: remove sh5/sh64 last fragments")

from the sh tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/kbuild/kbuild.rst
index 84b2d2dc8f78,e22621f4af0b..000000000000
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@@ -160,8 -160,6 +160,7 @@@ directory name found in the arch/ direc
  But some architectures such as x86 and sparc have aliases.
 =20
  - x86: i386 for 32 bit, x86_64 for 64 bit
 +- parisc: parisc64 for 64 bit
- - sh: sh for 32 bit, sh64 for 64 bit
  - sparc: sparc32 for 32 bit, sparc64 for 64 bit
 =20
  CROSS_COMPILE

--Sig_/nfu/PxOKBd=2/+QYaKMX1RR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQc65IACgkQAVBC80lX
0GwyFQf9HsiN1PRgq1Wdv4aMV3RGTSJNLfuOgUWhQMa03JuhyCg0w43Oqhvqr4V2
VOU0zf+vsvFe3vBbQEawANzUAY2JHM2/ufFPMaibJB4cWvAbiCcIxBfSHLTJwiKM
puCiHOjCz21IPQkcQ5x77nyEi2xkBtvQ4Pq4Vi481fGRcLHChlGEquS5J6hzybov
6f/7DAd1eTB+lyAdsBcCVFOVxUqS2q6tW4zZmyq/VFyLyx2czSh8+7O8CQUPc6PL
xchGaqoOb+vkwkXcsczuGKxYezYzUY+yVx0jbZdmYWXpEnhKP0uy/yubdpIOFZEw
uBZqA4WswwO1Sbj/K6+/Uld4pc8j1w==
=fvqO
-----END PGP SIGNATURE-----

--Sig_/nfu/PxOKBd=2/+QYaKMX1RR--
