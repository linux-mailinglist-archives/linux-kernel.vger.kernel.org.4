Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9882262EB33
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiKRBoi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Nov 2022 20:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240816AbiKRBo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:44:27 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5324C73B98;
        Thu, 17 Nov 2022 17:44:22 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 4DF5324E1BA;
        Fri, 18 Nov 2022 09:06:35 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 18 Nov
 2022 09:06:35 +0800
Received: from ubuntu.localdomain (183.27.96.116) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 18 Nov
 2022 09:06:34 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 08/14] dt-bindings: reset: Add StarFive JH7110 system and always-on reset definitions
Date:   Fri, 18 Nov 2022 09:06:21 +0800
Message-ID: <20221118010627.70576-9-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118010627.70576-1-hal.feng@starfivetech.com>
References: <20221118010627.70576-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.96.116]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

Add resets for the StarFive JH7110 system (SYS) and always-on (AON)
reset controller.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 MAINTAINERS                                 |   5 +-
 include/dt-bindings/reset/starfive-jh7110.h | 154 ++++++++++++++++++++
 2 files changed, 157 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/reset/starfive-jh7110.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e97dac9c0ee4..eeab26f5597c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19614,12 +19614,13 @@ F:	Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.yaml
 F:	drivers/pinctrl/starfive/
 F:	include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
 
-STARFIVE JH7100 RESET CONTROLLER DRIVERS
+STARFIVE RESET CONTROLLER DRIVERS
 M:	Emil Renner Berthing <kernel@esmil.dk>
+M:	Hal Feng <hal.feng@starfivetech.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
 F:	drivers/reset/starfive/
