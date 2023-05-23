Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3235570D3BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbjEWGPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbjEWGPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:15:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7853121;
        Mon, 22 May 2023 23:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684822530; x=1716358530;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yDCojzLYsG5wKsp06o/NDvm2B9gu67JEh/QTra7lVj8=;
  b=fIVQETAuGfzLlJ4Os0+z/4bOCDFT88qiWawG45xw+k9tOomnNi46Wsry
   m7F5zYAg5vq2S+025Rt/H2vBZRWxPjd8Hjaky7Fn/j/pWrrZTTb3K5rSm
   f5+4fOAn8YsEFcBPTMPx/817ESq2hBtlqdylH+fQ6tpN6BaJQYeog/uJA
   qwtRPT9UXCKYwYlfZ9SoREzhLDPoXhLpDLxY/cirr4Ibdu65pwoxjHZ+w
   9oDiOZ6S76u0VcKGGrlLz1VPvidMnY/TISkLxZh7EUf7HvoLUtSX4ONFp
   vnVYCpB7y3egQIAZJ2SF5tG3uDIGUrwTdWoVHJVhE/Wk9/Ohu+5CPe+ZS
   g==;
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="153433835"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 23:15:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 23:15:27 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 22 May 2023 23:15:23 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor.dooley@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <sre@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/4] dt-bindings: power: reset: at91: convert to YAML
Date:   Tue, 23 May 2023 09:15:08 +0300
Message-ID: <20230523061512.195271-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
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

Hi,

Series convert AT91 shutdown controllers documentation to YAML.
Along with it device trees were updated and also entries to
MAINTAINERS with documentation files.

Thank you,
Claudiu

Claudiu Beznea (4):
  ARM: dts: at91: use generic name for shutdown controller
  dt-bindings: power: reset: atmel,at91sam9260-shdwc: convert to yaml
  dt-bindings: power: reset: atmel,sama5d2-shdwc: convert to yaml
  MAINTAINERS: add documentation file for Microchip SAMA5D2 shutdown
    controller

 .../devicetree/bindings/arm/atmel-sysregs.txt |  94 ---------------
 .../power/reset/atmel,at91sam9260-shdwc.yaml  |  81 +++++++++++++
 .../power/reset/atmel,sama5d2-shdwc.yaml      | 114 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 arch/arm/boot/dts/at91-qil_a9260.dts          |   2 +-
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts   |   2 +-
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts     |   2 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts   |   2 +-
 arch/arm/boot/dts/at91sam9260.dtsi            |   2 +-
 arch/arm/boot/dts/at91sam9260ek.dts           |   2 +-
 arch/arm/boot/dts/at91sam9261.dtsi            |   2 +-
 arch/arm/boot/dts/at91sam9263.dtsi            |   2 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi   |   2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi            |   2 +-
 arch/arm/boot/dts/at91sam9n12.dtsi            |   2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi             |   2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi             |   2 +-
 arch/arm/boot/dts/sam9x60.dtsi                |   2 +-
 arch/arm/boot/dts/sama5d2.dtsi                |   2 +-
 arch/arm/boot/dts/sama5d3.dtsi                |   2 +-
 arch/arm/boot/dts/sama5d4.dtsi                |   2 +-
 arch/arm/boot/dts/sama7g5.dtsi                |   2 +-
 arch/arm/boot/dts/usb_a9260.dts               |   2 +-
 arch/arm/boot/dts/usb_a9263.dts               |   2 +-
 24 files changed, 216 insertions(+), 114 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/atmel,at91sam9260-shdwc.yaml
 create mode 100644 Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml

-- 
2.34.1

