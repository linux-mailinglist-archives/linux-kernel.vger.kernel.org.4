Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B555EF188
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbiI2JMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbiI2JMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:12:10 -0400
Received: from out199-12.us.a.mail.aliyun.com (out199-12.us.a.mail.aliyun.com [47.90.199.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718C75D0E3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:11:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VQzEcpp_1664442642;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VQzEcpp_1664442642)
          by smtp.aliyun-inc.com;
          Thu, 29 Sep 2022 17:10:44 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     namit@vmware.com
Cc:     tglx@linutronix.de, peterz@infradead.org, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/mm/tlb: fix error word 'clleared' to 'cleared'
Date:   Thu, 29 Sep 2022 17:10:40 +0800
Message-Id: <20220929091040.45390-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just correct the wrong word 'clleared' to 'cleared'

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
