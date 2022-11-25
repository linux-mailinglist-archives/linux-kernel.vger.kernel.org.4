Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1831638AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiKYNHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKYNHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:07:04 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C2B2B247;
        Fri, 25 Nov 2022 05:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669381622; x=1700917622;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jI7i+o6FKsmd1btMNTVQYWQ8viJcBNNVOTibOWoQzYE=;
  b=dwv1UdVpNRiWrmtWCDgBTZTxLm3XeslduRBD5pHtak33AoCAUX9X17P/
   eQ+LeAx0VvxSCXOItzZgVQnVPQzkYzIVbWuvIpztYXLMIqQxKhEvxu7QO
   CcjIuvrCK9t9paplngN21lBPjrj9kDFyssbqf29Sgs+hwKib6Mvx+oWad
   wN558545ut/zj4gLEhLKz2QsWv8hz6h2B9T3Htp4RRYg5g5HLCohSswV2
   kI0yXAjhGWG/l28Ni0sjWiXEBnVgrGQSnTN+as0+ZUpqudbqQ9OZ8ai7m
   p0KCDrrmP/hOHj2Vct6P+C3HutI/hxeEmJSjeRYbMLeEoUtnbN6cOdMmc
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="185182702"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2022 06:06:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 25 Nov 2022 06:06:50 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 25 Nov 2022 06:06:48 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <claudiu.beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v2 1/2] ARM: configs: sama5/7: switch to new MICROCHIP_ISC driver
Date:   Fri, 25 Nov 2022 15:06:45 +0200
Message-ID: <20221125130646.454084-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ATMEL_ISC and ATMEL_XISC have been deprecated and moved to staging.
Use the new MICROCHIP_ISC/MICROCHIP_XISC symbols which are the
replacement drivers.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
changes in v2:
- split the multi v7 into separate patch

 arch/arm/configs/sama5_defconfig | 2 +-
 arch/arm/configs/sama7_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 877bbe7b777e..f89fd4e0d10a 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -150,8 +150,8 @@ CONFIG_MEDIA_PLATFORM_SUPPORT=y
 CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
-CONFIG_VIDEO_ATMEL_ISC=y
 CONFIG_VIDEO_ATMEL_ISI=y
+CONFIG_VIDEO_MICROCHIP_ISC=y
 CONFIG_VIDEO_MT9V032=m
 CONFIG_VIDEO_OV2640=m
 CONFIG_VIDEO_OV5640=m
diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index 8f28c9d443f0..cc42cea77f38 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -140,7 +140,7 @@ CONFIG_MEDIA_SUPPORT_FILTER=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_MEDIA_PLATFORM_SUPPORT=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
-CONFIG_VIDEO_ATMEL_XISC=y
+CONFIG_VIDEO_MICROCHIP_XISC=y
 CONFIG_VIDEO_MICROCHIP_CSI2DC=y
 CONFIG_VIDEO_IMX219=m
 CONFIG_VIDEO_IMX274=m
-- 
2.25.1

