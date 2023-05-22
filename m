Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FE270C3F0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbjEVRDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjEVRDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:03:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E5DFE;
        Mon, 22 May 2023 10:03:44 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-208-162.ewe-ip-backbone.de [91.248.208.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CF3CE66058F2;
        Mon, 22 May 2023 18:03:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684775023;
        bh=SnIuBsU5kpCH9yPr3h2kL9GaEGKLFpCi+TtA5q9biHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JL2LQsn+CU1CxsWwr7jgwSvPLUdmgznwYDN5Zp/80zTnPJGJmnZw4sVL2DocPjbFz
         aG5XEF+hGuZ5F1EDF/AVr24l7zJNOOV6xCvh5zE7qoG11+e1vNX7wyzdoDj8asXmio
         dQtf9ZDe8MgPmrDcP/ogudB26xig1RWRtJxpAkBSJLP9OBG718rcCc6DyMzXbtVerD
         Ej0klxZIYkZTEtF8UMmTxEnMo2mBsJZi+pP7/a+NE8QUAPvJ+ZUml7L4Ycw4HJS2p1
         UiDZzji7zBb1R30DOSdOWLBdBxgROZjOWQiVnBhHn7vQ9uPS1meLgd3l3ExPkDFlCJ
         maXKcYPj9fppA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 78F6B4805B8; Mon, 22 May 2023 19:03:40 +0200 (CEST)
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
        kernel@collabora.com, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/7] dt-bindings: phy: rockchip,inno-usb2phy: add rk3588
Date:   Mon, 22 May 2023 19:03:18 +0200
Message-Id: <20230522170324.61349-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522170324.61349-1-sebastian.reichel@collabora.com>
References: <20230522170324.61349-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for the USB2 phy in the Rockchip RK3588 SoC.

Reviewed-by: Rob Herring <robh@kernel.org>
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

