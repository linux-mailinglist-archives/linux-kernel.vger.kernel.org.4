Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8335BBCED
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 11:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiIRJtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 05:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiIRJtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 05:49:31 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC861C4;
        Sun, 18 Sep 2022 02:49:27 -0700 (PDT)
X-QQ-mid: bizesmtp64t1663494563tqmiobyb
Received: from localhost.localdomain ( [125.70.163.64])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 18 Sep 2022 17:49:22 +0800 (CST)
X-QQ-SSF: 01000000002000E0G000B00A0000000
X-QQ-FEAT: 96VJ2VzXm/o4MkgZbjD89crh9aBQbuvCzUolp+8kUKNEvhOMv10Dyo7/pNjwR
        pLif67YN4n8mLYl5wnI0JMpHgTAoAZ2iX8LxVraCIFrYu+keDGZF391HWmfDCw06Va8Ogsp
        HG3IyH9t83T912bhiPkvP34gUEkwbzC5Xr6SEgwShh5wvT31DndxNHUVw/WHFHASrKieXdh
        SzWkpBuKOurLStBPq1uy4bzxhDjoYn/sSpob4iZdPOo15mX7zF01s4G1FsKVyiWyCMxPSXl
        5dWe2UCNjcomoZtyYaFjWVfzKRghVJ2p0ob5tpgzFg2x/sRq4xtTzzdqVkkpg1rY6OYYAXB
        yjS0cvtBIaG8EFjbgWaDgKmreneaV+bGupYL9mfYytQG7ZrrmnnrjhH22XePQ==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     robh+dt@kernel.org, frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] of: device: fix repeated words in comments
Date:   Sun, 18 Sep 2022 17:49:15 +0800
Message-Id: <20220918094915.19567-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'of'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/of/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 75b6cbffa755..6158173b92ad 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -19,7 +19,7 @@
 
 /**
  * of_match_device - Tell if a struct device matches an of_device_id list
- * @matches: array of of device match structures to search in
+ * @matches: array of device match structures to search in
  * @dev: the of device structure to match against
  *
  * Used by a driver to check whether an platform_device present in the
-- 
2.36.1

