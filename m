Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FA7735955
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjFSOS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjFSOSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:18:21 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DC1186
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:18:20 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b5251e5774so14469255ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687184300; x=1689776300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JQy84gQUtEAMC5sEhanysB2VGHkEqPs0ft2DSQHuBlk=;
        b=TF9Ir8ArfA1ZmdS3lhs/0saMshbLdrbX3GKiqC6IrUHGC5nf306M71GvRX5jM6GN1L
         WKsR2pilm46hyNOSHC3PfRaCZmyE610r9Z7Cndj+hdmPwsQ1NbsEDtel3g5Dp6Ge4vQo
         C3gbgNk+j1HH+F4VW6EicBFXyp5kBWyTLoyCU9rZF7qe2LeNF9C+97HN3i4RatIlz3o4
         z2j6gyuJ3wXqCNOFDR6khZTT7hV5sivUVE7trMGAaStGvNAWzOIt4uU5k4J0AtsdtGDw
         ZJQA1fPQXXuC5nU3+Wt1HnAySOQmUVeUmbE4StTeOtkcTglcOMJ9V7axs8lq4D/UcWP4
         xOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687184300; x=1689776300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQy84gQUtEAMC5sEhanysB2VGHkEqPs0ft2DSQHuBlk=;
        b=Np+bDVsa5ilZMTDlCGKLYxlbDg8064L7B5ZOc/iJDJYrjPtbB3NzC7IK8yidwO0yFy
         T+pOeVZRBGkp58sfsfjj97G283rPe1iB7Stuvvu/egm5ckyvlYT49t5zNWAFtsep81mu
         PZ1tJ9757QDHiktCvV5US19ifgiI7TCCmgZb7dL+ZPv7p1vfdliQVh/6SB4LYZLuLlre
         6z941DYfK4TlQjT9eyqedJA8JQPIBbaJLIJ0d6jZeieIgJwduomoFad+fuKZSmMc+nlt
         2JgsXioLpJHWgEGmYU8IgJmUbpM5twH+8ve6yZ6HdGkkxUHpfE4ALKBjrmSMfwKynWjH
         102A==
X-Gm-Message-State: AC+VfDyVUu69JRZoVvEqHjvpH2I6y1JX/bBNvwC061kboKC+sB8G8NYz
        FNqBrCHa6DcRapcX/I9Pg4U=
X-Google-Smtp-Source: ACHHUZ4gJBaUyELc7uscWZ5vr2ruSCb1nPh4+1QxdZJOfW1HMPII/IxFC1SQyJwwqmnM7x4ICyEIaA==
X-Received: by 2002:a17:902:d2cb:b0:1a9:40d5:b0ae with SMTP id n11-20020a170902d2cb00b001a940d5b0aemr1060217plc.12.1687184300199;
        Mon, 19 Jun 2023 07:18:20 -0700 (PDT)
Received: from zephyrusG14 ([103.251.210.211])
        by smtp.gmail.com with ESMTPSA id b9-20020a170902d88900b001b55fe1b471sm2589127plz.302.2023.06.19.07.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 07:18:19 -0700 (PDT)
Date:   Mon, 19 Jun 2023 19:48:15 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, philipp.g.hortmann@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
Subject: [PATCH v4 2/4] staging: rtl8192e: Rename variable SetBWModeHandler
Message-ID: <fe6c16cfe1d8f7ff41b5fce90fc63383fbfec4f5.1687183827.git.yogi.kernel@gmail.com>
References: <cover.1687183827.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687183827.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable SetBWModeHandler to set_bw_mode_handler to avoid
CamelCase which is not accepted by checkpatch.

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---

v4: Rebase to latest staging-testing branch as suggested by Greg Kroah-Hartman
    <gregkh@linuxfoundation.org>.

v3: Revert back to v1 of the patch as suggested by Greg Kroah-Hartman
    <gregkh@linuxfoundation.org>.

