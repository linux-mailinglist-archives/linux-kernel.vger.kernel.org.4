Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78AB627892
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbiKNJEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbiKNJEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:04:01 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0633F1D326;
        Mon, 14 Nov 2022 01:03:51 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0E817FF80F;
        Mon, 14 Nov 2022 09:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668416630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2GMVpmkxCSCyo/tEv6D1Xa5VBGNeC8i1WPJ1iBZRltY=;
        b=fJzsUhhuFC8MDsP1W6vRcOz32ei8ILzqx3jUaDhmxIqqJurD1F8wSskxWssyT8/B3Jszxi
        RwRJIdI/ZYCFS+vowb7zVZJS9hGnQRQLzY7nmRYq/79dwWjYcEsCTFvav75Jk+yI7ya/jP
        7Nxkc1rCW8o8SiW+gnrB3EfYlppGN6BpMrriT47vx33hM6erfQV7d8N3hpOqHpuO5NQyuN
        jAhR7V3V9gwRABkFwnJ1/hdmTyCHvqgtTzYB+LUHWh4sEAOiasYuXKfTn3LJph9bX3Ktjo
        EtvCnn5oAhFNEiYCZbIXwVAKm4nP/e+e59ux5YnbhoYnDL+CHVNAK48O1B5S9g==
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
Subject: [PATCH v3 12/17] dt-bindings: mtd: partitions: Change qcom,smem-part partition type
Date:   Mon, 14 Nov 2022 10:03:10 +0100
Message-Id: <20221114090315.848208-13-miquel.raynal@bootlin.com>
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

As described in dd638202dfb6 ("dt-bindings: mtd: partitions: add additional
example for qcom,smem-part"), the aim of documenting the subnodes was to be
able to declare nvmem cells. Hence, the partition property does not
really apply directly here, let's instead reference nvmem-cells.yaml
first.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mtd/partitions/qcom,smem-part.yaml      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml b/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
index 805eabece7c8..681a51f5257c 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
@@ -23,7 +23,7 @@ properties:
 
 patternProperties:
   "^partition-[0-9a-z]+$":
-    $ref: partition.yaml#
+    $ref: nvmem-cells.yaml
 
 required:
   - compatible
-- 
2.34.1

