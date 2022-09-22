Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B23F5E57DE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiIVBNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiIVBNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:13:02 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030BB49B52
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 18:13:01 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3734A5C00C9;
        Wed, 21 Sep 2022 21:13:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 21 Sep 2022 21:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663809180; x=
        1663895580; bh=581oZMKShZxT8Zn0zMTVJFcTkBUcW/2CxVH64DF0VuQ=; b=5
        /v8yeDpgRIOk7r62sNn9dlusfwrrbRWOJNYqTILsa8dzvtX22ug3mrD8CWKL4rgz
        g6JHE6jJy64E6Mwma+5D7cRrJNjxZgKZAOI2QJgc7MFfZ77aStnTVeb+PlMlFcKG
        sHfqg2LF0CVSBhH5lqxe2A4ooWPtO6inrhjS9DvvgeXa7zs+pZ33pGQPemR4AclV
        TFgeASNL3mR76hXjBXcpIFLYODhLF5WxIVJJqYs54sG8LyUDoDJ/425SKa+dAAxE
        ov1cAZTbVCWXZcWHMDPe4gGsShDhvwQ1hD5hH29vs/G6CLpu0o20AWeiE7bB3UOr
        E907F5GCUUqGCUoYRdKNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1663809180; x=1663895580; bh=5
        81oZMKShZxT8Zn0zMTVJFcTkBUcW/2CxVH64DF0VuQ=; b=hBmOfHdvykBjpUqXA
        Piz4qtLt5nV6dD8qGBG15J8U9CHEFAADbsYLT+DhUoYq13DGxR1n/tD6P6PvtYO3
        n2wOFiYvlk98dHTviwGdjm1lJzTqAzeOV1sTDVlr6js1/TghE0b1xNB0DQKcJDJ8
        pLOKUibjfNa6/pEkGByvcbsf6cpCQJgie00iWkoPvxSqTtBiA7O41Es2mQWf27un
        1+m0KhwqvwjR6z/k7r+1KKLU+9lGgE16aHfl531vb8ft1TNO08DqRLWbQl51MqIl
        IyfKNBcjfprOCZiUOtNTt5RkxL7UF2iG9Jt5vBVpkZ3QOzblovuQU1cQD4WDmoA4
        utk8w==
X-ME-Sender: <xms:nLYrYx07fsyhG2NVGhdKaLQHDvkEFZ2_6JP1XPhKYc2teDfzjzPH4g>
    <xme:nLYrY4FVjWfGzvnrw_dcFTQPUYrCEcAUESjsK5uHpXhwedM3PaH3svUaZalHzcDmy
    F2xPnqKopfzQp5tow>
X-ME-Received: <xmr:nLYrYx6mS7pPPSrO5hyyF5h7h8W-AYUK8rngt0q0t7tHhcM6efguErKX-Dlj5ml01gyjLP3rHlnP1rEeqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefvddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:nLYrY-0aALb4juiykLMGwfGDqPO0iYp2uN1oh-EqNX1PqS-hmiHtXg>
    <xmx:nLYrY0Ep_CobihJFxNRHF_qZ4ePSvlLmmH81OvbdxBJAtDg5w9eh2w>
    <xmx:nLYrY_-SQMFnwZ1sGMS91OM_wqtwo4SQ9eygPzi4fumq0DBIOWjaHw>
    <xmx:nLYrY4GlsaJV5R4jNHenLP7mGJ2tIa3P0EJJEJYk2WT6ZbDNOZMW3Q>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Sep 2022 21:12:59 -0400 (EDT)
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
Subject: [PATCH v1 06/12] virtio: virtio_balloon: use pageblock_order instead of MAX_ORDER
Date:   Wed, 21 Sep 2022 21:12:46 -0400
Message-Id: <20220922011252.2266780-7-zi.yan@sent.com>
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

virtio_balloon used MAX_ORDER to report free page blocks to host, as
MAX_ORDER becomes modifiable in later commits, the reported free size might
be too big. pageblock_order is either 1/2 of or the same as MAX_ORDER
currently. Use pageblock_order instead to make virtio_balloon have a
constant free page block report size when MAX_ORDER is changed in the later
commits.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloo=
n.c
index 5b15936a5214..51447737538b 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -33,7 +33,7 @@
 #define VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG (__GFP_NORETRY | __GFP_NOWARN =
| \
 					     __GFP_NOMEMALLOC)
 /* The order of free page blocks to report to host */
-#define VIRTIO_BALLOON_HINT_BLOCK_ORDER MAX_ORDER
+#define VIRTIO_BALLOON_HINT_BLOCK_ORDER pageblock_order
 /* The size of a free page block in bytes */
 #define VIRTIO_BALLOON_HINT_BLOCK_BYTES \
 	(1 << (VIRTIO_BALLOON_HINT_BLOCK_ORDER + PAGE_SHIFT))
--=20
2.35.1

