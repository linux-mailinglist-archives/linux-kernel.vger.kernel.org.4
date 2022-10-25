Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6663060D80C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiJYXjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiJYXjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:39:08 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E32FC6E1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:38:55 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id z24so9438146ljn.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQhShKhvS/+oh7sUIgvlgzVYDBBWcRkOByOCMCkM4bY=;
        b=K1XJ5QSKOcw0J6F5+EbA4VLES15MWEwPg7xBGqBZOqyU16Lis5D8BqIXTe+jdpp4Hn
         N9i5u1qbmtACjsFk1AY2h+Pv5Fah+53WjqaC/p9hd5WahD0M4gCvMAmf7ezZbi+X4w97
         tntdzGoxV/mf0z10t1Qlwi6tsxYEo5qameKn9VENyPVjo9H55WXtymWUNerUXG7R/TgA
         7YdqhSpv4WRoxWR7+0y4nYMuYsPXDO6EZ1hD76a0JkBftpUW3MuROXgucKmF/cXTiBQZ
         Eg0Zd2EXuTarw5f/KeWqmGxCl9N7uss3ZP9b0uzeaeNy1O7tmZ4VhIILgb6ubzzSVv9X
         +TDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQhShKhvS/+oh7sUIgvlgzVYDBBWcRkOByOCMCkM4bY=;
        b=fXA1iXuUG4r7oZxbG5she8Lv7SnNSoTlL1zC7oCZ1/1JwF7v4MoNE6k87xrjGIAruE
         A5sRxYjq+jM11Cii5GVbnZjIt5pwrWeSeo1a1peWM2OyQ6SfiL+te5zpZkfI/Uwu7Rkr
         lFn3eKWwVKtVtuzGBilZk+ytFfanr7J60e59FuszFHVncI/yIvMY6IwVCi7DmQlEGkGX
         mWfLgZK3k/6cQzrTwWWZqqq9+sJS1SHJqBU9yMsIXEcATicRqDDb01L8izvebfjdCNz9
         833Czu8CVM9S1BVApcRu3OEPNkYsr9URvKh1oyeGBR1/OVDlSwZqfCcDav60iiuyFSho
         vcMw==
X-Gm-Message-State: ACrzQf1TYxLk+jjvgJw5kAh0DHpI/5xDQ8ijybyJjVA/ixzLxZR0MhDs
        kI3+HMNzc6oTrKoMZQxsKvo=
X-Google-Smtp-Source: AMsMyM4bS3i6ryub5rHwNMHGTrDUdundTDbq2f+u2NAQPYqGqLKlD3DC/3shqFXGiIs4AzNmpqwMpg==
X-Received: by 2002:a2e:3a12:0:b0:277:a6b:b919 with SMTP id h18-20020a2e3a12000000b002770a6bb919mr5462167lja.191.1666741133690;
        Tue, 25 Oct 2022 16:38:53 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id w17-20020a05651c119100b0026daf4fc0f7sm701969ljo.92.2022.10.25.16.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:38:49 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH 12/17] staging: vt6655: changed variable name: cbFrameSize
Date:   Tue, 25 Oct 2022 23:37:08 +0000
Message-Id: <1be63d32bee244e0259a81b0c463efe98952aacd.1666740522.git.tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666740522.git.tanjubrunostar0@gmail.com>
References: <cover.1666740522.git.tanjubrunostar0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change variable names cbFrameSize to meet the
linux coding standard, as it says to avoid using camelCase naming
style. Cought by checkpatch

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 58 +++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 819080b14d5d..cc3b642ef8af 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -101,7 +101,7 @@ static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 				     void *pv_rrv_time,
 				     void *pv_rts,
 				     void *pv_cts,
-				     unsigned int	cbFrameSize,
+				     unsigned int	cb_frame_size,
 				     bool bNeedACK,
 				     unsigned int	uDMAIdx,
 				     void *psEthHeader,
