Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080B960EFC6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbiJ0GCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiJ0GCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:02:08 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D093615B136
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:01:57 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id r12so754490lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9xsV8c/rBmZYI1wjay++VlFqX2UEzreuAkhbJUXoYI=;
        b=JMZAloMRk2by2rzB7NUmodf0Q8FsWdDH9nNKiIiePzMYEfaWDVcea6FldIpZX/UWYf
         sRKM8rAolEc99Jp+inw+wJxfrXUFwRO0vcyTAxCsUv0vbs+z4TLcuC6bVGHyZVFuZDZL
         auP8/B64qtgHauoaho4zT6M/CIfKBIF7oCAKrr4AQlY3EQ/aOEJYqGMcL0BOVLNFLydq
         Yqp6kPn2z/nqBCwetzeorKGq+69xemGQofS2iN1Nf2PuGxlY4pXiLDWd22s4Z4IB0+KO
         oQdvoV2RRwZA/LIBZZkz4XEGeSIAYIXVX/N7OY3GF8RRN7Ymft0OOxJCLGxgCF6Zxev3
         p3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9xsV8c/rBmZYI1wjay++VlFqX2UEzreuAkhbJUXoYI=;
        b=kERYAOsW5NJU7pNnXqL1lg29C8RUW+jXkgrS9eONdf0RP3KQMLcTjvzejH1jdgwXgP
         4oDjM8bWyWSgGYLbc5KGCqcsPkmrpHs/tVPJRwK+7YRqFBJwuVbkZhPij/sWe5OcrQfZ
         lZK1MrIjOtUewqtmYI+DV3dwRl5BmIIPLQsc7dyB6hS1HQXj0mOFjrpo/kOAU0IBfZGU
         TVvh6GS7pK6W27VukDRdUleOiC1EUeDLliCTm8f4m9efuwmuDYfAh2Y/M+hCuvqaeEqW
         +okc0fpcIDQRty+JB8t9TjxBR6AOgy8T2cCUIcsVlgaevfVsNu0yD3ey7363z6Tf3r3+
         G8BA==
X-Gm-Message-State: ACrzQf2sA25AI/8tsdjHPB1k7wI/FBJj7cvXwsFUgUgDb8NuOrYPrJus
        OEj/M0WqQetKLCBJrN5OpAU=
X-Google-Smtp-Source: AMsMyM5E3Q+OqCqhnawOgnNaEijCkJoaDiGZc87C+nDk2KJY2DZAXJzpEczwkEeMgsvWVGuYYrK5Lw==
X-Received: by 2002:a05:6512:3d1d:b0:4a2:588b:d78 with SMTP id d29-20020a0565123d1d00b004a2588b0d78mr19387598lfv.375.1666850515468;
        Wed, 26 Oct 2022 23:01:55 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id j3-20020a056512344300b0049fff3f645esm61537lfr.70.2022.10.26.23.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 23:01:55 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v5 4/6] staging: vt6655: refactor code in s_vGenerateTxParameter
Date:   Thu, 27 Oct 2022 06:01:28 +0000
Message-Id: <f3e719f7ddc72ebc9fd100c66581017926450762.1666849707.git.tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666849707.git.tanjubrunostar0@gmail.com>
References: <cover.1666849707.git.tanjubrunostar0@gmail.com>
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

