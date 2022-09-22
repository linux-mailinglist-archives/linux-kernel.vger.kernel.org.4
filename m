Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2B95E57E5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiIVBNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiIVBNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:13:05 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8701B49B52
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 18:13:04 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C18555C0180;
        Wed, 21 Sep 2022 21:13:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 21 Sep 2022 21:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663809183; x=
        1663895583; bh=AK6DOiyMYfYJ/rTQuGgJsnozvlIptSPmsmwHZHzXqsQ=; b=v
        9K86v3JObqbyU969UkDuXoDi6otqaH8TNOazY0gx1ywRMVusvUeA5cV4nYKlR9qx
        ueK+dIXF/vc1G6GWSbESwiQaXAgFLvDrMtEb0+GMMnrKHoWC0sOQJgouwIaWqAOy
        6LocugA2F9I5eBl80ItW2lf9H0OQ+JXLCxggW88/R6BYcf6UkxfbrRMk8MIlxnAL
        0CEKf3NoKwitqCUJs7XQUOuy9lJszIvllsHz3eUiNXuGP/phpuiPk9xR9lWG50xq
        phYRao1KrQZ3ClaIyHaC1opwuowmFFBz0RTsxJ23/LJ8We8Xjr2Ec7FhomUMOhSu
        lpG07zjL8mHhVGBGGi4wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1663809183; x=1663895583; bh=A
        K6DOiyMYfYJ/rTQuGgJsnozvlIptSPmsmwHZHzXqsQ=; b=v3uJV9uiqhUmZfyJd
        lmmpAQbCS6bh7gg/x2+I9+rVVVNSkxhlMI+GbfGmOpydoZmoYyrr2Qv4pQNOyWmH
        NN4mpj7yhbV8FTrV3u9CXWo0dBQfMNXaW7fdMaOIju+0HVZkWJhEay9+qGWW6KTQ
        jZSH0+IwUgS4HmBma87eGh1N5fFmX9sSvOJroh0D9Dm5kmXZ42kTV9WCiJ2A8R2J
        b0IZPonqaHZ7ieaj370kHRgxAVy+MsNdAx5O0pYB3quXon+UdflOAd4e1O22ZGXP
        V8vxl0svR1YS23zpWqvCRMnx7uV2SjWNhKTPRd3JmyRByBNTkMZ+qb7JoEpId5oc
        ttHww==
X-ME-Sender: <xms:n7YrY_NJcRHsUPVjz_heDHQfDVleAK-k5NTWfJPTFodYe_AXnBLhoQ>
    <xme:n7YrY5_qpmNm83p3PMnzu7xYlC5oCBM1YbNc7zODc6JZAtzM2pg6_PpoVBLBIKpzX
    5JqChVfQQhfjgsT5A>
X-ME-Received: <xmr:n7YrY-QX0YgeKxxcJlnNA5Rk_zJOFIDUKMuZD3DVB9vhggHO-Hn4xf7zckmcgb1VNFBOUt-BQZgOICrLCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefvddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:n7YrYztwkR9ScxqzrHFqpVjVnO-d9kbZPHO5maQm2tdm6NFtheCk5g>
    <xmx:n7YrY3ePafj0hgaN8OeTbGUl1iT4jrudqqQQDaK74IxlmOu5g366Uw>
    <xmx:n7YrY_2bcZAPmiHzp9DZyxzot-BUPwZeKD8gzUpFFq4hVcxWqh3uQA>
    <xmx:n7YrYy-pHx8Lt5m-1XVy_WgrMkvjekY3V0i2gYwkxOwVTiVzAfn3OQ>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Sep 2022 21:13:03 -0400 (EDT)
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
Subject: [PATCH v1 11/12] mm: introduce MIN_MAX_ORDER to replace MAX_ORDER as compile time constant.
Date:   Wed, 21 Sep 2022 21:12:51 -0400
Message-Id: <20220922011252.2266780-12-zi.yan@sent.com>
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

