Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40935623C10
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbiKJGrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiKJGrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:47:47 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF842A433
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 22:47:45 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N7C3k4MzVzpWRF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:44:02 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 14:47:43 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <shaozhengchao@huawei.com>
Subject: [PATCH] hashtable: fix some kernel-doc comments
Date:   Thu, 10 Nov 2022 14:54:41 +0800
Message-ID: <20221110065441.87299-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit a8b7b2d0b3fc ("sched: sch_api: add missing rcu read lock to
silence the warning") has been merged, the macro hlist_for_each_entry_rcu
comments should be updated.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 include/linux/hashtable.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/hashtable.h b/include/linux/hashtable.h
index f6c666730b8c..8b50bb68428d 100644
--- a/include/linux/hashtable.h
+++ b/include/linux/hashtable.h
@@ -172,6 +172,7 @@ static inline void hash_del_rcu(struct hlist_node *node)
  * @obj: the type * to use as a loop cursor for each entry
  * @member: the name of the hlist_node within the struct
  * @key: the key of the objects to iterate over
+ * @cond: optional lockdep expression if called from non-RCU protection.
  */
 #define hash_for_each_possible_rcu(name, obj, member, key, cond...)	\
 	hlist_for_each_entry_rcu(obj, &name[hash_min(key, HASH_BITS(name))],\
-- 
2.17.1

