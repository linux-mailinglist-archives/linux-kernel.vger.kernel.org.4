Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74F36B0097
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCHINE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjCHIM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:12:56 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EACA0F30
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:12:48 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PWlPF3jzmzKqMg;
        Wed,  8 Mar 2023 16:10:41 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 16:12:28 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <damon@lists.linux.dev>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 0/3] mm/damon/paddr: minor code improvement
Date:   Wed, 8 Mar 2023 16:33:08 +0800
Message-ID: <20230308083311.120951-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unify folio_put() to make code more clear, and also fix minor issue in
damon_pa_young().

v3: 
- as SJ split the bugfix from v2, and it has merged[1], only do code
  improvement
- fix a missing folio_sz update in damon_pa_young()
- add RB from SJ
- rebase on next-20230308

[1] https://lkml.kernel.org/r/20230304193949.296391-1-sj@kernel.org

v2: 
- use goto lable in damon_pa_pageout() and refact too more functions

Kefeng Wang (3):
  mm/damon/paddr: minor refactor of damon_pa_pageout()
  mm/damon/paddr: minor refactor of
    damon_pa_mark_accessed_or_deactivate()
  mm/damon/paddr: fix missing folio_sz update in damon_pa_young()

 mm/damon/paddr.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

-- 
2.35.3

