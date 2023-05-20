Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CED70A8F7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 18:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjETQH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 12:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjETQH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 12:07:26 -0400
Received: from smtp.missinglinkelectronics.com (smtp.missinglinkelectronics.com [162.55.135.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D60E10F
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 09:07:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp.missinglinkelectronics.com (Postfix) with ESMTP id CD78D2021B;
        Sat, 20 May 2023 18:07:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at missinglinkelectronics.com
Received: from smtp.missinglinkelectronics.com ([127.0.0.1])
        by localhost (mail.missinglinkelectronics.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FyagOLw2-zEF; Sat, 20 May 2023 18:07:23 +0200 (CEST)
Received: from humpen-bionic2.mle (p578c5bfe.dip0.t-ipconnect.de [87.140.91.254])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: david)
        by smtp.missinglinkelectronics.com (Postfix) with ESMTPSA id 21629205F3;
        Sat, 20 May 2023 18:07:23 +0200 (CEST)
From:   David Epping <david.epping@missinglinkelectronics.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        David Epping <david.epping@missinglinkelectronics.com>
Subject: [PATCH net 1/3] net: phy: mscc: add VSC8502 to MODULE_DEVICE_TABLE
Date:   Sat, 20 May 2023 18:06:01 +0200
Message-Id: <20230520160603.32458-2-david.epping@missinglinkelectronics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230520160603.32458-1-david.epping@missinglinkelectronics.com>
References: <20230520160603.32458-1-david.epping@missinglinkelectronics.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mscc driver implements support for VSC8502, so its ID should be in
the MODULE_DEVICE_TABLE for automatic loading.

Signed-off-by: David Epping <david.epping@missinglinkelectronics.com>
---
 drivers/net/phy/mscc/mscc_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 62bf99e45af1..bd81a4b041e5 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -2656,6 +2656,7 @@ static struct phy_driver vsc85xx_driver[] = {
 module_phy_driver(vsc85xx_driver);
 
 static struct mdio_device_id __maybe_unused vsc85xx_tbl[] = {
+	{ PHY_ID_VSC8502, 0xfffffff0, },
 	{ PHY_ID_VSC8504, 0xfffffff0, },
 	{ PHY_ID_VSC8514, 0xfffffff0, },
 	{ PHY_ID_VSC8530, 0xfffffff0, },
-- 
2.17.1

