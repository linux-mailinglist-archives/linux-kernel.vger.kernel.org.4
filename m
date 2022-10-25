Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737CC60D80D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiJYXjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbiJYXjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:39:15 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69F6FFF83
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:39:01 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id u2so10257516ljl.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zbs1vdQmiigLvQ3VvOjQt4juPolJu9r7kj9YMM+BCuw=;
        b=NGGj1EZTA4a4FcTTnQKW9KHL1pqKgIDEiWhDE4hi1Ey4SgonsFSUwaMYcDWPIoxqhe
         YCpWJxCg1M55KAz8p6jqDu5+7pxZ+Cx6W9qapjoteC6XDMTKaAfQPAXEieIvF2O7IZG4
         tSd/sKZOKHolv6CUJbje8MFNcs0E4XWZOKax3G79OdSWqFES6OuYMJ5WQ34zhNxYbSPt
         BAT5z0esFRGdQ7l9b9D7fcooSfiJaN65yWAUPqEhlkTQg6yXwOkImF1+ZOBVEt0jtyVw
         RQh2iOywYvPEZFWWjlMvAmfk1m0e2LUWpulbXOsPF2Vl0cOPpeaRybOsd7nS3WeKum8e
         Eq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zbs1vdQmiigLvQ3VvOjQt4juPolJu9r7kj9YMM+BCuw=;
        b=jNJa3WhFQ8TOGX9h1DY/UFx5jQyXUYmP7qq3tuxsH9HoFPWz35IJin9p3Whs/C8IbA
         peaJti91JG17VMORUG8XgdZ+FWUgbRqTFP79/XbtmZGaH7LdB1Yz+eKZjUskh+R8AtBH
         TEed8ayyJB9bCJO6CAfLnPnyoNTYEDmSlE5xzQIDo93+MEZUBQLbDJoPnzQ665xobR9x
         +kuxEGg9OAr4R0pcuTTqLg5SYG+43RPo7WQVaO66BriQ9X6xj6DbPA1Zbp4/xXVgMQyv
         Q6JGf1InW+efueVmjgCxIG04tuCMSVguyqkfMJNVrJibeiKeegxw14rkqe8yMBrSUgz/
         wa7w==
X-Gm-Message-State: ACrzQf10A2h+5NUDK9i3AflxjdFcCzF/+JCRe6jNxCUzbGOBiBU6Im1w
        zPFSH4tKo1nXclcAOB5bJRw=
X-Google-Smtp-Source: AMsMyM7mXecyr92BeBSXLrQzK/Rv3qWMmq4SmvN+zIhRShjfY3ljYeZSnuGsFUjAFASXDuiNkkgBSA==
X-Received: by 2002:a2e:b626:0:b0:277:249:c1d9 with SMTP id s6-20020a2eb626000000b002770249c1d9mr7679370ljn.514.1666741140048;
        Tue, 25 Oct 2022 16:39:00 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id w17-20020a05651c119100b0026daf4fc0f7sm701969ljo.92.2022.10.25.16.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:38:56 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH 13/17] staging: vt6655: changed variable name: bNeedACK
Date:   Tue, 25 Oct 2022 23:37:09 +0000
Message-Id: <c41b74ed595c33c4d3385aa2ae638e337b26337e.1666740522.git.tanjubrunostar0@gmail.com>
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

change variable names bDisCRC to meet the
linux coding standard, as it says to avoid using camelCase naming
style. Cought by checkpatch

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 36 +++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index cc3b642ef8af..1704b63da2cd 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -102,7 +102,7 @@ static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 				     void *pv_rts,
 				     void *pv_cts,
 				     unsigned int	cb_frame_size,
-				     bool bNeedACK,
+				     bool b_need_ack,
 				     unsigned int	uDMAIdx,
 				     void *psEthHeader,
 				     unsigned short wCurrentRate);
@@ -927,7 +927,7 @@ static void s_vFillCTSHead(struct vnt_private *p_device,
  *      pv_rts            - RTS Buffer
  *      pCTS            - CTS Buffer
  *      cb_frame_size     - Transmit Data Length (Hdr+Payload+FCS)
- *      bNeedACK        - If need ACK
+ *      b_need_ack        - If need ACK
  *      uDescIdx        - Desc Index
  *  Out:
  *      none
@@ -944,7 +944,7 @@ static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 				     void *pv_rts,
 				     void *pv_cts,
 				     unsigned int cb_frame_size,
-				     bool bNeedACK,
+				     bool b_need_ack,
 				     unsigned int uDMAIdx,
 				     void *psEthHeader,
 				     unsigned short wCurrentRate)
@@ -979,30 +979,30 @@ static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 							       cb_frame_size, wCurrentRate);
 			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(p_device, by_pkt_type,
 								cb_frame_size,
-								wCurrentRate, bNeedACK);
+								wCurrentRate, b_need_ack);
 			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11B,
 								cb_frame_size,
 								p_device->byTopCCKBasicRate,
