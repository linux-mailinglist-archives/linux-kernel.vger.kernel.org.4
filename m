Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCE9726396
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240989AbjFGPB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241010AbjFGPBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:01:49 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9741FCE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:01:46 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-651e298be3fso7364855b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 08:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686150105; x=1688742105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lESAI44jK8lmdOmkk5nFnrQMYUILCez8k/el0obunUU=;
        b=cbMzcV5Cw0osxGhAezosV9ljOtfaU9OauaLrcoXOALU+qc8nULFnG/ku+12tzlgADH
         qPCtrcZBg2u6SAkBXAI5C4y/Vq307naZ74laDdP73+HpvrSGIVNDDf9DxCeWpSrJ5c4j
         aYQ5/YgPo0eOCDV1nNnyZ3g6V8YglQUhj0xAvVW/e7k8/9kkb6Bp1ZTRotED90hNfwAK
         K+Dw0rTLraaaM/2eCqM6LfGyCq8foEIXJWSzK0qtdhIo5FW4xOMhvO5U7aqaMTe0mjGJ
         JySf/nps6k3eb4pfLtp0Qp+qlg2uE1XDnziSfUWAkXm0cPJ3lrLEV7hHcw6E22roPNTt
         zSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686150105; x=1688742105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lESAI44jK8lmdOmkk5nFnrQMYUILCez8k/el0obunUU=;
        b=JhpOzB7BmsEzbsr3WvVoZTFuJyqnfu6dosy4i9jilkdJ2rqe7aKy7OE3r5iskvgtP6
         MOCHVfG8iDhfbcre1XhxDGap54SuMeQpgDaJ3Skt8sTSGdXDeb3LdBUZUBntoo7a8/P2
         pCJBH2Hz6MN5KRpxC3BmBe08NoHbZ5YoyhHQ9NgDGgM/rmah+5PMnIHk0d5q2gU9mKPI
         /YtVCChbFOegFRkIKbcBfeiT4eECgZhazusaGpXQofp+rhlAjrnhXzN1FMVbZw2MW9Su
         72WY21vTvqBHO9E2w3+c+9OhLtkTH3ZU2esf7603HgdLhHoeFbckPEJONLF2TfOvcKhn
         J/sw==
X-Gm-Message-State: AC+VfDyvIkzdNqNIr8e2/OY7/8Ol296Y0Hp8/Ijq7CDmwWl1CL2edWBs
        WRrwGpJLPA9tAhoeKo3boPE=
X-Google-Smtp-Source: ACHHUZ5bA4LaskD3jId1gka+sSU5c2YwDpMXXw2xTQN7TA68HiIT2X3O9E8oSmphVjxG/QzxOiW5Iw==
X-Received: by 2002:a05:6a00:1782:b0:662:56b4:c2f2 with SMTP id s2-20020a056a00178200b0066256b4c2f2mr1648793pfg.25.1686150105470;
        Wed, 07 Jun 2023 08:01:45 -0700 (PDT)
Received: from yogi-Zephyrus ([103.251.210.211])
        by smtp.gmail.com with ESMTPSA id c14-20020aa78e0e000000b0063d24fcc2besm8523788pfr.125.2023.06.07.08.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:01:45 -0700 (PDT)
Date:   Wed, 7 Jun 2023 20:31:41 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] staging: rtl8192e: Remove variable SetWirelessMode
Message-ID: <fba56522e419351b05e33df8cd0ac31806534d8c.1686149467.git.yogi.kernel@gmail.com>
References: <cover.1686149467.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686149467.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable SetWirelessMode is set in only one place throughout the
driver. This patch removes the variable and calls the real function
directly instead, eliminating the unnecessary indirection.
Additionally, the removal of the variable aligns with the checkpatch
guidelines by removing the use of CamelCase.

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---

