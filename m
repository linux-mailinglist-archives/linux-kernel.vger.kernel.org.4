Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DD75B56B5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiILIvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiILIv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:51:26 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A892B192
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:51:15 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id e68so7966336pfe.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=cW0iJRf8+xA5COcXhAJlFmlOVxkiZHTZTL93C3LInnc=;
        b=srYaZbbQ+5ULu/L0xi/5apWf3Fm7EWWe9T3NJjdWY7T4y1QltC/uAf2AxZK0toIecP
         EpzyZMldCUZm6CXBfx65FpzzXhsE2BuwX4YvynXPDupeTV2hw1Q0i1PnTBvqcL/7QrGR
         YQ9fBYNymtPPRGdhKmboNt4/7HjIjqqRBSQt5UIu5sriJAAheKJlED0LmHGiKWFZnlQd
         INpQBVonBqXENyVM5UAf0H/ftRi9Ujh8vIZKATl/3mdmxncb4qUOzRhITLSE1k+1UtRE
         iO4HpkUFtobSw8mb+i8HWNzgoLqkRfPmBKdYpxzKzGzz/SmuClIKp9yU+iMNi8C7kr/f
         Xe2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cW0iJRf8+xA5COcXhAJlFmlOVxkiZHTZTL93C3LInnc=;
        b=7RoJ6PAzNOHd6v7VhmmbUHtTL96ADfq3nYT7ev2/Tzwq7IcUoGMvrOf3DoQ8165lS5
         khf4Ts7jgo9+hSI6VLY44QmWTLkrTN4zP8px0tr9rgXwrhia7YX9NdrDlIMzUqrHkFmI
         0HflSqtID2hXd1NMzH1iyP9Fng4M08ILm4hsj7L+Lh88kL9HEJFHZMWdW2FnjJLv6n3w
         a5kwQsUg5xn003TbQhTo9rHtHBrBmU4BLAfW6mMXijw4hslcMdaUGmktzt5qiBuT+9yj
         j+pMUUSIt4ua6Iv6ZGaOH45bBUgUUrtNuUvyDzpXdvtGtjp7RxRNCVG8KFnnZpc+aRvN
         isNA==
X-Gm-Message-State: ACgBeo123ZWCbM2WHlxxrpWnENEXpgW2vpbDv0zOBCFEhGtu7YsCck16
        iVETNA/UIKwIBcVfS+qyYJg0Exy0ok5tKw==
X-Google-Smtp-Source: AA6agR4x7RI96Nnn/97AnsXd8xxocHTttbzDxD1tIBMmjqvnswDLArR+mDoLRJ5Q33zDr+pXChusIA==
X-Received: by 2002:a63:ff55:0:b0:438:fa5d:af36 with SMTP id s21-20020a63ff55000000b00438fa5daf36mr3754995pgk.533.1662972675200;
        Mon, 12 Sep 2022 01:51:15 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:5362:9d7f:2354:1d0a:78e3])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f54d00b00172897952a0sm5326699plf.283.2022.09.12.01.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 01:51:14 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh@kernel.org, andersson@kernel.org,
        rafael@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com
Subject: [PATCH 3/4] dt-bindings: thermal: Add qcom,qmi-tmd-device and qcom,tmd-device yaml bindings
Date:   Mon, 12 Sep 2022 14:20:48 +0530
Message-Id: <20220912085049.3517140-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220912085049.3517140-1-bhupesh.sharma@linaro.org>
References: <20220912085049.3517140-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qcom,qmi-tmd-device and qcom,tmd-device yaml bindings.

Qualcomm QMI based TMD cooling device(s) are used for various
mitigations for remote subsystem(s) including remote processor
mitigation, rail voltage restriction etc.

Each child node represents one remote subsystem and each child
of this subsystem in-turn represents separate TMD cooling device.

Cc: daniel.lezcano@linaro.org
Cc: rafael@kernel.org
Cc: andersson@kernel.org
Cc: robh@kernel.org
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../bindings/thermal/qcom,qmi-tmd-device.yaml |  78 +++++++++++
 .../bindings/thermal/qcom,tmd-device.yaml     | 122 ++++++++++++++++++
 include/dt-bindings/thermal/qcom,tmd.h        |  14 ++
 3 files changed, 214 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-tmd-device.yaml
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom,tmd-device.yaml
 create mode 100644 include/dt-bindings/thermal/qcom,tmd.h

