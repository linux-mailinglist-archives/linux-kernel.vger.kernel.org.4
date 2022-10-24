Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4954D609E79
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiJXKCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJXKC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:02:26 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7658A5A144
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 03:02:24 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g12so5331193lfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 03:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9xsV8c/rBmZYI1wjay++VlFqX2UEzreuAkhbJUXoYI=;
        b=LyD7DulQtLdUdHohPQKOb++7jgZC7o1sGM7lrig+76akqITG0iDH7FAP3HkCdQlzT1
         iTJMlw2vI61xH4z7Bc6fglS78X6RdvkVHvKmXDR6gkwaVuTkw7Ux3NrJb3T9f/ABOiLN
         e8PakEHHEJkZSw4tZo3TwsM4Ns/DMufyTMcsBAUGVG5MppUie9kUbuVgxJBYR13oYOk4
         XsmpO7N07jxqeyNAAedz5MlmlYn1Ic6ELmri0ySxcnL2ZYEqSCKLpvZrS7vyYIMkNYoO
         nRi7i53jS4oxBPa6OcQHApRUno8R2HvAS3U1E4hWdptm4qjQl1yeyDj4i0TtyPEd6dck
         SuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9xsV8c/rBmZYI1wjay++VlFqX2UEzreuAkhbJUXoYI=;
        b=I/OezysgSi/jxd6rZVH7txyJjJMsgO69QFgXAkSaWyp+Z7SvlawxJmaa+/rWyvzZzC
         9gGdHElsIFfBz0u57Htv9jGurAE3iZ2shylrByRG1S+JO4FWMn/mPwwgLtfNFkVzb7Bf
         RetJesUSniCqmuenlBENxvifHinOD6L71jOFSSWV0HVFeR/3Et/2ZiFTxS6Snf5CmvBw
         JaO163e6u/jWfQQ9pT2a32CljPcaCQBZ24g9KoY5XuuCMvOWWcpyoi/SadZPe4a4MgC1
         r5EB6o/M0CrFpoAEUCaqXfl5xLhkc28JQmMyUCc1lMftbZEVDc0jl1xLb+xvXe2mVLMq
         imgA==
X-Gm-Message-State: ACrzQf1LhTMdooWj1SqCjknhySq8CIXvB2eFwQi/SncU54f8MKKKbNci
        SWcbPfK1+9I6YjkNNXGkq1Y=
X-Google-Smtp-Source: AMsMyM5FUSg0LYKtRrnGv2YwECH7NXgHhIG6IUwvlYJcnAJh1JSn/A8P3OtdF4Le2RR2dOqz94F/Ig==
X-Received: by 2002:a05:6512:108b:b0:4a2:a253:5a90 with SMTP id j11-20020a056512108b00b004a2a2535a90mr11868424lfg.593.1666605743714;
        Mon, 24 Oct 2022 03:02:23 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id s9-20020a2eb629000000b0026dfbdfc1ddsm4896832ljn.11.2022.10.24.03.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 03:02:23 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v4 4/6] staging: vt6655: refactor long lines of code in s_vGenerateTxParamete
Date:   Mon, 24 Oct 2022 10:01:50 +0000
Message-Id: <f3e719f7ddc72ebc9fd100c66581017926450762.1666605225.git.tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666605225.git.tanjubrunostar0@gmail.com>
References: <cover.1666605225.git.tanjubrunostar0@gmail.com>
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

