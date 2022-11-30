Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFD363D394
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbiK3KjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbiK3KjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:39:18 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B7F2CE12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:39:17 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id f9so15645661pgf.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFaikCDnpsIUMnEwr90IPLfSx9vYLL7iMVX39oo84vU=;
        b=cZ0sw0r0q2/k3IxlWLJ5pn9C2ezYz+dbjNpzcIPmBVJi+TNFApY4nFDoAgqRhaZwvG
         gTGJI9BVrdLVs48A0ccCIITK0BUpKgr33Q7fMWYoKUzVf81Dx4RPym9keoSoydhZ7Tdm
         q2vwsaR1MgfK1/A3GOb3Hh4neB4LRTnx82TbKtkx0cHIUHSYUm5R4VzDIbLA7VB7eMbT
         8P7iGvt7sI4YOlljPtWhUCoB9AwgAlvUyX/tHaTw9kby02AbyrTbbRTealqBfUyT099I
         as6GOFcV6G9/7bHHSjcugV+ooIPO6p/rtRbM+KIothcrDZNUzKVMDwGctKtbQMA3fDks
         ckqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFaikCDnpsIUMnEwr90IPLfSx9vYLL7iMVX39oo84vU=;
        b=yySgK+InN+hnLXmDI39EhS0CvkLRbvDQMglAppyeTkzpUGphJ6PYJZSAPkLN4c0eCz
         n0jFmwyo9dQPeSrbjOOywQFR3r4NHTO8F+w3lMBEjp1aFZ1LnxveEdLEZhe9RQTrBQV/
         IkDIkCXXwzSbBM4hOGAM7WZeBls7tLxAQ0HDlMbysCIkFedehYdAK2mGMzzZaArNHYEe
         x3txQfGDQB8h1EwQXFa4zCkE4k44Yt/70hISQ6D94z/HcvQA7opLVv692xrwT9Quh1+n
         fw1lOxDgyva7Al4+XCB+UDP9TIlDZakJR1EqhJ4uH0a26ptdCPo+N7GqILN5vFbAl0JQ
         IMug==
X-Gm-Message-State: ANoB5pnRSoXycqlU86ACbgyB7w2OdXp6H1fIsJCcxq6Jg+JDIrjhtaY7
        1b2T3qtE90qN09bgOSxoNZCuGSj0DqxPBQ==
X-Google-Smtp-Source: AA0mqf5lxxj9H/bA04DI0e855UQIBOTRIGQPj2YKYQAbWNnxm+fS7MHFasu4ga1GXKMxXgMBZpMHLQ==
X-Received: by 2002:a63:5857:0:b0:46f:9763:a37b with SMTP id i23-20020a635857000000b0046f9763a37bmr39452822pgm.177.1669804756858;
        Wed, 30 Nov 2022 02:39:16 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c5f:27a2:d13a:7614:addb:b29d])
        by smtp.gmail.com with ESMTPSA id b207-20020a621bd8000000b00562677968aesm1098012pfb.72.2022.11.30.02.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 02:39:16 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        djakov@kernel.org, konrad.dybcio@linaro.org, a39.skl@gmail.com,
        andersson@kernel.org
Subject: [PATCH 2/2] dt-bindings: interconnect: Add SM6115 DT bindings
Date:   Wed, 30 Nov 2022 16:08:41 +0530
Message-Id: <20221130103841.2266464-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130103841.2266464-1-bhupesh.sharma@linaro.org>
References: <20221130103841.2266464-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SM6115 SoC has several bus fabrics that could be
controlled and tuned dynamically according to the bandwidth demand.

Add the support for the same.

Cc: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../bindings/interconnect/qcom,sm6115.yaml    | 137 ++++++++++++++++++
 .../dt-bindings/interconnect/qcom,sm6115.h    | 115 +++++++++++++++
 2 files changed, 252 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm6115.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,sm6115.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm6115.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm6115.yaml
