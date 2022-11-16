Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6568162BD29
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbiKPMIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiKPMHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:07:42 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1291FAE6A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:02:11 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5so11742646wmo.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cL/V4xypg6AeAmhob4TSQcRm9kAAM9JuGkCrpxMMIo=;
        b=N1zdvA7zwGA4eHzaUl+W7/q/3K2QCi6uvE60utukJlNDqgj7JJEsWPJBIDvr2fA6dh
         k34vi4mXtxUl7YgTVk+Yvgs7pG7OFohV/QUsxnHWMY9G/tmnz0rJXo9O+akB09ahBdgM
         ZDZzChu5ngrcID3J+7ZAeKfUrb5YuxTjT3WecU0wt14pma/le8zBBhQB/kPksj69xMIP
         653GcEzou5tkbP8NfYCt4tgdcCCxoHu/WuOgqY6JqMkCo6lAfjhlPSj5qpn+4LyvStIW
         qZRg6QNWF2iTZB1xRVWwUu8T5ZxkO0ozpoYOrQSTdoOabHaDTmT9AfFjFtgS0VHI4AJz
         n40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cL/V4xypg6AeAmhob4TSQcRm9kAAM9JuGkCrpxMMIo=;
        b=oG4O9caLYqnCJuhim6FUitoUcXHpIQNaCNFBt11P4+MFTGoD36b8qqOZ6bBJ4RK6OO
         YQW+9f8teB2U6Xvy/joLxolIqEkYxB12BaFAuyBF1+PpAjYlzLSNGzHPn8tzP5ttzA7E
         DiOyYXan5asVNUxuD2nkBPmGE7Avv4gV4ZjcPbzGHh3Q+ZA7SK4giyn6spP78N267EQz
         typ375SuRUD42/6J4tQpGFZdZrFK1jHSzGNLrAPN+SlP4wmZlwglfWpJUT699dl6+AQa
         Sk86/2AaTDkwraPnkFl/vSLwgUoVVOaM5krhbfnFlWqyMNaIKYBO/cwRfrds/nG9nxXU
         j6/Q==
X-Gm-Message-State: ANoB5pmP3gkn0e7nhOqzWLp/Xr057CkoWbJTf2DfVZzQ3RJgCjMRDrVB
        ePWM3zRqAJl4k0Ajc+JPezWWMQ==
X-Google-Smtp-Source: AA0mqf6waSLfNPtVuZ8cHkWURLFzHR6rVvmZDp1426vTFlaageROdcVQJIEd2MAhAvfaYIeombrFFQ==
X-Received: by 2002:a05:600c:4c27:b0:3c6:a7a1:eebd with SMTP id d39-20020a05600c4c2700b003c6a7a1eebdmr1831799wmp.176.1668600130511;
        Wed, 16 Nov 2022 04:02:10 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b002206203ed3dsm15120109wrx.29.2022.11.16.04.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:02:10 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH 08/10] dt-bindings: phy: Add qcom,snps-eusb2-phy schema file
Date:   Wed, 16 Nov 2022 14:01:55 +0200
Message-Id: <20221116120157.2706810-9-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116120157.2706810-1-abel.vesa@linaro.org>
References: <20221116120157.2706810-1-abel.vesa@linaro.org>
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

The SM8550 SoC uses Synopsis eUSB2 PHY. Add a dt-binding schema
for the new driver.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../bindings/phy/qcom,snps-eusb2-phy.yaml     | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
new file mode 100644
index 000000000000..d6a4bdd0cd42
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/qcom,snps-eusb2-phy.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm SNPS eUSB2 phy controller
+
+maintainers:
+  - Abel Vesa <abel.vesa@linaro.org>
+
+description:
+  eUSB2 controller supports LS/FS/HS usb connectivity on Qualcomm chipsets.
+
+properties:
+  compatible:
+    const: qcom,sm8550-snps-eusb2-phy
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  clocks:
+    items:
+      - description: ref src
+      - description: ref
+
+  clock-names:
+    items:
+      - const: ref_src
+      - const: ref
+
+  usb-repeater:
+    description:
+      Phandle to eUSB2 to USB 2.0 repeater
+
+  vdd-supply:
+    description:
+      Phandle to 0.88V regulator supply to PHY digital circuit.
+
+  vdda12-supply:
+    description:
+      Phandle to 1.2V regulator supply to PHY refclk pll block.
+
+  resets:
+    maxItems: 1
+    description:
+      Phandle to reset to phy block.
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+  - clocks
+  - clock-names
+  - vdd-supply
+  - vdda12-supply
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sm8550.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/clock/qcom,tcsrcc-sm8550.h>
+
+    usb_1_hsphy: phy@88e3000 {
+        compatible = "qcom,sm8550-snps-eusb2-phy";
+        reg = <0x88e3000 0x154>;
+        #phy-cells = <0>;
+
+        clocks = <&rpmhcc RPMH_CXO_PAD_CLK>,
+                 <&tcsrcc TCSR_USB2_CLKREF_EN>;
+        clock-names = "ref_src", "ref";
+
+        vdd-supply = <&vreg_l1e_0p88>;
+        vdda12-supply = <&vreg_l3e_1p2>;
+
+        resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+    };
-- 
2.34.1

