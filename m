Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5A6732D39
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243762AbjFPKRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245746AbjFPKRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:17:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A086137;
        Fri, 16 Jun 2023 03:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686910625; x=1718446625;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+yZ1J9TkgeUwFYSmwgGhVFWjrw27DTlM8sQsMjgV3EI=;
  b=iZo0eA5WrEXvrGcwLdFvX54VznAgI+HcsJ3nKs4Y6B03NzH64U505pE2
   s/yjndYVBj1Z7f6fHVLAH1sTPcvamzS//Rj421B/W1Gkl76hzQueYeo99
   Syt/NWGt496VX3ZWhcTDEUFP6P04X28yY4TlfYGsuwgJPZwD8pv5ZE60Z
   5XnK4J47JZpx6Z1rWUPIDe+CpGLS5sOqcHjhof1613jcnpxuou3hbOCvr
   HELztu8b7UOjSKmWj/DGEpUz7RGOZcaCuszhmZyDK0sK8gb8f7VrHgmxN
   7i3fnXCaoYqGK/X5PSpyil2vbDHjmvoGqQiVBz8h6qcDQJ52K+vFGvI1H
   A==;
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="218860839"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jun 2023 03:17:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 16 Jun 2023 03:17:03 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 16 Jun 2023 03:17:00 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <sre@kernel.org>, <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 0/4] dt-bindings: power: reset: at91: convert to YAML
Date:   Fri, 16 Jun 2023 13:16:42 +0300
Message-ID: <20230616101646.879480-1-claudiu.beznea@microchip.com>
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

Series convert AT91 shutdown controllers documentation to YAML.
Along with it device trees were updated and also entries to
MAINTAINERS with documentation files.

Thank you,
Claudiu

Changes in v3:
- do not define properties in allOf section
- used additionalProperties instead of unevaluatedProperties
- fixed compatible list of patch 3/4
- s/Atmel/Microchip AT91/g in title and description sections of YAML files
  and in commit description
- collected tags

Changes in v2:
- use minimum, maximum on uint32 enums instead of all possible values
- change commit description for patch 3/4 to explain why there is a
  syscon along with microchip,sama7g5-shdwc
- remove | near description entries

Claudiu Beznea (4):
  ARM: dts: at91: use generic name for shutdown controller
  dt-bindings: power: reset: atmel,at91sam9260-shdwc: convert to yaml
  dt-bindings: power: reset: atmel,sama5d2-shdwc: convert to yaml
  MAINTAINERS: add documentation file for Microchip SAMA5D2 shutdown
    controller

 .../devicetree/bindings/arm/atmel-sysregs.txt |  94 ---------------
 .../power/reset/atmel,at91sam9260-shdwc.yaml  |  82 +++++++++++++
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
 24 files changed, 217 insertions(+), 114 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/atmel,at91sam9260-shdwc.yaml
 create mode 100644 Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml

-- 
2.34.1

