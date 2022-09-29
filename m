Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3F65EF295
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbiI2JrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbiI2Jqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:46:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DF1D4A8E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:45:28 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MdSyq0PLPzHtnC;
        Thu, 29 Sep 2022 17:40:35 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 17:45:22 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 17:45:21 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>
CC:     <rostedt@goodmis.org>, <mingo@redhat.com>, <Julia.Lawall@inria.fr>,
        <akpm@linux-foundation.org>, <andreyknvl@gmail.com>,
        <elver@google.com>, <wangkefeng.wang@huawei.com>,
        <zhouchengming@bytedance.com>, <ardb@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH 2/3] arm64: module: Remove unused plt_entry_is_initialized()
Date:   Thu, 29 Sep 2022 17:41:33 +0800
Message-ID: <20220929094134.99512-3-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929094134.99512-1-lihuafei1@huawei.com>
References: <20220929094134.99512-1-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit f1a54ae9af0d ("arm64: module/ftrace: intialize PLT at load
time"), plt_entry_is_initialized() is unused anymore , so remove it.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 arch/arm64/include/asm/module.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index 28514b989a0b..8096d30c5e39 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -59,9 +59,4 @@ static inline bool is_forbidden_offset_for_adrp(void *place)
 
 struct plt_entry get_plt_entry(u64 dst, void *pc);
 
-static inline bool plt_entry_is_initialized(const struct plt_entry *e)
-{
-	return e->adrp || e->add || e->br;
-}
-
 #endif /* __ASM_MODULE_H */
-- 
2.17.1

