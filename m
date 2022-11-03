Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F56618863
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiKCTP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiKCTPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:15:10 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672EE1F63E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 12:15:07 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p8so4418999lfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 12:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCCC/aaN0XwGV5+u45rOCEbVu+I1nibQFzTI08X/CaE=;
        b=VFQpT11C9r1bia/G9DdHNF9ckFzQSI3EmESar5wRAdAUX6Cyp0dhYYqk/vDA4KJXHS
         DrvB6y4K9uy73vrA1dN94MD/D9kA4sMFW6oDQg/NimpDud6epm/ykPmd1E3SqNbqQVIP
         0gaGiZ8PUuB7TWPwnHxjwzYdrxBw+HC1JszdeV5F6LugdYs5S5sfyrGB42tfKpr7t62O
         7TBapxU5oBGQv56G178SOTiiw6yqjwKfuLu1/moJLY3yUkXbR2RrQq6UdkbmPKC4jgPj
         vdgZJ8ja0L1DjrWfWV+Gg4u8UvQopDkV0HO4VMH2sjLX6nMzMPns2vSP3HKrQPgU5a37
         IWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCCC/aaN0XwGV5+u45rOCEbVu+I1nibQFzTI08X/CaE=;
        b=DeBR0hbgniNkvyBZHZQWteSewRkop7RtGaN1jF832wmRfmYMyKvIaJoLx0QV/g7Grk
         tO/vPaGAte0FHITmBCUHqWmdDPRaHEGG89fab0Ncee9+n8Wh1xJ6kx21xPrMo8U+m0M/
         i+T8VWvjTUsMGi/wpX9PfMuMuuslG7K+SMFuk64izL9FYuMVClAt0RKu/vwICvEzdBVk
         RghiIO+XuJJYyzjQgSlbruJqTBoAQVw01jannHJ0JvDy6mDnNwj+v2vOTtGQd85aPC9u
         oYlzu97JQdquVTek1nP3ifiYjHbqzzi8JQBsfk17YBpNOo/ebWswMEm1y3oE0tCTQJpC
         wn8g==
X-Gm-Message-State: ACrzQf0+r0touUy5jjfPT6TJMynKaCYSWp3BKNQOoUYJ6X2sehHPGUzM
        oW8nCnf/2ohGfmIta6c043B4YLGxs48y/A==
X-Google-Smtp-Source: AMsMyM46lQfxV3ZaoyE1faX/QFWspK66kSoUq+qUSmUIDQ3IfPmTr7YS5n5+u3Cl5uh9hzQSYXxAmQ==
X-Received: by 2002:a05:6512:b0e:b0:4ae:23c9:1b32 with SMTP id w14-20020a0565120b0e00b004ae23c91b32mr11629860lfu.246.1667502905605;
        Thu, 03 Nov 2022 12:15:05 -0700 (PDT)
Received: from elroy-temp-vm ([20.240.130.248])
        by smtp.gmail.com with ESMTPSA id c4-20020ac244a4000000b004a47a92ff4csm218348lfm.193.2022.11.03.12.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:15:05 -0700 (PDT)
Date:   Thu, 3 Nov 2022 19:15:04 +0000
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: [PATCH v2] staging: vt6655: change the function name s_vFillRTSHead
Message-ID: <Y2QTON8cjU/D0GqO@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the use of Hungarian notation, which is not used in the Linux
kernel. Reported by checkpatch

Add indentation to the affected function headers to follow the Linux
kernel coding style

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---

v2: corrected confusing changlog message on this patch

 drivers/staging/vt6655/rxtx.c | 48 ++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 31ae99b3cb35..debc5d5daede 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -23,7 +23,7 @@
  *      s_uGetTxRsvTime- get frame reserved time
  *      s_vFillCTSHead- fulfill CTS ctl header
  *      s_vFillFragParameter- Set fragment ctl parameter.
- *      s_vFillRTSHead- fulfill RTS ctl header
+ *      fill_rts_header- fulfill RTS ctl header
  *      s_vFillTxKey- fulfill tx encrypt key
  *      s_vSWencryption- Software encrypt header
  *      vDMA0_tx_80211- tx 802.11 frame via dma0
@@ -85,15 +85,15 @@ static const unsigned short fb_opt1[2][5] = {
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
+static void fill_rts_header(struct vnt_private *pDevice,
+			    unsigned char byPktType,
+			    void *pvRTS,
+			    unsigned int cbFrameLength,
+			    bool bNeedAck,
+			    bool bDisCRC,
+			    struct ieee80211_hdr *hdr,
+			    unsigned short wCurrentRate,
+			    unsigned char byFBOption);
 
 static void s_vGenerateTxParameter(struct vnt_private *pDevice,
 				   unsigned char byPktType,
@@ -555,19 +555,15 @@ s_uFillDataHead(
 	return buf->duration;
 }
 
-static
-void
-s_vFillRTSHead(
-	struct vnt_private *pDevice,
-	unsigned char byPktType,
-	void *pvRTS,
-	unsigned int cbFrameLength,
-	bool bNeedAck,
-	bool bDisCRC,
-	struct ieee80211_hdr *hdr,
-	unsigned short wCurrentRate,
-	unsigned char byFBOption
-)
+static void fill_rts_header(struct vnt_private *pDevice,
+			    unsigned char byPktType,
+			    void *pvRTS,
+			    unsigned int cbFrameLength,
+			    bool bNeedAck,
+			    bool bDisCRC,
+			    struct ieee80211_hdr *hdr,
+			    unsigned short wCurrentRate,
+			    unsigned char byFBOption)
 {
 	unsigned int uRTSFrameLen = 20;
 
@@ -912,7 +908,7 @@ s_vGenerateTxParameter(
 			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
 			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
 
-			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
+			fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
 		} else {/* RTS_needless, PCF mode */
 			struct vnt_rrv_time_cts *buf = pvRrvTime;
 
@@ -931,7 +927,7 @@ s_vGenerateTxParameter(
 			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
 
 			/* Fill RTS */
-			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
+			fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
 		} else if (!pvRTS) {/* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
@@ -945,7 +941,7 @@ s_vGenerateTxParameter(
 			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
 
 			/* Fill RTS */
-			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
+			fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
 		} else { /* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
-- 
2.34.1

