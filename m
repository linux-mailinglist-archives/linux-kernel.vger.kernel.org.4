Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123B565685D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 09:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiL0IVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 03:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiL0IV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 03:21:29 -0500
Received: from out30-8.freemail.mail.aliyun.com (out30-8.freemail.mail.aliyun.com [115.124.30.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0140D111F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 00:21:27 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VYCusZ4_1672129277;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VYCusZ4_1672129277)
          by smtp.aliyun-inc.com;
          Tue, 27 Dec 2022 16:21:25 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jgross@suse.com
Cc:     boris.ostrovsky@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] x86/xen: Remove the unused function p2m_top_mfn_init()
Date:   Tue, 27 Dec 2022 16:21:15 +0800
Message-Id: <20221227082115.59000-1-jiapeng.chong@linux.alibaba.com>
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

The function p2m_top_mfn_init is defined in the p2m.c file,
but not called elsewhere, so remove this unused function.

arch/x86/xen/p2m.c:137:24: warning: unused function 'p2m_index'.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3557
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/x86/xen/p2m.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/xen/p2m.c b/arch/x86/xen/p2m.c
index 58db86f7b384..9bdc3b656b2c 100644
--- a/arch/x86/xen/p2m.c
+++ b/arch/x86/xen/p2m.c
@@ -134,11 +134,6 @@ static inline unsigned p2m_mid_index(unsigned long pfn)
 	return (pfn / P2M_PER_PAGE) % P2M_MID_PER_PAGE;
 }
 
-static inline unsigned p2m_index(unsigned long pfn)
-{
-	return pfn % P2M_PER_PAGE;
-}
-
 static void p2m_top_mfn_init(unsigned long *top)
 {
 	unsigned i;
-- 
2.20.1.7.g153144c

