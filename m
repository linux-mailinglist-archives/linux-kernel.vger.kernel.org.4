Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FFB6D25DA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjCaQmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjCaQl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:41:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E052291D;
        Fri, 31 Mar 2023 09:38:18 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-213-136.ewe-ip-backbone.de [91.248.213.136])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B715B660319C;
        Fri, 31 Mar 2023 17:38:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680280696;
        bh=IanGuFMtYNipnpczUMLMr5LoVeF2LYQjoKAV5cNfhuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mJg3f1Gi+1cc0aypuEBm1Au6W+2Hb7hdZ7C+ZzKxOyc9xgK4saf14aK9a4YKtSmpX
         bN7fP8QVF0fvXvX8xnMT+6933JacK4eCWKDHuJXW/0cqOZbMmbr8DtgW2TSQnUOdrv
         OQr3NynCiH5Vj3+fO3UUjjVTrHNHDJXiYwRs2GV9ZYByXiYjfz8jRCI3lRzP0TumoX
         wp4W1XxF7TLEXSr30iyUIkoFliDH/EyoASF5vWPu1ykVglZlYPDosOSsrsEyMXDjY4
         FKQKR2lu85CX6Rfe2rGNY/7TonswHbvr+Z+3CgWCGE8l540ZQAXd49p/Z3LfRSMyg5
         JpuAFJAkzBohQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id EBDAF4807E3; Fri, 31 Mar 2023 18:38:13 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv1 2/3] dt-bindings: phy: rockchip,inno-usb2phy: add rk3588
Date:   Fri, 31 Mar 2023 18:38:11 +0200
Message-Id: <20230331163812.6124-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331163812.6124-1-sebastian.reichel@collabora.com>
References: <20230331163812.6124-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for the USB2 phy in the Rockchip RK3588 SoC.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/phy/rockchip,inno-usb2phy.yaml   | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
index 0d6b8c28be07..5254413137c6 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
@@ -20,6 +20,7 @@ properties:
       - rockchip,rk3366-usb2phy
       - rockchip,rk3399-usb2phy
       - rockchip,rk3568-usb2phy
+      - rockchip,rk3588-usb2phy
       - rockchip,rv1108-usb2phy
 
   reg:
@@ -56,6 +57,14 @@ properties:
     description: Muxed interrupt for both ports
     maxItems: 1
 
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: phy
+      - const: apb
+
   rockchip,usbgrf:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -120,15 +129,21 @@ required:
   - reg
   - clock-output-names
   - "#clock-cells"
-  - host-port
-  - otg-port
+
+anyOf:
+  - required:
+      - otg-port
+  - required:
+      - host-port
 
 allOf:
   - if:
       properties:
         compatible:
           contains:
-            const: rockchip,rk3568-usb2phy
+            enum:
+              - rockchip,rk3568-usb2phy
+              - rockchip,rk3588-usb2phy
 
     then:
       properties:
-- 
2.39.2

