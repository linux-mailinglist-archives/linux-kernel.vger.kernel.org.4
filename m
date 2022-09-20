Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88C05BD9DB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 04:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiITCHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 22:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiITCHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 22:07:18 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D1757254
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 19:07:16 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MWlF94Gtmz14Qjc;
        Tue, 20 Sep 2022 10:03:09 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 10:07:13 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <peterz@infradead.org>, <ndesaulniers@google.com>,
        <jpoimboe@kernel.org>, <cuigaosheng1@huawei.com>,
        <lukas.bulwahn@gmail.com>, <akpm@linux-foundation.org>,
        <pbonzini@redhat.com>, <anshuman.khandual@arm.com>,
        <namit@vmware.com>, <seanjc@google.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] x86: remove orphan ia32_setup_arg_pages() declaration
Date:   Tue, 20 Sep 2022 10:07:10 +0800
Message-ID: <20220920020711.789296-4-cuigaosheng1@huawei.com>
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

The ia32_setup_arg_pages() has been removed by
commit b6a2fea39318 ("mm: variable length argument support"),
so remove the orphan declaration.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 arch/x86/include/asm/ia32.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/ia32.h b/arch/x86/include/asm/ia32.h
index fada857f0a1e..32e51ca35c0a 100644
--- a/arch/x86/include/asm/ia32.h
+++ b/arch/x86/include/asm/ia32.h
@@ -61,8 +61,6 @@ struct stat64 {
 
 #ifdef __KERNEL__
 struct linux_binprm;
-extern int ia32_setup_arg_pages(struct linux_binprm *bprm,
-				unsigned long stack_top, int exec_stack);
 struct mm_struct;
 extern void ia32_pick_mmap_layout(struct mm_struct *mm);
 
-- 
2.25.1

