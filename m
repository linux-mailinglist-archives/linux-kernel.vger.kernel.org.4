Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2682C5E57DA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiIVBNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiIVBNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:13:01 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAAFAA35A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 18:12:57 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 304E25C0145;
        Wed, 21 Sep 2022 21:12:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 21 Sep 2022 21:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663809177; x=
        1663895577; bh=6hIod5Xb/n6/GvZSv988w0dL7EymQUiDUpxAypFJV3A=; b=g
        7Hl4GZksfYJYKHux7Fd2YpcCSHO5mS3JUXy8fcKHPvVkPPkMdEFdlKech0GjtrB+
        UhoHax5scLMYKxjoQjNyqgxYR5evq969VB9S7g4xUjel5JH4IdmH6vcQJmGOvfIi
        /NW23afwZnlfVDU0e7j34U46msX8vWSUgJk95CwULeN98Bk0yhDApxEcf7KX3li7
        LI/qOg/pd5s3Zmz+swiy52pcxwZ5Fb+Ca1I8H9ezHpclUBml9qzVDM7VoTU4tEGm
        BPQVvDajtHKjXyVb8qvfrF/rMLEsde+1RM82aL3cAFGlXVVHUoCNMEilyIdIuK45
        rDsiqIIxWmtvxIj1ncp7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1663809177; x=1663895577; bh=6
        hIod5Xb/n6/GvZSv988w0dL7EymQUiDUpxAypFJV3A=; b=jir8dylmgmGv34mmu
        SolLmqh5uuUvUyXUnTyb/4bjKXRPIfoO/LQZEzdMK8rcIsZyTmcqSUvYJ9UntiGP
        yhy6z/dg3fE5bBOKBi9nRhimkBUn02kL1TKHQxDdtEH/L5YULjTkbF+uEQR/x064
        zNvwRuwGrP5rncAL/BsEgq7YAi7kkEXb2MHYlXVgkSEW3ZUeCFr2MT2eyw8tAfem
        S42tvNOj9sbTJE9ch5pMcG8LlQdfqVg/VIP97JCRPx9Sg1Mo+uhXFWaghZSfYal+
        EkN8T9GI03YGdGu+fwL0hsmTL5mm0J7hHNeWQ4W6RS4gzyeNL14uMobvF731IuBF
        mLtXw==
X-ME-Sender: <xms:mbYrY7o7TAWyaoiFNHfvEiVtOatpkIYP83SmPLvn6lrGuaLAui68yw>
    <xme:mbYrY1qmjGJbeoU8wN0fQdILXjSKR6Q0uiTTfYsr6k4u7AHh2BJU3EJBuHaUXmLCm
    J6w0cz9dYyatr4G3g>
X-ME-Received: <xmr:mbYrY4MIsLGDrYop5Ij7yl5z6RWHFCavgb3oCGlUY1pLPcwBg8LmINcMLSpHPwvfbCLDc8vXaSHXeB6x8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefvddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:mbYrY-69QIfyWdnssJ_fCSdFmWlSTJaML9tbZvUV_lRY4wu3OknJJQ>
    <xmx:mbYrY6524HijFIrjrK4sS794Rb7BheDnZpvO-5_KZd9mfsFLLi7deA>
    <xmx:mbYrY2h4ge82afA8YfQnhkXg9bfzsDx56sAqIOy69lgwzjlhQQsFAQ>
    <xmx:mbYrY9J9yjTeTs4qAEOQIvDwzUAmUiBKC1XrKG-hLD9cbWTzG7Ypog>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Sep 2022 21:12:56 -0400 (EDT)
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
Subject: [PATCH v1 03/12] mm: adapt deferred struct page init to new MAX_ORDER.
Date:   Wed, 21 Sep 2022 21:12:43 -0400
Message-Id: <20220922011252.2266780-4-zi.yan@sent.com>
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

deferred_init only initializes first section of a zone and defers the
rest and the rest of the zone will be initialized in size of a section.
When MAX_ORDER grows beyond a section size, early_page_uninitialised()
did not prevent pages beyond first section from initialization, since it
only checked the starting pfn and assumes MAX_ORDER is smaller than
a section size. In addition, deferred_init_maxorder() uses
MAX_ORDER_NR_PAGES as the initialization unit, which can cause the
initialized chunk of memory overlapping with other initialization jobs.

