Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BA45E57DC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiIVBNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiIVBNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:13:01 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DCE4E620
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 18:12:55 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DC22F5C00AE;
        Wed, 21 Sep 2022 21:12:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 21 Sep 2022 21:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1663809174; x=1663895574; bh=enpNk7D22O
        rhfKgczdlhV3ST7IUTsOP//CWl583ukHw=; b=2TMBMUQ3JvaFhv7ofjr4mBzfhh
        ZA9yMd7hZx9DsE+1wd/lcaEWpBJzvfa15pZfbaD1habTvkwcRU7PnlIjXGuwHy2N
        BsEAIEUojil6wshBB9rJrOCUMfWcSy065fRnvHi7y7T0kTGcwhKupsIUD7+yZ8OF
        6mm9Rtr8FO8HTv5TDuFlAD4g43/fK7Sz9ARk2oWQEppYwUgv4kRBEScj8pLvV5Zb
        HWVgxKTwCoDyRIFBxneH9cfhILbw7xNs1PI8rcxxJeYzZIzXu4eA9Xajyi7BhQcS
        ZMQo8DkUmPYMfW5xntKbqUNV6kGegUnKEE8ExCJPJNLBTG6tAZI+C9bz/LbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663809174; x=1663895574; bh=enpNk7D22OrhfKgczdlhV3ST7IUT
        sOP//CWl583ukHw=; b=idkEbL8c16dXZ/DFBWOFr5152UyTNL0vkDrjIn308gBo
        tDmU0BqF/o2s1NrTnnbDCIKTzgmv+ytcIE0jRLVDT0lhBX+mCF4SbHYojnJK3FTX
        QvQdEYfKHeOquJejFEksLMMQr18tyn62A+PocS4emx6xHAPISAofiGeh4wNyAgGX
        lI15kWPkTHENcF1d89arP6dU+upJ2Q23GzAG2M/CvYA3Ox2Kz4rkbtZv6YsfA5si
        evBS08kFXyWw8JForxfyilgWDCo/87ldGhAqd3EvNOde7xL0LowgvKtiXsyp5NqI
        Cp+cYdyh5vIzKEibL/NUBHuNEbPX5k6IluwP9uEVHw==
X-ME-Sender: <xms:lbYrY9f7E1Wjjx_wYzU9FxOEnYmlmD7qcRceA5Jl5i42PkHCMx8i1A>
    <xme:lbYrY7OA7xGf78gXvJhD0txG10fWIIL2TPyMuVjdb6RMwFpbVV4jUfRaJOdgmKNu3
    T3gWNqdqehiKNQ_Uw>
X-ME-Received: <xmr:lbYrY2j2_qajAW3kPxUd3j5T7-r3d0xLR2H76lHa0mOLJHdSR-0qQx3OwdedlrmGTzd4XEPEvKdYbaJYFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefvddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpedvieeutd
    ehtddthfegveekueevfedvueehjeeltdevgfejteekudfgvdelveekffenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:lbYrY2_Gs8i9tTzZZCOn5g8hO3nT8zyrr7oo8OchrS6V0hDoZjucYw>
    <xmx:lbYrY5v7amUxK2I5FMLaWs-p-8-bgMkffOXLqa4YIBZXTXumZzSvJw>
    <xmx:lbYrY1H_ZCoPlY54C-be6-I-qFju9ad4ovf5tvfAVeq3Eq53hJeb1g>
    <xmx:lrYrY6PzMAVecS6EGO-iwXOpGWhhQ8ZkjdlKP_PQJ5cm6_AbelRsZA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Sep 2022 21:12:53 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org
Cc:     Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        James Houghton <jthoughton@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 00/12] Make MAX_ORDER adjustable as a kernel boot time parameter.
Date:   Wed, 21 Sep 2022 21:12:40 -0400
Message-Id: <20220922011252.2266780-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Hi all,

This patchset adds support for kernel boot time adjustable MAX_ORDER, so th=
at
user can change the largest size of pages buddy allocator allocates.
It is on top of mm-everything-2022-09-19-00-45.

Changelog
=3D=3D=3D
From RFCv2

1. Dropped RFC, collected reviewed-by.
2. Added back page validation check in find_buddy_page_pfn() since it is
needed when zone is not contiguous.
3. Converted MAX_ORDER sized static array used in recently added kmsan code=
 to
a dynamic one.

Motivation
=3D=3D=3D

This enables kernel to allocate 1GB pages and is necessary for my ongoing w=
ork
on adding support for 1GB PUD THP[1]. This is also the conclusion I came up=
 with
after some discussion with David Hildenbrand on what methods should be used=
 for
allocating gigantic pages[2], since other approaches like using CMA allocat=
or or
alloc_contig_pages() are regarded as suboptimal.

