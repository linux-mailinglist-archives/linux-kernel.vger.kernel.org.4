Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283B75B6783
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 07:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiIMFx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 01:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiIMFxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 01:53:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8DB501AE;
        Mon, 12 Sep 2022 22:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663048403; x=1694584403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=K4JeNPhJg19W3KK06bkhJdspOGrwtvIGeS/Jba5cgqk=;
  b=edanJJn5TLmm3GkY2PI2fPso/bUohrxrJK8faicXdVzA84WA9bLBmnA2
   uAEcWVvgkGTXbo0VX1lPlZAYX7DvhiHapNZJHP0fxdNt15VyGKGhCPBzV
   /IcVy8sTUq0u7fbRuMr77n6f3IFPszD349vM69qMwn62V5n4ejMV/ZHha
   IPUYo8rqCkbJjhxj5lgsHcfL8BbSwaB+aSvMPP7dGAlYSMpPpaunMooAA
   Hf2ZWgq+cJFklP+0ClYFQEPOVdgNYaTcVb++XrIYoExEWl1XcaZDG+dYl
   a1xBJFoRfyws7XziCe09PBLJaW0mku8iUR2iCXZhlHEGK4c9MLchhrbAj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="361995446"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="361995446"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 22:53:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="646781565"
Received: from inlubt0246.iind.intel.com ([10.67.198.165])
  by orsmga008.jf.intel.com with ESMTP; 12 Sep 2022 22:53:20 -0700
From:   shruthi.sanil@intel.com
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@intel.com, srikanth.thokala@intel.com,
        mallikarjunappa.sangannavar@intel.com, shruthi.sanil@intel.com
Subject: [PATCH 1/2] usb: dwc3: pci: Update the macro names for USB PCIe device ID's for Alder Lake platforms
Date:   Tue, 13 Sep 2022 11:23:15 +0530
Message-Id: <20220913055316.23050-2-shruthi.sanil@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220913055316.23050-1-shruthi.sanil@intel.com>
References: <20220913055316.23050-1-shruthi.sanil@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shruthi Sanil <shruthi.sanil@intel.com>

The device ID 0x465e is defined for the USB3 device controller in the CPU
sub-system of Alder Lake N platform. Hence updating the macro name
accordingly.

The device ID 0x54ee is defined for the USB2 controller on the PCH
sub-system for Alder Lake N platform. Hence updating the macro name
accordingly.

The device ID's defined for Alder Lake P is shared between
Alder Lake P, Alder Lake PS and Alder Lake M.
Hence updating the macro name to ADL from ADLP to make it common
and keeping it aligned with the xHCI ID's naming convention.

As we have two device controllers on Alder Lake platforms
i.e. one on PCH sub-system and another on CPU sub-system(USB3),
appending _PCH for the USB2 device ID macro to differentiate
between the 2 ID's.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
---
 drivers/usb/dwc3/dwc3-pci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 4ee4ca09873a..7169d8865e17 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -40,9 +40,9 @@
 #define PCI_DEVICE_ID_INTEL_TGPLP		0xa0ee
 #define PCI_DEVICE_ID_INTEL_TGPH		0x43ee
 #define PCI_DEVICE_ID_INTEL_JSP			0x4dee
-#define PCI_DEVICE_ID_INTEL_ADL			0x465e
-#define PCI_DEVICE_ID_INTEL_ADLP		0x51ee
-#define PCI_DEVICE_ID_INTEL_ADLM		0x54ee
+#define PCI_DEVICE_ID_INTEL_ADL_PCH		0x51ee
+#define PCI_DEVICE_ID_INTEL_ADLN		0x465e
+#define PCI_DEVICE_ID_INTEL_ADLN_PCH		0x54ee
 #define PCI_DEVICE_ID_INTEL_ADLS		0x7ae1
 #define PCI_DEVICE_ID_INTEL_RPL			0x460e
 #define PCI_DEVICE_ID_INTEL_RPLS		0x7a61
@@ -445,13 +445,13 @@ static const struct pci_device_id dwc3_pci_id_table[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_JSP),
 	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADL),
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADL_PCH),
 	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADLP),
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADLN),
 	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADLM),
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADLN_PCH),
 	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADLS),
-- 
2.17.1

