Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1456C8848
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjCXWX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjCXWXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:23:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F747DAD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:23:15 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l27so3182465wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679696594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmc+Yh3XTUiALV4q5vVltlntUVE9IZwmAKsrbcMIn8E=;
        b=aWxGS61g8iTvs/jCZu60IzW+7tzq2LyJwA0C2wj/JTxwMq7Zs2VTNdvqTZm1/tLESI
         2DxRQ9Ly/VdxXHQ7iMJNeq2pepUZjJfPCpZOCMvhGkkcREVN3p/UaM+Et4yGJ9EgCu4A
         JXzj5Ls3pKklSFuzkxyx+g16m5Fffi78htPhx/CmUY3dSfLmM6T0YIaqTFR/Atr3+Uko
         vg48Kr2FwUpUvVtkDn2zXWe4pS6NW0CEp00DyTa7XZDL4bFYliRNszXVieJ6Yu/jG1IZ
         LvqIhyP5Tl6LstMdGT7/ylh1oxPdQjkLmR/US43/cX4gPoHbrBIhG6O6KMc34xt5qa27
         xfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679696594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmc+Yh3XTUiALV4q5vVltlntUVE9IZwmAKsrbcMIn8E=;
        b=rDBJb2XgkcwOLvOZTGa14v82YnIpNuacael19uXWHUz9ykT6MPX1GKqHBOKbqi9gJ1
         E39tX3NEcOSvrCEmNswQp1KF43l4drVBe7CTPV8CJ3+FsW7TcvY89X60EqpLx4gqGxzG
         WsgZrBblb6SVLxCYX08+qdr1BAK6cYGL1PQtxaROlgihkqC2nJXw8d2u3YdxKpZSf4PU
         5PdCvb5NPv4CYdNmhWALy4CyZELwhAN40hLgabHuU3bEWzSu3dsEcR2Z/2xoi3Rwt9gi
         G4Vc4gWUOYOuj35jHWO1jIaGJNFHk7tTDNwTIX2HVuLuZobwZdWqUO8qHtAvOB2MznbP
         3VAg==
X-Gm-Message-State: AAQBX9dCq9wi8i7wzVpjKaB6qrG9BzRK9NpjYpaH8tT5vbh/twISwvYq
        0U2cz8EHiCdblO4GW3fEKwYW3ijbSNPKCg==
X-Google-Smtp-Source: AKy350bJk9DDB8yV4yakIr9ZUylqIt7VlEZDFfJEKYzJL+ZwIN5MTOHwRARrBy5IS3fsalvCk7gmzw==
X-Received: by 2002:adf:ed04:0:b0:2d7:82ee:c9ce with SMTP id a4-20020adfed04000000b002d782eec9cemr4236374wro.20.1679696594343;
        Fri, 24 Mar 2023 15:23:14 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id m8-20020a5d4a08000000b002c3f03d8851sm19161446wrq.16.2023.03.24.15.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 15:23:13 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] staging: rtl8192e: remove blank lines after '{'
Date:   Sat, 25 Mar 2023 03:23:04 +0500
Message-Id: <e7cd8152e6986d361f81289868040889224bd1bf.1679696291.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1679696291.git.kamrankhadijadj@gmail.com>
References: <cover.1679696291.git.kamrankhadijadj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary blank lines after an open brace to adhere to the
Linux kernel coding-style guidelines. These issues are reported by
checkpatch.pl

"CHECK: Blank lines aren't necessary after an open brace '{'"

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index f627dfe66d90..b649d02dc5c8 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1167,7 +1167,6 @@ static int rtllib_rx_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 	if (crypt && !(fc & RTLLIB_FCTL_WEP) && !ieee->open_wep) {
 		if (/*ieee->ieee802_1x &&*/
 		    rtllib_is_eapol_frame(ieee, skb, hdrlen)) {
-
 			/* pass unencrypted EAPOL frames even if encryption is
 			 * configured
 			 */
@@ -1207,7 +1206,6 @@ static void rtllib_rx_check_leave_lps(struct rtllib_device *ieee, u8 unicast,
 				      u8 nr_subframes)
 {
 	if (unicast) {
-
 		if (ieee->state == RTLLIB_LINKED) {
 			if (((ieee->link_detect_info.NumRxUnicastOkInPeriod +
 			    ieee->link_detect_info.NumTxOkInPeriod) > 8) ||
@@ -1552,7 +1550,6 @@ static u8 qos_oui[QOS_OUI_LEN] = { 0x00, 0x50, 0xF2 };
 static int rtllib_verify_qos_info(struct rtllib_qos_information_element
 				     *info_element, int sub_type)
 {
-
 	if (info_element->elementID != QOS_ELEMENT_ID)
 		return -1;
 	if (info_element->qui_subtype != sub_type)
@@ -2696,7 +2693,6 @@ static void rtllib_rx_mgt(struct rtllib_device *ieee,
 		ieee->last_rx_ps_time = jiffies;
 
 	switch (WLAN_FC_GET_STYPE(le16_to_cpu(header->frame_ctl))) {
-
 	case RTLLIB_STYPE_BEACON:
 		netdev_dbg(ieee->dev, "received BEACON (%d)\n",
 			   WLAN_FC_GET_STYPE(le16_to_cpu(header->frame_ctl)));
-- 
2.34.1