v2: Removed the variable and called the function direction instead of
    just renaming the variable as suggested by Greg Kroah-Hartman
    <gregkh@linuxfoundation.org>.
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  1 -
 drivers/staging/rtl8192e/rtllib.h            |  1 -
 drivers/staging/rtl8192e/rtllib_softmac.c    | 16 +++++++---------
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 17b70dde7eeb..bbe0864e1348 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -716,7 +716,6 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
 	priv->rtllib->check_nic_enough_desc	= _rtl92e_check_nic_enough_desc;
 	priv->rtllib->handle_assoc_response	= _rtl92e_handle_assoc_response;
 	priv->rtllib->handle_beacon		= _rtl92e_handle_beacon;
-	priv->rtllib->SetWirelessMode		= rtl92e_set_wireless_mode;
 	priv->rtllib->LeisurePSLeave		= rtl92e_leisure_ps_leave;
 	priv->rtllib->SetBWModeHandler		= rtl92e_set_bw_mode;
 	priv->rf_set_chan			= rtl92e_set_channel;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 4aa5ce9f7792..68a3b8af3119 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1710,7 +1710,6 @@ struct rtllib_device {
 				 enum ht_channel_width bandwidth,
 				 enum ht_extchnl_offset Offset);
 	bool (*GetNmodeSupportBySecCfg)(struct net_device *dev);
-	void (*SetWirelessMode)(struct net_device *dev, u8 wireless_mode);
 	bool (*GetHalfNmodeSupportByAPsHandler)(struct net_device *dev);
 	u8   (*rtllib_ap_sec_type)(struct rtllib_device *ieee);
 	void (*InitialGainHandler)(struct net_device *dev, u8 Operation);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 7c4cba6dcf46..ed171eca4916 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -19,6 +19,7 @@
 #include <linux/etherdevice.h>
 #include <linux/ieee80211.h>
 #include "dot11d.h"
+#include "rtl8192e/rtl_core.h"
 
 static void rtllib_sta_wakeup(struct rtllib_device *ieee, short nl);
 
@@ -1503,7 +1504,7 @@ static void rtllib_associate_complete_wq(void *data)
 		netdev_info(ieee->dev, "Using G rates:%d\n", ieee->rate);
 	} else {
 		ieee->rate = 22;
-		ieee->SetWirelessMode(ieee->dev, IEEE_B);
+		rtl92e_set_wireless_mode(ieee->dev, IEEE_B);
 		netdev_info(ieee->dev, "Using B rates:%d\n", ieee->rate);
 	}
 	if (ieee->ht_info->bCurrentHTSupport && ieee->ht_info->enable_ht) {
@@ -1687,14 +1688,12 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 				    (ieee->modulation &
 				     RTLLIB_OFDM_MODULATION)) {
 					ieee->rate = 108;
-					ieee->SetWirelessMode(ieee->dev,
-							      IEEE_G);
+					rtl92e_set_wireless_mode(ieee->dev, IEEE_G);
 					netdev_info(ieee->dev,
 						    "Using G rates\n");
 				} else {
 					ieee->rate = 22;
-					ieee->SetWirelessMode(ieee->dev,
-							      IEEE_B);
+					rtl92e_set_wireless_mode(ieee->dev, IEEE_B);
 					netdev_info(ieee->dev,
 						    "Using B rates\n");
 				}
@@ -2276,11 +2275,10 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 		}
 		/* Dummy wirless mode setting to avoid encryption issue */
 		if (bSupportNmode) {
-			ieee->SetWirelessMode(ieee->dev,
-					      ieee->current_network.mode);
+			rtl92e_set_wireless_mode(ieee->dev, ieee->current_network.mode);
 		} else {
 			/*TODO*/
-			ieee->SetWirelessMode(ieee->dev, IEEE_G);
+			rtl92e_set_wireless_mode(ieee->dev, IEEE_G);
 		}
 
 		if ((ieee->current_network.mode == IEEE_N_24G) &&
@@ -2615,7 +2613,7 @@ static void rtllib_start_ibss_wq(void *data)
 		}
 
 		ieee->current_network.qos_data.supported = 0;
-		ieee->SetWirelessMode(ieee->dev, IEEE_G);
+		rtl92e_set_wireless_mode(ieee->dev, IEEE_G);
 		ieee->current_network.mode = ieee->mode;
 		ieee->current_network.atim_window = 0;
 		ieee->current_network.capability = WLAN_CAPABILITY_IBSS;
-- 
2.25.1

