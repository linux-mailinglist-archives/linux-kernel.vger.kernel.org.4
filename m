Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AD85E57E1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiIVBNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiIVBNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:13:04 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A522C4CA0C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 18:13:03 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1AB8F5C015A;
        Wed, 21 Sep 2022 21:13:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 21 Sep 2022 21:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663809183; x=
        1663895583; bh=N4M4pUOUBhXsQeCqeGj24cXYl3bhDovrj3T08UfMKQk=; b=2
        sJxtew6efa/JQqUPrBKv2LqozUXzRBUoOKKir1x7hfxy9e5lwnVSWYZS3e39JzTK
        BQGJUL0xDECaMjTJxkFid6qwdaCZ4axF9N0UqqFXXh+5CsFpXO0t0gFGt374radE
        eLH7SU/7MULg0/LRDAZapmZNrnqGsflKsaK4i2X0SfGL/p9s9SdVM8b1iINCwLu2
        wcYci/kIokL92jmbMfOO9ApxOkX82ODG7NCa2nHii01U2cOtS7vpXm/6oDcxtZYM
        VotTlfphStPT8MxYimzHthj9bND3qBQhPvgyapGLrRB8Qcp9zSQs+QuVS39pmGDe
        /NCz/1qNYLh4TyUtY2oog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1663809183; x=1663895583; bh=N
        4M4pUOUBhXsQeCqeGj24cXYl3bhDovrj3T08UfMKQk=; b=drsJ51jkdsaMh69m6
        imJkKgEfBaYTsq1h4pf47tRXHqnDWxVlejsJCbVT/c2FtdOAzPec+GXAfsfhy5zc
        ROjUVWJayIwdhgE15pg8UGCtvQflJanb7PO4K/vLRZqJbIL1LkcBsutWhXlpKURF
        /DqvvvmqjcveVtyn9d/Lj87nJI2+MRtDUI4xuZy5fhE6c+xtmy5c4Oq/TCZOzt9w
        P8Q6UHF7x2PW65A7FBXeUOvIKx2pGSKj+ZiYMc4MAxW0eS7WOTMbL2e1LV60VLtD
        YVQA1VoPu9vorR1L23iZcs4paXN0X6mopLBQegz6RVbPFQu7jCCovzgZofRrknyL
        Uk2mQ==
X-ME-Sender: <xms:nrYrYy2bfIYWFFwkwlc8K5sXyk0rkWOrqUPfjwUXWT_LrE3ro32YLg>
    <xme:nrYrY1Gc6pGcP0I7MBbAXHCuqHQlAJOsu50m8XVqD2Gh0kYrpHNINGKW0AeEe9CHL
    UTWR6kiX3J0GT6FNA>
X-ME-Received: <xmr:nrYrY66sYTlCMOYYd2NWesVDYEG6Pn3ylC5MzZBj2fPV7inm_Wg-fIRZYzE16su7CzGcXaccNzqkEVTZww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefvddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:nrYrYz1GBol68QJEz8a46waHtuTZBPQTMIxrXb82OubLmnwXTa4ilA>
    <xmx:nrYrY1F6Rt3lOFh25g8IZNlutasovHBX_Fmh3pOkXnf-BK6XNaNtTQ>
    <xmx:nrYrY892eQpC4gE6JHp5KBsTk_P0_6bUf_cv-Pj8NVxJOWuR22WSeg>
    <xmx:n7YrY9HpMTzcP_SXmkeVZ_IXXvbLRWvLqYkRZLsHkV9LFGsFuGXVRQ>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Sep 2022 21:13:02 -0400 (EDT)
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
Subject: [PATCH v1 10/12] mm: convert MAX_ORDER sized static arrays to dynamic ones.
Date:   Wed, 21 Sep 2022 21:12:50 -0400
Message-Id: <20220922011252.2266780-11-zi.yan@sent.com>
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

This prepares for the upcoming changes to make MAX_ORDER a boot time
parameter instead of compilation time constant. All static arrays with
MAX_ORDER size are converted to pointers and their memory is allocated
at runtime.

