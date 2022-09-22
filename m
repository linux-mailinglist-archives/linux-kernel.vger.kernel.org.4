Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B025E57E0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiIVBNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiIVBND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:13:03 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4704A54CA3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 18:13:02 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B15CF5C0170;
        Wed, 21 Sep 2022 21:13:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 21 Sep 2022 21:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663809181; x=
        1663895581; bh=drAyzX7q0CQRps8Kpo+CSOrvAuWQIQAnWi+G2OzIrVU=; b=i
        GuLuO3jU2GQuuLSP5rquoJ9Q66R9kNIQ06+wnMo83snRE++DdvM+3D/Qr3/PS7dL
        ZyOqx8UdYyIIUcZyAKFwdWzoDRpqtLgdHyj9dPY4Gg20oEc3sAvwHRiECv9sJJQe
        UPnHxjeMV+J4wwT2/4O75pzgRIqW+AcGKtSb6rAmMV0FvXg1D8s5GiURoFusv3OA
        E9SnpY4j7t3CdnUGeGnWHgWpZn1HM265Wtrvpmd9mXSAFt1nYo5Q7hYYmc3jYrII
        N8YXijBBCwM3rTvotVGVdFPFt0XGP4Q/0080WOwndFipQogqj/DNjYBQklbhYNya
        OVl/lw8ZAl9jtyzvZbtQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1663809181; x=1663895581; bh=d
        rAyzX7q0CQRps8Kpo+CSOrvAuWQIQAnWi+G2OzIrVU=; b=zvW5wzKvkvNzVbc6S
        GlLj8OKCD6LGmwYPQNZJPP18bJ5OLK50VTs/Kz1A5qZXr8jN8CQyJPE8n1NCxa7/
        shDr0aEQfZR9Ub800iz4TXEvRm2CRTRlabieZQQKOkz2iCE3BVe+SgZ8x69Ltk2O
        nvFPy3tWJ4Kz5Pdo8iKevp84USnXo7BVbd1Ux5emLK7m0+qzO9F3jnmymg2lUocc
        z1RWcLtktLIV5Sm3wvpKmiy5is7Y2yVbDpcTSPUUO2L8LNkoUMKWvcn45t3P/RCp
        9o2GVYxmJN+GBw1csGAFLZHEXLzTdir9qCT0sUDqU6EZPeujEPlevqsKspnpfGXk
        XdjqA==
X-ME-Sender: <xms:nbYrYwcjAcNQ-LSrFAL9XsfSnEniR3O-PH54TGWkQ8qIEjRJC_5Duw>
    <xme:nbYrYyNQXrEURDQwbBlylBLyyikldG5STzVBZYmAqA4ZPJNhiJEuqMK10s96ITUOi
    UH4CDm1lYbpKr4q1g>
X-ME-Received: <xmr:nbYrYxjpy3IKaySa8lPUWcoQs61yMpEe28pTbK9NCfjKovQsQWk5E2_RrX-OTiEzB4YElRu2bbKdORY-IQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefvddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:nbYrY187QQvOHdXKmiB9l9HaMHdqeeHqWfBG8TCmuYetJFdZ0ByIeQ>
    <xmx:nbYrY8tl9b9euwu14SezUWU4kRuZvMDa9bPfRReaizAYWB9aNXvX-g>
    <xmx:nbYrY8FV-5Zpn5t2jRmDMQ6ndpDJlmUP7l17fyvX3TjZjbBGnNteRg>
    <xmx:nbYrY5OjF3fJ1TQ8XZcuRsDwl98v8T2YGk620_MzW5N94Ud-NKNYzw>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Sep 2022 21:13:00 -0400 (EDT)
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
Subject: [PATCH v1 08/12] mm: replace MAX_ORDER when it is used to indicate max physical contiguity.
Date:   Wed, 21 Sep 2022 21:12:48 -0400
Message-Id: <20220922011252.2266780-9-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220922011252.2266780-1-zi.yan@sent.com>
References: <20220922011252.2266780-1-zi.yan@sent.com>
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

MAX_ORDER is limited at a memory section size, thus widely used as
a variable to indicate maximum physically contiguous page size. But this
limitation is no longer necessary as kernel only supports sparse memory
model. Add a new variable MAX_PHYS_CONTIG_ORDER to replace such uses of
MAX_ORDER.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 arch/sparc/mm/tsb.c                             |  4 ++--
 arch/um/kernel/um_arch.c                        |  4 ++--
 include/linux/pageblock-flags.h                 | 12 ++++++++++++
 kernel/dma/pool.c                               |  8 ++++----
 mm/hugetlb.c                                    |  2 +-
 mm/internal.h                                   |  2 +-
 mm/memory.c                                     |  4 ++--
 mm/memory_hotplug.c                             |  6 +++---
 mm/page_isolation.c                             |  2 +-
 mm/page_reporting.c                             |  2 +-
 11 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
