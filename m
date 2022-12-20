Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8C1651773
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 01:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbiLTAzk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Dec 2022 19:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiLTAzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 19:55:35 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF8A164B4;
        Mon, 19 Dec 2022 16:55:33 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 0526024E17F;
        Tue, 20 Dec 2022 08:55:32 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 20 Dec
 2022 08:55:31 +0800
Received: from ubuntu.localdomain (183.27.97.120) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 20 Dec
 2022 08:55:31 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
CC:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/5] riscv: dts: starfive: Add StarFive JH7110 pin function definitions
Date:   Tue, 20 Dec 2022 08:55:25 +0800
Message-ID: <20221220005529.34744-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221220005529.34744-1-hal.feng@starfivetech.com>
References: <20221220005529.34744-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.120]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianlong Huang <jianlong.huang@starfivetech.com>

Add pin function definitions for StarFive JH7110 SoC.

Co-developed-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 MAINTAINERS                                   |   4 +-
 arch/riscv/boot/dts/starfive/jh7110-pinfunc.h | 308 ++++++++++++++++++
 2 files changed, 311 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-pinfunc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7916f2fb7619..e0ffe584030b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19640,11 +19640,13 @@ F:	Documentation/devicetree/bindings/clock/starfive,jh71*.yaml
 F:	drivers/clk/starfive/clk-starfive-jh71*
 F:	include/dt-bindings/clock/starfive?jh71*.h
 
-STARFIVE JH7100 PINCTRL DRIVER
+STARFIVE JH71X0 PINCTRL DRIVERS
 M:	Emil Renner Berthing <kernel@esmil.dk>
+M:	Jianlong Huang <jianlong.huang@starfivetech.com>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.yaml
+F:	arch/riscv/boot/dts/starfive/jh7110-pinfunc.h
 F:	drivers/pinctrl/starfive/
 F:	include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
 
