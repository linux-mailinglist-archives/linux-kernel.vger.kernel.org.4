Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442BA62789B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbiKNJFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236783AbiKNJEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:04:33 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC071DDE8;
        Mon, 14 Nov 2022 01:04:00 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E3ABAFF815;
        Mon, 14 Nov 2022 09:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668416639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p+yDyoG2qKYEY8YhhZqOq33UNeQMIcC6DN9z91vnmHU=;
        b=LQh96YYntByQyxcKe0JCkWkS0OBc9b4DSahCT3qaQVd4HHXBCF5JEigiffOB1NdU7CKNQE
        B2KsJZGfIfN64kE6pRicJdFc80adinWRe8rA9qOvcgb5BIN5zpmzCln1CPOPwlHTfx8ftN
        lhpTbjbNfTD/FbbIzjM5I7IFnFfEyfKpcpFhqeB6acxVAoZVpkKnUV8hvWchYdk/XPrTzV
        +Lz1vNcZN64sRFDknCQwl6u/L465ERep2a4NU4RHTffkMh7JSb6bPX9tf4rDy9gm9Uqm9L
        YdAlmnMpSSS8PINpLmw31Kuv22Pi7+4qVpHsfVdiK/m0MUDRkoMwPvefKiY9QA==
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
Subject: [PATCH v3 16/17] dt-bindings: mtd: Drop object types when referencing other files
Date:   Mon, 14 Nov 2022 10:03:14 +0100
Message-Id: <20221114090315.848208-17-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114090315.848208-1-miquel.raynal@bootlin.com>
References: <20221114090315.848208-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting an object type is redundant when a reference is made, so drop
these useless lines.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mtd/mtd.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documentation/devicetree/bindings/mtd/mtd.yaml
index 9ee285b7d162..78da129e9985 100644
--- a/Documentation/devicetree/bindings/mtd/mtd.yaml
+++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
@@ -43,7 +43,6 @@ patternProperties:
     deprecated: true
 
   "^otp(-[0-9]+)?$":
-    type: object
     $ref: ../nvmem/nvmem.yaml#
 
     description: |
-- 
2.34.1

