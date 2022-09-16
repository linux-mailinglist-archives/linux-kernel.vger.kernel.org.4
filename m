Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F8D5BA7CF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiIPIID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 04:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiIPIHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:07:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4CE125;
        Fri, 16 Sep 2022 01:07:48 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9D9F66601FC1;
        Fri, 16 Sep 2022 09:07:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663315667;
        bh=HFcAB00gt8eqAsTyYnphTAU0Ql6q+1sXsjawCNEH/cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQcI5hG/nEoQDQevj8Y1rHXNHaD4uZGtExTXcKqpZ1khpvRMdAKrJzTzFruIcUk54
         2Umh/sxQsePr+ir29y3hsVazhmlYWSmBK8rYZby0hKEXB/If1t/N6PU2f+z7zIioM8
         6BrPKnxVTNA4vj5pzcHHv62beDkhqZLYuJpVB6Fot7KRHXQ2BLR0xJhsTQgrYWOtV7
         von0kL+S3tpHBIjr8AN7OSaQitbUdHNngdF3tY+1BTHa/iJ0CuvOEJTBJKSnaSsull
         /PjfnKxx+ZW/l+nrty9/dSppOIr9ghTbzTAbWJFy/+2U//RhEYdyVM7FJ4mFTz2l2u
         GFi+a3fuRXeeQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     jassisinghbrar@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, houlong.wei@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 2/2] dt-bindings: arm: mediatek: mmsys: Reference to mediatek,gce-mailbox.yaml
Date:   Fri, 16 Sep 2022 10:07:42 +0200
Message-Id: <20220916080742.26851-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220916080742.26851-1-angelogioacchino.delregno@collabora.com>
References: <20220916080742.26851-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GCE mailbox documentation was converted to DT schema: replace
mtk-gce.txt references to mediatek,gce-mailbox.yaml

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml       | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
index 6ad023eec193..85e6f4f621fc 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
@@ -52,7 +52,8 @@ properties:
     description:
       Using mailbox to communicate with GCE, it should have this
       property and list of phandle, mailbox specifiers. See
-      Documentation/devicetree/bindings/mailbox/mtk-gce.txt for details.
+      Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
+      for details.
     $ref: /schemas/types.yaml#/definitions/phandle-array
 
   mediatek,gce-client-reg:
-- 
2.37.2