free_area array in struct zone is allocated using memblock_alloc_node()
at boot time and using kzalloc() when memory is hot-added.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: kexec@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 .../admin-guide/kdump/vmcoreinfo.rst          |  2 +-
 drivers/gpu/drm/ttm/ttm_device.c              |  7 ++-
 drivers/gpu/drm/ttm/ttm_pool.c                | 58 +++++++++++++++++--
 include/drm/ttm/ttm_pool.h                    |  4 +-
 include/linux/mmzone.h                        |  2 +-
 mm/kmsan/init.c                               | 12 +++-
 mm/page_alloc.c                               | 32 ++++++++--
 7 files changed, 98 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation=
/admin-guide/kdump/vmcoreinfo.rst
index c572b5230fe0..a775462aa7c7 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -172,7 +172,7 @@ variables.
 Offset of the free_list's member. This value is used to compute the number
 of free pages.
=20
-Each zone has a free_area structure array called free_area[MAX_ORDER + 1].
+Each zone has a free_area structure array called free_area with length of =
MAX_ORDER + 1.
 The free_list represents a linked list of free page blocks.
=20
 (list_head, next|prev)
diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_dev=
ice.c
index e7147e304637..442a77bb5b4f 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -92,7 +92,9 @@ static int ttm_global_init(void)
 		>> PAGE_SHIFT;
 	num_dma32 =3D min(num_dma32, 2UL << (30 - PAGE_SHIFT));
=20
-	ttm_pool_mgr_init(num_pages);
+	ret =3D ttm_pool_mgr_init(num_pages);
+	if (ret)
+		goto out;
 	ttm_tt_mgr_init(num_pages, num_dma32);
=20
 	glob->dummy_read_page =3D alloc_page(__GFP_ZERO | GFP_DMA32);
