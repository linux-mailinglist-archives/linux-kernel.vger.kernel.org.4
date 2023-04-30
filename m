Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DEC6F288F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 13:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjD3LNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 07:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjD3LNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 07:13:16 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F35191988
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 04:13:13 -0700 (PDT)
Received: from 8bytes.org (p5b006afb.dip0.t-ipconnect.de [91.0.106.251])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 7313F245524;
        Sun, 30 Apr 2023 13:13:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1682853192;
        bh=e/hc/sgmTsxL7FqLBZAZ6Sn42+EIFZot5/s/m77y+Hs=;
        h=Date:From:To:Cc:Subject:From;
        b=vblFCCd8Yi9kOHW52IVRCSb9dJvtThZTL4SSCb29kLjiffS4+YFui3vl78T0ZGdrg
         OnsksBv5uHIZmI+2UGYHimQgLp5qMHNJlWxHYFQBrAhc3xU0D8DcWPTWPjRN3sBDlO
         cDaHUw1lRbI+sN5l+G7Q3KT9IOliEPpulUp+lXazzoWnxQ9bBuqjnDBqJ1TDDSgNMl
         Hh7PecVsmslm+ZEwLVmkFI0GJquLv79IiugSa+s9T8b4+hWCA4nO50KJJ60y5vM9nM
         wCPE9EzsMGcEAQGJfj0G/Ef3o9O0Kc2cavNAs4yjLBfeUbzt10CGXkygV6wSfAOeoV
         XLuQd8+1BKC4w==
Date:   Sun, 30 Apr 2023 13:13:11 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [git pull] IOMMU Updates for Linux v6.4
Message-ID: <ZE5NR5Ml8I2/Ze0f@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QjFRXS/P8c4vRLfe"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QjFRXS/P8c4vRLfe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

this pull-request is somewhat messier than usual because it has a lot of
conflicts with your tree. I resolved them in a test-merge and sorted it out
for you to compare your solution to mine (mine is also mostly similar to
the one in linux-next).

My resolution is attached and also available as a branch here:

	git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git pull-test

The resolution branch is compile-tested on x86-64 with defconfig and
allmodconfig, both passed.

With that being said:

