Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B3463778F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiKXLXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiKXLXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:23:03 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB541286FA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:23:00 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id z4so2034487wrr.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrWdJkF3q0bol/WSUFZ/oRfO3LX4B45L735/TAnHh7g=;
        b=Eul8gF1lGwAFf+MsLr3E/VFVRY0A3ENg9EgWOJEdJg+hprwIRpaI8mYoDaV7ftCVWY
         HX301ofEZzb0HCUII84zm6BEOmcyMaDA/AbxgqYog79sKb2iNMN7rCPGRFqnNjxXDDnh
         AYhQhBm3JsAEbFx/DOppy4fWfdQzcIpfeMS5pYevLO7/kBLL2fyEOW5+tNfZ8YF3nk+E
         DV+WlvTKqYhE1K2SXsasUhy0DpUceVCPNyhatQ/Nb3bjYnXq23vyVcJbAp9+sOpwDAVN
         mroFur9vnORgWReHTtfnaWiWZFYfwiOikROwiGTjVSkcJsbolnPs+QBdpGp09Yg28Chd
         x1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrWdJkF3q0bol/WSUFZ/oRfO3LX4B45L735/TAnHh7g=;
        b=Lp4+yuGfvC4/u5pg7cl7vdFPBXUHuWldNKVelIXYf3dawXv4X5gcYo+LuYMUxZov1v
         PmFixSDv0sYo2tosLhhS1X+InQ1PPkOQvRzNjcM+eiaNviPkLfM9cUnZfBgOV0TmBzq1
         0fVgJFBPDiwGPrDqx4USynvgbe974zPgLk3NyQKcoYVF/PRD8u7+IffnlwyVXomt32vX
         ehDVUi53muJb4mSkKP+1mc7P8DMuaw+aZyhG4LyxrWvyPo7IqdIOsjsyEEn/8e6CjkPT
         I82viTr9dJc7HRnSOMoy1x3D6yXGydi2gSUjQJQlT/U18XKpDkuhaKWQN6AVhY6SASfb
         ptgw==
X-Gm-Message-State: ANoB5pm1qHCJ4ZZ4VVWnuAlbaiX2IxP4TqXrMXZZXESjgnYiCEHTWmHK
        pbIf2GjYKWa8X2JbZjlXb+NS8A==
X-Google-Smtp-Source: AA0mqf6wOwj290X0Le+ISghpD0AwmElyWN+dwJu2DLWVQh3n4GtNOJo+IXNf+Yk7apsKcobwNi/9uw==
X-Received: by 2002:a05:6000:50f:b0:241:ee78:b109 with SMTP id a15-20020a056000050f00b00241ee78b109mr3933807wrf.203.1669288979426;
        Thu, 24 Nov 2022 03:22:59 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003cf57329221sm5839461wms.14.2022.11.24.03.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 03:22:59 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Melody Olvera <quic_molvera@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: interconnect: Add schema for SM8550
Date:   Thu, 24 Nov 2022 13:22:30 +0200
Message-Id: <20221124112232.1704144-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124112232.1704144-1-abel.vesa@linaro.org>
References: <20221124112232.1704144-1-abel.vesa@linaro.org>
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

Add dedicated schema file for SM8500. This allows better constraining
of reg property, depending on the type of the NOC node. Also allows
better constraining of the clocks property. All of the above while
keeping the file itself comprehensible.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../interconnect/qcom,sm8550-rpmh.yaml        | 141 ++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml
new file mode 100644
index 000000000000..9627b629d4ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml
@@ -0,0 +1,141 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sm8550-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on SM8550
+
+maintainers:
+  - Georgi Djakov <djakov@kernel.org>
+  - Odelu Kukatla <okukatla@codeaurora.org>
+
+description: |
+   RPMh interconnect providers support system bandwidth requirements through
+   RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+   able to communicate with the BCM through the Resource State Coordinator (RSC)
+   associated with each execution environment. Provider nodes must point to at
+   least one RPMh device child node pertaining to their RSC and each provider
+   can map to multiple RPMh resources.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm8550-aggre1-noc
+      - qcom,sm8550-aggre2-noc
+      - qcom,sm8550-clk-virt
+      - qcom,sm8550-cnoc-main
+      - qcom,sm8550-config-noc
+      - qcom,sm8550-gem-noc
+      - qcom,sm8550-lpass-ag-noc
+      - qcom,sm8550-lpass-lpiaon-noc
+      - qcom,sm8550-lpass-lpicx-noc
+      - qcom,sm8550-mc-virt
+      - qcom,sm8550-mmss-noc
+      - qcom,sm8550-nsp-noc
+      - qcom,sm8550-pcie-anoc
+      - qcom,sm8550-system-noc
+
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8550-aggre1-noc
+              - qcom,sm8550-aggre2-noc
+              - qcom,sm8550-cnoc-main
+              - qcom,sm8550-config-noc
+              - qcom,sm8550-gem-noc
+              - qcom,sm8550-lpass-ag-noc
+              - qcom,sm8550-lpass-lpiaon-noc
+              - qcom,sm8550-lpass-lpicx-noc
+              - qcom,sm8550-mmss-noc
+              - qcom,sm8550-nsp-noc
+              - qcom,sm8550-pcie-anoc
+              - qcom,sm8550-system-noc
+    then:
+      properties:
+        reg:
+          minItems: 1
+          maxItems: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8550-pcie-anoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre-NOC PCIe AXI clock
+            - description: cfg-NOC PCIe a-NOC AHB clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8550-aggre1-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre UFS PHY AXI clock
+            - description: aggre USB3 PRIM AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8550-aggre2-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: RPMH CC IPA clock
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+      #include <dt-bindings/clock/qcom,gcc-sm8550.h>
+      #include <dt-bindings/interconnect/qcom,sm8550.h>
+      #include <dt-bindings/clock/qcom,rpmh.h>
+
+      clk_virt: interconnect-0 {
+             compatible = "qcom,sm8550-clk-virt";
+             #interconnect-cells = <2>;
+             qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      cnoc_main: interconnect@1500000 {
+             compatible = "qcom,sm8550-cnoc-main";
+             reg = <0x01500000 0x13080>;
+             #interconnect-cells = <2>;
+             qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      aggre1_noc: interconnect@16e0000 {
+             compatible = "qcom,sm8550-aggre1-noc";
+             reg = <0x016e0000 0x14400>;
+             #interconnect-cells = <2>;
+             clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+                      <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
+             qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      aggre2_noc: interconnect@1700000 {
+             compatible = "qcom,sm8550-aggre2-noc";
+             reg = <0x01700000 0x1E400>;
+             #interconnect-cells = <2>;
+             clocks = <&rpmhcc RPMH_IPA_CLK>;
+             qcom,bcm-voters = <&apps_bcm_voter>;
+      };
-- 
2.34.1

