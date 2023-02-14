Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417F8696945
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjBNQXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjBNQXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:23:36 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FA222786
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:23:29 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id gn39so3123090ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ho3W5bzFPULTUWzadsK5pu3BzadwOuUIPmOvHHDXQeo=;
        b=giXtfREYAqOOutYXBXceTYvikLUhStzroO5RV1ME2JC4qcOZvI5aIJ2NAS7A2jSdLq
         /5F1IWf6HQJL5EKIt7ZKju7oHlHhl4E/0N2B4M5fbcjUpcBQ/PjYQPpc1GLH2t7mJNcP
         ApCiHEd1hvmXTHkbeTm4TE6lM9oOO7R6q2ldLDj80NvDXPw/38128vD8HjGI/kidNOXD
         JOpsGD9RSuprwVxC8uoifM2XcvAwwsAloIUr/VR/RwkYPNKB0JaJddqk9ePktG6lmEp7
         5efEK1stbx7Rlwxi0l93t2DbF3C+CYS6xd77b3YnXqs2OG1TE/rQhwSAsChFTFPsKQLF
         n1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ho3W5bzFPULTUWzadsK5pu3BzadwOuUIPmOvHHDXQeo=;
        b=mElBANZMnJwYuhDjfb4g8HDIi7M12X1Vu2ueCOepOA1qeOhkVmzJtEGIa/lsC+Hfum
         tLRZa0ggJZF0K6dPRSMx2FcZ2oqQXWFZByjzncYAZGm+zLxbEZorCZiT736CCdX3PzHD
         XkYiI+VOT2vE8FVebSr2ZhhBdeMbWWlR+J/ebNaQkFxsG+tvTlE+D4ZRe50Kx91ZXIEO
         mA0OjeiGVaIHtXI7NsOQbjFdh/SkHUs1n6IF0JM4KUD3ZnbARD3ftioiJ0iSkDjqDKBa
         9ikowKeWSqWfZ1kuXPHf25mP7W2lbX6Y44t5snBzWDqGh/N12DlQxaJbk84nBsfpCmdv
         PG6A==
X-Gm-Message-State: AO0yUKUQ9dMqo9cH4xOzYSCcaHun/2+sZRjAucFSqx5vil0liZ8TRMAI
        cDnvj3tW0Iq+Cmk309IQgosUKw==
X-Google-Smtp-Source: AK7set8+7D22lJZ4bzs8ZV904jT3DvukWZwVtXIDVgJ1bizVPlfd0MknPDf5B1eGeOnE+Tscypb+PA==
X-Received: by 2002:a17:906:2a15:b0:877:a2d1:7560 with SMTP id j21-20020a1709062a1500b00877a2d17560mr3495407eje.27.1676391807816;
        Tue, 14 Feb 2023 08:23:27 -0800 (PST)
Received: from fedora.. (cpezg-94-253-130-165-cbl.xnet.hr. [94.253.130.165])
        by smtp.googlemail.com with ESMTPSA id bp8-20020a170907918800b008806a3c22c5sm1318027ejb.25.2023.02.14.08.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 08:23:27 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/7] dt-bindings: clock: split qcom,gcc-ipq4019 to separate file
Date:   Tue, 14 Feb 2023 17:23:19 +0100
Message-Id: <20230214162325.312057-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move schema for the GCC on IPQ4019 platform to a separate file to be able
to allow passing XO and sleep clks directly to GCC.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../bindings/clock/qcom,gcc-ipq4019.yaml      | 53 +++++++++++++++++++
 .../bindings/clock/qcom,gcc-other.yaml        |  2 -
 2 files changed, 53 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml
new file mode 100644
index 0000000000000..6ebaef2288fa3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,gcc-ipq4019.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller on IPQ4019
+
+maintainers:
+  - Stephen Boyd <sboyd@kernel.org>
+  - Taniya Das <tdas@codeaurora.org>
+  - Robert Marko <robert.markoo@sartura.hr>
+
+description: |
+  Qualcomm global clock control module provides the clocks, resets and power
+  domains on IPQ4019.
+
+  See also:: include/dt-bindings/clock/qcom,gcc-ipq4019.h
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+properties:
+  compatible:
+    const: qcom,gcc-ipq4019
+
+  clocks:
+    items:
+      - description: board XO clock
+      - description: sleep clock
+
+  clock-names:
+    items:
+      - const: xo
+      - const: sleep_clk
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    clock-controller@1800000 {
+      compatible = "qcom,gcc-ipq4019";
+      reg = <0x1800000 0x60000>;
+      #clock-cells = <1>;
+      #power-domain-cells = <1>;
+      #reset-cells = <1>;
+      clocks = <&xo>, <&sleep_clk>;
+      clock-names = "xo", "sleep_clk";
+    };
+...
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
index 2e8acca64af1c..ae01e77495342 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
@@ -15,7 +15,6 @@ description: |
   domains.
 
   See also::
-    include/dt-bindings/clock/qcom,gcc-ipq4019.h
     include/dt-bindings/clock/qcom,gcc-ipq6018.h
     include/dt-bindings/reset/qcom,gcc-ipq6018.h
     include/dt-bindings/clock/qcom,gcc-msm8953.h
@@ -29,7 +28,6 @@ allOf:
 properties:
   compatible:
     enum:
-      - qcom,gcc-ipq4019
       - qcom,gcc-ipq6018
       - qcom,gcc-mdm9607
       - qcom,gcc-msm8953
-- 
2.39.1

