Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7C060E0FF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbiJZMka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbiJZMjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:39:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1037252A3;
        Wed, 26 Oct 2022 05:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666787984; x=1698323984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bfVM3nGLETUDj1ZTk6wf3LU5jsbE9pu9ws8/QdyqYNg=;
  b=uYt8CDPADwrXAqAvCxbYSbd8OOekGTTO5uTG+8UT15mB8oL0BQqyM4sm
   IO1AG7N7m6pNAKeCJ89Zs4ktipvmqh8jkLPKHRYJJZ8TekBmILlx584L7
   3V52AR9dXmnEh5cAC4+jVit8VWVCC9u6DiikBPXCDjguOUDicSP0bg9Ty
   8T3ZudbFpgBnf+cZYAAst+x1DNKjsD8g+UbknLEQWYCxtTM7oUh4NTb4f
   A4+el83RlywmEpQ9t5O/enRA93nuWLuSCUmIpPUs8ejXiKc9QYKnICc0S
   Mcx2CIyrckuuCclcdH7od1DXs2SjWl1k6WgV59RBhr94onzonUUvY/vcx
   g==;
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="186355974"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Oct 2022 05:39:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 26 Oct 2022 05:39:31 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 26 Oct 2022 05:39:29 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux@armlinux.org.uk>, <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 11/11] ARM: dts: at91: sam9x60ek: remove status = "okay" for regulators
Date:   Wed, 26 Oct 2022 15:41:14 +0300
Message-ID: <20221026124114.985876-12-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221026124114.985876-1-claudiu.beznea@microchip.com>
References: <20221026124114.985876-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove status = "okay" for sam9x60ek regulator as okay is the default
status.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sam9x60ek.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
index 4ba52ba11dc6..d929c1ba5789 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -76,7 +76,6 @@ vdd_1v8: fixed-regulator-vdd_1v8 {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		regulator-always-on;
-		status = "okay";
 	};
 
 	vdd_1v15: fixed-regulator-vdd_1v15 {
@@ -85,7 +84,6 @@ vdd_1v15: fixed-regulator-vdd_1v15 {
 		regulator-min-microvolt = <1150000>;
 		regulator-max-microvolt = <1150000>;
 		regulator-always-on;
-		status = "okay";
 	};
 
 	vdd1_3v3: fixed-regulator-vdd1_3v3 {
@@ -94,7 +92,6 @@ vdd1_3v3: fixed-regulator-vdd1_3v3 {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
-		status = "okay";
 	};
 
 	vdd2_3v3: regulator-fixed-vdd2_3v3 {
@@ -103,7 +100,6 @@ vdd2_3v3: regulator-fixed-vdd2_3v3 {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
-		status = "okay";
 	};
 };
 
-- 
2.34.1