For the first issue, make early_page_uninitialised() decrease the order
for non-deferred memory initialization when it is bigger than first
section. For the second issue, when adjust pfn alignment in
deferred_init_maxorder(), make sure the alignment is not bigger than
a section size.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/internal.h   |  2 +-
 mm/memblock.c   |  6 ++++--
 mm/page_alloc.c | 28 ++++++++++++++++++++--------
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 22fb1e6e3541..d688c0320cda 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -361,7 +361,7 @@ extern int __isolate_free_page(struct page *page, unsig=
ned int order);
 extern void __putback_isolated_page(struct page *page, unsigned int order,
 				    int mt);
 extern void memblock_free_pages(struct page *page, unsigned long pfn,
-					unsigned int order);
+					unsigned int *order);
 extern void __free_pages_core(struct page *page, unsigned int order);
 extern void prep_compound_page(struct page *page, unsigned int order);
 extern void post_alloc_hook(struct page *page, unsigned int order,
diff --git a/mm/memblock.c b/mm/memblock.c
index acbc77367faf..b957c12a93e7 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1640,7 +1640,9 @@ void __init memblock_free_late(phys_addr_t base, phys=
_addr_t size)
 	end =3D PFN_DOWN(base + size);
=20
 	for (; cursor < end; cursor++) {
-		memblock_free_pages(pfn_to_page(cursor), cursor, 0);
+		unsigned int order =3D 0;
+
+		memblock_free_pages(pfn_to_page(cursor), cursor, &order);
 		totalram_pages_inc();
 	}
 }
@@ -2035,7 +2037,7 @@ static void __init __free_pages_memory(unsigned long =
start, unsigned long end)
 		while (start + (1UL << order) > end)
 			order--;
=20
-		memblock_free_pages(pfn_to_page(start), start, order);
+		memblock_free_pages(pfn_to_page(start), start, &order);
=20
 		start +=3D (1UL << order);
 	}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b3dd5248e63d..e3af87d89ebf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -464,13 +464,19 @@ static inline bool deferred_pages_enabled(void)
 }
=20
 /* Returns true if the struct page for the pfn is uninitialised */
-static inline bool __meminit early_page_uninitialised(unsigned long pfn)
+static inline bool __meminit early_page_uninitialised(unsigned long pfn, u=
nsigned int *order)
 {
 	int nid =3D early_pfn_to_nid(pfn);
=20
 	if (node_online(nid) && pfn >=3D NODE_DATA(nid)->first_deferred_pfn)
 		return true;
=20
+	/* clamp down order to not exceed first_deferred_pfn */
+	if (order)
+		*order =3D min_t(unsigned int,
+			       *order,
+			       ilog2(NODE_DATA(nid)->first_deferred_pfn - pfn));
+
 	return false;
 }
=20
@@ -518,7 +524,7 @@ static inline bool deferred_pages_enabled(void)
 	return false;
 }
=20
-static inline bool early_page_uninitialised(unsigned long pfn)
+static inline bool early_page_uninitialised(unsigned long pfn, unsigned in=
t *order)
 {
 	return false;
 }
@@ -1653,7 +1659,7 @@ static void __meminit init_reserved_page(unsigned lon=
g pfn)
 	pg_data_t *pgdat;
 	int nid, zid;
=20
-	if (!early_page_uninitialised(pfn))
+	if (!early_page_uninitialised(pfn, NULL))
 		return;
=20
 	nid =3D early_pfn_to_nid(pfn);
@@ -1809,15 +1815,15 @@ int __meminit early_pfn_to_nid(unsigned long pfn)
 #endif /* CONFIG_NUMA */
=20
 void __init memblock_free_pages(struct page *page, unsigned long pfn,
-							unsigned int order)
+							unsigned int *order)
 {
-	if (early_page_uninitialised(pfn))
+	if (early_page_uninitialised(pfn, order))
 		return;
-	if (!kmsan_memblock_free_pages(page, order)) {
+	if (!kmsan_memblock_free_pages(page, *order)) {
 		/* KMSAN will take care of these pages. */
 		return;
 	}
-	__free_pages_core(page, order);
+	__free_pages_core(page, *order);
 }
=20
 /*
@@ -2036,7 +2042,13 @@ static unsigned long __init
 deferred_init_maxorder(u64 *i, struct zone *zone, unsigned long *start_pfn,
 		       unsigned long *end_pfn)
 {
-	unsigned long mo_pfn =3D ALIGN(*start_pfn + 1, MAX_ORDER_NR_PAGES);
+	/*
+	 * deferred_init_memmap_chunk gives out jobs with max size to
+	 * PAGES_PER_SECTION. Do not align mo_pfn beyond that.
+	 */
+	unsigned long align =3D min_t(unsigned long,
+				MAX_ORDER_NR_PAGES, PAGES_PER_SECTION);
+	unsigned long mo_pfn =3D ALIGN(*start_pfn + 1, align);
 	unsigned long spfn =3D *start_pfn, epfn =3D *end_pfn;
 	unsigned long nr_pages =3D 0;
 	u64 j =3D *i;
--=20
2.35.1

