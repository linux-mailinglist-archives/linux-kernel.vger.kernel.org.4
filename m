Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319E264F980
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 15:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLQOsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 09:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiLQOs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 09:48:29 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60DD612AC0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 06:48:27 -0800 (PST)
Received: from 8bytes.org (p200300c2771f3d0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:771f:3d00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 1563626005E;
        Sat, 17 Dec 2022 15:48:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1671288506;
        bh=mPpOabXgEdgV3EMszXyNv6IdcN6pP3hUB75hMuazS8A=;
        h=Date:From:To:Cc:Subject:From;
        b=SHMoVommrty7SIFXAN7jw8Z9N5y+urr3bSXEjClgjOlUyI9vq+eI0PHK00UINcW/T
         o9y2py4iultyEvoEwFcR5NhNXeR5kZmqm5Bpy32o7IxXCj16WIuW3mWzspHRtQysvQ
         QjTuFYf8MKHCEXtL3ts8TscwW3aici4RhFqvRxlNvYxiDI+GjRveprrDm6MevOUrsf
         dtNiKV1wM37aZpUCtTQoXTCyIVwj+fgiSNZOfrxQoHvCj5kgoaUTmBxwNVERF4bm+F
         sdKmTFHXF910VskEgB/71AfFjOxp+0VtYtNEBr46Qn2kiii9M+7zkCqqwgJjJnh66f
         If5Sxth0DB4tA==
Date:   Sat, 17 Dec 2022 15:48:24 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [git pull] IOMMU Updates for Linux v6.2
Message-ID: <Y53WuKl7o4/rKNt7@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1171Dmd0x676ykP7"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1171Dmd0x676ykP7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 830b3c68c1fb1e9176028d02ef86f3cf76aa2476:

  Linux 6.1 (2022-12-11 14:15:18 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.2

for you to fetch changes up to e3eca2e4f6489ed3143c80ce90bfa7ef7e12ebc7:

  Merge branches 'arm/allwinner', 'arm/exynos', 'arm/mediatek', 'arm/rockchip', 'arm/smmu', 'ppc/pamu', 's390', 'x86/vt-d', 'x86/amd' and 'core' into next (2022-12-12 12:50:53 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v6.2

Including:

	- Core code:
	  - map/unmap_pages() cleanup
	  - SVA and IOPF refactoring
	  - Clean up and document return codes from device/domain
	    attachment code

	- AMD driver:
	  - Rework and extend parsing code for ivrs_ioapic, ivrs_hpet
	    and ivrs_acpihid command line options
	  - Some smaller cleanups

	- Intel driver:
	  - Blocking domain support
	  - Cleanups

	- S390 driver:
	  - Fixes and improvements for attach and aperture handling

	- PAMU driver:
	  - Resource leak fix and cleanup

	- Rockchip driver:
	  - Page table permission bit fix

	- Mediatek driver:
	  - Improve safety from invalid dts input
	  - Smaller fixes and improvements

	- Exynos driver:
	  - Fix driver initialization sequence

	- Sun50i driver:
	  - Remove IOMMU_DOMAIN_IDENTITY as it has not been working
	    forever
	  - Various other fixes

----------------------------------------------------------------
Adam Skladowski (2):
      dt-bindings: arm-smmu: Add compatible for Qualcomm SM6115
      iommu/arm-smmu-qcom: Add SM6115 support

Chen Lin (1):
      iommu/arm-smmu: Warn once when the perfetcher errata patch fails to apply

Christophe Leroy (1):
      iommu/fsl_pamu: Replace NO_IRQ by 0

Colin Ian King (1):
      iommu/amd: Remove variable cnt ind iommu_poll_ga_log()

Dan Carpenter (1):
      iommu/mediatek: Fix forever loop in error handling

Denis Arefev (1):
      iommu/amd: Check return value of mmu_notifier_register()

Dmitry Baryshkov (10):
      dt-bindings: arm-smmu: Add missing Qualcomm SMMU compatibles
      dt-bindings: arm-smmu: fix clocks/clock-names schema
      dt-bindings: arm-smmu: add special case for Google Cheza platform
      dt-bindings: arm-smmu: Add generic qcom,smmu-500 bindings
      iommu/arm-smmu-qcom: Move implementation data into match data
      iommu/arm-smmu-qcom: Move the qcom,adreno-smmu check into qcom_smmu_create
      iommu/arm-smmu-qcom: provide separate implementation for SDM845-smmu-500
      iommu/arm-smmu-qcom: Merge table from arm-smmu-qcom-debug into match data
      iommu/arm-smmu-qcom: Stop using mmu500 reset for v2 MMUs
      iommu/arm-smmu-qcom: Add generic qcom,smmu-500 match entry

Fabien Parent (3):
      dt-bindings: iommu: mediatek: add binding documentation for MT8365 SoC
      iommu/mediatek: add support for 6-bit encoded port IDs
      iommu/mediatek: add support for MT8365 SoC

Guenter Roeck (1):
      iommu/mediatek: Validate number of phandles associated with "mediatek,larbs"

Jason Gunthorpe (1):
      iommu/sun50i: Remove IOMMU_DOMAIN_IDENTITY

Jernej Skrabec (5):
      iommu/sun50i: Fix reset release
      iommu/sun50i: Consider all fault sources for reset
      iommu/sun50i: Fix R/W permission check
      iommu/sun50i: Fix flush size
      iommu/sun50i: Implement .iotlb_sync_map

Joerg Roedel (3):
      Merge tag 'for-joerg' of git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd into core
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into arm/smmu
      Merge branches 'arm/allwinner', 'arm/exynos', 'arm/mediatek', 'arm/rockchip', 'arm/smmu', 'ppc/pamu', 's390', 'x86/vt-d', 'x86/amd' and 'core' into next

Kim Phillips (2):
      iommu/amd: Fix ivrs_acpihid cmdline parsing code
      iommu/amd: Fix ill-formed ivrs_ioapic, ivrs_hpet and ivrs_acpihid options

Konrad Dybcio (2):
      dt-bindings: arm-smmu: Add SM6350 GPU SMMUv2
      iommu/arm-smmu-qcom: Add SM6350 SMMUv2

Lu Baolu (20):
      iommu: Add max_pasids field in struct iommu_device
      iommu: Add max_pasids field in struct dev_iommu
      iommu: Remove SVM_FLAG_SUPERVISOR_MODE support
      PCI: Enable PASID only when ACS RR & UF enabled on upstream path
      iommu: Add attach/detach_dev_pasid iommu interfaces
      iommu: Add IOMMU SVA domain support
      iommu/vt-d: Add SVA domain support
      arm-smmu-v3/sva: Add SVA domain support
      iommu/sva: Refactoring iommu_sva_bind/unbind_device()
      iommu: Remove SVA related callbacks from iommu ops
      iommu: Prepare IOMMU domain for IOPF
      iommu: Per-domain I/O page fault handling
      iommu: Rename iommu-sva-lib.{c,h}
      iommu/vt-d: Allocate pasid table in device probe path
      iommu/vt-d: Add device_block_translation() helper
      iommu/vt-d: Add blocking domain support
      iommu/vt-d: Rename iommu_disable_dev_iotlb()
      iommu/vt-d: Rename domain_add_dev_info()
      iommu/vt-d: Remove unnecessary domain_context_mapped()
      iommu/vt-d: Use real field for indication of first level

Marek Szyprowski (1):
      iommu/exynos: Fix driver initialization sequence

Melody Olvera (2):
      dt-bindings: arm-smmu: Add 'compatible' for QDU1000 and QRU1000
      drivers: arm-smmu-impl: Add QDU1000 and QRU1000 iommu implementation

Michael Forney (1):
      iommu/amd: Fix typo in macro parameter name

Michael Riesch (1):
      iommu/rockchip: fix permission bits in page table entries v2

Nicolin Chen (5):
      iommu/amd: Drop unnecessary checks in amd_iommu_attach_device()
      iommu: Add return value rules to attach_dev op and APIs
      iommu: Regulate EINVAL in ->attach_dev callback functions
      iommu: Use EINVAL for incompatible device/domain in ->attach_dev
      iommu: Propagate return value in ->attach_dev callback functions

Niklas Schnelle (11):
      iommu/s390: Fix duplicate domain attachments
      iommu/s390: Get rid of s390_domain_device
      iommu/s390: Fix potential s390_domain aperture shrinking
      iommu/s390: Fix incorrect aperture check
      iommu/s390: Fix incorrect pgsize_bitmap
      iommu/s390: Implement map_pages()/unmap_pages() instead of map()/unmap()
      iommu/s390: Make attach succeed even if the device is in error state
      iommu/s390: Add I/O TLB ops
      iommu/s390: Use RCU to allow concurrent domain_list iteration
      iommu/s390: Optimize IOMMU table walking
      s390/pci: use lock-free I/O translation updates

Ricardo Ribalda (1):
      iommu/mediatek: Fix crash on isr after kexec()

Richard Acayan (1):
      dt-bindings: iommu: arm-smmu: add sdm670 compatible

Robin Murphy (10):
      iommu: Avoid races around device probe
      iommu/mediatek-v1: Update to {map,unmap}_pages
      iommu/sprd: Update to {map,unmap}_pages
      iommu/mediatek: Update to {map,unmap}_pages
      iommu/msm: Update to {map,unmap}_pages
      iommu/ipmmu-vmsa: Update to {map,unmap}_pages
      iommu/qcom: Update to {map,unmap}_pages
      iommu/io-pgtable-arm: Remove map/unmap
      iommu/io-pgtable-arm-v7s: Remove map/unmap
      iommu/io-pgtable: Remove map/unmap

Will Deacon (1):
      Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates

Yang Yingliang (2):
      iommu/mediatek: Check return value after calling platform_get_resource()
      iommu/amd: Fix pci device refcount leak in ppr_notifier()

Yong Wu (5):
      iommu/mediatek: Add platform_device_put for recovering the device refcnt
      iommu/mediatek: Use component_match_add
      iommu/mediatek: Add error path for loop of mm_dts_parse
      iommu/mediatek: Improve safety for mediatek,smi property in larb nodes
      iommu/mediatek: Remove unused "mapping" member from mtk_iommu_data

Yuan Can (1):
      iommu/fsl_pamu: Fix resource leak in fsl_pamu_probe()

 Documentation/admin-guide/kernel-parameters.txt    |  27 +-
 .../devicetree/bindings/iommu/arm,smmu.yaml        | 178 +++++++++-
 .../devicetree/bindings/iommu/mediatek,iommu.yaml  |   2 +
 arch/s390/include/asm/pci.h                        |   5 +-
 arch/s390/kvm/pci.c                                |   6 +-
 arch/s390/pci/pci.c                                |  13 +-
 arch/s390/pci/pci_dma.c                            |  77 +++--
 drivers/dma/idxd/cdev.c                            |   3 +-
 drivers/dma/idxd/init.c                            |  25 +-
 drivers/iommu/Makefile                             |   2 +-
 drivers/iommu/amd/init.c                           |  88 +++--
 drivers/iommu/amd/iommu.c                          |  15 +-
 drivers/iommu/amd/iommu_v2.c                       |   5 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    | 104 +++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  32 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  23 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c         |   3 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c   |  91 -----
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         | 157 ++++++---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h         |  21 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |   3 -
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |  21 +-
 drivers/iommu/exynos-iommu.c                       |  26 +-
 drivers/iommu/fsl_pamu.c                           |   8 +-
 drivers/iommu/fsl_pamu_domain.c                    |   4 +-
 drivers/iommu/intel/dmar.c                         |   7 +
 drivers/iommu/intel/iommu.c                        | 209 ++++++------
 drivers/iommu/intel/iommu.h                        |  33 +-
 drivers/iommu/intel/pasid.c                        |   6 +-
 drivers/iommu/intel/svm.c                          | 145 ++++----
 drivers/iommu/io-pgfault.c                         |  77 +----
 drivers/iommu/io-pgtable-arm-v7s.c                 |  41 +--
 drivers/iommu/io-pgtable-arm.c                     |  42 +--
 drivers/iommu/iommu-sva-lib.c                      |  71 ----
 drivers/iommu/iommu-sva.c                          | 240 +++++++++++++
 drivers/iommu/{iommu-sva-lib.h => iommu-sva.h}     |  14 +-
 drivers/iommu/iommu.c                              | 329 ++++++++++++------
 drivers/iommu/ipmmu-vmsa.c                         |  20 +-
 drivers/iommu/msm_iommu.c                          |  18 +-
 drivers/iommu/mtk_iommu.c                          | 153 ++++++---
 drivers/iommu/mtk_iommu_v1.c                       |  30 +-
 drivers/iommu/omap-iommu.c                         |   6 +-
 drivers/iommu/rockchip-iommu.c                     |  10 +-
 drivers/iommu/s390-iommu.c                         | 377 ++++++++++++---------
 drivers/iommu/sprd-iommu.c                         |  29 +-
 drivers/iommu/sun50i-iommu.c                       |  89 ++++-
 drivers/iommu/tegra-gart.c                         |   2 +-
 drivers/iommu/virtio-iommu.c                       |   7 +-
 drivers/misc/uacce/uacce.c                         |   2 +-
 drivers/pci/ats.c                                  |   3 +
 .../dt-bindings/memory/mediatek,mt8365-larb-port.h |  90 +++++
 include/linux/intel-svm.h                          |  13 -
 include/linux/io-pgtable.h                         |   6 -
 include/linux/iommu.h                              | 128 +++++--
 54 files changed, 1964 insertions(+), 1172 deletions(-)
 delete mode 100644 drivers/iommu/iommu-sva-lib.c
 create mode 100644 drivers/iommu/iommu-sva.c
 rename drivers/iommu/{iommu-sva-lib.h => iommu-sva.h} (83%)
 create mode 100644 include/dt-bindings/memory/mediatek,mt8365-larb-port.h

Please pull.

Thanks,

	Joerg

--1171Dmd0x676ykP7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmOd1rgACgkQK/BELZcB
GuM51w//Y9cFd1f0TH+V1t3glL3czvw9e4C2iiI/8bt+ys9M/s3HSq8pYP3VJ/BI
Zd797CvadgwLrUEvyip3rSE5eA4i2lbsGp30utCqSDaogINSTE2rN7igpcNUtKYo
XqtmTBUbftrDjqu6+Jq9SGFWwmCk+qY31pJtP1x4H9MWEsiQd2Tgyd8IBv4FfVpn
TX9R4XIlqJ0MmNyFTS9aGVp7nGC7N3O9cX6IQJiIXt/SvavX7blUaZGIa7H5w159
irfGnpdDbjmkb2RYuQ32i9GVB6cINKKXkieU8vckk2c6stQcgXrjTk/kP8GHO5/T
h1YhW6qnZdnLY/Gvvi2L9N0O9vo1DGY2+07hUa3n5qqFUBlF1rmDWnoR2lk7nJup
Rf//gU7xXWhzoZBARUf0TTzGILZ2KNZ1Mr9od4z9H6rqVGEFfvARrjnYb3ZxEmYz
RMkSQhloaA8yIilDBD7qOWa944C7Wpl5q+wwqW2FmxTt7i4FIcCM+WUySCa6+X1c
27cJ5AHOCT3zqaCnm44DD8+6f7dC6ACEdEOtvgnVw2N/G+1P9+jw34Oufjo1/ZV6
TtMq/mA6TLnMXOywcubAcou/j+sNmNu8sjd15CbdnDtIxLS4snzAnDWEwBJ59j5k
oCffBzqkpV5LbPTh/s/VEFb9E2rfMajkur2vqPIOU4G15oMjeJw=
=bSZr
-----END PGP SIGNATURE-----

--1171Dmd0x676ykP7--
