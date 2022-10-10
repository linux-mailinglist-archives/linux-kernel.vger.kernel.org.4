Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE84C5F9E8B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiJJMM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiJJMMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:12:48 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BE676555D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:12:46 -0700 (PDT)
Received: from 8bytes.org (p549ad5ad.dip0.t-ipconnect.de [84.154.213.173])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id EAC8C220973;
        Mon, 10 Oct 2022 14:12:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1665403965;
        bh=iEvih1XIJJdDiOuca7zdNJ+qZN0iXc03t2fguOP/Trw=;
        h=Date:From:To:Cc:Subject:From;
        b=vApuTtYOOiCkvwRm1dSQEA0s9+xziQrP+Us7HPNB25imA9GmRH2k+yPPaNtLAtpnp
         eYe9mpH1f3kz//wXMAph914+2pp5819oFMDEGA/9mRcGtFXaQULiwZN+/nz6ekjVkw
         Tj+9hSNwkESTY3gs49rPBuPVbdQoRz/GesbqavDzyXSTEMd6fYx4Pp1FwgQ7bnylCW
         QISkVU8FL3Bna8bLOHex0P/64GzKTUwXofGu4mfkpOXyGTqpLIVb7k1aDq0aE8FXET
         oVYa74UnmVcl2ZOGcEYpFqvb23JgVR69zEUgDssgdtQHba/qkS6n7aIOE1dFwGpeP9
         Ko3TMRrsLrDyw==
