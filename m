Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6835646EDD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiLHLr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLHLrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:47:25 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C035CD34;
        Thu,  8 Dec 2022 03:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670500044; x=1702036044;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MVTL6UUvKcTMVCYpcQSuarT5kz7nFvxwqkKHy/9pKRI=;
  b=s3w5JTnmDfhG0fCQYp/FygzJ6nbkqKQq9yj0DUk+zrnJIZHF19ZS8pyH
   kU+l6OQ/Q7mCRUJGEiVMcVrPlARU7bYV9SDkXh4gER4IQemvs5mGRhzqd
   FV/czQ4qIEiWPina9q6Dba3y+Mhy4Qf0s8wyqMXWwgNtmOeDel2YmdC6O
   DmzkSwDV0qYIyahvJdOGRD9Voo5I56v41mHUlvfY7L5s7tVFrWL5cErGh
   4yGy2srAfsYQ8GTRsHAHrTx39P0VxExYicelA5YtML76JNy2jXpGPFq1b
   8LNCxVa19gIeFO0VWF8No/J44SDqPk7JmgxLR9K9xj3bowb9CsGt9esJX
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="127112214"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Dec 2022 04:47:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Dec 2022 04:47:22 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 8 Dec 2022 04:47:20 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <sandeepsheriker.mallikarjun@microchip.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] ARM: dts: at91: sam9x60: fix the ddr clock for sam9x60
Date:   Thu, 8 Dec 2022 13:52:41 +0200
Message-ID: <20221208115241.36312-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
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

The 2nd DDR clock for sam9x60 DDR controller is peripheral clock with
id 49.

Fixes: 1e5f532c2737 ("ARM: dts: at91: sam9x60: add device tree for soc and board")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/sam9x60.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
index 8f5477e307dd..37a5d96aaf64 100644
--- a/arch/arm/boot/dts/sam9x60.dtsi
+++ b/arch/arm/boot/dts/sam9x60.dtsi
@@ -564,7 +564,7 @@ pmecc: ecc-engine@ffffe000 {
 			mpddrc: mpddrc@ffffe800 {
 				compatible = "microchip,sam9x60-ddramc", "atmel,sama5d3-ddramc";
 				reg = <0xffffe800 0x200>;
-				clocks = <&pmc PMC_TYPE_SYSTEM 2>, <&pmc PMC_TYPE_CORE PMC_MCK>;
+				clocks = <&pmc PMC_TYPE_SYSTEM 2>, <&pmc PMC_TYPE_PERIPHERAL 49>;
 				clock-names = "ddrck", "mpddr";
 			};
 
-- 
2.34.1

