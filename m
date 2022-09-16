Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DFD5BA4A5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 04:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiIPCeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 22:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIPCem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 22:34:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD202B268;
        Thu, 15 Sep 2022 19:34:40 -0700 (PDT)
Received: from canpemm500008.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MTJ211fg4zNm71;
        Fri, 16 Sep 2022 10:30:01 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500008.china.huawei.com
 (7.192.105.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 10:34:38 +0800
From:   Li Jinlin <lijinlin3@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linfeilong@huawei.com>
Subject: [PATCH] block/blk-rq-qos: delete useless enmu RQ_QOS_IOPRIO
Date:   Fri, 16 Sep 2022 10:32:41 +0800
Message-ID: <20220916023241.32926-1-lijinlin3@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500008.china.huawei.com (7.192.105.151)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since blk-ioprio handing was converted from a rqos policy to a direct call,
RQ_QOS_IOPRIO is not used anymore, just delete it.

Signed-off-by: Li Jinlin <lijinlin3@huawei.com>
---
 block/blk-mq-debugfs.c | 2 --
 block/blk-rq-qos.h     | 1 -
 2 files changed, 3 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index dee789f2f98f..bd942341b638 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -807,8 +807,6 @@ static const char *rq_qos_id_to_name(enum rq_qos_id id)
 		return "latency";
 	case RQ_QOS_COST:
 		return "cost";
-	case RQ_QOS_IOPRIO:
-		return "ioprio";
 	}
 	return "unknown";
 }
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 08b856570ad1..1ef1f7d4bc3c 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -17,7 +17,6 @@ enum rq_qos_id {
 	RQ_QOS_WBT,
 	RQ_QOS_LATENCY,
 	RQ_QOS_COST,
-	RQ_QOS_IOPRIO,
 };
 
 struct rq_wait {
-- 
2.23.0

