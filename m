Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612B3720362
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjFBNas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbjFBNah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:30:37 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E114E4C;
        Fri,  2 Jun 2023 06:30:25 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352CD2vS023887;
        Fri, 2 Jun 2023 15:30:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=yXr1dO9hXYb6Yp4qjold8WTPHoK4NgmyAwHDuDbtzoY=;
 b=wR0L36+Ovvxnf2bFaer1uhO7ewdx80jmliVxbd8nh+VIanyXV/JoztL951I14DgH5lgD
 V2hWCix329eQfztM9+ilToNGFVtxI7LrFXVlYmumJjftq7YfzImiTAI+gdNgnzw6XcrT
 p72l7YiPQDnRWU7cVwjd0/uYJ/QtwgWwM5hcNCojKmS3gAXdIcZ0S8nMEHHX3DXG3OFC
 KBPBLDMpvlsCRr7RLRej3pSYw+I2NZ8bNkqAUpWhVuajANyw7+N1zlOz5QnQtWkKsmOy
 hTgjbQS9kjYjkoJiNpXmMSj10O305W8WP7jlCX+fUzx2MZCUVeF0tAu0IPQUzaq8pSfu 4A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qyc08a223-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 15:30:10 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AEB22100034;
        Fri,  2 Jun 2023 15:30:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A56FD23694D;
        Fri,  2 Jun 2023 15:30:09 +0200 (CEST)
Received: from localhost (10.201.21.93) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 2 Jun
 2023 15:30:09 +0200
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
Subject: [PATCH v2 06/10] arm64: dts: st: introduce stm32mp25 pinctrl files
Date:   Fri, 2 Jun 2023 15:28:55 +0200
Message-ID: <20230602132859.16442-7-alexandre.torgue@foss.st.com>
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

Three packages exist for stm32mp25 dies. As ball-out is different between
them, this patch covers those differences by introducing dedicated pinctrl
dtsi files. Each dtsi pinctrl package file describes the package ball-out
through gpio-ranges.

Available packages are:

STM32MP25xAI: 18*18/FCBGA 172 ios
STM32MP25xAK: 14*14/FCBGA 144 ios
STM32MP25xAL: 10*10/TFBGA 144 ios

