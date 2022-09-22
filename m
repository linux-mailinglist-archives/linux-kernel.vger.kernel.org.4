Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89995E57E3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiIVBNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiIVBND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:13:03 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D104CA09
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 18:13:02 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 61DEA5C0148;
        Wed, 21 Sep 2022 21:13:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 21 Sep 2022 21:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663809182; x=
        1663895582; bh=Nv99GiHsEcawIlId0x0YqzolK3s7pNZObtF5Lg/ft28=; b=L
        JfyrA0jVaYrlzfxQwvyHHOLXlUY2oScbbstQsljB4o5boFM/FGWiI1igWh+NHzAb
        zKYGe0JtTtOJpUrmK0GJp1oYXQ5lCf9eqvwof9eEvIwU/WD23revC2t4Z87Jl2KH
        dUsc9AbMv06dNVj2r74mGvCTJU42xi2u8YTClW//ZtGFMHEYhasxI/sBnBaE610R
        wPlixukSML+R9yupUt8tgpqxOz59Jbv/ZSPn7R8/n2TabPLirhpP7B5jHUGBU8IB
        Dopd+CW8gUw0XcF78bujVC+1zNS4/x80N66Emyjt/nW4TAr9CzxDFUXEFYWyhwnf
        W39rcuwNQWYpEjpX1oZEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1663809182; x=1663895582; bh=N
        v99GiHsEcawIlId0x0YqzolK3s7pNZObtF5Lg/ft28=; b=shhDofdWwykdlWWls
        3aki8pc90kkgeL0GzQ5nWWo9d5u97v04wT2Y2KIW8FUAHkIfFWHa6qbiTd6CmKjj
        zY2ioMXPY1xNj3mKfRsBzk/nsSGrfL2O6pmH3kd34xoR+HYWKLIsGIdQddpQHnYU
        vtHy5Jzdh+NHRfTuEvBUHb58yUWPWc7PPSULpg4I2REaFNlLjUxUBGDcJMA46Hgg
        kC6luK8PgaaXn6/ncb6/P6UojGO0S4PFDdxvBgpiY+/3Cg8JcKdEP8lDISJGC7nS
        gi12gV9+DLHcjFfSBavYMbpgLxkrbbLinarI2I6t2lr+fVw/IBKcudBH8x3TSIGE
        LAO7g==
X-ME-Sender: <xms:nrYrY4VPKx1NwdUaTZcxQyRT1W-SE_MWz-zZ7-jIM2j-qE-86RvXfA>
    <xme:nrYrY8l1dEHMNSxtk1iZOCQFP5WiJ_gAZltRw5jUNkgxFpfqKUs2hOA7POFjfuaDx
    U5nl73OqRBxPmqjBg>
X-ME-Received: <xmr:nrYrY8YUFVtmYEqaMx44Jt_Q26PNWg9zm5PGA8grL6yjiEXPjLa8dOCCypoJeMA6Lcclytc_Ck-BmNpUQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefvddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:nrYrY3UoD9g7cbR1ZCfw7mublAxDechTDfcG2P6zas8lIUWtK-200g>
    <xmx:nrYrYykc7Zr2b8WwWuYBOZNFpfw1Z0WE9PN_cAJ1n2CWeZZu0HEZ9Q>
    <xmx:nrYrY8dv9ALUNJ5d_p2sfnigm7mQz67xGzVtVov8hfhS7ZK-hRGggA>
    <xmx:nrYrY4mVyoZQaHBhjo0QsrYeCXZI3vyFt2WWuk2ASqkjoKdFDX_MyQ>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Sep 2022 21:13:01 -0400 (EDT)
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
Subject: [PATCH v1 09/12] mm: Make MAX_ORDER of buddy allocator configurable via Kconfig SET_MAX_ORDER.
Date:   Wed, 21 Sep 2022 21:12:49 -0400
Message-Id: <20220922011252.2266780-10-zi.yan@sent.com>
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

With SPARSEMEM_VMEMMAP, all struct page are virtually contigous,
thus kernel can manipulate arbitrarily large pages. By checking
PFN validity during buddy page merging process, all free pages in buddy
allocator's free area have their PFNs contiguous even if the system has
several not physically contiguous memory sections. With these two
conditions, it is OK to remove the restriction of
MAX_ORDER + PAGE_SHIFT < SECTION_SIZE_BITS and change MAX_ORDER freely.

