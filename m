Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E18653DFF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 11:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbiLVKHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 05:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiLVKHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:07:45 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A418F16498;
        Thu, 22 Dec 2022 02:07:41 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMA3NMG004982;
        Thu, 22 Dec 2022 11:07:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=Xt99QzLkXk9dgF6CNBymqyjzMSZIicB6aFKbuVieT54=;
 b=lg2LYpd2bVLY6n+aTB6yt90HWs7EIYLF3d/HgLT7YGXRTsYX96hKgbkMnQBLTR7pWUIb
 BgbMOipJpxOkCXuByDXaVa93KHFQogQs1rgl+KHlkzZYXV29fUMh6WeuuqJ6bu0vQ1JS
 zA33mNDJ83PaFf8tAIaIRYJeIsKIr/YR0IU+jcS1/EPaiT7giDY5y6xwCvpLMafSS5Qy
 ObyBcS7sCIkRnqG5r19a0dJjxHcJQMTwcovpfwT95KQ3QkJrlH3oxxyzRt9jT7zl44JK
 G0raEferDvFRGimPvTQNviWV888utNs2AeKdBB2HhrffX8g9uj/dmGdkHnp+0jUd++nn 7A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mkc8jdtvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 11:07:14 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 863CF10004D;
        Thu, 22 Dec 2022 11:07:11 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E0DC92132C7;
        Thu, 22 Dec 2022 11:06:42 +0100 (CET)
Received: from localhost (10.201.21.217) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Thu, 22 Dec
 2022 11:06:42 +0100
From:   Gatien Chevallier <gatien.chevallier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>,
        <Oleksii_Moisieiev@epam.com>, <linus.walleij@linaro.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <loic.pallardy@st.com>,
        <devicetree@vger.kernel.org>, <mark.rutland@arm.com>,
        <arnd@arndb.de>, <gatien.chevallier@foss.st.com>
Subject: [RFC PATCH v2 3/7] dt-bindings: bus: add STM32MP15 ETZPC firewall bus bindings
Date:   Thu, 22 Dec 2022 11:05:00 +0100
Message-ID: <20221222100504.68247-4-gatien.chevallier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222100504.68247-1-gatien.chevallier@foss.st.com>
References: <20221222100504.68247-1-gatien.chevallier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.217]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_05,2022-12-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the list of peripherals IDs under firewall bus on STM32MP15.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 include/dt-bindings/bus/stm32mp15_sys_bus.h | 98 +++++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 include/dt-bindings/bus/stm32mp15_sys_bus.h

