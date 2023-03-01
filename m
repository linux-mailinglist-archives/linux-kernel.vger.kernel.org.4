Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B786A683B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 08:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCAHfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 02:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCAHfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:35:20 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE2C38021;
        Tue, 28 Feb 2023 23:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677656102; x=1709192102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fAj6J3f37Y66SAvoIaG966+1CCKAbDBv74KG41b5dj4=;
  b=Dxg4kI2+JbRd1VoBq9OEOrcGNqD3J4JDuGd0X6/PpyceMAJ+dpftTHX4
   AHLMdGLosZ+9aodeU2jtNJ+21zUgbGss4Ljq+o8O5Eetz/7kQk0HkO0zB
   rt6TZ/cQTSxJLvoyOBval2ONamKfvEVHbYEmUOBgrX4cJyZ/J1urmCqo+
   7mgZ5oMK7VcHhHvzcGRUVQrEGhe226R/sidWUENnV2mPwQ4kktx0CFBNG
   +TiQshgjk7u4lSrxUdHtV8V34hrLaeuin8tH2C3fU2GcVRz3u+Wvz6ntR
   opsI3YpyxZJb/kYe56tdsIA4H+LL48EbXecG104T55jhIlRGostKhSuNQ
   w==;
X-IronPort-AV: E=Sophos;i="5.98,224,1673938800"; 
   d="scan'208";a="202714059"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2023 00:35:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Mar 2023 00:35:00 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Wed, 1 Mar 2023 00:34:56 -0700
From:   shravan kumar <shravan.chippa@microchip.com>
To:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>
CC:     <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <shravan.chippa@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH v12 4/5] dt-bindings: media: i2c: imx334 add new link_freq
Date:   Wed, 1 Mar 2023 13:04:11 +0530
Message-ID: <20230301073412.1204574-5-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301073412.1204574-1-shravan.chippa@microchip.com>
References: <20230301073412.1204574-1-shravan.chippa@microchip.com>
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

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

