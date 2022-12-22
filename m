Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F03654117
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbiLVMdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbiLVMdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:33:10 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E82E21829;
        Thu, 22 Dec 2022 04:33:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2814B152B;
        Thu, 22 Dec 2022 04:33:47 -0800 (PST)
Received: from e126835.arm.com (unknown [10.57.87.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CBA93FA32;
        Thu, 22 Dec 2022 04:33:01 -0800 (PST)
From:   Emekcan Aras <emekcan.aras@arm.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Miguel Silva <rui.silva@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Emekcan Aras <emekcan.aras@arm.com>
Subject: [PATCH v3 2/2] dt-bindings: Add Arm corstone500 platform
Date:   Thu, 22 Dec 2022 12:32:44 +0000
Message-Id: <20221222123244.147238-3-emekcan.aras@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222123244.147238-1-emekcan.aras@arm.com>
References: <20221222123244.147238-1-emekcan.aras@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings to describe implementation of
the ARM Corstone500 platform.

Signed-off-by: Emekcan Aras <emekcan.aras@arm.com>
---
 .../bindings/arm/arm,corstone500.yaml         | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,corstone500.yaml

diff --git a/Documentation/devicetree/bindings/arm/arm,corstone500.yaml b/Documentation/devicetree/bindings/arm/arm,corstone500.yaml
new file mode 100644
index 000000000000..cfe41f7760fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arm,corstone500.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/arm,corstone500.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Corstone500
+
+maintainers:
+  - Emekcan Aras <emekcan.aras@arm.com>
+  - Rui Miguel Silva <rui.silva@linaro.org>
+
+description: |+
+  Corstone-500 is an ideal starting point for feature rich System on Chip
+  (SoC) designs based on the Cortex-A5 core. These designs can be used in
+  Internet of Things (IoT) and embedded products.
+
+  Corstone-500 includes most of the Arm IP in the SSE-500 subsystem and
+  example integration layer, an FPGA, and access to modelling options.
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - const: arm,corstone500
+
+additionalProperties: true
+
+...
-- 
2.25.1

