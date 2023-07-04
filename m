Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497D6746D9B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjGDJfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjGDJeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:34:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E869E1BD0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 02:33:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qGcOw-0006vB-Pq; Tue, 04 Jul 2023 11:32:50 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qGcOv-00C0AG-O9; Tue, 04 Jul 2023 11:32:49 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qGcOr-002Tyw-EU; Tue, 04 Jul 2023 11:32:45 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 21/26] dt-bindings: devfreq: event: rockchip,dfi: Add rk3568 support
Date:   Tue,  4 Jul 2023 11:32:37 +0200
Message-Id: <20230704093242.583575-22-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230704093242.583575-1-s.hauer@pengutronix.de>
References: <20230704093242.583575-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the rockchip,rk3568-dfi compatible to the binding. Make clocks
optional for this SoC as the RK3568 doesn't have a kernel controllable
PCLK.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 .../bindings/devfreq/event/rockchip,dfi.yaml      | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
index 7a82f6ae0701e..e8b64494ee8bd 100644
--- a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
+++ b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     enum:
       - rockchip,rk3399-dfi
+      - rockchip,rk3568-dfi
 
   clocks:
     maxItems: 1
@@ -34,11 +35,21 @@ properties:
 
 required:
   - compatible
-  - clocks
-  - clock-names
   - interrupts
   - reg
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - rockchip,rk3399-dfi
+
+then:
+  required:
+    - clocks
+    - clock-names
+
 additionalProperties: false
 
 examples:
-- 
2.39.2

