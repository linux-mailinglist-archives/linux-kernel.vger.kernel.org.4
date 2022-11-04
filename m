Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA9B619DB7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiKDQsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiKDQrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:47:46 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647BA40472;
        Fri,  4 Nov 2022 09:47:35 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9FFE84000E;
        Fri,  4 Nov 2022 16:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667580454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mfySvTw9F2sJ/4rPEiimBhliYhZWKXtJT7ol/a3yWK0=;
        b=BAwtPBJzb+XlqqpzqieVXHyZ3DejlH1PGnv/FsZyapr/V2YWOZGiYPcv+6xIEzpLbVjw/c
        fUyGzoqcJOQox8RZGEOSZ2zD3W51FvanYVppRulSmoXultO3xknnTd/N+GPCe60NEUl2gD
        yVMl+O6I/m5rWYz0DRHjv91tN67ZaaMgfReGqNYgeNnrhdF3ebkguBt3om0so6+f/E+6dW
        ig1moSkpc7vgCrgVbkJjfOxRwmwwKb8KuaTO4fG57mRlhpvkbIDA+ggpL8GbAKr/OM5wZF
        Tl5kiid47R8wu7G2EFkgyVjrU9Oc3JeAKIcjk6UynWKN/+DPVCmGfJmN94Zxkg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 13/17] dt-bindings: mtd: nvmem-cells: Fix example
Date:   Fri,  4 Nov 2022 17:47:14 +0100
Message-Id: <20221104164718.1290859-14-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104164718.1290859-1-miquel.raynal@bootlin.com>
References: <20221104164718.1290859-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no such thing as a "ranges" property within an nvmem-cells
node. There is no use of it, it is anyway not pictured anywhere that
this is valid, so drop it from the example.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../devicetree/bindings/mtd/partitions/nvmem-cells.yaml          | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
index 5cdd2efa9132..ca18892eacc7 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
@@ -84,7 +84,6 @@ examples:
             compatible = "nvmem-cells";
             label = "calibration";
             reg = <0xf00000 0x100000>;
-            ranges = <0 0xf00000 0x100000>;
             #address-cells = <1>;
             #size-cells = <1>;
 
-- 
2.34.1

