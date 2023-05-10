Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7886FE135
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbjEJPJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237571AbjEJPJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:09:49 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35C41993
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:09:47 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1aad6f2be8eso68615405ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683731387; x=1686323387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2MdUvkOQf/H6u+bsf32R+0B6I/OaVbOPJFXkpsnz650=;
        b=XceF3oromGb5RS/guK2wNN+F2+fqB6JGxs7JAUfy+IEbKlO7bEtxA6sXW708RRTFWP
         ZqnxwP405zkdO0YTUCrGlt/lBHeiWf0E4tUX1GA+PCCAPYxJonNfE5GpahOwbHlqAj+3
         il9lkE7h45xz7Wcv/OZancE5Se6+GhgCnxaCYqcGYmHbFQJRJw+O+axe9tF1tn/T5/4Y
         qj3h0h39+rZHEOEs/Lhz4DUAnZQaleeubwdAATBlQqxi4QG787tbarETiRuOPQByXxdX
         GkLgea/YP03ocP4r7LJBMAcxzqi9T65axWaC7446iyfMeCMPU2/KqoRWejisvI539GxW
         47ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683731387; x=1686323387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MdUvkOQf/H6u+bsf32R+0B6I/OaVbOPJFXkpsnz650=;
        b=OZwIa5A/8LGQx++OORoZ+dB65TJk7WbkwfmXx+vtzKDYinF0BCnPoLv900vEF81oii
         1ZVTzYffU0l4lYZg5N1HsM0b5ccqS8XXClX6hQ2v03setGKJLSgx4lmE3ag2JUR4/Os9
         hLqRsal7nlEz/YlCKbhtyxiMtCTmWGt9Pv4H9mkxAE6ThoRFnMhixyU/KeoTSEnrpSW5
         oH6ficC1ASGAnL7kabhiGkvOWj0Llh15Xl1roPkkuuNIn4Bvw6XlxURWPv4kS3QBl3Aa
         44pxkBuhhD+wSuPdTdTSUyOs7zrnq+dFhJ2/4XNRG4F/1W4EnyWa1DK6HDhgfGGPwTJ2
         cPGA==
X-Gm-Message-State: AC+VfDyNRADdqFGH9jeTvR9OqFsndqYyh/MI1MEizsX6GO/cWB3SEThr
        S95XzdjGHOOvaioe5O1jQdQ=
X-Google-Smtp-Source: ACHHUZ5h/G3A7pgdl0GfHmqF4GkzWayqzY9cVOhrOcG4jGAppA16m8qxu+4Svg3UWJ/bUXfGwNxSwA==
X-Received: by 2002:a17:902:c94b:b0:1ab:14f2:e7e6 with SMTP id i11-20020a170902c94b00b001ab14f2e7e6mr21581496pla.65.1683731387410;
        Wed, 10 May 2023 08:09:47 -0700 (PDT)
Received: from pop-os.localdomain ([103.251.210.208])
        by smtp.gmail.com with ESMTPSA id m2-20020a1709026bc200b001a045f45d49sm3869439plt.281.2023.05.10.08.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 08:09:47 -0700 (PDT)
Date:   Wed, 10 May 2023 20:39:42 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] staging: rtl8192e: Rename tmpCCK20Mindex and
 tmpCCK40Mindex
Message-ID: <3e8b6cd85e6e4fcc934cc1d813f5f594cef8ff92.1683730854.git.yogi.kernel@gmail.com>
References: <cover.1683730854.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683730854.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable tmpCCK20Mindex to tmp_cck_20m_index and
tmpCCK40Mindex to tmp_cck_40m_index to avoid CamelCase which
is not accepted by checkpatch.

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 28 +++++++++++-----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 117c0538cf5f..a44be3f810ab 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -658,7 +658,7 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 #define ThermalMeterVal	9
 	struct r8192_priv *priv = rtllib_priv(dev);
 	u32 tmp_reg, tmp_cck;
-	u8 tmp_ofdm_index, tmp_cck_index, tmpCCK20Mindex, tmpCCK40Mindex, tmpval;
+	u8 tmp_ofdm_index, tmp_cck_index, tmp_cck_20m_index, tmp_cck_40m_index, tmpval;
 	int i = 0, CCKSwingNeedUpdate = 0;
 
 	if (!priv->tx_pwr_tracking_init) {
@@ -689,33 +689,33 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 	priv->thermal_meter[1] = ThermalMeterVal;
 
 	if (priv->thermal_meter[0] >= (u8)tmp_reg) {
-		tmp_ofdm_index = tmpCCK20Mindex = 6+(priv->thermal_meter[0] -
+		tmp_ofdm_index = tmp_cck_20m_index = 6+(priv->thermal_meter[0] -
 			      (u8)tmp_reg);
-		tmpCCK40Mindex = tmpCCK20Mindex - 6;
+		tmp_cck_40m_index = tmp_cck_20m_index - 6;
 		if (tmp_ofdm_index >= OFDM_TABLE_LEN)
 			tmp_ofdm_index = OFDM_TABLE_LEN - 1;
-		if (tmpCCK20Mindex >= CCK_TABLE_LEN)
-			tmpCCK20Mindex = CCK_TABLE_LEN - 1;
-		if (tmpCCK40Mindex >= CCK_TABLE_LEN)
-			tmpCCK40Mindex = CCK_TABLE_LEN - 1;
+		if (tmp_cck_20m_index >= CCK_TABLE_LEN)
+			tmp_cck_20m_index = CCK_TABLE_LEN - 1;
+		if (tmp_cck_40m_index >= CCK_TABLE_LEN)
+			tmp_cck_40m_index = CCK_TABLE_LEN - 1;
 	} else {
 		tmpval = (u8)tmp_reg - priv->thermal_meter[0];
 		if (tmpval >= 6) {
 			tmp_ofdm_index = 0;
-			tmpCCK20Mindex = 0;
+			tmp_cck_20m_index = 0;
 		} else {
 			tmp_ofdm_index = 6 - tmpval;
-			tmpCCK20Mindex = 6 - tmpval;
+			tmp_cck_20m_index = 6 - tmpval;
 		}
-		tmpCCK40Mindex = 0;
+		tmp_cck_40m_index = 0;
 	}
 	if (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20)
-		tmp_cck_index = tmpCCK40Mindex;
+		tmp_cck_index = tmp_cck_40m_index;
 	else
-		tmp_cck_index = tmpCCK20Mindex;
+		tmp_cck_index = tmp_cck_20m_index;
 
-	priv->rec_cck_20m_idx = tmpCCK20Mindex;
-	priv->rec_cck_40m_idx = tmpCCK40Mindex;
+	priv->rec_cck_20m_idx = tmp_cck_20m_index;
+	priv->rec_cck_40m_idx = tmp_cck_40m_index;
 
 	if (priv->rtllib->current_network.channel == 14 &&
 	    !priv->bcck_in_ch14) {
-- 
2.34.1