It includes also the common file used for pin groups definition.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi b/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
new file mode 100644
index 000000000000..5bd27767fbf5
--- /dev/null
+++ b/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
+/*
+ * Copyright (C) STMicroelectronics 2023 - All Rights Reserved
+ * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
+ */
+#include <dt-bindings/pinctrl/stm32-pinfunc.h>
+
diff --git a/arch/arm64/boot/dts/st/stm32mp25xxai-pinctrl.dtsi b/arch/arm64/boot/dts/st/stm32mp25xxai-pinctrl.dtsi
new file mode 100644
index 000000000000..abdbc7aebc7f
--- /dev/null
+++ b/arch/arm64/boot/dts/st/stm32mp25xxai-pinctrl.dtsi
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
+/*
+ * Copyright (C) STMicroelectronics 2023 - All Rights Reserved
+ * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
+ */
+
+&pinctrl {
+	st,package = <STM32MP_PKG_AI>;
+
+	gpioa: gpio@44240000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 0 16>;
+	};
+
+	gpiob: gpio@44250000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 16 16>;
+	};
+
+	gpioc: gpio@44260000 {
+		status = "okay";
+		ngpios = <14>;
+		gpio-ranges = <&pinctrl 0 32 14>;
+	};
+
+	gpiod: gpio@44270000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 48 16>;
+	};
+
+	gpioe: gpio@44280000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 64 16>;
+	};
+
+	gpiof: gpio@44290000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 80 16>;
+	};
+
+	gpiog: gpio@442a0000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 96 16>;
+	};
+
+	gpioh: gpio@442b0000 {
+		status = "okay";
+		ngpios = <12>;
+		gpio-ranges = <&pinctrl 2 114 12>;
+	};
+
+	gpioi: gpio@442c0000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 128 16>;
+	};
+
+	gpioj: gpio@442d0000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 144 16>;
+	};
+
+	gpiok: gpio@442e0000 {
+		status = "okay";
+		ngpios = <8>;
+		gpio-ranges = <&pinctrl 0 160 8>;
+	};
+};
+
+&pinctrl_z {
+	gpioz: gpio@46200000 {
+		status = "okay";
+		ngpios = <10>;
+		gpio-ranges = <&pinctrl_z 0 400 10>;
+	};
+};
diff --git a/arch/arm64/boot/dts/st/stm32mp25xxak-pinctrl.dtsi b/arch/arm64/boot/dts/st/stm32mp25xxak-pinctrl.dtsi
new file mode 100644
index 000000000000..2e0d4d349d14
--- /dev/null
+++ b/arch/arm64/boot/dts/st/stm32mp25xxak-pinctrl.dtsi
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
+/*
+ * Copyright (C) STMicroelectronics 2023 - All Rights Reserved
+ * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
+ */
+
+&pinctrl {
+	st,package = <STM32MP_PKG_AK>;
+
+	gpioa: gpio@44240000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 0 16>;
+	};
+
+	gpiob: gpio@44250000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 16 16>;
+	};
+
+	gpioc: gpio@44260000 {
+		status = "okay";
+		ngpios = <14>;
+		gpio-ranges = <&pinctrl 0 32 14>;
+	};
+
+	gpiod: gpio@44270000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 48 16>;
+	};
+
+	gpioe: gpio@44280000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 64 16>;
+	};
+
+	gpiof: gpio@44290000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 80 16>;
+	};
+
+	gpiog: gpio@442a0000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 96 16>;
+	};
+
+	gpioh: gpio@442b0000 {
+		status = "okay";
+		ngpios = <12>;
+		gpio-ranges = <&pinctrl 2 114 12>;
+	};
+
+	gpioi: gpio@442c0000 {
+		status = "okay";
+		ngpios = <12>;
+		gpio-ranges = <&pinctrl 0 128 12>;
+	};
+};
+
+&pinctrl_z {
+	gpioz: gpio@46200000 {
+		status = "okay";
+		ngpios = <10>;
+		gpio-ranges = <&pinctrl_z 0 400 10>;
+	};
+};
diff --git a/arch/arm64/boot/dts/st/stm32mp25xxal-pinctrl.dtsi b/arch/arm64/boot/dts/st/stm32mp25xxal-pinctrl.dtsi
new file mode 100644
index 000000000000..2406e972554c
--- /dev/null
+++ b/arch/arm64/boot/dts/st/stm32mp25xxal-pinctrl.dtsi
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
+/*
+ * Copyright (C) STMicroelectronics 2023 - All Rights Reserved
+ * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
+ */
+
+&pinctrl {
+	st,package = <STM32MP_PKG_AL>;
+
+	gpioa: gpio@44240000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 0 16>;
+	};
+
+	gpiob: gpio@44250000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 16 16>;
+	};
+
+	gpioc: gpio@44260000 {
+		status = "okay";
+		ngpios = <14>;
+		gpio-ranges = <&pinctrl 0 32 14>;
+	};
+
+	gpiod: gpio@44270000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 48 16>;
+	};
+
+	gpioe: gpio@44280000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 64 16>;
+	};
+
+	gpiof: gpio@44290000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 80 16>;
+	};
+
+	gpiog: gpio@442a0000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 96 16>;
+	};
+
+	gpioh: gpio@442b0000 {
+		status = "okay";
+		ngpios = <12>;
+		gpio-ranges = <&pinctrl 2 114 12>;
+	};
+
+	gpioi: gpio@442c0000 {
+		status = "okay";
+		ngpios = <12>;
+		gpio-ranges = <&pinctrl 0 128 12>;
+	};
+};
+
+&pinctrl_z {
+	gpioz: gpio@46200000 {
+		status = "okay";
+		ngpios = <10>;
+		gpio-ranges = <&pinctrl_z 0 400 10>;
+	};
+};
-- 
2.17.1

