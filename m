Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C007F5E617C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiIVLnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiIVLmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:42:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51200E3EF7;
        Thu, 22 Sep 2022 04:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663846957; x=1695382957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kGhsNAF7SHuI6FCgH5W1LFNeZtcvIUXBy/giqtdU+oE=;
  b=0fuyVS4+Whprt+v3Tf1xYpk+hQ3phmtMCMtw6O7Y0NXSKjIv/ccnLV1k
   S/86DRPPIcIqMHCtoy5e+y9yK161pNjSycwVJeNUMquaQsikv44e4KfjP
   bCWDLrSHpnta8zgKFNZEVz1s5c4iM0iseREup5otC5cv8doprTG3npj+/
   5dblqQGTOeyxOndlPA6T3EHKTQpltUIgzVp/y3fH9KNwb+fDNojFeqCS1
   aXIfVXFB6nzSGDjKjdkYKw49vbfCn1HHFSrYVnvXGjAQz0yCeqgqxu07m
   7sclVLvF2uJgFhVXAduNKNvvLgRXk1AguWG7PzyMIFKGin/jawUbhSsuS
   g==;
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="114897452"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Sep 2022 04:42:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 22 Sep 2022 04:42:35 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 22 Sep 2022 04:42:28 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <kavyasree.kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 3/9] dt-bindings: serial: atmel,at91-usart: Add SAM9260 compatibles to SAM9X60
Date:   Thu, 22 Sep 2022 14:33:41 +0300
Message-ID: <20220922113347.144383-4-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922113347.144383-1-sergiu.moga@microchip.com>
References: <20220922113347.144383-1-sergiu.moga@microchip.com>
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

Require SAM9260 fallback compatible for SAM9X60, because SAM9X60 is
fully compatible with SAM9260 and Linux driver requires the latter.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---



v1 -> v2:
- Nothing, this patch was not here before


v2 -> v3:
- Use the commit message suggested by Krzysztof Kozlowski



v3 -> v4:
- add A-b tag, this was previously [PATCH 7]



v4 -> v5:
- Nothing



 Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
index bb1b5ed431f7..4da642763bef 100644
--- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
+++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
@@ -26,6 +26,8 @@ properties:
       - items:
           - const: microchip,sam9x60-dbgu
           - const: microchip,sam9x60-usart
+          - const: atmel,at91sam9260-dbgu
+          - const: atmel,at91sam9260-usart
 
   reg:
     maxItems: 1
-- 
2.34.1

