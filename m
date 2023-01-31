Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C879D68287A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjAaJQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjAaJQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:16:07 -0500
Received: from out199-18.us.a.mail.aliyun.com (out199-18.us.a.mail.aliyun.com [47.90.199.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E89F4DCC0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:14:15 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VaWFeLn_1675155933;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VaWFeLn_1675155933)
          by smtp.aliyun-inc.com;
          Tue, 31 Jan 2023 17:05:41 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] x86/delay: clean up some inconsistent indenting
Date:   Tue, 31 Jan 2023 17:04:21 +0800
Message-Id: <20230131090421.46039-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

arch/x86/lib/delay.c:134 delay_halt_mwaitx() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3906
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/x86/lib/delay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
index 0e65d00e2339..7c723d52c0b6 100644
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -131,7 +131,7 @@ static void delay_halt_mwaitx(u64 unused, u64 cycles)
 	 * Use cpu_tss_rw as a cacheline-aligned, seldomly accessed per-cpu
 	 * variable as the monitor target.
 	 */
-	 __monitorx(raw_cpu_ptr(&cpu_tss_rw), 0, 0);
+	__monitorx(raw_cpu_ptr(&cpu_tss_rw), 0, 0);
 
 	/*
 	 * AMD, like Intel, supports the EAX hint and EAX=0xf means, do not
-- 
2.20.1.7.g153144c

