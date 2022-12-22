Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9BF653E01
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 11:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiLVKH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 05:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiLVKHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:07:48 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EA61E70C;
        Thu, 22 Dec 2022 02:07:43 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BM7i883006364;
        Thu, 22 Dec 2022 11:07:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=pnk0AODRWy9qchWqvydC204yIzXNjeaL4loMfcA2TJ0=;
 b=6cHh5eTfqfjphJSLtwtPEB8wHGVRojwoHHW+Y4ZtH4YNftfD4sgnJwuBBZqv7y7n3Yd/
 UG8wfWCFd24/4V653OzMbnKHqTWfFco9QmQeB+RSYI+EhFNbXbHNw3cK/hFp05YeN2xi
 Rem7SLZbWJQ2XcGFr/wydIfuAPO+yDzeDNXlTZ6ovJLu375KXvRKFQyg0PkTiXUffDkY
 5ToMLX+ZwgkVyq2Z/Za+mBiitjDrTw+ycgNP8t3ipZHp13yO8xJMy7/9pB0QbUEPiEu1
 UhPlGb4SHjzOraQOmZkLNVOSVgWwJPt/gKR3IAKxvF4NJNTZHvrGwHVN1gPbV2BIpsjw zA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mkc8jdtva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 11:07:14 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 85F7410004A;
        Thu, 22 Dec 2022 11:07:11 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9A42D21ED2E;
        Thu, 22 Dec 2022 11:06:55 +0100 (CET)
Received: from localhost (10.201.21.217) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Thu, 22 Dec
 2022 11:06:55 +0100
From:   Gatien Chevallier <gatien.chevallier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>,
        <Oleksii_Moisieiev@epam.com>, <linus.walleij@linaro.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <loic.pallardy@st.com>,
        <devicetree@vger.kernel.org>, <mark.rutland@arm.com>,
        <arnd@arndb.de>, <gatien.chevallier@foss.st.com>
Subject: [RFC PATCH v2 4/7] dt-bindings: bus: add STM32MP13 ETZPC firewall bus bindings
Date:   Thu, 22 Dec 2022 11:05:01 +0100
Message-ID: <20221222100504.68247-5-gatien.chevallier@foss.st.com>
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

Adds the list of peripherals IDs under firewall bus on STM32MP13.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 include/dt-bindings/bus/stm32mp13_sys_bus.h | 60 +++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 include/dt-bindings/bus/stm32mp13_sys_bus.h

diff --git a/include/dt-bindings/bus/stm32mp13_sys_bus.h b/include/dt-bindings/bus/stm32mp13_sys_bus.h
new file mode 100644
index 000000000000..1160de87bc4a
--- /dev/null
+++ b/include/dt-bindings/bus/stm32mp13_sys_bus.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) STMicroelectronics 2022 - All Rights Reserved
+ */
+#ifndef _DT_BINDINGS_BUS_STM32MP13_SYS_BUS_H
+#define _DT_BINDINGS_BUS_STM32MP13_SYS_BUS_H
+
+/* ETZPC IDs */
+#define STM32MP1_ETZPC_VREFBUF_ID	0
+#define STM32MP1_ETZPC_LPTIM2_ID	1
+#define STM32MP1_ETZPC_LPTIM3_ID	2
+#define STM32MP1_ETZPC_LTDC_ID		3
+#define STM32MP1_ETZPC_DCMIPP_ID	4
+#define STM32MP1_ETZPC_USBPHYCTRL_ID	5
+#define STM32MP1_ETZPC_DDRCTRLPHY_ID	6
+/* IDs 7-11 reserved */
+#define STM32MP1_ETZPC_IWDG1_ID		12
+#define STM32MP1_ETZPC_STGENC_ID	13
+/* IDs 14-15 reserved */
+#define STM32MP1_ETZPC_USART1_ID	16
+#define STM32MP1_ETZPC_USART2_ID	17
+#define STM32MP1_ETZPC_SPI4_ID		18
+#define STM32MP1_ETZPC_SPI5_ID		19
+#define STM32MP1_ETZPC_I2C3_ID		20
+#define STM32MP1_ETZPC_I2C4_ID		21
+#define STM32MP1_ETZPC_I2C5_ID		22
+#define STM32MP1_ETZPC_TIM12_ID		23
+#define STM32MP1_ETZPC_TIM13_ID		24
+#define STM32MP1_ETZPC_TIM14_ID		25
+#define STM32MP1_ETZPC_TIM15_ID		26
+#define STM32MP1_ETZPC_TIM16_ID		27
+#define STM32MP1_ETZPC_TIM17_ID		28
+/* IDs 29-31 reserved */
+#define STM32MP1_ETZPC_ADC1_ID		32
+#define STM32MP1_ETZPC_ADC2_ID		33
+#define STM32MP1_ETZPC_OTG_ID		34
+/* IDs 35-39 reserved */
+#define STM32MP1_ETZPC_TSC_ID		37
+#define STM32MP1_ETZPC_RNG_ID		40
+#define STM32MP1_ETZPC_HASH_ID		41
+#define STM32MP1_ETZPC_CRYP_ID		42
+#define STM32MP1_ETZPC_SAES_ID		43
+#define STM32MP1_ETZPC_PKA_ID		44
+#define STM32MP1_ETZPC_BKPSRAM_ID	45
+/* IDs 46-47 reserved */
+#define STM32MP1_ETZPC_ETH1_ID		48
+#define STM32MP1_ETZPC_ETH2_ID		49
+#define STM32MP1_ETZPC_SDMMC1_ID	50
+#define STM32MP1_ETZPC_SDMMC2_ID	51
+/* ID 52 reserved */
+#define STM32MP1_ETZPC_MCE_ID		53
+#define STM32MP1_ETZPC_FMC_ID		54
+#define STM32MP1_ETZPC_QSPI_ID		55
+/* IDs 56-59 reserved */
+#define STM32MP1_ETZPC_SRAM1_ID		60
+#define STM32MP1_ETZPC_SRAM2_ID		61
+#define STM32MP1_ETZPC_SRAM3_ID		62
+/* ID 63 reserved */
+
+#endif /* _DT_BINDINGS_BUS_STM32MP13_SYS_BUS_H */
-- 
2.25.1

