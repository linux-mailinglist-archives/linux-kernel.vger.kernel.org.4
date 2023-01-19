Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4B66736D6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjASL3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjASL30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:29:26 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536A274967;
        Thu, 19 Jan 2023 03:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674127754; x=1705663754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1g0b3K27ODV8mWb+vk+Wg3fKm7I/wms8Et9Amh8ls0g=;
  b=nuRqAmY/s7CqVPqR/tg9O523bDh4jt/VFPGedN7pwewq87J+OUU5CPmZ
   HM+xACMkcU6MQXX0OzB83fIMSVyAjBkGXqD3Nf2eWJR/axDGxBMXc2XcC
   uT5crz15T8bU/fO98IeocGz6L6zOalIx6VtP+7+vj9xVMU+zP7mBgj2SX
   ffpkF45OGFyUexyvifpk+CeWVIIANVeMWZcPbi+f+17Qn8Lj4k1W0tEoH
   E9SS8fBiD3NBHY9XF2v7zSs0A36Z03GxRjO3FCjawk7631rZ54hZWnhbG
   3tteIjie8zwFY9fYuXpwVUBRhtCZwY5fehEeXsj1f5KoEGfp/rkqFKFJq
   w==;
X-IronPort-AV: E=Sophos;i="5.97,229,1669100400"; 
   d="scan'208";a="197282266"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jan 2023 04:29:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 04:29:12 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Thu, 19 Jan 2023 04:29:09 -0700
From:   shravan kumar <shravan.chippa@microchip.com>
To:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "shravan kumar" <shravan.chippa@microchip.com>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH v10 4/5] dt-bindings: media: i2c: imx334 add new link_freq
Date:   Thu, 19 Jan 2023 16:58:47 +0530
Message-ID: <20230119112848.3523273-5-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230119112848.3523273-1-shravan.chippa@microchip.com>
References: <20230119112848.3523273-1-shravan.chippa@microchip.com>
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

add new supported link frequency in dt example

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

