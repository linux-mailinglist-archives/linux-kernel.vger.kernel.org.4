Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C556070BEB3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjEVMse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjEVMsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:48:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BF7E6;
        Mon, 22 May 2023 05:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684759701; x=1716295701;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qkLMBK+x4QFZAz3Bh2xDdnf5Zd/BW2SuqHUWHFPHgkk=;
  b=IoQ8wyBqHnwRUC4Vh3NDtCcGLltkINQ/WRHPRZVwLOA+okKU1la5gpK8
   ouTFaU+lIG70tP24Vkky8TLnNLI54SXlr+kl68q19N2GF4gJSO46yYmy2
   kAwmAB25tH4df1XewOrHrNCbcBlwv6SNkZMhoPHNvYJ/vtilM06ZI/BXi
   UL6zrjuT6uscHgn1l72KD4UqCfqahzQwFAJW4M5phjUAKzgoaZKqH3KOX
   eKcsBjiemr92Gjl5Et3cY3GZHbpXubeMNWMJl4N3xqAFid5zHu8d4W4WJ
   AcL44gJpqOL3Vid857t2Bm+hux66mNX+tw7OiH6d11GCn/o/QnpLd4LDb
   w==;
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="226397671"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 05:48:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 05:48:21 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 22 May 2023 05:48:18 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama5d2: remove extra line
Date:   Mon, 22 May 2023 15:48:12 +0300
Message-ID: <20230522124812.107227-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra line from the definition of slow clock controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 256d29d66830..795a02b2e283 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -707,7 +707,6 @@ watchdog: watchdog@f8048040 {
 			clk32k: clock-controller@f8048050 {
 				compatible = "atmel,sama5d4-sckc";
 				reg = <0xf8048050 0x4>;
-
 				clocks = <&slow_xtal>;
 				#clock-cells = <0>;
 			};
-- 
2.34.1

