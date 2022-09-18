Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA575BBD59
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 12:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiIRKDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 06:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiIRKCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 06:02:42 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B52E2B25B
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 03:01:47 -0700 (PDT)
X-QQ-mid: bizesmtp67t1663495293tdq605wc
Received: from localhost.localdomain ( [125.70.163.64])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 18 Sep 2022 18:01:32 +0800 (CST)
X-QQ-SSF: 01000000002000E0G000B00A0000000
X-QQ-FEAT: hoArX50alxEDClN2oLfmw1bIc39VmrkBDny264n4KUaWSfedntjVIyx6r+c8c
        L/WGKFk0vDaQuqpoGGjlA0QeShQoOonQrFG6Vw8U/zLcry5dX9Gp7z5MIdgtHhdJJkUnzMS
        sGbKIutx3/mt576H2foz7qo3/v4X2+mac3s6hEZ0kGKaRyQ3TPBgmvjC2VEh0+qNTEGQDBr
        XMNUiOd/civm8ESsRm/6Y8DPE+Dv93B+73CxWA+idNs5JVYuNZbRDSsL2r+fX7j7K+xmrwW
        UokFHwmqvMx0j/suTI0l4KzW0L5yiAAb+V4QoCn+IkaQfxMGqhkjG6In3lVptHpKy0nYDus
        IMthyVk0ZKAcx9YOi+Sw/bE7j4+QjUBj9R+DY3HTP2FPtw8Um9z2S76U1iLKQ==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     namit@vmware.com, pv-drivers@vmware.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] mm: fix repeated words in comments
Date:   Sun, 18 Sep 2022 18:01:25 +0800
Message-Id: <20220918100125.25558-1-yuanjilin@cdjrlc.com>
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

Delete the redundant word 'on'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/misc/vmw_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 61a2be712bf7..c2e774f68133 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -736,7 +736,7 @@ static int vmballoon_handle_one_result(struct vmballoon *b, struct page *page,
  * @p: pointer to where the page struct is returned.
  *
  * Following a lock or unlock operation, returns the status of the operation for
- * an individual page. Provides the page that the operation was performed on on
+ * an individual page. Provides the page that the operation was performed on
  * the @page argument.
  *
  * Returns: The status of a lock or unlock operation for an individual page.
-- 
2.36.1

