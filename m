Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497626C5219
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjCVRQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjCVRQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:16:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E13D664EB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:15:36 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y4so75951955edo.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679505334;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgAa8TVR2OX/unZOH2SqxHOaAsu+Q0rJ4jrl6aVUaso=;
        b=dOIyMCtrgEL4ivGPb4AKDAyxL9kGBzbcDXlkfMZI7sysakRjCTGJ9B3w1kX/4kwGKg
         MZVjYDKHWjv/zF+dwWBgU3wtOkoZI7ZWZa2bBQW8n06eKM0AIoUaPmKINL7Vmo7YBbrP
         u62zmbb13pr0lwAFdbQxg+gp5wFnGEgaGP+twreZIr/tFST4PNuqHYlAJJOzXqHciR6B
         2TNU1MXFY5d2aXmT/lnoeCIlOGOighoUKN8QFLtUnn/Fq5p4/O+nTP7VUghmWtVcAuhU
         Y4TiFzIzzaDyTT2AkgdgVG3UAOgDhKRAlLrialpeM6+dLjkmwGuarsB9VqfPr3OrAYvW
         8/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505334;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PgAa8TVR2OX/unZOH2SqxHOaAsu+Q0rJ4jrl6aVUaso=;
        b=xT7u651VRpo8awaBCIp/W3Me8Jc4cw5mOobhMME/bmKhdbLh1lND0uZnSdQqEC8i51
         C7gOdkD7Te3nIr3fmIVuDnvrkChqFUJDa7t9PvKXt9VRcOaZPMNyHY9R3ZFOOcIMvwNY
         EbKoHwPnkiwMJxD7F5ihhYvyRdyii/MFcpMl5GIk38mKkx4Gxz5deEtliErh6U2DKz8q
         PS7jrXsmVZ4mjbtNAfGzguB6Zox0jbcb3EhNw6cHPCe35tXwAV33nhPgDWk2fgXOsYh4
         orw21As9uaGaopKo945zHkqlxGsmK/i7DJzhPncUTUjPGz9Y+PGV8NEj+bxkBBlSvj93
         XRGw==
X-Gm-Message-State: AO0yUKXTsngDFJsl/kgsBIl+1ieagwaUtV7jKYtdyVCTM0orBiYI0c+k
        /lmueMaqVtejHGx+z1b1OmxbBISOa1w=
X-Google-Smtp-Source: AK7set8ACwq2SguntQdO9FmuHbmEO07JY2DEp2AcZ4Hs+yNhFr6efWNtxKY//yiV7rjRFOngmqCXTw==
X-Received: by 2002:a05:6402:2711:b0:4bb:afe3:e0a with SMTP id y17-20020a056402271100b004bbafe30e0amr8970955edd.3.1679505334307;
        Wed, 22 Mar 2023 10:15:34 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id a18-20020a50c312000000b004c06f786602sm8054214edb.85.2023.03.22.10.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:15:33 -0700 (PDT)
Date:   Wed, 22 Mar 2023 18:15:32 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] staging: rtl8192e: Replace macro
 iwe_stream_add_point_rsl with standard function
Message-ID: <563af664b3186e73d99f73a6396f8ebcd3c52be2.1679504314.git.philipp.g.hortmann@gmail.com>
References: <cover.1679504314.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1679504314.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro iwe_stream_add_point_rsl with standard function
iwe_stream_add_point to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1->V2: Changed subject line to be without “f.”
---
 drivers/staging/rtl8192e/rtllib.h    |  3 ---
 drivers/staging/rtl8192e/rtllib_wx.c | 26 ++++++++++----------------
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 81d630cf7e52..1ce4c29dab13 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -65,9 +65,6 @@
 #define container_of_dwork_rsl(x, y, z)				\
 	container_of(to_delayed_work(x), y, z)
 
