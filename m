Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2516286F2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbiKNRXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237513AbiKNRWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:22:40 -0500
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756DA21E20
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:22:36 -0800 (PST)
X-QQ-mid: bizesmtp66t1668446098thihhvo4
Received: from wuhui-virtual-machine.localdoma ( [210.39.1.219])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 15 Nov 2022 01:14:27 +0800 (CST)
X-QQ-SSF: 01400000002000F0W000B00A0000000
X-QQ-FEAT: 3M0okmaRx3jf2HSgc6NA2riFbHnZlW2zT0JYfaAr646Mv5QittwGziEDWtWby
        eK4nCWGiP1qfYT10jOwQsugYHfPzWilHHFNjsQgV8XqW3Gm5AC3PELBuyW3Cn0WCS9Dbe6X
        kZHYJwAjnZZQYMZlKFa23XZtRZQQf6ZDuo8qlEvJO1r0eBu0gq/Cm3meOCfpLM/W8mYYTvZ
        PWQeUyrxa7GdZB615Kjs7puHzmb92vY2H5/tRTlkWhKIInGqDqwBfdTJnoSxfH3JOTfaDK1
        Jviai/6k4vnj+GFmwp7C7c194lJzanmxu93KbKdQGQObHfMaOIE7t6x/0ByVgv12OcD4+aN
        p5C02sXOxvujVlfhvgtOKfpMCupQBTQMgpWbQFDB87veiAkcbw=
X-QQ-GoodBg: 2
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuhongf@szu.edu.cn,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: [PATCH] mm/kmemleak.c: fix a comment
Date:   Tue, 15 Nov 2022 01:14:26 +0800
Message-Id: <20221114171426.91745-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed a typo in a code comment and I fixed it.

Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
---
 mm/kmemleak.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 203d9007295d..92f670edbf51 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1470,7 +1470,7 @@ static void scan_gray_list(void)
 }
 
 /*
- * Conditionally call resched() in a object iteration loop while making sure
+ * Conditionally call resched() in an object iteration loop while making sure
  * that the given object won't go away without RCU read lock by performing a
  * get_object() if !pinned.
  *
-- 
2.25.1

