Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC0C675B37
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjATRYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjATRYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:24:39 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD4ABAF1A;
        Fri, 20 Jan 2023 09:24:19 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pIv7h-00055Z-0E;
        Fri, 20 Jan 2023 18:24:17 +0100
Date:   Fri, 20 Jan 2023 17:24:10 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Jianhui Zhao <zhaojh329@gmail.com>
Subject: [PATCH v3 2/3] dt-bindings: clock: mediatek: add mt7981 clock IDs
Message-ID: <367c21c111458abf35170b37d51d023a04a04510.1674233728.git.daniel@makrotopia.org>
References: <cover.1674233728.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674233728.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT7981 clock dt-bindings, include topckgen, apmixedsys,
infracfg, and ethernet subsystem clocks.

Signed-off-by: Jianhui Zhao <zhaojh329@gmail.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../dt-bindings/clock/mediatek,mt7981-clk.h   | 215 ++++++++++++++++++
 1 file changed, 215 insertions(+)
 create mode 100644 include/dt-bindings/clock/mediatek,mt7981-clk.h

diff --git a/include/dt-bindings/clock/mediatek,mt7981-clk.h b/include/dt-bindings/clock/mediatek,mt7981-clk.h
new file mode 100644
index 0000000000000..192f8cefb589f
--- /dev/null
+++ b/include/dt-bindings/clock/mediatek,mt7981-clk.h
@@ -0,0 +1,215 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Wenzhen.Yu <wenzhen.yu@mediatek.com>
+ * Author: Jianhui Zhao <zhaojh329@gmail.com>
+ * Author: Daniel Golle <daniel@makrotopia.org>
+ */
+
+#ifndef _DT_BINDINGS_CLK_MT7981_H
+#define _DT_BINDINGS_CLK_MT7981_H
+
+/* TOPCKGEN */
+#define CLK_TOP_CB_CKSQ_40M		0
+#define CLK_TOP_CB_M_416M		1
+#define CLK_TOP_CB_M_D2			2
+#define CLK_TOP_CB_M_D3			3
+#define CLK_TOP_M_D3_D2			4
+#define CLK_TOP_CB_M_D4			5
+#define CLK_TOP_CB_M_D8			6
+#define CLK_TOP_M_D8_D2			7
+#define CLK_TOP_CB_MM_720M		8
+#define CLK_TOP_CB_MM_D2		9
+#define CLK_TOP_CB_MM_D3		10
+#define CLK_TOP_CB_MM_D3_D5		11
+#define CLK_TOP_CB_MM_D4		12
+#define CLK_TOP_CB_MM_D6		13
+#define CLK_TOP_MM_D6_D2		14
+#define CLK_TOP_CB_MM_D8		15
+#define CLK_TOP_CB_APLL2_196M		16
+#define CLK_TOP_APLL2_D2		17
+#define CLK_TOP_APLL2_D4		18
+#define CLK_TOP_NET1_2500M		19
+#define CLK_TOP_CB_NET1_D4		20
+#define CLK_TOP_CB_NET1_D5		21
+#define CLK_TOP_NET1_D5_D2		22
+#define CLK_TOP_NET1_D5_D4		23
+#define CLK_TOP_CB_NET1_D8		24
+#define CLK_TOP_NET1_D8_D2		25
+#define CLK_TOP_NET1_D8_D4		26
+#define CLK_TOP_CB_NET2_800M		27
+#define CLK_TOP_CB_NET2_D2		28
+#define CLK_TOP_CB_NET2_D4		29
+#define CLK_TOP_NET2_D4_D2		30
+#define CLK_TOP_NET2_D4_D4		31
+#define CLK_TOP_CB_NET2_D6		32
+#define CLK_TOP_CB_WEDMCU_208M		33
+#define CLK_TOP_CB_SGM_325M		34
+#define CLK_TOP_CKSQ_40M_D2		35
+#define CLK_TOP_CB_RTC_32K		36
+#define CLK_TOP_CB_RTC_32P7K		37
+#define CLK_TOP_USB_TX250M		38
+#define CLK_TOP_FAUD			39
+#define CLK_TOP_NFI1X			40
+#define CLK_TOP_USB_EQ_RX250M		41
+#define CLK_TOP_USB_CDR_CK		42
+#define CLK_TOP_USB_LN0_CK		43
+#define CLK_TOP_SPINFI_BCK		44
+#define CLK_TOP_SPI			45
+#define CLK_TOP_SPIM_MST		46
+#define CLK_TOP_UART_BCK		47
+#define CLK_TOP_PWM_BCK			48
+#define CLK_TOP_I2C_BCK			49
+#define CLK_TOP_PEXTP_TL		50
+#define CLK_TOP_EMMC_208M		51
+#define CLK_TOP_EMMC_400M		52
+#define CLK_TOP_DRAMC_REF		53
+#define CLK_TOP_DRAMC_MD32		54
+#define CLK_TOP_SYSAXI			55
+#define CLK_TOP_SYSAPB			56
+#define CLK_TOP_ARM_DB_MAIN		57
+#define CLK_TOP_AP2CNN_HOST		58
+#define CLK_TOP_NETSYS			59
+#define CLK_TOP_NETSYS_500M		60
+#define CLK_TOP_NETSYS_WED_MCU		61
+#define CLK_TOP_NETSYS_2X		62
+#define CLK_TOP_SGM_325M		63
+#define CLK_TOP_SGM_REG			64
+#define CLK_TOP_F26M			65
+#define CLK_TOP_EIP97B			66
+#define CLK_TOP_USB3_PHY		67
+#define CLK_TOP_AUD			68
+#define CLK_TOP_A1SYS			69
+#define CLK_TOP_AUD_L			70
+#define CLK_TOP_A_TUNER			71
+#define CLK_TOP_U2U3_REF		72
+#define CLK_TOP_U2U3_SYS		73
+#define CLK_TOP_U2U3_XHCI		74
+#define CLK_TOP_USB_FRMCNT		75
+#define CLK_TOP_NFI1X_SEL		76
+#define CLK_TOP_SPINFI_SEL		77
+#define CLK_TOP_SPI_SEL			78
+#define CLK_TOP_SPIM_MST_SEL		79
+#define CLK_TOP_UART_SEL		80
+#define CLK_TOP_PWM_SEL			81
+#define CLK_TOP_I2C_SEL			82
+#define CLK_TOP_PEXTP_TL_SEL		83
+#define CLK_TOP_EMMC_208M_SEL		84
+#define CLK_TOP_EMMC_400M_SEL		85
+#define CLK_TOP_F26M_SEL		86
+#define CLK_TOP_DRAMC_SEL		87
+#define CLK_TOP_DRAMC_MD32_SEL		88
+#define CLK_TOP_SYSAXI_SEL		89
+#define CLK_TOP_SYSAPB_SEL		90
+#define CLK_TOP_ARM_DB_MAIN_SEL		91
+#define CLK_TOP_AP2CNN_HOST_SEL		92
+#define CLK_TOP_NETSYS_SEL		93
+#define CLK_TOP_NETSYS_500M_SEL		94
+#define CLK_TOP_NETSYS_MCU_SEL		95
+#define CLK_TOP_NETSYS_2X_SEL		96
+#define CLK_TOP_SGM_325M_SEL		97
+#define CLK_TOP_SGM_REG_SEL		98
+#define CLK_TOP_EIP97B_SEL		99
+#define CLK_TOP_USB3_PHY_SEL		100
+#define CLK_TOP_AUD_SEL			101
+#define CLK_TOP_A1SYS_SEL		102
+#define CLK_TOP_AUD_L_SEL		103
+#define CLK_TOP_A_TUNER_SEL		104
+#define CLK_TOP_U2U3_SEL		105
+#define CLK_TOP_U2U3_SYS_SEL		106
+#define CLK_TOP_U2U3_XHCI_SEL		107
+#define CLK_TOP_USB_FRMCNT_SEL		108
+#define CLK_TOP_AUD_I2S_M		109
+
+/* INFRACFG */
+#define CLK_INFRA_66M_MCK		0
+#define CLK_INFRA_UART0_SEL		1
+#define CLK_INFRA_UART1_SEL		2
+#define CLK_INFRA_UART2_SEL		3
+#define CLK_INFRA_SPI0_SEL		4
+#define CLK_INFRA_SPI1_SEL		5
+#define CLK_INFRA_SPI2_SEL		6
+#define CLK_INFRA_PWM1_SEL		7
+#define CLK_INFRA_PWM2_SEL		8
+#define CLK_INFRA_PWM3_SEL		9
+#define CLK_INFRA_PWM_BSEL		10
+#define CLK_INFRA_PCIE_SEL		11
+#define CLK_INFRA_GPT_STA		12
+#define CLK_INFRA_PWM_HCK		13
+#define CLK_INFRA_PWM_STA		14
+#define CLK_INFRA_PWM1_CK		15
+#define CLK_INFRA_PWM2_CK		16
+#define CLK_INFRA_PWM3_CK		17
+#define CLK_INFRA_CQ_DMA_CK		18
+#define CLK_INFRA_AUD_BUS_CK		19
+#define CLK_INFRA_AUD_26M_CK		20
+#define CLK_INFRA_AUD_L_CK		21
+#define CLK_INFRA_AUD_AUD_CK		22
+#define CLK_INFRA_AUD_EG2_CK		23
+#define CLK_INFRA_DRAMC_26M_CK		24
+#define CLK_INFRA_DBG_CK		25
+#define CLK_INFRA_AP_DMA_CK		26
+#define CLK_INFRA_SEJ_CK		27
+#define CLK_INFRA_SEJ_13M_CK		28
+#define CLK_INFRA_THERM_CK		29
+#define CLK_INFRA_I2C0_CK		30
+#define CLK_INFRA_UART0_CK		31
+#define CLK_INFRA_UART1_CK		32
+#define CLK_INFRA_UART2_CK		33
+#define CLK_INFRA_SPI2_CK		34
+#define CLK_INFRA_SPI2_HCK_CK		35
+#define CLK_INFRA_NFI1_CK		36
+#define CLK_INFRA_SPINFI1_CK		37
+#define CLK_INFRA_NFI_HCK_CK		38
+#define CLK_INFRA_SPI0_CK		39
+#define CLK_INFRA_SPI1_CK		40
+#define CLK_INFRA_SPI0_HCK_CK		41
+#define CLK_INFRA_SPI1_HCK_CK		42
+#define CLK_INFRA_FRTC_CK		43
+#define CLK_INFRA_MSDC_CK		44
+#define CLK_INFRA_MSDC_HCK_CK		45
+#define CLK_INFRA_MSDC_133M_CK		46
+#define CLK_INFRA_MSDC_66M_CK		47
+#define CLK_INFRA_ADC_26M_CK		48
+#define CLK_INFRA_ADC_FRC_CK		49
+#define CLK_INFRA_FBIST2FPC_CK		50
+#define CLK_INFRA_I2C_MCK_CK		51
+#define CLK_INFRA_I2C_PCK_CK		52
+#define CLK_INFRA_IUSB_133_CK		53
+#define CLK_INFRA_IUSB_66M_CK		54
+#define CLK_INFRA_IUSB_SYS_CK		55
+#define CLK_INFRA_IUSB_CK		56
+#define CLK_INFRA_IPCIE_CK		57
+#define CLK_INFRA_IPCIE_PIPE_CK		58
+#define CLK_INFRA_IPCIER_CK		59
+#define CLK_INFRA_IPCIEB_CK		60
+
+/* APMIXEDSYS */
+#define CLK_APMIXED_ARMPLL		0
+#define CLK_APMIXED_NET2PLL		1
+#define CLK_APMIXED_MMPLL		2
+#define CLK_APMIXED_SGMPLL		3
+#define CLK_APMIXED_WEDMCUPLL		4
+#define CLK_APMIXED_NET1PLL		5
+#define CLK_APMIXED_MPLL		6
+#define CLK_APMIXED_APLL2		7
+
+/* SGMIISYS_0 */
+#define CLK_SGM0_TX_EN			0
+#define CLK_SGM0_RX_EN			1
+#define CLK_SGM0_CK0_EN			2
+#define CLK_SGM0_CDR_CK0_EN		3
+
+/* SGMIISYS_1 */
+#define CLK_SGM1_TX_EN			0
+#define CLK_SGM1_RX_EN			1
+#define CLK_SGM1_CK1_EN			2
+#define CLK_SGM1_CDR_CK1_EN		3
+
+/* ETHSYS */
+#define CLK_ETH_FE_EN			0
+#define CLK_ETH_GP2_EN			1
+#define CLK_ETH_GP1_EN			2
+#define CLK_ETH_WOCPU0_EN		3
+
+#endif /* _DT_BINDINGS_CLK_MT7981_H */
-- 
2.39.1

