Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21DA5E57E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiIVBN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiIVBNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:13:06 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1326C54CA3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 18:13:05 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7D5F75C0183;
        Wed, 21 Sep 2022 21:13:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 21 Sep 2022 21:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663809184; x=
        1663895584; bh=n1NV+B8lEl76VhNv8qB8eN5BjUrGYH/BezDur0ycako=; b=b
        UP0mNGn2ZplCVwYt69z9QrLForMHyZpc08pTqLg2Aw6guz+8obxUA/EoERGA1RQC
        hjwuZieh+8jI9wuWkEtiCJCkWzQzRTB+Yp+pVatRY+AjVC+pyr3SywxBKWyvfdEj
        1EzU1T4sEpt3i5OeVVH11HenwHZBJo+f/9b06LxRxxcKdN3ugFf+qWzdj5OT6Z8W
        hGKvlyShRc14mOM/UuZFFAi2op3tFKMPjCWxDlLF6cS4Qh94pQyYxJy47F1Q0BtB
        VTyPuvBwiVgWww9HUilg+a3v35ypl/JgOIsevwTkzyJXLxCFgMEYXOqFP5TOyZ4t
        JlRkadme+j05RDQb6C96Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1663809184; x=1663895584; bh=n
        1NV+B8lEl76VhNv8qB8eN5BjUrGYH/BezDur0ycako=; b=sjGJ6lLShwHUT0Bt9
        FAsdJ8gWTNntTkulo2MynpeCmp+QJzBKnbg56mjUBrHnhMg8dUTnpcgWqTayB+vo
        88B8jaybDlKcFQr1is4tLGveHxMyhNNA9RNtO3/aE6YFSqF18axXlvAnKBZ47xHl
        MECAfaBLyDtrNawWUyQrpG+tPFq0n69rLaVlc+jq7Aowo5PSZOULACNogRhbFzHI
        DP+nTCfF6jexxgj2xp7RX5I5RW+4cMpA3gP7mCJTV8aLwTSukKoB+fbR41W/HdWR
        L5ZSDbZqcFckigantdBHBhk261CKkwJojDe8oYKNfrJbCIMA57gcr2dhMzOFZksq
        IqXBw==
X-ME-Sender: <xms:oLYrY5XApKMZzXNuW-ApNqoNZqAsKLTFQFRMFBNNn82ms-uJltE0MA>
    <xme:oLYrY5n5fbnFnECgWfQo9aEAdwiWtY8lPzjvnmzkXmJRBDf2Jdr3T_nQVooFR0Waf
    afFIHw00XoBSBemPg>
X-ME-Received: <xmr:oLYrY1YUT-dEwhDx9CqROXbqU-dQ1jN94cYWy3lNZ1qfVNwq8Zgjso71zNUqhmGQFWHjZM4D5iIrhfvQdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefvddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:oLYrY8VYHCEsMwzd2fu_S7mZKjegoMZI3iNOgOQKCuJ_qoXl8SuJmg>
    <xmx:oLYrYzmOsnhyY4w4Rn9DbVpmPo6NwMBU7kgqmYuQTqRDYEx1rpGU8w>
    <xmx:oLYrY5dgQNtkNMIW0yaXj3qkHfQwaLS5YxTvYCAHG6hYc-ahoijriw>
    <xmx:oLYrY9lu3OovSHJbk0Lfo761GHbYbYye4iI_jIss6pcEuapnYYtPmA>
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
Subject: [PATCH v1 12/12] mm: make MAX_ORDER a kernel boot time parameter.
Date:   Wed, 21 Sep 2022 21:12:52 -0400
Message-Id: <20220922011252.2266780-13-zi.yan@sent.com>
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

With the new buddy_alloc_max_order, users can specify larger MAX_ORDER
than set in CONFIG_ARCH_MAX_ORDER or CONFIG_SET_MAX_ORDER.
It can be set any value >=3D CONFIG_ARCH_MAX_ORDER or CONFIG_SET_MAX_ORDER,
but < 256 (limited by vmscan scan_control and per-cpu free page list).

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-doc@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 .../admin-guide/kernel-parameters.txt         |  5 +++
 include/linux/mmzone.h                        | 10 +++++-
 mm/Kconfig                                    | 13 ++++++++
 mm/page_alloc.c                               | 31 +++++++++++++++++++
 mm/vmscan.c                                   |  1 -
 5 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
index 5f633844daac..eb0dd8a78205 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -494,6 +494,11 @@
 	bttv.pll=3D	See Documentation/admin-guide/media/bttv.rst
 	bttv.tuner=3D
