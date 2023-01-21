Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695F06769B1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 22:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjAUVpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 16:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjAUVpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 16:45:06 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD00C27D7B
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 13:45:04 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id n7so7683257wrx.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 13:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HOjq/wSj4ryBWQj1clILRiIoFo7/d98llcbQTtn/TrQ=;
        b=UjiSJtWuendmrcUDy4s+WBMI9ZMTln9rTrCvhPe0uKtB5fp8RV/sfS2KYikHlBWg8o
         DZ/EWwrdQs7N+3H2qi7Hs7cKFpOTUfmj85rQao0BhDedGbGbVhalkpA1ZTJopIC+mz/X
         JC6GBcNSZEH6aw3IR1q0s0W34Ypj6moddR9hy5rHI20czFVvp8C4wGLz35zQt93ZBy16
         fGmFj72KLKLyEYI5bQXlLnXXOo1B/MdPMl2Fvd1Hjx+LjXM50ooc9zVGSfDg5lG+gIIi
         vO5KBjRgqlblXh7ci6BeQ8m2+bpStovMRR81D3z9SNNf+3WjnYruDU468sWen6s+FdJo
         iksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOjq/wSj4ryBWQj1clILRiIoFo7/d98llcbQTtn/TrQ=;
        b=wpRw5G8zTOXycOYNwwjtD7luV9+AwWOX/Pjmuw9tWknfK9P/jISa6L0PXiOMh5VtCc
         QUMLNbGvheGDGNJh3BEns2SAwA6Cm6H+7h3LdmS3jZz9N3AKrVMMTrMeMGzS//Ewarej
         5BYspBAzoy7VXrRX4VtVLKYn7OHhVgb2JQKb5BFaVPNHLfnY+nNy5eOmgnxnc9Ddwbvu
         SVo/PKXdDscye7VKtGSozcqQSfbxESYYVwMBu6+M4Kqhc65rRmxHsuH+K8tJqtkgw0LK
         U1xFzrxdmBJyq9oigd3GIFotjM4lzFSkbnNKOcmFIfhfY5CPPXUS+wFGdjFAtCmVScGv
         E3QA==
X-Gm-Message-State: AFqh2koeLaz6VZ/ca574hISlrQQOfzwY+LtV2izzuWk2HUbIt7mfYUVu
        QsHEpXMAMF4bv1hj/MGm090=
X-Google-Smtp-Source: AMrXdXuqkjqGrmMBf1DAnqlFfdvPpMtdDPeB59Zf2H4RExxurqZQhJkvcwhfStlPkwGuLSkTODHgDw==
X-Received: by 2002:a5d:5d0c:0:b0:2be:5402:18e7 with SMTP id ch12-20020a5d5d0c000000b002be540218e7mr1675873wrb.5.1674337503058;
        Sat, 21 Jan 2023 13:45:03 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id r11-20020a5d694b000000b002bb28209744sm559375wrw.31.2023.01.21.13.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 13:45:02 -0800 (PST)
Date:   Sat, 21 Jan 2023 22:44:59 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: rtl8192e: Rename eeprom_CustomerID, SwChnlStage
 and SwChnlStep
Message-ID: <0d2e7bbd3a2f80d4652d4131c82294e172a2de30.1674336211.git.philipp.g.hortmann@gmail.com>
References: <cover.1674336211.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674336211.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable eeprom_CustomerID to eeprom_customer_id, SwChnlStage to
sw_chnl_stage and SwChnlStep to sw_chnl_step to avoid CamelCase which is
not accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 6 +++---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 8 ++++----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index b721bb72007d..6c570582479d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -303,7 +303,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 
 		usValue = rtl92e_eeprom_read(dev,
 					     (EEPROM_Customer_ID >> 1)) >> 8;
-		priv->eeprom_CustomerID = usValue & 0xff;
+		priv->eeprom_customer_id = usValue & 0xff;
 		usValue = rtl92e_eeprom_read(dev,
 					     EEPROM_ICVersion_ChannelPlan>>1);
 		priv->eeprom_chnl_plan = usValue&0xff;
@@ -327,7 +327,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		priv->card_8192_version = VERSION_8190_BD;
 		priv->eeprom_vid = 0;
 		priv->eeprom_did = 0;
-		priv->eeprom_CustomerID = 0;
+		priv->eeprom_customer_id = 0;
 		priv->eeprom_chnl_plan = 0;
 	}
 
@@ -449,7 +449,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 	if (priv->eeprom_vid == 0x1186 &&  priv->eeprom_did == 0x3304)
 		priv->customer_id =  RT_CID_DLINK;
 
-	switch (priv->eeprom_CustomerID) {
+	switch (priv->eeprom_customer_id) {
 	case EEPROM_CID_DEFAULT:
 		priv->customer_id = RT_CID_DEFAULT;
 		break;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 95a21859c7e0..ca10a14c63b4 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -907,8 +907,8 @@ static void _rtl92e_phy_switch_channel(struct net_device *dev, u8 channel)
 	u32 delay = 0;
 
 	while (!_rtl92e_phy_switch_channel_step(dev, channel,
-						&priv->SwChnlStage,
-						&priv->SwChnlStep, &delay)) {
+						&priv->sw_chnl_stage,
+						&priv->sw_chnl_step, &delay)) {
 		if (delay > 0)
 			msleep(delay);
 		if (!priv->up)
@@ -971,8 +971,8 @@ u8 rtl92e_set_channel(struct net_device *dev, u8 channel)
 
 	priv->chan = channel;
 
-	priv->SwChnlStage = 0;
-	priv->SwChnlStep = 0;
+	priv->sw_chnl_stage = 0;
+	priv->sw_chnl_step = 0;
 
 	if (priv->up)
 		_rtl92e_phy_switch_channel_work_item(dev);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index e0f4a3b444ee..55a68bbe3861 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -417,7 +417,7 @@ struct r8192_priv {
 	short	epromtype;
 	u16 eeprom_vid;
 	u16 eeprom_did;
-	u8 eeprom_CustomerID;
+	u8 eeprom_customer_id;
 	u16 eeprom_chnl_plan;
 
 	u8 eeprom_tx_pwr_level_cck[14];
@@ -432,8 +432,8 @@ struct r8192_priv {
 	u8 thermal_meter[2];
 
 	u8 sw_chnl_in_progress;
-	u8 SwChnlStage;
-	u8 SwChnlStep;
+	u8 sw_chnl_stage;
+	u8 sw_chnl_step;
 	u8 set_bw_mode_in_progress;
 
 	u8 n_cur_40mhz_prime_sc;
-- 
2.39.0

