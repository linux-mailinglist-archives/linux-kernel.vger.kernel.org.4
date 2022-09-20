Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085F85BD9D8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 04:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiITCH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 22:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiITCHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 22:07:17 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA81857247
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 19:07:15 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MWlF86NJSz14Qdw;
        Tue, 20 Sep 2022 10:03:08 +0800 (CST)
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
Subject: [PATCH 2/4] x86/platform/intel-mid: remove orphan declarations from intel-mid.h
Date:   Tue, 20 Sep 2022 10:07:09 +0800
Message-ID: <20220920020711.789296-3-cuigaosheng1@huawei.com>
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

All uses of intel_scu_devices_create() and intel_scu_devices_destroy()
have been removed by commit 4590d98f5a4f ("sfi: Remove framework
for deprecated firmware")

So remove the orphan declarations and the unused inline functions.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 arch/x86/include/asm/intel-mid.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/x86/include/asm/intel-mid.h b/arch/x86/include/asm/intel-mid.h
index c201083b34f6..1020a761bb7e 100644
--- a/arch/x86/include/asm/intel-mid.h
+++ b/arch/x86/include/asm/intel-mid.h
@@ -20,18 +20,6 @@ extern void intel_mid_pwr_power_off(void);
 
 extern int intel_mid_pwr_get_lss_id(struct pci_dev *pdev);
 
-#ifdef CONFIG_X86_INTEL_MID
-
-extern void intel_scu_devices_create(void);
-extern void intel_scu_devices_destroy(void);
-
-#else /* !CONFIG_X86_INTEL_MID */
-
-static inline void intel_scu_devices_create(void) { }
-static inline void intel_scu_devices_destroy(void) { }
-
-#endif /* !CONFIG_X86_INTEL_MID */
-
 /* Bus Select SoC Fuse value */
 #define BSEL_SOC_FUSE_MASK		0x7
 /* FSB 133MHz */
-- 
2.25.1

