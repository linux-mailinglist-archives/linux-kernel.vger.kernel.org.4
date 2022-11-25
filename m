Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A585D638ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiKYNHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiKYNGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:06:54 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06462A253;
        Fri, 25 Nov 2022 05:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669381613; x=1700917613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FYTVirkF2LL2UHadcUsKtXjlF5i8q7bfY4swItL04gI=;
  b=qYKsn+pQBXzCIBS+w5lnJ2rwBUIu4r3nD50FCVMfQsxUGBGeAxG7HiMF
   EzFEf3qdq8L5HQcuDLbCzBxtFbVDPovvvmD/ptaoNEaoUMh64LWGU4id8
   s1C7su3qGoGj2ft2hxt7TYJ1J2r+ES0ddaMwb1LktgekH3bDHJrTSO8a9
   F1GBTLK75do+SMHU9H65s35VjI8uxx0p5K7O9DRuaXg5/sf7aQQY/bIP8
   1biFTOAzg1PxqSt/LhO+eD/k7B6N+5e/vwBvuEOkQXt/0bwkPvcD871TS
   hw4qY43uHUAkCzlGiBqMD9hdWCdlEpHQEfgOmz1TxOc+NhUAzA7wJf8I2
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="125103766"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2022 06:06:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 25 Nov 2022 06:06:52 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 25 Nov 2022 06:06:50 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <claudiu.beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v2 2/2] ARM: configs: multi_v7: switch to new MICROCHIP_ISC driver
Date:   Fri, 25 Nov 2022 15:06:46 +0200
Message-ID: <20221125130646.454084-2-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221125130646.454084-1-eugen.hristev@microchip.com>
References: <20221125130646.454084-1-eugen.hristev@microchip.com>
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

 arch/arm/configs/multi_v7_defconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index b61b2e3d116b..d1686bc40e5d 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -663,11 +663,11 @@ CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_ASPEED=m
-CONFIG_VIDEO_ATMEL_ISC=m
-CONFIG_VIDEO_ATMEL_XISC=m
 CONFIG_VIDEO_ATMEL_ISI=m
-CONFIG_VIDEO_MICROCHIP_CSI2DC=m
 CONFIG_VIDEO_MMP_CAMERA=m
+CONFIG_VIDEO_MICROCHIP_ISC=m
+CONFIG_VIDEO_MICROCHIP_XISC=m
+CONFIG_VIDEO_MICROCHIP_CSI2DC=m
 CONFIG_VIDEO_TEGRA_VDE=m
 CONFIG_VIDEO_RENESAS_CEU=m
 CONFIG_VIDEO_RCAR_VIN=m
-- 
2.25.1

