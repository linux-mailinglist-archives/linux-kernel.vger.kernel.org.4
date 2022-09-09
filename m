Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C78A5B33E4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiIIJ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiIIJ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:26:54 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBDF481D7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:25:27 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MP9XJ6SsqzHnh1;
        Fri,  9 Sep 2022 17:23:28 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 9 Sep
 2022 17:25:25 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <david@redhat.com>, <osalvador@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 00/16] A few cleanup patches for mm
Date:   Fri, 9 Sep 2022 17:24:35 +0800
Message-ID: <20220909092451.24883-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Miaohe Lin (16):
  mm/page_alloc: ensure kswapd doesn't accidentally go to sleep
  mm/page_alloc: make zone_pcp_update() static
  mm: remove obsolete macro NR_PCP_ORDER_MASK
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
 include/linux/mmzone.h         |  6 ----
 mm/internal.h                  |  3 --
 mm/page_alloc.c                | 60 ++++++++++++++++------------------
 6 files changed, 30 insertions(+), 72 deletions(-)

-- 
2.23.0

