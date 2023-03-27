Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586E76CAB70
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjC0REe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjC0RDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:03:49 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717475FF9;
        Mon, 27 Mar 2023 10:02:54 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-17aeb49429eso9965578fac.6;
        Mon, 27 Mar 2023 10:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679936559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIK1w+CXfgSPJmxTqeF0/WQOBbahQffqFqpwRnNFhjs=;
        b=7n+l4yl5Fqpbq54z2tLBnhZZgOzWxQBjA/8+3qfMfH98MGy4q+s3XI6gkhf/tSwMLa
         Wb0GFncfvTeFJjCO4nPY78eGyDTuMER7CLOXsHBOXsiJVKWlRf5NZLle74SAKJF0jRL1
         n+6vX1VJ9TUtL4XpLkrqk9X22riXiahuym9SdKk9rjtNojDa61h5/l3Tas1mr0NrVLnC
         jb5A+6ZaaFPiwzrCnmvB9W2VS6qv06EAgXsy06EkaazUDDyFmJY1Eu51TbThu9CvoLuB
         JgshXEJUsbQ4hnQPiDodp+weySsSPVhYdot1k15WyM8W28sfCWkSdQ861j4zYRG7sKRq
         HjlQ==
X-Gm-Message-State: AAQBX9f7tQ10PcXrm0hE5lIoD+IITT+zhXU6FLK0sDAMlfNKG5tfxgUn
        1faxKDo60gPmSCOUTkWztg==
X-Google-Smtp-Source: AK7set+MgI/6QDWdbY7OBxPG8ErWpLlNItv/Ke5WnutBBXElg5yFH9Vd1Qk0S5csPH3n3Vjv/B4wYA==
X-Received: by 2002:a05:6870:8289:b0:177:ab68:aa9e with SMTP id q9-20020a056870828900b00177ab68aa9emr7503297oae.21.1679936559347;
        Mon, 27 Mar 2023 10:02:39 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id vd21-20020a0568708f9500b0017ae1aede32sm9799431oab.46.2023.03.27.10.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 10:02:38 -0700 (PDT)
Received: (nullmailer pid 4109396 invoked by uid 1000);
        Mon, 27 Mar 2023 17:02:37 -0000
From:   Rob Herring <robh@kernel.org>
To:     Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: thermal: Drop unneeded quotes
Date:   Mon, 27 Mar 2023 12:02:33 -0500
Message-Id: <20230327170233.4109156-1-robh@kernel.org>
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
 .../devicetree/bindings/thermal/amlogic,thermal.yaml          | 2 +-
 Documentation/devicetree/bindings/thermal/imx-thermal.yaml    | 4 ++--
 Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
index 999c6b365f1d..20f8f9b3b971 100644
--- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -30,7 +30,7 @@ properties:
 
   amlogic,ao-secure:
     description: phandle to the ao-secure syscon
-    $ref: '/schemas/types.yaml#/definitions/phandle'
+    $ref: /schemas/types.yaml#/definitions/phandle
 
   '#thermal-sensor-cells':
     const: 0
diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
index b22c8b59d5c7..fe599e443eaf 100644
--- a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
@@ -40,11 +40,11 @@ properties:
       - const: temp_grade
 
   fsl,tempmon:
-    $ref: '/schemas/types.yaml#/definitions/phandle'
+    $ref: /schemas/types.yaml#/definitions/phandle
     description: Phandle to anatop system controller node.
 
   fsl,tempmon-data:
-    $ref: '/schemas/types.yaml#/definitions/phandle'
+    $ref: /schemas/types.yaml#/definitions/phandle
     description: |
       Deprecated property, phandle pointer to fuse controller that contains
       TEMPMON calibration data, e.g. OCOTP on imx6q. The details about
diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
index f09e8723ca2b..145744027234 100644
--- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
@@ -29,14 +29,14 @@ properties:
     maxItems: 1
 
   fsl,tmu-range:
-    $ref: '/schemas/types.yaml#/definitions/uint32-array'
+    $ref: /schemas/types.yaml#/definitions/uint32-array
     description: |
       The values to be programmed into TTRnCR, as specified by the SoC
       reference manual. The first cell is TTR0CR, the second is TTR1CR, etc.
     maxItems: 4
 
   fsl,tmu-calibration:
-    $ref: '/schemas/types.yaml#/definitions/uint32-matrix'
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
     description: |
       A list of cell pairs containing temperature calibration data, as
       specified by the SoC reference manual. The first cell of each pair
-- 
2.39.2

