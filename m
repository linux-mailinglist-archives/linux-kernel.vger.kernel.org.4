Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2C06CAB44
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjC0RCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbjC0RBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:01:49 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294FD40F3;
        Mon, 27 Mar 2023 10:01:44 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-17aeb49429eso9961881fac.6;
        Mon, 27 Mar 2023 10:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679936503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vsiiS+cg9ETxQ7qmK+ws7pFEXw6XBClGT7/dY2V6YIU=;
        b=bVZm5l7aTZvKBMXP9G98Z3wDRRJjdqKdDAITZtlzKVyXme4PC4Z4iKHDwJGpTrhByT
         Xw/a3QUVakPT2UWf6lNGUXU3MlmMrf55AalH7XVcwObbVEAbbqGmaFLQSvoj8tYUd/2Q
         7pTY6VERpZjqnH9oXbWHqibymarGVOfEaXIRflSZpKsJFjbFp9KxTNFVf9bkkomwSadM
         ozE2/B/7WePreXRrva0FqWdK2y4g350rRyPPe7BoC+373uJ1giO6+fuVuFHSSlIRDD/y
         QxT21rVYQLbT6LP8FS7xx2hozzI5CIcRFGw8lcy9KMyAzPM2X0LDm4eT+o+ziparSgjx
         LkIw==
X-Gm-Message-State: AAQBX9f3K1wQoTVpeX86/ix/PolQPHmot+CZDYNZXE6Yjl0GT+1VkVyo
        KttlMa8S4qddb6Sz9L4sgg==
X-Google-Smtp-Source: AKy350Y8FlKQ/y1NaNuo1nCVn3oPUauVYD2sc8z7OjA3kA1wH7XZPPgYFn9GWGfUSER2YH3YSr7JQg==
X-Received: by 2002:a05:6870:9711:b0:177:b6ce:1e76 with SMTP id n17-20020a056870971100b00177b6ce1e76mr8661847oaq.55.1679936503338;
        Mon, 27 Mar 2023 10:01:43 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id zq35-20020a0568718ea300b0017f647294f5sm503569oab.16.2023.03.27.10.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 10:01:42 -0700 (PDT)
Received: (nullmailer pid 4104460 invoked by uid 1000);
        Mon, 27 Mar 2023 17:01:41 -0000
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Hammer Hsieh <hammerh0314@gmail.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: Drop unneeded quotes
Date:   Mon, 27 Mar 2023 12:01:36 -0500
Message-Id: <20230327170137.4104272-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/serial/amlogic,meson-uart.yaml        | 4 ++--
 .../devicetree/bindings/serial/qcom,serial-geni-qcom.yaml     | 4 ++--
 Documentation/devicetree/bindings/serial/renesas,em-uart.yaml | 4 ++--
 Documentation/devicetree/bindings/serial/renesas,hscif.yaml   | 4 ++--
 Documentation/devicetree/bindings/serial/renesas,sci.yaml     | 4 ++--
 Documentation/devicetree/bindings/serial/renesas,scif.yaml    | 4 ++--
 Documentation/devicetree/bindings/serial/renesas,scifa.yaml   | 4 ++--
 Documentation/devicetree/bindings/serial/renesas,scifb.yaml   | 4 ++--
 Documentation/devicetree/bindings/serial/serial.yaml          | 4 ++--
 Documentation/devicetree/bindings/serial/sprd-uart.yaml       | 4 ++--
 .../devicetree/bindings/serial/sunplus,sp7021-uart.yaml       | 4 ++--
 11 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index 3cbdde85ed71..ad13df48a590 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 BayLibre, SAS
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/serial/amlogic,meson-uart.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/serial/amlogic,meson-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic Meson SoC UART Serial Interface
 
diff --git a/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml b/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml
index 05a6999808d1..dd33794b3534 100644
--- a/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml
+++ b/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/serial/qcom,serial-geni-qcom.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/serial/qcom,serial-geni-qcom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm Geni based QUP UART interface
 
diff --git a/Documentation/devicetree/bindings/serial/renesas,em-uart.yaml b/Documentation/devicetree/bindings/serial/renesas,em-uart.yaml
index 12d0fa34f9f9..3fc2601f1338 100644
--- a/Documentation/devicetree/bindings/serial/renesas,em-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,em-uart.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/serial/renesas,em-uart.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/serial/renesas,em-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Renesas EMMA Mobile UART Interface
 
diff --git a/Documentation/devicetree/bindings/serial/renesas,hscif.yaml b/Documentation/devicetree/bindings/serial/renesas,hscif.yaml
index afedb6edfc34..1c7f1276aed6 100644
--- a/Documentation/devicetree/bindings/serial/renesas,hscif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,hscif.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/serial/renesas,hscif.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/serial/renesas,hscif.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Renesas High Speed Serial Communication Interface with FIFO (HSCIF)
 
diff --git a/Documentation/devicetree/bindings/serial/renesas,sci.yaml b/Documentation/devicetree/bindings/serial/renesas,sci.yaml
index dc445b327e0b..9f7305200c47 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,sci.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/serial/renesas,sci.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/serial/renesas,sci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Renesas Serial Communication Interface
 
diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index 1989bd67d04e..f26bea2d7398 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/serial/renesas,scif.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/serial/renesas,scif.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Renesas Serial Communication Interface with FIFO (SCIF)
 
diff --git a/Documentation/devicetree/bindings/serial/renesas,scifa.yaml b/Documentation/devicetree/bindings/serial/renesas,scifa.yaml
index 4c3b5e7270da..499507678cdf 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scifa.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scifa.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/serial/renesas,scifa.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/serial/renesas,scifa.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Renesas Serial Communications Interface with FIFO A (SCIFA)
 
diff --git a/Documentation/devicetree/bindings/serial/renesas,scifb.yaml b/Documentation/devicetree/bindings/serial/renesas,scifb.yaml
index 2f7cbbb48960..810d8a991fdd 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scifb.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scifb.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/serial/renesas,scifb.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/serial/renesas,scifb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Renesas Serial Communications Interface with FIFO B (SCIFB)
 
diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
index c9231e501f1f..ea277560a596 100644
--- a/Documentation/devicetree/bindings/serial/serial.yaml
+++ b/Documentation/devicetree/bindings/serial/serial.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/serial/serial.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/serial/serial.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Serial Interface Generic
 
diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.yaml b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
index da0e2745b5fc..28ff77aa86c8 100644
--- a/Documentation/devicetree/bindings/serial/sprd-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 Unisoc Inc.
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/serial/sprd-uart.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/serial/sprd-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Spreadtrum serial UART
 
diff --git a/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml b/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
index ea1e637661c7..7d0a4bcb88e9 100644
--- a/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) Sunplus Co., Ltd. 2021
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/serial/sunplus,sp7021-uart.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/serial/sunplus,sp7021-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Sunplus SoC SP7021 UART Controller
 
-- 
2.39.2

