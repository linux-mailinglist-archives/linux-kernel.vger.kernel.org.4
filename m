Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052276D0694
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjC3N0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjC3N0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:26:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4EAAF19
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680182783; x=1711718783;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HCAX12DiSGjlw/Lpg8A2iCso2olT/s9YNl1PAFJQaqk=;
  b=ac/0yihVS3wDbQTiThVOUJxf/8BzOZcXMwJevCNoDQBb/DRF7C+1meiQ
   knO2HUNYCEZcxlog0GfMNU659yjhtGkrk2UO/+B3EYPoVveX3NV7CJUz1
   oAvz52bdE48BGaMso6jKbhDCg6aPWKxKlpGOmChZaWlmVn93MIM6RXKX4
   KY09DawL998fyld7mzd/gjxgztAzedEQF+m8eIPmcEuO/A3+qNwkgdh90
   8AncLp5GjUm8oKtiokkAYjRyPNTHXHKrGaOUWrh4dOy1jhNZ7tdlJXnOZ
   dOGp8WZcuLKXvWx5NrgCbCBI9b2HjKKYVZDAn+x/1zjZpMvBBlPvSWrKC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="368945792"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="368945792"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 06:26:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="808643921"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="808643921"
Received: from unknown (HELO mylly.fi.intel.com.) ([10.237.72.51])
  by orsmga004.jf.intel.com with ESMTP; 30 Mar 2023 06:26:21 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] mfd: intel-lpss: Add Intel Meteor Lake PCH-S LPSS PCI IDs
Date:   Thu, 30 Mar 2023 16:26:18 +0300
Message-Id: <20230330132618.4108665-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Intel Meteor Lake PCH-S also called as Meteor Point-S LPSS PCI IDs.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/mfd/intel-lpss-pci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index dde31c50a632..699f44ffff0e 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -447,6 +447,21 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x7e79), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7e7a), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7e7b), (kernel_ulong_t)&bxt_i2c_info },
+	/* MTP-S */
+	{ PCI_VDEVICE(INTEL, 0x7f28), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7f29), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7f2a), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x7f2b), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x7f4c), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7f4d), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7f4e), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7f4f), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7f5c), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7f5d), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7f5e), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x7f5f), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x7f7a), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7f7b), (kernel_ulong_t)&bxt_i2c_info },
 	/* LKF */
 	{ PCI_VDEVICE(INTEL, 0x98a8), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x98a9), (kernel_ulong_t)&bxt_uart_info },
-- 
2.39.2

