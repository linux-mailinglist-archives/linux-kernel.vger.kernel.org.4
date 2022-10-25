Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7466760D801
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbiJYXhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiJYXhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:37:46 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480DEFBCDC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:37:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id d6so25280546lfs.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwmqc0ZHV1ejckQpOtC4ineulUJPlyh7/lvqbQKOwHg=;
        b=lohPY4YD0kSx0eh/wtGO/OHGpFqedZkzTscd30xAtFeZIwS1rVi6Vjxu+LvIYZiCFB
         X8aVTJ39+5VIPWDctbVxcXR6yvIGLrfK5SDDzt/D8bCvi2fKFI4W56TASurAY63Qyc+y
         Nu4QZpgNY2tHT+XjU8xguX7id6ZzweoJKDvMZjbLsCcLcmVqtC5XUvE2t9GRn+9xaKtI
         tueSOdKntKsbubliqd2DDc52BH2ZuIn+02TH65lh9ActVt6F2c2VjXCeEyQZshXBLMGe
         N44InlOYID129fOM/Rx4lTYboW1OkzHxCh2RlmH9ded2DttBa5Xr5ca5fT9no4zoSs2O
         Biug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwmqc0ZHV1ejckQpOtC4ineulUJPlyh7/lvqbQKOwHg=;
        b=xgl04tUPGbE7f6qxheJskWv41Do1K/Y8I8w2nYGiCDOxYTBoD1u81P2xO8baHbcuVi
         MlTHwGNDwCKeHYVTnve8jUtZxAUJeHSg+wvWRMbLxBAHIGZKhmZ2gmLpC/kdD03U7YXd
         /E8aesheP9Ha/TjZXEhynTpsH1D5+COa8PwKaAuIdZtL/qy+IZYOklKuMOt+BXCzIVkO
         v+d/qT4pwHthotbmXSamBj+l+bHwN8gy8P48kAh4oB3r7p0Ra56CB4MYs2hBHNhc1PBU
         hfTxPBR3ykJeChvhebUmY4aO0H3mbbzi+bwmFeP9ZWv+O7a2ejjGmphQ0/VjMhITtMTh
         jjww==
X-Gm-Message-State: ACrzQf3X2Bk7F52qMNDB1Fa20VJs7Uk5691s9r6M8Y18PTP01liD51R5
        i8gBVHZWSkvNxJD7XjpJQTE=
X-Google-Smtp-Source: AMsMyM68KtLT7ZZCJ60EUKqFsybR7kwuop+yBLXEThWQxQ5OP0iFicE8YUdnWrSOiL0yn1B4MASryA==
X-Received: by 2002:ac2:58ca:0:b0:4a2:7bb1:ad61 with SMTP id u10-20020ac258ca000000b004a27bb1ad61mr15431669lfo.212.1666741063660;
        Tue, 25 Oct 2022 16:37:43 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id w17-20020a05651c119100b0026daf4fc0f7sm701969ljo.92.2022.10.25.16.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:37:43 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH 02/17] staging: vt6655: changed variable names: s_vFillRTSHead
Date:   Tue, 25 Oct 2022 23:36:58 +0000
Message-Id: <8afb904f9fb22a262b3563d5cfc5804863bfb5ea.1666740522.git.tanjubrunostar0@gmail.com>
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

    change variable names s_vFillRTSHead and wTimeStampOff to meet the
    linux coding standard, as it says to avoid using camelCase naming style.
    Cought by checkpatch

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 54 +++++++++++++++++------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index ac9b3402be4f..8bb06b142748 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -23,7 +23,7 @@
  *      s_uGetTxRsvTime- get frame reserved time
  *      s_vFillCTSHead- fulfill CTS ctl header
  *      s_vFillFragParameter- Set fragment ctl parameter.
- *      s_vFillRTSHead- fulfill RTS ctl header
+ *      s_v_fill_rts_head- fulfill RTS ctl header
  *      s_vFillTxKey- fulfill tx encrypt key
  *      s_vSWencryption- Software encrypt header
  *      vDMA0_tx_80211- tx 802.11 frame via dma0
@@ -54,7 +54,7 @@
  */
 #define CRITICAL_PACKET_LEN      256
 