-#define iwe_stream_add_point_rsl(info, start, stop, iwe, p)	\
-	iwe_stream_add_point(info, start, stop, iwe, p)
-
 static inline void *netdev_priv_rsl(struct net_device *dev)
 {
 	return netdev_priv(dev);
diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index e580cd01c201..d6691f3c7c70 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -49,16 +49,13 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 	iwe.u.data.flags = 1;
 	if (network->ssid_len > 0) {
 		iwe.u.data.length = min_t(u8, network->ssid_len, 32);
-		start = iwe_stream_add_point_rsl(info, start, stop, &iwe,
-						 network->ssid);
+		start = iwe_stream_add_point(info, start, stop, &iwe, network->ssid);
 	} else if (network->hidden_ssid_len == 0) {
 		iwe.u.data.length = sizeof("<hidden>");
-		start = iwe_stream_add_point_rsl(info, start, stop,
-						 &iwe, "<hidden>");
+		start = iwe_stream_add_point(info, start, stop, &iwe, "<hidden>");
 	} else {
 		iwe.u.data.length = min_t(u8, network->hidden_ssid_len, 32);
-		start = iwe_stream_add_point_rsl(info, start, stop, &iwe,
-						 network->hidden_ssid);
+		start = iwe_stream_add_point(info, start, stop, &iwe, network->hidden_ssid);
 	}
 	/* Add the protocol name */
 	iwe.cmd = SIOCGIWNAME;
@@ -96,8 +93,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 	else
 		iwe.u.data.flags = IW_ENCODE_DISABLED;
 	iwe.u.data.length = 0;
-	start = iwe_stream_add_point_rsl(info, start, stop,
-					 &iwe, network->ssid);
+	start = iwe_stream_add_point(info, start, stop, &iwe, network->ssid);
 	/* Add basic and extended rates */
 	max_rate = 0;
 	p = custom;
@@ -152,8 +148,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 	iwe.cmd = IWEVCUSTOM;
 	iwe.u.data.length = p - custom;
 	if (iwe.u.data.length)
-		start = iwe_stream_add_point_rsl(info, start, stop,
-						 &iwe, custom);
+		start = iwe_stream_add_point(info, start, stop, &iwe, custom);
 	/* Add quality statistics */
 	/* TODO: Fix these values... */
 	iwe.cmd = IWEVQUAL;
@@ -174,7 +169,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 	p = custom;
 	iwe.u.data.length = p - custom;
 	if (iwe.u.data.length)
-		start = iwe_stream_add_point_rsl(info, start, stop, &iwe, custom);
+		start = iwe_stream_add_point(info, start, stop, &iwe, custom);
 
 	memset(&iwe, 0, sizeof(iwe));
 	if (network->wpa_ie_len) {
@@ -183,7 +178,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 		memcpy(buf, network->wpa_ie, network->wpa_ie_len);
 		iwe.cmd = IWEVGENIE;
 		iwe.u.data.length = network->wpa_ie_len;
-		start = iwe_stream_add_point_rsl(info, start, stop, &iwe, buf);
+		start = iwe_stream_add_point(info, start, stop, &iwe, buf);
 	}
 	memset(&iwe, 0, sizeof(iwe));
 	if (network->rsn_ie_len) {
@@ -192,7 +187,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 		memcpy(buf, network->rsn_ie, network->rsn_ie_len);
 		iwe.cmd = IWEVGENIE;
 		iwe.u.data.length = network->rsn_ie_len;
-		start = iwe_stream_add_point_rsl(info, start, stop, &iwe, buf);
+		start = iwe_stream_add_point(info, start, stop, &iwe, buf);
 	}
 
 	/* add info for WZC */
@@ -203,7 +198,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 		memcpy(buf, network->wzc_ie, network->wzc_ie_len);
 		iwe.cmd = IWEVGENIE;
 		iwe.u.data.length = network->wzc_ie_len;
-		start = iwe_stream_add_point_rsl(info, start, stop, &iwe, buf);
+		start = iwe_stream_add_point(info, start, stop, &iwe, buf);
 	}
 
 	/* Add EXTRA: Age to display seconds since last beacon/probe response
@@ -216,8 +211,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 		      (100 * (jiffies - network->last_scanned)) / HZ);
 	iwe.u.data.length = p - custom;
 	if (iwe.u.data.length)
-		start = iwe_stream_add_point_rsl(info, start, stop,
-						 &iwe, custom);
+		start = iwe_stream_add_point(info, start, stop, &iwe, custom);
 
 	return start;
 }
-- 
2.39.2

