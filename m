Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BCF686308
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjBAJmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjBAJmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:42:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF635EFA1;
        Wed,  1 Feb 2023 01:42:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 524BDB82153;
        Wed,  1 Feb 2023 09:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8B1C433D2;
        Wed,  1 Feb 2023 09:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675244531;
        bh=fyLlrQ6ozpspF/7rhlxFsw35A1aS+p/JI5vd/nqAEI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LbRn4123EqJwl5vEXwKvzNGH6riD3I4I8aAz+Bht3IeAsN9v/FQtOQDySY6xwCW++
         J76LeDvdGxFuaiZI9wS25/zn4SS2p0HRbPitWmdPEf7QCh4zpPuox6WOWZZNE8MAEG
         ag74tfu35YPsO/TUR6hAYEIUVlIUkHesj/LPxDwImyWSiy7jAlrFbabrvfOZ0W2aes
         bxWMOBNUvVA/pSsFPwogytySjjvjzHMDwUvJvUrFq2iGo+AEzRiCLXU00FQ0l4uUJi
         LOHLmsZvU91nMYrqatg0Zc0qb4E+8bjgiklJOM74gBjaaax7PJjQA42qdcNDmxyobq
         Gh6fhOMgdbaNg==
From:   Mike Rapoport <rppt@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 1/3] docs/mm: Physical Memory: remove useless markup
Date:   Wed,  1 Feb 2023 11:41:54 +0200
Message-Id: <20230201094156.991542-2-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230201094156.991542-1-rppt@kernel.org>
References: <20230201094156.991542-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
Acked-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 Documentation/core-api/dma-api.rst   |  2 --
 Documentation/mm/page_reclaim.rst    |  2 --
 Documentation/mm/physical_memory.rst | 12 ++++++------
 3 files changed, 6 insertions(+), 10 deletions(-)

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
index d24220d62475..3f3c02aa6e6e 100644
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
@@ -64,9 +64,9 @@ one of the types described below.
   change, their content may move between different physical pages. Often
   ``ZONE_MOVABLE`` is populated during memory hotplug, but it may be
   also populated on boot using one of ``kernelcore``, ``movablecore`` and
-  ``movable_node`` kernel command line parameters. See :ref:`Page migration
-  <page_migration>` and :ref:`Memory Hot(Un)Plug <admin_guide_memory_hotplug>`
-  for additional details.
+  ``movable_node`` kernel command line parameters. See
+  Documentation/mm/page_migration.rst and
+  Documentation/admin-guide/mm/memory_hotplug.rst for additional details.
 
 * ``ZONE_DEVICE`` represents memory residing on devices such as PMEM and GPU.
   It has different characteristics than RAM zone types and it exists to provide
@@ -252,7 +252,7 @@ General
 Reclaim control
 ~~~~~~~~~~~~~~~
 
-See also :ref:`Page Reclaim <page_reclaim>`.
+See also Documentation/mm/page_reclaim.rst.
 
 ``kswapd``
   Per-node instance of kswapd kernel thread.
-- 
2.35.1

