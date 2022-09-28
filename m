Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39855EDFD2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbiI1PL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234620AbiI1PLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:11:18 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19AC2AE1E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:11:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VQwVoHU_1664377871;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VQwVoHU_1664377871)
          by smtp.aliyun-inc.com;
          Wed, 28 Sep 2022 23:11:12 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     namit@vmware.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mm/tlb: fix error word 'clleared' to 'cleared'
Date:   Wed, 28 Sep 2022 23:11:09 +0800
Message-Id: <20220928151109.19364-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just correct the wrong word 'clleared' to 'cleared'

Fixes: c9fe66560bf2 ("mm/mprotect: do not flush when not required architecturally")
Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 arch/x86/include/asm/tlbflush.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index cda3118f3b27..c80a15ef0cbc 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -291,7 +291,7 @@ static inline bool pte_flags_need_flush(unsigned long oldflags,
 		diff &= ~_PAGE_ACCESSED;
 
 	/*
-	 * Did any of the 'flush_on_clear' flags was clleared set from between
+	 * Did any of the 'flush_on_clear' flags was cleared set from between
 	 * 'oldflags' and 'newflags'?
 	 */
 	if (diff & oldflags & flush_on_clear)
-- 
2.31.0

