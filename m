Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE5A6BF18C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjCQTOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjCQTOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:14:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3256CE251C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:14:15 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ek18so24261680edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679080450; x=1681672450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=50FdVkozqmiDaTptaXm+T/SPqTjp6PSR0BLk57qblb0=;
        b=T1t8o5Uj+OFyo+FA4xqSAahdXZ2IP+1B/1wJY4yKIP+XmwhwnBbbLhBZYw7DuSW9cI
         zFB4+oqwbLw4PM6SiEv2wHLKTkeOcLnoGelmGaZytPMWUVRouI0UbqtamdPSACSBYCst
         CGqEmVx7OSI4H6Q52dE0nFTtpOUONGdbbMBGwsBVDN07TVSsW9G3OI9LscTNCRdK9AYg
         x1IeTdKJBt4pJN0QqSLx2NngKkUwNaA1jli7l1pKoP7Iok2Ay9AU1ftOQttHng2aGnbT
         ILVDAmJ1q/y6zw0iTneNp4Bj7IvWbdXFJ8dsP2J/QcL+QJ6tz3baC4uKBs6pOIG/FjT5
         EJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679080450; x=1681672450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50FdVkozqmiDaTptaXm+T/SPqTjp6PSR0BLk57qblb0=;
        b=5io3D0WyuN8q/H+Ks9KMzbW7hkhq3SdgvdtQqhKp9LWs59vVYNYFrw0BHyRDG0AfxQ
         9GGMzOmrPhwqglkwqLUmZkWYooXYeKuwFLCZVytnhkm8WZU2SEF/cPTzI2kupIEFp1C0
         9g54xq256kKWUsoSiELOhD3xzvUiW3ZvyjMtLaiZc3KpMF82AyLGY4ASmAZXTWg/SmLJ
         byd3zFBb0FrXJx+XfMaWXO5DhEuBOv9qupfyJ2kl62FbwITXvFxLOOhtMq6lSz+ZWmQs
         IHTtwDeJqfeNLaYJ1GyMHtJdwozmEd+TY9iy5cbexdfJu4czlV8c9ZubhkxQfwmUtA4J
         zxww==
X-Gm-Message-State: AO0yUKXkBFhQI6CmwrR0DGjgTyMOsqLr5Rw0HLOPYUZ7vVIb87S/sgmC
        sBW60IYGXSCeAxe6BZ4Ruek=
X-Google-Smtp-Source: AK7set/rldRkyiPl/7x59TW5S1MemwG+Zss4qSco07XxjHWcEyA84A5rvDyoz/LeOG8J9s4kq29qAg==
X-Received: by 2002:a17:906:5354:b0:87c:c1:111 with SMTP id j20-20020a170906535400b0087c00c10111mr6508829ejo.4.1679080450598;
        Fri, 17 Mar 2023 12:14:10 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id v17-20020a170906339100b008e724dfc44bsm1282753eja.78.2023.03.17.12.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 12:14:10 -0700 (PDT)
Date:   Fri, 17 Mar 2023 20:14:08 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] staging: rtl8192e: Replace macro
 iwe_stream_add_point_rsl with standard f.
Message-ID: <27877d851c5afc5c226e68ebf4724c8f58486d68.1679077522.git.philipp.g.hortmann@gmail.com>
References: <cover.1679077522.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679077522.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro iwe_stream_add_point_rsl with standard function
iwe_stream_add_point to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
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

