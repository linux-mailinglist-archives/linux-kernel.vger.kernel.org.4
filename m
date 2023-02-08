Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EC368E619
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 03:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjBHCcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 21:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjBHCcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 21:32:09 -0500
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C536A199EF;
        Tue,  7 Feb 2023 18:32:01 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vb9eAsn_1675823518;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vb9eAsn_1675823518)
          by smtp.aliyun-inc.com;
          Wed, 08 Feb 2023 10:31:59 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     rafael@kernel.org
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ACPI: CPPC: Fix some kernel-doc comments
Date:   Wed,  8 Feb 2023 10:31:58 +0800
Message-Id: <20230208023158.69934-1-yang.lee@linux.alibaba.com>
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

Add the description of @pcc_ss_id in pcc_data_alloc().
Add the description of @cpu_num in cppc_get_transition_latency().

clear the below warnings:
drivers/acpi/cppc_acpi.c:607: warning: Function parameter or member 'pcc_ss_id' not described in 'pcc_data_alloc'
drivers/acpi/cppc_acpi.c:1616: warning: Function parameter or member 'cpu_num' not described in 'cppc_get_transition_latency'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3983
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/acpi/cppc_acpi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 02d83c807271..bc7b304944a7 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -596,6 +596,9 @@ bool __weak cpc_supported_by_cpu(void)
 /**
  * pcc_data_alloc() - Allocate the pcc_data memory for pcc subspace
  *
+ * @pcc_ss_id: The PCC Subspace index as parsed in the PCC client
+ *	       ACPI package.
+ *
  * Check and allocate the cppc_pcc_data memory.
  * In some processor configurations it is possible that same subspace
  * is shared between multiple CPUs. This is seen especially in CPUs
@@ -1604,6 +1607,8 @@ EXPORT_SYMBOL_GPL(cppc_set_perf);
 /**
  * cppc_get_transition_latency - returns frequency transition latency in ns
  *
+ * @cpu_num: the number of the specified cpu for per_cpu()
+ *
  * ACPI CPPC does not explicitly specify how a platform can specify the
  * transition latency for performance change requests. The closest we have
  * is the timing information from the PCCT tables which provides the info
-- 
2.20.1.7.g153144c

