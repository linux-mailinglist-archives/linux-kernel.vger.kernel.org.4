Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3DC713A32
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 16:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjE1OwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 10:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjE1OwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 10:52:03 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CD2E4
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 07:51:55 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d18d772bdso2942994b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 07:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685285515; x=1687877515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AMXq3Se3bHG0JmLuoAfId05SxF5hYAXzJCK5u4/OX2o=;
        b=gRLW0Yxfwb+XrSzjRIIERjetDhUxnfFggpD5lo0EfBfymV6snvPEJPKwT3VodYaJBF
         /PT8CIwj4TKB+rHso92lVZKpjumhhqRFYYbUdpBuxeOrvczFF+Wj7fc7EQbqpfOdDCPG
         /VBH+PQOO5n+SSiPyx/kDu8h/5SKEnxitMSpeNa2OOWUcHevFki3rWYUMTgrAVpVZh1G
         3ev3DBlTBgXu8QRnj0lbddqYas2J3L9+rbt/r/Wamg4AGSNunnU9jO52p4dj61I4cGW6
         57XDRyov5QsBxUN/51ihBu1voyB8ciYthgGShTWRUfmMq6FIvBzzttnRzm8tN269r53v
         Navw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685285515; x=1687877515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMXq3Se3bHG0JmLuoAfId05SxF5hYAXzJCK5u4/OX2o=;
        b=aeVNFryRk9h5/Qey6MYZzyQzfsgCkBNgvuQYZr0EtY1liVToVyooT/kbRP6ipR7Bk6
         mon9UN0EsTpnwsbpZDRbDPxY7S0mgtE0nxmaQYwBM2GoHwASSEtP+k/c+FjM5k9dePC6
         SOyiDLQ9gwMJNG92DjHfeqzI+yMjOuBL1mcyY8fBX7hTsn3SL96CGetVGlETwGam/Oil
         leCWg30jV6mA/l7TmT3lPUGMCcMrTvPljnZZ6Di6mvZaApS9w3K6nwa72bcRg6AXY+wu
         F0tv63Kz/iXKsDRV57rnxsQQ9fiNC7ggaBjPhPtHXhkdVKBOmOPOSIBAKrXtw9JaCgl5
         Z8ug==
X-Gm-Message-State: AC+VfDw8RqX5urnInU0WO5H8NWwihMTIPn51cOXIyHIP+X+kG3Qhc1Sy
        ogELz/I+y7fMZ+ZOm/Mx6QjQ2tUaB3E=
X-Google-Smtp-Source: ACHHUZ7/EU1eqjfCl0ubNx6ubSWhWW8beloR7v/CkC89FKwNenL6L6uXVdtJMVEu0jvqlnH76aHEPg==
X-Received: by 2002:a05:6a20:4293:b0:10c:c407:92e5 with SMTP id o19-20020a056a20429300b0010cc40792e5mr6107889pzj.22.1685285515110;
        Sun, 28 May 2023 07:51:55 -0700 (PDT)
Received: from yogi-Zephyrus ([103.251.210.199])
        by smtp.gmail.com with ESMTPSA id n23-20020a62e517000000b00625d84a0194sm5264175pff.107.2023.05.28.07.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 07:51:54 -0700 (PDT)
Date:   Sun, 28 May 2023 20:21:50 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] staging: rtl8192e: Rename variable SetBWModeHandler
Message-ID: <673530895e8da53d956e73fbe4b5f97400cb8594.1685284727.git.yogi.kernel@gmail.com>
References: <cover.1685284727.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1685284727.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable SetBWModeHandler to set_bw_mode_handler to avoid
CamelCase which is not accepted by checkpatch.

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c    | 4 ++--
 drivers/staging/rtl8192e/rtllib.h            | 6 +++---
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 699c4accf2db..68e921a3a0a8 100644
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
index fe30a291e64c..1fe504244437 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -835,11 +835,11 @@ static void HTSetConnectBwModeCallback(struct rtllib_device *ieee)
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
index 03f8703f5def..c30821a746c0 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1706,9 +1706,9 @@ struct rtllib_device {
 
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
index d85a32d2d050..07a3d0c0f0e0 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -359,7 +359,7 @@ void rtllib_wx_sync_scan_wq(void *data)
 		b40M = 1;
 		chan_offset = ieee->ht_info->CurSTAExtChnlOffset;
 		bandwidth = (enum ht_channel_width)ieee->ht_info->bCurBW40MHz;
-		ieee->SetBWModeHandler(ieee->dev, HT_CHANNEL_WIDTH_20,
+		ieee->set_bw_mode_handler(ieee->dev, HT_CHANNEL_WIDTH_20,
 				       HT_EXTCHNL_OFFSET_NO_EXT);
 	}
 
@@ -372,7 +372,7 @@ void rtllib_wx_sync_scan_wq(void *data)
 			ieee->set_chan(ieee->dev, chan - 2);
 		else
 			ieee->set_chan(ieee->dev, chan);
-		ieee->SetBWModeHandler(ieee->dev, bandwidth, chan_offset);
+		ieee->set_bw_mode_handler(ieee->dev, bandwidth, chan_offset);
 	} else {
 		ieee->set_chan(ieee->dev, chan);
 	}
-- 
2.25.1

