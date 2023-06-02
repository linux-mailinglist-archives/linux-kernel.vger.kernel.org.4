Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF51720361
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbjFBNal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbjFBNag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:30:36 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E2D1BF;
        Fri,  2 Jun 2023 06:30:24 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352CA3lF024389;
        Fri, 2 Jun 2023 15:30:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=rnTbMuo/1jJs6mK/nl6na6mbvzEbR5GcstyhUqWiTwQ=;
 b=bsRAahngGbqkRmpVxwegdu0uU6zSCJVSlRUzIvLpNUt4MENAh5eQilQHvDzuhZQ/th8/
 +pvFe5LhBVbn0/KKTwTBaVE6Gu1/Il3D18pIVyEHap4e+wGPiUH1LHXn8Iv42TckGKP4
 f0wNMF+AP4kJRbPBtC61cIze2czHOxxdqqnNUVqjUpCy6w9Pc6FufLTWQiuOXTJgJCIG
 dhXEwTBNv3T/FtneWk4xYQ2I0QF5+S2SFfuoDgXJ6qikvlbB6tlVlo4Z5nZ/s2tS6wiA
 jEtTIE/5aGJcpCfLERkqD7GEygsQ08mdF2QrMNhpudGa8lqwXwoFJYPJz8NSWjcXaWee ug== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qyc08a226-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 15:30:12 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C280C10002A;
        Fri,  2 Jun 2023 15:30:11 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B91AC23694A;
        Fri,  2 Jun 2023 15:30:11 +0200 (CEST)
Received: from localhost (10.201.21.93) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 2 Jun
 2023 15:30:11 +0200
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, <soc@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: [PATCH v2 08/10] arm64: dts: st: add stm32mp257f-ev1 board support
Date:   Fri, 2 Jun 2023 15:28:57 +0200
Message-ID: <20230602132859.16442-9-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230602132859.16442-1-alexandre.torgue@foss.st.com>
References: <20230602132859.16442-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_10,2023-06-02_02,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add STM32MP257F Evaluation board support. It embeds a STM32MP257FAI SoC,
with 4GB of DDR4, TSN switch (2+1 ports), 2*USB typeA, 1*USB2 typeC,
SNOR OctoSPI, mini PCIe, STPMIC2 for power distribution ...

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 7b107fa7414b..30dd6347a929 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -27,6 +27,7 @@ subdir-y += renesas
 subdir-y += rockchip
 subdir-y += socionext
 subdir-y += sprd
+subdir-y += st
 subdir-y += synaptics
 subdir-y += tesla
 subdir-y += ti
diff --git a/arch/arm64/boot/dts/st/Makefile b/arch/arm64/boot/dts/st/Makefile
new file mode 100644
index 000000000000..881fe1296c58
--- /dev/null
+++ b/arch/arm64/boot/dts/st/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+dtb-$(CONFIG_ARCH_STM32) += stm32mp257f-ev1.dtb
diff --git a/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi b/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
index 5bd27767fbf5..d34a1d5e79c0 100644
--- a/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
@@ -5,3 +5,34 @@
  */
 #include <dt-bindings/pinctrl/stm32-pinfunc.h>
 
+&pinctrl {
+	usart2_pins_a: usart2-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('A', 4, AF6)>; /* USART2_TX */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('A', 8, AF8)>; /* USART2_RX */
+			bias-disable;
+		};
+	};
+
+	usart2_idle_pins_a: usart2-idle-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('A', 4, ANALOG)>; /* USART2_TX */
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('A', 8, AF8)>; /* USART2_RX */
+			bias-disable;
+		};
+	};
+
+	usart2_sleep_pins_a: usart2-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 4, ANALOG)>, /* USART2_TX */
+				 <STM32_PINMUX('A', 8, ANALOG)>; /* USART2_RX */
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
new file mode 100644
index 000000000000..39b4726cc098
--- /dev/null
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
+/*
+ * Copyright (C) STMicroelectronics 2023 - All Rights Reserved
+ * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
+ */
+
+/dts-v1/;
+
+#include "stm32mp257.dtsi"
+#include "stm32mp25xf.dtsi"
+#include "stm32mp25-pinctrl.dtsi"
+#include "stm32mp25xxai-pinctrl.dtsi"
+
+/ {
+	model = "STMicroelectronics STM32MP257F-EV1 Evaluation Board";
+	compatible = "st,stm32mp257f-ev1", "st,stm32mp257";
+
+	aliases {
+		serial0 = &usart2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x1 0x0>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		fw@80000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x80000000 0x0 0x4000000>;
+			no-map;
+		};
+	};
+};
+
+&usart2 {
+	pinctrl-names = "default", "idle", "sleep";
+	pinctrl-0 = <&usart2_pins_a>;
+	pinctrl-1 = <&usart2_idle_pins_a>;
+	pinctrl-2 = <&usart2_sleep_pins_a>;
+	status = "okay";
+};
-- 
2.17.1

