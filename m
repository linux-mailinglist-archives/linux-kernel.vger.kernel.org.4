Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF9970F6A0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjEXMgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbjEXMgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:36:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28963135;
        Wed, 24 May 2023 05:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684931761; x=1716467761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hX0vBHxCDkOd3pRwjtiOcZRwcusvy0J39jQkffoEfYY=;
  b=Nea7OuSvTKoz5lOcEKauR8MoCAlE8XXA+FaN2eJn8Qon4TXK7RdYVzTe
   65j9JELXtOOAZEdW/omX7DxV1IBvPTMU4zYKRph8uPWZyXZJ9hMcqadZC
   AzeOVB0Y36xotRJpqa1rhSlf4Rr4v6tsgRkxAkE/HJJZe7J5RBOsaO9+i
   F+/+6drivFlxY+a1ih4jOx/y6KP+yhlnQCw6uX2KM8jNkG8mLs11CrU2j
   g/QNTaIb/jVDzGm7C3kVWHjFps8UOSC4uSZNNEash1O8RMe5l3c3ddWis
   uzW6g1BXlTGGIekYcaTZDMoVjlCzy8tBLu0ZI6BJGz9tavXEJnItR5F9r
   A==;
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="214683144"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 May 2023 05:36:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 24 May 2023 05:35:55 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 24 May 2023 05:35:52 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <sre@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 4/4] MAINTAINERS: add documentation file for Microchip SAMA5D2 shutdown controller
Date:   Wed, 24 May 2023 15:35:28 +0300
Message-ID: <20230524123528.439082-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524123528.439082-1-claudiu.beznea@microchip.com>
References: <20230524123528.439082-1-claudiu.beznea@microchip.com>
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

Add documentation file for SAMA5D2 shutdown controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 74a6b6b13d84..cdf4b41cf62b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13811,6 +13811,7 @@ F:	include/dt-bindings/iio/adc/at91-sama5d2_adc.h
 MICROCHIP SAMA5D2-COMPATIBLE SHUTDOWN CONTROLLER
 M:	Claudiu Beznea <claudiu.beznea@microchip.com>
 S:	Supported
+F:	Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
 F:	drivers/power/reset/at91-sama5d2_shdwc.c
 
 MICROCHIP SPI DRIVER
-- 
2.34.1

