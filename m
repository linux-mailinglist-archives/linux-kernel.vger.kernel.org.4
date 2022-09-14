Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6987F5B86F3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiINLE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiINLEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:04:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C46810FE0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 04:04:40 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MSHS8555VzlVrY;
        Wed, 14 Sep 2022 19:00:40 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 14 Sep 2022 19:04:38 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <mhiramat@kernel.org>, <peterz@infradead.org>,
        <ast@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] x86/ftrace: remove unused modifying_ftrace_code declaration
Date:   Wed, 14 Sep 2022 19:04:36 +0800
Message-ID: <20220914110437.1436353-2-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914110437.1436353-1-cuigaosheng1@huawei.com>
References: <20220914110437.1436353-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All uses of modifying_ftrace_code have been removed by
commit 768ae4406a5c ("x86/ftrace: Use text_poke()"),
so remove the declaration, too.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 arch/x86/include/asm/ftrace.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index b5ef474be858..908d99b127d3 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -23,7 +23,6 @@
 #define HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 
 #ifndef __ASSEMBLY__
-extern atomic_t modifying_ftrace_code;
 extern void __fentry__(void);
 
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
-- 
2.25.1

