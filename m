Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE446734184
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbjFQN5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbjFQN5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:57:10 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0652103
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 06:57:00 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94ea38c90ccso54621266b.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 06:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687010218; x=1689602218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YIlanWnqKthGj/Tq5D/eIod3q5DkOlUrV2jqF75OdBk=;
        b=jJZaPbUoiGXV83CRgbnKIucoNZJrVfNyNpUClduiO8BZ8K51O6/2w40HfljpyH+rW4
         uFuTj8jG3+UUOneluXtntbiorgV2GYSzSP1MDHoDeZlf+7j3/s/qcsRFdt7BiwHjLPKf
         Y9AnbzIACVm1ql93hUwKTuwPSx4a3EZZnKZ/BONz3IK0f0jAXKAFVXt7ac646xqKmFY0
         Xks3KRIEvTg6qBTF20IxeMMwTJjQLuWXelExmBXpfhGFc5GobQZE7uwBEwRP6jZqb+p9
         Ki35sZFK889sBEPoQrNC+oCJ6mAMJ3HtfpaOw68eeggtVNVaAMje+NKYfqjkRdsHiKim
         FoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687010218; x=1689602218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIlanWnqKthGj/Tq5D/eIod3q5DkOlUrV2jqF75OdBk=;
        b=f6zgu4l8PcuTTP+4qhv/CARmRtpoiQgjg9hl8PxZnHuPOCG8v8fFtYU3REto/Cb4li
         dS4MeOs7PXCLaw/QqTYKJi8cR7m0xugbICjF4yNwTVHOEsOsPKtlOGUa+UFLORo7L3/F
         berW7O2sepRh7PnnkpI1PX43vyiBz87zsivDqx0EoPG157oWkRhBCl4kbWzC8FJ4EEEn
         0CbAOysrDCm3M1SEAvtlhQI5UI1yYVJ+HOV9jIeFDqExua/KIZJ6aAWxXG4wtKQZcCMS
         u9nfWgvjSjXc5ffdTMo9yZ2NZJq2rQ+sxoi6X5VN5AHYnTIFvAQBDZvmfjObQiVm//fb
         ZDvw==
X-Gm-Message-State: AC+VfDxBdJppiKWt7eJKii2QwckYzae6rs5UbbFBMetkZKy2ikYQdPUE
        LxQoKwlWYB39vwHr+j6XiDE=
X-Google-Smtp-Source: ACHHUZ48fATnJ1gqItX2yAD21sjHWvXW1c3DuqyNYlIWPbMk4rA6O1XUD+c+335oN6kBfHw+5N2rQw==
X-Received: by 2002:a17:906:244:b0:974:ae1d:ad0b with SMTP id 4-20020a170906024400b00974ae1dad0bmr3485505ejl.3.1687010218591;
        Sat, 17 Jun 2023 06:56:58 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id q26-20020a1709060e5a00b009863d4b555esm2155361eji.82.2023.06.17.06.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 06:56:58 -0700 (PDT)
Date:   Sat, 17 Jun 2023 15:56:56 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] staging: rtl8192e: Rename constant IEEE_x to
 WIRELESS_MODE_x
Message-ID: <37d81ab3cbb0231868d75b11eaa2f65a0e6a9379.1687007788.git.philipp.g.hortmann@gmail.com>
References: <cover.1687007788.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687007788.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename constant IEEE_B to WIRELESS_MODE_B, IEEE_G -> WIRELESS_MODE_G and
IEEE_N_24G -> WIRELESS_MODE_N_24G to align with rtlwifi driver as
requested in TODO.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 10 +++----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c     |  6 ++--
 drivers/staging/rtl8192e/rtllib.h             |  7 ++---
 drivers/staging/rtl8192e/rtllib_rx.c          | 12 ++++----
 drivers/staging/rtl8192e/rtllib_softmac.c     | 28 +++++++++----------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  |  2 +-
 drivers/staging/rtl8192e/rtllib_tx.c          |  2 +-
 drivers/staging/rtl8192e/rtllib_wx.c          |  2 +-
 10 files changed, 34 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 10dc1c4e9913..c20dfc81d549 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -162,7 +162,7 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
 			 &priv->rtllib->current_network.qos_data.parameters;
 
 		u1bAIFS = qop->aifs[pAcParam] *
