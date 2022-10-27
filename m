Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C6A60F32F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiJ0JGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbiJ0JGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:06:37 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB0CAE85B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:06:21 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id r12so1481238lfp.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUjB/LIeIaF8ms/g2Nbld44QrRlq9IWMpRhgl/Fq6KI=;
        b=ZGJYKQQOLgntzby285FezJsUmL7FrUF/hukJJQ65lTw7VE2COSwHCFsJ7z38tqxWKQ
         nvCsHNF1pMLTsHoRsy0xhJ4ep9wZZMQlmsL6ZpBjsciqIC5JqhcAStIO9vr7uppYBieb
         IPgwvM99ulOAMWzz6DDP88dVzPQadoZycAVX9on4vfLsueyghYwAbuB7NusuFUpSxwo3
         HP89p5h0pCwjL7iPikDcEvjj0r6hhra39H17zDLgs0/tvlBmzS4jJzbn171vpxooYYOX
         HZLtS2hmjav1pCnWfeiqWfFXe5PW4FH4L8xoepwCKjNh6JnE4E6mWH7dB4gc/HgdgLny
         hRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUjB/LIeIaF8ms/g2Nbld44QrRlq9IWMpRhgl/Fq6KI=;
        b=ccIMExvgmPyGnsTpVowaBDKIaNdBhr6Vh7ziHVkcvnqHYU4rKJRyyLZOIBQpu2MvPq
         542aqYYOTX54LoYXhGY64tgBvWOh5WLx9DBgJoAdx14COTbFgT/hM5jrskod9XrELVJE
         /63fpzV5I4OtryNey/4IypDlDO1+jm/MejkRzUlau6/6UNl4g1fTcM0psdx4BaHQ1aFb
         deecmNFYhkuJ1YkUtLrDczSzurbvLgx0FdAJgwYZqCHGC4zs9y1nueBrN4QxYN0V5cw3
         Ib/3kcJF3mdodKf2alNaExw9CJbdwqWsewm+OyNAsVPwR/55/X7de4PCt53TLfXN36ui
         5XIg==
X-Gm-Message-State: ACrzQf2gvxBjnHNWiEqn/65o7JJ8WFkKNB640jvHFeND6vapWKag1gnT
        t4o8QLTOLseR9i3zK5rM2A6J2CQgkaYeig==
X-Google-Smtp-Source: AMsMyM7hEnHdVIG4FGGkxWCWOfQrxt6tcfpQlOXhZS0x/MehI+RMklhYsj8gbYqTKEESP4saVH+vbw==
X-Received: by 2002:ac2:5475:0:b0:4a2:4f8f:f01d with SMTP id e21-20020ac25475000000b004a24f8ff01dmr17030324lfn.386.1666861579727;
        Thu, 27 Oct 2022 02:06:19 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id d9-20020a2e96c9000000b0026f9cb6d10fsm153273ljj.45.2022.10.27.02.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 02:06:19 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v6 6/6] staging: vt6655: refactor code to avoid a line ending in '('
Date:   Thu, 27 Oct 2022 09:05:55 +0000
Message-Id: <43693eef6afe24973ed28f8b26e2d5117f5d35f1.1666849707.git.tanjubrunostar0@gmail.com>
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

join unnecessary split lines to avoid them ending in '('

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

