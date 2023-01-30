Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8153E680D26
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbjA3MKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbjA3MJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:09:38 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352CF3754C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675080537; x=1706616537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wy5L39BFMKrQQvzhCUrefjNpUTQMmUcvw5a7H2/NVdQ=;
  b=x909uhqiKqPic92b2feI3vmeHZ/dNUsrcyjJ67kzf4wW2aFFkr/Yf+D9
   agmmeRCN88sBt6PWWkCgbKYuDtM+RCFTLEVClY6pPNOW8UR4QoVwCfD4n
   /XxFVeM26beKSfrKXboKvPPzRkiHeiEY1kH1Z1gtzWDwLuEUuJg+uCmXt
   EH/jQoCmPWq/LsQXtE+WHw9yP1qSUDAhw79rSGdFM7SDzN2wT8x7s+Mba
   IdqKo14XFfGdSetcAeMbIuCKaKotzoGJb3LzX6q/DXXAThNwzg31lKTcf
   oVCciVWgXzj/tXtMo0+VnWK73cWM+sPoH818yIEtoJo3XWRpRGO053EZW
   g==;
X-IronPort-AV: E=Sophos;i="5.97,257,1669100400"; 
   d="scan'208";a="134605337"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jan 2023 05:07:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 05:07:45 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 05:07:41 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 6/8] ASoC: mchp-spdifrx: remove struct mchp_spdifrx_dev::fmt member
Date:   Mon, 30 Jan 2023 14:06:45 +0200
Message-ID: <20230130120647.638049-7-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230130120647.638049-1-claudiu.beznea@microchip.com>
References: <20230130120647.638049-1-claudiu.beznea@microchip.com>
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

Remove member fmt of struct mchp_spdifrx_dev as it is not used anywhere.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-spdifrx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/atmel/mchp-spdifrx.c b/sound/soc/atmel/mchp-spdifrx.c
index 90b2fb3a9844..46fff31321f3 100644
--- a/sound/soc/atmel/mchp-spdifrx.c
+++ b/sound/soc/atmel/mchp-spdifrx.c
@@ -235,7 +235,6 @@ struct mchp_spdifrx_dev {
 	struct regmap				*regmap;
 	struct clk				*pclk;
 	struct clk				*gclk;
-	unsigned int				fmt;
 	unsigned int				trigger_enabled;
 	unsigned int				gclk_enabled:1;
 };
-- 
2.34.1

