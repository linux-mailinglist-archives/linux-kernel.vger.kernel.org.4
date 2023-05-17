Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6D970672F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjEQLyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjEQLyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:54:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B5A4EED;
        Wed, 17 May 2023 04:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684324453; x=1715860453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WGOMQHnZTpw9dk6kO7DuPZBSvjfNXOGEhu//BHCo5Bk=;
  b=2mZRUA9QlGPTNPZFnrdJxedWgGmNgp4wPst1UEcxvkkS63Qv2SQizk82
   tKhaAapNPy69f3PneaA1a6R63rSeCnfzubFkBXoXE5MqxG9Xz9v6IGP0J
   gADGInyY1SdLsetEyXQOrzJP+qNlk250NCEZRq5tQG6VxxoHszs1xvDCQ
   FdtPea9TzABThN4GlbevCQIOIX/f+8MibL2IZIR6hqYb+ZbW6OyQSNjGg
   GlWXGup98bo6xG4Q4aza7f/55TNVvGSNtxgUDrPZF6h6oSMOLfX8Ba0K1
   3DotQ5/eBXxs74V6DI9UmiO8rUqO6rUrTMDK0dAu48o5BM+sHrUeSlriO
   w==;
X-IronPort-AV: E=Sophos;i="5.99,282,1677567600"; 
   d="scan'208";a="214268314"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2023 04:54:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 04:54:12 -0700
Received: from ryan-Precision-5560.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 17 May 2023 04:54:08 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <linus.walleij@linaro.org>, <ludovic.desroches@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 2/3] dt-bindings: pinctrl: at91-pio4: Add push-pull support
Date:   Wed, 17 May 2023 13:54:05 +0200
Message-ID: <048a41d1dcb3da0e845986a73eaac61a54c69269.1684313910.git.Ryan.Wanner@microchip.com>
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

Add generic push-pull support for pio4 driver.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt    | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
index e2b861ce16d8..774c3c269c40 100644
--- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
@@ -37,7 +37,8 @@ right representation of the pin.
 Optional properties:
 - GENERIC_PINCONFIG: generic pinconfig options to use:
 	- bias-disable, bias-pull-down, bias-pull-up, drive-open-drain,
-	  input-schmitt-enable, input-debounce, output-low, output-high.
+	 drive-push-pull input-schmitt-enable, input-debounce, output-low,
+	 output-high.
 	- for microchip,sama7g5-pinctrl only:
 		- slew-rate: 0 - disabled, 1 - enabled (default)
 - atmel,drive-strength: 0 or 1 for low drive, 2 for medium drive and 3 for
-- 
2.39.2

