Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FA962AF28
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 00:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiKOXK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 18:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238570AbiKOXKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 18:10:40 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B9F2E680;
        Tue, 15 Nov 2022 15:10:38 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AFNAMUf026650;
        Tue, 15 Nov 2022 17:10:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668553822;
        bh=gtf+eQVCKgSWi792JEHOnuPGmozhEm9qEIoe9H4zdgg=;
        h=From:To:CC:Subject:Date;
        b=jPOIf5AiID8XwK+J8AuyetpqXxWKUGmBI60zIdnA5pUEQuUDX1GraE7PofICp5cpl
         2GTScVC8OVpS0cM89NgCFLNXP2zI0koT5k5qAN7+n6tBvDvm9q1so80pz4IdpYD1Ys
         xeWV5K2St+L8tN+Peeql1IJJxlxUexN+MQD7sZ5w=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AFNAMej019020
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Nov 2022 17:10:22 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 15
 Nov 2022 17:10:22 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 15 Nov 2022 17:10:22 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AFNAMhV115002;
        Tue, 15 Nov 2022 17:10:22 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Keerthy <j-keerthy@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH] dt-bindings: gpio: gpio-davinci: Increase maxItems in gpio-line-names
Date:   Tue, 15 Nov 2022 17:10:21 -0600
Message-ID: <20221115231021.2389-1-nm@ti.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpio-line-names really depends on ti,ngpios. However, the maximum value
we have seen across the board is on K2G and da850 platforms where it can
be upto 144.

Link: https://lore.kernel.org/linux-arm-kernel/20221115200357.qa2rvw3clbz7unzq@symptom/T/#u
Fixes: c830b87a761b ("dt-bindings: gpio: gpio-davinci: Convert to json-schema")
Reported-by: Robert Nelson <robertcnelson@gmail.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

I dont see a practical scheme to set the maxItems based on ti,ngpios,
but deleting the maxItems was softening the check as well.

 Documentation/devicetree/bindings/gpio/gpio-davinci.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-davinci.yaml b/Documentation/devicetree/bindings/gpio/gpio-davinci.yaml
index f32e09ef937c..10e56cf306db 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-davinci.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-davinci.yaml
@@ -35,7 +35,7 @@ properties:
   gpio-line-names:
     description: strings describing the names of each gpio line.
     minItems: 1
-    maxItems: 100
+    maxItems: 144
 
   "#gpio-cells":
     const: 2
-- 
2.31.1

