Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DEA5BB9DA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 20:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiIQSQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 14:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiIQSQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 14:16:32 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587422E9FB
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 11:16:31 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x1so24360537plv.5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 11:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=RM/MaJxI7eoH4wnvJNEXDmXgONuOyNDJ2jEkwiNVsis=;
        b=A4FYl4GBOaQ5yCxsCOp1T3po6mv1ywVbb5AmOO9sgSOAqbsQr2gCiLAKvEYgDXS/75
         VlIVzpT00T2nd97MCukyNWNNeibQwGwlK1EEhg/hyVHqITP0LqD35Dge+9qWCQ+ztbij
         WU1NxEvBADx4x9+5I+s5jstOJY+3eua/9XVU1NvB9Ci4mvCku8WKVj8IyBNjvMeL0yH8
         gN1zTAICvaAVAQFeUP+4Ld7gk9LOLApzjottHsz51HogFOTxRrvmv7fmsbKNCn5TqSmK
         BmULaPrv6wIVXPIj89tnObunxSQpsHTttHq6GEl84kGtMp270lOPF+t/jcomrn4BZDql
         fI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=RM/MaJxI7eoH4wnvJNEXDmXgONuOyNDJ2jEkwiNVsis=;
        b=fgbQSprK0u4qWz4zFDftd+sQHHTJeYQYisxtU7Pu8M/IjswNtp9iQKP8onJi3EBl4g
         VyYFQFoOVSbJYuAWHgCLV2vjh/3fsMfQmJmILDPp4A6Hpid8lzks55K1C/x7fQKidXAG
         RXjhzZGZXYB09fDaoNGHdy4znHzI/NMbvl1XId2xbRZqLAZzbxyaJlejb9evYcIFVu+1
         gUqNd1tzmiexHQzfUCYYKNXPe5i4+ETKX5yLCLVMqNkgejJn0GsbA8RGknIGNx6USKSL
         yUFMQhhZ0gWBsfhA84W1E1YzOEAqZdF+6fQbmpEwpT5FYmjQ7Px+mxFEioRp52Y8Y4WH
         6xvA==
X-Gm-Message-State: ACgBeo2a5zD+6pB5AUu8nZuSjTqwjmuUm45So/2ezJGKOS8sJ3GRNDLo
        Gl+np7QLO+Ea9MHBKHWtxEU=
X-Google-Smtp-Source: AA6agR53kLzr7bxkOBBiiDIlpEtJBfGaqh5yhB60T36B+kwycRbKy4uSe/Zv9cuSgpbnv8+utox4Ew==
X-Received: by 2002:a17:90a:203:b0:200:8df6:84c with SMTP id c3-20020a17090a020300b002008df6084cmr21985905pjc.24.1663438590753;
        Sat, 17 Sep 2022 11:16:30 -0700 (PDT)
Received: from uftrace.. ([14.5.161.231])
        by smtp.gmail.com with ESMTPSA id lj12-20020a17090b344c00b001fd9c63e56bsm3529678pjb.32.2022.09.17.11.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 11:16:30 -0700 (PDT)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Fabio Aiuto <fabioaiuto83@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH 2/2] staging: rtl8723bs: Insert blank line after declarations
Date:   Sun, 18 Sep 2022 03:16:20 +0900
Message-Id: <20220917181620.3237192-1-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes checkpatch warning as follows:

  WARNING: Missing a blank line after declarations

Signed-off-by: Kang Minchul <tegongkang@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index ad6fb6c3d1f0..dade4d07662b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -245,6 +245,7 @@ u32 rtw_free_uc_swdec_pending_queue(struct adapter *adapter)
 {
 	u32 cnt = 0;
 	union recv_frame *pending_frame;
+
 	while ((pending_frame = rtw_alloc_recvframe(&adapter->recvpriv.uc_swdec_pending_queue))) {
 		rtw_free_recvframe(pending_frame, &adapter->recvpriv.free_recv_queue);
 		cnt++;
@@ -397,6 +398,7 @@ static union recv_frame *decryptor(struct adapter *padapter, union recv_frame *p
 
 	if (prxattrib->encrypt > 0) {
 		u8 *iv = precv_frame->u.hdr.rx_data+prxattrib->hdrlen;
+
 		prxattrib->key_index = (((iv[3])>>6)&0x3);
 
 		if (prxattrib->key_index > WEP_KEYS) {
@@ -882,6 +884,7 @@ static signed int sta2ap_data_frame(struct adapter *adapter, union recv_frame *p
 		}
 	} else {
 		u8 *myhwaddr = myid(&adapter->eeprompriv);
+
 		if (memcmp(pattrib->ra, myhwaddr, ETH_ALEN)) {
 			ret = RTW_RX_HANDLED;
 			goto exit;
@@ -1125,6 +1128,7 @@ static union recv_frame *recvframe_chk_defrag(struct adapter *padapter, union re
 	psta = rtw_get_stainfo(pstapriv, psta_addr);
 	if (!psta) {
 		u8 type = GetFrameType(pfhdr->rx_data);
+
 		if (type != WIFI_DATA_TYPE) {
 			psta = rtw_get_bcmc_stainfo(padapter);
 			pdefrag_q = &psta->sta_recvpriv.defrag_q;
@@ -1207,6 +1211,7 @@ static signed int validate_recv_mgnt_frame(struct adapter *padapter, union recv_
 	{
 		/* for rx pkt statistics */
 		struct sta_info *psta = rtw_get_stainfo(&padapter->stapriv, GetAddr2Ptr(precv_frame->u.hdr.rx_data));
+
 		if (psta) {
 			psta->sta_stats.rx_mgnt_pkts++;
 			if (GetFrameSubType(precv_frame->u.hdr.rx_data) == WIFI_BEACON)
@@ -1480,6 +1485,7 @@ static signed int validate_recv_frame(struct adapter *adapter, union recv_frame
 		retval = validate_recv_data_frame(adapter, precv_frame);
 		if (retval == _FAIL) {
 			struct recv_priv *precvpriv = &adapter->recvpriv;
+
 			precvpriv->rx_drop++;
 		} else if (retval == _SUCCESS) {
 #ifdef DBG_RX_DUMP_EAP
-- 
2.34.1

