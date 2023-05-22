Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C5F70BBE0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjEVLc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjEVLct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:32:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BAF8E;
        Mon, 22 May 2023 04:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684755156; x=1716291156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p1YzrIY2xM8tw0Xs6tuE2UXhuLXSFNV7QfVqo2c4pbc=;
  b=vB/u7qeoxeRZJu+QL98kMrwFLlQ3oQ68ezd2TeY5snQ0MGpLvMd8pS2S
   /8YreqT6KrldRKPAzY9sAvUGYTyYLk4tHFoeUfFRba1FCCtMiAoE5Q2en
   XHQdqDwwpL5pkKrvOYDoxOQxhUqyzRLdx5gTM/8y1av3/cS6Pv4sAUbx1
   MYKltPe4pwpVegfhPBRLwngjj2KMH6YbAfeCIGWW7z0W1mP65LspGVZgk
   HyAJ8xuMc72l2qI7MiYdxW5EyPGbbzkpirX6OPM713RVUt9r3piwW50Tj
   yXIGqXaWxW0GLY1xIVmBC+5Gsj8t0i514UARMnIF/nrzacxkwIHPUey5C
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="216630564"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 04:32:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 04:32:33 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 22 May 2023 04:32:28 -0700
From:   Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <ramon.nordin.rodriguez@ferroamp.se>
CC:     <horatiu.vultur@microchip.com>, <Woojung.Huh@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
        "Parthiban Veerasooran" <Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v2 1/6] net: phy: microchip_t1s: modify driver description to be more generic
Date:   Mon, 22 May 2023 17:03:26 +0530
Message-ID: <20230522113331.36872-2-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522113331.36872-1-Parthiban.Veerasooran@microchip.com>
References: <20230522113331.36872-1-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove LAN867X from the driver description as this driver is common for
all the Microchip 10BASE-T1S PHYs.

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 094967b3c111..a42a6bb6e3bd 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Driver for Microchip 10BASE-T1S LAN867X PHY
+ * Driver for Microchip 10BASE-T1S PHYs
  *
  * Support: Microchip Phys:
  *  lan8670, lan8671, lan8672
@@ -111,7 +111,7 @@ static int lan867x_read_status(struct phy_device *phydev)
 	return 0;
 }
 
-static struct phy_driver lan867x_driver[] = {
+static struct phy_driver microchip_t1s_driver[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_LAN867X),
 		.name               = "LAN867X",
@@ -124,7 +124,7 @@ static struct phy_driver lan867x_driver[] = {
 	}
 };
 
-module_phy_driver(lan867x_driver);
+module_phy_driver(microchip_t1s_driver);
 
 static struct mdio_device_id __maybe_unused tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN867X) },
@@ -133,6 +133,6 @@ static struct mdio_device_id __maybe_unused tbl[] = {
 
 MODULE_DEVICE_TABLE(mdio, tbl);
 
-MODULE_DESCRIPTION("Microchip 10BASE-T1S lan867x Phy driver");
+MODULE_DESCRIPTION("Microchip 10BASE-T1S PHYs driver");
 MODULE_AUTHOR("Ramón Nordin Rodriguez");
 MODULE_LICENSE("GPL");
-- 
2.34.1

