Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B275C740BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbjF1Ijm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbjF1Ifx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:35:53 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E8C3596;
        Wed, 28 Jun 2023 01:27:19 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso27078595e9.0;
        Wed, 28 Jun 2023 01:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687940838; x=1690532838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+VkJSv6lLBKzaHF7FPUBOopXTAQ4wP8Lpjbw0E+bcMc=;
        b=F+aotDGTKGYXs/wqgWNjLSX98Pd0y3s8ReAmq3ApZzrMuh1SAo2RBb/m+orRqHmv3o
         zPtgQCc6ScjRmeqQFLgL0xvvRisyb04DexdRBk4YPE5DDUk2C4SqXGWF3HsqU7bot97I
         naJEhK8Zd2durrX3aIU1zyj9QtYKBE81GYG1yfIfjlOhLC7rFHyX1ryVs4huZyscv9/U
         C5HP8GfKjK4GP91otQNxxOEQ9762UuLl35/IbrWJnvYvVjeVn8n7TVef3gCKwjsBgBH/
         +RezK6sMW66+Qt5zU6rhxI+NT9oMwXCjF16S8ffnWOKyv4u0iCOHb7zIuRQTWpU99Ifv
         ha9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940838; x=1690532838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VkJSv6lLBKzaHF7FPUBOopXTAQ4wP8Lpjbw0E+bcMc=;
        b=iMMi9Wl9DP0BvC7Mz3jfda4/GjnMpM9eNSSSepMrFwHqVxlKsxoFna/S7ZgpAWpmDU
         5YETCe3qI6zeJJE1LY43Ha4BvwW4DQRJE5cD2u1A9as1ceTG4ZvIUqaccv5S4y+SPkc/
         xf3gQ2ZeCaWUgdhCn8aG03c+a5jOIwnEMYtyECMobGju6RDzivvNHHBAzh1aQqp1jQAq
         sOO/lvjDp6RSFNCFsx2v2XHKwHjJoezCR1YUL7H6M4lzxRlDEcK4JV6J6wc7zWfC18fx
         5Bf1NgzkRMjhzaCMmw4/iceoseGOP3xOFWQPISFe0D7jys2qGPL7WTJ5xNdLhGKGVduj
         MoQg==
X-Gm-Message-State: AC+VfDwykih/tKK9n436f7Eae4fdruDO2K0wugIaKnMMf4I/4aSOqktK
        OXRA+2mwzenMcPLnZ5U/9bfkEbSdVXQ=
X-Google-Smtp-Source: ACHHUZ6Hp3hNoBEPLwzeAMm4XHolUl6yY/68afpJx5eD7pSb1KC9PUVZajx5MN6hMoEqegicnWvpUQ==
X-Received: by 2002:a05:600c:2942:b0:3f9:b8b8:20e4 with SMTP id n2-20020a05600c294200b003f9b8b820e4mr18448662wmd.31.1687940837482;
        Wed, 28 Jun 2023 01:27:17 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c229800b003fa98908014sm7748174wmf.8.2023.06.28.01.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 01:27:16 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     tglx@linutronix.de, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: timer: add Ralink SoCs system tick counter
Date:   Wed, 28 Jun 2023 10:27:16 +0200
Message-Id: <20230628082716.2075736-1-sergio.paracuellos@gmail.com>
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

Add YAML doc for the system tick counter which is present on Ralink SoCs.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../bindings/timer/ralink,cevt-systick.yaml   | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml

diff --git a/Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml b/Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml
new file mode 100644
index 000000000000..59d97feddf4e
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/ralink,cevt-systick.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: System tick counter present in Ralink family SoCs
+
+maintainers:
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+properties:
+  compatible:
+    const: ralink,cevt-systick
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    systick@d00 {
+        compatible = "ralink,cevt-systick";
+        reg = <0xd00 0x10>;
+
+        interrupt-parent = <&cpuintc>;
+        interrupts = <7>;
+    };
+...
-- 
2.25.1

