Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB76676374
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 04:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjAUDiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 22:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjAUDiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 22:38:14 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868F411EA9;
        Fri, 20 Jan 2023 19:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674272275; x=1705808275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bvzL8yBXjkbs6PX1KeNsY7o8KthoIvKiuovYJNPFyVI=;
  b=ZBn+2uK4VVfq5Ze+USU7ifvYtpjDx1Gl77+ATdR2L5KZcQzcVNdWWPi2
   9VJPFKnBaePuG21ghodszyfH9xBAt7aoQgWGmm2yahcVGEH2hGJf57T+L
   s/lLZ55L1xJyJGaeNhcIdK/kJiBAjrciKtiXmT6w2TUjZoakRRHzCBQ50
   kfgkjGXL6ryw1nrJwKxyhPbndB6RWa3BOEIvajlm8liFs3Of5tQI/9Xr7
   foV2U5MWQmlVbSixBj6Zs4SU//8mbBHGYDakZr5IUo6dC75bQvuwMGB2t
   oWf5AdAiandt8zsO1KPGbEwLOywoWzhUCWQYo0QK3Ah3si+F7iDVxz/rC
   A==;
X-IronPort-AV: E=Sophos;i="5.97,234,1669100400"; 
   d="scan'208";a="193243028"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2023 20:37:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 20:37:53 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Fri, 20 Jan 2023 20:37:48 -0700
From:   shravan kumar <shravan.chippa@microchip.com>
To:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>
CC:     <festevam@gmail.com>, <kernel@pengutronix.de>, <linux-imx@nxp.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <shravan.chippa@microchip.com>, Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH RESEND v10 4/5] dt-bindings: media: i2c: imx334 add new link_freq
Date:   Sat, 21 Jan 2023 09:07:12 +0530
Message-ID: <20230121033713.3535351-5-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230121033713.3535351-1-shravan.chippa@microchip.com>
References: <20230121033713.3535351-1-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
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

