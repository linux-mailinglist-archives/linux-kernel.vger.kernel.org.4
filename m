Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4816F914F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 12:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjEFKwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 06:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEFKwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 06:52:20 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9384F4C1E;
        Sat,  6 May 2023 03:52:16 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-52caed90d17so920379a12.0;
        Sat, 06 May 2023 03:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683370336; x=1685962336;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2WPWQzoKyocx4jwyrEWsU5/Mb3QtUt6PFyws4Xy1T9Y=;
        b=Y02N91RBlzP2MsrhYJsjugMSEbfcZeRHNsSeyLH0V4jJ25bvKsKxum9+cfrKRdmtyE
         2jatmgCyio0UXbdC5JSLlzi8onHkp8ZHKZZn/iLsDX8mWZKwY6PFx1qPx7x/NJZ8rYbm
         KxrX+GYTu+U36gmbDb55e+PAqY6n2+SMxQ1x9yCiI/l/76xBikEFrFFYU8t+TYJM2kbd
         sJB5bKMu/Xu3nppT0lSI4csaJQ8m86fKjwN+ZwE5VCDsAhEsVMsbhGyKHh4oBCOSM1c6
         5ZEYz2hvMQTPDuVgNKp9LKmVynKqFqtITxT1OE3W8fUW5cd/82N15gDukM3QRmhdqkY2
         rAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683370336; x=1685962336;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WPWQzoKyocx4jwyrEWsU5/Mb3QtUt6PFyws4Xy1T9Y=;
        b=b0PFRd/85KlJwKgdyeKkuJNmlERlRjBwht6R4oI0Kz7dGk4LB8yxfpiIf9iSE6mASh
         1PQTu40cQW2bCXOXLsrVJURkYXiz57WuaK4vc2lSosAzQq7ioCzI32QVyA2a9Butn3Yl
         fdiJ/pR1Xo+Sp5NTcZAgxjnR9bpQoZSflCGN9/RzPm2kWVOkvmo+xOhoy9js6K9rLCQC
         8XNa++lYCfMaRSpU1nwCBeKp86me2qeoQCpuEP5E5a6NQd3/rwPYMELKYTCSpA4iUuCy
         lDwSrNevWk4cO49jxr/cH3+Lta9EuaAat34sb+IkrAqVV1SM++kT+T7OpOlYqXH2gpIu
         6KMA==
X-Gm-Message-State: AC+VfDwj4uqQobc0FJ/Ma2DkwPLuW4II3F0O8p8H6u2UD6+e1+8EHhTM
        8L8MsF/cwVdBe3Eii5FS2DN3DCj/EkP5zKVs
X-Google-Smtp-Source: ACHHUZ64Hd99wZVk+p30c+4tID1J1V+hd30DeVjfmgF0X5yIzsDDwYEdecW6dcmGNDwQPN+e5WT1Rw==
X-Received: by 2002:a17:902:d4c3:b0:1ab:14da:981 with SMTP id o3-20020a170902d4c300b001ab14da0981mr5141456plg.35.1683370335839;
        Sat, 06 May 2023 03:52:15 -0700 (PDT)
Received: from yoga ([2400:1f00:13:6324:7c97:8040:5b6b:bbd5])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902748c00b001a9581d3ef5sm3322457pll.97.2023.05.06.03.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 03:52:15 -0700 (PDT)
Date:   Sat, 6 May 2023 16:22:09 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     robh@kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        KCHSU0@nuvoton.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: dt-bindings: nau8540: Convert to dtschema
Message-ID: <ZFYxWVdE9YkMKvXv@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the NAU8540 audio CODEC bindings to DT schema

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>

Changes:
V1 -> V2: Adhere to the correct procedure by including the maintainer's name.
          Drop Mark from maintainer.
---
 .../devicetree/bindings/sound/nau8540.txt     | 16 --------
 .../bindings/sound/nuvoton,nau8540.yaml       | 40 +++++++++++++++++++
 2 files changed, 40 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/nau8540.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8540.yaml

diff --git a/Documentation/devicetree/bindings/sound/nau8540.txt b/Documentation/devicetree/bindings/sound/nau8540.txt
deleted file mode 100644
index 307a76528320..000000000000
--- a/Documentation/devicetree/bindings/sound/nau8540.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-NAU85L40 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-
-  - compatible : "nuvoton,nau8540"
-
-  - reg : the I2C address of the device.
-
-Example:
-
-codec: nau8540@1c {
-       compatible = "nuvoton,nau8540";
-       reg = <0x1c>;
-};
diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8540.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8540.yaml
new file mode 100644
index 000000000000..7ccfbb8d8b04
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8540.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nuvoton,nau8540.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton Technology Corporation NAU85L40 Audio CODEC
+
+maintainers:
+  - John Hsu <KCHSU0@nuvoton.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: nuvoton,nau8540
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec@1c {
+            compatible = "nuvoton,nau8540";
+            reg = <0x1c>;
+        };
+    };
-- 
2.34.1