new file mode 100644
index 000000000000..f8ffc4360727
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm6115.yaml
@@ -0,0 +1,137 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sm6115.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM6115 Network-On-Chip interconnect
+
+maintainers:
+  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
+
+description: |
+  The Qualcomm SM6115 interconnect providers support adjusting the
+  bandwidth requirements between the various NoC fabrics.
+
+properties:
+  reg:
+    maxItems: 1
+
+  compatible:
+    enum:
+      - qcom,sm6115-bimc
+      - qcom,sm6115-cnoc
+      - qcom,sm6115-snoc
+
+  '#interconnect-cells':
+    const: 1
+
+  clock-names:
+    items:
+      - const: bus
+      - const: bus_a
+
+  clocks:
+    items:
+      - description: Bus Clock
+      - description: Bus A Clock
+
+# Child node's properties
+patternProperties:
+  '^interconnect-[a-z0-9]+$':
+    type: object
+    description:
+      The interconnect providers do not have a separate QoS register space,
+      but share parent's space.
+
+    properties:
+      compatible:
+        enum:
+          - qcom,sm6115-clk-virt
+          - qcom,sm6115-mmrt-virt
+          - qcom,sm6115-mmnrt-virt
+
+      '#interconnect-cells':
+        const: 1
+
+      clock-names:
+        items:
+          - const: bus
+          - const: bus_a
+
+      clocks:
+        items:
+          - description: Bus Clock
+          - description: Bus A Clock
+
+    required:
+      - compatible
+      - '#interconnect-cells'
+      - clock-names
+      - clocks
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - '#interconnect-cells'
+  - clock-names
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+
+    snoc: interconnect@1880000 {
+        compatible = "qcom,sm6115-snoc";
+        reg = <0x01880000 0x60200>;
+        #interconnect-cells = <1>;
+        clock-names = "bus", "bus_a";
+        clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+                 <&rpmcc RPM_SMD_SNOC_A_CLK>;
+
+        clk_virt: interconnect-clk {
+            compatible = "qcom,sm6115-clk-virt";
+            #interconnect-cells = <1>;
+            clock-names = "bus", "bus_a";
+            clocks = <&rpmcc RPM_SMD_QUP_CLK>,
+                     <&rpmcc RPM_SMD_QUP_A_CLK>;
+        };
+
+        mmnrt_virt: interconnect-mmnrt {
+            compatible = "qcom,sm6115-mmnrt-virt";
+            #interconnect-cells = <1>;
+            clock-names = "bus", "bus_a";
+            clocks = <&rpmcc RPM_SMD_MMNRT_CLK>,
+                     <&rpmcc RPM_SMD_MMNRT_A_CLK>;
+        };
+
+        mmrt_virt: interconnect-mmrt {
+            compatible = "qcom,sm6115-mmrt-virt";
+            #interconnect-cells = <1>;
+            clock-names = "bus", "bus_a";
+            clocks = <&rpmcc RPM_SMD_MMRT_CLK>,
+                     <&rpmcc RPM_SMD_MMRT_A_CLK>;
+        };
+    };
+
+    cnoc: interconnect@1900000 {
+        compatible = "qcom,sm6115-cnoc";
+        reg = <0x01900000 0x8200>;
+        #interconnect-cells = <1>;
+        clock-names = "bus", "bus_a";
+        clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
+                 <&rpmcc RPM_SMD_CNOC_A_CLK>;
+    };
+
+    bimc: interconnect@4480000 {
+        compatible = "qcom,sm6115-bimc";
+        reg = <0x04480000 0x80000>;
+        #interconnect-cells = <1>;
+        clock-names = "bus", "bus_a";
+        clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+                 <&rpmcc RPM_SMD_BIMC_A_CLK>;
+    };
diff --git a/include/dt-bindings/interconnect/qcom,sm6115.h b/include/dt-bindings/interconnect/qcom,sm6115.h
new file mode 100644
index 000000000000..2997106a661e
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sm6115.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Qualcomm SM6115 interconnect IDs
+ *
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM6115_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SM6115_H
+
+/* BIMC */
+#define MASTER_AMPSS_M0				0
+#define MASTER_SNOC_BIMC_RT			1
+#define MASTER_SNOC_BIMC_NRT			2
+#define MASTER_SNOC_BIMC			3
+#define MASTER_GRAPHICS_3D			4
+#define MASTER_TCU_0				5
+#define SLAVE_EBI_CH0				6
+#define SLAVE_BIMC_SNOC				7
+
+/* CNOC */
+#define MASTER_SNOC_CNOC			0
+#define MASTER_QDSS_DAP				1
+#define SLAVE_AHB2PHY_USB			2
+#define SLAVE_APSS_THROTTLE_CFG			3
+#define SLAVE_BIMC_CFG				4
+#define SLAVE_BOOT_ROM				5
+#define SLAVE_CAMERA_NRT_THROTTLE_CFG		6
+#define SLAVE_CAMERA_RT_THROTTLE_CFG		7
+#define SLAVE_CAMERA_CFG			8
+#define SLAVE_CLK_CTL				9
+#define SLAVE_RBCPR_CX_CFG			10
+#define SLAVE_RBCPR_MX_CFG			11
+#define SLAVE_CRYPTO_0_CFG			12
+#define SLAVE_DCC_CFG				13
+#define SLAVE_DDR_PHY_CFG			14
+#define SLAVE_DDR_SS_CFG			15
+#define SLAVE_DISPLAY_CFG			16
+#define SLAVE_DISPLAY_THROTTLE_CFG		17
+#define SLAVE_GPU_CFG				18
+#define SLAVE_GPU_THROTTLE_CFG			19
+#define SLAVE_HWKM_CORE				20
+#define SLAVE_IMEM_CFG				21
+#define SLAVE_IPA_CFG				22
+#define SLAVE_LPASS				23
+#define SLAVE_MAPSS				24
+#define SLAVE_MDSP_MPU_CFG			25
+#define SLAVE_MESSAGE_RAM			26
+#define SLAVE_CNOC_MSS				27
+#define SLAVE_PDM				28
+#define SLAVE_PIMEM_CFG				29
+#define SLAVE_PKA_CORE				30
+#define SLAVE_PMIC_ARB				31
+#define SLAVE_QDSS_CFG				32
+#define SLAVE_QM_CFG				33
+#define SLAVE_QM_MPU_CFG			34
+#define SLAVE_QPIC				35
+#define SLAVE_QUP_0				36
+#define SLAVE_RPM				37
+#define SLAVE_SDCC_1				38
+#define SLAVE_SDCC_2				39
+#define SLAVE_SECURITY				40
+#define SLAVE_SNOC_CFG				41
+#define SLAVE_TCSR				42
+#define SLAVE_TLMM				43
+#define SLAVE_USB3				44
+#define SLAVE_VENUS_CFG				45
+#define SLAVE_VENUS_THROTTLE_CFG		46
+#define SLAVE_VSENSE_CTRL_CFG			47
+#define SLAVE_SERVICE_CNOC			48
+
+/* SNOC */
+#define MASTER_SNOC_CFG				0
+#define MASTER_TIC				1
+#define MASTER_ANOC_SNOC			2
+#define MASTER_BIMC_SNOC			3
+#define MASTER_PIMEM				4
+#define MASTER_CRVIRT_A1NOC			5
+#define MASTER_QDSS_BAM				6
+#define MASTER_QPIC				7
+#define MASTER_QUP_0				8
+#define MASTER_IPA				9
+#define MASTER_QDSS_ETR				10
+#define MASTER_SDCC_1				11
+#define MASTER_SDCC_2				12
+#define MASTER_USB3				13
+#define SLAVE_APPSS				14
+#define SLAVE_SNOC_CNOC				15
+#define SLAVE_OCIMEM				16
+#define SLAVE_PIMEM				17
+#define SLAVE_SNOC_BIMC				18
+#define SLAVE_SERVICE_SNOC			19
+#define SLAVE_QDSS_STM				20
+#define SLAVE_TCU				21
+#define SLAVE_ANOC_SNOC				22
+
+/* CLK VIRT */
+#define MASTER_QUP_CORE_0			0
+#define MASTER_CRYPTO_CORE0			1
+#define SLAVE_QUP_CORE_0			2
+#define SLAVE_CRVIRT_A1NOC			3
+
+/* MMNRT Virtual */
+#define MASTER_CAMNOC_SF			0
+#define MASTER_VIDEO_P0				1
+#define MASTER_VIDEO_PROC			2
+#define SLAVE_SNOC_BIMC_NRT			3
+
+/* MMRT Virtual */
+#define MASTER_CAMNOC_HF			0
+#define MASTER_MDP_PORT0			1
+#define SLAVE_SNOC_BIMC_RT			2
+
+#endif
-- 
2.38.1

