Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D77732848
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244057AbjFPHCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243857AbjFPHCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:02:08 -0400
Received: from mx5.didiglobal.com (mx5.didiglobal.com [111.202.70.122])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6EF033AA8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 00:00:52 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.65.12])
        by mx5.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 2135AB006A838;
        Fri, 16 Jun 2023 15:00:50 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 16 Jun 2023 15:00:49 +0800
Date:   Fri, 16 Jun 2023 15:00:41 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From:   tiozhang <tiozhang@didiglobal.com>
To:     <tj@kernel.org>, <jiangshanlai@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <tiozhang@didiglobal.com>,
        <zyhtheonly@gmail.com>, <zyhtheonly@yeah.net>
Subject: [PATCH] workqueue: format pr_warn exceeds line length in wq_numa_init
Message-ID: <20230616070041.GA32700@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: tj@kernel.org, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, zyhtheonly@gmail.com,
        zyhtheonly@yeah.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.79.64.101]
X-ClientProxiedBy: ZJY01-PUBMBX-01.didichuxing.com (10.79.64.32) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Format this long line which would potentially let checkpatch complain
"WARNING: line length of 103 exceeds 100 columns".

Signed-off-by: tiozhang <tiozhang@didiglobal.com>
---
 kernel/workqueue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 47e7b29df5fe..4375c7190353 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5959,7 +5959,8 @@ static void __init wq_numa_init(void)
 
 	for_each_possible_cpu(cpu) {
 		if (WARN_ON(cpu_to_node(cpu) == NUMA_NO_NODE)) {
-			pr_warn("workqueue: NUMA node mapping not available for cpu%d, disabling NUMA support\n", cpu);
+			pr_warn("workqueue: NUMA node mapping not available for cpu%d, disabling NUMA support\n",
+				cpu);
 			return;
 		}
 	}
-- 
2.17.1

