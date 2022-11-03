Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DFB617A92
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiKCKEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiKCKE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:04:28 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07C5B873;
        Thu,  3 Nov 2022 03:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=jmb9l/w71G93+xK3oMfR1qcsVCte17Szsx88agaWhpw=; b=O2hdz3ouA7GDM/FOCYs0SAF22Y
        nA+vqTEgd/0iz90W7eA2lZ89lqgg7OKNhW/G1leLkDW+2tKCdku7LqbvdFU5l4CIEnbnkndp/L2Sr
        OF5OQTzv7XBRMFEaPXtJ9KeAhdVFjT9iJeIdmmUBKyy8WBR9V+FpB57zhlbmI4WpxPTej9ZaxWh/g
        T0t9kdHx4fOZF2auq1jY1GV1G1BdrKgc1FOb8/VCmJN792I12BGrWB+m7RgyahGtvb3BBAVa5mty+
        grMaKqh/NN5yNIVnhWK2YQ0kKYV43U+bMndsONMGQ4ciGDs+c+sVrzDprEkRlJ035Akg+H/HREFZ+
        ksThOhEQ==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:37996 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <andrej.picej@norik.com>)
        id 1oqX52-008HsM-HQ;
        Thu, 03 Nov 2022 11:04:20 +0100
From:   Andrej Picej <andrej.picej@norik.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: watchdog: fsl-imx: document suspend in wait mode
Date:   Thu,  3 Nov 2022 11:03:57 +0100
Message-Id: <20221103100358.176099-3-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221103100358.176099-1-andrej.picej@norik.com>
References: <20221103100358.176099-1-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Property "fsl,suspend-in-wait" suspends watchdog in "WAIT" mode which
corresponds to Linux's Suspend-to-Idle S0 mode. If this property is not
set and the device is put into Suspend-to-Idle mode, the watchdog
triggers a reset after 128 seconds.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
Changes in v3:
 - disallow the property for devices which don't support WDW bit
   functionality with .yaml DTS allOf:if:then scheme.

Changes in v2:
 - add a commit message,
 - add a list of devices which support this functionality
---
 .../bindings/watchdog/fsl-imx-wdt.yaml        | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
index fb7695515be1..12de8bbc8460 100644
--- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
@@ -55,6 +55,12 @@ properties:
       If present, the watchdog device is configured to assert its
       external reset (WDOG_B) instead of issuing a software reset.
 
+  fsl,suspend-in-wait:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      If present, the watchdog device is suspended in WAIT mode
+      (Suspend-to-Idle). Only supported on certain devices.
+
 required:
   - compatible
   - interrupts
@@ -62,6 +68,33 @@ required:
 
 unevaluatedProperties: false
 
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - fsl,imx25-wdt
+                - fsl,imx35-wdt
+                - fsl,imx50-wdt
+                - fsl,imx51-wdt
+                - fsl,imx53-wdt
+                - fsl,imx6q-wdt
+                - fsl,imx6sl-wdt
+                - fsl,imx6sll-wdt
+                - fsl,imx6sx-wdt
+                - fsl,imx6ul-wdt
+                - fsl,imx7d-wdt
+                - fsl,imx8mm-wdt
+                - fsl,imx8mn-wdt
+                - fsl,imx8mp-wdt
+                - fsl,imx8mq-wdt
+                - fsl,vf610-wdt
+    then:
+      properties:
+        fsl,suspend-in-wait: false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-- 
2.25.1

