Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A0273C709
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 08:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjFXGEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 02:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjFXGEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 02:04:24 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DDF273E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:04:11 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-98502b12fd4so30977466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687586649; x=1690178649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g5G3FVlCyqn63CYhl0DzmSuIziSgLL1eeoVVmuGLO64=;
        b=JFTgUaF0Iyqv+0trbfpYbYGVikT6eeHoKAhZtKqeseNVl9T4VSML3k/8pEOFWj3fKh
         VxaJtDipH9I+57zVWPG+/PwielTptyDOdsS4Itmgw6kOUG6RXItX2j/vEpfJBxPZPDdo
         hu43ISwB6SbfxoCvNS/yXTcscWUR6LYM5XLqpuqETwpHk8eE5YYSUJcJhGNvLml8bd+i
         mOE3JQGVUgfbL/yfHo9uqnQljyMLbifAVBDE2RwnTlAzlKvwWwaxzLnbwrDysyDuLbHi
         Fj2U1F5Qfk/7TbtQ3V9RhmzAVzHt4Qxf1WrtQzncyQYGTlD/m6Mr5E1DM84JUR6/RoUI
         eMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687586649; x=1690178649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5G3FVlCyqn63CYhl0DzmSuIziSgLL1eeoVVmuGLO64=;
        b=SSdGCHEUbwaQNMwTScAHPed7tugbLR0UuUKVSs3w3nvPMA+oo69hJrrnUQXTCLSavL
         CF2cwZ1J3n3SOeEkhAiIr9LexxZDMn7ofT2ymNrNiqXE4g3AoH2h0ynVvaaaogMhyo2Q
         NF60yZdNDw6e10YdvMAbeTzWlGDMa2oPfpv6AnG5moy77xih/SHQA/KgBqXhoJqlM4sV
         Mo+BLXnBh8BPSvQmjhLhbhZpvRRhJGEevIsX0qS7EyMGgBKCaciZPnu9kgms0HPVBmv0
         eJalYeB5f/jAHw7cZ8AjCV8E48j939B923G9nsjOVPMXRhPn+vo1+VY6JLSpYSOEYAdK
         ugfw==
X-Gm-Message-State: AC+VfDwg846hHarOzs/hmX2a3AxNlPEpctTAoq343I49oPfZ91TOMqNH
        9bV9VXdgOmbN0a9G0WS1VSM=
X-Google-Smtp-Source: ACHHUZ6QolQYsLgTtmwGbQQDdtdhMMzk4sp85rd9nFBWiuD41+Qe/TDRy5Vye9p5XMLG0xsmesR5+w==
X-Received: by 2002:a17:906:7a5e:b0:987:6960:36c6 with SMTP id i30-20020a1709067a5e00b00987696036c6mr15024649ejo.5.1687586649126;
        Fri, 23 Jun 2023 23:04:09 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id qq28-20020a17090720dc00b009891da61b1asm501984ejb.44.2023.06.23.23.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 23:04:07 -0700 (PDT)
Date:   Sat, 24 Jun 2023 08:04:05 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] staging: rtl8192e: Remove variable modulation as it is
 constant
Message-ID: <ebd543d097a65f105078c71faceaed2a4d5e7b55.1687583718.git.philipp.g.hortmann@gmail.com>
References: <cover.1687583718.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687583718.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ieee->modulation is initialized to 3 and then unchanged. All evaluations
will result accordingly. Remove resulting dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |   2 -
 drivers/staging/rtl8192e/rtllib.h            |   1 -
 drivers/staging/rtl8192e/rtllib_softmac.c    | 121 ++++++++-----------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c |   4 +-
 4 files changed, 50 insertions(+), 78 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 4447489a16ea..cb0753f6fb18 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -804,8 +804,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->rtllib->iw_mode = IW_MODE_INFRA;
 	priv->rtllib->active_scan = 1;
 	priv->rtllib->be_scan_inprogress = false;