@@ -218,7 +220,8 @@ int ttm_device_init(struct ttm_device *bdev, struct ttm=
_device_funcs *funcs,
 	bdev->funcs =3D funcs;
=20
 	ttm_sys_man_init(bdev);
-	ttm_pool_init(&bdev->pool, dev, use_dma_alloc, use_dma32);
+	if (ttm_pool_init(&bdev->pool, dev, use_dma_alloc, use_dma32))
+		return -ENOMEM;
=20
 	bdev->vma_manager =3D vma_manager;
 	INIT_DELAYED_WORK(&bdev->wq, ttm_device_delayed_workqueue);
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 85d19f425af6..d76f7d476421 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -64,11 +64,11 @@ module_param(page_pool_size, ulong, 0644);
=20
 static atomic_long_t allocated_pages;
=20
-static struct ttm_pool_type global_write_combined[MAX_ORDER + 1];
-static struct ttm_pool_type global_uncached[MAX_ORDER + 1];
+static struct ttm_pool_type *global_write_combined;
+static struct ttm_pool_type *global_uncached;
=20
-static struct ttm_pool_type global_dma32_write_combined[MAX_ORDER + 1];
-static struct ttm_pool_type global_dma32_uncached[MAX_ORDER + 1];
+static struct ttm_pool_type *global_dma32_write_combined;
+static struct ttm_pool_type *global_dma32_uncached;
=20
 static spinlock_t shrinker_lock;
 static struct list_head shrinker_list;
@@ -493,8 +493,10 @@ EXPORT_SYMBOL(ttm_pool_free);
  * @use_dma32: true if GFP_DMA32 should be used
  *
  * Initialize the pool and its pool types.
+ *
+ * Returns: 0 on successe, negative error code otherwise
  */
-void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
+int ttm_pool_init(struct ttm_pool *pool, struct device *dev,
 		   bool use_dma_alloc, bool use_dma32)
 {
 	unsigned int i, j;
@@ -506,11 +508,30 @@ void ttm_pool_init(struct ttm_pool *pool, struct devi=
ce *dev,
 	pool->use_dma32 =3D use_dma32;
=20
 	if (use_dma_alloc) {
-		for (i =3D 0; i < TTM_NUM_CACHING_TYPES; ++i)
+		for (i =3D 0; i < TTM_NUM_CACHING_TYPES; ++i) {
+			pool->caching[i].orders =3D
+				kvcalloc(MAX_ORDER + 1, sizeof(struct ttm_pool_type),
+					GFP_KERNEL);
+			if (!pool->caching[i].orders) {
+				i--;
+				goto failed;
+			}
 			for (j =3D 0; j <=3D MAX_ORDER; ++j)
 				ttm_pool_type_init(&pool->caching[i].orders[j],
 						   pool, i, j);
+
+		}
+		return 0;
+
+failed:
+		for (; i >=3D 0; i--) {
+			for (j =3D 0; j <=3D MAX_ORDER; ++j)
+				ttm_pool_type_fini(&pool->caching[i].orders[j]);
+			kfree(pool->caching[i].orders);
+		}
+		return -ENOMEM;
 	}
+	return 0;
 }
=20
 /**
@@ -701,6 +722,31 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 	spin_lock_init(&shrinker_lock);
 	INIT_LIST_HEAD(&shrinker_list);
=20
+	if (!global_write_combined) {
+		global_write_combined =3D kvcalloc(MAX_ORDER + 1, sizeof(struct ttm_pool=
_type),
+						GFP_KERNEL);
+		if (!global_write_combined)
+			return -ENOMEM;
+	}
+	if (!global_uncached) {
+		global_uncached =3D kvcalloc(MAX_ORDER + 1, sizeof(struct ttm_pool_type),
+					  GFP_KERNEL);
+		if (!global_uncached)
+			return -ENOMEM;
+	}
+	if (!global_dma32_write_combined) {
+		global_dma32_write_combined =3D kvcalloc(MAX_ORDER + 1, sizeof(struct tt=
m_pool_type),
+						      GFP_KERNEL);
+		if (!global_dma32_write_combined)
+			return -ENOMEM;
+	}
+	if (!global_dma32_uncached) {
+		global_dma32_uncached =3D kvcalloc(MAX_ORDER + 1, sizeof(struct ttm_pool=
_type),
+						GFP_KERNEL);
+		if (!global_dma32_uncached)
+			return -ENOMEM;
+	}
+
 	for (i =3D 0; i <=3D MAX_ORDER; ++i) {
 		ttm_pool_type_init(&global_write_combined[i], NULL,
 				   ttm_write_combined, i);
diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
index 8ce14f9d202a..f5ce60f629ae 100644
--- a/include/drm/ttm/ttm_pool.h
+++ b/include/drm/ttm/ttm_pool.h
@@ -72,7 +72,7 @@ struct ttm_pool {
 	bool use_dma32;
=20
 	struct {
-		struct ttm_pool_type orders[MAX_ORDER + 1];
+		struct ttm_pool_type *orders;
 	} caching[TTM_NUM_CACHING_TYPES];
 };
=20
@@ -80,7 +80,7 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *=
tt,
 		   struct ttm_operation_ctx *ctx);
 void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt);
=20
-void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
+int ttm_pool_init(struct ttm_pool *pool, struct device *dev,
 		   bool use_dma_alloc, bool use_dma32);
 void ttm_pool_fini(struct ttm_pool *pool);
=20
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index da5745fa15c3..032d347f36dd 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -822,7 +822,7 @@ struct zone {
 	CACHELINE_PADDING(_pad1_);
=20
 	/* free areas of different sizes */
-	struct free_area	free_area[MAX_ORDER + 1];
+	struct free_area	*free_area;
=20
 	/* zone flags, see below */
 	unsigned long		flags;
diff --git a/mm/kmsan/init.c b/mm/kmsan/init.c
index 6c0834274316..d3777146e7c4 100644
--- a/mm/kmsan/init.c
+++ b/mm/kmsan/init.c
@@ -96,7 +96,7 @@ void __init kmsan_init_shadow(void)
 struct metadata_page_pair {
 	struct page *shadow, *origin;
 };
-static struct metadata_page_pair held_back[MAX_ORDER + 1] __initdata;
+static struct metadata_page_pair *held_back __initdata;
=20
 /*
  * Eager metadata allocation. When the memblock allocator is freeing pages=
 to
@@ -115,6 +115,16 @@ bool kmsan_memblock_free_pages(struct page *page, unsi=
gned int order)
 {
 	struct page *shadow, *origin;
=20
+	if (!held_back) {
+		held_back =3D memblock_alloc((MAX_ORDER + 1) * sizeof(struct metadata_pa=
ge_pair),
+				sizeof(struct metadata_page_pair));
+		/* held_back cannot be allocated, kmsan will not take the page */
+		if (!held_back) {
+			WARN_ONCE(1, "held_back array cannot be allocated, kmsan will not work"=
);
+			return true;
+		}
+	}
+
 	if (!held_back[order].shadow) {
 		held_back[order].shadow =3D page;
 		return false;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e3af87d89ebf..ba7c284ba3d3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6249,13 +6249,23 @@ void __show_free_areas(unsigned int filter, nodemas=
k_t *nodemask, int max_zone_i
=20
 	for_each_populated_zone(zone) {
 		unsigned int order;
-		unsigned long nr[MAX_ORDER + 1], flags, total =3D 0;
-		unsigned char types[MAX_ORDER + 1];
+		unsigned long *nr, flags, total =3D 0;
+		unsigned char *types;
=20
 		if (zone_idx(zone) > max_zone_idx)
 			continue;
 		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
 			continue;
+
+		nr =3D kmalloc_array(MAX_ORDER + 1, sizeof(unsigned long), GFP_KERNEL);
+		if (!nr)
+			break;
+		types =3D kmalloc_array(MAX_ORDER + 1, sizeof(unsigned char), GFP_KERNEL=
);
+		if (!types) {
+			kfree(nr);
+			break;
+		}
+
 		show_node(zone);
 		printk(KERN_CONT "%s: ", zone->name);
=20
@@ -7710,8 +7720,8 @@ static void __meminit pgdat_init_internals(struct pgl=
ist_data *pgdat)
 	lruvec_init(&pgdat->__lruvec);
 }
=20
-static void __meminit zone_init_internals(struct zone *zone, enum zone_typ=
e idx, int nid,
-							unsigned long remaining_pages)
+static void __init zone_init_internals(struct zone *zone, enum zone_type i=
dx, int nid,
+					unsigned long remaining_pages, bool hotplug)
 {
 	atomic_long_set(&zone->managed_pages, remaining_pages);
 	zone_set_nid(zone, nid);
@@ -7720,6 +7730,16 @@ static void __meminit zone_init_internals(struct zon=
e *zone, enum zone_type idx,
 	spin_lock_init(&zone->lock);
 	zone_seqlock_init(zone);
 	zone_pcp_init(zone);
+	if (hotplug)
+		zone->free_area =3D
+			kcalloc_node(MAX_ORDER + 1, sizeof(struct free_area),
+				     GFP_KERNEL, nid);
+	else
+		zone->free_area =3D
+			memblock_alloc_node(sizeof(struct free_area) * (MAX_ORDER + 1),
+					    sizeof(struct free_area), nid);
+	BUG_ON(!zone->free_area);
+
 }
=20
 /*
@@ -7758,7 +7778,7 @@ void __ref free_area_init_core_hotplug(struct pglist_=
data *pgdat)
 	}
=20
 	for (z =3D 0; z < MAX_NR_ZONES; z++)
-		zone_init_internals(&pgdat->node_zones[z], z, nid, 0);
+		zone_init_internals(&pgdat->node_zones[z], z, nid, 0, true);
 }
 #endif
=20
@@ -7821,7 +7841,7 @@ static void __init free_area_init_core(struct pglist_=
data *pgdat)
 		 * when the bootmem allocator frees pages into the buddy system.
 		 * And all highmem pages will be managed by the buddy system.
 		 */
-		zone_init_internals(zone, j, nid, freesize);
+		zone_init_internals(zone, j, nid, freesize, false);
=20
 		if (!size)
 			continue;
--=20
2.35.1

