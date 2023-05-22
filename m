Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BFE70CAE5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbjEVUZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjEVUYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:24:46 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11E4B5;
        Mon, 22 May 2023 13:24:44 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50db91640d3so96604a12.0;
        Mon, 22 May 2023 13:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684787083; x=1687379083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btQwAZ+OJpomjBfsYfWI/t2/La/UN3uRKYWtIk0Ij7U=;
        b=Sjo5murqx0vXxRPU+nMVF98HCit8ZMTpMCIDWKn/+YqroZuZ1opR8rCAxlXFukTk6k
         YCwI+niFc4BfGFf6+fbySPuseCjplNobyxSaihB4fnyNAVo74+wAijobPb4yo58w3/Xo
         WTGrvzV052DqQ9bNLBQ+ubh+NO4kkj15t+VwkGEwudYtM7qhJDPIMmQo47qKx7Cteq8a
         c4K9EaOi8YmuxDj+CuNO5APV3k4W1p/SNJPTzrwJbzP864gVpHJOWCL6cd2UxZ6xjN1m
         iUH2mT05P+atqROJ0UZdLjB0Nka+3NMr9Vk/mOwa69gizUpFj36xL8QmUBzYmU+6eJvN
         N1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684787083; x=1687379083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btQwAZ+OJpomjBfsYfWI/t2/La/UN3uRKYWtIk0Ij7U=;
        b=KhQJwmTTVgmS/kSinBx+35ShjVVqZv5B4bYySeB/kqFLz4gjIJQAkPPuFSPH6ZduqZ
         17h7OmPAAgehtCpjC5q3vy9bSZkj7QMfEI/3CiCAme/MgyxQn3Vu3xTYlevcgvp19EHd
         IntmsRs2TlEOiPv2iZklzxXhuci9cMVri2h5xg06y0k0rS58W6mhz7FfB7bZu/ksxnTr
         InOztMOmW5Ubcoq3fPlChOnn9VQDf+qv5+QtwHr4/FL2IGMfynZdxLoYl2f45bQOJ6ZU
         EUt1r8cQTLVyvq9z4Zhu327vOTGuRB/P9VYVG7c7EVgsO0ytvmf4mHWr3WvlVRTe1b/a
         tH5A==
X-Gm-Message-State: AC+VfDyjprPOkjtg1rOL0Z8tHJuDisfuj7bxm51TIlUx8dAPDuzIYtvt
        xR46Wv1+7/Dk1+c+MhpagtPKyArFns4=
X-Google-Smtp-Source: ACHHUZ6Hl7NIZoibCh4D+lq2NzCu2+E+7XpBh6Ft195lztIW8pyuwH+yUlhBl0OMKIhEWp3cVN3Dtg==
X-Received: by 2002:aa7:d353:0:b0:50b:d819:4fd2 with SMTP id m19-20020aa7d353000000b0050bd8194fd2mr8421413edr.17.1684787083004;
        Mon, 22 May 2023 13:24:43 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c459-f400-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c459:f400::e63])
        by smtp.googlemail.com with ESMTPSA id v2-20020a056402184200b0050d56dffc93sm3265031edy.12.2023.05.22.13.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:24:42 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, kvalo@kernel.org, tony0620emma@gmail.com,
        Peter Robinson <pbrobinson@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>, jernej.skrabec@gmail.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH wireless-next v2 1/4] wifi: rtw88: sdio: Check the HISR RX_REQUEST bit in rtw_sdio_rx_isr()
Date:   Mon, 22 May 2023 22:24:22 +0200
Message-Id: <20230522202425.1827005-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522202425.1827005-1-martin.blumenstingl@googlemail.com>
References: <20230522202425.1827005-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_sdio_rx_isr() is responsible for receiving data from the wifi chip
and is called from the SDIO interrupt handler when the interrupt status
register (HISR) has the RX_REQUEST bit set. After the first batch of
data has been processed by the driver the wifi chip may have more data
ready to be read, which is managed by a loop in rtw_sdio_rx_isr().

It turns out that there are cases where the RX buffer length (from the
REG_SDIO_RX0_REQ_LEN register) does not match the data we receive. The
following two cases were observed with a RTL8723DS card:
- RX length is smaller than the total packet length including overhead
  and actual data bytes (whose length is part of the buffer we read from
  the wifi chip and is stored in rtw_rx_pkt_stat.pkt_len). This can
  result in errors like:
    skbuff: skb_over_panic: text:ffff8000011924ac len:3341 put:3341
  (one case observed was: RX buffer length = 1536 bytes but
   rtw_rx_pkt_stat.pkt_len = 1546 bytes, this is not valid as it means
   we need to read beyond the end of the buffer)
- RX length looks valid but rtw_rx_pkt_stat.pkt_len is zero

Check if the RX_REQUEST is set in the HISR register for each iteration
inside rtw_sdio_rx_isr(). This mimics what the RTL8723DS vendor driver
does and makes the driver only read more data if the RX_REQUEST bit is
set (which seems to be a way for the card's hardware or firmware to
tell the host that data is ready to be processed).

For RTW_WCPU_11AC chips this check is not needed. The RTL8822BS vendor
driver for example states that this check is unnecessary (but still uses
it) and the RTL8822CS drops this check entirely.

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Changes since v1:
- added Ping-Ke's Reviewed-by (thank you!)


 drivers/net/wireless/realtek/rtw88/sdio.c | 24 ++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 06fce7c3adda..2c1fb2dabd40 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -998,9 +998,9 @@ static void rtw_sdio_rxfifo_recv(struct rtw_dev *rtwdev, u32 rx_len)
 
 static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
 {
-	u32 rx_len, total_rx_bytes = 0;
+	u32 rx_len, hisr, total_rx_bytes = 0;
 
-	while (total_rx_bytes < SZ_64K) {
+	do {
 		if (rtw_chip_wcpu_11n(rtwdev))
 			rx_len = rtw_read16(rtwdev, REG_SDIO_RX0_REQ_LEN);
 		else
@@ -1012,7 +1012,25 @@ static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
 		rtw_sdio_rxfifo_recv(rtwdev, rx_len);
 
 		total_rx_bytes += rx_len;
-	}
+
+		if (rtw_chip_wcpu_11n(rtwdev)) {
+			/* Stop if no more RX requests are pending, even if
+			 * rx_len could be greater than zero in the next
+			 * iteration. This is needed because the RX buffer may
+			 * already contain data while either HW or FW are not
+			 * done filling that buffer yet. Still reading the
+			 * buffer can result in packets where
+			 * rtw_rx_pkt_stat.pkt_len is zero or points beyond the
+			 * end of the buffer.
+			 */
+			hisr = rtw_read32(rtwdev, REG_SDIO_HISR);
+		} else {
+			/* RTW_WCPU_11AC chips have improved hardware or
+			 * firmware and can use rx_len unconditionally.
+			 */
+			hisr = REG_SDIO_HISR_RX_REQUEST;
+		}
+	} while (total_rx_bytes < SZ_64K && hisr & REG_SDIO_HISR_RX_REQUEST);
 }
 
 static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
-- 
2.40.1