-			  ((mode & (IEEE_G | IEEE_N_24G)) ? 9 : 20) + aSifsTime;
+			  ((mode & (WIRELESS_MODE_G | WIRELESS_MODE_N_24G)) ? 9 : 20) + aSifsTime;
 
 		rtl92e_dm_init_edca_turbo(dev);
 
@@ -1816,14 +1816,14 @@ void rtl92e_update_ratr_table(struct net_device *dev)
 	rtl92e_config_rate(dev, &rate_config);
 	ratr_value = rate_config | *pMcsRate << 12;
 	switch (ieee->mode) {
-	case IEEE_B:
+	case WIRELESS_MODE_B:
 		ratr_value &= 0x0000000F;
 		break;
-	case IEEE_G:
-	case IEEE_G | IEEE_B:
+	case WIRELESS_MODE_G:
+	case WIRELESS_MODE_G | WIRELESS_MODE_B:
 		ratr_value &= 0x00000FF7;
 		break;
-	case IEEE_N_24G:
+	case WIRELESS_MODE_N_24G:
 		if (ieee->ht_info->peer_mimo_ps == 0)
 			ratr_value &= 0x0007F007;
 		else
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 20c0308eb3c1..777ee2509e7d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -277,7 +277,7 @@ static void _rtl92e_update_cap(struct net_device *dev, u16 cap)
 		}
 	}
 
