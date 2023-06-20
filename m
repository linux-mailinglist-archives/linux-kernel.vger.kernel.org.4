Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBD77367CE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjFTJe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjFTJeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:34:14 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02CCA3;
        Tue, 20 Jun 2023 02:34:12 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30fcde6a73cso3837522f8f.2;
        Tue, 20 Jun 2023 02:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687253651; x=1689845651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TF/a4lzsA+Yd6AHWAdtyVM0//0bLbIMcawg9U9+2DR4=;
        b=psgHcwL6j8NN1LnQl1Hfra8+ZEK/7UBgT7kN8r1YBkGx+qOy6JwvIsaAR5L0kIlGED
         OKTMTCEPPwCl/32VYRBMfJBQe0ydXiSr5Sa14SrYAicEQK8qFSxx3kERVagHPY84dMq3
         vEytByRxXguawKplCjpQ8gRDFu0hZGeReHGQdli+jwj3MWSTXx6cv1WODU2ekMrfsnas
         ggamMDatTsEE61l8D0hQmrFW7kskMJNbw2AbcdudnJuwnRe4aT740CmX6ETm3T9ysh0n
         lxshSzOo9qFBT6Nw/3Qrw8dfYll3N5YSg3aZl2cI5NxOBiW89Cn+aaJGSlHg90So7fZx
         2UIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687253651; x=1689845651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TF/a4lzsA+Yd6AHWAdtyVM0//0bLbIMcawg9U9+2DR4=;
        b=L4/oTbjnfu1FHb9o+hsao338hlkGJzTkmfIAZssijdPOdVYW/TUxqGjTQnH3IhF+5w
         ZzxB0mwwQyGGFAylBDl2hKLFQASGVc5BWT7uISWo0FvxOcxU5Wd4Xrqr0sokQjazOz/q
         kRnR2JFnCEjaB2RPgxDz1YW+ayvP01CM3Qir38kZiUC+VqMjeRTRd8jhY8hsAyEmP2NE
         IoA+pBDSbYy4Hng75pscsf5zO6fvKmG8iwunacKqk2wn6HZedvkBMWFnkGYpH1OhUgGq
         wPB5r8RCRJJg2lRIWnzVSe27t3iKWRyBQdUBUVK7bsJdVpmbDJk47PwSqev8nA6bNjdm
         KDdw==
X-Gm-Message-State: AC+VfDyK0fm4+QiSg/vEWwMrRlBeuQyNg0+GoT9GHA5b9psLdLA0c3US
        IIdMHspbtazcVfGvJc/ISfoB3yh5CCY=
X-Google-Smtp-Source: ACHHUZ5CNZ3MmW+ALF7Eb5p8VxJJ3DKsHdwzf5v/YKC+vfveWHsQXd0f9I0GyReLR6bNwa9sY/N1oA==
X-Received: by 2002:a05:6000:1008:b0:30e:4515:1529 with SMTP id a8-20020a056000100800b0030e45151529mr7663493wrx.37.1687253650928;
        Tue, 20 Jun 2023 02:34:10 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id m13-20020adff38d000000b003113ed02080sm1554992wro.95.2023.06.20.02.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 02:34:10 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: timer: add Ralink SoCs timer documentation
Date:   Tue, 20 Jun 2023 11:34:09 +0200
Message-Id: <20230620093409.1411399-1-sergio.paracuellos@gmail.com>
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
 .../bindings/timer/ralink,rt2880-timer.yaml   | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml b/Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml
new file mode 100644
index 000000000000..9a315449f73e
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml
@@ -0,0 +1,49 @@
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
+  clock-names:
+    const: timer
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
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
+        clock-names = "timer";
+
+        interrupt-parent = <&intc>;
+        interrupts = <1>;
+    };
+...
-- 
2.25.1

