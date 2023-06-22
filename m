Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3713E739DA2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjFVJr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjFVJrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:47:36 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273AE1BDF;
        Thu, 22 Jun 2023 02:37:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31297125334so433502f8f.0;
        Thu, 22 Jun 2023 02:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687426565; x=1690018565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l4gpttMj31BBSFbZT/4nnsZG9u/pp2/at881A+9V8iw=;
        b=qQJ30SYGU6mAqR+F3oFrWIbeg3VaEG2DXvNE6xa/Oboc/ciu+XcYWuvqy4lpPdSd2U
         CJrkGsT5LnVatB7tOlrm9/BeuMBqn1wPvZCdd+j8DLppIGJW5WvfZkAGWOpNLPn7guS5
         4Q3tHVYC6/E1ORllSQPdPhVh0HkD3SljVIIczCc179kB+70cLtZ0mKhlldw9v6e70mzK
         Gw8RTDYoWeS2eEl4WyjGH1mZsfqc41T7y65G5j+rwHm/m2RVMrG/Du1oGe/JJbS9FA4D
         X37I1rmIBynKldQSLamxxD47O3Nx5XLNsmVknWxtpTsAgYCUy3DitrHN5bS8HRGSHFM9
         QVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687426565; x=1690018565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4gpttMj31BBSFbZT/4nnsZG9u/pp2/at881A+9V8iw=;
        b=STKbFpDculv3CBCuwv0Eg+spF9eF0FubVtHoG/2QdOmtXW6LzDNEKqBUVsKHeLKBGu
         7dxjFEUxFpi32e6DD9o0dnM797lGOIgTTmSf/dqq3uBpELfm0piMkTrKmaEkILKCW26d
         ZEaQKKJzS6XUVFCwE1Xb6sd6zItgRedFnL2GtWNW8+9AtD12PDtd9EeX259/kJbum9jF
         ZCBdiXka7pAPJXmE7bKmWA8r3WWEvlh40usLNEty08TGT9h5gvs7AHQ1NZltBtCgovl8
         /pYsDA93qhcp6rDXyiMfZIcsOdYF6WB+F77fOn9DbjrBx9kP+87zlnL6Q+mf4SUK/lTF
         z8bg==
X-Gm-Message-State: AC+VfDxOKa6KZC5OchjeXUq2J7t4xwVJLuylwZwMl7DsrPXKd0FvYb69
        7yBP38L5CRHF3EmkVPbocYvDMkprvxA=
X-Google-Smtp-Source: ACHHUZ5iJdC2LAgVPI6M1k6R73WdAAVD+SZ5Lb867CmA/kLdn9ToixULHCrI2e4TDGb5PdwTFHOG5A==
X-Received: by 2002:adf:e88a:0:b0:311:19ad:a082 with SMTP id d10-20020adfe88a000000b0031119ada082mr15702045wrm.3.1687426565263;
        Thu, 22 Jun 2023 02:36:05 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id y10-20020adff6ca000000b0030f9c3219aasm6545120wrp.47.2023.06.22.02.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 02:36:04 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: interrupt-controller: add Ralink SoCs interrupt controller
Date:   Thu, 22 Jun 2023 11:36:03 +0200
Message-Id: <20230622093603.1499745-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Add YAML doc for the interrupt controller which is present on Ralink SoCs.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../ralink,rt2880-intc.yaml                   | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ralink,rt2880-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ralink,rt2880-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/ralink,rt2880-intc.yaml
new file mode 100644
index 000000000000..85873bc025ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/ralink,rt2880-intc.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/ralink,rt2880-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ralink SoCs Interrupt Controller
+
+maintainers:
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+description: |
+  This interrupt controller support a central point for interrupt aggregation
+  for platform related blocks.
+
+properties:
+  compatible:
+    const: ralink,rt2880-intc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - '#interrupt-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    intc: interrupt-controller@200 {
+      compatible = "ralink,rt2880-intc";
+      reg = <0x200 0x100>;
+      interrupt-controller;
+      #interrupt-cells = <1>;
+
+      interrupt-parent = <&cpuintc>;
+      interrupts = <2>;
+    };
+...
-- 
2.25.1