-	if (net->mode & (IEEE_G | IEEE_N_24G)) {
+	if (net->mode & (WIRELESS_MODE_G | WIRELESS_MODE_N_24G)) {
 		u8	slot_time_val;
 		u8	cur_slot_time = priv->slot_time;
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 219ff7685c15..70b7d7825c6d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -2104,7 +2104,7 @@ static void _rtl92e_dm_dynamic_tx_power(struct net_device *dev)
 		return;
 	}
 	if ((priv->rtllib->ht_info->IOTPeer == HT_IOT_PEER_ATHEROS) &&
-	    (priv->rtllib->mode == IEEE_G)) {
+	    (priv->rtllib->mode == WIRELESS_MODE_G)) {
 		txhipower_threshold = TX_POWER_ATHEROAP_THRESH_HIGH;
 		txlowpower_threshold = TX_POWER_ATHEROAP_THRESH_LOW;
 	} else {
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 9cbe229a601f..7ee3cb846ca1 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -424,12 +424,12 @@ static u8 HT_PickMCSRate(struct rtllib_device *ieee, u8 *pOperateMCS)
 	}
 
 	switch (ieee->mode) {
-	case IEEE_B:
-	case IEEE_G:
+	case WIRELESS_MODE_B:
+	case WIRELESS_MODE_G:
 		for (i = 0; i <= 15; i++)
 			pOperateMCS[i] = 0;
 		break;
-	case IEEE_N_24G:
+	case WIRELESS_MODE_N_24G:
 		pOperateMCS[0] &= RATE_ADPT_1SS_MASK;
 		pOperateMCS[1] &= RATE_ADPT_2SS_MASK;
 		pOperateMCS[3] &= RATE_ADPT_MCS32_MASK;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index c789f7a9d3c6..99a6501f615a 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -309,7 +309,7 @@ enum rt_op_mode {
 };
 
 #define aSifsTime						\
-	 ((priv->rtllib->current_network.mode == IEEE_N_24G) ? 16 : 10)
+	 ((priv->rtllib->current_network.mode == WIRELESS_MODE_N_24G) ? 16 : 10)
 
 #define MGMT_QUEUE_NUM 5
 
@@ -1722,10 +1722,7 @@ struct rtllib_device {
 	u8 priv[];
 };
 
-#define IEEE_B	    (1<<1)
-#define IEEE_G	    (1<<2)
-#define IEEE_N_24G		  (1<<4)
-#define IEEE_MODE_MASK    (IEEE_B | IEEE_G)
+#define IEEE_MODE_MASK    (WIRELESS_MODE_B | WIRELESS_MODE_G)
 
 /* Generate a 802.11 header */
 
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index cb13964b5181..08782336d390 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -2317,9 +2317,9 @@ static inline int rtllib_network_init(
 	network->mode = 0;
 
 	if (network->flags & NETWORK_HAS_OFDM)
-		network->mode |= IEEE_G;
+		network->mode |= WIRELESS_MODE_G;
 	if (network->flags & NETWORK_HAS_CCK)
-		network->mode |= IEEE_B;
+		network->mode |= WIRELESS_MODE_B;
 
 	if (network->mode == 0) {
 		netdev_dbg(ieee->dev, "Filtered out '%s (%pM)' network.\n",
@@ -2329,8 +2329,8 @@ static inline int rtllib_network_init(
 	}
 
 	if (network->bssht.bd_support_ht) {
-		if (network->mode & (IEEE_G | IEEE_B))
-			network->mode = IEEE_N_24G;
+		if (network->mode & (WIRELESS_MODE_G | WIRELESS_MODE_B))
+			network->mode = WIRELESS_MODE_N_24G;
 	}
 	if (rtllib_is_empty_essid(network->ssid, network->ssid_len))
 		network->flags |= NETWORK_EMPTY_ESSID;
@@ -2576,8 +2576,8 @@ static inline void rtllib_process_probe_response(
 	if (is_same_network(&ieee->current_network, network,
 	   (network->ssid_len ? 1 : 0))) {
 		update_network(ieee, &ieee->current_network, network);
-		if ((ieee->current_network.mode == IEEE_N_24G ||
-		     ieee->current_network.mode == IEEE_G) &&
+		if ((ieee->current_network.mode == WIRELESS_MODE_N_24G ||
+		     ieee->current_network.mode == WIRELESS_MODE_G) &&
 		    ieee->current_network.berp_info_valid) {
 			if (ieee->current_network.erp_value & ERP_UseProtection)
 				ieee->current_network.buseprotection = true;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 438bf0d48b75..5609d1dbcf6a 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -181,7 +181,7 @@ static u8 MgntQuery_MgntFrameTxRate(struct rtllib_device *ieee)
 		rate = ieee->basic_rate & 0x7f;
 
 	if (rate == 0) {
-		if (ieee->mode == IEEE_N_24G && !ht_info->bCurSuppCCK)
+		if (ieee->mode == WIRELESS_MODE_N_24G && !ht_info->bCurSuppCCK)
 			rate = 0x0c;
 		else
 			rate = 0x02;
@@ -802,8 +802,8 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 	else
 		atim_len = 0;
 
-	if ((ieee->current_network.mode == IEEE_G) ||
-	   (ieee->current_network.mode == IEEE_N_24G &&
+	if ((ieee->current_network.mode == WIRELESS_MODE_G) ||
+	   (ieee->current_network.mode == WIRELESS_MODE_N_24G &&
 	   ieee->ht_info->bCurSuppCCK)) {
 		erp_len = 3;
 		erpinfo_content = 0;
@@ -1470,7 +1470,7 @@ static void rtllib_associate_complete_wq(void *data)
 		netdev_info(ieee->dev, "Using G rates:%d\n", ieee->rate);
 	} else {
 		ieee->rate = 22;
-		ieee->SetWirelessMode(ieee->dev, IEEE_B);
+		ieee->SetWirelessMode(ieee->dev, WIRELESS_MODE_B);
 		netdev_info(ieee->dev, "Using B rates:%d\n", ieee->rate);
 	}
 	if (ieee->ht_info->bCurrentHTSupport && ieee->ht_info->enable_ht) {
@@ -1654,14 +1654,12 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 				    (ieee->modulation &
 				     RTLLIB_OFDM_MODULATION)) {
 					ieee->rate = 108;
-					ieee->SetWirelessMode(ieee->dev,
-							      IEEE_G);
+					ieee->SetWirelessMode(ieee->dev, WIRELESS_MODE_G);
 					netdev_info(ieee->dev,
 						    "Using G rates\n");
 				} else {
 					ieee->rate = 22;
-					ieee->SetWirelessMode(ieee->dev,
-							      IEEE_B);
+					ieee->SetWirelessMode(ieee->dev, WIRELESS_MODE_B);
 					netdev_info(ieee->dev,
 						    "Using B rates\n");
 				}
@@ -1826,8 +1824,8 @@ static inline u16 assoc_parse(struct rtllib_device *ieee, struct sk_buff *skb,
 	status_code = le16_to_cpu(response_head->status);
 	if ((status_code == WLAN_STATUS_ASSOC_DENIED_RATES ||
 	   status_code == WLAN_STATUS_CAPS_UNSUPPORTED) &&
-	   ((ieee->mode == IEEE_G) &&
-	   (ieee->current_network.mode == IEEE_N_24G) &&
+	   ((ieee->mode == WIRELESS_MODE_G) &&
+	   (ieee->current_network.mode == WIRELESS_MODE_N_24G) &&
 	   (ieee->AsocRetryCount++ < (RT_ASOC_RETRY_LIMIT - 1)))) {
 		ieee->ht_info->iot_action |= HT_IOT_ACT_PURE_N_MODE;
 	} else {
@@ -2239,10 +2237,10 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 					      ieee->current_network.mode);
 		} else {
 			/*TODO*/
-			ieee->SetWirelessMode(ieee->dev, IEEE_G);
+			ieee->SetWirelessMode(ieee->dev, WIRELESS_MODE_G);
 		}
 
-		if ((ieee->current_network.mode == IEEE_N_24G) &&
+		if ((ieee->current_network.mode == WIRELESS_MODE_N_24G) &&
 		    bHalfSupportNmode) {
 			netdev_info(ieee->dev, "======>enter half N mode\n");
 			ieee->bHalfWirelessN24GMode = true;
@@ -2498,7 +2496,7 @@ static void rtllib_start_ibss_wq(void *data)
 	}
 
 	ieee->state = RTLLIB_NOLINK;
-	ieee->mode = IEEE_G;
+	ieee->mode = WIRELESS_MODE_G;
 	/* check if we have this cell in our network list */
 	rtllib_softmac_check_all_nets(ieee);
 
@@ -2568,14 +2566,14 @@ static void rtllib_start_ibss_wq(void *data)
 		}
 
 		ieee->current_network.qos_data.supported = 0;
-		ieee->SetWirelessMode(ieee->dev, IEEE_G);
+		ieee->SetWirelessMode(ieee->dev, WIRELESS_MODE_G);
 		ieee->current_network.mode = ieee->mode;
 		ieee->current_network.atim_window = 0;
 		ieee->current_network.capability = WLAN_CAPABILITY_IBSS;
 	}
 
 	netdev_info(ieee->dev, "%s(): ieee->mode = %d\n", __func__, ieee->mode);
-	if (ieee->mode == IEEE_N_24G)
+	if (ieee->mode == WIRELESS_MODE_N_24G)
 		HTUseDefaultSetting(ieee);
 	else
 		ieee->ht_info->bCurrentHTSupport = false;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 6013ae7c6abf..8f2f0dca88e7 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -489,7 +489,7 @@ int rtllib_wx_get_name(struct rtllib_device *ieee, struct iw_request_info *info,
 {
 	const char *b = ieee->modulation & RTLLIB_CCK_MODULATION ? "b" : "";
 	const char *g = ieee->modulation & RTLLIB_OFDM_MODULATION ? "g" : "";
-	const char *n = ieee->mode & (IEEE_N_24G) ? "n" : "";
+	const char *n = ieee->mode & (WIRELESS_MODE_N_24G) ? "n" : "";
 
 	scnprintf(wrqu->name, sizeof(wrqu->name), "802.11%s%s%s", b, g, n);
 	return 0;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index c3f1910d9f58..ec038ef806c3 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -406,7 +406,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 	if (is_broadcast_ether_addr(skb->data + 16))
 		return;
 
-	if (ieee->mode < IEEE_N_24G) {
+	if (ieee->mode < WIRELESS_MODE_N_24G) {
 		if (skb->len > ieee->rts) {
 			tcb_desc->bRTSEnable = true;
 			tcb_desc->rts_rate = MGN_24M;
diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index 82b537da8b21..184eba571741 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -118,7 +118,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 			max_rate = rate;
 	}
 
-	if (network->mode >= IEEE_N_24G) {
+	if (network->mode >= WIRELESS_MODE_N_24G) {
 		struct ht_capab_ele *ht_cap = NULL;
 		bool is40M = false, isShortGI = false;
 		u8 max_mcs = 0;
-- 
2.40.1

