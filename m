Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61C663A85E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiK1M2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiK1M2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:28:38 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FCEE09E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:28:37 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h11so9252154wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVDJy2tBLtCtWs3y08tyAkZLMTUym8AlgvjfHM0t+RU=;
        b=iGvLrgP+BN/INHeehkuaXQ1sANc5zWrMqHWOANSMXFwS/ZQGZEvZmriwvSZ5QuD5fe
         vD0eepBRZu52A2MTckIHEAz0bX6ZSmYnf7+UFFdJSlZbR1YChvLiW/Co5JTb/qMDthDm
         tM69rcnPzfaQBckED6vsiiMHyM6n+8TaSopI/9RdEOTecdVOT3jVmoCF4T4TJXOaB1JH
         dL/bOd8icj3iFwBenjAM5NJU9IoMfeHgaebeCOxasndW5B8apY31mvtBxvjuqz5woO8y
         rP2ubX0VpxUP4H5XMaB/buACUrzmcRobB4PX2Mj8FvsEcPpC+Tlmf5FROqaIppN6C5pa
         Wohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVDJy2tBLtCtWs3y08tyAkZLMTUym8AlgvjfHM0t+RU=;
        b=kYjpoQgKWhpehz7KkFEsfClhdIAxkOJzdn2VrgYM54miFlcdkVKEPiskPvbgT765pI
         3ljYIIyZ948RAeo67WH2hgp5N9AM9+6u/v0DOczMLTtjhPZYTs2fAAkjzhFkwhSEx5nI
         mFeZQ7XfDzQIz+QeWwuUIBGnC3mZogBQHlz3m3bhhNB7WgWNJ7X6SbDgUj9x5E85f1L/
         5DUAi8+frcviADsqH5ChSo8gsw0JaU5Upxgig/90WBFHrXZ1FahAEPf9KAQlbWfjN/66
         rztt2VTEhiNZ/4WKwP96spHbM9VJorBMAkybrqUSFTPfDQzsb9XuV919dAA7BjWmw3m/
         TqIg==
X-Gm-Message-State: ANoB5pmvdzUgFewQQwROo4MNZoS2LOe8T9BLiJ0vATdpI5LFah7rm1oT
        PUEj3/q6Hq0MYGiPAkHqIXgRhA==
X-Google-Smtp-Source: AA0mqf4iCC0DFuyE691E4lDtiMN+Y5MOicBbSYJB93Fx1b37W5jQaZQNulHVsX8B1OQ1TQekrqrNyQ==
X-Received: by 2002:a05:6000:103:b0:241:d028:78c5 with SMTP id o3-20020a056000010300b00241d02878c5mr19637312wrx.131.1669638515873;
        Mon, 28 Nov 2022 04:28:35 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id u18-20020adfdd52000000b002421db5f279sm598405wrm.78.2022.11.28.04.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 04:28:35 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v3 2/9] dt-bindings: clock: Add SM8550 TCSR CC clocks
Date:   Mon, 28 Nov 2022 14:28:13 +0200
Message-Id: <20221128122820.798610-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128122820.798610-1-abel.vesa@linaro.org>
References: <20221128122820.798610-1-abel.vesa@linaro.org>
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

Add bindings documentation for clock TCSR driver on SM8550.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v2:
 * dropped the allOf clause
 * changed comments in bindings header to mention TCSR CC clocks

 .../bindings/clock/qcom,sm8550-tcsrcc.yaml    | 45 +++++++++++++++++++
 .../dt-bindings/clock/qcom,sm8550-tcsrcc.h    | 18 ++++++++
 2 files changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-tcsrcc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sm8550-tcsrcc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsrcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsrcc.yaml
new file mode 100644
index 000000000000..b2de251328e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsrcc.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm8550-tcsrcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm TCSR Clock Controller on SM8550
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+description: |
+  Qualcomm TCSR clock control module provides the clocks, resets and
+  power domains on SM8550
+
+  See also:: include/dt-bindings/clock/qcom,sm8550-tcsrcc.h
+
+properties:
+  compatible:
+    const: qcom,sm8550-tcsrcc
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@1fc0000 {
+      compatible = "qcom,sm8550-tcsrcc";
+      reg = <0x1fc0000 0x30000>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/qcom,sm8550-tcsrcc.h b/include/dt-bindings/clock/qcom,sm8550-tcsrcc.h
new file mode 100644
index 000000000000..091cb76f953a
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm8550-tcsrcc.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_TCSR_CC_SM8550_H
+#define _DT_BINDINGS_CLK_QCOM_TCSR_CC_SM8550_H
+
+/* TCSR CC clocks */
+#define TCSR_PCIE_0_CLKREF_EN					0
+#define TCSR_PCIE_1_CLKREF_EN					1
+#define TCSR_UFS_CLKREF_EN					2
+#define TCSR_UFS_PAD_CLKREF_EN					3
+#define TCSR_USB2_CLKREF_EN					4
+#define TCSR_USB3_CLKREF_EN					5
+
+#endif
-- 
2.34.1

