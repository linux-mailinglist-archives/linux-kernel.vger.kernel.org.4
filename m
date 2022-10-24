Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AA8609E7B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiJXKC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiJXKCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:02:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15F75A8B8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 03:02:32 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g12so5331875lfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 03:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUjB/LIeIaF8ms/g2Nbld44QrRlq9IWMpRhgl/Fq6KI=;
        b=nq1Q11H5du7gVhunvJWLyKQeRvhmbS4Uz2eP0nz++8feNXQN2mIkyEwEYVGnee7+/6
         3VpVwaBT2Cz4zam03P55KzT/dT1dH03pBYnxAxq/dNZdf4glEPr3uZdPR1Bo7iZjaznR
         Huag/Lr81tqDMleuaKqknAAe64Ieyv4AHKS8o9FR1Ozm/12+A3iLOWHuEPsbajyck4Jd
         LqotuWd1t4g3eW9E5Q22C/kzonAMXOLtWXze5oCw20ZqAcfukUnymG0dkRdIZWB+n7PV
         qCIHscHCngi/YTt+WIEFpC9frMTWgqjXSBcwPimf2rrP8IOhHyLhXriBBMZm5Kkf5RQD
         G4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUjB/LIeIaF8ms/g2Nbld44QrRlq9IWMpRhgl/Fq6KI=;
        b=0kiCJ/QF5w269X4rEOMfsw7+Adu7nQcHJl8VSsnjvwwikG9rPVrxk1HcUxTbnI0XA0
         Qj0XHeda3pDxokaA5UvX+ZVmUkc3MPPLzNK+mlYAa29e78ebzFoZ66Xa9XqhQKfSgg4w
         bkU6G1Gqq/QSJB29WJoR8eGK1fLmgr/OBe8syiMDro2F+py1IUf/6FwxZM83cF5xdeIX
         5oUtgxI4gzV1OJ+2oWDGNbtH4fSZkTgKFGDUtub8G8cIAs1BzTblNvD9ePUmB6qT65OV
         j4s/VhQu1X8stbSf34MLrWpXWbjWFvTZZDxpwPFcPDdywSp+JJ5+kM+V7ISut2A3MDUH
         7yGA==
X-Gm-Message-State: ACrzQf1+OxW7YjE3KEJfOGI7XjbWX/ZzQggWfwumqXisYSVVhbQLHd/i
        2Xi6qtjtiULVL1HDBQHqe5U=
X-Google-Smtp-Source: AMsMyM5ocewgUwZ4FqsY3ThKJ9oXuzldPMVB0iB4wvhmkYKgNq0LB7MdEO0L8TBltMOc1SaxEYilTg==
X-Received: by 2002:ac2:5dc5:0:b0:4a6:3193:582 with SMTP id x5-20020ac25dc5000000b004a631930582mr8585481lfq.236.1666605752278;
        Mon, 24 Oct 2022 03:02:32 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id s9-20020a2eb629000000b0026dfbdfc1ddsm4896832ljn.11.2022.10.24.03.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 03:02:31 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v4 6/6] staging: vt6655: refactor code to avoid a line ending in '('
Date:   Mon, 24 Oct 2022 10:01:52 +0000
Message-Id: <43693eef6afe24973ed28f8b26e2d5117f5d35f1.1666605225.git.tanjubrunostar0@gmail.com>
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

