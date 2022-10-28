Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13C2611E1E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 01:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJ1X0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 19:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJ1X0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 19:26:18 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2927E24F7A3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:26:12 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h12so3403917ljg.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQe+2hHBmcm3Iek0E2MIyCyrx7Z86fYMUFGwOxoXr6Q=;
        b=ePqdSGl8r9FllmjwNWoh573XDSnzK5I4nCmlEZgthvcPl3/jmS+uN51B35UUNj5mA5
         HEDLMpcgrrnXIPwv+nVDySujRXnKdJF9g/A2/z+5xXf2xfqof6IB7YPPhirTBwspK5rp
         XkF+4EhniTIsTYYripf+Tu+xezvx2TGpj9mBCR8QCjwhC7ZV7tV7UstssQ13nDD21+Ae
         nuW++XfYTYKdl9IGzGJDF4fLMKjvaVR5AXtUKtePoU1f4uIj5pjTs1+DantKZSI/WeqO
         IMRbbH1OvPu2Mqm+QglDWI+oKFVF0nOfdOa4Vf1L8ViVMLEIynbaoBynd4i2HJ8trcB4
         IsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQe+2hHBmcm3Iek0E2MIyCyrx7Z86fYMUFGwOxoXr6Q=;
        b=ODAId5UqVFEhxbf4NC4/GhCnl7lDhgT6/ZMT0DbIw1Or1YKEi6aGh/mW0uljqgj0zm
         OJvw4rPRg7d2r0ADYJGKNn03ADJ7E62Scz2zksczZN4IY1N5ZYHyebvHDQB38toItzth
         xy001iBt78gOxzbgCCvy6MyrptG68d14prNpjJOzbItS9mm2t1EzmDwgom3CrHnaDsJP
         JQNc0AJ687WGFlqsfTb77JVW8yWLi+9nXErN5VIGOaQBhL5Cs4Cv18t/glr2k7gEm7EZ
         Cf8hxQKavJLfkCvYn4s+iP7PBAZ0xJfzoqKtYeXUMbQZYd0Ds3ajX927gw3sWHHbnEPk
         uqUg==
X-Gm-Message-State: ACrzQf0Ov5pPMVr6Fn81T6ElpNpOdFpZ+X2cgmgV4jCmEVHWGs3+1XnT
        9ShkRef2SG/KIMXxynXenr1BPsRXUqqYMA==
X-Google-Smtp-Source: AMsMyM5LWqv2r3+h4McwbMrvVf2OYT2+ybq+d8uGTOBfnHdoFM7as9mEJe8wgtBxk23YuZbKZdW+9w==
X-Received: by 2002:a05:651c:511:b0:26f:dfb2:eeef with SMTP id o17-20020a05651c051100b0026fdfb2eeefmr654174ljp.343.1666999570400;
        Fri, 28 Oct 2022 16:26:10 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id s2-20020a056512202200b0049aa20af00fsm7064lfs.21.2022.10.28.16.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 16:26:10 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v9 6/6] staging: vt6655: fix lines of code ending in a '('
Date:   Fri, 28 Oct 2022 23:23:27 +0000
Message-Id: <45d10b850cef8ed5db7042311dbe19bcba185396.1666995639.git.tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666995639.git.tanjubrunostar0@gmail.com>
References: <cover.1666995639.git.tanjubrunostar0@gmail.com>
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

fix checkpatch errors related to lines ending with a '(' 
by joining some lines of code and indenting properly to improve
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