For other MAX_ORDER uses (described below), there is no need or too much
hassle to convert certain static array to dynamic ones. Add
MIN_MAX_ORDER to serve as compile time constant in place of MAX_ORDER.

ARM64 hypervisor maintains its own free page list and does not import
any core kernel symbols, so soon-to-be runtime variable MAX_ORDER is not
accessible in ARM64 hypervisor code. Also there is no need to allocating
very large pages.

In SLAB/SLOB/SLUB, 2-D array kmalloc_caches uses MAX_ORDER in its second
dimension. It is too much hassle to allocate memory for kmalloc_caches
before any proper memory allocator is set up.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Quentin Perret <qperret@google.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/kvm/hyp/include/nvhe/gfp.h | 2 +-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c  | 2 +-
 include/linux/mmzone.h                | 3 +++
 include/linux/pageblock-flags.h       | 4 ++--
 include/linux/slab.h                  | 8 ++++----
 mm/slab.c                             | 2 +-
 mm/slub.c                             | 6 +++---
 7 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/gfp.h b/arch/arm64/kvm/hyp/inc=
lude/nvhe/gfp.h
index fe5472a184a3..29b92f68ab69 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/gfp.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
@@ -16,7 +16,7 @@ struct hyp_pool {
 	 * API at EL2.
 	 */
 	hyp_spinlock_t lock;
-	struct list_head free_area[MAX_ORDER + 1];
+	struct list_head free_area[MIN_MAX_ORDER + 1];
 	phys_addr_t range_start;
 	phys_addr_t range_end;
 	unsigned short max_order;
diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe=
/page_alloc.c
index d40f0b30b534..7ebbac3e2e76 100644
--- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -241,7 +241,7 @@ int hyp_pool_init(struct hyp_pool *pool, u64 pfn, unsig=
ned int nr_pages,
 	int i;
=20
 	hyp_spin_lock_init(&pool->lock);
-	pool->max_order =3D min(MAX_ORDER, get_order((nr_pages + 1) << PAGE_SHIFT=
));
+	pool->max_order =3D min(MIN_MAX_ORDER, get_order((nr_pages + 1) << PAGE_S=
HIFT));
 	for (i =3D 0; i < pool->max_order; i++)
 		INIT_LIST_HEAD(&pool->free_area[i]);
 	pool->range_start =3D phys;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 032d347f36dd..19fca391f635 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -26,10 +26,13 @@
 /* Free memory management - zoned buddy allocator.  */
 #ifdef CONFIG_SET_MAX_ORDER
 #define MAX_ORDER CONFIG_SET_MAX_ORDER
+#define MIN_MAX_ORDER CONFIG_SET_MAX_ORDER
 #elif CONFIG_ARCH_FORCE_MAX_ORDER !=3D 0
 #define MAX_ORDER CONFIG_ARCH_FORCE_MAX_ORDER
+#define MIN_MAX_ORDER CONFIG_ARCH_FORCE_MAX_ORDER
 #else
 #define MAX_ORDER 10
+#define MIN_MAX_ORDER MAX_ORDER
 #endif
=20
 #define MAX_ORDER_NR_PAGES (1 << MAX_ORDER)
diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flag=
s.h
index 5469ba6f97c1..0424b6e04dae 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -41,7 +41,7 @@ extern unsigned int pageblock_order;
  * Huge pages are a constant size, but don't exceed the maximum allocation
  * granularity.
  */
-#define pageblock_order		min_t(unsigned int, HUGETLB_PAGE_ORDER, MAX_ORDER)
+#define pageblock_order		min_t(unsigned int, HUGETLB_PAGE_ORDER, MIN_MAX_O=
RDER)
=20
 #endif /* CONFIG_HUGETLB_PAGE_SIZE_VARIABLE */
=20
@@ -51,7 +51,7 @@ extern unsigned int pageblock_order;
  * If huge pages are not used, group by MAX_ORDER_NR_PAGES or
  * PAGES_PER_SECTION when MAX_ORDER_NR_PAGES is larger.
  */
-#define pageblock_order		(min(PFN_SECTION_SHIFT, MAX_ORDER))
+#define pageblock_order		(min(PFN_SECTION_SHIFT, MIN_MAX_ORDER))
=20
 #endif /* CONFIG_HUGETLB_PAGE */
=20
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 1553bb127d8c..737bb72e5a60 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -257,8 +257,8 @@ static inline unsigned int arch_slab_minalign(void)
  * to do various tricks to work around compiler limitations in order to
  * ensure proper constant folding.
  */
-#define KMALLOC_SHIFT_HIGH	((MAX_ORDER + PAGE_SHIFT) <=3D 25 ? \
-				(MAX_ORDER + PAGE_SHIFT) : 25)
+#define KMALLOC_SHIFT_HIGH	((MIN_MAX_ORDER + PAGE_SHIFT) <=3D 25 ? \
+				(MIN_MAX_ORDER + PAGE_SHIFT) : 25)
 #define KMALLOC_SHIFT_MAX	KMALLOC_SHIFT_HIGH
 #ifndef KMALLOC_SHIFT_LOW
 #define KMALLOC_SHIFT_LOW	5