-	priv->rtllib->modulation = RTLLIB_CCK_MODULATION |
-				   RTLLIB_OFDM_MODULATION;
 	priv->rtllib->host_encrypt = 1;
 	priv->rtllib->host_decrypt = 1;
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index e3ce4431d460..fdb7990130b5 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1492,7 +1492,6 @@ struct rtllib_device {
 
 	int short_slot;
 	int mode;       /* A, B, G */
-	int modulation; /* CCK, OFDM */
 
 	/* used for forcing the ibss workqueue to terminate
 	 * without wait for the syncro scan to terminate
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 425d4acbcdf0..c1e5127f5251 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -35,12 +35,8 @@ static unsigned int rtllib_MFIE_rate_len(struct rtllib_device *ieee)
 {
 	unsigned int rate_len = 0;
 
-	if (ieee->modulation & RTLLIB_CCK_MODULATION)
-		rate_len = RTLLIB_CCK_RATE_LEN + 2;
-
-	if (ieee->modulation & RTLLIB_OFDM_MODULATION)
-
-		rate_len += RTLLIB_OFDM_RATE_LEN + 2;
+	rate_len = RTLLIB_CCK_RATE_LEN + 2;
+	rate_len += RTLLIB_OFDM_RATE_LEN + 2;
 
 	return rate_len;
 }
@@ -53,14 +49,12 @@ static void rtllib_MFIE_Brate(struct rtllib_device *ieee, u8 **tag_p)
 {
 	u8 *tag = *tag_p;
 
-	if (ieee->modulation & RTLLIB_CCK_MODULATION) {
-		*tag++ = MFIE_TYPE_RATES;
-		*tag++ = 4;
-		*tag++ = RTLLIB_BASIC_RATE_MASK | RTLLIB_CCK_RATE_1MB;
-		*tag++ = RTLLIB_BASIC_RATE_MASK | RTLLIB_CCK_RATE_2MB;
-		*tag++ = RTLLIB_BASIC_RATE_MASK | RTLLIB_CCK_RATE_5MB;
-		*tag++ = RTLLIB_BASIC_RATE_MASK | RTLLIB_CCK_RATE_11MB;
-	}
+	*tag++ = MFIE_TYPE_RATES;
+	*tag++ = 4;
+	*tag++ = RTLLIB_BASIC_RATE_MASK | RTLLIB_CCK_RATE_1MB;
+	*tag++ = RTLLIB_BASIC_RATE_MASK | RTLLIB_CCK_RATE_2MB;
+	*tag++ = RTLLIB_BASIC_RATE_MASK | RTLLIB_CCK_RATE_5MB;
+	*tag++ = RTLLIB_BASIC_RATE_MASK | RTLLIB_CCK_RATE_11MB;
 
 	/* We may add an option for custom rates that specific HW
 	 * might support
@@ -72,18 +66,17 @@ static void rtllib_MFIE_Grate(struct rtllib_device *ieee, u8 **tag_p)
 {
 	u8 *tag = *tag_p;
 
-	if (ieee->modulation & RTLLIB_OFDM_MODULATION) {
-		*tag++ = MFIE_TYPE_RATES_EX;
-		*tag++ = 8;
-		*tag++ = RTLLIB_BASIC_RATE_MASK | RTLLIB_OFDM_RATE_6MB;
-		*tag++ = RTLLIB_BASIC_RATE_MASK | RTLLIB_OFDM_RATE_9MB;
-		*tag++ = RTLLIB_BASIC_RATE_MASK | RTLLIB_OFDM_RATE_12MB;
-		*tag++ = RTLLIB_BASIC_RATE_MASK | RTLLIB_OFDM_RATE_18MB;
-		*tag++ = RTLLIB_BASIC_RATE_MASK | RTLLIB_OFDM_RATE_24MB;
-		*tag++ = RTLLIB_BASIC_RATE_MASK | RTLLIB_OFDM_RATE_36MB;
-		*tag++ = RTLLIB_BASIC_RATE_MASK | RTLLIB_OFDM_RATE_48MB;
-		*tag++ = RTLLIB_BASIC_RATE_MASK | RTLLIB_OFDM_RATE_54MB;
-	}
+	*tag++ = MFIE_TYPE_RATES_EX;
+	*tag++ = 8;
+	*tag++ = RTLLIB_BASIC_RATE_MASK | RTLLIB_OFDM_RATE_6MB;
+	*tag++ = RTLLIB_BASIC_RATE_MASK | RTLLIB_OFDM_RATE_9MB;
+	*tag++ = RTLLIB_BASIC_RATE_MASK | RTLLIB_OFDM_RATE_12MB;
+	*tag++ = RTLLIB_BASIC_RATE_MASK | RTLLIB_OFDM_RATE_18MB;
+	*tag++ = RTLLIB_BASIC_RATE_MASK | RTLLIB_OFDM_RATE_24MB;
+	*tag++ = RTLLIB_BASIC_RATE_MASK | RTLLIB_OFDM_RATE_36MB;
+	*tag++ = RTLLIB_BASIC_RATE_MASK | RTLLIB_OFDM_RATE_48MB;
+	*tag++ = RTLLIB_BASIC_RATE_MASK | RTLLIB_OFDM_RATE_54MB;
+
 	/* We may add an option for custom rates that specific HW might
 	 * support
 	 */
@@ -1465,8 +1458,7 @@ static void rtllib_associate_complete_wq(void *data)
 
 	netif_carrier_on(ieee->dev);
 	ieee->is_roaming = false;
-	if (rtllib_is_54g(&ieee->current_network) &&
-	   (ieee->modulation & RTLLIB_OFDM_MODULATION)) {
+	if (rtllib_is_54g(&ieee->current_network)) {
 		ieee->rate = 108;
 		netdev_info(ieee->dev, "Using G rates:%d\n", ieee->rate);
 	} else {
@@ -1652,9 +1644,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 				schedule_delayed_work(
 					   &ieee->associate_procedure_wq, 0);
 			} else {
-				if (rtllib_is_54g(&ieee->current_network) &&
-				    (ieee->modulation &
-				     RTLLIB_OFDM_MODULATION)) {
+				if (rtllib_is_54g(&ieee->current_network)) {
 					ieee->rate = 108;
 					ieee->set_wireless_mode(ieee->dev, WIRELESS_MODE_G);
 					netdev_info(ieee->dev,
@@ -2526,47 +2516,34 @@ static void rtllib_start_ibss_wq(void *data)
 		if (!ieee->wap_set)
 			eth_random_addr(ieee->current_network.bssid);
 
-		if (ieee->modulation & RTLLIB_CCK_MODULATION) {
-			ieee->current_network.rates_len = 4;
-
-			ieee->current_network.rates[0] =
-				 RTLLIB_BASIC_RATE_MASK | RTLLIB_CCK_RATE_1MB;
-			ieee->current_network.rates[1] =
-				 RTLLIB_BASIC_RATE_MASK | RTLLIB_CCK_RATE_2MB;
-			ieee->current_network.rates[2] =
-				 RTLLIB_BASIC_RATE_MASK | RTLLIB_CCK_RATE_5MB;
-			ieee->current_network.rates[3] =
-				 RTLLIB_BASIC_RATE_MASK | RTLLIB_CCK_RATE_11MB;
-
-		} else {
-			ieee->current_network.rates_len = 0;
-		}
-
-		if (ieee->modulation & RTLLIB_OFDM_MODULATION) {
-			ieee->current_network.rates_ex_len = 8;
-
-			ieee->current_network.rates_ex[0] =
-						 RTLLIB_OFDM_RATE_6MB;
-			ieee->current_network.rates_ex[1] =
-						 RTLLIB_OFDM_RATE_9MB;
-			ieee->current_network.rates_ex[2] =
-						 RTLLIB_OFDM_RATE_12MB;
-			ieee->current_network.rates_ex[3] =
-						 RTLLIB_OFDM_RATE_18MB;
-			ieee->current_network.rates_ex[4] =
-						 RTLLIB_OFDM_RATE_24MB;
-			ieee->current_network.rates_ex[5] =
-						 RTLLIB_OFDM_RATE_36MB;
-			ieee->current_network.rates_ex[6] =
-						 RTLLIB_OFDM_RATE_48MB;
-			ieee->current_network.rates_ex[7] =
-						 RTLLIB_OFDM_RATE_54MB;
-
-			ieee->rate = 108;
-		} else {
-			ieee->current_network.rates_ex_len = 0;
-			ieee->rate = 22;
-		}
+		ieee->current_network.rates_len = 4;
+		ieee->current_network.rates[0] =
+			RTLLIB_BASIC_RATE_MASK | RTLLIB_CCK_RATE_1MB;
+		ieee->current_network.rates[1] =
+			RTLLIB_BASIC_RATE_MASK | RTLLIB_CCK_RATE_2MB;
+		ieee->current_network.rates[2] =
+			RTLLIB_BASIC_RATE_MASK | RTLLIB_CCK_RATE_5MB;
+		ieee->current_network.rates[3] =
+			RTLLIB_BASIC_RATE_MASK | RTLLIB_CCK_RATE_11MB;
+
+		ieee->current_network.rates_ex_len = 8;
+		ieee->current_network.rates_ex[0] =
+			RTLLIB_OFDM_RATE_6MB;
+		ieee->current_network.rates_ex[1] =
+			RTLLIB_OFDM_RATE_9MB;
+		ieee->current_network.rates_ex[2] =
+			RTLLIB_OFDM_RATE_12MB;
+		ieee->current_network.rates_ex[3] =
+			RTLLIB_OFDM_RATE_18MB;
+		ieee->current_network.rates_ex[4] =
+			RTLLIB_OFDM_RATE_24MB;
+		ieee->current_network.rates_ex[5] =
+			RTLLIB_OFDM_RATE_36MB;
+		ieee->current_network.rates_ex[6] =
+			RTLLIB_OFDM_RATE_48MB;
+		ieee->current_network.rates_ex[7] =
+			RTLLIB_OFDM_RATE_54MB;
+		ieee->rate = 108;
 
 		ieee->current_network.qos_data.supported = 0;
 		ieee->set_wireless_mode(ieee->dev, WIRELESS_MODE_G);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 2de63d1f2009..1a7575ab9d6d 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -487,11 +487,9 @@ EXPORT_SYMBOL(rtllib_wx_set_rawtx);
 int rtllib_wx_get_name(struct rtllib_device *ieee, struct iw_request_info *info,
 		       union iwreq_data *wrqu, char *extra)
 {
-	const char *b = ieee->modulation & RTLLIB_CCK_MODULATION ? "b" : "";
-	const char *g = ieee->modulation & RTLLIB_OFDM_MODULATION ? "g" : "";
 	const char *n = ieee->mode & (WIRELESS_MODE_N_24G) ? "n" : "";
 
-	scnprintf(wrqu->name, sizeof(wrqu->name), "802.11%s%s%s", b, g, n);
+	scnprintf(wrqu->name, sizeof(wrqu->name), "802.11bg%s", n);
 	return 0;
 }
 EXPORT_SYMBOL(rtllib_wx_get_name);
-- 
2.41.0

