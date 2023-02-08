Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A92068E75B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 06:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjBHFKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 00:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjBHFKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 00:10:02 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838B442BE0;
        Tue,  7 Feb 2023 21:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675832994; x=1707368994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bvzL8yBXjkbs6PX1KeNsY7o8KthoIvKiuovYJNPFyVI=;
  b=hXsNUL5Vm55hJuXF6/PNwIbjku+kjcUJbszp+zXLYYVAVsK2d0A4WFpt
   Q6eyRHEGGaIRDvu7jdK6sLjNBwDwzTC2B0QPFiFW/7BLWsgbuB5d0RPPV
   WC+KxPM8M5uglgf/QGGu9L8dzs+3YhIDWHSmnANPaO8X/r8gTlwffJ+NW
   I/2DSyVKKibOdNoG5kYbSAILYYY17M4y2gdoxOyCMFQ3VPPAXiMHrvhhP
   IqPtzKFEKTSI0WkTpY//lvP7j3BCGaoYulPXAeObsboF8avlNiSEqzWnl
   6gUyNUOlJrGY0ftpOjjwiR8mJFbillgfgEYsGXiGsoprBw7W4O8qrfulq
   A==;
X-IronPort-AV: E=Sophos;i="5.97,280,1669100400"; 
   d="scan'208";a="200025004"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Feb 2023 22:09:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 22:09:51 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 22:09:47 -0700
From:   shravan kumar <shravan.chippa@microchip.com>
To:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>
CC:     <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <shravan.chippa@microchip.com>, Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH v11 4/5] dt-bindings: media: i2c: imx334 add new link_freq
Date:   Wed, 8 Feb 2023 10:39:14 +0530
Message-ID: <20230208050915.1958183-5-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230208050915.1958183-1-shravan.chippa@microchip.com>
References: <20230208050915.1958183-1-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shravan Chippa <shravan.chippa@microchip.com>

Add new supported link frequency in dt example.

Suggested-by: Sakari Ailus <sakari.ailus@iki.fi>
Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
---
 Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml
index f5055b9db693..09533496b20c 100644
--- a/Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml
@@ -82,7 +82,7 @@ examples:
                 imx334: endpoint {
                     remote-endpoint = <&cam>;
                     data-lanes = <1 2 3 4>;
-                    link-frequencies = /bits/ 64 <891000000>;
+                    link-frequencies = /bits/ 64 <891000000 445500000>;
                 };
             };
         };
-- 
2.34.1

