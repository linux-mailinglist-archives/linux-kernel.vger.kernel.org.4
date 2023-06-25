Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D8E73D118
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjFYMy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjFYMyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:54:54 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDC9D2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 05:54:49 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QprXV3Rc2z1HC6c;
        Sun, 25 Jun 2023 20:54:34 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 25 Jun
 2023 20:54:46 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] x86: ia32.h: Remove unused code
Date:   Sun, 25 Jun 2023 20:54:11 +0800
Message-ID: <20230625125411.25840-1-yuehaibing@huawei.com>
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

Since commit 32974ad4907c ("[IA64] Remove COMPAT_IA32 support")
IA32_STACK_TOP and ia32_setup_arg_pages() is not used anymore.
And commit 675a0813609f ("x86: unify mmap_{32|64}.c") left behind
ia32_pick_mmap_layout() extern declaration.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/x86/include/asm/ia32.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/x86/include/asm/ia32.h b/arch/x86/include/asm/ia32.h
index fada857f0a1e..68f7eefe63d3 100644
--- a/arch/x86/include/asm/ia32.h
+++ b/arch/x86/include/asm/ia32.h
@@ -57,17 +57,6 @@ struct stat64 {
 	unsigned long long	st_ino;
 } __attribute__((packed));
 
-#define IA32_STACK_TOP IA32_PAGE_OFFSET
-
-#ifdef __KERNEL__
-struct linux_binprm;
-extern int ia32_setup_arg_pages(struct linux_binprm *bprm,
-				unsigned long stack_top, int exec_stack);
-struct mm_struct;
-extern void ia32_pick_mmap_layout(struct mm_struct *mm);
-
-#endif
-
 #endif /* CONFIG_IA32_EMULATION */
 
 #endif /* _ASM_X86_IA32_H */
-- 
2.34.1

