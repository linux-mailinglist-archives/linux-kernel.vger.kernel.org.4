Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37CA706736
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjEQLy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjEQLyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:54:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C51261A4;
        Wed, 17 May 2023 04:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684324457; x=1715860457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RT0UlB3xEwYqeI/LH/lFegS8fsQcn4QNfOH63mMlj1o=;
  b=w9aAqCWrHam+R1UsIlvXbMxfK2g06Otj7OhmeZORuNk78HgWzFsUHySp
   8/UIZqBMZJglYYVXDkbQkFUhMFJmHSN7dRShLGzZlh0W4CL/5cRgHKzY4
   BpOToRZ3asP1PIs2vnKYCyiHdwSbaQltgwrLfsEGtbgqlQX7DRJGBM5RX
   FvgnmumJmWv8zincxyd38/+AzYcb0vAtGfGhBoDxHIlwHGQ98sqFCWLJi
   XuPCLLffgInXSb8pAeupwyCmLWtUVCylNlE50t+v1s6Uph8uZCjvcg5jA
   PJ2r/+LnjgKi29Dw9NPGb1loe7bOfoKzPBhyqVD/2Gi4gXGK63a4YNeaP
   A==;
X-IronPort-AV: E=Sophos;i="5.99,282,1677567600"; 
   d="scan'208";a="225738592"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2023 04:54:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 04:54:16 -0700
Received: from ryan-Precision-5560.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 17 May 2023 04:54:13 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <linus.walleij@linaro.org>, <ludovic.desroches@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 3/3] ARM: dts: at91: Return to boolean properties
Date:   Wed, 17 May 2023 13:54:06 +0200
Message-ID: <6f06be9e393c02563bc877498c8af75daf3b47f8.1684313910.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684313910.git.Ryan.Wanner@microchip.com>
References: <cover.1684313910.git.Ryan.Wanner@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Returning back to commit 0dc23d1a8e17
("arm: dts: at91: Fix boolean properties with values") as pinctrl driver no
longer expects an integer value and expects a simple boolean property.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/boot/dts/at91-kizbox3-hs.dts      | 2 +-
 arch/arm/boot/dts/at91-kizbox3_common.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91-kizbox3-hs.dts b/arch/arm/boot/dts/at91-kizbox3-hs.dts
index 7075df6549e9..fec7269088d1 100644
--- a/arch/arm/boot/dts/at91-kizbox3-hs.dts
+++ b/arch/arm/boot/dts/at91-kizbox3-hs.dts
@@ -225,7 +225,7 @@ pinctrl_pio_zbe_rst: gpio_zbe_rst {
 		pinctrl_pio_io_reset: gpio_io_reset {
 			pinmux = <PIN_PB30__GPIO>;
 			bias-disable;
-			drive-open-drain = <1>;
+			drive-open-drain;
 			output-low;
 		};
 		pinctrl_pio_input: gpio_input {
diff --git a/arch/arm/boot/dts/at91-kizbox3_common.dtsi b/arch/arm/boot/dts/at91-kizbox3_common.dtsi
index abe27adfa4d6..465664628419 100644
--- a/arch/arm/boot/dts/at91-kizbox3_common.dtsi
+++ b/arch/arm/boot/dts/at91-kizbox3_common.dtsi
@@ -211,7 +211,7 @@ pinctrl_flx4_default: flx4_i2c6_default {
 		pinmux = <PIN_PD12__FLEXCOM4_IO0>, //DATA
 		<PIN_PD13__FLEXCOM4_IO1>; //CLK
 		bias-disable;
-		drive-open-drain = <1>;
+		drive-open-drain;
 	};
 
 	pinctrl_pwm0 {
-- 
2.39.2