In addition, make MAX_ORDER a kernel boot time parameter can enable user to
adjust buddy allocator without recompiling the kernel for their own needs, =
so
that one can still have a small MAX_ORDER if he/she does not need to alloca=
te
gigantic pages like 1GB PUD THPs.

Background
=3D=3D=3D

At the moment, kernel imposes MAX_ORDER - 1 + PAGE_SHFIT < SECTION_SIZE_BITS
restriction. This prevents buddy allocator merging pages across memory sect=
ions,
as PFNs might not be contiguous and code like page++ would fail. But this w=
ould
not be an issue when SPARSEMEM_VMEMMAP is set, since all struct page are
virtually contiguous. So boot time adjustable MAX_ORDER depends on
SPARSEMEM_VMEMMAP.

Description
=3D=3D=3D

I tested the patchset on both x86_64 and ARM64 at 4KB base pages. The syste=
ms
boot and run.

In terms of the concerns on performance degradation if MAX_ORDER is increas=
ed,
I run vm-scalability from lkp comparing current system, my patchset with
MAX_ORDER=3D11 and my patchset with MAX_ORDER=3D20 on a x86_64 VM and saw
almost no performance difference, please vm-scalability reports in the
RFCv2: https://lore.kernel.org/linux-mm/20220811231643.1012912-1-zi.yan@sen=
t.com/

Patch 1 changes MAX_ORDER to represent the max order of pages allocated
by buddy allocator. right now MAX_ORDER - 1 represents that and it is
confusing. Suggested by Vlastimil Babka. checkpatch.pl is updated to
warn future use of MAX_ORDER, since its semantics is changed.

Patch 2 adds a page validation in find_buddy_page_pfn() when zone is not
contiguous, since some pages in the middle of a zone can be invalid.

Patch 3 make deferred struct page initialization work when MAX_ORDER is
bigger than a memory section size.

Patch 4-7 convert the use of MAX_ORDER to pageblock_order. Since
pageblock_order is a constant when MAX_ORDER can be changed at boot time
and close to current MAX_ORDER value. I separate changes to different patch=
es
for easy review and can merge them into a single one if that works better.

Patch 8 replaces MAX_ORDER with MAX_PHYS_CONTIG_ORDER when it is used to
indicate the maximum number of physically contiguous pages.

Patch 9 adds a new Kconfig option SET_MAX_ORDER to allow specifying MAX_ORD=
ER
when ARCH_FORCE_MAX_ORDER is not used by the arch, like x86_64.

Patch 10 converts statically allocated arrays with MAX_ORDER length to dyna=
mic
ones if possible and prepares for making MAX_ORDER a boot time parameter.

Patch 11 adds a new MIN_MAX_ORDER constant to replace soon-to-be-dynamic
MAX_ORDER for places where converting static array to dynamic one is causing
hassle and not necessary, i.e., ARM64 hypervisor page allocation and SLAB.

Patch 12 changes MAX_ORDER to be a kernel boot time parameter and it is
opt-in as an mm/Kconfig option.


Any suggestion and/or comment is welcome. Thanks.


[1] https://lore.kernel.org/linux-mm/20200928175428.4110504-1-zi.yan@sent.c=
om/
[2] https://lore.kernel.org/linux-mm/e132fdd9-65af-1cad-8a6e-71844ebfe6a2@r=
edhat.com/