The following changes since commit 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d:

  Linux 6.3-rc6 (2023-04-09 11:15:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-u=
pdates-v6.4

for you to fetch changes up to e51b4198396cd715b140c0e8b259680429ff0cfb:

  Merge branches 'iommu/fixes', 'arm/allwinner', 'arm/exynos', 'arm/mediate=
k', 'arm/omap', 'arm/renesas', 'arm/rockchip', 'arm/smmu', 'ppc/pamu', 'uni=
soc', 'x86/vt-d', 'x86/amd', 'core' and 'platform-remove_new' into next (20=
23-04-14 13:45:50 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux 6.4

Including:

	- Convert to platform remove callback returning void

	- Extend changing default domain to normal group

	- Intel VT-d updates:
	    - Remove VT-d virtual command interface and IOASID
	    - Allow the VT-d driver to support non-PRI IOPF
	    - Remove PASID supervisor request support
	    - Various small and misc cleanups

	- ARM SMMU updates:
	    - Device-tree binding updates:
	        * Allow Qualcomm GPU SMMUs to accept relevant clock properties
	        * Document Qualcomm 8550 SoC as implementing an MMU-500
	        * Favour new "qcom,smmu-500" binding for Adreno SMMUs

	    - Fix S2CR quirk detection on non-architectural Qualcomm SMMU
	      implementations

	    - Acknowledge SMMUv3 PRI queue overflow when consuming events

	    - Document (in a comment) why ATS is disabled for bypass streams

	- AMD IOMMU updates:
	    - 5-level page-table support
	    - NUMA awareness for memory allocations

	- Unisoc driver: Support for reattaching an existing domain

	- Rockchip driver: Add missing set_platform_dma_ops callback

	- Mediatek driver: Adjust the dma-ranges

	- Various other small fixes and cleanups

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: arm-smmu: Add compatible for SM8550 SoC

Christophe JAILLET (2):
      iommu/exynos: Use the devm_clk_get_optional() helper
      iommu/vt-d: Do not use GFP_ATOMIC when not needed

Chunyan Zhang (2):
      iommu/sprd: Release dma buffer to avoid memory leak
      iommu/sprd: Add support for reattaching an existing domain

Geert Uytterhoeven (1):
      iommu: Spelling s/cpmxchg64/cmpxchg64/

Jacob Pan (7):
      iommu/vt-d: Remove virtual command interface
      iommu/sva: Move PASID helpers to sva code
      iommu/sva: Remove PASID to mm lookup function
      iommu/sva: Use GFP_KERNEL for pasid allocation
      iommu/ioasid: Rename INVALID_IOASID
      iommu/vt-d: Use non-privileged mode for all PASIDs
      iommu/vt-d: Remove PASID supervisor request support

Jason Gunthorpe (4):
      iommu/sva: Stop using ioasid_set for SVA
      iommu: Remove ioasid infrastructure
      iommu: Make iommu_release_device() static
      iommu: Remove iommu_group_get_by_id()

Jean-Philippe Brucker (1):
      iommu/arm-smmu-v3: Explain why ATS stays disabled with bypass

Jerry Snitselaar (1):
      iommu/amd: Set page size bitmap during V2 domain allocation

Joerg Roedel (2):
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/will/linux into arm/smmu
      Merge branches 'iommu/fixes', 'arm/allwinner', 'arm/exynos', 'arm/med=
iatek', 'arm/omap', 'arm/renesas', 'arm/rockchip', 'arm/smmu', 'ppc/pamu', =
'unisoc', 'x86/vt-d', 'x86/amd', 'core' and 'platform-remove_new' into next

Kishon Vijay Abraham I (1):
      iommu/amd: Fix "Guest Virtual APIC Table Root Pointer" configuration =
in IRTE

Konrad Dybcio (3):
      dt-bindings: arm-smmu: Use qcom,smmu compatible for MMU500 adreno SMM=
Us
      dt-bindings: arm-smmu: Add SM8350 Adreno SMMU
      dt-bindings: arm-smmu: Document SM61[12]5 GPU SMMU

Lu Baolu (14):
      iommu/ipmmu-vmsa: Call arm_iommu_release_mapping() in release path
      iommu: Split iommu_group_remove_device() into helpers
      iommu: Same critical region for device release and removal
      iommu: Move lock from iommu_change_dev_def_domain() to its caller
      iommu: Replace device_lock() with group->mutex
      iommu: Cleanup iommu_change_dev_def_domain()
      iommu: Use sysfs_emit() for sysfs show
      dmaengine: idxd: Add enable/disable device IOPF feature
      iommu/vt-d: Allow SVA with device-specific IOPF
      iommu/vt-d: Move iopf code from SVA to IOPF enabling path
      iommu/vt-d: Move pfsid and ats_qdep calculation to device probe path
      iommu/vt-d: Move PRI handling to IOPF feature path
      iommu/vt-d: Remove unnecessary checks in iopf disabling path
      iommu/vt-d: Remove extern from function prototypes

Manivannan Sadhasivam (1):
      iommu/arm-smmu-qcom: Limit the SMR groups to 128

Nick Alcock (1):
      iommu/sun50i: remove MODULE_LICENSE in non-modules

Randy Dunlap (1):
      iommu/fsl: fix all kernel-doc warnings in fsl_pamu.c

Rob Herring (2):
      iommu: Use of_property_present() for testing DT property presence
      iommu/omap: Use of_property_read_bool() for boolean properties

Steven Price (1):
      iommu/rockchip: Add missing set_platform_dma_ops callback

Thomas Wei=DFschuh (1):
      iommu: Make kobj_type structure constant

Tina Zhang (7):
      iommu/vt-d: Make size of operands same in bitwise operations
      iommu/vt-d: Remove BUG_ON on checking valid pfn range
      iommu/vt-d: Remove BUG_ON in handling iotlb cache invalidation
      iommu/vt-d: Remove BUG_ON when domain->pgd is NULL
      iommu/vt-d: Remove BUG_ON in map/unmap()
      iommu/vt-d: Remove a useless BUG_ON(dev->is_virtfn)
      iommu/vt-d: Remove BUG_ON in dmar_insert_dev_scope()

Tomas Krcka (1):
      iommu/arm-smmu-v3: Acknowledge pri/event queue overflow if any

Uwe Kleine-K=F6nig (10):
      iommu/arm-smmu: Drop if with an always false condition
      iommu/apple-dart: Convert to platform remove callback returning void
      iommu/arm-smmu-v3: Convert to platform remove callback returning void
      iommu/arm-smmu: Convert to platform remove callback returning void
      iommu/ipmmu-vmsa: Convert to platform remove callback returning void
      iommu/msm: Convert to platform remove callback returning void
      iommu/mtk: Convert to platform remove callback returning void
      iommu/mtk_iommu_v1: Convert to platform remove callback returning void
      iommu/omap: Convert to platform remove callback returning void
      iommu/sprd: Convert to platform remove callback returning void

Vasant Hegde (3):
      iommu/amd: Allocate page table using numa locality info
      iommu/amd: Allocate IOMMU irqs using numa locality info
      iommu/amd: Add 5 level guest page table support

Will Deacon (1):
      Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/up=
dates

Wolfram Sang (1):
      iommu/ipmmu-vmsa: remove R-Car H3 ES1.* handling

Yong Wu (15):
      iommu/mediatek: Set dma_mask for PGTABLE_PA_35_EN
      dt-bindings: media: mediatek,vcodec: Remove dma-ranges property
      dt-bindings: media: mediatek,jpeg: Remove dma-ranges property
      iommu/mediatek: Improve comment for the current region/bank
      iommu/mediatek: Get regionid from larb/port id
      iommu/mediatek: mt8192: Add iova_region_larb_msk
      iommu/mediatek: mt8195: Add iova_region_larb_msk
      iommu/mediatek: mt8186: Add iova_region_larb_msk
      iommu/mediatek: Add a gap for the iova regions
      iommu/mediatek: Set dma_mask for the master devices
      media: mtk-jpegdec: Remove the setting for dma_mask
      media: mediatek: vcodec: Remove the setting for dma_mask
      arm64: dts: mt8195: Remove the unnecessary dma-ranges
      arm64: dts: mt8195: Add dma-ranges for the parent "soc" node
      arm64: dts: mt8186: Add dma-ranges for the parent "soc" node

Yoshihiro Shimoda (1):
      dt-bindings: iommu: renesas, ipmmu-vmsa: Update for R-Car Gen4

 .../ABI/testing/sysfs-kernel-iommu_groups          |   1 -
 .../devicetree/bindings/iommu/arm,smmu.yaml        |  45 ++-
 .../bindings/iommu/renesas,ipmmu-vmsa.yaml         |  32 +-
 .../bindings/media/mediatek,mt8195-jpegdec.yaml    |   7 -
 .../bindings/media/mediatek,mt8195-jpegenc.yaml    |   7 -
 .../bindings/media/mediatek,vcodec-decoder.yaml    |   5 -
 .../bindings/media/mediatek,vcodec-encoder.yaml    |   5 -
 .../bindings/media/mediatek-jpeg-encoder.yaml      |   5 -
 Documentation/x86/sva.rst                          |   2 +-
 arch/arm64/boot/dts/mediatek/mt8186.dtsi           |   1 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi           |   4 +-
 arch/x86/kernel/traps.c                            |   2 +-
 drivers/dma/idxd/device.c                          |   8 +-
 drivers/dma/idxd/idxd.h                            |   2 +-
 drivers/dma/idxd/init.c                            |  33 +-
 drivers/dma/idxd/irq.c                             |   2 +-
 drivers/iommu/Kconfig                              |   9 +-
 drivers/iommu/Makefile                             |   1 -
 drivers/iommu/amd/amd_iommu.h                      |   9 +
 drivers/iommu/amd/amd_iommu_types.h                |  12 +-
 drivers/iommu/amd/init.c                           |  30 +-
 drivers/iommu/amd/io_pgtable.c                     |   4 +-
 drivers/iommu/amd/io_pgtable_v2.c                  |  25 +-
 drivers/iommu/amd/iommu.c                          |  17 +-
 drivers/iommu/apple-dart.c                         |   6 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  32 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |  16 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |  14 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |  12 +-
 drivers/iommu/exynos-iommu.c                       |  24 +-
 drivers/iommu/fsl_pamu.c                           |   9 +-
 drivers/iommu/intel/cap_audit.c                    |   2 -
 drivers/iommu/intel/dmar.c                         |  13 +-
 drivers/iommu/intel/iommu.c                        | 277 ++++++--------
 drivers/iommu/intel/iommu.h                        |  35 +-
 drivers/iommu/intel/irq_remapping.c                |   2 +-
 drivers/iommu/intel/pasid.c                        |  43 ---
 drivers/iommu/intel/pasid.h                        |   7 -
 drivers/iommu/intel/svm.c                          |   3 +-
 drivers/iommu/ioasid.c                             | 422 -----------------=
----
 drivers/iommu/iommu-sva.c                          |  61 +--
 drivers/iommu/iommu-sva.h                          |   4 -
 drivers/iommu/iommu.c                              | 347 +++++++----------
 drivers/iommu/ipmmu-vmsa.c                         |  23 +-
 drivers/iommu/msm_iommu.c                          |   5 +-
 drivers/iommu/mtk_iommu.c                          | 158 ++++++--
 drivers/iommu/mtk_iommu_v1.c                       |   5 +-
 drivers/iommu/omap-iommu.c                         |   7 +-
 drivers/iommu/rockchip-iommu.c                     |  61 ++-
 drivers/iommu/sprd-iommu.c                         |  60 ++-
 drivers/iommu/sun50i-iommu.c                       |   1 -
 .../media/platform/mediatek/jpeg/mtk_jpeg_core.c   |   3 -
 .../platform/mediatek/vcodec/mtk_vcodec_dec_drv.c  |   8 -
 .../platform/mediatek/vcodec/mtk_vcodec_enc_drv.c  |   3 -
 include/linux/ioasid.h                             |  83 ----
 include/linux/iommu.h                              |  21 +-
 include/linux/sched/mm.h                           |  26 --
 kernel/fork.c                                      |   1 +
 mm/init-mm.c                                       |   4 +-
 59 files changed, 789 insertions(+), 1277 deletions(-)
 delete mode 100644 drivers/iommu/ioasid.c
 delete mode 100644 include/linux/ioasid.h

Please pull.

Thanks,

	Joerg

diff --cc arch/x86/kernel/process_64.c
index 223b223f713f,bb65a68b4b49..3d181c16a2f6
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@@ -39,6 -39,6 +39,7 @@@
  #include <linux/io.h>
  #include <linux/ftrace.h>
  #include <linux/syscalls.h>
++#include <linux/iommu.h>
 =20
  #include <asm/processor.h>
  #include <asm/pkru.h>
diff --cc drivers/iommu/iommu-sva.c
index dd76a1a09cf7,c434b95dc8eb..5d4bb11dde01
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@@ -10,26 -9,14 +10,14 @@@
  #include "iommu-sva.h"
 =20
  static DEFINE_MUTEX(iommu_sva_lock);
- static DECLARE_IOASID_SET(iommu_sva_pasid);
+ static DEFINE_IDA(iommu_global_pasid_ida);
 =20
- /**
-  * iommu_sva_alloc_pasid - Allocate a PASID for the mm
-  * @mm: the mm
-  * @min: minimum PASID value (inclusive)
-  * @max: maximum PASID value (inclusive)
-  *
-  * Try to allocate a PASID for this mm, or take a reference to the existi=
ng one
-  * provided it fits within the [@min, @max] range. On success the PASID is
-  * available in mm->pasid and will be available for the lifetime of the m=
m.
-  *
-  * Returns 0 on success and < 0 on error.
-  */
- int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t ma=
x)
+ /* Allocate a PASID for the mm within range (inclusive) */
+ static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioas=
id_t max)
  {
  	int ret =3D 0;
- 	ioasid_t pasid;
 =20
- 	if (min =3D=3D INVALID_IOASID || max =3D=3D INVALID_IOASID ||
 -	if (!pasid_valid(min) || !pasid_valid(max) ||
++	if (min =3D=3D IOMMU_PASID_INVALID || max =3D=3D IOMMU_PASID_INVALID ||
  	    min =3D=3D 0 || max < min)
  		return -EINVAL;
 =20
@@@ -44,11 -28,11 +32,12 @@@
  		goto out;
  	}
 =20
- 	pasid =3D ioasid_alloc(&iommu_sva_pasid, min, max, mm);
- 	if (pasid =3D=3D INVALID_IOASID)
- 		ret =3D -ENOMEM;
- 	else
- 		mm_pasid_set(mm, pasid);
+ 	ret =3D ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
+ 	if (ret < min)
+ 		goto out;
+ 	mm->pasid =3D ret;
+ 	ret =3D 0;
++
  out:
  	mutex_unlock(&iommu_sva_lock);
  	return ret;
@@@ -242,3 -205,11 +210,11 @@@ out_put_mm
 =20
  	return status;
  }
+=20
+ void mm_pasid_drop(struct mm_struct *mm)
+ {
 -	if (likely(!pasid_valid(mm->pasid)))
++	if (likely(!mm_valid_pasid(mm)))
+ 		return;
+=20
+ 	ida_free(&iommu_global_pasid_ida, mm->pasid);
+ }
diff --cc drivers/iommu/iommu.c
index 807c98de40d4,153a3dab568c..f1dcfa3f1a1b
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@@ -88,9 -87,10 +88,10 @@@ static const char * const iommu_group_r
 =20
  static int iommu_bus_notifier(struct notifier_block *nb,
  			      unsigned long action, void *data);
+ static void iommu_release_device(struct device *dev);
  static int iommu_alloc_default_domain(struct iommu_group *group,
  				      struct device *dev);
 -static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 +static struct iommu_domain *__iommu_domain_alloc(const struct bus_type *b=
us,
  						 unsigned type);
  static int __iommu_attach_device(struct iommu_domain *domain,
  				 struct device *dev);
diff --cc include/linux/iommu.h
index 0fd4e6734d5b,7dbdd13d7ce0..e8c9a7da1060
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@@ -455,12 -455,11 +455,11 @@@ static inline const struct iommu_ops *d
  	return dev->iommu->iommu_dev->ops;
  }
 =20
 -extern int bus_iommu_probe(struct bus_type *bus);
 -extern bool iommu_present(struct bus_type *bus);
 +extern int bus_iommu_probe(const struct bus_type *bus);
 +extern bool iommu_present(const struct bus_type *bus);
  extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
  extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
 -extern struct iommu_domain *iommu_domain_alloc(struct bus_type *bus);
 +extern struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus=
);
- extern struct iommu_group *iommu_group_get_by_id(int id);
  extern void iommu_domain_free(struct iommu_domain *domain);
  extern int iommu_attach_device(struct iommu_domain *domain,
  			       struct device *dev);
