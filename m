Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B5A74586C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjGCJcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjGCJcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:32:06 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DB5E59;
        Mon,  3 Jul 2023 02:32:02 -0700 (PDT)
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Mon, 3 Jul 2023
 17:32:00 +0800
From:   =Xianwei Zhao <xianwei.zhao@amlogic.com>
To:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: [PATCH 1/3] dt-bindings: power: add Amlogic C3 power domains
Date:   Mon, 3 Jul 2023 17:31:40 +0800
Message-ID: <20230703093142.2028500-2-xianwei.zhao@amlogic.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230703093142.2028500-1-xianwei.zhao@amlogic.com>
References: <20230703093142.2028500-1-xianwei.zhao@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.98.11.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add devicetree binding document and related header file for Amlogic C3 secure power domains.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../power/amlogic,meson-sec-pwrc.yaml         |  3 ++-
 include/dt-bindings/power/amlogic-c3-power.h  | 26 +++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/power/amlogic-c3-power.h

diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
index eab21bb2050a..d80bbedfe3aa 100644
--- a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
@@ -12,7 +12,7 @@ maintainers:
   - Jianxin Pan <jianxin.pan@amlogic.com>
 
 description: |+
-  Secure Power Domains used in Meson A1/C1/S4 SoCs, and should be the child node
+  Secure Power Domains used in Meson A1/C1/S4 & C3 SoCs, and should be the child node
   of secure-monitor.
 
 properties:
@@ -20,6 +20,7 @@ properties:
     enum:
       - amlogic,meson-a1-pwrc
       - amlogic,meson-s4-pwrc
+      - amlogic,c3-pwrc
 
   "#power-domain-cells":
     const: 1
diff --git a/include/dt-bindings/power/amlogic-c3-power.h b/include/dt-bindings/power/amlogic-c3-power.h
new file mode 100644
index 000000000000..3403e7c0b49d
--- /dev/null
+++ b/include/dt-bindings/power/amlogic-c3-power.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (c) 2023 Amlogic, Inc.
+ * Author: hongyu chen1 <hongyu.chen1@amlogic.com>
+ */
+#ifndef _DT_BINDINGS_AMLOGIC_C3_POWER_H
+#define _DT_BINDINGS_AMLOGIC_C3_POWER_H
+
+#define PWRC_C3_NNA_ID				0
+#define PWRC_C3_AUDIO_ID			1
+#define PWRC_C3_RESV_SEC_ID			2
+#define PWRC_C3_SDIOA_ID			3
+#define PWRC_C3_EMMC_ID				4
+#define PWRC_C3_USB_COMB_ID			5
+#define PWRC_C3_SDCARD_ID			6
+#define PWRC_C3_ETH_ID				7
+#define PWRC_C3_RESV0_ID			8
+#define PWRC_C3_GE2D_ID				9
+#define PWRC_C3_CVE_ID				10
+#define PWRC_C3_GDC_WRAP_ID			11
+#define PWRC_C3_ISP_TOP_ID			12
+#define PWRC_C3_MIPI_ISP_WRAP_ID		13
+#define PWRC_C3_VCODEC_ID			14
+
+#endif
+

base-commit: 057889cb4244096ea5abcbe76ffd4d311c3078fe
-- 
2.37.1

