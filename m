Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8787615164
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 19:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiKASSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 14:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiKASSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:18:03 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFB81B1C9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 11:18:02 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id h12so15364904ljg.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vodxGcB9Pfq4inF2n1v2hS81nVigSig+J8tui1TzmuI=;
        b=Qc0XDlexEehoXO0/jTvzs0z7EYSclLqBVX2YPX6Sz95MUZz5Asrwe2L0X9beaEMO6X
         ZcgKaLTVFr4/CCiZOHKr9S0cCRHfnymAQofEJhLZImcLFJDtGCki3k6QnX6wh8ELxFms
         fK7kQ1QZfUuD85M1ozqKtHSG3qFFSYZmx0kTE9/ugaUdT8uuGsnGyKy/BYDiC2wVOJdh
         vuiLTDlsPJVdQRF3nFyfMRFQVp1qaO+kZGIkrwruyk8kI5laDiWdV4q50wbjE2PKsB9k
         S8ECVWQET4O9TMqcRLFaDUP7pPn1y8T5Ry+dK6qdExOeiqT1IRqkMNvxlIEoO9Uxco13
         8DwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vodxGcB9Pfq4inF2n1v2hS81nVigSig+J8tui1TzmuI=;
        b=y6nxlEa7TLxsmhuym7xZh1JP3T197HAQbhMNRJDeyH/xYdcIbp1oLqrURVqd+9p0bI
         0t9MEhSGHj0MoYPxWA9jenV9T6gP76R6oDasHK5GnS9iHuI0eNLimoMpBarOCH+Y43I8
         at97i7JLV9O7x5d05vVa6M4APsEkSuet2+ROF0MQgkfsWgGGTjLJj88Dnz+TRB3Llbwa
         4zie8r81jiNUq8SeLWe3ye/VqExf7rA7qUwWXyXJrPMksc9V37Q8Aea1e11K7lqzI1Ul
         8jtDUlwy+WhOvnGKzTpydzN6nyEJ3bkqB5U1POyHxjbp2cj4osQ8rKlqy27AhOn4x4cr
         GfPw==
X-Gm-Message-State: ACrzQf3z5kSxkRNL1iRyuMT1sOTp25zpMqU7/1SYntwb3UP21YpnJZa3
        EYFB5P6zHRK9uxmE9d74z0eDqPBAEX8MYA==
X-Google-Smtp-Source: AMsMyM4OZIcXNFSzE5MkmG/j4J7D2LsGbLV2wb7yjeJrpP5XuJ9Vc+VFfk15Y+TYxtLaN7Yx2G/asg==
X-Received: by 2002:a2e:918a:0:b0:277:46da:16a6 with SMTP id f10-20020a2e918a000000b0027746da16a6mr5882036ljg.200.1667326682166;
        Tue, 01 Nov 2022 11:18:02 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id 190-20020a2e05c7000000b0026f9cb6d10fsm1850601ljf.45.2022.11.01.11.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 11:18:01 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v3 1/2] staging: vt6655: change the function name s_vFillRTSHead
Date:   Tue,  1 Nov 2022 18:17:48 +0000
Message-Id: <0ceb6b190e5a50f99bb3c0f5d23ba2421f6b709f.1667326000.git.tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1667326000.git.tanjubrunostar0@gmail.com>
References: <cover.1667326000.git.tanjubrunostar0@gmail.com>
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

Remove the use of Hungarian notation, which is not used in the Linux
kernel. Reported by checkpatch

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 31ae99b3cb35..c01fc1a593f3 100644
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
+static void fill_rts_head(struct vnt_private *pDevice,
+			  unsigned char byPktType,
+			  void *pvRTS,
+			  unsigned int	cbFrameLength,
+			  bool bNeedAck,
+			  bool bDisCRC,
+			  struct ieee80211_hdr *hdr,
+			  unsigned short wCurrentRate,
+			  unsigned char byFBOption);
 
 static void s_vGenerateTxParameter(struct vnt_private *pDevice,
 				   unsigned char byPktType,
@@ -912,7 +912,7 @@ s_vGenerateTxParameter(
 			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
 			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
 
-			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
+			fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
 		} else {/* RTS_needless, PCF mode */
 			struct vnt_rrv_time_cts *buf = pvRrvTime;
 
@@ -931,7 +931,7 @@ s_vGenerateTxParameter(
 			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
 
 			/* Fill RTS */
-			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
+			fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
 		} else if (!pvRTS) {/* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
@@ -945,7 +945,7 @@ s_vGenerateTxParameter(
 			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
 
 			/* Fill RTS */
-			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
+			fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
 		} else { /* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
-- 
2.34.1

