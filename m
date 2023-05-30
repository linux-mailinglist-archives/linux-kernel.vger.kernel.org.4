Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8A0715964
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjE3JIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjE3JIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:08:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1804CD;
        Tue, 30 May 2023 02:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685437698; x=1716973698;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3xrNb/GCbzmCyvgZ+8ggmdYFsvrk6fVk1+jfq9Z+qZY=;
  b=HyfSDlsWKynzDOsdIMr2rII7wQfCOJ60RctqtfNoCnBHUrmyYywPgF5k
   RMdbu+qyenLW6xjoc+Y3FGtuFmUVXj26nybE0pI6cHtsyoSKfEOOXnt46
   rrtfi36J81c+WSdlZcWg3iUkrHJAPIVY8wR0+e4AlOVosVjQADCRTbaIN
   sJkZr6bvd/8nf32SawIK4K0d/wjZNwLybUr6sJGG6etbe/k4MmgOqCQQ3
   vYLDoTrqSQr70DfYpBdO1goH7y4MAThp+4l25jpbYRwN+a4WcFiMnu42w
   P9ds99eM78i9k5nENEOgMOhJecSCo6N3QMhyUo+Mha9AuFVGCVYvd9SC6
   A==;
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="213680020"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2023 02:08:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 30 May 2023 02:08:12 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 30 May 2023 02:08:08 -0700
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
Subject: [PATCH v3 0/3] dt-bindings: timer: Microchip AT91 convert to YAML
Date:   Tue, 30 May 2023 12:07:55 +0300
Message-ID: <20230530090758.1652329-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Series converts Microchip AT91 timers DT bindings to YAML. Along with it the
atmel,at91rm9200-wdt has been converted and introduced in this series
as it is referenced by atmel,at91rm9200-st.

Thank you,
Claudiu Beznea

Changes in v3:
- removed patch 1/4 from v2
- in patch 1/3 keep interrupt description only for PIT case (not for PIT64b)
  and updated interrupt description to emphasize blocks part of the system
  controller; note that system controller components may be different b/w
  different Microchip AT91 SoCs; 
- in patch 3/3 updated interrupt description to emphasize blocks part of the
  system controller; also, corrected Alexandre's email address
- collected tags.

Changes in v2:
- fixed compilation errors (sorry for that in v1)
- moved DTS patch as the 1st patch in series
- squash PIT and PIT64B into the same documentation file
- use Microchip in titles, descriptions and commit message
- in patch 4/4 remove oneOf from compatible section

Claudiu Beznea (3):
  dt-bindings: timer: atmel,at91sam9260-pit: convert to yaml
  dt-bindings: watchdog: atmel,at91rm9200-wdt: convert to yaml
  dt-bindings: timer: atmel,at91rm9200-st: convert to yaml

 .../devicetree/bindings/arm/atmel-sysregs.txt | 21 ----
 .../bindings/timer/atmel,at91rm9200-st.yaml   | 66 +++++++++++++
 .../bindings/timer/atmel,at91sam9260-pit.yaml | 99 +++++++++++++++++++
 .../watchdog/atmel,at91rm9200-wdt.yaml        | 29 ++++++
 .../watchdog/atmel-at91rm9200-wdt.txt         |  9 --
 5 files changed, 194 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/atmel,at91rm9200-st.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt

-- 
2.34.1

