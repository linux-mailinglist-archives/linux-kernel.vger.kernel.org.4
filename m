Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898F770ABF2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 03:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjEUB7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 21:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjEUB7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 21:59:22 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF1112A
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 18:59:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QP3fQ1CDQz4x4P;
        Sun, 21 May 2023 11:59:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1684634353;
        bh=qlV4WNjNJgl2YAU0jcaO5+e9/aF+CGwXgcMfDthQSX0=;
        h=From:To:Cc:Subject:Date:From;
        b=lzED8cMsRZ10/ahBZoeYGzLOPp1fSn7qzoFnJLPS3GwSIcpdrzTdT2eKHSptikjVZ
         NS6Ie3gx+JGOKHDB1rrz+llnNGzeMVBJI83N8HbqkpAHbiN2ZnYiDTe971yRpX35Ky
         ji4mUSMwyXDxyzfTt7eFLAYLVMGY7uEHAbmKG2305brWzoAZQftSEOqP8AcBxQN/sh
         0nqVCgVD6oG4OLLwGuo81B6zrOAYhkuCaE5kgCzioxFuOV2sPT2Uujm6g2wBhXQXus
         2myZS2u0epgrv2yl/iYILs3GvRwZSiwJv+sBC+1I3E8vmeNtxbDadPTRIxiKKgmT72
         rMiJWITddEPtQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     gbatra@linux.vnet.ibm.com, hbathini@linux.ibm.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        nathan@kernel.org, rdunlap@infradead.org, robh@kernel.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.4-2 tag
Date:   Sun, 21 May 2023 11:59:02 +1000
Message-ID: <87lehizbq1.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull powerpc fixes for 6.4:

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/po=
werpc-6.4-2

for you to fetch changes up to 1f7aacc5eb9ed2cc17be7a90da5cd559effb9d59:

  powerpc/iommu: Incorrect DDW Table is referenced for SR-IOV device (2023-=
05-17 00:54:55 +1000)

- ------------------------------------------------------------------
powerpc fixes for 6.4 #2

 - Fix broken soft dirty tracking when using the Radix MMU (>=3D P9).

 - Fix ISA mapping when "ranges" property is not present, for PASemi Nemo b=
oards.

 - Fix a possible WARN_ON_ONCE hitting in BPF extable handling.

 - Fix incorrect DMA address handling when using 2MB TCEs.

 - Fix a bug in IOMMU table handling for SR-IOV devices.

 - Fix the recent rework of IOMMU handling which left arch code calling cle=
an
   up routines that are handled by the IOMMU core.

 - A few assorted build fixes.

Thanks to: Christian Zigotzky, Dan Hor=C3=A1k, Gaurav Batra, Hari Bathini, =
Jason
Gunthorpe, Nathan Chancellor, Naveen N. Rao, Nicholas Piggin, Pali Roh=C3=
=A1r, Randy
Dunlap, Rob Herring.

- ------------------------------------------------------------------
Gaurav Batra (2):
      powerpc/iommu: DMA address offset is incorrectly calculated with 2MB =
TCEs
      powerpc/iommu: Incorrect DDW Table is referenced for SR-IOV device

Hari Bathini (1):
      powerpc/bpf: populate extable entries only during the last pass

Jason Gunthorpe (1):
      powerpc/iommu: Remove iommu_del_device()

Michael Ellerman (2):
      powerpc/64s/radix: Fix soft dirty tracking
      powerpc/crypto: Fix aes-gcm-p10 build when VSX=3Dn

Nathan Chancellor (1):
      powerpc/boot: Disable power10 features after BOOTAFLAGS assignment

Randy Dunlap (1):
      powerpc/fsl_uli1575: fix kconfig warnings and build errors

Rob Herring (1):
      powerpc/isa-bridge: Fix ISA mapping when "ranges" is not present


 arch/powerpc/boot/Makefile               |  6 ++--
 arch/powerpc/crypto/Kconfig              |  2 +-
 arch/powerpc/include/asm/iommu.h         |  5 ---
 arch/powerpc/kernel/dma-iommu.c          |  4 ++-
 arch/powerpc/kernel/iommu.c              | 28 ++++-----------
 arch/powerpc/kernel/isa-bridge.c         |  5 +--
 arch/powerpc/mm/book3s64/radix_pgtable.c |  4 +--
 arch/powerpc/net/bpf_jit_comp.c          |  2 ++
 arch/powerpc/platforms/Kconfig           |  1 +
 arch/powerpc/platforms/powernv/pci.c     | 25 -------------
 arch/powerpc/platforms/pseries/iommu.c   | 38 +++++---------------
 11 files changed, 32 insertions(+), 88 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmRpeqIACgkQUevqPMjh
pYA2fQ/7BZucOtUs36IjCBHUMd+l5De01lPzoErQ6m3r3uwpEgymXw531NlTv+Sq
eGfwUDTuYts4pXW5ELAeVHsW7115lou2775Th2kbjcnGR2PtMFeDfnAgXb5mTFSI
L7FkUm2Z/V5tEGO9QNVIcwmrx8uK743Jou+HWAkMGqoopnomPjLspirZGAtOLSVk
pmyzWIRyfeaSm5elAx37vFzgQ+uJtJ9rhf8YaLzgjOX309jFoOhqd1O9tNC8rfFH
59gxeSW2gzdnKO/GzU3x5fDLCxqPCrRG8KnM8RDTjFIvRQRZrF/fAN3tYhYew+IT
omFteOW89tZS2JJbmZyTQPLIh2Nkvi0iEItwC7i1rz1nVmTTy3vPD3bC3xfoNH+2
aepvt4KuLmcJ62M3MZNwMfPcdfCwqCg7G1+ORUVdnElYO9r8weOBNkHIYqIFVuQX
LRMu2kUmMVYaqm4YBRrMKCvZX1zNNJvPFRlQI8WjPG6oOTLQILee5MUmdeCIEa9K
piMkA+YoDfaJ2l9FCA48MJiueSRgkDAW/RsI/ozu6BE1Ba2ndy0JL/4qMpInsh3T
3/fwnynLX3A28wFCJFNOykjvGb6X90gRzQ48Vga9U0yGNhPA+f4Xk9b1JslWb8l3
nn78rof3w2wkYDOUSnlDtSFzS7O2WYfRh5c5UdZxfpo4OV6RbAE=3D
=3DnuS4
-----END PGP SIGNATURE-----
