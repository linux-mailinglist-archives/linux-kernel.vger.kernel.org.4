Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BCE732D42
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245580AbjFPKRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243664AbjFPKRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:17:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986B72120;
        Fri, 16 Jun 2023 03:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686910640; x=1718446640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1EF0J3XTU84QK19mrIrzhm1/XzHKeM/G1C/GTKLV/tc=;
  b=myxlqNmzSTi3FP3Sc4joHpFxR5Ifk22fbKxsTnFL1VPx07CMRqdZbEZE
   G5Ot0LmE+O9ldwGAxFk5x/5CRjdtH9no4CPAHDpu1WuRWN5kIlnw9Z3jj
   jKY1992YtBBHxjFjbOn1fBhXIv7uCri4uBFmfzVnSI5WOh2Pm/n/XyXCc
   RrXCIS6wdZwkdEDf0Gy+rTidXUwPgOrX5wPDsbwoBrBlFhmK9m6uvNcAS
   buUR+lJwQxK0/sZgdU8zRFIxN/f6EOs5wtdHNYXAJN7MzohJYEQ7UWDRr
   59UfGgezBKVkyzU5C3JCwr07Mq4fyaDye5zM2a8BvnC+ZVx/yKALr8a8s
   g==;
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="218860857"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jun 2023 03:17:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 16 Jun 2023 03:17:18 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 16 Jun 2023 03:17:14 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <sre@kernel.org>, <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 4/4] MAINTAINERS: add documentation file for Microchip SAMA5D2 shutdown controller
Date:   Fri, 16 Jun 2023 13:16:46 +0300
Message-ID: <20230616101646.879480-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616101646.879480-1-claudiu.beznea@microchip.com>
References: <20230616101646.879480-1-claudiu.beznea@microchip.com>
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

Add documentation file for SAMA5D2 shutdown controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
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

