Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D85C60D808
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiJYXiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiJYXiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:38:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF36FC6DB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:37:56 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j4so25419571lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/urUot3cNFITmccYXucAWbb6h0aY9AK/ky19fLze9Y=;
        b=eW2kzFNFulbHPkEY7L5bBP+QwQ3W37hMKKPg0Qaeboh3BrZ7/uL6LUSZ5FFptG3XZ7
         NS0PqiWbQ0EeEyzfFWoobh4lME1DosqR8XHU9m7mu6pU6vZ8NSUAEhR/II8EQWim5kV/
         mlkodIg0psVC7jLm+cbtiapnCeeN9shZyLVNC7THLMoMeS7K55gHiALm2PyiMS4uuuFx
         prQqbGpXyuSFdPNDnrayMe4jyat+D0Tde7eiRJF05I16Z1bObQaouZ0GYffCCkrEsqrU
         BmcSqY7wTbf3sJNdSjSKZZHcFSawKk8h+J1MpiVfycLoeeLa7FrB92I7AGmZHky8Y20B
         bMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/urUot3cNFITmccYXucAWbb6h0aY9AK/ky19fLze9Y=;
        b=bRh9gZzT5yPG5fdDHFe/rCnW7EgDTG6ynmBq2iYJOhVmkUriP5lZi/o40OB+kuQ2fv
         DqavJvEg9trguXkrnYB2Co5l+9+te880tpOglxO4mN7R/zLpSE7Qjpng1ZB6UdunfLEj
         vqlD392CAlh7Nw1oc6kQXfZ69NY3GO00yfVZbWEY8AG22qGOb7br42Ueea0Ympgmkf/d
         Jb4SpB99ZGnaVrfpmOm12zHQQqLzhXQom5K7Ro9rpBTCA++hInokTSfgTBVQN3aKpbLT
         AV8b95PUH07pu7iV/fgRSFR3uhAZjNTD6EMs6O6+Sbc/s2qd/nlkPodohNt7JqCTmxbD
         OmHQ==
X-Gm-Message-State: ACrzQf3jT9GG7PHiTy4PsUBZSinFLdBNEnwU7w2GUTiXv31EgmAThR/a
        bYoQO7V1CmwssKjuSq5irOs=
X-Google-Smtp-Source: AMsMyM4/u8NvgBgAVSW7nJHMWTZ4tIpusPuAe4BeRtt5DfV4jV37O9yX7AZSzNvJXNl/EM1m5GT/7Q==
X-Received: by 2002:ac2:4a6b:0:b0:4a2:46f7:93f1 with SMTP id q11-20020ac24a6b000000b004a246f793f1mr15337574lfp.675.1666741074451;
        Tue, 25 Oct 2022 16:37:54 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id w17-20020a05651c119100b0026daf4fc0f7sm701969ljo.92.2022.10.25.16.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:37:54 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH 08/17] staging: vt6655: changed variable name: bDisCRC
Date:   Tue, 25 Oct 2022 23:37:04 +0000
Message-Id: <45a1de2d980f814ccc7e5c3932e4084d4d057f9e.1666740522.git.tanjubrunostar0@gmail.com>
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
 drivers/staging/vt6655/rxtx.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 1949a647a443..cb6d915fe7d0 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -90,7 +90,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 			      void *pv_rts,
 			      unsigned int	cb_frame_length,
 			      bool b_need_ack,
-			      bool bDisCRC,
+			      bool b_dis_crc,
 			      struct ieee80211_hdr *hdr,
 			      unsigned short wCurrentRate,
 			      unsigned char byFBOption);
@@ -628,7 +628,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 			      void *pv_rts,
 			      unsigned int cb_frame_length,
 			      bool b_need_ack,
-			      bool bDisCRC,
+			      bool b_dis_crc,
 			      struct ieee80211_hdr *hdr,
 			      unsigned short wCurrentRate,
 			      unsigned char byFBOption)
@@ -638,7 +638,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 	if (!pv_rts)
 		return;
 
-	if (bDisCRC) {
+	if (b_dis_crc) {
 		/* When CRCDIS bit is on, H/W forgot to generate FCS for
 		 * RTS frame, in this case we need to decrease its length by 4.
 		 */
@@ -820,7 +820,7 @@ static void s_vFillCTSHead(struct vnt_private *p_device,
 			   void *pvCTS,
 			   unsigned int cb_frame_length,
 			   bool b_need_ack,
-			   bool bDisCRC,
+			   bool b_dis_crc,
 			   unsigned short wCurrentRate,
 			   unsigned char byFBOption)
 {
@@ -829,7 +829,7 @@ static void s_vFillCTSHead(struct vnt_private *p_device,
 	if (!pvCTS)
 		return;
 
-	if (bDisCRC) {
+	if (b_dis_crc) {
 		/* When CRCDIS bit is on, H/W forgot to generate FCS for
 		 * CTS frame, in this case we need to decrease its length by 4.
 		 */
@@ -947,13 +947,13 @@ static void s_vGenerateTxParameter(struct vnt_private *p_device,
 				   unsigned short wCurrentRate)
 {
 	u16 fifo_ctl = le16_to_cpu(tx_buffer_head->fifo_ctl);
-	bool bDisCRC = false;
+	bool b_dis_crc = false;
 	unsigned char byFBOption = AUTO_FB_NONE;
 
 	tx_buffer_head->current_rate = cpu_to_le16(wCurrentRate);
 
 	if (fifo_ctl & FIFOCTL_CRCDIS)
-		bDisCRC = true;
+		b_dis_crc = true;
 
 	if (fifo_ctl & FIFOCTL_AUTO_FB_0)
 		byFBOption = AUTO_FB_0;
@@ -981,7 +981,7 @@ static void s_vGenerateTxParameter(struct vnt_private *p_device,
 								bNeedACK);
 
 			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cbFrameSize, bNeedACK,
-					  bDisCRC, psEthHeader, wCurrentRate, byFBOption);
+					  b_dis_crc, psEthHeader, wCurrentRate, byFBOption);
 		} else {/* RTS_needless, PCF mode */
 			struct vnt_rrv_time_cts *buf = pvRrvTime;
 
@@ -995,7 +995,7 @@ static void s_vGenerateTxParameter(struct vnt_private *p_device,
 
 			/* Fill CTS */
 			s_vFillCTSHead(p_device, uDMAIdx, by_pkt_type, pvCTS, cbFrameSize, bNeedACK,
-				       bDisCRC, wCurrentRate, byFBOption);
+				       b_dis_crc, wCurrentRate, byFBOption);
 		}
 	} else if (by_pkt_type == PK_TYPE_11A) {
 		if (pv_rts) {/* RTS_need, non PCF mode */
@@ -1008,7 +1008,7 @@ static void s_vGenerateTxParameter(struct vnt_private *p_device,
 
 			/* Fill RTS */
 			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cbFrameSize, bNeedACK,
-					  bDisCRC, psEthHeader, wCurrentRate, byFBOption);
+					  b_dis_crc, psEthHeader, wCurrentRate, byFBOption);
 		} else if (!pv_rts) {/* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
@@ -1026,7 +1026,7 @@ static void s_vGenerateTxParameter(struct vnt_private *p_device,
 
 			/* Fill RTS */
 			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cbFrameSize, bNeedACK,
-					  bDisCRC, psEthHeader, wCurrentRate, byFBOption);
+					  b_dis_crc, psEthHeader, wCurrentRate, byFBOption);
 		} else { /* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
-- 
2.34.1

