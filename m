Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF4A726399
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241010AbjFGPCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241181AbjFGPCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:02:18 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6360B2101
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:02:12 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-65314ee05c6so3535154b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 08:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686150131; x=1688742131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zG5lPa3pt3CBh78GFYF12trQ1TmiLPYaWhXfF67zHG0=;
        b=fvS9ICf7N5XMNdzgrh45C2R3ReuaMK6GJBriQnHXs0Czvd5kFAFdhB2MeUD11cgxww
         Y9juJb9+7UyrACHWPXzuyF4j3BtDCEnCpxOEaD2Zmn9+xYt9zKPCyhS54JSo3FJpeLtD
         paBmgmY+Og8RqX9BHdfL7KguvfxIsK8DXboc8CvH4tz1gk1kL3gfaV/0k8lRJ9dseVkO
         ZTay6y56HSk2Vag9sf3Ok3MqubW3yh8OX67pXgHoxS5tT14V7YcJtrZx3MQ6QiS2j0WD
         3ZOJvzK9jx7W0SFciPjJKsXqQFJjoNS2M9F8oxFpLfC5QZNxiJDwxNXvLkFothhoTuOf
         V7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686150131; x=1688742131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zG5lPa3pt3CBh78GFYF12trQ1TmiLPYaWhXfF67zHG0=;
        b=eejv+j4EK9Hx0fqcq9yxXCKmWhI38AJ49iPA+BUuduSlgtFkymrKIgxpUu2IYadT0R
         oVONjTE4MD2bY2eJADSaGZyEKst5hBnQvLHl7i3EveiseA0S2DEdqdJmAp5+mYTBiyEr
         X9xlZ3gPRGtWcd1anHuk+j7e5uuk4r4CwVmgzkF5VQEb56KBUFZoFrCD4g6ozG9gIfiU
         j9j+4/U5y00Vdvky9bMAie1njKB6sy8NHesz/1605rwBcdqcvbBOyRYNEZD1uz9bXcqi
         2apsOuju33X2AU47+IIlwr6/gQsDRSX04nxCzeHU/g4+Eo9d7hyZDw+FyNLsHIxVsM+L
         RWog==
X-Gm-Message-State: AC+VfDwdzWXGw0HenlOccPJ7mCt4LInSzFkZOE6nMgSKsVyyAj6PaQw8
        5JuqJfzxC1l6UsejpEevY+k=
X-Google-Smtp-Source: ACHHUZ6h3Y9+P1svH1XAJ9BG/1uE9rCcobjW9vR+sGhuY7lgwDoF35Dt2eX4NYdlDEjqipeESYwzBQ==
X-Received: by 2002:a05:6a00:2284:b0:64d:6c6f:84f2 with SMTP id f4-20020a056a00228400b0064d6c6f84f2mr3234856pfe.19.1686150130489;
        Wed, 07 Jun 2023 08:02:10 -0700 (PDT)
Received: from yogi-Zephyrus ([103.251.210.211])
        by smtp.gmail.com with ESMTPSA id c14-20020aa78e0e000000b0063d24fcc2besm8524214pfr.125.2023.06.07.08.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:02:10 -0700 (PDT)
Date:   Wed, 7 Jun 2023 20:32:06 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] staging: rtl8192e: Remove variable SetBWModeHandler
Message-ID: <0af9595916447a28e27c249f3696fe107382ca53.1686149467.git.yogi.kernel@gmail.com>
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

The variable SetBWModeHandler is set in only one place throughout the
driver. This patch removes the variable and calls the real function
directly instead, eliminating the unnecessary indirection.
Additionally, the removal of the variable aligns with the checkpatch
guidelines by removing the use of CamelCase.

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---