@@ -926,7 +926,7 @@ static void s_vFillCTSHead(struct vnt_private *p_device,
  *      pv_rrv_time        - pv_rrv_time
  *      pv_rts            - RTS Buffer
  *      pCTS            - CTS Buffer
- *      cbFrameSize     - Transmit Data Length (Hdr+Payload+FCS)
+ *      cb_frame_size     - Transmit Data Length (Hdr+Payload+FCS)
  *      bNeedACK        - If need ACK
  *      uDescIdx        - Desc Index
  *  Out:
@@ -935,7 +935,7 @@ static void s_vFillCTSHead(struct vnt_private *p_device,
  * Return Value: none
  *
  -
- * unsigned int cbFrameSize, Hdr+Payload+FCS
+ * unsigned int cb_frame_size, Hdr+Payload+FCS
  */
 static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 				     unsigned char by_pkt_type,
@@ -943,7 +943,7 @@ static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 				     void *pv_rrv_time,
 				     void *pv_rts,
 				     void *pv_cts,
-				     unsigned int cbFrameSize,
+				     unsigned int cb_frame_size,
 				     bool bNeedACK,
 				     unsigned int uDMAIdx,
 				     void *psEthHeader,
@@ -972,68 +972,72 @@ static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 			struct vnt_rrv_time_rts *buf = pv_rrv_time;
 
 			buf->rts_rrv_time_aa = get_rtscts_time(p_device, 2, by_pkt_type,
-							       cbFrameSize, wCurrentRate);
+							       cb_frame_size, wCurrentRate);
 			buf->rts_rrv_time_ba = get_rtscts_time(p_device, 1, by_pkt_type,
-							       cbFrameSize, wCurrentRate);
+							       cb_frame_size, wCurrentRate);
 			buf->rts_rrv_time_bb = get_rtscts_time(p_device, 0, by_pkt_type,
-							       cbFrameSize, wCurrentRate);
-			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(p_device, by_pkt_type, cbFrameSize,
+							       cb_frame_size, wCurrentRate);
+			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(p_device, by_pkt_type,
+								cb_frame_size,
 								wCurrentRate, bNeedACK);
-			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11B, cbFrameSize,
+			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11B,
+								cb_frame_size,
 								p_device->byTopCCKBasicRate,
 								bNeedACK);
 
-			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cbFrameSize, bNeedACK,
+			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cb_frame_size, bNeedACK,
 					  b_dis_crc, psEthHeader, wCurrentRate, by_fb_option);
 		} else {/* RTS_needless, PCF mode */
 			struct vnt_rrv_time_cts *buf = pv_rrv_time;
 
-			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(p_device, by_pkt_type, cbFrameSize,
+			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(p_device, by_pkt_type,
+								cb_frame_size,
 								wCurrentRate, bNeedACK);
-			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11B, cbFrameSize,
+			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11B,
+								cb_frame_size,
 								p_device->byTopCCKBasicRate,
 								bNeedACK);
 			buf->cts_rrv_time_ba = get_rtscts_time(p_device, 3, by_pkt_type,
-							       cbFrameSize, wCurrentRate);
+							       cb_frame_size, wCurrentRate);
 
 			/* Fill CTS */