Zi Yan (12):
  mm: rectify MAX_ORDER semantics to be the largest page order from
    buddy allocator
  mm: check page validity when find a buddy page in a non-contiguous
    zone
  mm: adapt deferred struct page init to new MAX_ORDER.
  mm: prevent pageblock size being larger than section size.
  fs: proc: use pageblock_nr_pages for reschedule period in read_kcore()
  virtio: virtio_balloon: use pageblock_order instead of MAX_ORDER
  mm/page_reporting: set page_reporting_order to -1 to prevent it
    running
  mm: replace MAX_ORDER when it is used to indicate max physical
    contiguity.
  mm: Make MAX_ORDER of buddy allocator configurable via Kconfig
    SET_MAX_ORDER.
  mm: convert MAX_ORDER sized static arrays to dynamic ones.
  mm: introduce MIN_MAX_ORDER to replace MAX_ORDER as compile time
    constant.
  mm: make MAX_ORDER a kernel boot time parameter.

 .../admin-guide/kdump/vmcoreinfo.rst          |   4 +-
 .../admin-guide/kernel-parameters.txt         |   9 +-
 arch/Kconfig                                  |   4 +
 arch/arc/Kconfig                              |   4 +-
 arch/arm/Kconfig                              |  12 +-
 arch/arm/configs/imx_v6_v7_defconfig          |   2 +-
 arch/arm/configs/milbeaut_m10v_defconfig      |   2 +-
 arch/arm/configs/oxnas_v6_defconfig           |   2 +-
 arch/arm/configs/pxa_defconfig                |   2 +-
 arch/arm/configs/sama7_defconfig              |   2 +-
 arch/arm/configs/sp7021_defconfig             |   2 +-
 arch/arm64/Kconfig                            |  16 +--
 arch/arm64/include/asm/sparsemem.h            |   2 +-
 arch/arm64/kvm/hyp/include/nvhe/gfp.h         |   2 +-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c          |   2 +-
 arch/csky/Kconfig                             |   2 +-
 arch/ia64/Kconfig                             |   8 +-
 arch/ia64/include/asm/sparsemem.h             |   4 +-
 arch/ia64/mm/hugetlbpage.c                    |   2 +-
 arch/loongarch/Kconfig                        |  16 +--
 arch/m68k/Kconfig.cpu                         |   8 +-
 arch/mips/Kconfig                             |  22 ++-
 arch/nios2/Kconfig                            |  10 +-
 arch/powerpc/Kconfig                          |  30 ++---
 arch/powerpc/configs/85xx/ge_imp3a_defconfig  |   2 +-
 arch/powerpc/configs/fsl-emb-nonhw.config     |   2 +-
 arch/powerpc/mm/book3s64/iommu_api.c          |   2 +-
 arch/powerpc/mm/hugetlbpage.c                 |   2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c     |   2 +-
 arch/sh/configs/ecovec24_defconfig            |   2 +-
 arch/sh/mm/Kconfig                            |  20 ++-
 arch/sparc/Kconfig                            |   8 +-
 arch/sparc/kernel/pci_sun4v.c                 |   2 +-
 arch/sparc/kernel/traps_64.c                  |   2 +-
 arch/sparc/mm/tsb.c                           |   4 +-
 arch/um/kernel/um_arch.c                      |   4 +-
 arch/xtensa/Kconfig                           |   8 +-
 drivers/base/regmap/regmap-debugfs.c          |   8 +-
 drivers/crypto/hisilicon/sgl.c                |   6 +-
 .../gpu/drm/i915/gem/selftests/huge_pages.c   |   2 +-
 drivers/gpu/drm/ttm/ttm_device.c              |   7 +-
 drivers/gpu/drm/ttm/ttm_pool.c                |  72 ++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   2 +-
 drivers/irqchip/irq-gic-v3-its.c              |   4 +-
 drivers/md/dm-bufio.c                         |   2 +-
 drivers/misc/genwqe/card_utils.c              |   2 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |   2 +-
 drivers/net/ethernet/ibm/ibmvnic.h            |   2 +-
 drivers/video/fbdev/hyperv_fb.c               |   6 +-
 drivers/virtio/virtio_balloon.c               |   2 +-
 drivers/virtio/virtio_mem.c                   |   8 +-
 fs/proc/kcore.c                               |   2 +-
 fs/ramfs/file-nommu.c                         |   2 +-
 include/drm/ttm/ttm_pool.h                    |   4 +-
 include/linux/hugetlb.h                       |   2 +-
 include/linux/mmzone.h                        |  36 ++++-
 include/linux/pageblock-flags.h               |  21 ++-
 include/linux/slab.h                          |   8 +-
 kernel/crash_core.c                           |   2 +-
 kernel/dma/pool.c                             |   8 +-
 kernel/events/ring_buffer.c                   |   2 +-
 mm/Kconfig                                    |  33 ++++-
 mm/compaction.c                               |   8 +-
 mm/debug_vm_pgtable.c                         |   4 +-
 mm/huge_memory.c                              |   2 +-
 mm/hugetlb.c                                  |   4 +-
 mm/internal.h                                 |   8 +-
 mm/kmsan/init.c                               |  18 ++-
 mm/memblock.c                                 |   8 +-
 mm/memory.c                                   |   4 +-
 mm/memory_hotplug.c                           |   6 +-
 mm/page_alloc.c                               | 127 +++++++++++++-----
 mm/page_isolation.c                           |  14 +-
 mm/page_owner.c                               |   6 +-
 mm/page_reporting.c                           |   8 +-
 mm/shuffle.h                                  |   2 +-
 mm/slab.c                                     |   2 +-
 mm/slub.c                                     |   6 +-
 mm/vmscan.c                                   |   1 -
 mm/vmstat.c                                   |  14 +-
 net/smc/smc_ib.c                              |   2 +-
 scripts/checkpatch.pl                         |   8 ++
 security/integrity/ima/ima_crypto.c           |   2 +-
 tools/testing/memblock/linux/mmzone.h         |   6 +-
 84 files changed, 462 insertions(+), 272 deletions(-)

--=20
2.35.1