diff --git a/include/dt-bindings/bus/stm32mp15_sys_bus.h b/include/dt-bindings/bus/stm32mp15_sys_bus.h
new file mode 100644
index 000000000000..97eacc7b5f16
--- /dev/null
+++ b/include/dt-bindings/bus/stm32mp15_sys_bus.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) STMicroelectronics 2022 - All Rights Reserved
+ */
+#ifndef _DT_BINDINGS_BUS_STM32MP15_SYS_BUS_H
+#define _DT_BINDINGS_BUS_STM32MP15_SYS_BUS_H
+
+/* ETZPC IDs */
+#define STM32MP1_ETZPC_STGENC_ID	0
+#define STM32MP1_ETZPC_BKPSRAM_ID	1
+#define STM32MP1_ETZPC_IWDG1_ID		2
+#define STM32MP1_ETZPC_USART1_ID	3
+#define STM32MP1_ETZPC_SPI6_ID		4
+#define STM32MP1_ETZPC_I2C4_ID		5
+/* ID 6 reserved */
+#define STM32MP1_ETZPC_RNG1_ID		7
+#define STM32MP1_ETZPC_HASH1_ID		8
+#define STM32MP1_ETZPC_CRYP1_ID		9
+#define STM32MP1_ETZPC_DDRCTRL_ID	10
+#define STM32MP1_ETZPC_DDRPHYC_ID	11
+#define STM32MP1_ETZPC_I2C6_ID		12
+/* IDs 13-15 reserved */
+#define STM32MP1_ETZPC_TIM2_ID		16
+#define STM32MP1_ETZPC_TIM3_ID		17
+#define STM32MP1_ETZPC_TIM4_ID		18
+#define STM32MP1_ETZPC_TIM5_ID		19
+#define STM32MP1_ETZPC_TIM6_ID		20
+#define STM32MP1_ETZPC_TIM7_ID		21
+#define STM32MP1_ETZPC_TIM12_ID		22
+#define STM32MP1_ETZPC_TIM13_ID		23
+#define STM32MP1_ETZPC_TIM14_ID		24
+#define STM32MP1_ETZPC_LPTIM1_ID	25
+#define STM32MP1_ETZPC_WWDG1_ID		26
+#define STM32MP1_ETZPC_SPI2_ID		27
+#define STM32MP1_ETZPC_SPI3_ID		28
+#define STM32MP1_ETZPC_SPDIFRX_ID	29
+#define STM32MP1_ETZPC_USART2_ID	30
+#define STM32MP1_ETZPC_USART3_ID	31
+#define STM32MP1_ETZPC_UART4_ID		32
+#define STM32MP1_ETZPC_UART5_ID		33
+#define STM32MP1_ETZPC_I2C1_ID		34
+#define STM32MP1_ETZPC_I2C2_ID		35
+#define STM32MP1_ETZPC_I2C3_ID		36
+#define STM32MP1_ETZPC_I2C5_ID		37
+#define STM32MP1_ETZPC_CEC_ID		38
+#define STM32MP1_ETZPC_DAC_ID		39
+#define STM32MP1_ETZPC_UART7_ID		40
+#define STM32MP1_ETZPC_UART8_ID		41
+/* IDs 42-43 reserved */
+#define STM32MP1_ETZPC_MDIOS_ID		44
+/* IDs 45-47 reserved */
+#define STM32MP1_ETZPC_TIM1_ID		48
+#define STM32MP1_ETZPC_TIM8_ID		49
+/* ID 50 reserved */
+#define STM32MP1_ETZPC_USART6_ID	51
+#define STM32MP1_ETZPC_SPI1_ID		52
+#define STM32MP1_ETZPC_SPI4_ID		53
+#define STM32MP1_ETZPC_TIM15_ID		54
+#define STM32MP1_ETZPC_TIM16_ID		55
+#define STM32MP1_ETZPC_TIM17_ID		56
+#define STM32MP1_ETZPC_SPI5_ID		57
+#define STM32MP1_ETZPC_SAI1_ID		58
+#define STM32MP1_ETZPC_SAI2_ID		59
+#define STM32MP1_ETZPC_SAI3_ID		60
+#define STM32MP1_ETZPC_DFSDM_ID		61
+#define STM32MP1_ETZPC_TT_FDCAN_ID	62
+/* IDs 63 reserved */
+#define STM32MP1_ETZPC_LPTIM2_ID	64
+#define STM32MP1_ETZPC_LPTIM3_ID	65
+#define STM32MP1_ETZPC_LPTIM4_ID	66
+#define STM32MP1_ETZPC_LPTIM5_ID	67
+#define STM32MP1_ETZPC_SAI4_ID		68
+#define STM32MP1_ETZPC_VREFBUF_ID	69
+#define STM32MP1_ETZPC_DCMI_ID		70
+#define STM32MP1_ETZPC_CRC2_ID		71
+#define STM32MP1_ETZPC_ADC_ID		72
+#define STM32MP1_ETZPC_HASH2_ID		73
+#define STM32MP1_ETZPC_RNG2_ID		74
+#define STM32MP1_ETZPC_CRYP2_ID		75
+/* IDs 76-79 reserved */
+#define STM32MP1_ETZPC_SRAM1_ID		80
+#define STM32MP1_ETZPC_SRAM2_ID		81
+#define STM32MP1_ETZPC_SRAM3_ID		82
+#define STM32MP1_ETZPC_SRAM4_ID		83
+#define STM32MP1_ETZPC_RETRAM_ID	84
+#define STM32MP1_ETZPC_OTG_ID		85
+#define STM32MP1_ETZPC_SDMMC3_ID	86
+#define STM32MP1_ETZPC_DLYBSD3_ID	87
+#define STM32MP1_ETZPC_DMA1_ID		88
+#define STM32MP1_ETZPC_DMA2_ID		89
+#define STM32MP1_ETZPC_DMAMUX_ID	90
+#define STM32MP1_ETZPC_FMC_ID		91
+#define STM32MP1_ETZPC_QSPI_ID		92
+#define STM32MP1_ETZPC_DLYBQ_ID		93
+#define STM32MP1_ETZPC_ETH_ID		94
+/* ID 95 reserved */
+
+#endif /* _DT_BINDINGS_BUS_STM32MP15_SYS_BUS_H */
-- 
2.25.1