-			s_vFillCTSHead(p_device, uDMAIdx, by_pkt_type, pv_cts, cbFrameSize,
+			s_vFillCTSHead(p_device, uDMAIdx, by_pkt_type, pv_cts, cb_frame_size,
 				       bNeedACK, b_dis_crc, wCurrentRate, by_fb_option);
 		}
 	} else if (by_pkt_type == PK_TYPE_11A) {
 		if (pv_rts) {/* RTS_need, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pv_rrv_time;
 
-			buf->rts_rrv_time = get_rtscts_time(p_device, 2, by_pkt_type, cbFrameSize,
+			buf->rts_rrv_time = get_rtscts_time(p_device, 2, by_pkt_type, cb_frame_size,
 							    wCurrentRate);
-			buf->rrv_time = vnt_rxtx_rsvtime_le16(p_device, by_pkt_type, cbFrameSize,
+			buf->rrv_time = vnt_rxtx_rsvtime_le16(p_device, by_pkt_type, cb_frame_size,
 							      wCurrentRate, bNeedACK);
 
 			/* Fill RTS */
-			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cbFrameSize, bNeedACK,
+			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cb_frame_size, bNeedACK,
 					  b_dis_crc, psEthHeader, wCurrentRate, by_fb_option);
 		} else if (!pv_rts) {/* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pv_rrv_time;
 
-			buf->rrv_time = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11A, cbFrameSize,
+			buf->rrv_time = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11A, cb_frame_size,
 							      wCurrentRate, bNeedACK);
 		}
 	} else if (by_pkt_type == PK_TYPE_11B) {
 		if (pv_rts) {/* RTS_need, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pv_rrv_time;
 
-			buf->rts_rrv_time = get_rtscts_time(p_device, 0, by_pkt_type, cbFrameSize,
+			buf->rts_rrv_time = get_rtscts_time(p_device, 0, by_pkt_type, cb_frame_size,
 							    wCurrentRate);
-			buf->rrv_time = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11B, cbFrameSize,
+			buf->rrv_time = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11B, cb_frame_size,
 							      wCurrentRate, bNeedACK);
 
 			/* Fill RTS */
-			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cbFrameSize, bNeedACK,
+			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cb_frame_size, bNeedACK,
 					  b_dis_crc, psEthHeader, wCurrentRate, by_fb_option);
 		} else { /* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pv_rrv_time;
 
-			buf->rrv_time = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11B, cbFrameSize,
+			buf->rrv_time = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11B, cb_frame_size,
 							      wCurrentRate, bNeedACK);
 		}
 	}
@@ -1053,7 +1057,7 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 	struct vnt_tx_fifo_head *tx_buffer_head =
 			(struct vnt_tx_fifo_head *)td_info->buf;
 	u16 fifo_ctl = le16_to_cpu(tx_buffer_head->fifo_ctl);
-	unsigned int cbFrameSize;
+	unsigned int cb_frame_size;
 	__le16 uDuration;
 	unsigned char *pbyBuffer;
 	unsigned int uLength = 0;
@@ -1073,7 +1077,7 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 	unsigned short wTxBufSize;   /* FFinfo size */
 	unsigned char by_fb_option = AUTO_FB_NONE;
 
-	cbFrameSize = skb->len + 4;
+	cb_frame_size = skb->len + 4;
 
 	if (info->control.hw_key) {
 		switch (info->control.hw_key->cipher) {
@@ -1084,7 +1088,7 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 			break;
 		}
 
-		cbFrameSize += info->control.hw_key->icv_len;
+		cb_frame_size += info->control.hw_key->icv_len;
 
 		if (p_device->local_id > REV_ID_VT3253_A1) {
 			/* MAC Header should be padding 0 to DW alignment. */
@@ -1225,9 +1229,9 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 
 	/* Fill FIFO,RrvTime,RTS,and CTS */
 	s_vgenerate_tx_parameter(p_device, by_pkt_type, tx_buffer_head, pv_rrv_time, pv_rts, pv_cts,
-				 cbFrameSize, bNeedACK, uDMAIdx, hdr, p_device->wCurrentRate);
+				 cb_frame_size, bNeedACK, uDMAIdx, hdr, p_device->wCurrentRate);
 	/* Fill DataHead */
-	uDuration = s_uFillDataHead(p_device, by_pkt_type, pvTxDataHd, cbFrameSize, uDMAIdx,
+	uDuration = s_uFillDataHead(p_device, by_pkt_type, pvTxDataHd, cb_frame_size, uDMAIdx,
 				    bNeedACK, 0, 0, uMACfragNum, by_fb_option,
 				    p_device->wCurrentRate, is_pspoll);
 
-- 
2.34.1

