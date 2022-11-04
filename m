Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE1C61918F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 08:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiKDHEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 03:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiKDHEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 03:04:10 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9D426AE0;
        Fri,  4 Nov 2022 00:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2p85PywWzOGMuPi7LyVF87Rkg9ap8Sdw6fppqAVvpvc=; b=GO0642ydkU1voJokRMyiEkKoPx
        7hk3cOAuFbgsjZWIF4PTzcR0+olDRePSwS20plXvrCyzIhcChT53n0Da8bjon25fGn/QSMoTvcyw+
        JdlJgOm0bSPmNYxoz1Qu91tE67yIIJVRbJU27+AoeU/fbiYq7n6HWBPBGMTjNC+bOEkdaSTFWT5qv
        zgar4jHm2I+nxezY0+uIrse5/0fCsmrq1X4kYDBCRtmy/AjAUIf3FENWHT9sLFGuAPb1G/snz+ux0
        hjxRI4T9nDZLG77CgWFwayjP9hEQxk2rQ09t3N/kyyrEUvIxAdGnvxz6+s9JZOZ8Rn39xOlmHTEnB
        8uzE+gAg==;
Received: from [89.212.21.243] (port=40616 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <andrej.picej@norik.com>)
        id 1oqqk7-00EcG2-Gk;
        Fri, 04 Nov 2022 08:04:02 +0100
From:   Andrej Picej <andrej.picej@norik.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] dt-bindings: watchdog: fsl-imx: document suspend in wait mode
Date:   Fri,  4 Nov 2022 08:03:57 +0100
Message-Id: <20221104070358.426657-3-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221104070358.426657-1-andrej.picej@norik.com>
References: <20221104070358.426657-1-andrej.picej@norik.com>
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
Changes in v4:
 - combine allOf, reorder allOf so it follows example-schema, drop the
   quotes around 'watchdog.yaml'.

Changes in v3:
 - disallow the property for devices which don't support WDW bit
   functionality with .yaml DTS allOf:if:then scheme.

Changes in v2:
 - add a commit message,
 - add a list of devices which support this functionality
---
 .../bindings/watchdog/fsl-imx-wdt.yaml        | 37 +++++++++++++++++--
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
index fb7695515be1..181f0cc5b5bd 100644
--- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
@@ -9,9 +9,6 @@ title: Freescale i.MX Watchdog Timer (WDT) Controller
 maintainers:
   - Anson Huang <Anson.Huang@nxp.com>
 
-allOf:
-  - $ref: "watchdog.yaml#"
-
 properties:
   compatible:
     oneOf:
@@ -55,11 +52,45 @@ properties:
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
   - reg
 
+allOf:
+  - $ref: watchdog.yaml#
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
 unevaluatedProperties: false
 
 examples:
-- 
2.25.1

