Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC330735952
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjFSORz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjFSORw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:17:52 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639B6E7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:17:51 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666e916b880so1187407b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687184271; x=1689776271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z2lE7a2e73x78sHkw8HLnq0fUJFGsUNME76JPhx8NgU=;
        b=NHpLwEgbAllkTYZVBSWJFhrO127G4EAGk+PObZwauMv29q3xq9Ph+MbO26c4+j2cpA
         MyCtGuYnHvcRP4YpAbZtZn+fBwsIeIStGioI/TNjNeVurN+ead6ZGjqRMnEvB/zEBCGp
         3JllhG70x/GQD23zisSEKQBKLlaA0rkPyK0hKhbjNHWlcpJyB7btvhR2inltVM5YS4+l
         0Xe8q5oCZoMx3PoPKpWeRfcRFLipYEiC3XaSDWaLM/lQGHgl702/BmR0298xXd/T+REJ
         fDgzro9JD229vzbd9XdBIZ32rFH1iB5D3l7UPU/UH/nQWHt6LzeGMmkx3b6bfZ6rNBQf
         AuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687184271; x=1689776271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2lE7a2e73x78sHkw8HLnq0fUJFGsUNME76JPhx8NgU=;
        b=WvKqkuB4WsTwFQN59qPvbFaq+LR91sRyDarlrrgqh9HfRhzK9L1UCyf+iGW1RVOdug
         EuGN8jzLhH8yrHlVU22z2yIyOPfiM6uDcVUYgQlhDrkkQ4xwA5dA8bDeIiUXLGKF5Fv5
         fdOaWhyi10YYcfSlSEkC7vuDeeqI6oeZnEkOlEoS0qaj63jGQx1SIAftc1pYHn0Wo2lP
         Avptx2+J/dZMfVJUCQFLAJigpEcE5F1KekzXcwFycJKDOCHoQyNzjrUN/cTxlz59fcip
         yXTSk8wzfupvL4sujikNJFgNEtph+dVko6c9VNRQpdHAFxr+E4L/egZPxy5o3nvjjkgX
         JcNg==
X-Gm-Message-State: AC+VfDyp3bG4zRG7C++gIxlTBHIzc7HaYBHWe+N6gn8FuABn+YWWDN4R
        hkn+0nSaGwD2dGRN3kigc+I=
X-Google-Smtp-Source: ACHHUZ71lOMJwPR5Z+FKfKg9o2n6I9rc5xObNqZMrTaCL5qHi7HhX5JyYX06DYG6aX7zVZ/htUYlLA==
X-Received: by 2002:a05:6a20:9187:b0:11a:c012:4fdb with SMTP id v7-20020a056a20918700b0011ac0124fdbmr938782pzd.34.1687184270774;
        Mon, 19 Jun 2023 07:17:50 -0700 (PDT)
Received: from zephyrusG14 ([103.251.210.211])
        by smtp.gmail.com with ESMTPSA id x1-20020a056a00270100b005a8173829d5sm12177962pfv.66.2023.06.19.07.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 07:17:50 -0700 (PDT)
Date:   Mon, 19 Jun 2023 19:47:46 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, philipp.g.hortmann@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
Subject: [PATCH v4 1/4] staging: rtl8192e: Rename variable SetWirelessMode
Message-ID: <c0a65d217d272bf457917c89462c49e67bbfedb2.1687183827.git.yogi.kernel@gmail.com>
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

Rename variable SetWirelessMode to set_wireless_mode to avoid
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
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  2 +-
 drivers/staging/rtl8192e/rtllib.h            |  2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c    | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 9cb4ae9ba970..51748166eecc 100644
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
index cdd167de127f..581d568476ce 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1690,7 +1690,7 @@ struct rtllib_device {
 				 enum ht_channel_width bandwidth,
 				 enum ht_extchnl_offset Offset);
 	bool (*GetNmodeSupportBySecCfg)(struct net_device *dev);
-	void (*SetWirelessMode)(struct net_device *dev, u8 wireless_mode);
+	void (*set_wireless_mode)(struct net_device *dev, u8 wireless_mode);
 	bool (*GetHalfNmodeSupportByAPsHandler)(struct net_device *dev);
 	u8   (*rtllib_ap_sec_type)(struct rtllib_device *ieee);
 	void (*InitialGainHandler)(struct net_device *dev, u8 Operation);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 7494c7e6fff6..0eaff91d92bd 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1470,7 +1470,7 @@ static void rtllib_associate_complete_wq(void *data)
 		netdev_info(ieee->dev, "Using G rates:%d\n", ieee->rate);
 	} else {
 		ieee->rate = 22;
-		ieee->SetWirelessMode(ieee->dev, WIRELESS_MODE_B);
+		ieee->set_wireless_mode(ieee->dev, WIRELESS_MODE_B);
 		netdev_info(ieee->dev, "Using B rates:%d\n", ieee->rate);
 	}
 	if (ieee->ht_info->bCurrentHTSupport && ieee->ht_info->enable_ht) {
@@ -1654,12 +1654,12 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 				    (ieee->modulation &
 				     RTLLIB_OFDM_MODULATION)) {
 					ieee->rate = 108;
-					ieee->SetWirelessMode(ieee->dev, WIRELESS_MODE_G);
+					ieee->set_wireless_mode(ieee->dev, WIRELESS_MODE_G);
 					netdev_info(ieee->dev,
 						    "Using G rates\n");
 				} else {
 					ieee->rate = 22;
-					ieee->SetWirelessMode(ieee->dev, WIRELESS_MODE_B);
+					ieee->set_wireless_mode(ieee->dev, WIRELESS_MODE_B);
 					netdev_info(ieee->dev,
 						    "Using B rates\n");
 				}
@@ -2233,11 +2233,11 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 		}
 		/* Dummy wirless mode setting to avoid encryption issue */
 		if (bSupportNmode) {
-			ieee->SetWirelessMode(ieee->dev,
+			ieee->set_wireless_mode(ieee->dev,
 					      ieee->current_network.mode);
 		} else {
 			/*TODO*/
-			ieee->SetWirelessMode(ieee->dev, WIRELESS_MODE_G);
+			ieee->set_wireless_mode(ieee->dev, WIRELESS_MODE_G);
 		}
 
 		if ((ieee->current_network.mode == WIRELESS_MODE_N_24G) &&
@@ -2566,7 +2566,7 @@ static void rtllib_start_ibss_wq(void *data)
 		}
 
 		ieee->current_network.qos_data.supported = 0;
-		ieee->SetWirelessMode(ieee->dev, WIRELESS_MODE_G);
+		ieee->set_wireless_mode(ieee->dev, WIRELESS_MODE_G);
 		ieee->current_network.mode = ieee->mode;
 		ieee->current_network.atim_window = 0;
 		ieee->current_network.capability = WLAN_CAPABILITY_IBSS;
-- 
2.34.1

