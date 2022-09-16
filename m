Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA2A5BA767
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 09:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiIPHX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 03:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiIPHXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 03:23:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A34A50DD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 00:23:37 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MTQSM2072zmVSP;
        Fri, 16 Sep 2022 15:19:47 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 15:23:34 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <osalvador@suse.de>, <anshuman.khandual@arm.com>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 00/16] A few cleanup patches for mm
Date:   Fri, 16 Sep 2022 15:22:41 +0800
Message-ID: <20220916072257.9639-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
This series contains a few cleanup patches to remove the obsolete
comments and functions, use helper macro to improve readability and
so on. More details can be found in the respective changelogs.
Thanks!
---
v2:
  Thanks David, Oscar, Anshuman and Matthew for review and comment!
  Collect Reviewed-by and Acked-by tag.
  3/6: Further remove NR_PCP_ORDER_WIDTH per Matthew.
  8/16: Tweak changelog to better explain the issue per Oscar.
  12/16: Adjust if block to match comment per David.
---
Miaohe Lin (16):
  mm/page_alloc: ensure kswapd doesn't accidentally go to sleep
  mm/page_alloc: make zone_pcp_update() static
  mm: remove obsolete macro NR_PCP_ORDER_MASK and NR_PCP_ORDER_WIDTH
  mm/page_alloc: remove obsolete comment in zone_statistics()
  mm/page_alloc: add __init annotations to
    init_mem_debugging_and_hardening()
  mm/page_alloc: fix freeing static percpu memory
  mm: remove obsolete pgdat_is_empty()
  mm/page_alloc: add missing is_migrate_isolate() check in
    set_page_guard()
  mm/page_alloc: use local variable zone_idx directly
  mm, memory_hotplug: remove obsolete generic_free_nodedata()
  mm/page_alloc: make boot_nodestats static
  mm/page_alloc: use helper macro SZ_1{K,M}
  mm/page_alloc: init local variable buddy_pfn
  mm/page_alloc: use costly_order in WARN_ON_ONCE_GFP()
  mm/page_alloc: remove obsolete gfpflags_normal_context()
  mm/page_alloc: fix obsolete comment in deferred_pfn_valid()

 include/linux/gfp.h            | 23 -------------
 include/linux/memory_hotplug.h |  8 -----
 include/linux/mm.h             |  2 +-
 include/linux/mmzone.h         | 12 -------
 mm/internal.h                  |  3 --
 mm/page_alloc.c                | 63 ++++++++++++++++------------------
 6 files changed, 31 insertions(+), 80 deletions(-)

-- 
2.23.0

