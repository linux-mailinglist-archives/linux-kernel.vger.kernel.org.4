Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8105B3075
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiIIHjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiIIHiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:38:01 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDDF11B035;
        Fri,  9 Sep 2022 00:35:43 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso750216pjm.5;
        Fri, 09 Sep 2022 00:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=7+4jowJN8mfXe7NV6ZaB79mTdCuMM7yQdieyGm6TkKs=;
        b=EOE5sd4WaXTB//AdnU9BzE9EGd1JYBjzseXrYZhkzVKDzluMpBfiP4SdqlXBM7+8NZ
         Kv0BoCwSNfw/rvsxC9hl4uUotXEc0jCCYb5Yb/DpUXxhNg3jQ7Dr2vTAzzURCPpme1zp
         OVPsCl7xInuA5y9qo3fHetqaaSYVHzty0Z9ereST4wgwKmDW4p7V6tZ3J1xMOwYv5jVi
         ceRNhH9299fEbX9Ubf7fpXdPiN3W2AVVU4/QmENOk2oWqRHg/sNbGYzrg3+f8ar5ul2L
         0d9mAm2AwaH7/MjdE229/Kr5v227j0ntjGADY+hQ+tzLmUNkLZZeb0BVWx+Hq9LIZQZb
         fpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7+4jowJN8mfXe7NV6ZaB79mTdCuMM7yQdieyGm6TkKs=;
        b=ugutnRwv8H3e2uCUIKOFjLmQd6lHiPU/51D7eLD4v7XLsaEeDzZDqVcs2FVxdSbb/I
         VFLQ1IrNe48zeTFoJZiVvhoSgOMRPeziUYRIX5f/ECyFYC0ERwTuH0DsRVYue2ewXA9L
         WXMh1up+3kYBuqkBNPbdl7HSZsBbatuKrL0I+WXh8GjmQwzXM7qICtbGj/N6t55BCgBD
         PBX0p7jesx+0VNAb7IlyWZ1YtMZudbDug57044diczWNGsZ2CM3+BwvpCoy9E1Fr1jZq
         ApYytze5qV9Gi1/YZKnKL28Xd2p3vddJIP2RN2IXUOHuZewdindhajdjG38eaCy2kSPU
         mELg==
X-Gm-Message-State: ACgBeo18uKvhH2cxKHsLM75FUz4iUBAqr4LFXVbaENeuOTH5h7T3y4RA
        as6F3YrOQ8AM3X4A1PQLD0Q=
X-Google-Smtp-Source: AA6agR6NvNBCM+DMvIp/jddFmpx83RBkxMQtBDCCIQS81DoPbJ0sbb6IEf+cDof2WAORTV1UoSAf9g==
X-Received: by 2002:a17:90b:3144:b0:1f5:829e:cd49 with SMTP id ip4-20020a17090b314400b001f5829ecd49mr8415275pjb.80.1662708941891;
        Fri, 09 Sep 2022 00:35:41 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id ix19-20020a170902f81300b00174e5fe9ce1sm720938plb.159.2022.09.09.00.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 00:35:41 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH V7 1/2] dt-bindings: mfd: sprd: Add bindings for ums512 global registers
Date:   Fri,  9 Sep 2022 15:34:55 +0800
Message-Id: <20220909073456.239668-2-gengcixi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909073456.239668-1-gengcixi@gmail.com>
References: <20220909073456.239668-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Add bindings for Unisoc system global register which provide register map
for clocks.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml

diff --git a/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
new file mode 100644
index 000000000000..c8125dbd1d72
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2022 Unisoc Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/sprd,ums512-glbreg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc System Global Register
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+description:
+  Unisoc system global registers provide register map
+  for clocks and some multimedia modules of the SoC.
+
+properties:
+  compatible:
+    items:
+      - const: sprd,ums512-glbregs
+      - const: syscon
+      - const: simple-mfd
+
+  "#address-cells": true
+  "#size-cells": true
+
+  ranges:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "^clock-controller@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/clock/sprd,ums512-clk.yaml#
+    description:
+      Clock controller for the SoC clocks.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    ap_apb_regs: syscon@71000000 {
+      compatible = "sprd,ums512-glbregs", "syscon", "simple-mfd";
+      reg = <0x71000000 0x3000>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges = <0 0x71000000 0x3000>;
+
+      clock-controller@0 {
+        compatible = "sprd,ums512-apahb-gate";
+        reg = <0x0 0x2000>;
+        #clock-cells = <1>;
+      };
+    };
+
+  - |
+    ap_intc5_regs: syscon@32360000 {
+      compatible = "sprd,ums512-glbregs", "syscon", "simple-mfd";
+      reg = <0x32360000 0x1000>;
+    };
-- 
2.34.1

