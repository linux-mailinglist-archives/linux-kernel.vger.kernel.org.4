Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BFB609E76
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiJXKCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiJXKCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:02:20 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60E55A144
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 03:02:12 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g12so5330390lfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 03:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Mcq4XElldK8n+d5RjVbZo8PZpT7nLSBwi7AAq7x+9Q=;
        b=HsE0mA4YRF+d60FHuzR+bNY90b/LW7majYVX+xOOROK3Z+MKgT7jmevYrqo2wYLoZy
         uf//LgVVDdHQcKYBWTwruvsD7xOrc/NsZA+xrb209tphyEmfhRTeSxYOpbU+dEsJ7w7g
         2PXOGECSaVP98cQ7/VBM5C17duQLdBnbBBTs9B4QscvyNmul/c40bfSGVRd7Eg4NcV4P
         onUBqmmQBHk8mXuAZr7qbWEMY7/Q1E4laD45ClXJDe8ijDnavvSdXEaWg7gPldNyfq50
         DWcDoAy5iAUn36BS/gQmJRe/HMV5jCq3+xgU5dAJg3lLLfmc+4LeWF+Em5eBUnSeLrGW
         BmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Mcq4XElldK8n+d5RjVbZo8PZpT7nLSBwi7AAq7x+9Q=;
        b=0jIKbiKGGhk3xQZ+WqZT7K0760y/0wP3E24V5LJPKuEP4ZOukuQ1oVi2mUk8FZs9YX
         z27QVRBZDM/VNESvh52FmalYhT2mltJ+YQbbc7M5WamUflHGac6n30/puwZuP5NTW275
         Kg1y93IaneNc8piCIdficmvqm4Bko+9JW3aVRng4T7y1KOOWgi1tnxj/wBQOPbJAz7v3
         FGYy/BS2R4caufR6Z8IzkEfpn/s57otU21kLqkbW/n72739OV67ewMFoDZG3m/tMKLr6
         YO5B2aBM4uIqktavW4zndnE784wwcIfKQ/w0bwxA+ew4mXgVcxTrg1WIbmHzqfbhkciy
         3v6A==
X-Gm-Message-State: ACrzQf1v5QkspFwNEhAU66kIg0LYe9hEToltzBgooENTpaQolf17NCbP
        EgrD4up97hg5YT8bgZScxdI=
X-Google-Smtp-Source: AMsMyM7u1jDjv3m3O8AybqRqiuuPlyNqjc/uOhZXhZr3QldHhqEkX7gYnCuc6K6mgt+c2BgBJVZ7Yg==
X-Received: by 2002:ac2:5e70:0:b0:4a9:cd8b:980b with SMTP id a16-20020ac25e70000000b004a9cd8b980bmr3368274lfr.516.1666605732170;
        Mon, 24 Oct 2022 03:02:12 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id s9-20020a2eb629000000b0026dfbdfc1ddsm4896832ljn.11.2022.10.24.03.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 03:02:11 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v4 3/6] staging: vt6655: refactor long lines of code in s_uFillDataHead
Date:   Mon, 24 Oct 2022 10:01:49 +0000
Message-Id: <a2e720d63f4e71dc9b37cf3440831e696c7e2fd1.1666605225.git.tanjubrunostar0@gmail.com>
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

fix checkpatch errors by refactoring long lines of code in the function: s_uFillDataHead

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 97 ++++++++++++++++++++++++-----------
 1 file changed, 67 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 8e56a7ee8035..7b6571ba7c36 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -481,19 +481,28 @@ static __le16 s_uFillDataHead(struct vnt_private *pDevice,
 			} else {
 				/* Get Duration and TimeStamp */
 				buf->duration_a =
-					cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A, cbFrameLength,
-									    byPktType, wCurrentRate, bNeedAck, uFragIdx,
-									    cbLastFragmentSize, uMACfragNum,
+					cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A,
+									    cbFrameLength,
+									    byPktType,
+									    wCurrentRate, bNeedAck,
+									    uFragIdx,
+									    cbLastFragmentSize,
+									    uMACfragNum,
 									    byFBOption));
 				buf->duration_b =
-					cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_B, cbFrameLength,
-									    PK_TYPE_11B, pDevice->byTopCCKBasicRate,
-									    bNeedAck, uFragIdx, cbLastFragmentSize,
-									    uMACfragNum, byFBOption));
+					cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_B,
+									    cbFrameLength,
+									    PK_TYPE_11B,
+									    pDevice->byTopCCKBasicRate,
+									    bNeedAck, uFragIdx,
+									    cbLastFragmentSize,
+									    uMACfragNum,
+									    byFBOption));
 			}
 
 			buf->time_stamp_off_a = vnt_time_stamp_off(pDevice, wCurrentRate);
