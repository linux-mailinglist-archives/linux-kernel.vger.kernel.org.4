Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D49B74C7EF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 21:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjGIT50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 15:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGIT5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 15:57:24 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81013FD;
        Sun,  9 Jul 2023 12:57:23 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3110ab7110aso4093465f8f.3;
        Sun, 09 Jul 2023 12:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688932642; x=1691524642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vgaL3ZrKA+Pcji4s9jnCF3RMQhPuKT4E0C3X68pMG+8=;
        b=kvF3fZAR68Gve34/cWdFay6RCv5xmqJf1nrDjPO3VQJj27roELR861+tAS2X2Zv/YT
         2YkLXcdGl+MYL7kwJnBwbdMP8R1NoNikv68SfAboruEA+DlMN3InYdQqDQxwqdG5wJ5m
         6qo1ZtY8C8vXHFF2xP83FR6dZNyORWM4ynwuuyUIgqlqB64eranV1MPDrJXj2c1PwyON
         vZ0QuTyyt9O2ohNSAqulr0wFItgCjo37r5VUu6JZB46kSNcdPXYP8GMQQ6zjCqpQDhO4
         SWeAXX3MUwL96yCA9V0s47wMrLUxM+FaKxGljBGE08plSgxN8gN2WJ5khLRyKNx88U5q
         fxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688932642; x=1691524642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgaL3ZrKA+Pcji4s9jnCF3RMQhPuKT4E0C3X68pMG+8=;
        b=e8fxNc64JBC+uiZovtT9P0XB2O0VqZsdt/6amgGYOyWHFxQ1d4SbIbp2oNiLdWPhKQ
         eYjjg/WbdoEXf7AGDwn16mUP/2fMk93QwPtyXNsP0g3UiDmErXSfVVx2oBVBJD9O9JMb
         FnyrzpV9id3/CeUm3P4T8YxfCaZdxyUDIDUjXW/bCwLEIwNq5z68rfXUXlEj0lRmaWK7
         w3aH+5QGrCzYJ4nwTvpHlhcZir0CPjq2ZQP8a/P5e/GzoarsHd54Y4DU9w4jvsbWi5gK
         L+xifKRgpv9NAcxeXmuiEJImJgiKcznnhvosp9HTvo2LOs0vqCFTHlCVyFG1NtkdDKf6
         qXiw==
X-Gm-Message-State: ABy/qLZqdX6XHIy8MOoJWzaLZlKGP9VdameFrgfmGTGcx9kW8cRhM5f1
        FqcvugeiF4+nfikiOi0bzZbKO3rKo64=
X-Google-Smtp-Source: APBJJlHnpKpk1j4UtCEBEpXmkLG5mn/ORsGASeMsbD/NNpDuVareXgr+QoXvQ+NOx/d6nszUVAYaWw==
X-Received: by 2002:a05:6000:372:b0:313:efe3:c165 with SMTP id f18-20020a056000037200b00313efe3c165mr9300798wrf.49.1688932641435;
        Sun, 09 Jul 2023 12:57:21 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-6ebb-3c00-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:6ebb:3c00::e63])
        by smtp.googlemail.com with ESMTPSA id p11-20020a056000018b00b003141e86e751sm9878782wrx.5.2023.07.09.12.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 12:57:21 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jernej.skrabec@gmail.com,
        pkshih@realtek.com, ulf.hansson@linaro.org, kvalo@kernel.org,
        tony0620emma@gmail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "Lukas F . Hartmann" <lukas@mntre.com>
Subject: [PATCH] wifi: rtw88: sdio: Honor the host max_req_size in the RX path
Date:   Sun,  9 Jul 2023 21:57:12 +0200
Message-ID: <20230709195712.603200-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas reports skb_over_panic errors on his Banana Pi BPI-CM4 which comes
with an Amlogic A311D (G12B) SoC and a RTL8822CS SDIO wifi/Bluetooth
combo card. The error he observed is identical to what has been fixed
in commit e967229ead0e ("wifi: rtw88: sdio: Check the HISR RX_REQUEST
bit in rtw_sdio_rx_isr()") but that commit didn't fix Lukas' problem.

Lukas found that disabling or limiting RX aggregation fix the problem
for him. In the following discussion a few key topics have been
discussed which have an impact on this problem:
- The Amlogic A311D (G12B) SoC has a hardware bug in the SDIO controller
  which prevents DMA transfers. Instead all transfers need to go through
  the controller SRAM which limits transfers to 1536 bytes
- rtw88 chips don't split incoming (RX) packets, so if a big packet is
  received this is forwarded to the host in it's original form
- rtw88 chips can do RX aggregation, meaning more multiple incoming
  packets can be pulled by the host from the card with one MMC/SDIO
  transfer. This Depends on settings in the REG_RXDMA_AGG_PG_TH
  register (BIT_RXDMA_AGG_PG_TH limits the number of packets that will
  be aggregated, BIT_DMA_AGG_TO_V1 configures a timeout for aggregation
  and BIT_EN_PRE_CALC makes the chip honor the limits more effectively)

Use multiple consecutive reads in rtw_sdio_read_port() to limit the
number of bytes which are copied by the host from the card in one
MMC/SDIO transfer. This allows receiving a buffer that's larger than
the hosts max_req_size (number of bytes which can be transferred in
one MMC/SDIO transfer). As a result of this the skb_over_panic error
is gone as the rtw88 driver is now able to receive more than 1536 bytes
from the card (either because the incoming packet is larger than that
or because multiple packets have been aggregated).

Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
Reported-by: Lukas F. Hartmann <lukas@mntre.com>
Closes: https://lore.kernel.org/linux-wireless/CAFBinCBaXtebixKbjkWKW_WXc5k=NdGNaGUjVE8NCPNxOhsb2g@mail.gmail.com/
Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 24 +++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 2c1fb2dabd40..b19262ec5d8c 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -500,19 +500,31 @@ static u32 rtw_sdio_get_tx_addr(struct rtw_dev *rtwdev, size_t size,
 static int rtw_sdio_read_port(struct rtw_dev *rtwdev, u8 *buf, size_t count)
 {
 	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
+	struct mmc_host *host = rtwsdio->sdio_func->card->host;
 	bool bus_claim = rtw_sdio_bus_claim_needed(rtwsdio);
 	u32 rxaddr = rtwsdio->rx_addr++;
+	size_t bytes;
 	int ret;
 
 	if (bus_claim)
 		sdio_claim_host(rtwsdio->sdio_func);
 
-	ret = sdio_memcpy_fromio(rtwsdio->sdio_func, buf,
-				 RTW_SDIO_ADDR_RX_RX0FF_GEN(rxaddr), count);
-	if (ret)
-		rtw_warn(rtwdev,
-			 "Failed to read %zu byte(s) from SDIO port 0x%08x",
-			 count, rxaddr);
+	while (count > 0) {
+		bytes = min_t(size_t, host->max_req_size, count);
+
+		ret = sdio_memcpy_fromio(rtwsdio->sdio_func, buf,
+					 RTW_SDIO_ADDR_RX_RX0FF_GEN(rxaddr),
+					 bytes);
+		if (ret) {
+			rtw_warn(rtwdev,
+				 "Failed to read %zu byte(s) from SDIO port 0x%08x",
+				 bytes, rxaddr);
+			break;
+		}
+
+		count -= bytes;
+		buf += bytes;
+	}
 
 	if (bus_claim)
 		sdio_release_host(rtwsdio->sdio_func);
-- 
2.41.0

