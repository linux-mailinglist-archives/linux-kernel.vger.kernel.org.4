Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F605E57D9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiIVBNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiIVBNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:13:00 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2DBAA35B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 18:12:57 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 651605C00D9;
        Wed, 21 Sep 2022 21:12:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 21 Sep 2022 21:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663809176; x=
        1663895576; bh=MSo7ULomsyjNP4gRg30AmWuJ8lrcYe6Of6vn0yDqlEI=; b=U
        bvAtdk3jqb/SLwIn3LagFuki25gtt0dyJHJe9GYei1VxOuWrjHDbf2r7EJwFbaQE
        0saVlcT5+46mnum8Oa4i9NU54dcRAapsGGa4RMi1/Ax7JE6idJfyGjat1dabv/Wo
        cXXbWW8eZYlsVw82WERLDKJEDBXToudONPyYqTZ8cIJzJxt0QW4F6AXUyN6/V0+X
        IitSXYDnm/cC7+u/DJ061AadZf9knvGEcQfpRHdmwSD9E45olDT+cmrMl8WTsyQl
        rlHP7lZ/lG/pgCKfDZV9umu1n0dM083fXP95M/EM+R7a7TLUI9mMpLC+VmHPgG+t
        ZbxnzTBDu8WC4tlP2S0gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1663809176; x=1663895576; bh=M
        So7ULomsyjNP4gRg30AmWuJ8lrcYe6Of6vn0yDqlEI=; b=prFzzCkOPM8m5u0lS
        RomLqylk3YLZgI0vBFe22NgHQ/tGmwhDWMYNWgbeblejanHX3scU1pFw2PMRJbBl
        ahnq8kJkHFG4Kb4iRS1piPUShoW4CvryBzt0qOXiuM6Z/StxS9DZXzdT988whWrj
        U+MNmFceFC+C40vZa8BfnoQRmPTcbom+dQEV2O1JesZe1eZLNk1pKukJgFpKY71T
        fE5ug2hfv2SqkymjpCA4vc8zZzwbz/v/lwPXt1jxFnO5SnU+qRSvtBCMsxJ0w30S
        NSNxIJsCUolE5X8Xg+ehavsd+h/VGpuhcb4lhWat8zfIPovz21hjOfyN1/cLCKMx
        FMW+g==
X-ME-Sender: <xms:mLYrY4QaykZsP4_0YTz8oYzmRUVmUvpfRmoXX81_x7yiKe1h4NQQAw>
    <xme:mLYrY1z-helECTkS1M2ear2AjT_MjarcG6xiL9_XGWZirdDlZH2zZMGp4a5ztftGv
    5r16Nn_-U1x0ZaWBg>
X-ME-Received: <xmr:mLYrY11NxAydffvedRlyf-0c4wA15Sf0JUn_NR59vvBK86GzjsQdmkotq9wepZLzjV8zrSq-r4U-OLjgGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefvddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:mLYrY8DqtQlOK2e4qwRW6L_NAirgvh1yg7U4cKJZiX2OcK-70yIkfA>
    <xmx:mLYrYxg4obgZVTk7bNsq_CoaV9fNxoOnBJEe4JVMyx3X-ph6-uY6kA>
    <xmx:mLYrY4oOEXxdmnlQz9FNRlvE6dckUy-3ojYKfkak7XH4aQCZxMaCfA>
    <xmx:mLYrY0RGPmrCvXrsr-K8rxq1YlmjnyVr751Hd7E0ZTgQEIG5uHlHhg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Sep 2022 21:12:55 -0400 (EDT)
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
Subject: [PATCH v1 02/12] mm: check page validity when find a buddy page in a non-contiguous zone
Date:   Wed, 21 Sep 2022 21:12:42 -0400
Message-Id: <20220922011252.2266780-3-zi.yan@sent.com>
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

When MAX_ORDER > section size, buddy page might not be valid when the zone
is non-contiguous. Check it and return NULL if buddy page is not valid.

For PFNs that not aligned to MAX_ORDER (usually at the beginning and end
of a zone), __free_pages_memory() clamps down the order to make sure
invalid PFN will not show up as a buddy PFN.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/internal.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/internal.h b/mm/internal.h
index b3002e03c28f..22fb1e6e3541 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -330,12 +330,16 @@ static inline struct page *find_buddy_page_pfn(struct=
 page *page,
 			unsigned long pfn, unsigned int order, unsigned long *buddy_pfn)
 {
 	unsigned long __buddy_pfn =3D __find_buddy_pfn(pfn, order);
+	struct zone *zone =3D page_zone(page);
 	struct page *buddy;
=20
 	buddy =3D page + (__buddy_pfn - pfn);
 	if (buddy_pfn)
 		*buddy_pfn =3D __buddy_pfn;
=20
+	if (unlikely(!zone->contiguous && !pfn_valid(__buddy_pfn)))
+		return NULL;
+
 	if (page_is_buddy(page, buddy, order))
 		return buddy;
 	return NULL;
--=20
2.35.1

