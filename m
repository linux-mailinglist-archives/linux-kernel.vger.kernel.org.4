Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0066FE2CB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbjEJQwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjEJQwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:52:18 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66F186BA;
        Wed, 10 May 2023 09:51:56 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34AEqUK7015023;
        Wed, 10 May 2023 18:51:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=lcLDqN2ZYdjWNqrxhC5sckV20z6BNR4pxtCqiw/kpbM=;
 b=dk7NmF2csO2LTk2mHy7Br/xGu8EiQaurF2rizF6rPIpxYTni524o2o+M+9HIWjRv6DeJ
 EJh290xBpdLFpzNf+W9kDzUkCxkn2dlBqu6S9m99Vbo2F7oYB4/QORFtq7yZYsKQG3KV
 2iaqmWV4Ji0gKsu/mv5X+E1gBz/x6Q1auhuFs6oLdguo+SJT7Yz3k4zzKCC8MEY7aEbg
 slH4iaFooMmkh7JDnh6EjbtJaAgydx9fb9H8t3G4O4Af7Zm8Jf5HQrahngMTC/vz0xK/
 44KZK54YPfB/h/aAcmYjwCwvxUcRGnOtW15leLGZtn0aT7f0Q5GMuBeKiXhO0sioubhp 6A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qg90pjfhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 18:51:45 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2FA4710002A;
        Wed, 10 May 2023 18:51:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 22AD122D185;
        Wed, 10 May 2023 18:51:45 +0200 (CEST)
Received: from localhost (10.48.1.0) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 10 May
 2023 18:51:44 +0200
From:   Patrick Delaunay <patrick.delaunay@foss.st.com>
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <gabriel.fernandez@st.com>, <gabriel.fernandez@foss.st.com>,
        "Patrick Delaunay" <patrick.delaunay@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2] dt-bindings: rcc: stm32: Sync with u-boot copy for STM32MP13 SoC
Date:   Wed, 10 May 2023 18:51:40 +0200
Message-ID: <20230510184305.v2.1.I417093ddcea282be479f10a37147d1935a9050b7@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.1.0]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cosmetic change, aligned with files in U-Boot:
- change obsolete SPDX id : GPL-2.0+ and use the same license
  GPL-2.0-only for the 2 files
- use correct mail address gabriel.fernandez@foss.st.com
- remove extra space

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

Changes in v2:
- Change title "Fix STM32MP13 include file"
- Use the same license for the 2 files GPL-2.0-only as recommended
  to avoid check-patch issue on next

 include/dt-bindings/clock/stm32mp13-clks.h   | 6 +++---
 include/dt-bindings/reset/stm32mp13-resets.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/dt-bindings/clock/stm32mp13-clks.h b/include/dt-bindings/clock/stm32mp13-clks.h
index 02befd25edce..0bd7b54c65ff 100644
--- a/include/dt-bindings/clock/stm32mp13-clks.h
+++ b/include/dt-bindings/clock/stm32mp13-clks.h
@@ -1,7 +1,7 @@
-/* SPDX-License-Identifier: GPL-2.0+ or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
 /*
  * Copyright (C) STMicroelectronics 2020 - All Rights Reserved
- * Author: Gabriel Fernandez <gabriel.fernandez@st.com> for STMicroelectronics.
+ * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STMicroelectronics.
  */
 
 #ifndef _DT_BINDINGS_STM32MP13_CLKS_H_
@@ -64,7 +64,7 @@
 #define CK_MCO1		38
 #define CK_MCO2		39
 
-/*  IP clocks */
+/* IP clocks */
 #define SYSCFG		40
 #define VREF		41
 #define DTS		42
diff --git a/include/dt-bindings/reset/stm32mp13-resets.h b/include/dt-bindings/reset/stm32mp13-resets.h
index 934864e90da6..ecb37c7ddde1 100644
--- a/include/dt-bindings/reset/stm32mp13-resets.h
+++ b/include/dt-bindings/reset/stm32mp13-resets.h
@@ -1,7 +1,7 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
 /*
  * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
- * Author: Gabriel Fernandez <gabriel.fernandez@st.com> for STMicroelectronics.
+ * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STMicroelectronics.
  */
 
 #ifndef _DT_BINDINGS_STM32MP13_RESET_H_
-- 
2.25.1

