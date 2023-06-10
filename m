Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12AF72AAE7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 12:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjFJK3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 06:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjFJK3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 06:29:21 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE4535B6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 03:29:20 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QdYwB5Lhwz18M15;
        Sat, 10 Jun 2023 18:24:26 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 10 Jun
 2023 18:29:18 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jeffxu@google.com>
CC:     <linux-kernel@vger.kernel.org>, <keescook@chromium.org>,
        <mcgrof@kernel.org>, <akpm@linux-foundation.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] kernel: pid_namespace: Remove unused set_memfd_noexec_scope()
Date:   Sat, 10 Jun 2023 18:28:58 +0800
Message-ID: <20230610102858.31488-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

This inline function is unused, remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/pid_sysctl.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/pid_sysctl.h b/kernel/pid_sysctl.h
index d67a4d45bb42..b26e027fc9cd 100644
--- a/kernel/pid_sysctl.h
+++ b/kernel/pid_sysctl.h
@@ -52,7 +52,6 @@ static inline void register_pid_ns_sysctl_table_vm(void)
 }
 #else
 static inline void initialize_memfd_noexec_scope(struct pid_namespace *ns) {}
-static inline void set_memfd_noexec_scope(struct pid_namespace *ns) {}
 static inline void register_pid_ns_sysctl_table_vm(void) {}
 #endif
 
-- 
2.34.1

