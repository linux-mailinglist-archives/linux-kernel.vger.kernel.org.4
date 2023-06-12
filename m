Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F20B72CB6D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbjFLQZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjFLQYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:24:49 -0400
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FFD199;
        Mon, 12 Jun 2023 09:24:48 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1q8kLW-006Ghq-Cl; Mon, 12 Jun 2023 16:24:46 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND v2] dt-bindings: mfd: gateworks-gsc: remove unnecessary fan-controller nodes
Date:   Mon, 12 Jun 2023 09:24:44 -0700
Message-Id: <20230612162444.3936302-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unnecessary #address-cells and #size-cells nodes from
the fan-controller. These are not needed as the fan controller does not
have any children.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v2:
 - udpated commit log to explain why the nodes are unnessesary
 - added Krzysztof's rb tag
---
 .../devicetree/bindings/mfd/gateworks-gsc.yaml         | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
index acb9c54942d9..dc379f3ebf24 100644
--- a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
+++ b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
@@ -122,12 +122,6 @@ patternProperties:
       compatible:
         const: gw,gsc-fan
 
-      "#address-cells":
-        const: 1
-
-      "#size-cells":
-        const: 0
-
       reg:
         description: The fan controller base address
         maxItems: 1
@@ -135,8 +129,6 @@ patternProperties:
     required:
       - compatible
       - reg
-      - "#address-cells"
-      - "#size-cells"
 
 required:
   - compatible
@@ -194,8 +186,6 @@ examples:
             };
 
             fan-controller@2c {
-                #address-cells = <1>;
-                #size-cells = <0>;
                 compatible = "gw,gsc-fan";
                 reg = <0x2c>;
             };
-- 
2.25.1

