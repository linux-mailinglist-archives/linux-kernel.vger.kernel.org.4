Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47926BE99C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjCQMt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjCQMtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:49:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1915CC14
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:49:48 -0700 (PDT)
Received: from dggpeml500004.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PdP5d54JhznXq1;
        Fri, 17 Mar 2023 20:46:45 +0800 (CST)
Received: from DESKTOP-EJM108K.china.huawei.com (10.174.186.25) by
 dggpeml500004.china.huawei.com (7.185.36.140) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 20:49:46 +0800
From:   Dongxu Sun <sundongxu3@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        Dongxu Sun <sundongxu3@huawei.com>
Subject: [PATCH 3/4] arm64/signal: Add tpidr2/za/zt sigframe size in comment
Date:   Fri, 17 Mar 2023 20:49:14 +0800
Message-ID: <20230317124915.1263-4-sundongxu3@huawei.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20230317124915.1263-1-sundongxu3@huawei.com>
References: <20230317124915.1263-1-sundongxu3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.186.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500004.china.huawei.com (7.185.36.140)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the comments of sigcontext.__reserved[], since we already
support SME/SME2.

Signed-off-by: Dongxu Sun <sundongxu3@huawei.com>
---
 arch/arm64/include/uapi/asm/sigcontext.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index 656a10ea6c67..d85e3079474d 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
@@ -45,10 +45,13 @@ struct sigcontext {
  *	0x210		fpsimd_context
  *	 0x10		esr_context
  *	0x8a0		sve_context (vl <= 64) (optional)
+ *	 0x10		tpidr2_context (optional)
+ *	 0x10		za_context (optional)
+ *	 0x10		zt_context (optional)
  *	 0x20		extra_context (optional)
  *	 0x10		terminator (null _aarch64_ctx)
  *
- *	0x510		(reserved for future allocation)
+ *	0x4e0		(reserved for future allocation)
  *
  * New records that can exceed this space need to be opt-in for userspace, so
  * that an expanded signal frame is not generated unexpectedly.  The mechanism
-- 
2.33.0

