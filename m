Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA895FACAA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJKGWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJKGVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:21:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8179388DF3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 23:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665469293; x=1697005293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=daaV3WZWukjbgGvbQ73mOCe8nI4eaN3LDyARuyKPkhs=;
  b=ByuPlgddCmgqfX3Ubtch4r85kAcf5gII3xFwhlqQ09JR9u91jIT+KpMI
   HZgONM5e+wRAfbm9S1D50j8Mlru9BmEcdNEebZQNqfb7qPkur6i7X+pQ3
   wdNEbD3nGtvgqDvi9VX3XdQZymv4YGmZ89waJ3wLJlcVguH09DOrfCVAU
   PYBtIT2bnWe1Bf68c64Cw1wBrookKSgQM9ePLLiZOhbWxw7PC9koAwOLi
   iUUd1nv9SNxDk1FFVPpqMhGFvXOFpEV7D5laUP/qCWWn9JYgmD6M6N6nb
   R+zPtGl31sJcpS5dQwuZt3IxJFTEFP5WSQPxnY6xowF60JxAfrFZTzJ2k
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="284149504"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="284149504"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 23:21:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="577321998"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="577321998"
Received: from q.bj.intel.com ([10.238.154.102])
  by orsmga003.jf.intel.com with ESMTP; 10 Oct 2022 23:21:20 -0700
From:   shaoqin.huang@intel.com
To:     rppt@kernel.org
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] memblock test: Update TODO list
Date:   Tue, 11 Oct 2022 14:21:22 +0800
Message-Id: <20221011062128.49359-4-shaoqin.huang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011062128.49359-1-shaoqin.huang@intel.com>
References: <20221011062128.49359-1-shaoqin.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