-								bNeedACK);
+								b_need_ack);
 
-			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cb_frame_size, bNeedACK,
+			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cb_frame_size, b_need_ack,
 					  b_dis_crc, psEthHeader, wCurrentRate, by_fb_option);
 		} else {/* RTS_needless, PCF mode */
 			struct vnt_rrv_time_cts *buf = pv_rrv_time;
 
 			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(p_device, by_pkt_type,
 								cb_frame_size,
-								wCurrentRate, bNeedACK);
+								wCurrentRate, b_need_ack);
 			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11B,
 								cb_frame_size,
 								p_device->byTopCCKBasicRate,
-								bNeedACK);
+								b_need_ack);
 			buf->cts_rrv_time_ba = get_rtscts_time(p_device, 3, by_pkt_type,
 							       cb_frame_size, wCurrentRate);
 
 			/* Fill CTS */
 			s_vFillCTSHead(p_device, uDMAIdx, by_pkt_type, pv_cts, cb_frame_size,
-				       bNeedACK, b_dis_crc, wCurrentRate, by_fb_option);
+				       b_need_ack, b_dis_crc, wCurrentRate, by_fb_option);
 		}
 	} else if (by_pkt_type == PK_TYPE_11A) {
 		if (pv_rts) {/* RTS_need, non PCF mode */
@@ -1011,16 +1011,16 @@ static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 			buf->rts_rrv_time = get_rtscts_time(p_device, 2, by_pkt_type, cb_frame_size,
 							    wCurrentRate);
 			buf->rrv_time = vnt_rxtx_rsvtime_le16(p_device, by_pkt_type, cb_frame_size,
-							      wCurrentRate, bNeedACK);
+							      wCurrentRate, b_need_ack);
 
 			/* Fill RTS */
-			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cb_frame_size, bNeedACK,
+			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cb_frame_size, b_need_ack,
 					  b_dis_crc, psEthHeader, wCurrentRate, by_fb_option);
 		} else if (!pv_rts) {/* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pv_rrv_time;
 
 			buf->rrv_time = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11A, cb_frame_size,
-							      wCurrentRate, bNeedACK);
+							      wCurrentRate, b_need_ack);
 		}
 	} else if (by_pkt_type == PK_TYPE_11B) {
 		if (pv_rts) {/* RTS_need, non PCF mode */
@@ -1029,16 +1029,16 @@ static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 			buf->rts_rrv_time = get_rtscts_time(p_device, 0, by_pkt_type, cb_frame_size,
 							    wCurrentRate);
 			buf->rrv_time = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11B, cb_frame_size,
-							      wCurrentRate, bNeedACK);
+							      wCurrentRate, b_need_ack);
 
 			/* Fill RTS */
-			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cb_frame_size, bNeedACK,
+			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cb_frame_size, b_need_ack,
 					  b_dis_crc, psEthHeader, wCurrentRate, by_fb_option);
 		} else { /* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pv_rrv_time;
 
 			buf->rrv_time = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11B, cb_frame_size,
-							      wCurrentRate, bNeedACK);
+							      wCurrentRate, b_need_ack);
 		}
 	}
 }
@@ -1065,7 +1065,7 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 	unsigned int uMACfragNum = 1;
 	unsigned int uPadding = 0;
 	unsigned int cbReqCount = 0;
-	bool bNeedACK = (bool)(fifo_ctl & FIFOCTL_NEEDACK);
+	bool b_need_ack = (bool)(fifo_ctl & FIFOCTL_NEEDACK);
 	bool bRTS = (bool)(fifo_ctl & FIFOCTL_RTS);
 	struct vnt_tx_desc *ptdCurr;
 	unsigned int cbHeaderLength = 0;
@@ -1229,10 +1229,10 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 
 	/* Fill FIFO,RrvTime,RTS,and CTS */
 	s_vgenerate_tx_parameter(p_device, by_pkt_type, tx_buffer_head, pv_rrv_time, pv_rts, pv_cts,
-				 cb_frame_size, bNeedACK, uDMAIdx, hdr, p_device->wCurrentRate);
+				 cb_frame_size, b_need_ack, uDMAIdx, hdr, p_device->wCurrentRate);
 	/* Fill DataHead */
 	uDuration = s_uFillDataHead(p_device, by_pkt_type, pvTxDataHd, cb_frame_size, uDMAIdx,
-				    bNeedACK, 0, 0, uMACfragNum, by_fb_option,
+				    b_need_ack, 0, 0, uMACfragNum, by_fb_option,
 				    p_device->wCurrentRate, is_pspoll);
 
 	hdr->duration_id = uDuration;
-- 
2.34.1

