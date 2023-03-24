Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55A16C7D34
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCXLav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjCXLat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:30:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAEB11ABCD;
        Fri, 24 Mar 2023 04:30:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 825B412FC;
        Fri, 24 Mar 2023 04:31:32 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 951553F6C4;
        Fri, 24 Mar 2023 04:30:46 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com, Shengyu Qu <wiagn233@outlook.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v9 1/3] dt-bindings: mfd: x-powers,axp152: Document the AXP313a variant
Date:   Fri, 24 Mar 2023 11:30:11 +0000
Message-Id: <20230324113013.254371-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230324113013.254371-1-andre.przywara@arm.com>
References: <20230324113013.254371-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Botka <martin.botka@somainline.org>

The X-Powers AXP313a is a PMIC used on some devices with the Allwinner
H616 or H313 SoC.
According to the datasheet, the DC/DC converter PWM frequency is fixed
(to 3 MHz), so disallow the property that lets us set this frequency
for the other PMICs.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../devicetree/bindings/mfd/x-powers,axp152.yaml     | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
index b7a8747d5fa0e..4b4f42cb09ef7 100644
--- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
+++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
@@ -79,6 +79,17 @@ allOf:
       required:
         - interrupts
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: x-powers,axp313a
+
+    then:
+      not:
+        required:
+          - x-powers,dcdc-freq
+
 properties:
   compatible:
     oneOf:
@@ -88,6 +99,7 @@ properties:
           - x-powers,axp209
           - x-powers,axp221
           - x-powers,axp223
+          - x-powers,axp313a
           - x-powers,axp803
           - x-powers,axp806
           - x-powers,axp809
-- 
2.25.1

