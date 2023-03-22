Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CAD6C5286
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjCVRfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCVRfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:35:05 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EA5442F7;
        Wed, 22 Mar 2023 10:35:03 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id m20-20020a9d6094000000b0069caf591747so10792937otj.2;
        Wed, 22 Mar 2023 10:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679506503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4iBFMrGCXs7aCaesF7jmbgEDqOsWeQiS1SA88xm+gP4=;
        b=imDww5pmXMMgcLK5+/NoK5x002oQhkFKrWjKCCNDNWkkfA4RFSUSu7LgNAzX6Q3OZa
         qzpOp4WJmIAiR5NeLQ1JEl4n4KMyZFRn/Lxg/wS40nVdhc1qqjA46XS6lWzo9CzXE+40
         rkl+ZmIguZOzwdygGeae8CKKvGIJmmaba/L4CFXPMxV55fIJhBGIifzXwnC3L8gBc3Ak
         KcbrI0iU7WdLonRO/Qszmiw7XumhpuYehDwjAbtl1CiJw9pPx7twloKYlT5RMdnOuzLq
         PATb5pEOEnDHQ4qObC6f7b5ez/AdejYJxM4YffANtAmPFY3hhCGPGenQl9EATeBtiqx+
         +n5A==
X-Gm-Message-State: AO0yUKWZYNtgzwH+fM9mtG0dK4hcKjyFOs3l70Z731nXHX90Q+fuqwAS
        xzUtK7qpkoLuRA07F9QbQg==
X-Google-Smtp-Source: AK7set8m4syrOCyuvx0eJfcZmRDih7NX1pwJMSBfADgJk63vKLPYr43ZCbmjV3U24/oNGz5bTTge9g==
X-Received: by 2002:a05:6830:129a:b0:69f:289:1fe9 with SMTP id z26-20020a056830129a00b0069f02891fe9mr2058230otp.17.1679506502895;
        Wed, 22 Mar 2023 10:35:02 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l26-20020a0568301d7a00b0069fa776d3c2sm162320oti.18.2023.03.22.10.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:34:58 -0700 (PDT)
Received: (nullmailer pid 3970918 invoked by uid 1000);
        Wed, 22 Mar 2023 17:34:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] dt-bindings: mailbox: Drop unneeded quotes
Date:   Wed, 22 Mar 2023 12:34:48 -0500
Message-Id: <20230322173449.3970718-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mailbox/amlogic,meson-gxbb-mhu.yaml   | 4 ++--
 .../devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml   | 4 ++--
 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml    | 4 ++--
 Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml   | 4 ++--
 Documentation/devicetree/bindings/mailbox/st,stm32-ipcc.yaml  | 4 ++--
 .../devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml  | 4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/amlogic,meson-gxbb-mhu.yaml b/Documentation/devicetree/bindings/mailbox/amlogic,meson-gxbb-mhu.yaml
index dfd26b998189..385809ed1569 100644
--- a/Documentation/devicetree/bindings/mailbox/amlogic,meson-gxbb-mhu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/amlogic,meson-gxbb-mhu.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 BayLibre, SAS
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/mailbox/amlogic,meson-gxbb-mhu.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/mailbox/amlogic,meson-gxbb-mhu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic Meson Message-Handling-Unit Controller
 
diff --git a/Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml
index 935937c67133..404477910f02 100644
--- a/Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/mailbox/microchip,mpfs-mailbox.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/mailbox/microchip,mpfs-mailbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Microchip PolarFire SoC (MPFS) MSS (microprocessor subsystem) mailbox controller
 
diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index d888ead09282..7f18fb10435d 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/mailbox/qcom,apcs-kpss-global.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/mailbox/qcom,apcs-kpss-global.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm APCS global block
 
diff --git a/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
index bdfb4a8220c5..b526f9c0c272 100644
--- a/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/mailbox/sprd-mailbox.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/mailbox/sprd-mailbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Spreadtrum mailbox controller
 
diff --git a/Documentation/devicetree/bindings/mailbox/st,stm32-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/st,stm32-ipcc.yaml
index 0dfe05a04dd0..134fd223a02b 100644
--- a/Documentation/devicetree/bindings/mailbox/st,stm32-ipcc.yaml
+++ b/Documentation/devicetree/bindings/mailbox/st,stm32-ipcc.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/mailbox/st,stm32-ipcc.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/mailbox/st,stm32-ipcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: STMicroelectronics STM32 IPC controller
 
diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
index 2193141dd7fd..45df46343f6a 100644
--- a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/mailbox/xlnx,zynqmp-ipi-mailbox.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/mailbox/xlnx,zynqmp-ipi-mailbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Xilinx IPI(Inter Processor Interrupt) mailbox controller
 
-- 
2.39.2

