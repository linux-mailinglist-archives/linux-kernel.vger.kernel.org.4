Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A166F5E57DF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiIVBN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiIVBNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:13:02 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2054D4CA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 18:13:01 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DFF1D5C0163;
        Wed, 21 Sep 2022 21:13:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 21 Sep 2022 21:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663809180; x=
        1663895580; bh=4qf8gwW64yaS/ijpFJ5QAbyea/2OTfhuki+JGD62W78=; b=F
        zzo+GA+Y+3nduM+jCB3uwjFWL4HQ+5fng2KryrWBV400EykVrizlQ72aQRQpqJdG
        qMkG7T+0oOdph/N5cdTUvpQ8mkNbkvO+8v/HXLtbLwk/egvD+hxz9dd+Rxhymojn
        uMbATHeGqQmx4OiZF/5ZJjNZ6VRMILTkwDt/o1Ia3ff9yreInYERJEljR+CXFICo
        k8OeZBJ0nxzayAWQ6+wvc8+bL51AUDuoRmf0Lyvnc7zZGApPO8YXg3d0jgu3JRiS
        HnOYwMMAAexr6qcsjqX7zjsb/XqzgwqWFQKpOIpyjhe+zZR5coojlL5/MahKIqD8
        YNK/aa0ZxsJl89BeQjI0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1663809180; x=1663895580; bh=4
        qf8gwW64yaS/ijpFJ5QAbyea/2OTfhuki+JGD62W78=; b=pTT+0lmOVk5f9USJ5
        g/LxbJqaZ6V4sUvK8DR8UvI90Y9/e6WsFSKRPjY4jmUhUHINzTz9g8y1jemIbEbj
        XTj6WuBoL8oSblVOluTqEW5RoT+ladIxiZqwqDrZw5VonMTvB8eq0WChatnCGqRl
        hoOiXaf9McR3RwCKJHVIuGoFL1K0XTZwbGnca4f6ZtFsfhWdz1GA6yspy5Crtrga
        rU81ccpSrlxN9gwrgOjIx1BYIhTzFwkrobvdf2iw+R1Zby463Dh5Q0DaJ34y8fLm
        zvPMZxzXQePKdJVYBXqsMrmBiAtAYScnP22QXAUlAQ9nCdgpVQ0zNDWmSFCmwgbz
        IThAQ==
X-ME-Sender: <xms:nLYrYwWcLuXTDS_7Lej0I8Yux3Xa_Jli03xKU0pf6t0A-XvHUoNVhQ>
    <xme:nLYrY0kIl-dvpkcvOYYHLLT879SWbBXPns3HFPREy-EBU6ymFAsKPbX2ffQt2s5n_
    0xS8-GKcgItYFz_2g>
X-ME-Received: <xmr:nLYrY0Z1bDVH2-lXZjtAmGBFgJuznl-V_LODMGOjAACPzxsCPhVziFN6lJN7xB28WgaYKZ7Qw9vgMcwfaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefvddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:nLYrY_U-9kURvmnuIKRywQj-kpsUr_MxqgKrVMv43bdNGad_E4PlmQ>
    <xmx:nLYrY6mwiMIaWFKZi1yjkiyqdS17xcBnbKGcib5iu5UhzwX5STKKog>
    <xmx:nLYrY0eqnY0AJdVeulRSaSeoYBurfUZLBDhJQtbAs0eN0D14Ki_dSg>
    <xmx:nLYrYwk0-ZTZ1Hk0I_Ar5bkWKTEQRxWJFwMFtryVGvhAWbJmVY0sLw>
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
Subject: [PATCH v1 07/12] mm/page_reporting: set page_reporting_order to -1 to prevent it running
Date:   Wed, 21 Sep 2022 21:12:47 -0400
Message-Id: <20220922011252.2266780-8-zi.yan@sent.com>
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

page_reporting_order was initialized to MAX_ORDER to prevent it running
before its value is overwritten. Use -1 instead to remove the
dependency on MAX_ORDER.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/page_reporting.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index d52a55bca6d5..e3d6f4af34e0 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -11,7 +11,11 @@
 #include "page_reporting.h"
 #include "internal.h"
=20
-unsigned int page_reporting_order =3D MAX_ORDER + 1;
+/*
+ * Set page_reporting_order to (unsigned int)-1 to prevent it running unti=
l the
+ * value is being overwritten
+ */
+unsigned int page_reporting_order =3D (unsigned int)-1;
 module_param(page_reporting_order, uint, 0644);
 MODULE_PARM_DESC(page_reporting_order, "Set page reporting order");
=20
--=20
2.35.1

