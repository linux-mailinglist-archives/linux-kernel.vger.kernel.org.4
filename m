Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AC8692EA8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 07:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBKGdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 01:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBKGdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 01:33:09 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6256A7BFD6;
        Fri, 10 Feb 2023 22:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676097181; x=1707633181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7i8zMF0K839+UX0WmEQKEd/eIgzkZJvjyjtd/qQGye0=;
  b=YMVX+3+r3JqtYDns8ewpeLR5rTAMcpjpSkqN/JPIZXkI4hm+Sqwr8TY3
   cFbaZ57DCVSvztuHxFshFodaHwua89vyav9oYcGZwqGJ4tXXMexzxQOTS
   Ha3nREwTE3wrGX5MnBBaSoqdcJ/txAdJE9z13JRfyTFPHQW2fQI0s4frc
   CUXCrV8griac5c49y0oYiTnelnU9UsMlI5g/voqPqOZbZfz2g8kT9wbtL
   KPIlSpIT1ZTufYeEVEpQHQz6ey881/gkF45bDkjFuOknk9AVB67WX/1Mi
   F2cVz7KPzk7zSl2zdDElGh5+PWk22+hmD1eM+4s6+xXL9PHshhKkPzd31
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="310223195"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="310223195"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 22:33:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="997171761"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="997171761"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga005.fm.intel.com with ESMTP; 10 Feb 2023 22:33:00 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 01/12] platform/x86: ISST: Fix kernel documentation warnings
Date:   Fri, 10 Feb 2023 22:32:46 -0800
Message-Id: <20230211063257.311746-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230211063257.311746-1-srinivas.pandruvada@linux.intel.com>
References: <20230211063257.311746-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning displayed for "make W=1" for kernel documentation.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 3 ++-
 drivers/platform/x86/intel/speed_select_if/isst_if_common.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index a7e02b24a87a..63d49fe17a16 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -112,6 +112,7 @@ static void isst_delete_hash(void)
  * isst_store_cmd() - Store command to a hash table
  * @cmd: Mailbox command.
  * @sub_cmd: Mailbox sub-command or MSR id.
+ * @cpu: Target CPU for the command
  * @mbox_cmd_type: Mailbox or MSR command.
  * @param: Mailbox parameter.
  * @data: Mailbox request data or MSR data.
@@ -363,7 +364,7 @@ static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn
 /**
  * isst_if_get_pci_dev() - Get the PCI device instance for a CPU
  * @cpu: Logical CPU number.
- * @bus_number: The bus number assigned by the hardware.
+ * @bus_no: The bus number assigned by the hardware.
  * @dev: The device number assigned by the hardware.
  * @fn: The function number assigned by the hardware.
  *
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.h b/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
index fdecdae248d7..35ff506b402e 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
@@ -40,6 +40,7 @@
  * @offset:	Offset to the first valid member in command structure.
  *		This will be the offset of the start of the command
  *		after command count field
+ * @owner:	Registered module owner
  * @cmd_callback: Callback function to handle IOCTL. The callback has the
  *		command pointer with data for command. There is a pointer
  *		called write_only, which when set, will not copy the
-- 
2.39.1