Date:   Mon, 10 Oct 2022 14:12:43 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [git pull] IOMMU Updates for Linux v6.1
Message-ID: <Y0QMOy7g2nADghrJ@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Xq+2gmiaDifvryq8"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Xq+2gmiaDifvryq8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit f76349cf41451c5c42a99f18a9163377e4b364ff:

  Linux 6.0-rc7 (2022-09-25 14:01:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.1

for you to fetch changes up to 38713c6028a3172c4c256512c3fbcfc799fe2d43:

  Merge branches 'apple/dart', 'arm/mediatek', 'arm/omap', 'arm/smmu', 'virtio', 'x86/vt-d', 'x86/amd' and 'core' into next (2022-09-26 15:52:31 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v6.1:

Including:

	- Removal of the bus_set_iommu() interface which became
	  unnecesary because of IOMMU per-device probing

	- Make the dma-iommu.h header private

	- Intel VT-d changes from Lu Baolu:
	  - Decouple PASID and PRI from SVA
	  - Add ESRTPS & ESIRTPS capability check
	  - Cleanups

	- Apple DART support for the M1 Pro/MAX SOCs

	- Support for AMD IOMMUv2 page-tables for the DMA-API layer. The
	  v2 page-tables are compatible with the x86 CPU page-tables.
	  Using them for DMA-API prepares support for hardware-assisted
	  IOMMU virtualization

	- Support for MT6795 Helio X10 M4Us in the Mediatek IOMMU driver

	- Some smaller fixes and cleanups

----------------------------------------------------------------
Andy Shevchenko (2):
      iommu: Do not dereference fwnode in struct device
      iommu/virtio: Do not dereference fwnode in struct device

AngeloGioacchino Del Regno (3):
      dt-bindings: mediatek: Add bindings for MT6795 M4U
      iommu/mediatek: Introduce new flag TF_PORT_TO_ADDR_MT8173
      iommu/mediatek: Add support for MT6795 Helio X10 M4Us

Dan Carpenter (1):
      iommu/omap: Fix buffer overflow in debugfs

Janne Grunau (1):
      iommu/io-pgtable: Move Apple DART support to its own file

Jean-Philippe Brucker (1):
      dt-bindings: iommu: arm,smmu-v3: Relax order of interrupt names

Joerg Roedel (3):
      Merge branch 'iommu/fixes' into core
      iommu/virtio: Fix compile error with viommu_capable()
      Merge branches 'apple/dart', 'arm/mediatek', 'arm/omap', 'arm/smmu', 'virtio', 'x86/vt-d', 'x86/amd' and 'core' into next

John Garry (3):
      iova: Remove some magazine pointer NULL checks
      iova: Remove magazine BUG_ON() checks
      iova: Remove iovad->rcaches check in iova_rcache_get()

Lu Baolu (5):
      iommu/vt-d: Remove unnecessary SVA data accesses in page fault path
      iommu/vt-d: Decouple PASID & PRI enabling from SVA
      iommu/vt-d: Remove pasid_set_eafe()
      iommu/vt-d: Avoid unnecessary global IRTE cache invalidation
      iommu/vt-d: Avoid unnecessary global DMA cache invalidation

Matthew Rosato (1):
      iommu/s390: Fail probe for non-PCI devices

Robin Murphy (22):
      iommu: Retire iommu_capable()
      iommu/arm-smmu: Report IOMMU_CAP_CACHE_COHERENCY better
      iommu/io-pgtable-arm: Remove iommu_dev==NULL special case
      iommu/vt-d: Handle race between registration and device probe
      iommu/amd: Handle race between registration and device probe
      iommu: Always register bus notifiers
      iommu: Move bus setup to IOMMU device registration
      iommu/amd: Clean up bus_set_iommu()
      iommu/arm-smmu: Clean up bus_set_iommu()
      iommu/arm-smmu-v3: Clean up bus_set_iommu()
      iommu/dart: Clean up bus_set_iommu()
      iommu/exynos: Clean up bus_set_iommu()
      iommu/ipmmu-vmsa: Clean up bus_set_iommu()
      iommu/mtk: Clean up bus_set_iommu()
      iommu/omap: Clean up bus_set_iommu()
      iommu/tegra-smmu: Clean up bus_set_iommu()
      iommu/virtio: Clean up bus_set_iommu()
      iommu: Clean up bus_set_iommu()
      iommu/dma: Clean up Kconfig
      iommu/dma: Move public interfaces to linux/iommu.h
      iommu/dma: Make header private
      iommu/iova: Fix module config properly

Suravee Suthikulpanit (4):
      iommu/amd: Refactor amd_iommu_domain_enable_v2 to remove locking
      iommu/amd: Update sanity check when enable PRI/ATS for IOMMU v1 table
      iommu/amd: Add support for Guest IO protection
      iommu/amd: Add support for using AMD IOMMU v2 page table for DMA-API

Sven Peter (3):
      iommu/io-pgtable: Add DART subpage protection support
      iommu/io-pgtable-dart: Add DART PTE support for t6000
      iommu: dart: Support t6000 variant

Vasant Hegde (9):
      iommu/amd/io-pgtable: Implement map_pages io_pgtable_ops callback
      iommu/amd/io-pgtable: Implement unmap_pages io_pgtable_ops callback
      iommu/amd: Add map/unmap_pages() iommu_domain_ops callback support
      iommu/amd: Initial support for AMD IOMMU v2 page table
      iommu/amd: Add command-line option to enable different page table
      iommu/amd: Free domain id in error path
      iommu/amd: Free domain ID after domain_flush_pages
      iommu/amd: Remove outdated comment
      iommu/amd: Fix sparse warning

Yi Liu (1):
      iommu/vt-d: Rename cap_5lp_support to cap_fl5lp_support

Yuan Can (2):
      iommu: Remove comment of dev_has_feat in struct doc
      iommu: Remove duplicate ida_free in iommu_group_alloc

 Documentation/admin-guide/kernel-parameters.txt    |   2 +
 .../devicetree/bindings/iommu/arm,smmu-v3.yaml     |  15 +-
 .../devicetree/bindings/iommu/mediatek,iommu.yaml  |   4 +
 MAINTAINERS                                        |   3 +-
 arch/arm64/Kconfig                                 |   1 -
 arch/arm64/mm/dma-mapping.c                        |   2 +-
 drivers/acpi/viot.c                                |   1 -
 drivers/gpu/drm/exynos/exynos_drm_dma.c            |   1 -
 drivers/iommu/Kconfig                              |  16 +-
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/amd/Kconfig                          |   1 -
 drivers/iommu/amd/Makefile                         |   2 +-
 drivers/iommu/amd/amd_iommu.h                      |   1 -
 drivers/iommu/amd/amd_iommu_types.h                |  10 +-
 drivers/iommu/amd/init.c                           |  47 ++-
 drivers/iommu/amd/io_pgtable.c                     |  76 ++--
 drivers/iommu/amd/io_pgtable_v2.c                  | 415 ++++++++++++++++++
 drivers/iommu/amd/iommu.c                          | 164 ++++---
 drivers/iommu/apple-dart.c                         |  57 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  62 +--
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |  97 +----
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |   6 +-
 drivers/iommu/dma-iommu.c                          |  18 +-
 drivers/iommu/dma-iommu.h                          |  42 ++
 drivers/iommu/exynos-iommu.c                       |   9 -
 drivers/iommu/fsl_pamu_domain.c                    |   6 +-
 drivers/iommu/intel/Kconfig                        |   6 +-
 drivers/iommu/intel/cap_audit.c                    |   4 +-
 drivers/iommu/intel/iommu.c                        |  95 ++---
 drivers/iommu/intel/iommu.h                        |   7 +-
 drivers/iommu/intel/irq_remapping.c                |   6 +-
 drivers/iommu/intel/pasid.c                        |  12 +-
 drivers/iommu/intel/svm.c                          |  62 +--
 drivers/iommu/io-pgtable-arm.c                     |  71 +---
 drivers/iommu/io-pgtable-dart.c                    | 469 +++++++++++++++++++++
 drivers/iommu/io-pgtable.c                         |   4 +
 drivers/iommu/iommu.c                              | 154 +++----
 drivers/iommu/iova.c                               |  13 +-
 drivers/iommu/ipmmu-vmsa.c                         |  35 +-
 drivers/iommu/msm_iommu.c                          |   2 -
 drivers/iommu/mtk_iommu.c                          |  45 +-
 drivers/iommu/mtk_iommu_v1.c                       |  13 +-
 drivers/iommu/omap-iommu-debug.c                   |   6 +-
 drivers/iommu/omap-iommu.c                         |   6 -
 drivers/iommu/rockchip-iommu.c                     |   2 -
 drivers/iommu/s390-iommu.c                         |  15 +-
 drivers/iommu/sprd-iommu.c                         |   5 -
 drivers/iommu/sun50i-iommu.c                       |   2 -
 drivers/iommu/tegra-smmu.c                         |  29 +-
 drivers/iommu/virtio-iommu.c                       |  32 +-
 drivers/irqchip/irq-gic-v2m.c                      |   2 +-
 drivers/irqchip/irq-gic-v3-its.c                   |   2 +-
 drivers/irqchip/irq-gic-v3-mbi.c                   |   2 +-
 drivers/irqchip/irq-ls-scfg-msi.c                  |   2 +-
 drivers/vfio/vfio_iommu_type1.c                    |   1 -
 include/dt-bindings/memory/mt6795-larb-port.h      |  95 +++++
 include/linux/dma-iommu.h                          |  93 ----
 include/linux/io-pgtable.h                         |   3 +
 include/linux/iommu.h                              |  47 ++-
 include/linux/iova.h                               |   2 +-
 60 files changed, 1501 insertions(+), 902 deletions(-)
 create mode 100644 drivers/iommu/amd/io_pgtable_v2.c
 create mode 100644 drivers/iommu/dma-iommu.h
 create mode 100644 drivers/iommu/io-pgtable-dart.c
 create mode 100644 include/dt-bindings/memory/mt6795-larb-port.h
 delete mode 100644 include/linux/dma-iommu.h

Please pull.

Thanks,

	Joerg

--Xq+2gmiaDifvryq8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmNEDDsACgkQK/BELZcB
GuMiAg/+LAsK9z9382/5CXy3gEcTqNs/OV6Rq0XGNVj7VBdFX1BzIajGwgeExMCt
lDBUEC3aNQ5sJG/n1ZF5i+7B2GedxUAkD4tsQG+7gF9rv00msoSuhM9UQH20MyGo
XWjOSRW6hF0tNeJGUjZ9X6/llbYGcEG7+EUAOrNWRP+a29K9C1WEFaEAEj3uP5W2
OT3W4bvNkYBDwtgMkfIRV3sHC70dsMgzhOVzP4HvGRW/EMTtF/uoBwjI7buFMh0S
gQsAJxeP5Mb3j3e0D7JJoKPACMOb0J30XCxp/i3SM2sn9WHM4pjAcxugCTBKWf+w
LqXlwmJ0h/JirVanLJLoBUUOa+KcZjR7CoitWl2gdPpf4Ffpi3pPASgU/wVKWTeI
b1Jv5/PKimQbQ0ulK/AjUnDn1SJY9NOYPfH6tLL6pBGuPYQlNj/oB7X0/9opqKw0
8HQ2m3HPQm1W5mRciowSGxIOsOndUUyjaaoY7UbRpciJluwMr5KpKsv9+B2Y51L0
QQY0HuZB5gmizHmSBNll9UySkN/X8XEWqpy2lqjxNBGj0p6uUdxfL1nP5wut512e
dl4uLjW0l7tC9mSjX2SFAnXNMtjBjySGxNf/W3K7vOxd5lp1Zi1iYTwzFZOb23ft
Gn9z0w1y9IUjoi9EB1Rlhx/vvipTMaSiI0SXgLkZsk4jjxsN2VE=
=2zZl
-----END PGP SIGNATURE-----

--Xq+2gmiaDifvryq8--
