Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AA97144CC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjE2G2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjE2G2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:28:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DB8E4F;
        Sun, 28 May 2023 23:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685341658; x=1716877658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9nT6k4usc1ZdAfXJeFOMGjCgg2EwH9GxhdepY57V2w8=;
  b=JHpJkQTZ0kcqUm9uh54qS5Qovv+m5vCnyNUYH6yymCKgBXlwLzQe09si
   daov/5yo28/3YsgvhmkBfag3LXWDPxrIxI3oWw6Qp9rAVkeo/MZnieAYh
   TkP3bm/z59riQahmjI9k8PiU+ITN9yBwcWjw6okSCeMnDSq9uREq8CE9+
   CcYcYZIT3H4eOxcOobzldI0OadN6vFWloRwyOHDRJ81Xyza5BLYyAKJt2
   nAXx+X0g4IfAFX2oFAqPoqLLO9VtY8GSyEHUR3CONtA1mOg/8n0YqfIZN
   6urombmlvdNcEIYNivX5WKmJaEGFyIeFArLymrmu1JgZ78Nb/eOeh+PNh
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="215861656"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 May 2023 23:26:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 28 May 2023 23:26:27 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Sun, 28 May 2023 23:26:22 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH v2 1/4] ARM: dts: at91: sama7g5: keep only microchip,sam9x60-pit64b compatible for pit64b
Date:   Mon, 29 May 2023 09:26:01 +0300
Message-ID: <20230529062604.1498052-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529062604.1498052-1-claudiu.beznea@microchip.com>
References: <20230529062604.1498052-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