index e1094851c328..5f633844daac 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3907,7 +3907,7 @@
 			[KNL] Minimal page reporting order
 			Format: <integer>
 			Adjust the minimal page reporting order. The page
-			reporting is disabled when it exceeds MAX_ORDER.
+			reporting is disabled when it exceeds MAX_PHYS_CONTIG_ORDER.
=20
 	panic=3D		[KNL] Kernel behaviour on panic: delay <timeout>
 			timeout > 0: seconds before rebooting
diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index 912205787161..15c31d050dab 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -402,8 +402,8 @@ void tsb_grow(struct mm_struct *mm, unsigned long tsb_i=
ndex, unsigned long rss)
 	unsigned long new_rss_limit;
 	gfp_t gfp_flags;
=20
-	if (max_tsb_size > (PAGE_SIZE << MAX_ORDER))
-		max_tsb_size =3D (PAGE_SIZE << MAX_ORDER);
+	if (max_tsb_size > (PAGE_SIZE << MAX_PHYS_CONTIG_ORDER))
+		max_tsb_size =3D (PAGE_SIZE << MAX_PHYS_CONTIG_ORDER);
=20
 	new_cache_index =3D 0;
 	for (new_size =3D 8192; new_size < max_tsb_size; new_size <<=3D 1UL) {
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index e0de60e503b9..52a474f4f1c7 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -368,10 +368,10 @@ int __init linux_main(int argc, char **argv)
 	max_physmem =3D TASK_SIZE - uml_physmem - iomem_size - MIN_VMALLOC;
=20
 	/*
-	 * Zones have to begin on a 1 << MAX_ORDER page boundary,
+	 * Zones have to begin on a 1 << MAX_PHYS_CONTIG_ORDER page boundary,
 	 * so this makes sure that's true for highmem
 	 */
-	max_physmem &=3D ~((1 << (PAGE_SHIFT + MAX_ORDER)) - 1);
+	max_physmem &=3D ~((1 << (PAGE_SHIFT + MAX_PHYS_CONTIG_ORDER)) - 1);
 	if (physmem_size + iomem_size > max_physmem) {
 		highmem =3D physmem_size + iomem_size - max_physmem;
 		physmem_size -=3D highmem;
diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flag=
s.h
index 95589b24fff9..5469ba6f97c1 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -61,6 +61,18 @@ extern unsigned int pageblock_order;
 #define pageblock_start_pfn(pfn)	ALIGN_DOWN((pfn), pageblock_nr_pages)
 #define pageblock_end_pfn(pfn)		ALIGN((pfn) + 1, pageblock_nr_pages)
=20
+/*
+ * memory section is only defined in sparsemem and in flatmem, pages are a=
lways
+ * physically contiguous, but we use MAX_ORDER since all users assume so.
+ */
+#ifdef CONFIG_FLATMEM
+#define MAX_PHYS_CONTIG_ORDER	MAX_ORDER
+#else /* SPARSEMEM */
+#define MAX_PHYS_CONTIG_ORDER	(min(PFN_SECTION_SHIFT, MAX_ORDER))
+#endif /* CONFIG_FLATMEM */
+
+#define MAX_PHYS_CONTIG_NR_PAGES	(1UL << MAX_PHYS_CONTIG_ORDER)
+
 /* Forward declaration */
 struct page;
=20
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 1acec2e22827..11af1063eb86 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -84,8 +84,8 @@ static int atomic_pool_expand(struct gen_pool *pool, size=
_t pool_size,
 	void *addr;
 	int ret =3D -ENOMEM;
=20
-	/* Cannot allocate larger than MAX_ORDER */
-	order =3D min(get_order(pool_size), MAX_ORDER);
+	/* Cannot allocate larger than MAX_PHYS_CONTIG_ORDER */
+	order =3D min(get_order(pool_size), MAX_PHYS_CONTIG_ORDER);
=20
 	do {
 		pool_size =3D 1 << (PAGE_SHIFT + order);
@@ -190,11 +190,11 @@ static int __init dma_atomic_pool_init(void)
=20
 	/*
 	 * If coherent_pool was not used on the command line, default the pool
-	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER.
+	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_PHYS_CONTIG_ORDER.
 	 */
 	if (!atomic_pool_size) {
 		unsigned long pages =3D totalram_pages() / (SZ_1G / SZ_128K);
-		pages =3D min_t(unsigned long, pages, MAX_ORDER_NR_PAGES);
+		pages =3D min_t(unsigned long, pages, MAX_PHYS_CONTIG_NR_PAGES);
 		atomic_pool_size =3D max_t(size_t, pages << PAGE_SHIFT, SZ_128K);
 	}
 	INIT_WORK(&atomic_pool_work, atomic_pool_work_fn);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 84a4ea87f394..e6c829a581d6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1922,7 +1922,7 @@ pgoff_t hugetlb_basepage_index(struct page *page)
 	pgoff_t index =3D page_index(page_head);
 	unsigned long compound_idx;
=20
-	if (compound_order(page_head) > MAX_ORDER)
+	if (compound_order(page_head) > MAX_PHYS_CONTIG_ORDER)
 		compound_idx =3D page_to_pfn(page) - page_to_pfn(page_head);
 	else
 		compound_idx =3D page - page_head;
diff --git a/mm/internal.h b/mm/internal.h
index d688c0320cda..1b1abfc2196e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -304,7 +304,7 @@ static inline bool page_is_buddy(struct page *page, str=
uct page *buddy,
  * satisfies the following equation:
  *     P =3D B & ~(1 << O)
  *
- * Assumption: *_mem_map is contiguous at least up to MAX_ORDER
+ * Assumption: *_mem_map is contiguous at least up to MAX_PHYS_CONTIG_ORDER
  */
 static inline unsigned long
 __find_buddy_pfn(unsigned long page_pfn, unsigned int order)
diff --git a/mm/memory.c b/mm/memory.c
index 118e5f023597..06f5f2de3a2c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5717,7 +5717,7 @@ void clear_huge_page(struct page *page,
 	unsigned long addr =3D addr_hint &
 		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
=20
-	if (unlikely(pages_per_huge_page > MAX_ORDER_NR_PAGES)) {
+	if (unlikely(pages_per_huge_page > MAX_PHYS_CONTIG_NR_PAGES)) {
 		clear_gigantic_page(page, addr, pages_per_huge_page);
 		return;
 	}
@@ -5769,7 +5769,7 @@ void copy_user_huge_page(struct page *dst, struct pag=
e *src,
 		.vma =3D vma,
 	};
=20
-	if (unlikely(pages_per_huge_page > MAX_ORDER_NR_PAGES)) {
+	if (unlikely(pages_per_huge_page > MAX_PHYS_CONTIG_NR_PAGES)) {
 		copy_user_gigantic_page(dst, src, addr, vma,
 					pages_per_huge_page);
 		return;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2985d5302c57..994a648c0f5c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -596,16 +596,16 @@ static void online_pages_range(unsigned long start_pf=
n, unsigned long nr_pages)
 	unsigned long pfn;
=20
 	/*
-	 * Online the pages in MAX_ORDER aligned chunks. The callback might
+	 * Online the pages in MAX_PHYS_CONTIG_ORDER aligned chunks. The callback=
 might
 	 * decide to not expose all pages to the buddy (e.g., expose them
 	 * later). We account all pages as being online and belonging to this
 	 * zone ("present").
 	 * When using memmap_on_memory, the range might not be aligned to
-	 * MAX_ORDER_NR_PAGES - 1, but pageblock aligned. __ffs() will detect
+	 * MAX_PHYS_CONTIG_NR_PAGES - 1, but pageblock aligned. __ffs() will dete=
ct
 	 * this and the first chunk to online will be pageblock_nr_pages.
 	 */
 	for (pfn =3D start_pfn; pfn < end_pfn;) {
-		int order =3D min_t(unsigned long, MAX_ORDER, __ffs(pfn));
+		int order =3D min_t(unsigned long, MAX_PHYS_CONTIG_ORDER, __ffs(pfn));
=20
 		(*online_page_callback)(pfn_to_page(pfn), order);
 		pfn +=3D (1UL << order);
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 0c2b7d4f7054..2c183827d365 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -226,7 +226,7 @@ static void unset_migratetype_isolate(struct page *page=
, int migratetype)
 	 */
 	if (PageBuddy(page)) {
 		order =3D buddy_order(page);
-		if (order >=3D pageblock_order && order <=3D MAX_ORDER) {
+		if (order >=3D pageblock_order && order <=3D MAX_PHYS_CONTIG_ORDER) {
 			buddy =3D find_buddy_page_pfn(page, page_to_pfn(page),
 						    order, NULL);
 			if (buddy && !is_migrate_isolate_page(buddy)) {
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index e3d6f4af34e0..001438f3dbeb 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -248,7 +248,7 @@ page_reporting_process_zone(struct page_reporting_dev_i=
nfo *prdev,
 		return err;
=20
 	/* Process each free list starting from lowest order/mt */
-	for (order =3D page_reporting_order; order <=3D MAX_ORDER; order++) {
+	for (order =3D page_reporting_order; order <=3D MAX_PHYS_CONTIG_ORDER; or=
der++) {
 		for (mt =3D 0; mt < MIGRATE_TYPES; mt++) {
 			/* We do not pull pages from the isolate free list */
 			if (is_migrate_isolate(mt))
--=20
2.35.1

