Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCCF5E6504
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiIVOVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiIVOUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:20:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD456A6ADB;
        Thu, 22 Sep 2022 07:20:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A007201B;
        Thu, 22 Sep 2022 07:20:48 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 106FA3F73B;
        Thu, 22 Sep 2022 07:20:39 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Grant Likely <grant.likely@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pawel Moll <Pawel.Moll@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: arm: add copyright messages (Arm Ltd.)
Date:   Thu, 22 Sep 2022 15:20:09 +0100
Message-Id: <20220922142010.1412640-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922142010.1412640-1-andre.przywara@arm.com>
References: <20220922142010.1412640-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPL license seems to require an explicit copyright statement.

Add the appropriate line into files which were lacking this. This
assigns the copyright to Arm Ltd., for files which were originally
contributed by Arm Ltd. employees.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi      | 2 +-
 arch/arm64/boot/dts/arm/foundation-v8-gicv3-psci.dts  | 2 +-
 arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts       | 2 +-
 arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi      | 2 +-
 arch/arm64/boot/dts/arm/foundation-v8-psci.dts        | 2 +-
 arch/arm64/boot/dts/arm/foundation-v8-psci.dtsi       | 2 +-
 arch/arm64/boot/dts/arm/foundation-v8-spin-table.dtsi | 2 +-
 arch/arm64/boot/dts/arm/foundation-v8.dts             | 3 +--
 arch/arm64/boot/dts/arm/foundation-v8.dtsi            | 2 +-
 arch/arm64/boot/dts/arm/juno-base.dtsi                | 5 +++++
 arch/arm64/boot/dts/arm/juno-r1-scmi.dts              | 5 +++++
 arch/arm64/boot/dts/arm/juno-r2-scmi.dts              | 5 +++++
 arch/arm64/boot/dts/arm/juno-scmi.dts                 | 1 +
 arch/arm64/boot/dts/arm/juno-scmi.dtsi                | 5 +++++
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts            | 2 ++
 arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi      | 2 ++
 arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts  | 4 ++--
 17 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi b/arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi
index 53fa6b9fd86fb..db61c828ff8e4 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi
+++ b/arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
- * ARM Ltd.
+ * Copyright (c) 2012-2022 Arm Ltd.
  *
  * ARMv8 Foundation model DTS (GICv2 configuration)
  */
diff --git a/arch/arm64/boot/dts/arm/foundation-v8-gicv3-psci.dts b/arch/arm64/boot/dts/arm/foundation-v8-gicv3-psci.dts
index 32c16d7f216ab..b2f8ceeb4d51c 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8-gicv3-psci.dts
+++ b/arch/arm64/boot/dts/arm/foundation-v8-gicv3-psci.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
- * ARM Ltd.
+ * Copyright (c) 2012-2022 Arm Ltd.
  *
  * ARMv8 Foundation model DTS (GICv3+PSCI configuration)
  */
diff --git a/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts b/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts
index e1426de132560..81dd879379d72 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts
+++ b/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
- * ARM Ltd.
+ * Copyright (c) 2012-2022 Arm Ltd.
  *
  * ARMv8 Foundation model DTS (GICv3 configuration)
  */
diff --git a/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi b/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi
index dd2d305b53393..83f24b2cb0586 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi
+++ b/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
- * ARM Ltd.
+ * Copyright (c) 2012-2022 Arm Ltd.
  *
  * ARMv8 Foundation model DTS (GICv3 configuration)
  */
diff --git a/arch/arm64/boot/dts/arm/foundation-v8-psci.dts b/arch/arm64/boot/dts/arm/foundation-v8-psci.dts
index 1d6c6bcb08cdd..5afc1cd59b5cf 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8-psci.dts
+++ b/arch/arm64/boot/dts/arm/foundation-v8-psci.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
- * ARM Ltd.
+ * Copyright (c) 2012-2022 Arm Ltd.
  *
  * ARMv8 Foundation model DTS (GICv2+PSCI configuration)
  */
diff --git a/arch/arm64/boot/dts/arm/foundation-v8-psci.dtsi b/arch/arm64/boot/dts/arm/foundation-v8-psci.dtsi
index f9589905dc024..bf748a0db4fa6 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8-psci.dtsi
+++ b/arch/arm64/boot/dts/arm/foundation-v8-psci.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
- * ARM Ltd.
+ * Copyright (c) 2012-2022 Arm Ltd.
  *
  * ARMv8 Foundation model DTS (PSCI configuration)
  */
diff --git a/arch/arm64/boot/dts/arm/foundation-v8-spin-table.dtsi b/arch/arm64/boot/dts/arm/foundation-v8-spin-table.dtsi
index 6796bbb5eef05..b9352ccff0194 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8-spin-table.dtsi
+++ b/arch/arm64/boot/dts/arm/foundation-v8-spin-table.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
- * ARM Ltd.
+ * Copyright (c) 2012-2022 Arm Ltd.
  *
  * ARMv8 Foundation model DTS (spin table configuration)
  */
diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dts b/arch/arm64/boot/dts/arm/foundation-v8.dts
index a73bf774c7603..e1bae3f8de702 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8.dts
+++ b/arch/arm64/boot/dts/arm/foundation-v8.dts
@@ -1,10 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
- * ARM Ltd.
+ * Copyright (c) 2012-2022 Arm Ltd.
  *
  * ARMv8 Foundation model DTS (GICv2 configuration)
  */
-
 #include "foundation-v8.dtsi"
 #include "foundation-v8-gicv2.dtsi"
 #include "foundation-v8-spin-table.dtsi"
diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dtsi b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
index 152bc7f0f37cb..5ad4102d6073c 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8.dtsi
+++ b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
- * ARM Ltd.
+ * Copyright (c) 2012-2022 Arm Ltd.
  *
  * ARMv8 Foundation model DTS
  */
diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index 5f89d984b031e..ae890f3b448ee 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -1,4 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+/*
+ * Arm Juno board common peripheral definitions
+ *
+ * Copyright (c) 2014-2022 Arm Ltd.
+ */
 #include "juno-clocks.dtsi"
 #include "juno-motherboard.dtsi"
 
diff --git a/arch/arm64/boot/dts/arm/juno-r1-scmi.dts b/arch/arm64/boot/dts/arm/juno-r1-scmi.dts
index e63543c624f4a..d554ce3794f0d 100644
--- a/arch/arm64/boot/dts/arm/juno-r1-scmi.dts
+++ b/arch/arm64/boot/dts/arm/juno-r1-scmi.dts
@@ -1,4 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+/*
+ * SCMI definitions specific to the Arm Juno R1 board
+ *
+ * Copyright (c) 2022 Arm Ltd.
+ */
 #include "juno-r1.dts"
 #include "juno-scmi.dtsi"
 
diff --git a/arch/arm64/boot/dts/arm/juno-r2-scmi.dts b/arch/arm64/boot/dts/arm/juno-r2-scmi.dts
index 6c80f08b3ec2e..9781dcb9f2e14 100644
--- a/arch/arm64/boot/dts/arm/juno-r2-scmi.dts
+++ b/arch/arm64/boot/dts/arm/juno-r2-scmi.dts
@@ -1,4 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+/*
+ * SCMI definitions specific to the Arm Juno R2 board
+ *
+ * Copyright (c) 2022 Arm Ltd.
+ */
 #include "juno-r2.dts"
 #include "juno-scmi.dtsi"
 
diff --git a/arch/arm64/boot/dts/arm/juno-scmi.dts b/arch/arm64/boot/dts/arm/juno-scmi.dts
index 51844a407a7dd..56880d8fd1ff0 100644
--- a/arch/arm64/boot/dts/arm/juno-scmi.dts
+++ b/arch/arm64/boot/dts/arm/juno-scmi.dts
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+/* Copyright (c) 2022 Arm Ltd. */
 #include "juno.dts"
 #include "juno-scmi.dtsi"
 
diff --git a/arch/arm64/boot/dts/arm/juno-scmi.dtsi b/arch/arm64/boot/dts/arm/juno-scmi.dtsi
index c6f4b80d3dff0..d78f595b30600 100644
--- a/arch/arm64/boot/dts/arm/juno-scmi.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-scmi.dtsi
@@ -1,4 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+/*
+ * SCMI definitions shared by all Arm Juno boards
+ *
+ * Copyright (c) 2022 Arm Ltd.
+ */
 / {
 	etf@20010000 {
 		power-domains = <&scmi_devpd 8>;
diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
index 5b514c865845d..1fecc3f3655eb 100644
--- a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
+++ b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
@@ -2,6 +2,8 @@
 /*
  * ARM Ltd. Fast Models
  *
+ * Copyright (c) 2012-2022 Arm Ltd.
+ *
  * Architecture Envelope Model (AEM) ARMv8-A
  * ARMAEMv8AMPCT
  *
diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
index 5f8f17d6c8e59..5b525a7063d37 100644
--- a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
+++ b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
@@ -2,6 +2,8 @@
 /*
  * ARM Ltd. Fast Models
  *
+ * Copyright (c) 2012-2022 Arm Ltd.
+ *
  * Versatile Express (VE) system model
  * Motherboard component
  *
diff --git a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
index 8cb44b0577ca5..72a0c1dcc48fd 100644
--- a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
+++ b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
- * ARM Ltd. Versatile Express
+ * Copyright (c) 2012-2022 Arm Ltd.
  *
- * LogicTile Express 20MG
+ * ARM Ltd. Versatile Express LogicTile Express 20MG
  * V2F-1XV7
  *
  * Cortex-A53 (2 cores) Soft Macrocell Model
-- 
2.25.1

