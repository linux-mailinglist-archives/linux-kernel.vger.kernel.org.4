Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2633268D51A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjBGLHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjBGLHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:07:12 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98706EB7E;
        Tue,  7 Feb 2023 03:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675768027; x=1707304027;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dDI4A6HJTioLCKUY7vYEGx25MsUN8KwQ7xKiuXhgBIM=;
  b=oevL/DppNKzFPBEiFA42Lv0eeey9MDIvBTnLPymn43CykMJevTDyqOPN
   t0LzWIbJdWlleRtOuDbAMoM5sZLRc8JDYDE+SvcFQ00C3vC8jBnz86gVJ
   n1wJ2JcRrw1Yo2ROiXUsaqcaFSK2K3NXrdkH33jFNy1o4rCV6OPuE6FOW
   m/qKR8Dm8snoBRTVx8SG9RhyYFuz3gGRokGJbDXw6v+tPbNyPcG1nTp8/
   tAI50LhnrxMlIj72wEHWOC0v+0/VLBJrpiYPfgvtqAJlpLW1ggDzzEVP8
   acC3JY5Zpk14CMW4uxRRtBOvitPxgjL6CGAHbAIhBS3gluWN5MgiRVlHF
   g==;
X-IronPort-AV: E=Sophos;i="5.97,278,1669100400"; 
   d="scan'208";a="135929091"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Feb 2023 04:07:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 04:07:05 -0700
Received: from che-lt-i66125lx.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 04:06:56 -0700
From:   Durai Manickam KR <durai.manickamkr@microchip.com>
To:     <Hari.PrasathGE@microchip.com>,
        <balamanikandan.gunasundar@microchip.com>,
        <manikandan.m@microchip.com>, <varshini.rajendran@microchip.com>,
        <dharma.b@microchip.com>, <nayabbasha.sayed@microchip.com>,
        <balakrishnan.s@microchip.com>, <claudiu.beznea@microchip.com>,
        <cristian.birsan@microchip.com>, <nicolas.ferre@microchip.com>,
        <krzysztof.kozlowski@linaro.org>, <alexandre.belloni@bootlin.com>,
        <davem@davemloft.net>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <Horatiu.Vultur@microchip.com>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <michael@walle.cc>, <jerry.ray@microchip.com>
CC:     Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: [PATCH v6 0/8] Add support for sam9x60 curiosity board
Date:   Tue, 7 Feb 2023 16:36:43 +0530
Message-ID: <20230207110651.197268-1-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches is meant to address the following:
- Moving of flexcom definitions from board file to SoC file and
   some minor changes to its properties.
- Add support for the new sam9x60 curiosity board based on the
   existing sam9x60 SoC.

Changes in v6:
--------------
- Added Reviewed-by and Acked-by tags.
All the patches are accepted except the below patches which are
updated based on the comments receied on PATCH v5,
- [PATCH v5 8/8] Enabled the sdmmc1 node in dts.
- [PATCH v5 8/8] Syntax update in dts for sdmmc1 node and i2c0 
  node.

Changes in v5:
--------------
All the patches are accepted except the below patches which are 
updated based on the comments receied on PATCH v4,
- [PATCH v4 2/8] Updated from field and first SOB as same author.
- [PATCH v4 2/8] Added the missing compatibles for the UART.
- [PATCH v4 8/8] Fixed the dtb warnings.

Changes in v4:
--------------
- Added the missed property atmel,usart-mode in uart5
- Renamed the led label.

Changes in v3:
--------------
- Updated commit logs mentioning each author's contribution.
- Author name is updated based on the linux mainline guidelines.
- updated the description file such that sam9x60 curiosity is
  added together with sam9x60ek as an enum.
- Updated the entries in the regulator container alphabetically
  sorted.
- Added label name and node name following the guidelines.

Changes in v2:
--------------
- Added generic names for regulator node.
- Removed the #addredd-cells and #size-cells property which shows
  compilation warning.
- Removed the property "status=okay" as this is default.
- No underscores used for the pinctrl definitions and node names.
- Organised the patches in the logical way.
- Bindings are made separate patch.

Durai Manickam KR (3):
  ARM: dts: at91: sam9x60: fix spi4 node
  dt-bindings: arm: at91: Add info on sam9x60 curiosity
  ARM: dts: at91: sam9x60_curiosity: Add device tree for sam9x60
    curiosity board

Manikandan Muralidharan (5):
  ARM: dts: at91: sam9x60: Fix the label numbering for the flexcom
    functions
  ARM: dts: at91: sam9x60: move flexcom definitions
  ARM: dts: at91: sam9x60: Specify the FIFO size for the Flexcom UART
  ARM: dts: at91: sam9x60: Add DMA bindings for the flexcom nodes
  ARM: dts: at91: sam9x60: Add missing flexcom definitions

 .../devicetree/bindings/arm/atmel-at91.yaml   |   6 +-
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/at91-sam9x60_curiosity.dts  | 503 ++++++++++++++
 arch/arm/boot/dts/at91-sam9x60ek.dts          |  50 +-
 arch/arm/boot/dts/sam9x60.dtsi                | 622 ++++++++++++++++++
 5 files changed, 1140 insertions(+), 42 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-sam9x60_curiosity.dts

-- 
2.25.1

