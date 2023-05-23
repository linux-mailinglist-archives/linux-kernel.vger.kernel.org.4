Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9F470D328
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 07:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbjEWF2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 01:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjEWF2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 01:28:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7CF18D;
        Mon, 22 May 2023 22:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684819690; x=1716355690;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5FXK4mOZ1THnPXdkLFqXmtCdYmSHKGst6TFK3PBHyk0=;
  b=0qhbaULH6B22qGNx6DjoWUOTpfS+C1LP+PpzGv5GLcwG5EHKnwICTxDs
   KMaUkwIhPwi0nRG4CZVVpw8ly9tVIRQGU/75H5mTuj5x9jPYNpRmNyFLI
   sPQla7+t6OpMBC5sry4GJUONwcXPE2va7OsFHUrOGtPw1L8CcHjCgIID8
   GWSlcEZrspOKKzhxRylhBgGyzkqYxcDyUjNQYOdcWHL1Lz1UZ2LtxZWOe
   hpqWQ//9xNdFb6MbUMibJ3C1k09LHQlwqlzQQu/L6h3Ak8BBU7hwCMfXM
   ZVVuXui3/Y1QjIBk8eaOZBYtRjcFAnGd+mlJXl8rlpzDmJLUYAAgDB97u
   w==;
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="216780042"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 22:28:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 22:28:06 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 22 May 2023 22:28:04 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama7g5ek: fix debounce delay property for shdwc
Date:   Tue, 23 May 2023 08:27:50 +0300
Message-ID: <20230523052750.184223-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no atmel,shdwc-debouncer property for SHDWC. The right DT property
is debounce-delay-us. Use it.

Fixes: 16b161bcf5d4 ("ARM: dts: at91: sama7g5: add shdwc node")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama7g5ek.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
index aa5cc0e98bba..217e9b96c61e 100644
--- a/arch/arm/boot/dts/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
@@ -792,7 +792,7 @@ &sdmmc2 {
 };
 
 &shdwc {
-	atmel,shdwc-debouncer = <976>;
+	debounce-delay-us = <976>;
 	status = "okay";
 
 	input@0 {
-- 
2.34.1

