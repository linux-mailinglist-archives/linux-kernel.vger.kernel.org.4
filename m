Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3779B619DB1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbiKDQsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiKDQro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:47:44 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE88C40468;
        Fri,  4 Nov 2022 09:47:34 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8EF324000A;
        Fri,  4 Nov 2022 16:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667580453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Az+vA24nx4uvmv1Sczda31bkwb6yQkjFSBWEcaTheT0=;
        b=ChQj65BOvZTCxBNYdAezFTY653MJ7ia/ynKE/exoiU1+ta/nj9vOU47PweC4brOYyobd2Q
        QSL7o/J6vNEgkyS97jmPqVaPZTsCdf3HJ7Enm/QCbX27+wTUBvCMdiymxCyHlWd3sAUYJC
        07ZSrzuLaNJpX7hMftY2WlwzroIVXx5RFnlPiW/0xdM+Qu4o2i0bYBPg+8eBTm782NLtHc
        13Atqdm9kmT+kRCHWJLlLhcAFHDS50TdCNF4crWB39lnoLc1yf3pXOYlNvXvBU7occfnN/
        Exbgr+IN8mhycDdx0mKf6zW4KUHpgxQoTmo67SCNY6QS7xG+z9urJ4o1kNdKww==
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
Subject: [PATCH v2 12/17] dt-bindings: mtd: partitions: Change qcom,smem-part partition type
Date:   Fri,  4 Nov 2022 17:47:13 +0100
Message-Id: <20221104164718.1290859-13-miquel.raynal@bootlin.com>
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

As described in dd638202dfb6 ("dt-bindings: mtd: partitions: add additional
example for qcom,smem-part"), the aim of documenting the subnodes was to be
able to declare nvmem cells. Hence, the partition property does not
really apply directly here, let's instead reference nvmem-cells.yaml
first.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
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

