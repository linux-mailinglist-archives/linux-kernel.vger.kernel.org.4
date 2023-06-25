Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E2F73D0C9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjFYMMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjFYMMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:12:13 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BCB9F
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 05:12:13 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QpqYF0C08zLn4F;
        Sun, 25 Jun 2023 20:10:09 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 25 Jun
 2023 20:12:10 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
        <johannes@sipsolutions.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>
CC:     <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] um/x86: Remove unsued extern declaration ldt_host_info()
Date:   Sun, 25 Jun 2023 20:11:20 +0800
Message-ID: <20230625121120.27584-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is unused now, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/x86/um/asm/mm_context.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/um/asm/mm_context.h b/arch/x86/um/asm/mm_context.h
index 4a73d63e4760..dc32dc023c2f 100644
--- a/arch/x86/um/asm/mm_context.h
+++ b/arch/x86/um/asm/mm_context.h
@@ -11,8 +11,6 @@
 #include <linux/mutex.h>
 #include <asm/ldt.h>
 
-extern void ldt_host_info(void);
-
 #define LDT_PAGES_MAX \
 	((LDT_ENTRIES * LDT_ENTRY_SIZE)/PAGE_SIZE)
 #define LDT_ENTRIES_PER_PAGE \
-- 
2.34.1

