Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F20C5B3BC7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiIIPY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiIIPYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:24:49 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED5826544;
        Fri,  9 Sep 2022 08:24:48 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d12so2111784plr.6;
        Fri, 09 Sep 2022 08:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Zfu8klkEEURpU6QZwMFaeAs/esTIGjM6BvmfdjMYuCk=;
        b=PjZpOXEl+oIcoS7efqLcchb5oPyfaVEWuVORB+OUoZEeWgCwjgGggsidMwnRwwp2oB
         VSok99bvvywQia6qI47v2YvlkMWjFTRAIRksQ3B4GrJ82/G0S+DdACOvvppcxftGO4PW
         BBKaE1HNUcm94klM9pNb+HoN89KJHeiKUDppRi4S+2EQfC2QxlpCh5Q2C0S0o0Nbwg2N
         8c2OzJEkGsbKO0RYPsfCpWP32p/h/Zeb12useBvg4lSEJn2TmQy6704dnBnzg9ZjVHh+
         KI+dOjDFe5ZKVYoONjSEZRjXnwUV4bOLliLEblHJqmm6O4A/bBMeVqF2aqqwFlKSmwf+
         PECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Zfu8klkEEURpU6QZwMFaeAs/esTIGjM6BvmfdjMYuCk=;
        b=td+71/mM86CIcIgCm2diZRrMmwUwEV/kzvBDMCmDNqc2PgR7zUsL5K56dPKKBn1DbH
         H51M3VNvrq+B+hjpNRb2qtbbxXdbY6hWr7gbiWToIrF2J9QscdfW+HnUwzF1gJKHOWP8
         uF9WkCwCko/4CD+EWhmno6KFLBsA7xfhFGyCeBSQR6Rn8BtySBlMKqWavQiz7a0JY9so
         jGNhQwPJX5mTd/w3wyhELXzGWQJ9EXVi2+jS9Yo965mW80+h174mFuSd4V34U2AWycPy
         p6uMH5KSBIibn/78NLVBcgiNTUQFFxEohXcAcOp8iOd3S6ENKXoyEV4Y5YtQKyGObkJn
         ZlvA==
X-Gm-Message-State: ACgBeo035yw657s21fUuocgVuIbk/UEnGJV0lo7XT5VHHhNcnLAgOY6Z
        ank+PM7xleNLum3saOk9G5k=
X-Google-Smtp-Source: AA6agR7v5CLPT8W0QMt74ZAYLYkkAAKv2OVvwL488Qk2b7VMFVsXXpse++CJp5L5a2osVXpoC8oSVA==
X-Received: by 2002:a17:902:b70a:b0:173:1a17:451f with SMTP id d10-20020a170902b70a00b001731a17451fmr14066970pls.81.1662737088011;
        Fri, 09 Sep 2022 08:24:48 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id p20-20020a63e654000000b00434abd19eeasm604006pgj.78.2022.09.09.08.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:24:47 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [RESEND][PATCH V8 1/2] dt-bindings: mfd: sprd: Add bindings for ums512 global registers
Date:   Fri,  9 Sep 2022 23:24:20 +0800
Message-Id: <20220909152421.278662-2-gengcixi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909152421.278662-1-gengcixi@gmail.com>
References: <20220909152421.278662-1-gengcixi@gmail.com>
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
 .../bindings/mfd/sprd,ums512-glbreg.yaml      | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml

diff --git a/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
new file mode 100644
index 000000000000..996bd4a17ca3
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
@@ -0,0 +1,71 @@
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
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
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

