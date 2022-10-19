Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9713603AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 09:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiJSHrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 03:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiJSHr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:47:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8DA6CD02;
        Wed, 19 Oct 2022 00:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666165642; x=1697701642;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LypfmRLZezRvZ80PtilHRfcQRqUmEX2LdxRqHmA8vmo=;
  b=LbEr/IucazeVVhSvh4fpj3cdS6tQwJ6ZbMBdT2cNAC7rBS+bYZMYikBV
   j99HqVlQLwvBj6+kEfAaVdwQy8C9kQx5VEzrq7PMvFsIq+CEcEqhsohCu
   YwaqaTwjVx9Lpkj4P9AYCKAug7J2rmLis19OHqi79UM1EU+Do1skboZbb
   JLeb0tYHksS6yTDd3hkV0xyQa4eyb/zp0koSzmHQardZxMoGQg2U0Tpe/
   IurnXWjvoA+hbr6GFzkjLQBmlJfoel3f0r7xAgXxhX4F9W/99gq9qXa5A
   sRIPX1r8tc2IkOWyu1tVzI3GBuN9LYP28TflVEsf6zkHHeXUq8sZZ/OxP
   w==;
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="196077013"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Oct 2022 00:47:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 19 Oct 2022 00:47:21 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 19 Oct 2022 00:47:20 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <claudiu.beznea@microchip.com>, <nicolas.ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH] ARM: dts: lan966x: Enable sgpio on pcb8291
Date:   Wed, 19 Oct 2022 09:51:54 +0200
Message-ID: <20221019075154.2555054-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable sgpio node on pcb8291 as this is needed to be able to control
the LEDs on this board. Otherwise the LEDs support on the board will
not be available.
On the other board pcb8309 the sgpio is already enabled because it
needed to access the SFP ports.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 arch/arm/boot/dts/lan966x-pcb8291.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x-pcb8291.dts b/arch/arm/boot/dts/lan966x-pcb8291.dts
index f4f054cdf2a87..3a3d76af86122 100644
--- a/arch/arm/boot/dts/lan966x-pcb8291.dts
+++ b/arch/arm/boot/dts/lan966x-pcb8291.dts
@@ -69,6 +69,12 @@ can0_b_pins:  can0-b-pins {
 		pins = "GPIO_35", "GPIO_36";
 		function = "can0_b";
 	};
+
+	sgpio_a_pins: sgpio-a-pins {
+		/* SCK, D0, D1, LD */
+		pins = "GPIO_32", "GPIO_33", "GPIO_34", "GPIO_35";
+		function = "sgpio_a";
+	};
 };
 
 &can0 {
@@ -118,6 +124,20 @@ &serdes {
 	status = "okay";
 };
 
+&sgpio {
+	pinctrl-0 = <&sgpio_a_pins>;
+	pinctrl-names = "default";
+	microchip,sgpio-port-ranges = <0 3>, <8 11>;
+	status = "okay";
+
+	gpio@0 {
+		ngpios = <64>;
+	};
+	gpio@1 {
+		ngpios = <64>;
+	};
+};
+
 &switch {
 	status = "okay";
 };
-- 
2.38.0

