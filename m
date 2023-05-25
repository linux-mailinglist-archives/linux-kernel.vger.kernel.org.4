Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA6F710C99
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjEYM5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241141AbjEYM5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:57:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2C7E4A;
        Thu, 25 May 2023 05:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685019418; x=1716555418;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FUGrDWX/gtkCZPde2wa6CTBiIpMC9IR1HKiXnMzSqbI=;
  b=ewnrc4rKwd9Em37sSUP3mXYz5ipp+R99khNNNt1lJo/3AYDQVdeK5Sph
   BtfOeNvz/d0gA7qPGnNGPHZSHKlpkN0JV66EwsLLjTCBYyrHyXvtKxvYi
   BBV6xO5WOUeGYHS0JWG44npScuywvIq/pM13Z2n0un2Mp6U4FiliSyZkH
   8a3CjJgLv7s1SzCu6N/2OjBqL9nJaXVzUBhRSWVgdFq07Q2CNbAy/AHwK
   xjH5ulj1Q/aAT72cH88K6OEuifY9r7YOWBfpLu4IwIjUuploh0rR2QGMW
   hFnVR3V9fXSfrbHwIICspHyLNb2iLXTochbBLj1p9bhwJdk/l/T4tJkKL
   w==;
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="217255227"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 May 2023 05:56:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 25 May 2023 05:56:49 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 25 May 2023 05:56:41 -0700
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
Subject: [PATCH 0/5] dt-bindings: timer: AT91 convert to YAML
Date:   Thu, 25 May 2023 15:55:57 +0300
Message-ID: <20230525125602.640855-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
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

Hi,

Series converts AT91 timers DT bindings to YAML. Along with it the
atmel,at91rm9200-wdt has been converted and introduced in this series
as it is referenced by atmel,at91rm9200-st.

Thank you,
Claudiu Beznea

Claudiu Beznea (5):
  dt-bindings: timer: atmel,at91sam9260-pit: convert to yaml
  ARM: dts: at91: sama7g5: keep only microchip,sam9x60-pit64b compatible
    for pit64b
  dt-bindings: timer: microchip,sam9x60-pit64b: convert to yaml
  dt-bindings: watchdog: atmel,at91rm9200-wdt: convert to yaml
  dt-bindings: timer: atmel,at91rm9200-st: convert to yaml

 .../devicetree/bindings/arm/atmel-sysregs.txt | 21 ------
 .../bindings/timer/atmel,at91rm9200-st.yaml   | 66 +++++++++++++++++++
 .../bindings/timer/atmel,at91sam9260-pit.yaml | 51 ++++++++++++++
 .../timer/microchip,sam9x60-pit64b.yaml       | 56 ++++++++++++++++
 .../watchdog/atmel,at91rm9200-wdt.yaml        | 29 ++++++++
 .../watchdog/atmel-at91rm9200-wdt.txt         |  9 ---
 arch/arm/boot/dts/sama7g5.dtsi                |  4 +-
 7 files changed, 204 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/atmel,at91rm9200-st.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/microchip,sam9x60-pit64b.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt

-- 
2.34.1

