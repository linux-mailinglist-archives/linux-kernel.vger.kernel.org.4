Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40D360CABB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiJYLRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiJYLRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:17:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA991BEA5;
        Tue, 25 Oct 2022 04:17:16 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MxTmr3yf9zVj3L;
        Tue, 25 Oct 2022 19:12:28 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 19:17:14 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 19:17:13 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <robert.moore@intel.com>, <rafael.j.wysocki@intel.com>,
        <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <devel@acpica.org>,
        <linux-kernel@vger.kernel.org>, <wangxiongfeng2@huawei.com>,
        <liwei391@huawei.com>
Subject: [PATCH] ACPICA: add missing macro ACPI_FUNCTION_TRACE() for ns_repair_HID()
Date:   Tue, 25 Oct 2022 19:36:43 +0800
Message-ID: <20221025113643.79743-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit add function tracing macros for the namespace repair
mechanism.

  commit 0766efdf9a9d24eaefe260c787f49af225018b16
  ACPICA: Add function trace macros to improve debugging

But it missed the trace macro for the entry of ns_repair_HID(). Let's
add it.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/acpi/acpica/nsrepair2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index dd533c887e3a..957d7eb4861f 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -499,7 +499,7 @@ acpi_ns_repair_HID(struct acpi_evaluate_info *info,
 	char *source;
 	char *dest;
 
-	ACPI_FUNCTION_NAME(ns_repair_HID);
+	ACPI_FUNCTION_TRACE(ns_repair_HID);
 
 	/* We only care about string _HID objects (not integers) */
 
-- 
2.20.1

