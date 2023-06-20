Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515EB7368B0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjFTKDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjFTKDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:03:05 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36E61716;
        Tue, 20 Jun 2023 03:02:35 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so5965171e87.3;
        Tue, 20 Jun 2023 03:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687255353; x=1689847353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EhcdZWoQG0UDwjZKkQk3ltrC5NBGrPI5FQ7NnJ4uB+8=;
        b=H8rc9kUI9M6VfR4+8RTcunAnXLjel3eAsgUmZdCTL2G4ubYvWyuH8vLFQiusTW1BiZ
         X4FG7PD+LypL6SKd5yRleie60KX0BPgE/HviDuHUdEYUobw0wMWxDSosk469YuVUlHyD
         4VWU0owpnlaucJ9vbreDwnOlEABa1+ZA9BhvyXzGkjQ3ygcoZgW/XJxHpGJIpCek6oZr
         p3jdnS0X5zeB/5LeN7Ij9A1qf15aEUwnfLemLRRxYJh4oaCGkT4fTW8lkQXby1B7QJgZ
         Gd/z8FlYfLJY00ctz63VdOld0h4QG4Ktwf3VjK2Xy4QEe+dEU+EM6R53pt6NWaLBHdtf
         qOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687255353; x=1689847353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EhcdZWoQG0UDwjZKkQk3ltrC5NBGrPI5FQ7NnJ4uB+8=;
        b=Ge6x6jIoxVePcwS0KHtiaoWlvzhar6ziCNY1zoUGZn1RrJOO6HS7g99M0txI2c9UXt
         MlkmMXXF4JSR0tBHww/J7YPrk+BOnOo6ITdGg2IOu2/6goqJl1c/08EFvtUM/guIpi2V
         O8SolYJH47UtSFy8h+UtCOw20cUOnDE078AOnk5CnQLghTlKfQPbPWsDYlEPj2yHcnX1
         Z+zpRLoYn8jqs/AayowwNJF1vjrGgt2vh+v5iOwlsZr8a0J2juDCQu1WLCygFo4PqTjs
         z4ikSmoRttu2yUNO1ODNSJbWoW8bUgNPEdQ5MYOFO1h0Au//U4hgM3pfcgfmJm2PG1ej
         b02w==
X-Gm-Message-State: AC+VfDyrc/TFusXVDwD89CBKuwYzr0YFcP4BtE7+/qKUcfjFAQ6wX12+
        NfXuBh2UYhYRQC8nCWafZ6WZ37YoomU=
X-Google-Smtp-Source: ACHHUZ7yG+D+Ub1hxk5SfsKBZK6kg3x/+ygwCXzV/AK1L4I7BP3Wm9hvsPS1yXi3Zkir0ULoYLbKzA==
X-Received: by 2002:a19:710f:0:b0:4f7:3ee8:eede with SMTP id m15-20020a19710f000000b004f73ee8eedemr7180692lfc.61.1687255353160;
        Tue, 20 Jun 2023 03:02:33 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id d2-20020adfe842000000b0031274a184d5sm1608126wrn.109.2023.06.20.03.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 03:02:32 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: timer: add Ralink SoCs timer
Date:   Tue, 20 Jun 2023 12:02:31 +0200
Message-Id: <20230620100231.1412582-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML documentation for the timer which is present on Ralink SoCs.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
Changes in v2:
- Remove redundant 'documentation' word from subject.
- Drop clock-names property.

 .../bindings/timer/ralink,rt2880-timer.yaml   | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml b/Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml
new file mode 100644
index 000000000000..daa7832babe3
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/ralink,rt2880-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Timer present in Ralink family SoCs
+
+maintainers:
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+properties:
+  compatible:
+    const: ralink,rt2880-timer
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@100 {
+        compatible = "ralink,rt2880-timer";
+        reg = <0x100 0x20>;
+
+        clocks = <&sysc 3>;
+
+        interrupt-parent = <&intc>;
+        interrupts = <1>;
+    };
+...
-- 
2.25.1

