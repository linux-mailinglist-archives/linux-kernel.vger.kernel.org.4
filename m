Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5AD713A30
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 16:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjE1Ovm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 10:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjE1Ovk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 10:51:40 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09D0C3
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 07:51:37 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64d2ca9ef0cso1671631b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 07:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685285497; x=1687877497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cDqIyCgpLYXTC8W2bqF9+g0yU2kwPgX3pJEbL1qQiTM=;
        b=Fau3+U+TYnVe5J8D1aUuY6YkMWTA1ZPfVkCUff9o9bowf9SO0G3lDTGg703wBkOVcg
         SuyJnIK0bYa+D4Utszt8Yy9Yr7tQ5f9QJTNUQJjNUdCydV1oibTOfYcrU+klOFbwP3Q6
         IkmmXC2a2x3+uVOSq2QlUhKofFHMG52/XEybqHfTsw+iOdOpERZyXjUwrKfpZTgoPJZ2
         e8UMkX4CaSKQaIb9+ddH/ejRTJdF6ehUlQ/IMHpsjUG/RcDV4bg6tkFihv1+QU1LOTg2
         j36pqQxRdpdPsTm6hd+TC+UJYaIjJ+47vL+G8+V0OF8mkNeViBE59FSznLgsu2ljdXWK
         Mr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685285497; x=1687877497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDqIyCgpLYXTC8W2bqF9+g0yU2kwPgX3pJEbL1qQiTM=;
        b=ghePMa/w8h7d+Or7/767VezjuExB4mLZAXedN52ETEt1Zr1FidoF6U95gw0th3QqZC
         sXE4jkbk+ehBlUDmv4kzGrl0QBpXxj2Ty9epoNwDr5iSLjTLsz0i5tgWGe9OfQWbhfhB
         Epa9EXUUm/ivVGDip1a25N0/UAfWV4HB5LKcaZOENgFE4rDGckPNufWHWTHO1dUMKDJx
         DI4Uy6LT68VF1bDzqLy9osNNLi9ITA9rcUdpeGkuVqu2GLua1QKZD32a3yNS24f+46sZ
         5W877Nw1nKEOvb9EwEeL04cA0kzfThOE3SEXwWbTgtvaXxx9sQj1ijDu+9sJC8XPwcyH
         F2eg==
X-Gm-Message-State: AC+VfDzqxbIe9Kfin+RbU2lr6axyWWQRvvI6Nf8bw+i/HqY4q0LqrlMO
        Yha00sQTlq1hVFUCRLIFqDY=
X-Google-Smtp-Source: ACHHUZ4+q6Q202RpJ4zFPxeou+gPh9VxdjdpW1CXiz20RSrB6dc8YsAgs63ZAC6RMFSbHQcHzQzvPQ==
X-Received: by 2002:a05:6a00:1949:b0:646:421f:500b with SMTP id s9-20020a056a00194900b00646421f500bmr11795884pfk.10.1685285497227;
        Sun, 28 May 2023 07:51:37 -0700 (PDT)
Received: from yogi-Zephyrus ([103.251.210.199])
        by smtp.gmail.com with ESMTPSA id s9-20020aa78d49000000b00643889e30c2sm5273135pfe.180.2023.05.28.07.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 07:51:36 -0700 (PDT)
Date:   Sun, 28 May 2023 20:21:33 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] staging: rtl8192e: Rename variable SetWirelessMode
Message-ID: <5a1ee0e9ef53ebe6085c14dba08c438862ec992e.1685284727.git.yogi.kernel@gmail.com>
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

Rename variable SetWirelessMode to set_wireless_mode to avoid
CamelCase which is not accepted by checkpatch.

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
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
index 4aa5ce9f7792..03f8703f5def 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1710,7 +1710,7 @@ struct rtllib_device {
 				 enum ht_channel_width bandwidth,
 				 enum ht_extchnl_offset Offset);
 	bool (*GetNmodeSupportBySecCfg)(struct net_device *dev);
-	void (*SetWirelessMode)(struct net_device *dev, u8 wireless_mode);
+	void (*set_wireless_mode)(struct net_device *dev, u8 wireless_mode);
 	bool (*GetHalfNmodeSupportByAPsHandler)(struct net_device *dev);
 	u8   (*rtllib_ap_sec_type)(struct rtllib_device *ieee);
 	void (*InitialGainHandler)(struct net_device *dev, u8 Operation);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 7c4cba6dcf46..bbb1f2f0d35b 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1503,7 +1503,7 @@ static void rtllib_associate_complete_wq(void *data)
 		netdev_info(ieee->dev, "Using G rates:%d\n", ieee->rate);
 	} else {
 		ieee->rate = 22;
-		ieee->SetWirelessMode(ieee->dev, IEEE_B);
+		ieee->set_wireless_mode(ieee->dev, IEEE_B);
 		netdev_info(ieee->dev, "Using B rates:%d\n", ieee->rate);
 	}
 	if (ieee->ht_info->bCurrentHTSupport && ieee->ht_info->enable_ht) {
@@ -1687,13 +1687,13 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
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
@@ -2276,11 +2276,11 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
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
@@ -2615,7 +2615,7 @@ static void rtllib_start_ibss_wq(void *data)
 		}
 
 		ieee->current_network.qos_data.supported = 0;
-		ieee->SetWirelessMode(ieee->dev, IEEE_G);
+		ieee->set_wireless_mode(ieee->dev, IEEE_G);
 		ieee->current_network.mode = ieee->mode;
 		ieee->current_network.atim_window = 0;
 		ieee->current_network.capability = WLAN_CAPABILITY_IBSS;
-- 
2.25.1

