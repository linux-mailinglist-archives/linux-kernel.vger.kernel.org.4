Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98105B6C28
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiIMLEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiIMLEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:04:05 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49BC5E307
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 04:04:00 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MRgV608sczmV9h;
        Tue, 13 Sep 2022 19:00:13 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 13 Sep 2022 19:03:57 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <robinmholt@gmail.com>, <steve.wahl@hpe.com>,
        <mike.travis@hpe.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <tony.luck@intel.com>, <hch@lst.de>,
        <cuigaosheng1@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drivers/misc/sgi-xp: Remove orphan declarations from drivers/misc/sgi-xp/xp.h
Date:   Tue, 13 Sep 2022 19:03:56 +0800
Message-ID: <20220913110356.764711-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Remove the following orphan declarations from drivers/misc/sgi-xp/xp.h:
1. xp_nofault_PIOR_target
2. xp_error_PIOR
3. xp_nofault_PIOR

They have been removed since commit 9726bfcdb977 ("misc/sgi-xp:
remove SGI SN2 support"), so remove them.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
v2:
- Remove unused xp_nofault_PIOR declaration.
- Format the commit messages for the patch, thanks!
 drivers/misc/sgi-xp/xp.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/misc/sgi-xp/xp.h b/drivers/misc/sgi-xp/xp.h
index 9f9af77f8d2e..f1336f43d3bd 100644
--- a/drivers/misc/sgi-xp/xp.h
+++ b/drivers/misc/sgi-xp/xp.h
@@ -334,10 +334,6 @@ extern int (*xp_cpu_to_nasid) (int);
 extern enum xp_retval (*xp_expand_memprotect) (unsigned long, unsigned long);
 extern enum xp_retval (*xp_restrict_memprotect) (unsigned long, unsigned long);
 
-extern u64 xp_nofault_PIOR_target;
-extern int xp_nofault_PIOR(void *);
-extern int xp_error_PIOR(void);
-
 extern struct device *xp;
 extern enum xp_retval xp_init_uv(void);
 extern void xp_exit_uv(void);
-- 
2.25.1

