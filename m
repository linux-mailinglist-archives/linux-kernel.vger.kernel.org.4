Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC4F6F64AA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjEDGHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEDGHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:07:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F871984;
        Wed,  3 May 2023 23:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683180460; x=1714716460;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3p5CPLUKsgB434vhwxvISd43WJZSlLw5pyn7exU6CDU=;
  b=xn9SRLY6NYRfuyQRm643QxtIVYGYg6XmKP38KZrHGkVP3Bd40rNQ6J5b
   hjba/DpQ4SZETFK+YnbgYV+Er+xpm6Ig2fv00gTNKDhQDhW3Ru0xtep88
   /M9xzlHJazngntmaa/11H6bj6aUoaiY4GY9arySvY9LAzfe/X6ub0wlZf
   4Q1RybiJAfsLONazSknQD3CBsJioe4kKWOIPyANkn96JwDnBQadxKrbLz
   IhTtnCqnp6po49df2LdZWD1K6bVv0rihedYEmwDO8eFWiDeIRxNsoQYa3
   jklo8+Afy+Tkc3y8ojSKeVqoq4Vo9QIXOeBftc952ilAfNrms1MQAhF2f
   g==;
X-IronPort-AV: E=Sophos;i="5.99,249,1677567600"; 
   d="scan'208";a="150277109"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 May 2023 23:07:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 3 May 2023 23:07:38 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 3 May 2023 23:07:35 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/5] dt-bindings: clocks: at91: convert to yaml
Date:   Thu, 4 May 2023 09:07:24 +0300
Message-ID: <20230504060729.689579-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series converts atmel clocks bindings (PMC and slow clock
controller) to YAML. Along with it updated device trees to cope
with the dt-binding requirements.

Thank you,
Claudiu Beznea

Claudiu Beznea (5):
  ARM: dts: at91: use clock-controller name for PMC nodes
  dt-bindings: clocks: atmel,at91rm9200-pmc: convert to yaml
  ARM: dts: at91: at91sam9n12: witch sckc to new clock bindings
  ARM: dts: at91: use clock-controller name for sckc nodes
  dt-bindings: clocks: at91sam9x5-sckc: convert to yaml

 .../devicetree/bindings/clock/at91-clock.txt  |  58 -------
 .../bindings/clock/atmel,at91rm9200-pmc.yaml  | 161 ++++++++++++++++++
 .../bindings/clock/atmel,at91sam9x5-sckc.yaml |  84 +++++++++
 arch/arm/boot/dts/at91rm9200.dtsi             |   2 +-
 arch/arm/boot/dts/at91sam9260.dtsi            |   2 +-
 arch/arm/boot/dts/at91sam9261.dtsi            |   2 +-
 arch/arm/boot/dts/at91sam9263.dtsi            |   2 +-
 arch/arm/boot/dts/at91sam9g20.dtsi            |   2 +-
 arch/arm/boot/dts/at91sam9g25.dtsi            |   2 +-
 arch/arm/boot/dts/at91sam9g35.dtsi            |   2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi            |   4 +-
 arch/arm/boot/dts/at91sam9n12.dtsi            |  25 +--
 arch/arm/boot/dts/at91sam9rl.dtsi             |   4 +-
 arch/arm/boot/dts/at91sam9x25.dtsi            |   2 +-
 arch/arm/boot/dts/at91sam9x35.dtsi            |   2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi             |   4 +-
 arch/arm/boot/dts/sam9x60.dtsi                |   4 +-
 arch/arm/boot/dts/sama5d2.dtsi                |   4 +-
 arch/arm/boot/dts/sama5d3.dtsi                |   4 +-
 arch/arm/boot/dts/sama5d3_emac.dtsi           |   2 +-
 arch/arm/boot/dts/sama5d4.dtsi                |   4 +-
 arch/arm/boot/dts/sama7g5.dtsi                |   2 +-
 22 files changed, 274 insertions(+), 104 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/at91-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml

-- 
2.34.1

