Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6134D6190DD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 07:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiKDGU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 02:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiKDGUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 02:20:19 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A21F2A256;
        Thu,  3 Nov 2022 23:20:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VTve9Ku_1667542815;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VTve9Ku_1667542815)
          by smtp.aliyun-inc.com;
          Fri, 04 Nov 2022 14:20:16 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] block: Fix some kernel-doc comments
Date:   Fri,  4 Nov 2022 14:20:14 +0800
Message-Id: <20221104062014.62656-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
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

Remove the description of @required_features in elevator_match()
to clear the below warning:

block/elevator.c:103: warning: Excess function parameter 'required_features' description in 'elevator_match'

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2734
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 block/elevator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/elevator.c b/block/elevator.c
index 800e0038be0d..a5bdc3b1e7e5 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -94,7 +94,6 @@ static inline bool elv_support_features(struct request_queue *q,
  * elevator_match - Test an elevator name and features
  * @e: Scheduler to test
  * @name: Elevator name to test
- * @required_features: Features that the elevator must provide
  *
  * Return true if the elevator @e name matches @name and if @e provides all
  * the features specified by @required_features.
-- 
2.20.1.7.g153144c

