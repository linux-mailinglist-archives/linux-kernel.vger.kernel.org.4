Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26641724D3F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbjFFTkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239166AbjFFTk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:40:28 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89611731;
        Tue,  6 Jun 2023 12:40:20 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 5644C5FD04;
        Tue,  6 Jun 2023 22:40:18 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686080418;
        bh=/a/D+K5/RvpmyF70t6iC3BBkjuaMSTKw05HEPcEHC4s=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=U6ocXN1G6uTrfaWco6cAeZM97dFR7tz6TUPf7CeCu5CPDjXQU2dre7b8dh0i+JaAK
         KqpPea98a9Weqoio4IuCXDQv2dpQGgtbwoSCvm8XjnJfQVFbqfnbB4D3Q5UBR9lyAK
         8szkyAnbPVdaOpQoQfYawi3x2iLT6kpwIopS85LWSIYoDjNB0BB7k+60IAsnGgf+8z
         bNbRpjqIPeL6L+yDyQHQh2QB+zV0GTUEPp/7KGC8Zo94TH+VJeICPdbEuqkkMAJvbn
         HJalKIdx3G9HVCEMfKdfLC9dYslMShjC+j3ylvJiZCM5NcitWJhWFX/CXyqgChb047
         Xga83sr0FzWCg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue,  6 Jun 2023 22:40:16 +0300 (MSK)
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] dt-bindings: nand: meson: Fix 'nand-rb' property
Date:   Tue, 6 Jun 2023 22:35:07 +0300
Message-ID: <20230606193507.35024-1-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/06 14:43:00 #21444531
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of 'nand-rb' property. Use "Fixes" because this property
must be supported since the beginning. For this controller 'nand-rb' is
stored in the controller node (not in chip), because it has only single
r/b wire for all chips.

Fixes: fbc00b5e746f ("dt-bindings: nand: meson: convert txt to yaml")
Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
index 28fb9a7dd70f..866edf800b81 100644
--- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
@@ -37,6 +37,8 @@ properties:
       - const: core
       - const: device
 
+  nand-rb: true
+
 patternProperties:
   "^nand@[0-7]$":
     type: object
@@ -81,6 +83,7 @@ examples:
 
       pinctrl-0 = <&nand_pins>;
       pinctrl-names = "default";
+      nand-rb = "true";
 
       #address-cells = <1>;
       #size-cells = <0>;
-- 
2.35.0

