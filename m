Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1945BC188
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 04:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiISCtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 22:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiISCtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 22:49:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D902193F7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 19:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663555759; x=1695091759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=daaV3WZWukjbgGvbQ73mOCe8nI4eaN3LDyARuyKPkhs=;
  b=mB/daAxY5PJPkBPvV6qri2d5ug70t10Gta0naPxd7pYTqqvEXGR9bJtc
   q2v3um/XYuN7JibueRM/Ekt+TNyWN6pcWhd+ojpXgbqZ/vwAhO3lFZ9ks
   umbZ2bcyL8iyr2SUpknVe8R0wFu3c9NRK874wF7HhjmwdkI2a9jJbXeJo
   DxcZvRrC91i18VtqDkeR9iGi5TqaSV3Bv1b8xvC58sn4kzB4ZWY4x7xhT
   nrVZ8ZakaysKZNcopFCYrJuCCsYS5vjt1cPOTzSfcvOFQZk3WBi4zkNTx
   5lSncPjW4KW4dOpnisYFRZlD+746RQjS0Nkb4TYjDhRYoxsWItclMRoke
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="298019471"
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="298019471"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 19:49:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="947035197"
Received: from q.bj.intel.com ([10.238.154.102])
  by fmsmga005.fm.intel.com with ESMTP; 18 Sep 2022 19:49:18 -0700
From:   shaoqin.huang@intel.com
To:     rppt@kernel.org
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] memblock test: Update TODO list
Date:   Mon, 19 Sep 2022 10:47:39 +0800
Message-Id: <20220919024745.153395-4-shaoqin.huang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220919024745.153395-1-shaoqin.huang@intel.com>
References: <20220919024745.153395-1-shaoqin.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaoqin Huang <shaoqin.huang@intel.com>

Remove the completed items from TODO list.

Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
---
 tools/testing/memblock/TODO | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/tools/testing/memblock/TODO b/tools/testing/memblock/TODO
index 33044c634ea7..503cc96fcdc3 100644
--- a/tools/testing/memblock/TODO
+++ b/tools/testing/memblock/TODO
@@ -1,17 +1,10 @@
 TODO
 =====
 
-1. Add tests trying to memblock_add() or memblock_reserve() 129th region.
-   This will trigger memblock_double_array(), make sure it succeeds.
-   *Important:* These tests require valid memory ranges, use dummy physical
-                memory block from common.c to implement them. It is also very
-                likely that the current MEM_SIZE won't be enough for these
-                test cases. Use realloc to adjust the size accordingly.
-
-2. Add test cases using this functions (implement them for both directions):
+1. Add test cases using this functions (implement them for both directions):
    + memblock_alloc_raw()
    + memblock_alloc_exact_nid_raw()
    + memblock_alloc_try_nid_raw()
 
-3. Add tests for memblock_alloc_node() to check if the correct NUMA node is set
+2. Add tests for memblock_alloc_node() to check if the correct NUMA node is set
    for the new region
-- 
2.34.1

