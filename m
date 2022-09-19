Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22B35BD012
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiISPMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiISPMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:12:14 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767A82A712
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:12:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQEvWFT_1663600327;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VQEvWFT_1663600327)
          by smtp.aliyun-inc.com;
          Mon, 19 Sep 2022 23:12:08 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xhao@linux.alibaba.com
Subject: [PATCH v1 1/2] mm/damon/sysfs: remove unnecessary variables
Date:   Mon, 19 Sep 2022 23:12:00 +0800
Message-Id: <20220919151201.66696-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just do a little change here, the 'err' variable really no need to stay
here.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/sysfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 0cca1909bf67..b852a75b9f39 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1109,9 +1109,8 @@ static ssize_t start_store(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	struct damon_sysfs_region *region = container_of(kobj,
 			struct damon_sysfs_region, kobj);
-	int err = kstrtoul(buf, 0, &region->start);

-	if (err)
+	if (kstrtoul(buf, 0, &region->start))
 		return -EINVAL;
 	return count;
 }
@@ -1130,9 +1129,8 @@ static ssize_t end_store(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	struct damon_sysfs_region *region = container_of(kobj,
 			struct damon_sysfs_region, kobj);
-	int err = kstrtoul(buf, 0, &region->end);

-	if (err)
+	if (kstrtoul(buf, 0, &region->end))
 		return -EINVAL;
 	return count;
 }
--
2.31.0