fix checkpatch errors by refactoring long lines of code in the function: s_vGenerateTxParameter

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 68 ++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 7b6571ba7c36..475526b73e1a 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -834,7 +834,9 @@ static void s_vFillCTSHead(struct vnt_private *pDevice,
 	}
 
 	if (byPktType == PK_TYPE_11GB || byPktType == PK_TYPE_11GA) {
-		if (byFBOption != AUTO_FB_NONE && uDMAIdx != TYPE_ATIMDMA && uDMAIdx != TYPE_BEACONDMA) {
+		if (byFBOption != AUTO_FB_NONE &&
+		    uDMAIdx != TYPE_ATIMDMA &&
+		    uDMAIdx != TYPE_BEACONDMA) {
 			/* Auto Fall back */
 			struct vnt_cts_fb *buf = pvCTS;
 			/* Get SignalField, ServiceField & Length */
@@ -873,7 +875,11 @@ static void s_vFillCTSHead(struct vnt_private *pDevice,
 
 			ether_addr_copy(buf->data.ra,
 					pDevice->abyCurrentNetAddr);
-		} else { /* if (byFBOption != AUTO_FB_NONE && uDMAIdx != TYPE_ATIMDMA && uDMAIdx != TYPE_BEACONDMA) */
+		} else {
+			/* if (byFBOption != AUTO_FB_NONE &&
+			 * uDMAIdx != TYPE_ATIMDMA &&
+			 * uDMAIdx != TYPE_BEACONDMA)
+			 */
 			struct vnt_cts *buf = pvCTS;
 			/* Get SignalField, ServiceField & Length */
 			vnt_get_phy_field(pDevice, uCTSFrameLen,
@@ -959,50 +965,70 @@ static void s_vGenerateTxParameter(struct vnt_private *pDevice,
 			/* Fill RsvTime */
 			struct vnt_rrv_time_rts *buf = pvRrvTime;
 
-			buf->rts_rrv_time_aa = get_rtscts_time(pDevice, 2, byPktType, cbFrameSize, wCurrentRate);
-			buf->rts_rrv_time_ba = get_rtscts_time(pDevice, 1, byPktType, cbFrameSize, wCurrentRate);
-			buf->rts_rrv_time_bb = get_rtscts_time(pDevice, 0, byPktType, cbFrameSize, wCurrentRate);
-			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
-			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
-
-			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
+			buf->rts_rrv_time_aa = get_rtscts_time(pDevice, 2, byPktType, cbFrameSize,
+							       wCurrentRate);
+			buf->rts_rrv_time_ba = get_rtscts_time(pDevice, 1, byPktType, cbFrameSize,
+							       wCurrentRate);
+			buf->rts_rrv_time_bb = get_rtscts_time(pDevice, 0, byPktType, cbFrameSize,
+							       wCurrentRate);
+			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize,
+								wCurrentRate, bNeedACK);
+			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize,
+								pDevice->byTopCCKBasicRate,
+								bNeedACK);
+
+			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
+				       psEthHeader, wCurrentRate, byFBOption);
 		} else {/* RTS_needless, PCF mode */
 			struct vnt_rrv_time_cts *buf = pvRrvTime;
 
-			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
-			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
-			buf->cts_rrv_time_ba = get_rtscts_time(pDevice, 3, byPktType, cbFrameSize, wCurrentRate);
+			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize,
+								wCurrentRate, bNeedACK);
+			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize,
+								pDevice->byTopCCKBasicRate,
+								bNeedACK);
+			buf->cts_rrv_time_ba = get_rtscts_time(pDevice, 3, byPktType, cbFrameSize,
+							       wCurrentRate);
 
 			/* Fill CTS */
-			s_vFillCTSHead(pDevice, uDMAIdx, byPktType, pvCTS, cbFrameSize, bNeedACK, bDisCRC, wCurrentRate, byFBOption);
+			s_vFillCTSHead(pDevice, uDMAIdx, byPktType, pvCTS, cbFrameSize, bNeedACK,
+				       bDisCRC, wCurrentRate, byFBOption);
 		}
 	} else if (byPktType == PK_TYPE_11A) {
 		if (pvRTS) {/* RTS_need, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
-			buf->rts_rrv_time = get_rtscts_time(pDevice, 2, byPktType, cbFrameSize, wCurrentRate);
-			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
+			buf->rts_rrv_time = get_rtscts_time(pDevice, 2, byPktType, cbFrameSize,
+							    wCurrentRate);
+			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize,
+							      wCurrentRate, bNeedACK);
 
 			/* Fill RTS */
-			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
+			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
+				       psEthHeader, wCurrentRate, byFBOption);
 		} else if (!pvRTS) {/* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
-			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11A, cbFrameSize, wCurrentRate, bNeedACK);
+			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11A, cbFrameSize,
+							      wCurrentRate, bNeedACK);
 		}
 	} else if (byPktType == PK_TYPE_11B) {
 		if (pvRTS) {/* RTS_need, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
-			buf->rts_rrv_time = get_rtscts_time(pDevice, 0, byPktType, cbFrameSize, wCurrentRate);
-			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
+			buf->rts_rrv_time = get_rtscts_time(pDevice, 0, byPktType, cbFrameSize,
+							    wCurrentRate);
+			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize,
+							      wCurrentRate, bNeedACK);
 
 			/* Fill RTS */
-			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
+			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
+				       psEthHeader, wCurrentRate, byFBOption);
 		} else { /* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
-			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
+			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize,
+							      wCurrentRate, bNeedACK);
 		}
 	}
 }
-- 
2.34.1

