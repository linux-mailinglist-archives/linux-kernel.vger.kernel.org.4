Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1509062788C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbiKNJEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236783AbiKNJDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:03:45 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB371D0E0;
        Mon, 14 Nov 2022 01:03:44 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B2FD0FF805;
        Mon, 14 Nov 2022 09:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668416623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMd5yQHc0mg7inpTTSKlKhmW8IystLlC3mwO9N5nbf0=;
        b=ZUOFFzlahY/6zR8pZGIcGDlVQIV1XA+HsAoAWglps0ariGqxA2mYrg+w6at9ptJfOTq7gZ
        fXMmPHOnKlr+DZVvtUjbOv/X5i9aSRVwkTpaGjl2Z1bUrCgY/q/5wY3IukIxKFz5H7MViQ
        CupDkGaueHDRxqSLJM7bTIO35KfeRmSqJNBI7SBnmM4dETRj9ZAhdOEDnGbIP+wNnvRNWd
        16qXoCZdH3PS9MU2jBBe175a7e/HfFvU6VlquHcrZor6HSLfs2cajaqSm3Y5pAFY4Ixxf3
        gmrVWp5KjjG/GW2q5VGS9SAdYxirwmErogfunhcOLHlTQC7qZqlZYNcDmyk7og==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 09/17] dt-bindings: mtd: spi-nor: Drop common properties
Date:   Mon, 14 Nov 2022 10:03:07 +0100
Message-Id: <20221114090315.848208-10-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114090315.848208-1-miquel.raynal@bootlin.com>
References: <20221114090315.848208-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When redefining common properties does not bring any additional
information, just drop them from the SPI-NOR bindings because these
properties already are definied in mtd.yaml.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mtd/jedec,spi-nor.yaml     | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 7149784a36ac..6cc491083650 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -70,20 +70,6 @@ properties:
       be used on such systems, to denote the absence of a reliable reset
       mechanism.
 
-  partitions:
-    type: object
-
-  '#address-cells': true
-  '#size-cells': true
-
-patternProperties:
-  # Note: use 'partitions' node for new users
-  '^partition@':
-    type: object
-
-  "^otp(-[0-9]+)?$":
-    type: object
-
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

