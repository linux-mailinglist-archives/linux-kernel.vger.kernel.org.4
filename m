Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9545573AF36
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 05:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjFWD7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 23:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjFWD7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 23:59:06 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9D1210A;
        Thu, 22 Jun 2023 20:59:04 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f870247d6aso139817e87.0;
        Thu, 22 Jun 2023 20:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687492743; x=1690084743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cwb2g7B61k6vJspUStt9gge0ov/hucFMMX2AqdAGRWc=;
        b=qfMMKEz9rWN3iFXI6hJLAMQEkZCzoyTAbVytPhNYsw0e5f+Ci+tD7deuBjoMlCP0U2
         wFloh5rrifNR0Mrn+byd9BnU76MJWVgIqMfCTSCoeuDfSRMBRXjJR8HIdkhDn4tBrJOk
         cgUfjbwm0F6s9ZQyB1WnOMMsljFCaXGs+iRCnNSl2CKpX8BmLmWzMpqNVq+0kAa82arD
         HT24nR3EOIhH+cB+85CljYCpnH5xP0Wxd1jF9+iAZjrKbXVOvaxfhGKHWCqP5MA5PEh1
         JozxNrma1W5PjM80hZcXZnWlR/oJwNr0JWrjWf8/8M1o2Lhi48mfeFP20eWq23FgMbtM
         s1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687492743; x=1690084743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cwb2g7B61k6vJspUStt9gge0ov/hucFMMX2AqdAGRWc=;
        b=cywXrUat8sBahh0Sv+xL12v18qcCaWLUlRrO7NPj7L3b1eUXBwEaPB4EoB7dvzoUwT
         kRjxhXZMKvv1bW6A9IIpqGYbRmbn4dnr4aC4KDK3+PNUQpWIXAL8R/SfEMnVf3796QMu
         ojVplJYQhqJRX/+vPGPgt3+DlT2Nspm86RJlYd1EvLpU6LWQrTVLE3oV+JeiEUiXAcrA
         dSJH2FmRIddiYvh0BxPboU3slDAi7wXiUkHxGt0hdEpLHq627Cm4sRk4n9Dg0SeJhvXU
         6suixeUqj4LKky/oT7d5goQ73U4o/jrARaNF60JbsPfo0LowDxRbIesQbb99pSLm4r01
         Me/g==
X-Gm-Message-State: AC+VfDyFGs9tvlOPEVe6BEKKVwbi91V1NTwsDwJL9e9fiRMwzH+rcZTY
        QBFp5Jp4P0C3r7WOc81qFb2lcgj5c8k=
X-Google-Smtp-Source: ACHHUZ7hqikoqe2viVcatb6vQlowOpWXVymWRD/SCzP1ZrMly+RRLmjaP8KdMBMMcYDbeItTQWYwVw==
X-Received: by 2002:a05:6512:10c6:b0:4f9:70cc:fe77 with SMTP id k6-20020a05651210c600b004f970ccfe77mr279954lfg.1.1687492742447;
        Thu, 22 Jun 2023 20:59:02 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id f11-20020a1c6a0b000000b003f7f2a1484csm1111094wmc.5.2023.06.22.20.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 20:59:01 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3] dt-bindings: interrupt-controller: add Ralink SoCs interrupt controller
Date:   Fri, 23 Jun 2023 05:59:01 +0200
Message-Id: <20230623035901.1514341-1-sergio.paracuellos@gmail.com>
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

Add YAML doc for the interrupt controller which is present on Ralink SoCs.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
Changes in v3:
 - Drop '|' from description.
 - s/unevaluatedProperties/additionalProperties
 - Add Conor's Reviewed-by tag.

Changes in v2:
 - Drop label from the example.

 .../ralink,rt2880-intc.yaml                   | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ralink,rt2880-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ralink,rt2880-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/ralink,rt2880-intc.yaml
new file mode 100644
index 000000000000..0fa952a9edfd
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
+description:
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
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@200 {
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