@@@ -1172,7 -1165,17 +1165,16 @@@ static inline bool tegra_dev_iommu_get_
  	return false;
  }
 =20
 -static inline bool pasid_valid(ioasid_t ioasid)
 -{
 -	return ioasid !=3D IOMMU_PASID_INVALID;
 -}
 -
  #ifdef CONFIG_IOMMU_SVA
+ static inline void mm_pasid_init(struct mm_struct *mm)
+ {
+ 	mm->pasid =3D IOMMU_PASID_INVALID;
+ }
++static inline bool mm_valid_pasid(struct mm_struct *mm)
++{
++	return mm->pasid !=3D IOMMU_PASID_INVALID;
++}
+ void mm_pasid_drop(struct mm_struct *mm);
  struct iommu_sva *iommu_sva_bind_device(struct device *dev,
  					struct mm_struct *mm);
  void iommu_sva_unbind_device(struct iommu_sva *handle);
@@@ -1192,6 -1195,8 +1194,9 @@@ static inline u32 iommu_sva_get_pasid(s
  {
  	return IOMMU_PASID_INVALID;
  }
+ static inline void mm_pasid_init(struct mm_struct *mm) {}
++static inline bool mm_valid_pasid(struct mm_struct *mm) { return false; }
+ static inline void mm_pasid_drop(struct mm_struct *mm) {}
  #endif /* CONFIG_IOMMU_SVA */
 =20
  #endif /* __LINUX_IOMMU_H */
diff --cc kernel/fork.c
index 735d9f4f5acf,e7d10ad98a69..ed4e01daccaa
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@@ -97,7 -97,7 +97,8 @@@
  #include <linux/io_uring.h>
  #include <linux/bpf.h>
  #include <linux/stackprotector.h>
 +#include <linux/user_events.h>
+ #include <linux/iommu.h>
 =20
  #include <asm/pgalloc.h>
  #include <linux/uaccess.h>

--QjFRXS/P8c4vRLfe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmROTUMACgkQK/BELZcB
GuNUxxAAq0CiB0lSMRwvaLb06rtykJSqbHf93LrFnpuZEDeYrb52hwfUtOdjmgwz
RrExvMQKoiW6y6Kak5Rn5/TXwRzZqPg5TPDyb5ych6hmndQg3zY92t7jv+N4lB8G
hh8f6t7eKSgb9FjFAIjdFdMtZUvdRRhqz6I7XWRbvrXHlC2bURwUWk7r3VOixBwd
6xyjEV+4oewe8r6PMBHDtiJ2UN47cOHtO7fEgm1Ms6zfOF09b63xhYFP2MI5cZED
b6SIlZ2+HppBP/ln+LlfIDlZEZWjjorPaE9v9VcssxZiHqc/pC51aTh6DBHYYNjU
yXbiyUvo3P599gYKwIr3WXce5ygFcqHPGjPdOPffbXSOulQW6+uV4Dh7ThsA/I5K
JH47mLbGNql+DJ6XoFJJQBeEKclZhNclPGlZdVJ4YpfFfBsDjI55uSPy3zqd+W7N
0hKEksZFQ0cJ3rtxcz+l8nV2zJfvqTysBxJF+182h2inibiM0a3xRmR2SMPMySec
LO3lTbsETj80nXPyYMYspkV7kb9dDPZg0EZGSOnbp6uV3qvJ2uY8Bpr2Nw8H7U2h
cUHLxmABvP5thTLwdv5AkZDBoWSHSxnbYC4wKxHtyXww/71otgn3NpsIPO9iQ/7b
zg/IVpdjyuZTgc21iJ1/L0EV4egbx8vlNlmkAqzXFmDBuu4F9yQ=
=FCEu
-----END PGP SIGNATURE-----

--QjFRXS/P8c4vRLfe--
