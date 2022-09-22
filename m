Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723D45E57DB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiIVBNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiIVBNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:13:00 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86865AA36A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 18:12:58 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E5FC35C00DC;
        Wed, 21 Sep 2022 21:12:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 21 Sep 2022 21:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663809177; x=
        1663895577; bh=nBAxwy7mmxae2g4ruRqIT/WlkqUizN+JnMmmOsyX9Nw=; b=O
        F+CFPoueSRToSVY24ff+BNtiDFR9srx8WZZbBDeaTKzjrs7eC6/BhuDCAszmbOU8
        516R5WZ0C/DfnvJqa2eY3j+yPo5Zy4NfILyraWApldfgRubYrXcGWg9UtH7u66JH
        m7MbURBBajPXRL6W6FUrBUnnqz8EAYKzrJ0mrkvdXNPqKy2Mg6R308YYI/ECmU4R
        NuLOUgzIaABnzxvkFoOoZNZerNErJBFvBOjFNVXnziQ5QzhoUzGbxRnPkk8g8MTD
        khCWSjKYKhoZdRof68nShQsBeGPJ4wDA6B39vvcAc/w6uLePhNble7OBUx7vJ21j
        ub7eGy3Q46o3h6QNNGt0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1663809177; x=1663895577; bh=n
        BAxwy7mmxae2g4ruRqIT/WlkqUizN+JnMmmOsyX9Nw=; b=Dn0n8KLAOSyWbD2wa
        PYpDxYjWEp1fA7VZSNKS/JDLv+UgfQZqKaIHH4DxhKmCkjhx/5yAkXhasoQfA6Ym
        lQLA185JXhuqGYD0feLJ5JNmTSOimSofFZwpy7THBes232KpXfbilVa9wGztbivE
        JJsTd3xpE+n8eItJLVqur0tkVh8gWLQwjaSuKYBjOWz422k1krey7FSubEjlOmD2
        3AemdmQ84WSMksz6EmJC3fTCEuaKASwsK60CHa/jS+zkvv9DlrWlGe3uiw6P/vKo
        avJciDxBHEm8Nu7RYCL9r+Wz2QkCRFPgDQNfXoprfY/OhNvkOMVuktqrnjdAQj/+
        lNd8Q==
X-ME-Sender: <xms:mbYrY9_UH72Ifz19z24afFAkAI3rzu5wDLvnjJzI2NC-2uOPST95eg>
    <xme:mbYrYxsZWAdxeNmk1IbLJJQTUB7Pq4kziuHmXAQhuGv6as-Jspu5abomVaNQCb2jT
    q2am_8RqC3L9jdmGA>
X-ME-Received: <xmr:mbYrY7BKVc2hjJdgDx9_jw3GbH8F8POzm5Eg9PSCXVLE2lG-1mG9KyTbskNHIBlxF3CbIJ8jbRG7B4UW-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefvddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:mbYrYxdZjs2PBWY7MlDhw8Se1z1ZAv6gNQvP3OpEWdz0In6QgSGxVg>
    <xmx:mbYrYyNdHrlejDwU69R9nYlb4SysVt-WQec-WQQrjFbuPx4tFaYy8Q>
    <xmx:mbYrYzm2xdCsXDK1fupwh5KThuV72x4arm7lGCZdbgaOws3SX0aFfg>
    <xmx:mbYrY8uiUOsmO8LRPgiok_bWIjflGKvab4XIOxzIPv2Ob-6HhPbLOA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Sep 2022 21:12:57 -0400 (EDT)
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
Subject: [PATCH v1 04/12] mm: prevent pageblock size being larger than section size.
Date:   Wed, 21 Sep 2022 21:12:44 -0400
Message-Id: <20220922011252.2266780-5-zi.yan@sent.com>
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

Only physical pages from a section can be guaranteed to be contiguous
and so far a pageblock can only group contiguous physical pages by
design. Set pageblock_order properly to prevent pageblock going beyond
section size.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/pageblock-flags.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flag=
s.h
index e83c4c095041..95589b24fff9 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -47,8 +47,11 @@ extern unsigned int pageblock_order;
=20
 #else /* CONFIG_HUGETLB_PAGE */
=20
-/* If huge pages are not used, group by MAX_ORDER_NR_PAGES */
-#define pageblock_order		MAX_ORDER
+/*
+ * If huge pages are not used, group by MAX_ORDER_NR_PAGES or
+ * PAGES_PER_SECTION when MAX_ORDER_NR_PAGES is larger.
+ */
+#define pageblock_order		(min(PFN_SECTION_SHIFT, MAX_ORDER))
=20
 #endif /* CONFIG_HUGETLB_PAGE */
=20
--=20
2.35.1

