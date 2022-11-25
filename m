Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E45B63835D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 06:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKYFIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 00:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKYFIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 00:08:30 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E8E28E35;
        Thu, 24 Nov 2022 21:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669352908; x=1700888908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V1OMSs+r2Vdaq4EgRP9UUqO3OShybYjzPFVxY3dHlKs=;
  b=Bnv02nNpyF8pY6pZ7cvb01gWcqVMd7IfFtAEAF91+Fwq/J0Zz9poEs0W
   on52ZdYqhiFx8qM+LFgJl+YXl4rD0CqtqlNSt+S5JuxbUmaVVAogVby1I
   4NPLckF+kQi1M1A0+nzaFx+41J7ARAL7bElEfe5gScyR3+seATEI9l+r0
   L+0kHn+gyaS1nCKdvVQI0YkwTrqfk2CbbisP5msvVHdsEhDHx1ENX5+Uh
   oaA+dkbDsCXI4Wr3Yfln+vF2odSGVmHDViKVxAllZ3tgCtvIM5unM7xkQ
   yf/GR1u/l73ppGhDdnqV4jy2WcsFh4Lj3is/Etw2sOyNfefOUGPWeInip
   g==;
X-IronPort-AV: E=Sophos;i="5.96,192,1665471600"; 
   d="scan'208";a="125044667"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Nov 2022 22:08:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 24 Nov 2022 22:08:27 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 24 Nov 2022 22:08:25 -0700
From:   shravan kumar <shravan.chippa@microchip.com>
To:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Shravan Chippa" <shravan.chippa@microchip.com>
Subject: [PATCH v5 1/6] dt-bindings: imx334: modify link frequency in examples
Date:   Fri, 25 Nov 2022 10:38:02 +0530
Message-ID: <20221125050807.1857479-2-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221125050807.1857479-1-shravan.chippa@microchip.com>
References: <20221125050807.1857479-1-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shravan Chippa <shravan.chippa@microchip.com>

-imx334 sensor is configured to 1782Mbps/lane for 3840x2160@60.
-But in device tree bindings exapmple we are passing 891Mbps/lane
so modified to 1782Mbps

Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
---
 Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml
index f5055b9db693..ea3c93f97d65 100644
--- a/Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml
@@ -82,7 +82,7 @@ examples:
                 imx334: endpoint {
                     remote-endpoint = <&cam>;
                     data-lanes = <1 2 3 4>;
-                    link-frequencies = /bits/ 64 <891000000>;
+                    link-frequencies = /bits/ 64 <1782000000>;
                 };
             };
         };
-- 
2.34.1

