Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7134C5B6199
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 21:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiILTWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 15:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiILTWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 15:22:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193954361C;
        Mon, 12 Sep 2022 12:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663010532; x=1694546532;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TXS01MeQcvfoprp7LLm9T1zw6OQ9jGZYEO3glco0J4Y=;
  b=k6lvxM5NhVVlV9AgaFgY/2GWYiqjX5LWElNX6CkiPcTMBcYnJDR3DGd3
   C6hi7r+j+3c2Hl1Bkntk3HUxjkOozAtIXiVtMUP7Tvfr7aSxJnTBHh7lb
   rIUBj9ed7cZR2u0A4kXqklL2KqyNhklJS+VvbnsVPSY5niIezqb7iAtQC
   oIc4Y42MeQyegk/XLvUCsQRyAso9xb+rGmk+HzMhydWM7P5n9xj7z0zFk
   gw+cRGdoRG6Ws5Ur3eyEQ72XPIm/S3tLqepDEpu+UBj3PxPemL8fqeCvG
   m/o0XsuvlWbfmHcZpf7cDP/8iZlLzTZLcbJPhrkw+jYDK18BEXPagX1Nu
   A==;
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="173492040"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Sep 2022 12:22:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 12 Sep 2022 12:22:10 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 12 Sep 2022 12:22:09 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <claudiu.beznea@microchip.com>, <nicolas.ferre@microchip.com>,
        <michael@walle.cc>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH] ARM: dts: lan966x: Fix the interrupt number for internal PHYs
Date:   Mon, 12 Sep 2022 21:26:29 +0200
Message-ID: <20220912192629.461452-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet the interrupts for internal PHYs are
80 and 81.

Fixes: 6ad69e07def67c ("ARM: dts: lan966x: add MIIM nodes")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 arch/arm/boot/dts/lan966x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x.dtsi
index bcb130a2471d..23665a042990 100644
--- a/arch/arm/boot/dts/lan966x.dtsi
+++ b/arch/arm/boot/dts/lan966x.dtsi
@@ -547,13 +547,13 @@ mdio1: mdio@e200413c {
 
 			phy0: ethernet-phy@1 {
 				reg = <1>;
-				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			phy1: ethernet-phy@2 {
 				reg = <2>;
-				interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 		};
-- 
2.33.0

