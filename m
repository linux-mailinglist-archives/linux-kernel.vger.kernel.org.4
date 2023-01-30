Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6213A680D0F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbjA3MJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236644AbjA3MIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:08:52 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848C4AD34
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675080513; x=1706616513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zg6MguSNDaqbB/z5cJmHX/RzGSEZnrDsEwnqwyBRCy8=;
  b=tbHrY5cd5EOhVC9OPaJSpTY28g9BsblN0R9cSXfGlIVXsQGzF8mUGjFj
   7cqvuGRq13JZimoExC4G4er0bj1DUnmFCpkOr7KUj8IHKxG4v02LQ6Dhi
   4hWaYikjNqwmbjLdnPPabP/vdF7+CWsS7/nAZcJNGce+gO5BY5ex9eduG
   SxqGtl0aUvm6JLY9+iVSQvpbHe3q6cMZawda4+915poEdblmn6ux/oKya
   Pgew0vcri0hNJQ7pQVY8vwRJDpoqTpvRUfmTknzJleeoZy5oaqNq1Cvfa
   mB6nJJJ0+5mOiFW6QROmZKpb73TJnhqaE2BtFwQq8QoQRE7inZl1Cd1aX
   g==;
X-IronPort-AV: E=Sophos;i="5.97,257,1669100400"; 
   d="scan'208";a="198544941"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jan 2023 05:07:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 05:07:52 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 05:07:48 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 8/8] ASoC: mchp-spdifrx: document data structures
Date:   Mon, 30 Jan 2023 14:06:47 +0200
Message-ID: <20230130120647.638049-9-claudiu.beznea@microchip.com>
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

Document data structures used by mchp-spdifrx driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-spdifrx.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/soc/atmel/mchp-spdifrx.c b/sound/soc/atmel/mchp-spdifrx.c
index 796d4ec2b2b1..dab5d93de329 100644
--- a/sound/soc/atmel/mchp-spdifrx.c
+++ b/sound/soc/atmel/mchp-spdifrx.c
@@ -249,16 +249,34 @@ static const struct regmap_config mchp_spdifrx_regmap_config = {
 
 #define SPDIFRX_CHANNELS	2
 
+/**
+ * struct mchp_spdifrx_ch_stat: MCHP SPDIFRX channel status
+ * @data: channel status bits
+ * @done: completion to signal channel status bits acquisition done
+ */
 struct mchp_spdifrx_ch_stat {
 	unsigned char data[SPDIFRX_CS_BITS / 8];
 	struct completion done;
 };
 
+/**
+ * struct mchp_spdifrx_user_data: MCHP SPDIFRX user data
+ * @data: user data bits
+ * @done: completion to signal user data bits acquisition done
+ */
 struct mchp_spdifrx_user_data {
 	unsigned char data[SPDIFRX_UD_BITS / 8];
 	struct completion done;
 };
 
+/**
+ * struct mchp_spdifrx_mixer_control: MCHP SPDIFRX mixer control data structure
+ * @ch_stat: array of channel statuses
+ * @user_data: array of user data
+ * @ulock: ulock bit status
+ * @badf: badf bit status
+ * @signal: signal bit status
+ */
 struct mchp_spdifrx_mixer_control {
 	struct mchp_spdifrx_ch_stat ch_stat[SPDIFRX_CHANNELS];
 	struct mchp_spdifrx_user_data user_data[SPDIFRX_CHANNELS];
@@ -267,6 +285,17 @@ struct mchp_spdifrx_mixer_control {
 	bool signal;
 };
 
+/**
+ * struct mchp_spdifrx_dev: MCHP SPDIFRX device data structure
+ * @capture: DAI DMA configuration data
+ * @control: mixer controls
+ * @mlock: mutex to protect concurency b/w configuration and control APIs
+ * @dev: struct device
+ * @regmap: regmap for this device
+ * @pclk: peripheral clock
+ * @gclk: generic clock
+ * @trigger_enabled: true if enabled though trigger() ops
+ */
 struct mchp_spdifrx_dev {
 	struct snd_dmaengine_dai_dma_data	capture;
 	struct mchp_spdifrx_mixer_control	control;
-- 
2.34.1

