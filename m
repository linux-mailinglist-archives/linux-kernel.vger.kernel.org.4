Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B9C6E1390
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjDMRcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjDMRcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:32:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3FA93D2;
        Thu, 13 Apr 2023 10:31:56 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-212-251.ewe-ip-backbone.de [91.248.212.251])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 880CE660321C;
        Thu, 13 Apr 2023 18:31:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681407114;
        bh=9fXlimUk4RI4TS7WB7TrWJCQOOCfy/yC4BkqgN4K5Io=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WLjc8D/ZxyFYoW2KaMRAWUO24rFnT65DUuaFIMuaYrrz9TJcMT8ksCfwuwTiR2mtw
         hpHsdW8HQ4gQPPZS0iVcJrdXPTiOAPVFWSkt5DPmhs5CpvtHfgErci23QQ17lNXF89
         xCHU7ixp0UUWSPV3XiGUpH+MLz0e1cdVbK9I40adBfCCn28c6ZaPkds0yuy2GZHLxT
         ODhaLlujZu1CYo6yhxTwy5uQrEnlSwRDJ3ems2sCA8FSU4S4MPvytnm+QGu6qXSULb
         Zar9oDkjKQ98MGgtxlIxobznallwOWyjXwscOjKpQGU/4PiKjQYR621Wx+pfazf8y4
         ddDRmFDURQNtw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id CA56E4807E3; Thu, 13 Apr 2023 19:31:51 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com, Rob Herring <robh@kernel.org>
Subject: [PATCHv4 1/3] dt-bindings: usb: Add RK3588 OHCI
Date:   Thu, 13 Apr 2023 19:31:48 +0200
Message-Id: <20230413173150.71387-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413173150.71387-1-sebastian.reichel@collabora.com>
References: <20230413173150.71387-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for RK3588 OHCI. As far as I know it's fully
compatible with generic-ohci.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/usb/generic-ohci.yaml    | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/generic-ohci.yaml b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
index a9ba7257b884..4feb993af53b 100644
--- a/Documentation/devicetree/bindings/usb/generic-ohci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
@@ -44,6 +44,7 @@ properties:
               - hpe,gxp-ohci
               - ibm,476gtr-ohci
               - ingenic,jz4740-ohci
+              - rockchip,rk3588-ohci
               - snps,hsdk-v1.0-ohci
           - const: generic-ohci
       - enum:
@@ -69,7 +70,7 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 3
+    maxItems: 4
     description: |
       In case the Renesas R-Car Gen3 SoCs:
         - if a host only channel: first clock should be host.
@@ -147,6 +148,19 @@ allOf:
     then:
       properties:
         transceiver: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3588-ohci
+    then:
+      properties:
+        clocks:
+          minItems: 4
+    else:
+      properties:
+        clocks:
+          maxItems: 3
 
 additionalProperties: false
 
-- 
2.39.2

