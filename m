Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75882688E38
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 04:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjBCDuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 22:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjBCDuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 22:50:54 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22827E6F3;
        Thu,  2 Feb 2023 19:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675396252; x=1706932252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K/FmuJe85bAHYZr8iZGtQCBIR7zCPBdVyq4OhYP65Jc=;
  b=BKdqsfi/sihbpVUQ3k2aHe1OSikFqXdVwFFGnwLw1y06pOgpSu8G4xbt
   7Poe0L62k239OmluDSTMOJKSIG0lT5G8D8kQLkycGkhBJk4pGjGXWh/ls
   qZYnWhyCPLlFz/XAh+uuWPvo7xn0vfN/bQFDtz2e+u1yyt4n2nXqGAyCk
   mmxkpyZ6/FN3ez2geGJhhLFrD514wxOQZ26DnPVk6NME416u5/8bR6oDK
   oE8H/b3V3udZmxliRoIsn51ftH03/zXAkLRK8yf5baK1ePYinJAmbE+bS
   nrU51U2DChYFnoQTbdfArMKUW10eKtBZgWDdvV8OmCTkTGF6283Hoxl8V
   A==;
X-IronPort-AV: E=Sophos;i="5.97,269,1669100400"; 
   d="scan'208";a="199411244"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Feb 2023 20:50:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 20:50:47 -0700
Received: from che-lt-i66125lx.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 20:50:37 -0700
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
Subject: [PATCH v5 7/8] dt-bindings: arm: at91: Add info on sam9x60 curiosity
Date:   Fri, 3 Feb 2023 09:18:32 +0530
Message-ID: <20230203034833.451461-8-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230203034833.451461-1-durai.manickamkr@microchip.com>
References: <20230203034833.451461-1-durai.manickamkr@microchip.com>
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

Adding the sam9x60 curiosity board from Microchip into the atmel AT91 board
description yaml file.

Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 2224b18801a1..dfb8fd089197 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -91,9 +91,11 @@ properties:
           - const: atmel,sama5d2
           - const: atmel,sama5
 
-      - description: SAM9X60-EK board
+      - description: Microchip SAM9X60 Evaluation Boards
         items:
-          - const: microchip,sam9x60ek
+          - enum:
+              - microchip,sam9x60ek
+              - microchip,sam9x60-curiosity
           - const: microchip,sam9x60
           - const: atmel,at91sam9
 
-- 
2.25.1

