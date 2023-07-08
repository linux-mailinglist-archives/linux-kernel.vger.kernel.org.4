Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F194374BCEF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 10:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjGHI5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 04:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjGHI5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 04:57:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F351FEF
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 01:57:32 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qykdd5Fb2zTkg4;
        Sat,  8 Jul 2023 16:56:21 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 8 Jul
 2023 16:57:28 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 0/8] A few fixup and cleanup patches for memory-failure
Date:   Sat, 8 Jul 2023 16:57:36 +0800
Message-ID: <20230708085744.3599311-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
This series contains a few fixup patches to fix potential permanently
locked hpage, fix race window when trying to get hugetlb folio and so
on. Also there is minor cleanup for comments and codestyle. More details
can be found in the respective changelogs.
Thanks!

Miaohe Lin (8):
  mm: memory-failure: fix potential permanently locked hpage
  mm: memory-failure: ensure moving HWPoison flag to the raw error pages
  mm: memory-failure: Don't account hwpoison_filter() filtered pages
  mm: memory-failure: use local variable huge to check hugetlb page
  mm: memory-failure: remove unneeded header files
  mm: memory-failure: minor cleanup for comments and codestyle
  mm: memory-failure: fetch compound head after extra page refcnt is
    held
  mm: memory-failure: fix race window when trying to get hugetlb folio

 mm/memory-failure.c | 49 +++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

-- 
2.33.0