Add SET_MAX_ORDER to allow MAX_ORDER adjustment when arch does not set
its own MAX_ORDER via ARCH_FORCE_MAX_ORDER. Make it depend
on SPARSEMEM_VMEMMAP, when MAX_ORDER is not limited by SECTION_SIZE_BITS.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 arch/Kconfig           |  4 ++++
 include/linux/mmzone.h | 17 ++++++++++++++---
 mm/Kconfig             | 14 ++++++++++++++
 mm/internal.h          |  2 --
 4 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 1c2599618eeb..e51c759a82ad 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -11,6 +11,10 @@ source "arch/$(SRCARCH)/Kconfig"
=20
 menu "General architecture-dependent options"
=20
+config ARCH_FORCE_MAX_ORDER
+	int
+	default "0"
+
 config CRASH_CORE
 	bool
=20
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index de1548f4fc07..da5745fa15c3 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -24,11 +24,14 @@
 #include <asm/page.h>
=20
 /* Free memory management - zoned buddy allocator.  */
-#ifndef CONFIG_ARCH_FORCE_MAX_ORDER
-#define MAX_ORDER 10
-#else
+#ifdef CONFIG_SET_MAX_ORDER
+#define MAX_ORDER CONFIG_SET_MAX_ORDER
+#elif CONFIG_ARCH_FORCE_MAX_ORDER !=3D 0
 #define MAX_ORDER CONFIG_ARCH_FORCE_MAX_ORDER
+#else
+#define MAX_ORDER 10
 #endif
+
 #define MAX_ORDER_NR_PAGES (1 << MAX_ORDER)
=20
 /*
@@ -1588,9 +1591,17 @@ static inline bool movable_only_nodes(nodemask_t *no=
des)
 #define SECTION_BLOCKFLAGS_BITS \
 	((1UL << (PFN_SECTION_SHIFT - pageblock_order)) * NR_PAGEBLOCK_BITS)
=20
+/*
+ * The MAX_ORDER check is not necessary when CONFIG_SET_MAX_ORDER is set, =
since
+ * it depends on CONFIG_SPARSEMEM_VMEMMAP, where all struct page are virtu=
ally
+ * contiguous, thus > section size pages can be allocated and manipulated
+ * without worrying about non-contiguous struct page.
+ */
+#ifndef CONFIG_SET_MAX_ORDER
 #if (MAX_ORDER + PAGE_SHIFT) > SECTION_SIZE_BITS
 #error Allocator MAX_ORDER exceeds SECTION_SIZE
 #endif
+#endif /* CONFIG_SET_MAX_ORDER*/
=20
 static inline unsigned long pfn_to_section_nr(unsigned long pfn)
 {
diff --git a/mm/Kconfig b/mm/Kconfig
index ae6711d24e4a..9c7280acd528 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -435,6 +435,20 @@ config SPARSEMEM_VMEMMAP
 	  pfn_to_page and page_to_pfn operations.  This is the most
 	  efficient option when sufficient kernel resources are available.
=20
+config SET_MAX_ORDER
+	int "Set maximum order of buddy allocator"
+	depends on SPARSEMEM_VMEMMAP && (ARCH_FORCE_MAX_ORDER =3D 0)
+	range 10 255
+	default "10"
+	help
+	  The kernel memory allocator divides physically contiguous memory
+	  blocks into "zones", where each zone is a power of two number of
+	  pages.  This option selects the largest power of two that the kernel
+	  keeps in the memory allocator.  If you need to allocate very large
+	  blocks of physically contiguous memory, then you may need to
+	  increase this value. A value of 10 means that the largest free memory
+	  block is 2^10 pages.
+
 config HAVE_MEMBLOCK_PHYS_MAP
 	bool
=20
diff --git a/mm/internal.h b/mm/internal.h
index 1b1abfc2196e..1c3f260930d8 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -303,8 +303,6 @@ static inline bool page_is_buddy(struct page *page, str=
uct page *buddy,
  * 2) Any buddy B will have an order O+1 parent P which
  * satisfies the following equation:
  *     P =3D B & ~(1 << O)
- *
- * Assumption: *_mem_map is contiguous at least up to MAX_PHYS_CONTIG_ORDER
  */
 static inline unsigned long
 __find_buddy_pfn(unsigned long page_pfn, unsigned int order)
--=20
2.35.1