-			buf->time_stamp_off_b = vnt_time_stamp_off(pDevice, pDevice->byTopCCKBasicRate);
+			buf->time_stamp_off_b = vnt_time_stamp_off(pDevice,
+								   pDevice->byTopCCKBasicRate);
 
 			return buf->duration_a;
 		}
@@ -506,14 +515,29 @@ static __le16 s_uFillDataHead(struct vnt_private *pDevice,
 				  pDevice->byTopCCKBasicRate,
 				  PK_TYPE_11B, &buf->b);
 		/* Get Duration and TimeStamp */
-		buf->duration_a = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A, cbFrameLength, byPktType,
-								      wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
-		buf->duration_b = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_B, cbFrameLength, PK_TYPE_11B,
-								       pDevice->byTopCCKBasicRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
-		buf->duration_a_f0 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F0, cbFrameLength, byPktType,
-									  wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
-		buf->duration_a_f1 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F1, cbFrameLength, byPktType,
-									 wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
+		buf->duration_a = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A,
+								      cbFrameLength, byPktType,
+								      wCurrentRate, bNeedAck,
+								      uFragIdx, cbLastFragmentSize,
+								      uMACfragNum, byFBOption));
+		buf->duration_b = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_B,
+								      cbFrameLength, PK_TYPE_11B,
+								      pDevice->byTopCCKBasicRate,
+								      bNeedAck, uFragIdx,
+								      cbLastFragmentSize,
+								      uMACfragNum, byFBOption));
+		buf->duration_a_f0 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F0,
+									 cbFrameLength, byPktType,
+									 wCurrentRate, bNeedAck,
+									 uFragIdx,
+									 cbLastFragmentSize,
+									 uMACfragNum, byFBOption));
+		buf->duration_a_f1 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F1,
+									 cbFrameLength, byPktType,
+									 wCurrentRate, bNeedAck,
+									 uFragIdx,
+									 cbLastFragmentSize,
+									 uMACfragNum, byFBOption));
 
 		buf->time_stamp_off_a = vnt_time_stamp_off(pDevice, wCurrentRate);
 		buf->time_stamp_off_b = vnt_time_stamp_off(pDevice, pDevice->byTopCCKBasicRate);
@@ -531,12 +555,24 @@ static __le16 s_uFillDataHead(struct vnt_private *pDevice,
 					  byPktType, &buf->a);
 
 			/* Get Duration and TimeStampOff */
-			buf->duration = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A, cbFrameLength, byPktType,
-									    wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
-			buf->duration_f0 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F0, cbFrameLength, byPktType,
-									       wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
-			buf->duration_f1 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F1, cbFrameLength, byPktType,
-										wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
+			buf->duration =
+				cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A,
+								    cbFrameLength, byPktType,
+								    wCurrentRate, bNeedAck,
+								    uFragIdx, cbLastFragmentSize,
+								    uMACfragNum, byFBOption));
+			buf->duration_f0 =
+				cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F0,
+								    cbFrameLength, byPktType,
+								    wCurrentRate, bNeedAck,
+								    uFragIdx, cbLastFragmentSize,
+								    uMACfragNum, byFBOption));
+			buf->duration_f1 =
+				cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F1,
+								    cbFrameLength, byPktType,
+								    wCurrentRate, bNeedAck,
+								    uFragIdx, cbLastFragmentSize,
+								    uMACfragNum, byFBOption));
 			buf->time_stamp_off = vnt_time_stamp_off(pDevice, wCurrentRate);
 			return buf->duration;
 		}
@@ -552,10 +588,11 @@ static __le16 s_uFillDataHead(struct vnt_private *pDevice,
 		} else {
 			/* Get Duration and TimeStampOff */
 			buf->duration =
-				cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A, cbFrameLength, byPktType,
-								    wCurrentRate, bNeedAck, uFragIdx,
-								    cbLastFragmentSize, uMACfragNum,
-								    byFBOption));
+				cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A,
+								    cbFrameLength, byPktType,
+								    wCurrentRate, bNeedAck,
+								    uFragIdx, cbLastFragmentSize,
+								    uMACfragNum, byFBOption));
 		}
 
 		buf->time_stamp_off = vnt_time_stamp_off(pDevice, wCurrentRate);
@@ -573,10 +610,10 @@ static __le16 s_uFillDataHead(struct vnt_private *pDevice,
 	} else {
 		/* Get Duration and TimeStampOff */
 		buf->duration =
-			cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_B, cbFrameLength, byPktType,
-							    wCurrentRate, bNeedAck, uFragIdx,
-							    cbLastFragmentSize, uMACfragNum,
-							    byFBOption));
+			cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_B, cbFrameLength,
+							    byPktType, wCurrentRate, bNeedAck,
+							    uFragIdx, cbLastFragmentSize,
+							    uMACfragNum, byFBOption));
 	}
 
 	buf->time_stamp_off = vnt_time_stamp_off(pDevice, wCurrentRate);
-- 
2.34.1

