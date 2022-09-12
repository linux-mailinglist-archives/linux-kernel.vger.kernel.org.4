Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4B75B617E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 21:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiILTIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 15:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiILTID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 15:08:03 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3517342AEF;
        Mon, 12 Sep 2022 12:08:03 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id j12so9519050pfi.11;
        Mon, 12 Sep 2022 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=ZMDXrfVZs/FU6NF5M/gBqbkEPLHG1eBQo8h/hDTaUCg=;
        b=X+P6BlT/TgB+VgH4TuMHIRPPPLlu9hFPNmvGQbx25k/DL0wJT6dThcKawGEizioFpJ
         Xt3desz9OjLRcHYn5ONBMRZcZ2EDdceqrasVC1d94noPmls9MW9Jp9NddnLI/EQM4TFj
         uzjAqXKNB4Ya+rLP44TGEogUCDLEBFlcoFAZOkQvCy2VtyTZUnw7NlsXjTH2RrPoIh8O
         aevgPeUoFLeEeylTJoD9Jb3rYkaiXMxfgR6lHhX+E5IKoILkD2VJH40uHYFxk3FQlamx
         WekZZnUArJCqTPjPsedPxXu0689R2o1rqIFSkiyzsmQw+kol+vBsSQkCmliZYwZzFEzk
         e3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ZMDXrfVZs/FU6NF5M/gBqbkEPLHG1eBQo8h/hDTaUCg=;
        b=kPhcMuec841JKgXnBIg1C/fG/GYhxhKHqd/5lHn53LaIICC5B6sFQbfYYZUKOfF1FJ
         TgOBTVLurN9Ljqd7WcTQq8o/GlTLubY6zGcqMeqZ3JN/EBWXawQ/ipiN5ihEYdDGuTsh
         esJw+nxZzVmwEvOKssVzsIiaDgdNhOzfV0h1t+ka7sYMyadkCV46tu3AOicH+VKpviqG
         XLWjl+TOCSugopqP+mppqPOEqL98zLvjGoE63eDsStCeBsjC1iZaFou7aLbYj63RCZt/
         DAE4xKqszaKQ2K56tlh5L0OEECn0xBvmHVS0v0gHrMe2M6gYMfKC5N9ITWIroF6Uel7q
         sZXg==
X-Gm-Message-State: ACgBeo023XOsjOxl/4Nw58ay7J6d1pPC24t9l70z7JZdH3yKWFTGmOpv
        /eO+0nT7WeSiYxPOf42kRLumbikCev8=
X-Google-Smtp-Source: AA6agR7nSrHh2h4kB2kKYTa0py2r+eQGRLobPUH2fZSgan4UTOTKUgTS7ZHzYVmWUxmM2RmPNQXmCg==
X-Received: by 2002:a63:d80f:0:b0:438:69c7:7df7 with SMTP id b15-20020a63d80f000000b0043869c77df7mr17769857pgh.261.1663009682475;
        Mon, 12 Sep 2022 12:08:02 -0700 (PDT)
Received: from localhost.localdomain ([116.73.241.66])
        by smtp.gmail.com with ESMTPSA id 68-20020a630547000000b00434272fe870sm1091889pgf.88.2022.09.12.12.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 12:08:01 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jagathjog1996@gmail.com
Subject: [PATCH v2 1/2] dt-bindings: rtc: add Maxim max31329 rtc device tree bindings
Date:   Tue, 13 Sep 2022 00:37:52 +0530
Message-Id: <20220912190753.10158-2-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220912190753.10158-1-jagathjog1996@gmail.com>
References: <20220912190753.10158-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document devicetree bindings for the Maxim max31329 real time clock.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/rtc/maxim,max31329.yaml          | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/maxim,max31329.yaml

diff --git a/Documentation/devicetree/bindings/rtc/maxim,max31329.yaml b/Documentation/devicetree/bindings/rtc/maxim,max31329.yaml
new file mode 100644
index 000000000000..fc99f1854847
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/maxim,max31329.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/maxim,max31329.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX31329 Real Time Clock
+
+maintainers:
+  - Jagath Jog J <jagathjog1996@gmail.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: maxim,max31329
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 0
+
+  clock-output-names:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  trickle-resistor-ohms:
+    enum:
+      - 3000
+      - 6000
+      - 11000
+
+  wakeup-source: true
+
+  start-year: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@68 {
+            compatible = "maxim,max31329";
+            reg = <0x68>;
+            trickle-resistor-ohms = <6000>;
+            #clock-cells = <0>;
+        };
+    };
+...
-- 
2.17.1

