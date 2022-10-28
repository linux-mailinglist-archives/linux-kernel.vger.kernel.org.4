Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80F8611978
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiJ1Rlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiJ1Rlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:41:36 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBE11C8429
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:41:23 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id d25so9012405lfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEOapcrR5Veb7GbTiYOEkCV8uEMgF6llwclPcWMWYnY=;
        b=WwpzTb+iSq6Qsli6fJJxH5RQUDLYQyiO/o/MYSY7N6z6Jgy7MnZDUMas5mg81ALVRU
         U9T+vGeMiZ9roVRA2qpTydAQIdk1t3tDGdzk9YwOlbQeoD0kTTQh4t9LEDoNMx0uPYUh
         Vblgj/rFbI49KtSCueFoLBsrw8IVvjT3ZndLVhm3vVKyjMlTei/GDb+Cz3CGMz+IC2fp
         NemWWWwFPvEbcIEKDuQs/UI5ENn0OH0zOgeEYOkVuuPThVMmaT+m1G58U4z/3PUgaf7q
         1lV10rq4luUROPgOkU5Xx4CNlewTfleno1ZSAKecNSfrCFK3sttSgyBc2HjEVgGNboCQ
         kPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEOapcrR5Veb7GbTiYOEkCV8uEMgF6llwclPcWMWYnY=;
        b=tjXYsNwlTyvZHvtKS0emYzo/5rDxJ8hDgBOPkKeA+h84BsonNnL3P+Dje1mJpH0Hb0
         bIXtvRqnC4cmEzlc1JrMy0aQUjsNdd28Y0lmEmWSE3NiATt2IbJ0lYfUIIEM6osIT8bA
         tTpQZQiglfVWE+0/8OUui3j55U4PWyJKiQZmd3wd9pyZTn6EXwsiwQ6cgU5ZePl5gsda
         TJzvkmU9/aNb7OzmCAfn5W3YAjwTKOHzLlsNJH+vYwyZo2z1wEfgDzfx/M2AUaclIArz
         Fgu2y4YPJMCMid6bZzZ6aOHlLTUI/qUW19bA63BiA5QmbXmZ4aa7LXEu/Smg/E4FmfD9
         WR8Q==
X-Gm-Message-State: ACrzQf04wVrNQcRjjDeMS/+0l7Qv8GDiyK9o42bPUpQoa8ZzHBVYp1d6
        pdQkoZwHb18tTLVU6Oil0lU=
X-Google-Smtp-Source: AMsMyM747L5KEH03pFOFU1iKA7oJhO99+AfcwLCrcR1oGZdD9jQGbBCHe3gO74b5rWsGQv8HY23AUw==
X-Received: by 2002:ac2:4a6f:0:b0:4b0:1e5a:9287 with SMTP id q15-20020ac24a6f000000b004b01e5a9287mr203825lfp.156.1666978881713;
        Fri, 28 Oct 2022 10:41:21 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id s2-20020a2eb622000000b0026dfdcbccdasm725322ljn.14.2022.10.28.10.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 10:41:21 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v8 6/6] staging: vt6655: fix lines of code ending in a '('
Date:   Fri, 28 Oct 2022 17:40:58 +0000
Message-Id: <45d10b850cef8ed5db7042311dbe19bcba185396.1666978292.git.tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666978292.git.tanjubrunostar0@gmail.com>
References: <cover.1666978292.git.tanjubrunostar0@gmail.com>
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

fix checkpatch errors related to lines ending with a '(' by
joining some lines of code and indenting properly to increase
visibility

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 6a4fcb16b674..d585435520b3 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -1118,7 +1118,7 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *pDevice,
 				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_cts));
 				pvRTS = NULL;
-				pvCTS = (void *) (pbyTxBufferAddr + wTxBufSize +
+				pvCTS = (void *)(pbyTxBufferAddr + wTxBufSize +
 						  sizeof(struct vnt_rrv_time_cts) + cbMICHDR);
 				pvTxDataHd = (void *)(pbyTxBufferAddr + wTxBufSize +
 						      sizeof(struct vnt_rrv_time_cts) + cbMICHDR +
@@ -1296,10 +1296,8 @@ static void vnt_fill_txkey(struct ieee80211_hdr *hdr, u8 *key_buffer,
 		ether_addr_copy(mic_hdr->addr2, hdr->addr2);
 		ether_addr_copy(mic_hdr->addr3, hdr->addr3);
 
-		mic_hdr->frame_control = cpu_to_le16(
-			le16_to_cpu(hdr->frame_control) & 0xc78f);
-		mic_hdr->seq_ctrl = cpu_to_le16(
-				le16_to_cpu(hdr->seq_ctrl) & 0xf);
+		mic_hdr->frame_control = cpu_to_le16(le16_to_cpu(hdr->frame_control) & 0xc78f);
+		mic_hdr->seq_ctrl = cpu_to_le16(le16_to_cpu(hdr->seq_ctrl) & 0xf);
 
 		if (ieee80211_has_a4(hdr->frame_control))
 			ether_addr_copy(mic_hdr->addr4, hdr->addr4);
@@ -1470,9 +1468,9 @@ static int vnt_beacon_xmit(struct vnt_private *priv,
 
 		/* Get Duration and TimeStampOff */
 		short_head->duration =
-			cpu_to_le16((u16)s_uGetDataDuration(priv, DATADUR_B,
-				    frame_size, PK_TYPE_11A, current_rate,
-				    false, 0, 0, 1, AUTO_FB_NONE));
+			cpu_to_le16((u16)s_uGetDataDuration(priv, DATADUR_B, frame_size,
+							    PK_TYPE_11A, current_rate, false,
+							    0, 0, 1, AUTO_FB_NONE));
 
 		short_head->time_stamp_off =
 				vnt_time_stamp_off(priv, current_rate);
@@ -1486,9 +1484,9 @@ static int vnt_beacon_xmit(struct vnt_private *priv,
 
 		/* Get Duration and TimeStampOff */
 		short_head->duration =
-			cpu_to_le16((u16)s_uGetDataDuration(priv, DATADUR_B,
-				    frame_size, PK_TYPE_11B, current_rate,
-				    false, 0, 0, 1, AUTO_FB_NONE));
+			cpu_to_le16((u16)s_uGetDataDuration(priv, DATADUR_B, frame_size,
+							    PK_TYPE_11B, current_rate, false,
+							    0, 0, 1, AUTO_FB_NONE));
 
 		short_head->time_stamp_off =
 			vnt_time_stamp_off(priv, current_rate);
-- 
2.34.1

