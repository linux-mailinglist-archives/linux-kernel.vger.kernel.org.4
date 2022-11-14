Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0806627887
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbiKNJEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbiKNJDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:03:40 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B49013E0D;
        Mon, 14 Nov 2022 01:03:36 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 00B5BFF814;
        Mon, 14 Nov 2022 09:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668416615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=abWxBYqdkWoQQQ3GX9Ts6R6Hk4Vd1Cu/4zxI2EIxg38=;
        b=Vx8uXQPeIudcKPHv0cv4vSdQKXGtNvXUAKz2bssWEm7L8914U7EQ3bSdC08XNv/m1t864m
        7Q3WyMg2Nxxt2MonG7/VEewHlzRAle+KnJtXc1TbAz0/h0SQB4s1jGf9T8zvC2HXWYTJUX
        rPO6Q2SkF4deIHBhvUIPxDaYEx5DgKBWhaUpbG5sok6S4nCD5FQUSZW34kXqJo7/CjG35h
        pA7IAjVc2pd8inw8POVZw5Hx5GGZbhTIarPrHDFR+BHbaamtdcEGNT63dnp0pQzC9rgNrZ
        jcXN94kxIBb1rdNGE4z5mkVOM8waFtBIKW+liCcHLgIIX3kef1fs8TIAB+lkuQ==
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
Subject: [PATCH v3 06/17] dt-bindings: mtd: ingenic: Mark partitions in the controller node as deprecated
Date:   Mon, 14 Nov 2022 10:03:04 +0100
Message-Id: <20221114090315.848208-7-miquel.raynal@bootlin.com>
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

Defining partitions as subnodes of the controller has been deprecated
long time ago, but unlike having partitions within the controller node,
having an enveloppe named "partitions" (which is not itself within a
chip subnode) is not that common, so keep this deprecated definition in
this file.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mtd/ingenic,nand.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml b/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml
index 87b2944d0d1b..90dbc5eba1e7 100644
--- a/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml
@@ -32,6 +32,7 @@ properties:
 
   partitions:
     type: object
+    deprecated: true
     description:
       Node containing description of fixed partitions.
 
-- 
2.34.1