v2: Removed the variable and called the function direction instead of
    just renaming the variable as suggested by Greg Kroah-Hartman
    <gregkh@linuxfoundation.org>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 1 -
 drivers/staging/rtl8192e/rtl819x_HTProc.c    | 8 ++++----
 drivers/staging/rtl8192e/rtllib.h            | 3 ---
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 6 +++---
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index bbe0864e1348..6f6c31344441 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -717,7 +717,6 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
 	priv->rtllib->handle_assoc_response	= _rtl92e_handle_assoc_response;
 	priv->rtllib->handle_beacon		= _rtl92e_handle_beacon;
 	priv->rtllib->LeisurePSLeave		= rtl92e_leisure_ps_leave;
-	priv->rtllib->SetBWModeHandler		= rtl92e_set_bw_mode;
 	priv->rf_set_chan			= rtl92e_set_channel;
 
 	priv->rtllib->start_send_beacons = rtl92e_start_beacon;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index fe30a291e64c..ad92a8230055 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -6,6 +6,8 @@
  */
 #include "rtllib.h"
 #include "rtl819x_HT.h"
+#include "rtl8192e/r8192E_phy.h"
+
 u8 MCS_FILTER_ALL[16] = {
 	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 	0xff, 0x1f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
@@ -835,12 +837,10 @@ static void HTSetConnectBwModeCallback(struct rtllib_device *ieee)
 			ieee->set_chan(ieee->dev,
 				       ieee->current_network.channel);
 
-		ieee->SetBWModeHandler(ieee->dev, HT_CHANNEL_WIDTH_20_40,
-				       ht_info->CurSTAExtChnlOffset);
+		rtl92e_set_bw_mode(ieee->dev, HT_CHANNEL_WIDTH_20_40, ht_info->CurSTAExtChnlOffset);
 	} else {
 		ieee->set_chan(ieee->dev, ieee->current_network.channel);
-		ieee->SetBWModeHandler(ieee->dev, HT_CHANNEL_WIDTH_20,
-				       HT_EXTCHNL_OFFSET_NO_EXT);
+		rtl92e_set_bw_mode(ieee->dev, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);
 	}
 
 	ht_info->sw_bw_in_progress = false;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 68a3b8af3119..d22a586043f2 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1706,9 +1706,6 @@ struct rtllib_device {
 
 	/* check whether Tx hw resource available */
 	short (*check_nic_enough_desc)(struct net_device *dev, int queue_index);
-	void (*SetBWModeHandler)(struct net_device *dev,
-				 enum ht_channel_width bandwidth,
-				 enum ht_extchnl_offset Offset);
 	bool (*GetNmodeSupportBySecCfg)(struct net_device *dev);
 	bool (*GetHalfNmodeSupportByAPsHandler)(struct net_device *dev);
 	u8   (*rtllib_ap_sec_type)(struct rtllib_device *ieee);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index d85a32d2d050..9fb4fee93990 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -15,6 +15,7 @@
 
 #include "rtllib.h"
 #include "dot11d.h"
+#include "rtl8192e/r8192E_phy.h"
 /* FIXME: add A freqs */
 
 const long rtllib_wlan_frequencies[] = {
@@ -359,8 +360,7 @@ void rtllib_wx_sync_scan_wq(void *data)
 		b40M = 1;
 		chan_offset = ieee->ht_info->CurSTAExtChnlOffset;
 		bandwidth = (enum ht_channel_width)ieee->ht_info->bCurBW40MHz;
-		ieee->SetBWModeHandler(ieee->dev, HT_CHANNEL_WIDTH_20,
-				       HT_EXTCHNL_OFFSET_NO_EXT);
+		rtl92e_set_bw_mode(ieee->dev, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);
 	}
 
 	rtllib_start_scan_syncro(ieee, 0);
@@ -372,7 +372,7 @@ void rtllib_wx_sync_scan_wq(void *data)
 			ieee->set_chan(ieee->dev, chan - 2);
 		else
 			ieee->set_chan(ieee->dev, chan);
-		ieee->SetBWModeHandler(ieee->dev, bandwidth, chan_offset);
+		rtl92e_set_bw_mode(ieee->dev, bandwidth, chan_offset);
 	} else {
 		ieee->set_chan(ieee->dev, chan);
 	}
-- 
2.25.1

