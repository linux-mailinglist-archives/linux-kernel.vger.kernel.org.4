Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CBD73CE51
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 05:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjFYDwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 23:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjFYDwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 23:52:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8809A1B8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 20:52:33 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QpcVp5TPpzqTv3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 11:52:18 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 25 Jun
 2023 11:52:31 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <bsingharora@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] delayacct: Remove obsolete delayacct_is_task_waiting_on_io()
Date:   Sun, 25 Jun 2023 11:51:50 +0800
Message-ID: <20230625035150.1140988-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

There's on caller left since commit a3d5dc908a5f ("delayacct: support
swapin delay accounting for swapping without blkio"). So remove it.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/delayacct.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 6639f48dac36..422ba4e66f65 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -244,8 +244,6 @@ static inline int delayacct_add_tsk(struct taskstats *d,
 { return 0; }
 static inline __u64 delayacct_blkio_ticks(struct task_struct *tsk)
 { return 0; }
-static inline int delayacct_is_task_waiting_on_io(struct task_struct *p)
-{ return 0; }
 static inline void delayacct_freepages_start(void)
 {}
 static inline void delayacct_freepages_end(void)
-- 
2.27.0