v2: Removed the variable and called the function directly instead of
    just renaming the variable as suggested by Greg Kroah-Hartman
    <gregkh@linuxfoundation.org>.
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c    | 4 ++--
 drivers/staging/rtl8192e/rtllib.h            | 6 +++---
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 51748166eecc..a06d1c4e778a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -718,7 +718,7 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
 	priv->rtllib->handle_beacon		= _rtl92e_handle_beacon;
 	priv->rtllib->set_wireless_mode		= rtl92e_set_wireless_mode;
 	priv->rtllib->LeisurePSLeave		= rtl92e_leisure_ps_leave;
-	priv->rtllib->SetBWModeHandler		= rtl92e_set_bw_mode;
+	priv->rtllib->set_bw_mode_handler	= rtl92e_set_bw_mode;
 	priv->rf_set_chan			= rtl92e_set_channel;
 
 	priv->rtllib->start_send_beacons = rtl92e_start_beacon;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 7ee3cb846ca1..f9fa3f2bb728 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -833,11 +833,11 @@ static void HTSetConnectBwModeCallback(struct rtllib_device *ieee)
 			ieee->set_chan(ieee->dev,
 				       ieee->current_network.channel);
 
-		ieee->SetBWModeHandler(ieee->dev, HT_CHANNEL_WIDTH_20_40,
+		ieee->set_bw_mode_handler(ieee->dev, HT_CHANNEL_WIDTH_20_40,
 				       ht_info->CurSTAExtChnlOffset);
 	} else {
 		ieee->set_chan(ieee->dev, ieee->current_network.channel);
-		ieee->SetBWModeHandler(ieee->dev, HT_CHANNEL_WIDTH_20,
+		ieee->set_bw_mode_handler(ieee->dev, HT_CHANNEL_WIDTH_20,
 				       HT_EXTCHNL_OFFSET_NO_EXT);
 	}
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 581d568476ce..b3d6699b31ed 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1686,9 +1686,9 @@ struct rtllib_device {
 
 	/* check whether Tx hw resource available */
 	short (*check_nic_enough_desc)(struct net_device *dev, int queue_index);
-	void (*SetBWModeHandler)(struct net_device *dev,
-				 enum ht_channel_width bandwidth,
-				 enum ht_extchnl_offset Offset);
+	void (*set_bw_mode_handler)(struct net_device *dev,
+				    enum ht_channel_width bandwidth,
+				    enum ht_extchnl_offset Offset);
 	bool (*GetNmodeSupportBySecCfg)(struct net_device *dev);
 	void (*set_wireless_mode)(struct net_device *dev, u8 wireless_mode);
 	bool (*GetHalfNmodeSupportByAPsHandler)(struct net_device *dev);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index be82f0a655e8..d8c7b7377132 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -335,7 +335,7 @@ void rtllib_wx_sync_scan_wq(void *data)
 		b40M = 1;
 		chan_offset = ieee->ht_info->CurSTAExtChnlOffset;
 		bandwidth = (enum ht_channel_width)ieee->ht_info->bCurBW40MHz;
-		ieee->SetBWModeHandler(ieee->dev, HT_CHANNEL_WIDTH_20,
+		ieee->set_bw_mode_handler(ieee->dev, HT_CHANNEL_WIDTH_20,
 				       HT_EXTCHNL_OFFSET_NO_EXT);
 	}
 
@@ -348,7 +348,7 @@ void rtllib_wx_sync_scan_wq(void *data)
 			ieee->set_chan(ieee->dev, chan - 2);
 		else
 			ieee->set_chan(ieee->dev, chan);
-		ieee->SetBWModeHandler(ieee->dev, bandwidth, chan_offset);
+		ieee->set_bw_mode_handler(ieee->dev, bandwidth, chan_offset);
 	} else {
 		ieee->set_chan(ieee->dev, chan);
 	}
-- 
2.34.1

