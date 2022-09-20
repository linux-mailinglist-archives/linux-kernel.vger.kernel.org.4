Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A935BD9D9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 04:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiITCHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 22:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiITCHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 22:07:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421EA57234
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 19:07:17 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MWlDV5Bw8zMn50;
        Tue, 20 Sep 2022 10:02:34 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 10:07:14 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <peterz@infradead.org>, <ndesaulniers@google.com>,
        <jpoimboe@kernel.org>, <cuigaosheng1@huawei.com>,
        <lukas.bulwahn@gmail.com>, <akpm@linux-foundation.org>,
        <pbonzini@redhat.com>, <anshuman.khandual@arm.com>,
        <namit@vmware.com>, <seanjc@google.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] x86/extable: remove orphan fixup_bug() declaration
Date:   Tue, 20 Sep 2022 10:07:11 +0800
Message-ID: <20220920020711.789296-5-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920020711.789296-1-cuigaosheng1@huawei.com>
References: <20220920020711.789296-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fixup_bug() has been removed by
commit 15a416e8aaa7 ("x86/entry: Treat BUG/WARN as NMI-like
entries"), so remove the orphan declaration.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 arch/x86/include/asm/extable.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/extable.h b/arch/x86/include/asm/extable.h
index eeed395c3177..a0e0c6b50155 100644
--- a/arch/x86/include/asm/extable.h
+++ b/arch/x86/include/asm/extable.h
@@ -37,7 +37,6 @@ struct pt_regs;
 
 extern int fixup_exception(struct pt_regs *regs, int trapnr,
 			   unsigned long error_code, unsigned long fault_addr);
-extern int fixup_bug(struct pt_regs *regs, int trapnr);
 extern int ex_get_fixup_type(unsigned long ip);
 extern void early_fixup_exception(struct pt_regs *regs, int trapnr);
 
-- 
2.25.1

