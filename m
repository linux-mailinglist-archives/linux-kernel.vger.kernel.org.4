Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A95627883
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbiKNJEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbiKNJDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:03:37 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD5938AF;
        Mon, 14 Nov 2022 01:03:28 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E1669FF809;
        Mon, 14 Nov 2022 09:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668416606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Y3Ilf0k1Zb565CDODTPYfsRYtki95YJmPfK8ZRRt10=;
        b=U5weO7ep3Ye7minqImiXDZllYYNsMWXY4DLWkB4nhJMCeQqZoElaOHaHYcvxN5QPLtxbid
        pQmuUpD18pj6+/GqBS9rBAeb4xVM1eOo1WFfCyduOnVskQy4Ok1MMfGcaYtRW5mttK2OoA
        pC/w9tJq6mHpS81V28oBmN4Hh78a75QzpDSVQ4tfo8CLD1b+JZ0aXzz0YBpA8WJfd0d1gq
        nKETdlV7TG6ZlSBDZCPQpZqQ5VJ9qfMbqTOgbGF/CKLRMdmHmL/ZfCmTjzGd87GaZ7i4Wt
        VBnr6ARRELUaIg6bbhNp1zVNgrw1U1DhlhI4qLK0lNhf66X6bH6RFdHheUE+Hg==
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
Subject: [PATCH v3 03/17] dt-bindings: mtd: nand-chip: Reference mtd.yaml
Date:   Mon, 14 Nov 2022 10:03:01 +0100
Message-Id: <20221114090315.848208-4-miquel.raynal@bootlin.com>
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

A NAND chip is an MTD device. mtd.yaml already defines many useful and
relevant properties, let's reference this file here to get access to
these additional property definitions.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mtd/nand-chip.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/nand-chip.yaml b/Documentation/devicetree/bindings/mtd/nand-chip.yaml
index 97ac3a3fbb52..8d5d2d3ef56b 100644
--- a/Documentation/devicetree/bindings/mtd/nand-chip.yaml
+++ b/Documentation/devicetree/bindings/mtd/nand-chip.yaml
@@ -9,6 +9,9 @@ title: NAND Chip and NAND Controller Generic Binding
 maintainers:
   - Miquel Raynal <miquel.raynal@bootlin.com>
 
+allOf:
+  - $ref: "mtd.yaml#"
+
 description: |
   This file covers the generic description of a NAND chip. It implies that the
   bus interface should not be taken into account: both raw NAND devices and
-- 
2.34.1

