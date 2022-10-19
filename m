Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E560604CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiJSQSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiJSQSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:18:24 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789AA1B6C9F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:18:22 -0700 (PDT)
X-QQ-mid: bizesmtp77t1666184527tr0g1i3e
Received: from localhost.localdomain ( [182.148.15.91])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Oct 2022 21:02:06 +0800 (CST)
X-QQ-SSF: 01000000008000F0I000B00A0000000
X-QQ-FEAT: fs34Pe/+C2Qz/O+Hf3pkbi2c05tFOEa85g4JKwYdHD4DIEeh9/8UtoOJDQV5W
        uwlIh10xrr1mbVPrecjJCbagkFKCRm/doqcF7TA65gPZfgxd7eEfT8okqSjMQXiNX9y/T3A
        TehcB/avalAl/9BSlv8RMFexGikRr8jL+0oO4pPfh8PFhfYlYCw0jNyzMW1rtOCfjoxCC3+
        F9MF6FqfV8e5pW/vwVALp1Q+UcPFnUvbPHdBf2VFI6IkEdrvNtuXbOTH7d4hexaqdXroK6J
        d5kd2dxArrHY6F5yQm8vuPWMmSpsMCz9OId3Xdww8fLAutWpOxkf+IMkTsI8UmWHPBGFTn6
        DFgR5NhvJaIJMZAjwvbx5CaNs+W6W3XZd8rDRpaMVY+u+c9Yoq2QLex7FDXo5KsZw+ICyxC
        CyTE0ws6Pr0=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     robh+dt@kernel.org, frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] of: fix repeated words in comments
Date:   Wed, 19 Oct 2022 21:02:00 +0800
Message-Id: <20221019130200.60460-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 8cefe5a7d04e..16c7e5a2a868 100644
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

