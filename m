Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A25B628378
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbiKNPEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbiKNPEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:04:48 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8116E1A832;
        Mon, 14 Nov 2022 07:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668438287; x=1699974287;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+/Tp5mnL13FbLRXuixpZuYpTtoYMT9wshvc4aS25Gvc=;
  b=W6sjpurUbdWalH/TvMevEaqFGHR0pCFzo4g6PO3HInAovPNuNVEjb0yW
   RkGmXvfMx1pNkiAl5yyKHzHom7wrE4bs9e3l7JNDxOTVhXNHHrx/H2VLm
   9kXRdXpnN39ILoFVzCPJh+kN4v77mS+8L2mkfN9ua9OMQ07gxS5lWaLv4
   6iAVv9HgahHtUOkbpfH8O5frGlt2g5mbcLNpB866ieIwcbdHlY6hf7C7B
   KgQktsxP3jtVVKM1jd1+de0Bfsvf2EeFqpaiqXhQBYihBu9RKZHcDYfeT
   yyGBSZNNSWeooMzeM3bQ334mr8MzZf1xGpoNhG0vmYwoQZrkLjh7KoI1s
   w==;
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="186870983"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Nov 2022 08:04:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 14 Nov 2022 08:04:33 -0700
Received: from virtualbox.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 14 Nov 2022 08:04:31 -0700
From:   Mihai Sain <mihai.sain@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <claudiu.beznea@microchip.com>, <eugen.hristev@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama7g5: fix signal name of pin PD8
Date:   Mon, 14 Nov 2022 17:04:13 +0200
Message-ID: <20221114150413.2795-1-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.38.1
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

The signal name of pin PD8 with function D is A22_NANDCLE
as it is defined in the datasheet.

Fixes: 7540629e2fc7 ("ARM: dts: at91: add sama7g5 SoC DT and sama7g5-ek")
Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/sama7g5-pinfunc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama7g5-pinfunc.h b/arch/arm/boot/dts/sama7g5-pinfunc.h
index 6e87f0d4b8fc..a67a156e26ab 100644
--- a/arch/arm/boot/dts/sama7g5-pinfunc.h
+++ b/arch/arm/boot/dts/sama7g5-pinfunc.h
@@ -673,7 +673,7 @@
 #define PIN_PD8__GPIO			PINMUX_PIN(PIN_PD8, 0, 0)
 #define PIN_PD8__SDMMC2_DAT3		PINMUX_PIN(PIN_PD8, 1, 1)
 #define PIN_PD8__I2SMCC0_DIN0		PINMUX_PIN(PIN_PD8, 3, 1)
-#define PIN_PD8__A11_NANDCLE		PINMUX_PIN(PIN_PD8, 4, 2)
+#define PIN_PD8__A22_NANDCLE		PINMUX_PIN(PIN_PD8, 4, 2)
 #define PIN_PD8__TIOA2			PINMUX_PIN(PIN_PD8, 5, 2)
 #define PIN_PD8__FLEXCOM11_IO0		PINMUX_PIN(PIN_PD8, 6, 5)
 #define PIN_PD9				105
-- 
2.38.1

