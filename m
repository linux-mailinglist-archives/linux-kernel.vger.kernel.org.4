Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9687A6E3637
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 10:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjDPIrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 04:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjDPIrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 04:47:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C88E4E;
        Sun, 16 Apr 2023 01:47:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C925061900;
        Sun, 16 Apr 2023 08:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A69BC4339C;
        Sun, 16 Apr 2023 08:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681634829;
        bh=V9sTFQERjNMBCKlK+chFi8htr5xGiz1UWzM0Jgp/e/o=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=J5hlXRSgKB3xfI0sxujOqVopyqDR1n8rZ9QWipR4jNHyJ10devrmhBNZ4w/4s75Wd
         hcLWYqqs1AFnUWTRXKJskGJtV32Cj1nYGQ6kky8+jzZ5xYpH/kWzf3ssLs9DieCv1X
         F9bJPCYEAwQogGeXB9KdvrilINIro6pCFFBPmP01ToDi1HpF3A3Kz4Avp5BTQ/b0Ks
         4i26wWiKL1lrghUiQdxYfhit3o9TGsrrocQJlbUvcgswhN2Rbo6u0YBmp0nK4idBdG
         UntScXEKRlTk+Ae6DaNLDjVX8RnZxF/b9gEwsmyE5XJz9x/onZLuJJlRAnPqKVQIT3
         q5iW4RUh9HPcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 16E60C7619A;
        Sun, 16 Apr 2023 08:47:09 +0000 (UTC)
From:   Yang Xiwen via B4 Relay 
        <devnull+forbidden405.outlook.com@kernel.org>
Date:   Sun, 16 Apr 2023 16:46:01 +0800
Subject: [PATCH RFC v3 3/4] dt-binding: mmc: hi3798cv200-dw-mshc: convert
 to YAML and rename to histb-dw-mshc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230415-mmc-hi3798mv200-v3-3-00e2368c0709@outlook.com>
References: <20230415-mmc-hi3798mv200-v3-0-00e2368c0709@outlook.com>
In-Reply-To: <20230415-mmc-hi3798mv200-v3-0-00e2368c0709@outlook.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yang Xiwen <forbidden405@outlook.com>
Cc:     tianshuliang <tianshuliang@hisilicon.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        David Yang <mmyangfl@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681634825; l=4079;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=cbsKBjsjU3CIDW9tEpwhQdbd51tcFrBuqYrGKC8a2uw=;
 b=+tEngQQj4AT/9BBPyp2Xl5avlbKqAfcwtJ9fHwKRWQnVBkEa7/cSpYh5zRfac0rNOk/QhG7MH
 J45Jp0OEig5DE4kO7cP9c4c1RuDIfARPcg1b8Mc4nXkuP04H2Ddhw4i
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=hfdpPU3AXR+t7fdv58tXCD4UzRNq+fop2TMJezFlAhM=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230415 with auth_id=44
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Xiwen <forbidden405@outlook.com>

The renaming is due to the fact that it is now supporting SoCs other
than Hi3798CV200.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../bindings/mmc/hi3798cv200-dw-mshc.txt           | 40 -------------
 .../devicetree/bindings/mmc/histb-dw-mshc.yaml     | 69 ++++++++++++++++++++++
 2 files changed, 69 insertions(+), 40 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.txt
deleted file mode 100644
index a0693b7145f2a..0000000000000
--- a/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-* Hisilicon Hi3798CV200 specific extensions to the Synopsys Designware Mobile
-  Storage Host Controller
-
-Read synopsys-dw-mshc.txt for more details
-
-The Synopsys designware mobile storage host controller is used to interface
-a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
-differences between the core Synopsys dw mshc controller properties described
-by synopsys-dw-mshc.txt and the properties used by the Hisilicon Hi3798CV200
-specific extensions to the Synopsys Designware Mobile Storage Host Controller.
-
-Required Properties:
-- compatible: Should contain "hisilicon,hi3798cv200-dw-mshc".
-- clocks: A list of phandle + clock-specifier pairs for the clocks listed
-  in clock-names.
-- clock-names: Should contain the following:
-	"ciu" - The ciu clock described in synopsys-dw-mshc.txt.
-	"biu" - The biu clock described in synopsys-dw-mshc.txt.
-	"ciu-sample" - Hi3798CV200 extended phase clock for ciu sampling.
-	"ciu-drive"  - Hi3798CV200 extended phase clock for ciu driving.
-
-Example:
-
-	emmc: mmc@9830000 {
-		compatible = "hisilicon,hi3798cv200-dw-mshc";
-		reg = <0x9830000 0x10000>;
-		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&crg HISTB_MMC_CIU_CLK>,
-			 <&crg HISTB_MMC_BIU_CLK>,
-			 <&crg HISTB_MMC_SAMPLE_CLK>,
-			 <&crg HISTB_MMC_DRV_CLK>;
-		clock-names = "ciu", "biu", "ciu-sample", "ciu-drive";
-		fifo-depth = <256>;
-		clock-frequency = <200000000>;
-		cap-mmc-highspeed;
-		mmc-ddr-1_8v;
-		mmc-hs200-1_8v;
-		non-removable;
-		bus-width = <8>;
-	};
diff --git a/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
new file mode 100644
index 0000000000000..4711ad293b9e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/histb-dw-mshc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:
+  Hisilicon HiSTB SoC specific extensions to the Synopsys Designware Mobile
+  Storage Host Controller
+
+maintainers:
+  - Yang Xiwen <forbidden405@outlook.com>
+
+description:
+  The Synopsys designware mobile storage host controller is used to interface a
+  SoC with storage medium such as eMMC or SD/MMC cards.
+
+properties:
+  compatible:
+    enum:
+      - hisilicon,hi3798cv200-dw-mshc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 4
+
+  clock-names:
+    items:
+      - const: ciu
+      - const: biu
+      - const: ciu-sample
+      - const: ciu-drive
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: synopsys-dw-mshc-common.yaml#
+
+examples:
+  - |
+    emmc: mmc@9830000 {
+      compatible = "hisilicon,hi3798cv200-dw-mshc";
+      reg = <0x9830000 0x10000>;
+      interrupts = <35>;
+      clocks = <&crg 1>,
+               <&crg 2>,
+               <&crg 3>,
+               <&crg 4>;
+      clock-names = "ciu", "biu", "ciu-sample", "ciu-drive";
+      fifo-depth = <256>;
+      clock-frequency = <200000000>;
+      cap-mmc-highspeed;
+      mmc-ddr-1_8v;
+      mmc-hs200-1_8v;
+      non-removable;
+      bus-width = <8>;
+    };

-- 
2.39.2

