Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B721B719D11
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbjFANNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjFANNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:13:44 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFB0E7;
        Thu,  1 Jun 2023 06:13:41 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id E29722143E;
        Thu,  1 Jun 2023 15:13:37 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/5] dt-bindings: arm: ti: add toradex,verdin-am62 et al.
Date:   Thu,  1 Jun 2023 15:13:28 +0200
Message-Id: <20230601131332.26877-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601131332.26877-1-francesco@dolcini.it>
References: <20230601131332.26877-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add toradex,verdin-am62 for Toradex Verdin AM62 SoM, its
nonwifi and wifi variants and the carrier boards (Dahlia,
Verdin Development Board and Yavia) they may be mated in.

Link: https://developer.toradex.com/hardware/verdin-som-family/modules/verdin-am62/
Link: https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
v2: added reviewed-by
---
 .../devicetree/bindings/arm/ti/k3.yaml        | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index e1183f90bb06..e3aee191d403 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -33,6 +33,26 @@ properties:
               - ti,am62-lp-sk
           - const: ti,am625
 
+      - description: K3 AM62x SoC Toradex Verdin Modules and Carrier Boards
+        items:
+          - enum:
+              - toradex,verdin-am62-nonwifi-dahlia # Verdin AM62 Module on Dahlia
+              - toradex,verdin-am62-nonwifi-dev    # Verdin AM62 Module on Verdin Development Board
+              - toradex,verdin-am62-nonwifi-yavia  # Verdin AM62 Module on Yavia
+          - const: toradex,verdin-am62-nonwifi     # Verdin AM62 Module without Wi-Fi / BT
+          - const: toradex,verdin-am62             # Verdin AM62 Module
+          - const: ti,am625
+
+      - description: K3 AM62x SoC Toradex Verdin Modules and Carrier Boards with Wi-Fi / BT
+        items:
+          - enum:
+              - toradex,verdin-am62-wifi-dahlia # Verdin AM62 Wi-Fi / BT Module on Dahlia
+              - toradex,verdin-am62-wifi-dev    # Verdin AM62 Wi-Fi / BT M. on Verdin Development B.
+              - toradex,verdin-am62-wifi-yavia  # Verdin AM62 Wi-Fi / BT Module on Yavia
+          - const: toradex,verdin-am62-wifi     # Verdin AM62 Wi-Fi / BT Module
+          - const: toradex,verdin-am62          # Verdin AM62 Module
+          - const: ti,am625
+
       - description: K3 AM642 SoC
         items:
           - enum:
-- 
2.25.1