diff --git a/Documentation/devicetree/bindings/thermal/qcom,qmi-tmd-device.yaml b/Documentation/devicetree/bindings/thermal/qcom,qmi-tmd-device.yaml
new file mode 100644
index 000000000000..dfda5b611a93
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom,qmi-tmd-device.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/thermal/qcom,qmi-tmd-device.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm QMI based thermal mitigation (TMD) cooling devices.
+
+maintainers:
+  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
+
+description:
+  Qualcomm QMI based TMD cooling device(s) are used for various
+  mitigations for remote subsystem(s) including remote processor
+  mitigation, rail voltage restriction etc.
+
+properties:
+  $nodename:
+    const: qmi-tmd-devices
+
+  compatible:
+    items:
+      - const: qcom,qmi-tmd-devices
+
+  modem0:
+    $ref: /schemas/thermal/qcom,tmd-device.yaml#
+
+  adsp:
+    $ref: /schemas/thermal/qcom,tmd-device.yaml#
+
+  cdsp:
+    $ref: /schemas/thermal/qcom,tmd-device.yaml#
+
+  slpi:
+    $ref: /schemas/thermal/qcom,tmd-device.yaml#
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/thermal/qcom,tmd.h>
+    qmi-tmd-devices {
+      compatible = "qcom,qmi-tmd-devices";
+
+      modem0 {
+        qcom,instance-id = <MODEM0_INSTANCE_ID>;
+
+        modem0_pa: tmd-device0 {
+          label = "pa";
+          #cooling-cells = <2>;
+        };
+
+        modem0_proc: tmd-device1 {
+          label = "modem";
+          #cooling-cells = <2>;
+        };
+
+        modem0_current: tmd-device2 {
+          label = "modem_current";
+          #cooling-cells = <2>;
+        };
+
+        modem0_skin: tmd-device3 {
+          label = "modem_skin";
+          #cooling-cells = <2>;
+        };
+
+        modem0_vdd: tmd-device4 {
+          label = "cpuv_restriction_cold";
+          #cooling-cells = <2>;
+        };
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/thermal/qcom,tmd-device.yaml b/Documentation/devicetree/bindings/thermal/qcom,tmd-device.yaml
new file mode 100644
index 000000000000..38ac62f03376
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom,tmd-device.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/thermal/qcom,tmd-device.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm thermal mitigation (TMD) cooling devices
+
+maintainers:
+  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
+
+description:
+  Qualcomm thermal mitigation (TMD) cooling devices. Each child node
+  represents one remote subsystem and each child of this subsystem in-turn
+  represents separate cooling devices.
+
+properties:
+  $nodename:
+    pattern: "^(modem|adsp|cdsp|slpi[0-9])?$"
+
+  qcom,instance-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Remote subsystem QMI server instance id to be used for communicating with QMI.
+
+patternProperties:
+  "^tmd-device[0-9]?$":
+    type: object
+    description:
+      Subnodes indicating tmd cooling device of a specific category.
+    properties:
+      label:
+        maxItems: 1
+        description: |
+          Remote subsystem device identifier. Acceptable device names -
+          "pa" -> for pa cooling device,
+          "cpuv_restriction_cold" -> for vdd restriction,
+          "cx_vdd_limit" -> for vdd limit,
+          "modem" -> for processor passive cooling device,
+          "modem_current" -> for current limiting device,
+          "modem_bw" ->  for bus bandwidth limiting device,
+          "cpr_cold" -> for cpr restriction.
+
+      "#cooling-cells":
+        const: 2
+
+    required:
+      - label
+      - "#cooling-cells"
+
+    additionalProperties: false
+
+required:
+  - qcom,instance-id
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/thermal/qcom,tmd.h>
+    modem0 {
+      qcom,instance-id = <MODEM0_INSTANCE_ID>;
+
+      modem0_pa: tmd-device0 {
+        label = "pa";
+        #cooling-cells = <2>;
+      };
+
+      modem0_proc: tmd-device1 {
+        label = "modem";
+        #cooling-cells = <2>;
+      };
+
+      modem0_current: tmd-device2 {
+        label = "modem_current";
+        #cooling-cells = <2>;
+      };
+
+      modem0_skin: tmd-device3 {
+        label = "modem_skin";
+        #cooling-cells = <2>;
+      };
+
+      modem0_vdd: tmd-device4 {
+        label = "cpuv_restriction_cold";
+        #cooling-cells = <2>;
+      };
+    };
+
+  - |
+    #include <dt-bindings/thermal/qcom,tmd.h>
+    adsp {
+      qcom,instance-id = <ADSP_INSTANCE_ID>;
+
+      adsp_vdd: tmd-device1 {
+        label = "cpuv_restriction_cold";
+        #cooling-cells = <2>;
+      };
+    };
+
+  - |
+    #include <dt-bindings/thermal/qcom,tmd.h>
+    cdsp {
+      qcom,instance-id = <CDSP_INSTANCE_ID>;
+
+      cdsp_vdd: tmd-device1 {
+        label = "cpuv_restriction_cold";
+        #cooling-cells = <2>;
+      };
+    };
+
+  - |
+    #include <dt-bindings/thermal/qcom,tmd.h>
+    slpi {
+      qcom,instance-id = <SLPI_INSTANCE_ID>;
+
+      slpi_vdd: tmd-device1 {
+        label = "cpuv_restriction_cold";
+        #cooling-cells = <2>;
+      };
+    };
diff --git a/include/dt-bindings/thermal/qcom,tmd.h b/include/dt-bindings/thermal/qcom,tmd.h
new file mode 100644
index 000000000000..5ede4422e04e
--- /dev/null
+++ b/include/dt-bindings/thermal/qcom,tmd.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for the Qualcomm TMD instances.
+ */
+
+#ifndef _DT_BINDINGS_THERMAL_QCOM_TMD_H_
+#define _DT_BINDINGS_THERMAL_QCOM_TMD_H_
+
+#define MODEM0_INSTANCE_ID	0x0
+#define ADSP_INSTANCE_ID	0x1
+#define CDSP_INSTANCE_ID	0x43
+#define SLPI_INSTANCE_ID	0x53
+
+#endif
-- 
2.37.1

