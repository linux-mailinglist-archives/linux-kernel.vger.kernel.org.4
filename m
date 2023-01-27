Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506B967DED2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 09:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjA0IEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 03:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjA0IEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:04:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A49375193;
        Fri, 27 Jan 2023 00:04:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2749B81FBF;
        Fri, 27 Jan 2023 08:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AB9C433EF;
        Fri, 27 Jan 2023 08:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674806646;
        bh=PLW27rVPPgQXoOQSnxZ4p5WQWtbMJcN4Z4Y6W08+hGA=;
        h=From:To:Cc:Subject:Date:From;
        b=Zog1O5zJgSWGN0ZRHgiAnfUzzTV7lKX963HuC3SlN+JCzvHcETcXfEw+6yPGp+rwW
         MFZLWoiFbPpt3jERiro05ZxIA+GbR6TEGyDqiFZzcJFkMeG5kN467XSwjYTCggU4Ah
         kUcUpgO+7RzatdJVjMriSQ8PTuFmLGfNTXdpXbjci90odcQtg3jForgUdhTeB6CzO0
         h46NWnfNLBBalR31Ae1Sm2DIAVeHz4mpxBEPzRXmCeW+PeSSYjkJ0+3kg0CsbYZ8Rs
         LJlDtOpwY7ZjlzebrjhpctH/MiK8UBabJN1BTofo8vK8QKjT5gXXGRV82bIzqde5mL
         lKEzYtXu53wCg==
From:   Mike Rapoport <rppt@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] docs/mm: Physical Memory: remove useless markup
Date:   Fri, 27 Jan 2023 10:03:52 +0200
Message-Id: <20230127080352.177185-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Jon says:

  > +See also :ref:`Page Reclaim <page_reclaim>`.

  Can also just be "See also Documentation/mm/page_reclaim.rst".  The
  right things will happen in the HTML output, readers of the plain-text
  will know immediately where to go, and we don't have to add the label
  clutter.

Remove reference markup and unnecessary labes and use plain file names.

Fixes: 5d8c5e430a63 ("docs/mm: Physical Memory: add structure, introduction and nodes description")
Suggested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 Documentation/core-api/dma-api.rst   | 2 --
 Documentation/mm/page_reclaim.rst    | 2 --
 Documentation/mm/physical_memory.rst | 6 +++---
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
index c847a5b0a0d3..829f20a193ca 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -1,5 +1,3 @@
-.. _dma_api:
-
 ============================================
 Dynamic DMA mapping using the generic device
 ============================================
diff --git a/Documentation/mm/page_reclaim.rst b/Documentation/mm/page_reclaim.rst
index 3fccde066436..50a30b7f8ac3 100644
--- a/Documentation/mm/page_reclaim.rst
+++ b/Documentation/mm/page_reclaim.rst
@@ -1,7 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. _page_reclaim:
-
 ============
 Page Reclaim
 ============
diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
index d24220d62475..120d54ba6ea7 100644
--- a/Documentation/mm/physical_memory.rst
+++ b/Documentation/mm/physical_memory.rst
@@ -39,8 +39,8 @@ one of the types described below.
 * ``ZONE_DMA`` and ``ZONE_DMA32`` historically represented memory suitable for
   DMA by peripheral devices that cannot access all of the addressable
   memory. For many years there are better more and robust interfaces to get
-  memory with DMA specific requirements (:ref:`DMA API <dma_api>`), but
-  ``ZONE_DMA`` and ``ZONE_DMA32`` still represent memory ranges that have
+  memory with DMA specific requirements (Documentation/core-api/dma-api.rst),
+  but ``ZONE_DMA`` and ``ZONE_DMA32`` still represent memory ranges that have
   restrictions on how they can be accessed.
   Depending on the architecture, either of these zone types or even they both
   can be disabled at build time using ``CONFIG_ZONE_DMA`` and
@@ -252,7 +252,7 @@ General
 Reclaim control
 ~~~~~~~~~~~~~~~
 
-See also :ref:`Page Reclaim <page_reclaim>`.
+See also Documentation/mm/page_reclaim.rst.
 
 ``kswapd``
   Per-node instance of kswapd kernel thread.
-- 
2.35.1