@@ -271,7 +271,7 @@ static inline unsigned int arch_slab_minalign(void)
  * (PAGE_SIZE*2).  Larger requests are passed to the page allocator.
  */
 #define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
-#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT)
+#define KMALLOC_SHIFT_MAX	(MIN_MAX_ORDER + PAGE_SHIFT)
 #ifndef KMALLOC_SHIFT_LOW
 #define KMALLOC_SHIFT_LOW	3
 #endif
@@ -284,7 +284,7 @@ static inline unsigned int arch_slab_minalign(void)
  * be allocated from the same page.
  */
 #define KMALLOC_SHIFT_HIGH	PAGE_SHIFT
-#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT)
+#define KMALLOC_SHIFT_MAX	(MIN_MAX_ORDER + PAGE_SHIFT)
 #ifndef KMALLOC_SHIFT_LOW
 #define KMALLOC_SHIFT_LOW	3
 #endif
diff --git a/mm/slab.c b/mm/slab.c
index 530f418a4930..23798c32bb38 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -466,7 +466,7 @@ static int __init slab_max_order_setup(char *str)
 {
 	get_option(&str, &slab_max_order);
 	slab_max_order =3D slab_max_order < 0 ? 0 :
-				min(slab_max_order, MAX_ORDER);
+				min(slab_max_order, MIN_MAX_ORDER);
 	slab_max_order_set =3D true;
=20
 	return 1;
diff --git a/mm/slub.c b/mm/slub.c
index d001573b67c7..c3b1f438a8e3 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3891,8 +3891,8 @@ static inline int calculate_order(unsigned int size)
 	/*
 	 * Doh this slab cannot be placed using slub_max_order.
 	 */
-	order =3D calc_slab_order(size, 1, MAX_ORDER, 1);
-	if (order <=3D MAX_ORDER)
+	order =3D calc_slab_order(size, 1, MIN_MAX_ORDER, 1);
+	if (order <=3D MIN_MAX_ORDER)
 		return order;
 	return -ENOSYS;
 }
@@ -4403,7 +4403,7 @@ __setup("slub_min_order=3D", setup_slub_min_order);
 static int __init setup_slub_max_order(char *str)
 {
 	get_option(&str, (int *)&slub_max_order);
-	slub_max_order =3D min_t(unsigned int, slub_max_order, MAX_ORDER);
+	slub_max_order =3D min_t(unsigned int, slub_max_order, MIN_MAX_ORDER);
=20
 	return 1;
 }
--=20
2.35.1

