Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9127144BE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjE2G1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjE2G1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:27:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7BEBB;
        Sun, 28 May 2023 23:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685341629; x=1716877629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KcTINnFqEvZciX/JTiRqX8Z8FBun2lhdVHpacFRYHL4=;
  b=17J28CGx+sP+Vjy3WBSFZworUluYI3IWEsfg4nqsQGsh0QD6twmUZfli
   xT4PHR1kvErkDJIHrjiKGHr91AewdBK7FB7cn2GBX1BYvgEyzNIHIjtXL
   sESEzEICZtzFTf5U7UWqC/KZBu3iTK3ENggh0wjSr+/kx+KBVue0BV6le
   6cQRwr1fL/mgcdno3oNrnqH4qd9we4Dy9gBpZEVRlyFsKol24szTp0jTq
   kEVv7S5h1PwdGHDKsqNNWUwQPSrLAXqBm4CRgPREKOnaI76bd4MQyaqGw
   lysaOQREgIRmqcHQkl5sUJTcaLQd4jrEeE/+rV4x6FGgdAjU1NKW231Iv
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="215861621"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 May 2023 23:26:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 28 May 2023 23:26:22 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Sun, 28 May 2023 23:26:17 -0700
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
Subject: [PATCH v2 0/4] dt-bindings: timer: Microchip AT91 convert to YAML
Date:   Mon, 29 May 2023 09:26:00 +0300
Message-ID: <20230529062604.1498052-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
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

Hi,

Series converts Microchip AT91 timers DT bindings to YAML. Along with it the
atmel,at91rm9200-wdt has been converted and introduced in this series
as it is referenced by atmel,at91rm9200-st.

Thank you,
Claudiu Beznea

Changes in v2:
- fixed compilation errors (sorry for that in v1)
- moved DTS patch as the 1st patch in series
- squash PIT and PIT64B into the same documentation file
- use Microchip in titles, descriptions and commit message
- in patch 4/4 remove oneOf from compatible section

Claudiu Beznea (4):
  ARM: dts: at91: sama7g5: keep only microchip,sam9x60-pit64b compatible
    for pit64b
  dt-bindings: timer: atmel,at91sam9260-pit: convert to yaml
  dt-bindings: watchdog: atmel,at91rm9200-wdt: convert to yaml
  dt-bindings: timer: atmel,at91rm9200-st: convert to yaml

 .../devicetree/bindings/arm/atmel-sysregs.txt | 21 ----
 .../bindings/timer/atmel,at91rm9200-st.yaml   | 65 +++++++++++++
 .../bindings/timer/atmel,at91sam9260-pit.yaml | 96 +++++++++++++++++++
 .../watchdog/atmel,at91rm9200-wdt.yaml        | 29 ++++++
 .../watchdog/atmel-at91rm9200-wdt.txt         |  9 --
 arch/arm/boot/dts/sama7g5.dtsi                |  4 +-
 6 files changed, 192 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/atmel,at91rm9200-st.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt

-- 
2.34.1

