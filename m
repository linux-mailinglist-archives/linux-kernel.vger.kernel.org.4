Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728C35EFAFA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbiI2QgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbiI2QgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:36:09 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1550C26F5;
        Thu, 29 Sep 2022 09:36:04 -0700 (PDT)
X-QQ-mid: bizesmtp68t1664469353ty2iuuyk
Received: from localhost.localdomain ( [113.72.145.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Sep 2022 00:35:52 +0800 (CST)
X-QQ-SSF: 01000000002000303000B00A0000000
X-QQ-FEAT: 7Lv6dviieSRAp3JV0PxWTIUwBOkUOF4Jj1AKxT/tPj/UQ7gAZBgxuApzJJ3Py
        bnDJ+E0QXWRlSZ0/QxTaX6hTz3f6kupKwPCxalSlCb9bgnp7JNPzQDoBFIDppbC7pjsjaUm
        GPYk/Bk2isRY/NrMLQG0fAux+YW7UMbuonO71DmUvZdzqpcDIiwTHRwkTyDyFhZBFrqoCFj
        hUdfNwXpZFzENXCoZmFUKPEyqyv9W7Uzsxf+r0Osyk8gZpNbEHcgRLriJw/kDtr02lju07R
        Bc2nUwXZ0CnzqCI+7zA9hNc0LNi51sPZVB4Oj1ibTvIhyPZDpqkMJ40HyBwsnv/NvSCsfJU
        I0sqpEeYLEPwD8chPSKo2Ci4Jlyxskm5l5ixV/g+6mSAdNzS4A=
X-QQ-GoodBg: 0
From:   Hal Feng <hal.feng@linux.starfivetech.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 11/30] dt-bindings: reset: Add StarFive JH7110 reset definitions
Date:   Fri, 30 Sep 2022 00:35:47 +0800
Message-Id: <20220929163547.19211-1-hal.feng@linux.starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

Add resets for the StarFive JH7110 reset controller.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
---
 include/dt-bindings/reset/starfive-jh7110.h | 154 ++++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644 include/dt-bindings/reset/starfive-jh7110.h

diff --git a/include/dt-bindings/reset/starfive-jh7110.h b/include/dt-bindings/reset/starfive-jh7110.h
new file mode 100644
index 000000000000..512bd8834efb
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
+/* syscrg_rst */
+#define JH7110_SYSRST_JTAG2APB			  0
+#define JH7110_SYSRST_SYSCON			  1
+#define JH7110_SYSRST_IOMUX			  2
+#define JH7110_SYSRST_BUS			  3
+#define JH7110_SYSRST_DEBUG			  4
+#define JH7110_SYSRST_CORE0			  5
+#define JH7110_SYSRST_CORE1			  6
+#define JH7110_SYSRST_CORE2			  7
+#define JH7110_SYSRST_CORE3			  8
+#define JH7110_SYSRST_CORE4			  9
+#define JH7110_SYSRST_CORE0_ST			 10
+#define JH7110_SYSRST_CORE1_ST			 11
+#define JH7110_SYSRST_CORE2_ST			 12
+#define JH7110_SYSRST_CORE3_ST			 13
+#define JH7110_SYSRST_CORE4_ST			 14
+#define JH7110_SYSRST_TRACE0			 15
+#define JH7110_SYSRST_TRACE1			 16
+#define JH7110_SYSRST_TRACE2			 17
+#define JH7110_SYSRST_TRACE3			 18
+#define JH7110_SYSRST_TRACE4			 19
+#define JH7110_SYSRST_TRACE_COM			 20
+#define JH7110_SYSRST_GPU_APB			 21
+#define JH7110_SYSRST_GPU_DOMA			 22
+#define JH7110_SYSRST_NOC_BUS_APB_BUS		 23
+#define JH7110_SYSRST_NOC_BUS_AXICFG0_AXI	 24
+#define JH7110_SYSRST_NOC_BUS_CPU_AXI		 25
+#define JH7110_SYSRST_NOC_BUS_DISP_AXI		 26
+#define JH7110_SYSRST_NOC_BUS_GPU_AXI		 27
+#define JH7110_SYSRST_NOC_BUS_ISP_AXI		 28
+#define JH7110_SYSRST_NOC_BUS_DDRC		 29
+#define JH7110_SYSRST_NOC_BUS_STG_AXI		 30
+#define JH7110_SYSRST_NOC_BUS_VDEC_AXI		 31
+
+#define JH7110_SYSRST_NOC_BUS_VENC_AXI		 32
+#define JH7110_SYSRST_AXI_CFG1_DEC_AHB		 33
+#define JH7110_SYSRST_AXI_CFG1_DEC_MAIN		 34
+#define JH7110_SYSRST_AXI_CFG0_DEC_MAIN		 35
+#define JH7110_SYSRST_AXI_CFG0_DEC_MAIN_DIV	 36
+#define JH7110_SYSRST_AXI_CFG0_DEC_HIFI4	 37
+#define JH7110_SYSRST_DDR_AXI			 38
+#define JH7110_SYSRST_DDR_OSC			 39
+#define JH7110_SYSRST_DDR_APB			 40
+#define JH7110_SYSRST_DOM_ISP_TOP_N		 41
+#define JH7110_SYSRST_DOM_ISP_TOP_AXI		 42
+#define JH7110_SYSRST_DOM_VOUT_TOP_SRC		 43
+#define JH7110_SYSRST_CODAJ12_AXI		 44
+#define JH7110_SYSRST_CODAJ12_CORE		 45
+#define JH7110_SYSRST_CODAJ12_APB		 46
+#define JH7110_SYSRST_WAVE511_AXI		 47
+#define JH7110_SYSRST_WAVE511_BPU		 48
+#define JH7110_SYSRST_WAVE511_VCE		 49
+#define JH7110_SYSRST_WAVE511_APB		 50
+#define JH7110_SYSRST_VDEC_JPG_ARB_JPG		 51
+#define JH7110_SYSRST_VDEC_JPG_ARB_MAIN		 52
+#define JH7110_SYSRST_AXIMEM0_AXI		 53
+#define JH7110_SYSRST_WAVE420L_AXI		 54
+#define JH7110_SYSRST_WAVE420L_BPU		 55
+#define JH7110_SYSRST_WAVE420L_VCE		 56
+#define JH7110_SYSRST_WAVE420L_APB		 57
+#define JH7110_SYSRST_AXIMEM1_AXI		 58
+#define JH7110_SYSRST_AXIMEM2_AXI		 59
+#define JH7110_SYSRST_INTMEM			 60
+#define JH7110_SYSRST_QSPI_AHB			 61
+#define JH7110_SYSRST_QSPI_APB			 62
+#define JH7110_SYSRST_QSPI_REF			 63
+
+#define JH7110_SYSRST_SDIO0_AHB			 64
+#define JH7110_SYSRST_SDIO1_AHB			 65
+#define JH7110_SYSRST_GMAC1_AXI			 66
+#define JH7110_SYSRST_GMAC1_AHB			 67
+#define JH7110_SYSRST_MAILBOX			 68
+#define JH7110_SYSRST_SPI0_APB			 69
+#define JH7110_SYSRST_SPI1_APB			 70
+#define JH7110_SYSRST_SPI2_APB			 71
+#define JH7110_SYSRST_SPI3_APB			 72
+#define JH7110_SYSRST_SPI4_APB			 73
+#define JH7110_SYSRST_SPI5_APB			 74
+#define JH7110_SYSRST_SPI6_APB			 75
+#define JH7110_SYSRST_I2C0_APB			 76
+#define JH7110_SYSRST_I2C1_APB			 77
+#define JH7110_SYSRST_I2C2_APB			 78
+#define JH7110_SYSRST_I2C3_APB			 79
+#define JH7110_SYSRST_I2C4_APB			 80
+#define JH7110_SYSRST_I2C5_APB			 81
+#define JH7110_SYSRST_I2C6_APB			 82
+#define JH7110_SYSRST_UART0_APB			 83
+#define JH7110_SYSRST_UART0_CORE		 84
+#define JH7110_SYSRST_UART1_APB			 85
+#define JH7110_SYSRST_UART1_CORE		 86
+#define JH7110_SYSRST_UART2_APB			 87
+#define JH7110_SYSRST_UART2_CORE		 88
+#define JH7110_SYSRST_UART3_APB			 89
+#define JH7110_SYSRST_UART3_CORE		 90
+#define JH7110_SYSRST_UART4_APB			 91
+#define JH7110_SYSRST_UART4_CORE		 92
+#define JH7110_SYSRST_UART5_APB			 93
+#define JH7110_SYSRST_UART5_CORE		 94
+#define JH7110_SYSRST_SPDIF_APB			 95
+
+#define JH7110_SYSRST_PWMDAC_APB		 96
+#define JH7110_SYSRST_PDM_DMIC			 97
+#define JH7110_SYSRST_PDM_APB			 98
+#define JH7110_SYSRST_I2SRX_APB			 99
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
+/* aoncrg_rst */
+#define JH7110_AONRST_GMAC0_AXI		0
+#define JH7110_AONRST_GMAC0_AHB		1
+#define JH7110_AONRST_AON_IOMUX		2
+#define JH7110_AONRST_PMU_APB		3
+#define JH7110_AONRST_PMU_WKUP		4
+#define JH7110_AONRST_RTC_APB		5
+#define JH7110_AONRST_RTC_CAL		6
+#define JH7110_AONRST_RTC_32K		7
+
+#define	JH7110_AONRST_END		8
+
+#endif /* __DT_BINDINGS_RESET_STARFIVE_JH7110_H__ */
-- 
2.17.1

