Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD236731427
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343526AbjFOJhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245756AbjFOJgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:36:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A102D5B;
        Thu, 15 Jun 2023 02:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686821753; x=1718357753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sgleBrWYZnvVYap3+gjn9OSksnZJfPCZWSf6l1DJU/I=;
  b=jZZehcwyeR1Fbm8Ybg+nqVBqRiYaa2msvBAJxlOOloyhpCa7vE6Wc/vB
   nCzmUjuc2GxNlVwPIRYjakwmSlzvKZGH5CWyu13uf5HM4n3y2o4Qq8Yv9
   jM7JdmF0srKCzO9BxCE2VznyrbKsxLUVPRcpxq3qgq6Ty9DhRzrQBcOx9
   itAgjOT3LNds+2DCTUEl8QnAew9VkteZnTwpJ3VlwxgryS1izK1+R8OsG
   0bNIHdz6JqAE6Ip4oAbsrVbbv+dY8zcoRGnyFC7SP9obb5XbIQbT4YMY2
   Fi6n37svVRwZqNBdxiDKO9nevM3Rllim7GhhkPk2fafP+FyDD2nZYFUmn
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="216166915"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2023 02:34:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 15 Jun 2023 02:34:37 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 15 Jun 2023 02:34:33 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <m.grzeschik@pengutronix.de>, <maxime@cerno.tech>, <windhl@126.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 11/11] clk: at91: sama7g5: s/ep_chg_chg_id/ep_chg_id
Date:   Thu, 15 Jun 2023 12:32:27 +0300
Message-ID: <20230615093227.576102-12-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230615093227.576102-1-claudiu.beznea@microchip.com>
References: <20230615093227.576102-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/ep_chg_chg_id/ep_chg_id in documentation of master clock structure.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sama7g5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 7e06ea22c8af..91b5c6f14819 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -354,10 +354,10 @@ static struct sama7g5_pll {
 /*
  * Master clock (MCK[1..4]) description
  * @n:			clock name
- * @ep_chg_chg_id:	index in parents array that specifies the changeable
  * @ep:			extra parents names array (entry formed by PLL components
  *			identifiers (see enum pll_component_id))
  * @hw:			pointer to clk_hw
+ * @ep_chg_id:		index in parents array that specifies the changeable
  *			parent
  * @ep_count:		extra parents count
  * @ep_mux_table:	mux table for extra parents
-- 
2.34.1

