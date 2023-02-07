Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6648368D52A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjBGLIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjBGLIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:08:51 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B29D39BAA;
        Tue,  7 Feb 2023 03:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675768123; x=1707304123;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p1lbUVhb7i+rNn22EBbKPX27IsYE8BqOKDNggZDvwDs=;
  b=Y7ATvVS//3N4W8ReMPTkvc8FGAiZCLdrMAMKyPBeTodXwGloKmPcjXTY
   /TKHpKAO8lIf5x2uI4tvXNVzw48Oz8GQBSiwTm+d8qalJY9ty+CY/tpus
   P9VktByis0Gq/ulUxXdheW9Cn7KLSsjPJMNKxEd0JyDvvP3RNMgd50uLL
   64eQ4XpMD+MR7MNlzQ7RIln9ZNHIsCtxETMKfVpf3wljuYJG3QSq+Z8IY
   opMvhDmC7T36KcDuPtdJnallEAdvruktMfrgMVjU7WUCARxcEuNrNOhd0
   a9K8oH9zSecgR468yuWTWo0TEUOWagHV6MsamDvVcqByX9TGQU3aZEMyT
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,278,1669100400"; 
   d="scan'208";a="199283546"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Feb 2023 04:08:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 04:08:42 -0700
Received: from che-lt-i66125lx.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 04:08:32 -0700
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
Subject: [PATCH v6 7/8] dt-bindings: arm: at91: Add info on sam9x60 curiosity
Date:   Tue, 7 Feb 2023 16:36:50 +0530
Message-ID: <20230207110651.197268-8-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230207110651.197268-1-durai.manickamkr@microchip.com>
References: <20230207110651.197268-1-durai.manickamkr@microchip.com>
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

