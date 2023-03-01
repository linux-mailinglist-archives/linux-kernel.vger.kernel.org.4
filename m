Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876746A6A86
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 11:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjCAKJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 05:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjCAKJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 05:09:36 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FAA196B3;
        Wed,  1 Mar 2023 02:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677665372; x=1709201372;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L21mfnwG2tG1rkVD0UVEhu+U7/OYan2vtpwho9OQe+k=;
  b=bwbpNxDtBXrb9qxsNI91JHsQ1sCCqKKpymZAfToxGFJnjfhlLjIpcfzY
   Acj5Fu/N1+Eb/allR1o/d9e/qympgc6rc1HCDJq9lO100AVZPKzYuxpvD
   z4V9NEmwhUznM1/KBOnp+m8N8+pMOD8xXm/s+ECV+HBojn90q/oFuF4JS
   cx0N+U7pO9S7atYrcB2JTEmMrts87PRsCr/hkfyIAixbyoghQ3cmkNeLD
   fKuUwHM1l1JTr0dg/JKb74XzupyB/IR/NfihtIl2ZPWC21wq/QGS14vcx
   FroZGSL1M7y2TGhlGbIYYlGNkXpkXhYDT5PBOGEbjCM/qf3LJF0EQ+d42
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,224,1673938800"; 
   d="scan'208";a="202983394"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2023 03:09:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Mar 2023 03:09:17 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Wed, 1 Mar 2023 03:09:14 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <jirislaby@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <ilpo.jarvinen@linux.intel.com>, <deller@gmx.de>,
        <geert+renesas@glider.be>, <phil.edworthy@renesas.com>,
        <matthew.gerlach@linux.intel.com>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH tty-next] serial: 8250_pci1xxxx: Disable SERIAL_8250_PCI1XXXX config by default
Date:   Wed, 1 Mar 2023 15:39:30 +0530
Message-ID: <20230301100930.3519883-1-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable SERIAL_8250_PCI1XXXX config by default

Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
---
 drivers/tty/serial/8250/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 978dc196c29b..cbf11147dc89 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -299,7 +299,6 @@ config SERIAL_8250_PCI1XXXX
 	tristate "Microchip 8250 based serial port"
 	depends on SERIAL_8250 && PCI
 	select SERIAL_8250_PCILIB
-	default SERIAL_8250
 	help
 	 Select this option if you have a setup with Microchip PCIe
 	 Switch with serial port enabled and wish to enable 8250
-- 
2.25.1

