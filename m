Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7916387F4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiKYKxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKYKxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:53:39 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7855A4909F;
        Fri, 25 Nov 2022 02:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669373614; x=1700909614;
  h=from:to:cc:subject:date:message-id;
  bh=jVgMwvZ/rrpfHG40moJqsnfYA8TzsFsgMNZm046xI88=;
  b=FIsiBN+fjnFwIyQsZDS8OTpE2X2AvoARgxq7MKGYpjDVuweLmfw4aMiC
   0IoyTg7ogoW1aJjBSI5uDMKvFvKs++6xXT4VcyRwD9KGnQmTKIBKRy/bI
   JEDNl0rGNF8OdAviX8qbxdt525YsC303vlDrCjaOaXgmIc5w2k1lcIM5w
   pGN/fL0dRbhozHL+eEcyd9xyEJ9+Pq2UyUSJV/ORtSR1+/NubeWbEp5LS
   3hXsFkRx/XB4qVdFKckvVBItIJccBNs1d6LZ7amiM1kAW9xDtlI+2cfCy
   MQfryCLnRVpsGDld0+WidcHil9HSYkIHWEv2b2N8RiuqqBOm5VUC55/Pg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="316281281"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="316281281"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 02:53:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="644765604"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="644765604"
Received: from inlubt0246.iind.intel.com ([10.67.198.165])
  by fmsmga007.fm.intel.com with ESMTP; 25 Nov 2022 02:53:28 -0800
From:   shruthi.sanil@intel.com
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@intel.com, srikanth.thokala@intel.com,
        mallikarjunappa.sangannavar@intel.com, shruthi.sanil@intel.com
Subject: [PATCH] usb: dwc3: pci: Update PCIe device ID for USB3 controller on CPU sub-system for Raptor Lake
Date:   Fri, 25 Nov 2022 16:23:27 +0530
Message-Id: <20221125105327.27945-1-shruthi.sanil@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shruthi Sanil <shruthi.sanil@intel.com>

The device ID 0xa70e is defined for the USB3 device controller in the CPU
sub-system of Raptor Lake platform. Hence updating the ID accordingly.

Fixes: bad0d1d726ac ("usb: dwc3: pci: Add support for Intel Raptor Lake")
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
---
 drivers/usb/dwc3/dwc3-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index fb14511b1e10..89c9ab2b19f8 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -45,7 +45,7 @@
 #define PCI_DEVICE_ID_INTEL_ADLN		0x465e
 #define PCI_DEVICE_ID_INTEL_ADLN_PCH		0x54ee
 #define PCI_DEVICE_ID_INTEL_ADLS		0x7ae1
-#define PCI_DEVICE_ID_INTEL_RPL			0x460e
+#define PCI_DEVICE_ID_INTEL_RPL			0xa70e
 #define PCI_DEVICE_ID_INTEL_RPLS		0x7a61
 #define PCI_DEVICE_ID_INTEL_MTLP		0x7ec1
 #define PCI_DEVICE_ID_INTEL_MTL			0x7e7e

base-commit: 08ad43d554bacb9769c6a69d5f771f02f5ba411c
-- 
2.17.1

