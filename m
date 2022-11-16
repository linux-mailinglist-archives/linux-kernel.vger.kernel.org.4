Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F5C62BE36
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbiKPMgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbiKPMgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:36:32 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A463523153
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:35:24 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o4so29556685wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NByFCuUAaW4OorBUL4tvtlh/sf8BMWr3RB7zpoFsbEY=;
        b=jFpK/7TinwA7mXto6JKWGrObV8/S8tAvxAE678KBCTJZntoHqrlFIAaFDbAk1AaWEW
         4O43MiNcBsqKuLnqXraQg/DFcFvF7P5j5DBQTI5NwxP4C1+BbzHXW1AnS4jvU0vjLQnb
         fwnloMz8XX7vpX0MhAhs445MfnXdncRblVX8qzW7MMb5KlArLTH7CrDXD5BdpTNzO8fo
         ZPujJr3pTBpoWADmWdtd8tCi7z+MGrdtMSKMdpw2pdcWs6nJll1v6eYORAD6Hc+MDUOW
         5EAaI//lg9slmYzmbYfDLtCAluF8PBpbiWbOuZaq8v0yH1KogHNGUkeLbM6t281Bn/Yg
         VDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NByFCuUAaW4OorBUL4tvtlh/sf8BMWr3RB7zpoFsbEY=;
        b=WIyrWvaErwWpGUsb9YW6xxfC10Z3AFIM4ouvQQQyUtt8DagzPmaPy9tCjGF5an2hLH
         6MEJP+ehGR+9YYRutT3ZA9HFpz3XvNRjfJNn9j7hOj9TjTbXRYNyXtvm+Zg8hvl5S2DY
         UfnBsASyY+8yRhtORyFwQio5jRVWsrfsXqWh+jsQ6VOTYEbf4BOWxA7HxeClXvwkvdAd
         6KsOK0p8rYgi8MoMM39ZWZHo6yr06eqieE70WE/VEDE3SFCRHdT3PY/X/YHXTZLFF3dO
         f+7pWb0SAHIWtIMWWPAcgdkYhjtXemSWDYPa9oqkSfSZCfXGtWabS9H3hsx0CZjaJCpz
         SauQ==
X-Gm-Message-State: ANoB5plW6xz71wKWPLxM8ys45gw4zaJ48SH4ugH9THpbB/Z6r30j44qA
        81tvk1JjVw1WPfw4usWo+iEyDg==
X-Google-Smtp-Source: AA0mqf7MAq4RmLvD2UaXGN76VxewI6inkoZgXyxEzmwwnzjidbH7Xj2NCcbDhX5iKvZR7j7hiE4IzA==
X-Received: by 2002:a5d:6044:0:b0:241:9a71:8938 with SMTP id j4-20020a5d6044000000b002419a718938mr4824317wrt.105.1668602123250;
        Wed, 16 Nov 2022 04:35:23 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id d20-20020a1c7314000000b003cfcf9f9d62sm1959925wmb.12.2022.11.16.04.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:35:22 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, kw@linux.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: PCI: qcom: Add SM8550 to binding
Date:   Wed, 16 Nov 2022 14:35:04 +0200
Message-Id: <20221116123505.2760397-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Add the SM8550 platform to the binding.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 54f07852d279..efa01a8411c4 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -34,6 +34,8 @@ properties:
       - qcom,pcie-sm8250
       - qcom,pcie-sm8450-pcie0
       - qcom,pcie-sm8450-pcie1
+      - qcom,pcie-sm8550-pcie0
+      - qcom,pcie-sm8550-pcie1
       - qcom,pcie-ipq6018
 
   reg:
@@ -92,6 +94,10 @@ properties:
   power-domains:
     maxItems: 1
 
+  enable-gpios:
+    description: GPIO controlled connection to ENABLE# signal
+    maxItems: 1
+
   perst-gpios:
     description: GPIO controlled connection to PERST# signal
     maxItems: 1
@@ -187,6 +193,8 @@ allOf:
               - qcom,pcie-sm8250
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
+              - qcom,pcie-sm8550-pcie0
+              - qcom,pcie-sm8550-pcie1
     then:
       properties:
         reg:
@@ -601,6 +609,92 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sm8550-pcie0
+    then:
+      properties:
+        clocks:
+          minItems: 11
+          maxItems: 11
+        clock-names:
+          items:
+            - const: pipe # PIPE clock
+            - const: pipe_mux # PIPE MUX
+            - const: phy_pipe # PIPE output clock
+            - const: ref # REFERENCE clock
+            - const: aux # Auxiliary clock
+            - const: cfg # Configuration clock
+            - const: bus_master # Master AXI clock
+            - const: bus_slave # Slave AXI clock
+            - const: slave_q2a # Slave Q2A clock
+            - const: ddrss_sf_tbu # PCIe SF TBU clock
+            - const: aggre0 # Aggre NoC PCIe0 AXI clock
+        interconnects:
+          maxItems: 1
+        interconnect-names:
+          const: icc_path
+        iommus:
+          maxItems: 1
+        iommu-map:
+          maxItems: 2
+        power-domains:
+          maxItems: 1
+        power-domain-names:
+          const: gdsc
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: pci # PCIe core reset
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sm8550-pcie1
+    then:
+      properties:
+        clocks:
+          minItems: 12
+          maxItems: 12
+        clock-names:
+          items:
+            - const: pipe # PIPE clock
+            - const: pipe_mux # PIPE MUX
+            - const: phy_pipe # PIPE output clock
+            - const: ref # REFERENCE clock
+            - const: aux # Auxiliary clock
+            - const: cfg # Configuration clock
+            - const: bus_master # Master AXI clock
+            - const: bus_slave # Slave AXI clock
+            - const: slave_q2a # Slave Q2A clock
+            - const: ddrss_sf_tbu # PCIe SF TBU clock
+            - const: aggre1 # Aggre NoC PCIe1 AXI clock
+            - const: cnoc_pcie_sf_axi # Config NoC PCIe1 AXI clock
+        interconnects:
+          maxItems: 1
+        interconnect-names:
+          const: icc_path
+        iommus:
+          maxItems: 1
+        iommu-map:
+          maxItems: 2
+        power-domains:
+          maxItems: 1
+        power-domain-names:
+          const: gdsc
+        resets:
+          maxItems: 2
+        reset-names:
+          items:
+            - const: pci # PCIe core reset
+            - const: pcie_1_link_down_reset # PCIe link down reset
+
   - if:
       properties:
         compatible:
@@ -672,6 +766,8 @@ allOf:
               - qcom,pcie-sm8250
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
+              - qcom,pcie-sm8550-pcie0
+              - qcom,pcie-sm8550-pcie1
     then:
       oneOf:
         - properties:
-- 
2.34.1