-static const unsigned short wTimeStampOff[2][MAX_RATE] = {
+static const unsigned short w_time_stamp_off[2][MAX_RATE] = {
 	{384, 288, 226, 209, 54, 43, 37, 31, 28, 25, 24, 23}, /* Long Preamble */
 	{384, 192, 130, 113, 54, 43, 37, 31, 28, 25, 24, 23}, /* Short Preamble */
 };
@@ -85,15 +85,15 @@ static const unsigned short w_fb_opt_1[2][5] = {
 #define DATADUR_A_F1    13
 
 /*---------------------  Static Functions  --------------------------*/
-static void s_vFillRTSHead(struct vnt_private *pDevice,
-			   unsigned char byPktType,
-			   void *pvRTS,
-			   unsigned int	cbFrameLength,
-			   bool bNeedAck,
-			   bool bDisCRC,
-			   struct ieee80211_hdr *hdr,
-			   unsigned short wCurrentRate,
-			   unsigned char byFBOption);
+static void s_v_fill_rts_head(struct vnt_private *pDevice,
+			      unsigned char byPktType,
+			      void *pvRTS,
+			      unsigned int	cbFrameLength,
+			      bool bNeedAck,
+			      bool bDisCRC,
+			      struct ieee80211_hdr *hdr,
+			      unsigned short wCurrentRate,
+			      unsigned char byFBOption);
 
 static void s_vGenerateTxParameter(struct vnt_private *pDevice,
 				   unsigned char byPktType,
@@ -130,7 +130,7 @@ static __le16 s_uFillDataHead(struct vnt_private *pDevice,
 
 static __le16 vnt_time_stamp_off(struct vnt_private *priv, u16 rate)
 {
-	return cpu_to_le16(wTimeStampOff[priv->preamble_type % 2]
+	return cpu_to_le16(w_time_stamp_off[priv->preamble_type % 2]
 							[rate % MAX_RATE]);
 }
 
@@ -620,15 +620,15 @@ static __le16 s_uFillDataHead(struct vnt_private *pDevice,
 	return buf->duration;
 }
 
-static void s_vFillRTSHead(struct vnt_private *pDevice,
-			   unsigned char byPktType,
-			   void *pvRTS,
-			   unsigned int cbFrameLength,
-			   bool bNeedAck,
-			   bool bDisCRC,
-			   struct ieee80211_hdr *hdr,
-			   unsigned short wCurrentRate,
-			   unsigned char byFBOption)
+static void s_v_fill_rts_head(struct vnt_private *pDevice,
+			      unsigned char byPktType,
+			      void *pvRTS,
+			      unsigned int cbFrameLength,
+			      bool bNeedAck,
+			      bool bDisCRC,
+			      struct ieee80211_hdr *hdr,
+			      unsigned short wCurrentRate,
+			      unsigned char byFBOption)
 {
 	unsigned int uRTSFrameLen = 20;
 
@@ -977,8 +977,8 @@ static void s_vGenerateTxParameter(struct vnt_private *pDevice,
 								pDevice->byTopCCKBasicRate,
 								bNeedACK);
 
-			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
-				       psEthHeader, wCurrentRate, byFBOption);
+			s_v_fill_rts_head(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
+					  psEthHeader, wCurrentRate, byFBOption);
 		} else {/* RTS_needless, PCF mode */
 			struct vnt_rrv_time_cts *buf = pvRrvTime;
 
@@ -1004,8 +1004,8 @@ static void s_vGenerateTxParameter(struct vnt_private *pDevice,
 							      wCurrentRate, bNeedACK);
 
 			/* Fill RTS */
-			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
-				       psEthHeader, wCurrentRate, byFBOption);
+			s_v_fill_rts_head(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
+					  psEthHeader, wCurrentRate, byFBOption);
 		} else if (!pvRTS) {/* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
@@ -1022,8 +1022,8 @@ static void s_vGenerateTxParameter(struct vnt_private *pDevice,
 							      wCurrentRate, bNeedACK);
 
 			/* Fill RTS */
-			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
-				       psEthHeader, wCurrentRate, byFBOption);
+			s_v_fill_rts_head(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
+					  psEthHeader, wCurrentRate, byFBOption);
 		} else { /* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
-- 
2.34.1