diff --git a/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h b/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h
new file mode 100644
index 000000000000..8e684d63a916
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h
@@ -0,0 +1,308 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ */
+
+#ifndef __JH7110_PINFUNC_H__
+#define __JH7110_PINFUNC_H__
+
+/*
+ * mux bits:
+ *  | 31 - 24 | 23 - 16 | 15 - 10 |  9 - 8   |  7 - 0  |
+ *  |  din    |  dout   |  doen   | function | gpio nr |
+ *
+ * dout:     output signal
+ * doen:     output enable signal
+ * din:      optional input signal, 0xff = none
+ * function:
+ * gpio nr:  gpio number, 0 - 63
+ */
+#define GPIOMUX(n, dout, doen, din) ( \
+		(((din)  & 0xff) << 24) | \
+		(((dout) & 0xff) << 16) | \
+		(((doen) & 0x3f) << 10) | \
+		((n) & 0x3f))
+
+#define PINMUX(n, func) ((1 << 10) | (((func) & 0x3) << 8) | ((n) & 0xff))
+
+/* sys_iomux dout */
+#define GPOUT_LOW				0
+#define GPOUT_HIGH				1
+#define GPOUT_SYS_WAVE511_UART_TX		2
+#define GPOUT_SYS_CAN0_STBY			3
+#define GPOUT_SYS_CAN0_TST_NEXT_BIT		4
+#define GPOUT_SYS_CAN0_TST_SAMPLE_POINT		5
+#define GPOUT_SYS_CAN0_TXD			6
+#define GPOUT_SYS_USB_DRIVE_VBUS		7
+#define GPOUT_SYS_QSPI_CS1			8
+#define GPOUT_SYS_SPDIF				9
+#define GPOUT_SYS_HDMI_CEC_SDA			10
+#define GPOUT_SYS_HDMI_DDC_SCL			11
+#define GPOUT_SYS_HDMI_DDC_SDA			12
+#define GPOUT_SYS_WATCHDOG			13
+#define GPOUT_SYS_I2C0_CLK			14
+#define GPOUT_SYS_I2C0_DATA			15
+#define GPOUT_SYS_SDIO0_BACK_END_POWER		16
+#define GPOUT_SYS_SDIO0_CARD_POWER_EN		17
+#define GPOUT_SYS_SDIO0_CCMD_OD_PULLUP_EN	18
+#define GPOUT_SYS_SDIO0_RST			19
+#define GPOUT_SYS_UART0_TX			20
+#define GPOUT_SYS_HIFI4_JTAG_TDO		21
+#define GPOUT_SYS_JTAG_TDO			22
+#define GPOUT_SYS_PDM_MCLK			23
+#define GPOUT_SYS_PWM_CHANNEL0			24
+#define GPOUT_SYS_PWM_CHANNEL1			25
+#define GPOUT_SYS_PWM_CHANNEL2			26
+#define GPOUT_SYS_PWM_CHANNEL3			27
+#define GPOUT_SYS_PWMDAC_LEFT			28
+#define GPOUT_SYS_PWMDAC_RIGHT			29
+#define GPOUT_SYS_SPI0_CLK			30
+#define GPOUT_SYS_SPI0_FSS			31
+#define GPOUT_SYS_SPI0_TXD			32
+#define GPOUT_SYS_GMAC_PHYCLK			33
+#define GPOUT_SYS_I2SRX_BCLK			34
+#define GPOUT_SYS_I2SRX_LRCK			35
+#define GPOUT_SYS_I2STX0_BCLK			36
+#define GPOUT_SYS_I2STX0_LRCK			37
+#define GPOUT_SYS_MCLK				38
+#define GPOUT_SYS_TDM_CLK			39
+#define GPOUT_SYS_TDM_SYNC			40
+#define GPOUT_SYS_TDM_TXD			41
+#define GPOUT_SYS_TRACE_DATA0			42
+#define GPOUT_SYS_TRACE_DATA1			43
+#define GPOUT_SYS_TRACE_DATA2			44
+#define GPOUT_SYS_TRACE_DATA3			45
+#define GPOUT_SYS_TRACE_REF			46
+#define GPOUT_SYS_CAN1_STBY			47
+#define GPOUT_SYS_CAN1_TST_NEXT_BIT		48
+#define GPOUT_SYS_CAN1_TST_SAMPLE_POINT		49
+#define GPOUT_SYS_CAN1_TXD			50
+#define GPOUT_SYS_I2C1_CLK			51
+#define GPOUT_SYS_I2C1_DATA			52
+#define GPOUT_SYS_SDIO1_BACK_END_POWER		53
+#define GPOUT_SYS_SDIO1_CARD_POWER_EN		54
+#define GPOUT_SYS_SDIO1_CLK			55
+#define GPOUT_SYS_SDIO1_CMD_OD_PULLUP_EN	56
+#define GPOUT_SYS_SDIO1_CMD			57
+#define GPOUT_SYS_SDIO1_DATA0			58
+#define GPOUT_SYS_SDIO1_DATA1			59
+#define GPOUT_SYS_SDIO1_DATA2			60
+#define GPOUT_SYS_SDIO1_DATA3			61
+#define GPOUT_SYS_SDIO1_DATA4			63
+#define GPOUT_SYS_SDIO1_DATA5			63
+#define GPOUT_SYS_SDIO1_DATA6			64
+#define GPOUT_SYS_SDIO1_DATA7			65
+#define GPOUT_SYS_SDIO1_RST			66
+#define GPOUT_SYS_UART1_RTS			67
+#define GPOUT_SYS_UART1_TX			68
+#define GPOUT_SYS_I2STX1_SDO0			69
+#define GPOUT_SYS_I2STX1_SDO1			70
+#define GPOUT_SYS_I2STX1_SDO2			71
+#define GPOUT_SYS_I2STX1_SDO3			72
+#define GPOUT_SYS_SPI1_CLK			73
+#define GPOUT_SYS_SPI1_FSS			74
+#define GPOUT_SYS_SPI1_TXD			75
+#define GPOUT_SYS_I2C2_CLK			76
+#define GPOUT_SYS_I2C2_DATA			77
+#define GPOUT_SYS_UART2_RTS			78
+#define GPOUT_SYS_UART2_TX			79
+#define GPOUT_SYS_SPI2_CLK			80
+#define GPOUT_SYS_SPI2_FSS			81
+#define GPOUT_SYS_SPI2_TXD			82
+#define GPOUT_SYS_I2C3_CLK			83
+#define GPOUT_SYS_I2C3_DATA			84
+#define GPOUT_SYS_UART3_TX			85
+#define GPOUT_SYS_SPI3_CLK			86
+#define GPOUT_SYS_SPI3_FSS			87
+#define GPOUT_SYS_SPI3_TXD			88
+#define GPOUT_SYS_I2C4_CLK			89
+#define GPOUT_SYS_I2C4_DATA			90
+#define GPOUT_SYS_UART4_RTS			91
+#define GPOUT_SYS_UART4_TX			92
+#define GPOUT_SYS_SPI4_CLK			93
+#define GPOUT_SYS_SPI4_FSS			94
+#define GPOUT_SYS_SPI4_TXD			95
+#define GPOUT_SYS_I2C5_CLK			96
+#define GPOUT_SYS_I2C5_DATA			97
+#define GPOUT_SYS_UART5_RTS			98
+#define GPOUT_SYS_UART5_TX			99
+#define GPOUT_SYS_SPI5_CLK			100
+#define GPOUT_SYS_SPI5_FSS			101
+#define GPOUT_SYS_SPI5_TXD			102
+#define GPOUT_SYS_I2C6_CLK			103
+#define GPOUT_SYS_I2C6_DATA			104
+#define GPOUT_SYS_SPI6_CLK			105
+#define GPOUT_SYS_SPI6_FSS			106
+#define GPOUT_SYS_SPI6_TXD			107
+
+/* aon_iomux dout */
+#define GPOUT_AON_CLK_32K_OUT			2
+#define GPOUT_AON_PTC0_PWM4			3
+#define GPOUT_AON_PTC0_PWM5			4
+#define GPOUT_AON_PTC0_PWM6			5
+#define GPOUT_AON_PTC0_PWM7			6
+#define GPOUT_AON_CLK_GCLK0			7
+#define GPOUT_AON_CLK_GCLK1			8
+#define GPOUT_AON_CLK_GCLK2			9
+
+/* sys_iomux doen */
+#define GPOEN_ENABLE				0
+#define GPOEN_DISABLE				1
+#define GPOEN_SYS_HDMI_CEC_SDA			2
+#define GPOEN_SYS_HDMI_DDC_SCL			3
+#define GPOEN_SYS_HDMI_DDC_SDA			4
+#define GPOEN_SYS_I2C0_CLK			5
+#define GPOEN_SYS_I2C0_DATA			6
+#define GPOEN_SYS_HIFI4_JTAG_TDO		7
+#define GPOEN_SYS_JTAG_TDO			8
+#define GPOEN_SYS_PWM0_CHANNEL0			9
+#define GPOEN_SYS_PWM0_CHANNEL1			10
+#define GPOEN_SYS_PWM0_CHANNEL2			11
+#define GPOEN_SYS_PWM0_CHANNEL3			12
+#define GPOEN_SYS_SPI0_NSSPCTL			13
+#define GPOEN_SYS_SPI0_NSSP			14
+#define GPOEN_SYS_TDM_SYNC			15
+#define GPOEN_SYS_TDM_TXD			16
+#define GPOEN_SYS_I2C1_CLK			17
+#define GPOEN_SYS_I2C1_DATA			18
+#define GPOEN_SYS_SDIO1_CMD			19
+#define GPOEN_SYS_SDIO1_DATA0			20
+#define GPOEN_SYS_SDIO1_DATA1			21
+#define GPOEN_SYS_SDIO1_DATA2			22
+#define GPOEN_SYS_SDIO1_DATA3			23
+#define GPOEN_SYS_SDIO1_DATA4			24
+#define GPOEN_SYS_SDIO1_DATA5			25
+#define GPOEN_SYS_SDIO1_DATA6			26
+#define GPOEN_SYS_SDIO1_DATA7			27
+#define GPOEN_SYS_SPI1_NSSPCTL			28
+#define GPOEN_SYS_SPI1_NSSP			29
+#define GPOEN_SYS_I2C2_CLK			30
+#define GPOEN_SYS_I2C2_DATA			31
+#define GPOEN_SYS_SPI2_NSSPCTL			32
+#define GPOEN_SYS_SPI2_NSSP			33
+#define GPOEN_SYS_I2C3_CLK			34
+#define GPOEN_SYS_I2C3_DATA			35
+#define GPOEN_SYS_SPI3_NSSPCTL			36
+#define GPOEN_SYS_SPI3_NSSP			37
+#define GPOEN_SYS_I2C4_CLK			38
+#define GPOEN_SYS_I2C4_DATA			39
+#define GPOEN_SYS_SPI4_NSSPCTL			40
+#define GPOEN_SYS_SPI4_NSSP			41
+#define GPOEN_SYS_I2C5_CLK			42
+#define GPOEN_SYS_I2C5_DATA			43
+#define GPOEN_SYS_SPI5_NSSPCTL			44
+#define GPOEN_SYS_SPI5_NSSP			45
+#define GPOEN_SYS_I2C6_CLK			46
+#define GPOEN_SYS_I2C6_DATA			47
+#define GPOEN_SYS_SPI6_NSSPCTL			48
+#define GPOEN_SYS_SPI6_NSSP			49
+
+/* aon_iomux doen */
+#define GPOEN_AON_PTC0_OE_N_4			2
+#define GPOEN_AON_PTC0_OE_N_5			3
+#define GPOEN_AON_PTC0_OE_N_6			4
+#define GPOEN_AON_PTC0_OE_N_7			5
+
+/* sys_iomux gin */
+#define GPI_NONE				255
+
+#define GPI_SYS_WAVE511_UART_RX			0
+#define GPI_SYS_CAN0_RXD			1
+#define GPI_SYS_USB_OVERCURRENT			2
+#define GPI_SYS_SPDIF				3
+#define GPI_SYS_JTAG_RST			4
+#define GPI_SYS_HDMI_CEC_SDA			5
+#define GPI_SYS_HDMI_DDC_SCL			6
+#define GPI_SYS_HDMI_DDC_SDA			7
+#define GPI_SYS_HDMI_HPD			8
+#define GPI_SYS_I2C0_CLK			9
+#define GPI_SYS_I2C0_DATA			10
+#define GPI_SYS_SDIO0_CD			11
+#define GPI_SYS_SDIO0_INT			12
+#define GPI_SYS_SDIO0_WP			13
+#define GPI_SYS_UART0_RX			14
+#define GPI_SYS_HIFI4_JTAG_TCK			15
+#define GPI_SYS_HIFI4_JTAG_TDI			16
+#define GPI_SYS_HIFI4_JTAG_TMS			17
+#define GPI_SYS_HIFI4_JTAG_RST			18
+#define GPI_SYS_JTAG_TDI			19
+#define GPI_SYS_JTAG_TMS			20
+#define GPI_SYS_PDM_DMIC0			21
+#define GPI_SYS_PDM_DMIC1			22
+#define GPI_SYS_I2SRX_SDIN0			23
+#define GPI_SYS_I2SRX_SDIN1			24
+#define GPI_SYS_I2SRX_SDIN2			25
+#define GPI_SYS_SPI0_CLK			26
+#define GPI_SYS_SPI0_FSS			27
+#define GPI_SYS_SPI0_RXD			28
+#define GPI_SYS_JTAG_TCK			29
+#define GPI_SYS_MCLK_EXT			30
+#define GPI_SYS_I2SRX_BCLK			31
+#define GPI_SYS_I2SRX_LRCK			32
+#define GPI_SYS_I2STX0_BCLK			33
+#define GPI_SYS_I2STX0_LRCK			34
+#define GPI_SYS_TDM_CLK				35
+#define GPI_SYS_TDM_RXD				36
+#define GPI_SYS_TDM_SYNC			37
+#define GPI_SYS_CAN1_RXD			38
+#define GPI_SYS_I2C1_CLK			39
+#define GPI_SYS_I2C1_DATA			40
+#define GPI_SYS_SDIO1_CD			41
+#define GPI_SYS_SDIO1_INT			42
+#define GPI_SYS_SDIO1_WP			43
+#define GPI_SYS_SDIO1_CMD			44
+#define GPI_SYS_SDIO1_DATA0			45
+#define GPI_SYS_SDIO1_DATA1			46
+#define GPI_SYS_SDIO1_DATA2			47
+#define GPI_SYS_SDIO1_DATA3			48
+#define GPI_SYS_SDIO1_DATA4			49
+#define GPI_SYS_SDIO1_DATA5			50
+#define GPI_SYS_SDIO1_DATA6			51
+#define GPI_SYS_SDIO1_DATA7			52
+#define GPI_SYS_SDIO1_STRB			53
+#define GPI_SYS_UART1_CTS			54
+#define GPI_SYS_UART1_RX			55
+#define GPI_SYS_SPI1_CLK			56
+#define GPI_SYS_SPI1_FSS			57
+#define GPI_SYS_SPI1_RXD			58
+#define GPI_SYS_I2C2_CLK			59
+#define GPI_SYS_I2C2_DATA			60
+#define GPI_SYS_UART2_CTS			61
+#define GPI_SYS_UART2_RX			62
+#define GPI_SYS_SPI2_CLK			63
+#define GPI_SYS_SPI2_FSS			64
+#define GPI_SYS_SPI2_RXD			65
+#define GPI_SYS_I2C3_CLK			66
+#define GPI_SYS_I2C3_DATA			67
+#define GPI_SYS_UART3_RX			68
+#define GPI_SYS_SPI3_CLK			69
+#define GPI_SYS_SPI3_FSS			70
+#define GPI_SYS_SPI3_RXD			71
+#define GPI_SYS_I2C4_CLK			72
+#define GPI_SYS_I2C4_DATA			73
+#define GPI_SYS_UART4_CTS			74
+#define GPI_SYS_UART4_RX			75
+#define GPI_SYS_SPI4_CLK			76
+#define GPI_SYS_SPI4_FSS			77
+#define GPI_SYS_SPI4_RXD			78
+#define GPI_SYS_I2C5_CLK			79
+#define GPI_SYS_I2C5_DATA			80
+#define GPI_SYS_UART5_CTS			81
+#define GPI_SYS_UART5_RX			82
+#define GPI_SYS_SPI5_CLK			83
+#define GPI_SYS_SPI5_FSS			84
+#define GPI_SYS_SPI5_RXD			85
+#define GPI_SYS_I2C6_CLK			86
+#define GPI_SYS_I2C6_DATA			87
+#define GPI_SYS_SPI6_CLK			88
+#define GPI_SYS_SPI6_FSS			89
+#define GPI_SYS_SPI6_RXD			90
+
+/* aon_iomux gin */
+#define GPI_AON_PMU_GPIO_WAKEUP_0		0
+#define GPI_AON_PMU_GPIO_WAKEUP_1		1
+#define GPI_AON_PMU_GPIO_WAKEUP_2		2
+#define GPI_AON_PMU_GPIO_WAKEUP_3		3
+
+#endif
-- 
2.38.1

