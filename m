Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E518F734636
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 15:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjFRNFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 09:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFRNFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 09:05:07 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72081AB
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 06:05:06 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6685421cdb3so553034b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 06:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687093506; x=1689685506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wRgjeJzxwlHCJLz7nU375fsDcPTbnKnIoD3o2Bz9KAw=;
        b=cXyvrNAHts7ZQKqRpwP5po9vFgi5UBx2urXqkY9wKEmwBrVwzf21mqIYR5u8OOwqYq
         seZooz4bJCoP5qNtlcvyDGPR8EJoZHtu0F9dvg71mTHtCwdX/FNRAOxGJnO3NMrm5f6/
         6nZEtvH5LzQPp02TCCd9aWLy1i1P+QFUsSpAjDZzBojJD/SCLHTMtXdzTVyfB8qqnhqS
         zri/v8RQf8xJt/t8S82m9n1TdJlMRZLopYsK8Y4O2jU6T+oq8QGxBSQnZmodKG1kp2au
         WHCqz9M1NrMjyZuJ3FaQGHkE4aLTPg8E6K603E2YULLkwERXWk/bhazXNRPEgB5BXS0t
         BPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687093506; x=1689685506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRgjeJzxwlHCJLz7nU375fsDcPTbnKnIoD3o2Bz9KAw=;
        b=TiLOoy1Gw/P0e/y93ORyQq1WDIdO7dDlLHT9MDq26kXw692m5ayU097GvCnPcL8Y6i
         13VaqAd+pr+qMkb/QxaSql42NR498Gf3JBWT0z2aHvwYTILApNUvCViMDienl0mAommO
         p5Np0H+lBovwlK5LKSL6XQxSYT4B+Lj1UGkcs8Y6LtiTIweNrfN9pEY64p7PxZH5Smt8
         r2GwBgYX4zvC1+mqT7CPp2eXbPRQF2QyuR64jhQ28Ck4u6ZXTIAwWf2IIueg+vigu+nV
         C/bRtQqr/OL1j5T2uQbJsj0On0a8Iv1THmbsWrwDfH16w5LEXNy1Cp2rn6/LfsdJcolR
         2VnQ==
X-Gm-Message-State: AC+VfDwVtAf1cnxhYY99tJ9YN2U1vyqm8DE3n+gRX1Fyf/AJbQ1JGl2n
        pX9wSUd6Jh+uFg8d3BiA4Ms=
X-Google-Smtp-Source: ACHHUZ6es/VJJzhFLT9wXqeFtuAH6zY9atWgUcUgors1zxxi0wNkNJm7T9EQ+ZkJ5hRJMjiZlpEfXQ==
X-Received: by 2002:a05:6a00:1743:b0:646:f971:b179 with SMTP id j3-20020a056a00174300b00646f971b179mr20164537pfc.16.1687093506145;
        Sun, 18 Jun 2023 06:05:06 -0700 (PDT)
Received: from zephyrusG14 ([103.251.210.211])
        by smtp.gmail.com with ESMTPSA id j1-20020aa78d01000000b0065418efa5ebsm16110685pfe.155.2023.06.18.06.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 06:05:05 -0700 (PDT)
Date:   Sun, 18 Jun 2023 18:35:00 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, philipp.g.hortmann@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
Subject: [PATCH v3 1/4] staging: rtl8192e: Rename variable SetWirelessMode
Message-ID: <31ea72cdec675c53b2125f8425e74e92d99de276.1687092111.git.yogi.kernel@gmail.com>
References: <cover.1687092111.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687092111.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable SetWirelessMode to set_wireless_mode to avoid
CamelCase which is not accepted by checkpatch.

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---

v3: Revert back to v1 of the patch as suggested by Greg Kroah-Hartman
    <gregkh@linuxfoundation.org>.

