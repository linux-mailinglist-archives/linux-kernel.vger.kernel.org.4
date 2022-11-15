Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA758629EE9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbiKOQXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiKOQXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:23:30 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2924B108E;
        Tue, 15 Nov 2022 08:23:29 -0800 (PST)
Received: from canpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NBWbb6wdvzqSMt;
        Wed, 16 Nov 2022 00:19:39 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 canpemm500001.china.huawei.com (7.192.104.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 00:23:26 +0800
From:   Xie XiuQi <xiexiuqi@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <james.morse@arm.com>, <rafael@kernel.org>, <tony.luck@intel.com>,
        <robert.moore@intel.com>, <bp@alien8.de>, <devel@acpica.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tanxiaofei@huawei.com>, <wangxiongfeng2@huawei.com>,
        <lvying6@huawei.com>
Subject: [PATCH v2 1/2] ACPI: APEI: include missing acpi/apei.h
Date:   Wed, 16 Nov 2022 00:41:45 +0800
Message-ID: <20221115164146.106005-2-xiexiuqi@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221115164146.106005-1-xiexiuqi@huawei.com>
References: <20221115164146.106005-1-xiexiuqi@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500001.china.huawei.com (7.192.104.163)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot reported this warning with 'make W=1':

drivers/acpi/apei/apei-base.c:763:12: warning: no previous prototype for 'arch_apei_enable_cmcff' [-Wmissing-prototypes]
  763 | int __weak arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr,
      |            ^~~~~~~~~~~~~~~~~~~~~~
drivers/acpi/apei/apei-base.c:770:13: warning: no previous prototype for 'arch_apei_report_mem_error' [-Wmissing-prototypes]
  770 | void __weak arch_apei_report_mem_error(int sev,
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~

Include missing acpi/apei.h to avoid this warning.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 9dae3d0d9e64 ("apei, mce: Factor out APEI architecture specific MCE calls")
Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 drivers/acpi/apei/apei-base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index f372cf872125..3387372bb911 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -28,6 +28,7 @@
 #include <linux/rculist.h>
 #include <linux/interrupt.h>
 #include <linux/debugfs.h>
+#include <acpi/apei.h>
 #include <asm/unaligned.h>
 
 #include "apei-internal.h"
-- 
2.20.1

