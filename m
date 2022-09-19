Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A2B5BD56D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 21:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIST4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 15:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiIST4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 15:56:34 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01425481F8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 12:56:32 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t3so237616ply.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 12:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9eQI2Cevi4CZxbZ5a/a4ZLydPDsHng3JOmFm5TOPYxU=;
        b=YSFjhGMpMvCaBX2WrPq5f4nq71mBpx9z+Pf7Dh1TMZ09RGBSOPRoruPkarHfutW4y4
         TBvl+X0fc6QiO9j/N4u0WWikPnsd0Di2zxmyXYyxU9uSDqC1Y/eYA1Fzlcks7TOAHwWF
         +Rii2xsOknAdDkBXmqNMhDI8LmsxHSLTsIYi92y26/KNIl7ODJYpX40ZT89vN1PEh1g3
         TbeRhM27oEYFwG0KZuCzQ2Jh2JotojFB4sBmd5qhh/oQW2fE9pqT+5IGD7RZRbsFq0Cv
         VUNAhS4KHXkyCO7L1pQb+Tqjf2lL/fek2GaCGbprGt4EqEWGq47qfy1SQxtUzJzAfrFv
         inEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9eQI2Cevi4CZxbZ5a/a4ZLydPDsHng3JOmFm5TOPYxU=;
        b=sQa71hSzbhT1yN7pixxbMkHm/y+7OAnsCZHJCrOGFDzuy0TMuX94QlE0qinMe0ZdUK
         ngzJjNRnNk9lWeU/ogwxuOZPBwFPrZ4leA3gicejENx0ntg1SZWecHNbsJcBPUGdYcGE
         Sxs8JQtJ4+pIhsWW3yvf+GpzL8Lg2Z2ez6iO7/nf35BLxivyszvtrsEPupoEW7n3/6UT
         97s1VfWYmiZ7Flxg/U6gkZT6iDGqHuBGz5mB5wRPEKbyw6pSCGJBAsDCU5SWH/ouWD1T
         YDaiL9/7fMFT6AHxMTndNGMC7api48H+JSUBVrcSQ9upQ6zRfmNP43N2FB1xY4PKeeis
         S3vg==
X-Gm-Message-State: ACrzQf2JTyI/Z4ieeNk7IhAMy7ysZMN+7GFqG0fTvzB15MjMWpU/fdRJ
        pAIxMEAQ2AUFvKthhQ6H4PLqipyGqLNkIw==
X-Google-Smtp-Source: AMsMyM5HX5H4svUT/r2BofoDjMeZmDJRtcRoQw9GQPPRehh2i6rgcw3FPCaeJGKB7rq21joXwwPRGw==
X-Received: by 2002:a17:902:e884:b0:178:2065:5c29 with SMTP id w4-20020a170902e88400b0017820655c29mr1369992plg.114.1663617392278;
        Mon, 19 Sep 2022 12:56:32 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:6535:ca5f:67d1:670d:e188])
        by smtp.gmail.com with ESMTPSA id a14-20020a17090a688e00b002032bda9a5dsm7071454pjd.41.2022.09.19.12.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 12:56:31 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, thara.gopinath@gmail.com,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, Jordan Crouse <jorcrous@amazon.com>
Subject: [PATCH v6 1/4] dt-bindings: qcom-qce: Convert bindings to yaml
Date:   Tue, 20 Sep 2022 01:26:15 +0530
Message-Id: <20220919195618.926227-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220919195618.926227-1-bhupesh.sharma@linaro.org>
References: <20220919195618.926227-1-bhupesh.sharma@linaro.org>
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

Convert Qualcomm QCE crypto devicetree binding to YAML.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Tested-by: Jordan Crouse <jorcrous@amazon.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../devicetree/bindings/crypto/qcom-qce.txt   | 25 -------
 .../devicetree/bindings/crypto/qcom-qce.yaml  | 67 +++++++++++++++++++
 2 files changed, 67 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/crypto/qcom-qce.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/qcom-qce.yaml

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.txt b/Documentation/devicetree/bindings/crypto/qcom-qce.txt
deleted file mode 100644
index fdd53b184ba8..000000000000
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Qualcomm crypto engine driver
-
-Required properties:
-
-- compatible  : should be "qcom,crypto-v5.1"
-- reg         : specifies base physical address and size of the registers map
-- clocks      : phandle to clock-controller plus clock-specifier pair
-- clock-names : "iface" clocks register interface
-                "bus" clocks data transfer interface
-                "core" clocks rest of the crypto block
-- dmas        : DMA specifiers for tx and rx dma channels. For more see
-                Documentation/devicetree/bindings/dma/dma.txt
-- dma-names   : DMA request names should be "rx" and "tx"
-
-Example:
-	crypto@fd45a000 {
-		compatible = "qcom,crypto-v5.1";
-		reg = <0xfd45a000 0x6000>;
-		clocks = <&gcc GCC_CE2_AHB_CLK>,
-			 <&gcc GCC_CE2_AXI_CLK>,
-			 <&gcc GCC_CE2_CLK>;
-		clock-names = "iface", "bus", "core";
-		dmas = <&cryptobam 2>, <&cryptobam 3>;
-		dma-names = "rx", "tx";
-	};
diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
new file mode 100644
index 000000000000..8df47e8513b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/qcom-qce.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm crypto engine driver
+
+maintainers:
+  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
+
+description:
+  This document defines the binding for the QCE crypto
+  controller found on Qualcomm parts.
+
+properties:
+  compatible:
+    const: qcom,crypto-v5.1
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: iface clocks register interface.
+      - description: bus clocks data transfer interface.
+      - description: core clocks rest of the crypto block.
+
+  clock-names:
+    items:
+      - const: iface
+      - const: bus
+      - const: core
+
+  dmas:
+    items:
+      - description: DMA specifiers for rx dma channel.
+      - description: DMA specifiers for tx dma channel.
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-apq8084.h>
+    crypto-engine@fd45a000 {
+        compatible = "qcom,crypto-v5.1";
+        reg = <0xfd45a000 0x6000>;
+        clocks = <&gcc GCC_CE2_AHB_CLK>,
+                 <&gcc GCC_CE2_AXI_CLK>,
+                 <&gcc GCC_CE2_CLK>;
+        clock-names = "iface", "bus", "core";
+        dmas = <&cryptobam 2>, <&cryptobam 3>;
+        dma-names = "rx", "tx";
+    };
-- 
2.37.1