v2: Removed the variable and called the function directly instead of
    just renaming the variable as suggested by Greg Kroah-Hartman
    <gregkh@linuxfoundation.org>.
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  2 +-
 drivers/staging/rtl8192e/rtllib.h            |  2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c    | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 17b70dde7eeb..699c4accf2db 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -716,7 +716,7 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
 	priv->rtllib->check_nic_enough_desc	= _rtl92e_check_nic_enough_desc;
 	priv->rtllib->handle_assoc_response	= _rtl92e_handle_assoc_response;
 	priv->rtllib->handle_beacon		= _rtl92e_handle_beacon;
-	priv->rtllib->SetWirelessMode		= rtl92e_set_wireless_mode;
+	priv->rtllib->set_wireless_mode		= rtl92e_set_wireless_mode;
 	priv->rtllib->LeisurePSLeave		= rtl92e_leisure_ps_leave;
 	priv->rtllib->SetBWModeHandler		= rtl92e_set_bw_mode;
 	priv->rf_set_chan			= rtl92e_set_channel;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 87e9169214f6..f91355de17f7 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1708,7 +1708,7 @@ struct rtllib_device {
 				 enum ht_channel_width bandwidth,
 				 enum ht_extchnl_offset Offset);
 	bool (*GetNmodeSupportBySecCfg)(struct net_device *dev);
-	void (*SetWirelessMode)(struct net_device *dev, u8 wireless_mode);
+	void (*set_wireless_mode)(struct net_device *dev, u8 wireless_mode);
 	bool (*GetHalfNmodeSupportByAPsHandler)(struct net_device *dev);
 	u8   (*rtllib_ap_sec_type)(struct rtllib_device *ieee);
 	void (*InitialGainHandler)(struct net_device *dev, u8 Operation);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 821ca86b8bcd..1c48e1ee5baf 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1472,7 +1472,7 @@ static void rtllib_associate_complete_wq(void *data)
 		netdev_info(ieee->dev, "Using G rates:%d\n", ieee->rate);
 	} else {
 		ieee->rate = 22;
-		ieee->SetWirelessMode(ieee->dev, IEEE_B);
+		ieee->set_wireless_mode(ieee->dev, IEEE_B);
 		netdev_info(ieee->dev, "Using B rates:%d\n", ieee->rate);
 	}
 	if (ieee->ht_info->bCurrentHTSupport && ieee->ht_info->enable_ht) {
@@ -1656,13 +1656,13 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 				    (ieee->modulation &
 				     RTLLIB_OFDM_MODULATION)) {
 					ieee->rate = 108;
-					ieee->SetWirelessMode(ieee->dev,
+					ieee->set_wireless_mode(ieee->dev,
 							      IEEE_G);
 					netdev_info(ieee->dev,
 						    "Using G rates\n");
 				} else {
 					ieee->rate = 22;
-					ieee->SetWirelessMode(ieee->dev,
+					ieee->set_wireless_mode(ieee->dev,
 							      IEEE_B);
 					netdev_info(ieee->dev,
 						    "Using B rates\n");
@@ -2237,11 +2237,11 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 		}
 		/* Dummy wirless mode setting to avoid encryption issue */
 		if (bSupportNmode) {
-			ieee->SetWirelessMode(ieee->dev,
+			ieee->set_wireless_mode(ieee->dev,
 					      ieee->current_network.mode);
 		} else {
 			/*TODO*/
-			ieee->SetWirelessMode(ieee->dev, IEEE_G);
+			ieee->set_wireless_mode(ieee->dev, IEEE_G);
 		}
 
 		if ((ieee->current_network.mode == IEEE_N_24G) &&
@@ -2570,7 +2570,7 @@ static void rtllib_start_ibss_wq(void *data)
 		}
 
 		ieee->current_network.qos_data.supported = 0;
-		ieee->SetWirelessMode(ieee->dev, IEEE_G);
+		ieee->set_wireless_mode(ieee->dev, IEEE_G);
 		ieee->current_network.mode = ieee->mode;
 		ieee->current_network.atim_window = 0;
 		ieee->current_network.capability = WLAN_CAPABILITY_IBSS;
-- 
2.34.1

