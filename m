Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A91642C29
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiLEPnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbiLEPnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:43:32 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CC7BF54;
        Mon,  5 Dec 2022 07:43:30 -0800 (PST)
Received: from canpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NQnmb48l0zJnQc;
        Mon,  5 Dec 2022 23:39:59 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 canpemm500001.china.huawei.com (7.192.104.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 23:43:27 +0800
From:   Xie XiuQi <xiexiuqi@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <james.morse@arm.com>, <rafael@kernel.org>, <tony.luck@intel.com>,
        <robert.moore@intel.com>, <bp@alien8.de>, <devel@acpica.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tanxiaofei@huawei.com>, <wangxiongfeng2@huawei.com>,
        <lvying6@huawei.com>, <naoya.horiguchi@nec.com>,
        <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 1/4] ACPI: APEI: include missing acpi/apei.h
Date:   Tue, 6 Dec 2022 00:00:40 +0800
Message-ID: <20221205160043.57465-2-xiexiuqi@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221205160043.57465-1-xiexiuqi@huawei.com>
References: <20221205160043.57465-1-xiexiuqi@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
index 9b52482b4ed5..02196a312dc5 100644
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