=20
+	buddy_alloc_max_order=3D	[KNL] This parameter adjusts the size of largest
+			pages that can be allocated from kernel buddy allocator. The largest
+			page size is 2^buddy_alloc_max_order * PAGE_SIZE.
+			Format: integer
+
 	bulk_remove=3Doff	[PPC]  This parameter disables the use of the pSeries
 			firmware feature for flushing multiple hpte entries
 			at a time.
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 19fca391f635..5669191d15dc 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -35,6 +35,14 @@
 #define MIN_MAX_ORDER MAX_ORDER
 #endif
=20
+/* remap MAX_ORDER to buddy_alloc_max_order for boot time adjustment */
+#ifdef CONFIG_BOOT_TIME_MAX_ORDER
+/* Defined in mm/page_alloc.c */
+extern int buddy_alloc_max_order;
+#undef MAX_ORDER
+#define MAX_ORDER buddy_alloc_max_order
+#endif /* CONFIG_BOOT_TIME_MAX_ORDER */
+
 #define MAX_ORDER_NR_PAGES (1 << MAX_ORDER)
=20
 /*
@@ -1600,7 +1608,7 @@ static inline bool movable_only_nodes(nodemask_t *nod=
es)
  * contiguous, thus > section size pages can be allocated and manipulated
  * without worrying about non-contiguous struct page.
  */
-#ifndef CONFIG_SET_MAX_ORDER
+#if !defined(CONFIG_SET_MAX_ORDER) && !defined(CONFIG_BOOT_TIME_MAX_ORDER)
 #if (MAX_ORDER + PAGE_SHIFT) > SECTION_SIZE_BITS
 #error Allocator MAX_ORDER exceeds SECTION_SIZE
 #endif
diff --git a/mm/Kconfig b/mm/Kconfig
index 9c7280acd528..3e6b61ba9fec 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -449,6 +449,19 @@ config SET_MAX_ORDER
 	  increase this value. A value of 10 means that the largest free memory
 	  block is 2^10 pages.
=20
+config BOOT_TIME_MAX_ORDER
+	bool "Set maximum order of buddy allocator at boot time"
+	depends on SPARSEMEM_VMEMMAP && (ARCH_FORCE_MAX_ORDER !=3D 0 || SET_MAX_O=
RDER !=3D 0)
+	help
+	  It enables users to set the maximum order of buddy allocator at system
+	  boot time instead of a static MACRO set at compilation time. Systems wi=
th
+	  a lot of memory might want to allocate large pages whereas it is much
+	  less feasible and desirable for systems with less memory. This option
+	  allows different systems to control the largest page they want to
+	  allocate. By default, MAX_ORDER will be set to ARCH_FORCE_MAX_ORDER or
+	  SET_MAX_ORDER, whichever is non-zero, when the boot time parameter is n=
ot
+	  set. The maximum of MAX_ORDER is currently limited at 256.
+
 config HAVE_MEMBLOCK_PHYS_MAP
 	bool
=20
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ba7c284ba3d3..9eacdf3a37c4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9720,3 +9720,34 @@ bool has_managed_dma(void)
 	return false;
 }
 #endif /* CONFIG_ZONE_DMA */
+
+#ifdef CONFIG_BOOT_TIME_MAX_ORDER
+int buddy_alloc_max_order =3D MIN_MAX_ORDER;
+EXPORT_SYMBOL(buddy_alloc_max_order);
+
+static int __init buddy_alloc_set(char *val)
+{
+	int ret;
+	unsigned long max_order;
+
+	ret =3D kstrtoul(val, 10, &max_order);
+
+	if (ret < 0)
+		return -EINVAL;
+
+	/*
+	 * max_order is also limited at below locations:
+	 * 1. scan_control in mm/vmscan.c uses s8 field for order, max_order cann=
ot
+	 * be bigger than S8_MAX before the field is changed.
+	 * 2. free_pcppages_bulk has max_order upper limit.
+	 */
+	if (max_order > MIN_MAX_ORDER && max_order <=3D S8_MAX)
+		buddy_alloc_max_order =3D max_order;
+	else
+		buddy_alloc_max_order =3D MIN_MAX_ORDER;
+
+	return 0;
+}
+
+early_param("buddy_alloc_max_order", buddy_alloc_set);
+#endif /* CONFIG_BOOT_TIME_MAX_ORDER */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a8fd6300fa7e..009632243398 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6623,7 +6623,6 @@ unsigned long try_to_free_pages(struct zonelist *zone=
list, int order,
 	 * scan_control uses s8 fields for order, priority, and reclaim_idx.
 	 * Confirm they are large enough for max values.
 	 */
-	BUILD_BUG_ON(MAX_ORDER > S8_MAX);
 	BUILD_BUG_ON(DEF_PRIORITY > S8_MAX);
 	BUILD_BUG_ON(MAX_NR_ZONES > S8_MAX);
=20
--=20
2.35.1

