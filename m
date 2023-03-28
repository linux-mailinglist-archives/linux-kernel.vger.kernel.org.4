Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C487D6CC6C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbjC1PlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbjC1Pko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:40:44 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4A986AC;
        Tue, 28 Mar 2023 08:39:37 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SE1LA6016212;
        Tue, 28 Mar 2023 17:38:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=eQMMwdgtbCFYg6RdDX7MRzsB4HskdJ9yFYqsMjdrGSM=;
 b=Lpb68G+T712ZWpf2lQ9iX6airbyfNaUsX5TDEinSF0mafdRw1gGz5ipFKdmPDCiZzZRx
 pwWlbxJiMq+XdDRIqBUSZX/nt0NemkHHKC/kKR65OEui038BPjtNT+g1ca0hoCRWWXGg
 HFHYaTtYoXCzKKC6iv51/CtaTR9ZoNbDOoddBbrzhZXzYzstM8NKm+9uGb3b1n9tWiyW
 MN/wLEQusQkaTyeeZFxwYBOPPcl0oOAfbFh66XrJvm7BfUNxBSbWeKlebmhfsbMwr+Gv
 rRmcNKc1c2i9nUKrYI+y6sQViWUCu7e+vEcLSJN1k6zcInJKtMi/292S0AhGn9e2JbZ2 bQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pkwvsaate-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 17:38:40 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 32A6610002A;
        Tue, 28 Mar 2023 17:38:40 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2BD542194F6;
        Tue, 28 Mar 2023 17:38:40 +0200 (CEST)
Received: from localhost (10.201.20.168) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 28 Mar
 2023 17:38:39 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/6] ARM: dts: stm32: add pins for usart2/1/4/8 in stm32mp13-pinctrl
Date:   Tue, 28 Mar 2023 17:37:22 +0200
Message-ID: <20230328153723.498672-6-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328153723.498672-1-valentin.caron@foss.st.com>
References: <20230328153723.498672-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pins for uart4, uart8, usart1 and usart2 in stm32mp13-pinctrl.dtsi
Theses pins have three states: default, sleep and idle.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 arch/arm/boot/dts/stm32mp13-pinctrl.dtsi | 129 +++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp13-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp13-pinctrl.dtsi
index b2dce3a29f39..27e0c3826789 100644
--- a/arch/arm/boot/dts/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp13-pinctrl.dtsi
@@ -258,4 +258,133 @@ pins2 {
 			bias-disable;
 		};
 	};
+
+	uart4_idle_pins_a: uart4-idle-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('D', 6, ANALOG)>; /* UART4_TX */
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('D', 8, AF8)>; /* UART4_RX */
+			bias-disable;
+		};
+	};
+
+	uart4_sleep_pins_a: uart4-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 6, ANALOG)>, /* UART4_TX */
+				 <STM32_PINMUX('D', 8, ANALOG)>; /* UART4_RX */
+		};
+	};
+
+	uart8_pins_a: uart8-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('E', 1, AF8)>; /* UART8_TX */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('F', 9, AF8)>; /* UART8_RX */
+			bias-pull-up;
+		};
+	};
+
+	uart8_idle_pins_a: uart8-idle-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('E', 1, ANALOG)>; /* UART8_TX */
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('F', 9, AF8)>; /* UART8_RX */
+			bias-pull-up;
+		};
+	};
+
+	uart8_sleep_pins_a: uart8-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('E', 1, ANALOG)>, /* UART8_TX */
+				 <STM32_PINMUX('F', 9, ANALOG)>; /* UART8_RX */
+		};
+	};
+
+	usart1_pins_a: usart1-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('C', 0, AF7)>, /* USART1_TX */
+				 <STM32_PINMUX('C', 2, AF7)>; /* USART1_RTS */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('B', 0, AF4)>, /* USART1_RX */
+				 <STM32_PINMUX('A', 7, AF7)>; /* USART1_CTS_NSS */
+			bias-pull-up;
+		};
+	};
+
+	usart1_idle_pins_a: usart1-idle-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('C', 0, ANALOG)>, /* USART1_TX */
+				 <STM32_PINMUX('A', 7, ANALOG)>; /* USART1_CTS_NSS */
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('C', 2, AF7)>; /* USART1_RTS */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins3 {
+			pinmux = <STM32_PINMUX('B', 0, AF4)>; /* USART1_RX */
+			bias-pull-up;
+		};
+	};
+
+	usart1_sleep_pins_a: usart1-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('C', 0, ANALOG)>, /* USART1_TX */
+				 <STM32_PINMUX('C', 2, ANALOG)>, /* USART1_RTS */
+				 <STM32_PINMUX('A', 7, ANALOG)>, /* USART1_CTS_NSS */
+				 <STM32_PINMUX('B', 0, ANALOG)>; /* USART1_RX */
+		};
+	};
+
+	usart2_pins_a: usart2-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('H', 12, AF1)>, /* USART2_TX */
+				 <STM32_PINMUX('D', 4, AF3)>; /* USART2_RTS */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('D', 15, AF1)>, /* USART2_RX */
+				 <STM32_PINMUX('E', 11, AF2)>; /* USART2_CTS_NSS */
+			bias-disable;
+		};
+	};
+
+	usart2_idle_pins_a: usart2-idle-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('H', 12, ANALOG)>, /* USART2_TX */
+				 <STM32_PINMUX('E', 11, ANALOG)>; /* USART2_CTS_NSS */
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('D', 4, AF3)>; /* USART2_RTS */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins3 {
+			pinmux = <STM32_PINMUX('D', 15, AF1)>; /* USART2_RX */
+			bias-disable;
+		};
+	};
+
+	usart2_sleep_pins_a: usart2-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('H', 12, ANALOG)>, /* USART2_TX */
+				 <STM32_PINMUX('D', 4, ANALOG)>, /* USART2_RTS */
+				 <STM32_PINMUX('D', 15, ANALOG)>, /* USART2_RX */
+				 <STM32_PINMUX('E', 11, ANALOG)>; /* USART2_CTS_NSS */
+		};
+	};
 };
-- 
2.25.1

