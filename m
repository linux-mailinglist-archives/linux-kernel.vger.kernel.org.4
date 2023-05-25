Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF77710C9F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbjEYM51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbjEYM5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:57:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA08E50;
        Thu, 25 May 2023 05:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685019427; x=1716555427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9nT6k4usc1ZdAfXJeFOMGjCgg2EwH9GxhdepY57V2w8=;
  b=zZr/rJag4FJJi0wxD74HkQhNXS7uPTShDHuieWUgZqJL7bLu9Z/fWzDa
   tzDw9zwNrndSU+Mh7A0Bg3HK1q+rbTbn8MZnWZPO80kpZYKf1kgo7Ym6c
   KpwOgZFoJXUddV9e0XmW5rm59ckQF40Fe82R/SCr7p4kV56Yc7Nf1coqd
   6hxC+Z7JQOVJZb2uRgAR4GBrfrxu4Nu0Zcn9vhqcaNcq5fY/hCdoi5mA/
   rB1pzV3ph5z2jwAyjlR9tLnD7gL2Jn7mTMHucCVs2fxdXBWUYfgGRoIJO
   GVilIgRE0nD9MKKwK7Mxi3aTtCEFIJ0Wi7ZDHOGFoJdQ7ffs4fG2zruEh
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="215446666"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 May 2023 05:57:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 25 May 2023 05:57:03 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 25 May 2023 05:56:57 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <sebastian.reichel@collabora.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH 2/5] ARM: dts: at91: sama7g5: keep only microchip,sam9x60-pit64b compatible for pit64b
Date:   Thu, 25 May 2023 15:55:59 +0300
Message-ID: <20230525125602.640855-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525125602.640855-1-claudiu.beznea@microchip.com>
References: <20230525125602.640855-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAM9X60 and SAMA7G5 PIT64Bs are 1 to 1 compatible. Thus, there is no
need for specific compatible string on SAMA7G5.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/sama7g5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index 886b6209a71e..500b00508621 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -610,7 +610,7 @@ eic: interrupt-controller@e1628000 {
 		};
 
 		pit64b0: timer@e1800000 {
-			compatible = "microchip,sama7g5-pit64b", "microchip,sam9x60-pit64b";
+			compatible = "microchip,sam9x60-pit64b";
 			reg = <0xe1800000 0x4000>;
 			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 70>, <&pmc PMC_TYPE_GCK 70>;
@@ -618,7 +618,7 @@ pit64b0: timer@e1800000 {
 		};
 
 		pit64b1: timer@e1804000 {
-			compatible = "microchip,sama7g5-pit64b", "microchip,sam9x60-pit64b";
+			compatible = "microchip,sam9x60-pit64b";
 			reg = <0xe1804000 0x4000>;
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 71>, <&pmc PMC_TYPE_GCK 71>;
-- 
2.34.1

