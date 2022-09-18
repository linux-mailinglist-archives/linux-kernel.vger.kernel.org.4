Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00BA5BBD5C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 12:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiIRKE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 06:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiIRKEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 06:04:55 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07666DF53
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 03:04:53 -0700 (PDT)
X-QQ-mid: bizesmtp85t1663495479t7gj5w7r
Received: from localhost.localdomain ( [125.70.163.64])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 18 Sep 2022 18:04:38 +0800 (CST)
X-QQ-SSF: 01000000002000E0G000B00A0000000
X-QQ-FEAT: 3adAc7TLCXY5GaKtkvGuWZSpXIuPCtcW0x06nRb+TzPWDCEA7o+eax3sCIHGn
        wAS0qA8l13ldUQJSPaxkajN9huBgtljyv8WH+5LRvQS4I/YrbqJcf8TQ0zAUmJYGnrJQ9wo
        CYzGWBFt1/Dvk3Rw7bHS3oggknp5ffS1Wc6lt++C4zEF2nvX0U5KDO55TL4TPO9RLgIkXKH
        vM4omGy6s8lsPh9r5/qtR/ZdxpJsXRnJP8jf7sLhEkgzMyw86OAqtnCpNg6Yb5sJliEeFKl
        ve93v0voSz6cya7wSVQQ39bwKWBQNo5YTjJQSFebL1qdVT5461czl70qfpmWzwLzq24E0Iq
        8QUZK7lUGNXQJ5ODZqUS+vDcB86ZnRHfjWyQuuuPbJ15tje+CufXlC/6VcELw==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     tomas.winkler@intel.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] mei: fix repeated words in comments
Date:   Sun, 18 Sep 2022 18:04:31 +0800
Message-Id: <20220918100431.28381-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'from'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/misc/mei/hw-txe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/hw-txe.c b/drivers/misc/mei/hw-txe.c
index 00652c137cc7..1f72bbd5ee51 100644
--- a/drivers/misc/mei/hw-txe.c
+++ b/drivers/misc/mei/hw-txe.c
@@ -176,7 +176,7 @@ static bool mei_txe_aliveness_set(struct mei_device *dev, u32 req)
  * @dev: the device structure
  *
  * Extract HICR_HOST_ALIVENESS_RESP_ACK bit from
- * from HICR_HOST_ALIVENESS_REQ register value
+ * HICR_HOST_ALIVENESS_REQ register value
  *
  * Return: SICR_HOST_ALIVENESS_REQ_REQUESTED bit value
  */
-- 
2.36.1