-F:	include/dt-bindings/reset/starfive-jh7100.h
+F:	include/dt-bindings/reset/starfive*
 
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
diff --git a/include/dt-bindings/reset/starfive-jh7110.h b/include/dt-bindings/reset/starfive-jh7110.h
new file mode 100644
index 000000000000..1a5bab671161
--- /dev/null
+++ b/include/dt-bindings/reset/starfive-jh7110.h
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright (C) 2021-2022 Emil Renner Berthing <kernel@esmil.dk>
+ */
+
+#ifndef __DT_BINDINGS_RESET_STARFIVE_JH7110_H__
+#define __DT_BINDINGS_RESET_STARFIVE_JH7110_H__
+
+/* SYSCRG resets */
+#define JH7110_SYSRST_JTAG2APB			0
+#define JH7110_SYSRST_SYSCON			1
+#define JH7110_SYSRST_IOMUX			2
+#define JH7110_SYSRST_BUS			3
+#define JH7110_SYSRST_DEBUG			4
+#define JH7110_SYSRST_CORE0			5
+#define JH7110_SYSRST_CORE1			6
+#define JH7110_SYSRST_CORE2			7
+#define JH7110_SYSRST_CORE3			8
+#define JH7110_SYSRST_CORE4			9
+#define JH7110_SYSRST_CORE0_ST			10
+#define JH7110_SYSRST_CORE1_ST			11
+#define JH7110_SYSRST_CORE2_ST			12
+#define JH7110_SYSRST_CORE3_ST			13
+#define JH7110_SYSRST_CORE4_ST			14
+#define JH7110_SYSRST_TRACE0			15
+#define JH7110_SYSRST_TRACE1			16
+#define JH7110_SYSRST_TRACE2			17
+#define JH7110_SYSRST_TRACE3			18
+#define JH7110_SYSRST_TRACE4			19
+#define JH7110_SYSRST_TRACE_COM			20
+#define JH7110_SYSRST_GPU_APB			21
+#define JH7110_SYSRST_GPU_DOMA			22
+#define JH7110_SYSRST_NOC_BUS_APB_BUS		23
+#define JH7110_SYSRST_NOC_BUS_AXICFG0_AXI	24
+#define JH7110_SYSRST_NOC_BUS_CPU_AXI		25
+#define JH7110_SYSRST_NOC_BUS_DISP_AXI		26
+#define JH7110_SYSRST_NOC_BUS_GPU_AXI		27
+#define JH7110_SYSRST_NOC_BUS_ISP_AXI		28
+#define JH7110_SYSRST_NOC_BUS_DDRC		29
+#define JH7110_SYSRST_NOC_BUS_STG_AXI		30
+#define JH7110_SYSRST_NOC_BUS_VDEC_AXI		31
+
+#define JH7110_SYSRST_NOC_BUS_VENC_AXI		32
+#define JH7110_SYSRST_AXI_CFG1_DEC_AHB		33
+#define JH7110_SYSRST_AXI_CFG1_DEC_MAIN		34
+#define JH7110_SYSRST_AXI_CFG0_DEC_MAIN		35
+#define JH7110_SYSRST_AXI_CFG0_DEC_MAIN_DIV	36
+#define JH7110_SYSRST_AXI_CFG0_DEC_HIFI4	37
+#define JH7110_SYSRST_DDR_AXI			38
+#define JH7110_SYSRST_DDR_OSC			39
+#define JH7110_SYSRST_DDR_APB			40
+#define JH7110_SYSRST_DOM_ISP_TOP_N		41
+#define JH7110_SYSRST_DOM_ISP_TOP_AXI		42
+#define JH7110_SYSRST_DOM_VOUT_TOP_SRC		43
+#define JH7110_SYSRST_CODAJ12_AXI		44
+#define JH7110_SYSRST_CODAJ12_CORE		45
+#define JH7110_SYSRST_CODAJ12_APB		46
+#define JH7110_SYSRST_WAVE511_AXI		47
+#define JH7110_SYSRST_WAVE511_BPU		48
+#define JH7110_SYSRST_WAVE511_VCE		49
+#define JH7110_SYSRST_WAVE511_APB		50
+#define JH7110_SYSRST_VDEC_JPG_ARB_JPG		51
+#define JH7110_SYSRST_VDEC_JPG_ARB_MAIN		52
+#define JH7110_SYSRST_AXIMEM0_AXI		53
+#define JH7110_SYSRST_WAVE420L_AXI		54
+#define JH7110_SYSRST_WAVE420L_BPU		55
+#define JH7110_SYSRST_WAVE420L_VCE		56
+#define JH7110_SYSRST_WAVE420L_APB		57
+#define JH7110_SYSRST_AXIMEM1_AXI		58
+#define JH7110_SYSRST_AXIMEM2_AXI		59
+#define JH7110_SYSRST_INTMEM			60
+#define JH7110_SYSRST_QSPI_AHB			61
+#define JH7110_SYSRST_QSPI_APB			62
+#define JH7110_SYSRST_QSPI_REF			63
+
+#define JH7110_SYSRST_SDIO0_AHB			64
+#define JH7110_SYSRST_SDIO1_AHB			65
+#define JH7110_SYSRST_GMAC1_AXI			66
+#define JH7110_SYSRST_GMAC1_AHB			67
+#define JH7110_SYSRST_MAILBOX			68
+#define JH7110_SYSRST_SPI0_APB			69
+#define JH7110_SYSRST_SPI1_APB			70
+#define JH7110_SYSRST_SPI2_APB			71
+#define JH7110_SYSRST_SPI3_APB			72
+#define JH7110_SYSRST_SPI4_APB			73
+#define JH7110_SYSRST_SPI5_APB			74
+#define JH7110_SYSRST_SPI6_APB			75
+#define JH7110_SYSRST_I2C0_APB			76
+#define JH7110_SYSRST_I2C1_APB			77
+#define JH7110_SYSRST_I2C2_APB			78
+#define JH7110_SYSRST_I2C3_APB			79
+#define JH7110_SYSRST_I2C4_APB			80
+#define JH7110_SYSRST_I2C5_APB			81
+#define JH7110_SYSRST_I2C6_APB			82
+#define JH7110_SYSRST_UART0_APB			83
+#define JH7110_SYSRST_UART0_CORE		84
+#define JH7110_SYSRST_UART1_APB			85
+#define JH7110_SYSRST_UART1_CORE		86
+#define JH7110_SYSRST_UART2_APB			87
+#define JH7110_SYSRST_UART2_CORE		88
+#define JH7110_SYSRST_UART3_APB			89
+#define JH7110_SYSRST_UART3_CORE		90
+#define JH7110_SYSRST_UART4_APB			91
+#define JH7110_SYSRST_UART4_CORE		92
+#define JH7110_SYSRST_UART5_APB			93
+#define JH7110_SYSRST_UART5_CORE		94
+#define JH7110_SYSRST_SPDIF_APB			95
+
+#define JH7110_SYSRST_PWMDAC_APB		96
+#define JH7110_SYSRST_PDM_DMIC			97
+#define JH7110_SYSRST_PDM_APB			98
+#define JH7110_SYSRST_I2SRX_APB			99
+#define JH7110_SYSRST_I2SRX_BCLK		100
+#define JH7110_SYSRST_I2STX0_APB		101
+#define JH7110_SYSRST_I2STX0_BCLK		102
+#define JH7110_SYSRST_I2STX1_APB		103
+#define JH7110_SYSRST_I2STX1_BCLK		104
+#define JH7110_SYSRST_TDM_AHB			105
+#define JH7110_SYSRST_TDM_CORE			106
+#define JH7110_SYSRST_TDM_APB			107
+#define JH7110_SYSRST_PWM_APB			108
+#define JH7110_SYSRST_WDT_APB			109
+#define JH7110_SYSRST_WDT_CORE			110
+#define JH7110_SYSRST_CAN0_APB			111
+#define JH7110_SYSRST_CAN0_CORE			112
+#define JH7110_SYSRST_CAN0_TIMER		113
+#define JH7110_SYSRST_CAN1_APB			114
+#define JH7110_SYSRST_CAN1_CORE			115
+#define JH7110_SYSRST_CAN1_TIMER		116
+#define JH7110_SYSRST_TIMER_APB			117
+#define JH7110_SYSRST_TIMER0			118
+#define JH7110_SYSRST_TIMER1			119
+#define JH7110_SYSRST_TIMER2			120
+#define JH7110_SYSRST_TIMER3			121
+#define JH7110_SYSRST_INT_CTRL_APB		122
+#define JH7110_SYSRST_TEMP_APB			123
+#define JH7110_SYSRST_TEMP_CORE			124
+#define JH7110_SYSRST_JTAG_CERTIFICATION	125
+
+#define	JH7110_SYSRST_END			126
+
+/* AONCRG resets */
+#define JH7110_AONRST_GMAC0_AXI			0
+#define JH7110_AONRST_GMAC0_AHB			1
+#define JH7110_AONRST_AON_IOMUX			2
+#define JH7110_AONRST_PMU_APB			3
+#define JH7110_AONRST_PMU_WKUP			4
+#define JH7110_AONRST_RTC_APB			5
+#define JH7110_AONRST_RTC_CAL			6
+#define JH7110_AONRST_RTC_32K			7
+
+#define	JH7110_AONRST_END			8
+
+#endif /* __DT_BINDINGS_RESET_STARFIVE_JH7110_H__ */
-- 
2.38.1

