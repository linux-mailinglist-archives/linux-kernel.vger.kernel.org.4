Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F636C5218
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjCVRQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjCVRQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:16:02 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F95637C4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:15:28 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h8so75846288ede.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679505327; x=1682097327;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUXfjO9MLExMn6IoI9J9KH+mTRK8zfSKTM2CAEavc0Q=;
        b=StizjcQ7WHtK5C9WkTHZfZVzbgeCBIoZs/U03xKRNTW3g6z5Su1ebLLig/QHnem0Rt
         lnrt/iGBcYCm9ODYVfIuZz3hkaqMYy+zkrt8/TNCGRugZBy7iV2UgX/GfPSPU4FjBc2E
         8WuWBprxLSns8Wh6t0G8KUR/OhQn/tX/VKpRs5qGPjPFGcyBIGnGIEA1VEfC8I0Arfcm
         +DuvzDVrCXa/7bhER7Iy0tAavUW+rERFgg9tiMbQuK4cPMi6+9Hc2Pj3CfA+kAkp0iOi
         pJwlDQkrIAk4fnY/pJHgPhn7KHkfyhlacr3TOEzKGQPEvIEF5U2dVugi9svrI2epibak
         D9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505327; x=1682097327;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUXfjO9MLExMn6IoI9J9KH+mTRK8zfSKTM2CAEavc0Q=;
        b=SK0m9b8NVt1C8xK54Smr33wmq7EG69fk5wX+wEo/QdT0EV37ZJidn6/+RDt+jj4wXw
         mWh3P5k8JwR+FJrrHx3f4i9N8ltoInQUwLrMG2TC+kiHXYeIcyxwgtRNhxNev8WElaQG
         d7cy/OBXlPAjLAkwlYbwxufDOKdh5cbW78RFyONRgvy0t1k8oNb+VuNIC7Px1+qMjVQl
         k1l0QTH0biTEYplVeapVorCX6CqwHEixDx6+Rs8GSUj+HhRNFNNA5ShmdW4TqykcQxb/
         lGIKHj7djBKZbFBZ0iXP5UGnLTRhDiQBSkMMycG1bZT4ru3BpMc9dXd90wVEV1LNJlEb
         9+Sg==
X-Gm-Message-State: AO0yUKUcf7Y3BvrcnAZsaaYONQZpv9aVkuqGrHqCC1E2j7LNQKpomZyF
        XFPlAG4/9gPXjJtcGjfBZAw=
X-Google-Smtp-Source: AK7set+3A/hNGGINr2P2D/xVNkf3ePrjH6RFD2x2Wdd7V4LJUOVPf8zZcERsfcF423/cyk/JA4Nu/Q==
X-Received: by 2002:a17:906:224f:b0:92e:f520:7762 with SMTP id 15-20020a170906224f00b0092ef5207762mr6720088ejr.6.1679505326925;
        Wed, 22 Mar 2023 10:15:26 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id lc5-20020a170906dfe500b0092973e209f2sm7451911ejc.109.2023.03.22.10.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:15:26 -0700 (PDT)
Date:   Wed, 22 Mar 2023 18:15:24 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] staging: rtl8192e: Replace macro
 iwe_stream_add_event_rsl with standard function
Message-ID: <00a8057acc994c139530a070974694b999a8f96a.1679504314.git.philipp.g.hortmann@gmail.com>
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

Replace macro iwe_stream_add_event_rsl with standard function
iwe_stream_add_event to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1->V2: Changed subject line to be without “f.”
---
 drivers/staging/rtl8192e/rtllib.h    |  3 ---
 drivers/staging/rtl8192e/rtllib_wx.c | 16 ++++++----------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 669a9d9a5d18..81d630cf7e52 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -65,9 +65,6 @@
 #define container_of_dwork_rsl(x, y, z)				\
 	container_of(to_delayed_work(x), y, z)
 
-#define iwe_stream_add_event_rsl(info, start, stop, iwe, len)	\
-	iwe_stream_add_event(info, start, stop, iwe, len)
-
 #define iwe_stream_add_point_rsl(info, start, stop, iwe, p)	\
 	iwe_stream_add_point(info, start, stop, iwe, p)
 
diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index 217426ee2e92..e580cd01c201 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -41,8 +41,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 	iwe.cmd = SIOCGIWAP;
 	iwe.u.ap_addr.sa_family = ARPHRD_ETHER;
 	ether_addr_copy(iwe.u.ap_addr.sa_data, network->bssid);
-	start = iwe_stream_add_event_rsl(info, start, stop,
-					 &iwe, IW_EV_ADDR_LEN);
+	start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_ADDR_LEN);
 	/* Remaining entries will be displayed in the order we provide them */
 
 	/* Add the ESSID */
@@ -71,8 +70,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 	}
 	*pname = '\0';
 	snprintf(iwe.u.name, IFNAMSIZ, "IEEE802.11%s", proto_name);
-	start = iwe_stream_add_event_rsl(info, start, stop,
-					 &iwe, IW_EV_CHAR_LEN);
+	start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_CHAR_LEN);
 	/* Add mode */
 	iwe.cmd = SIOCGIWMODE;
 	if (network->capability &
@@ -81,8 +79,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 			iwe.u.mode = IW_MODE_MASTER;
 		else
 			iwe.u.mode = IW_MODE_ADHOC;
-		start = iwe_stream_add_event_rsl(info, start, stop,
-						 &iwe, IW_EV_UINT_LEN);
+		start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_UINT_LEN);
 	}
 
 	/* Add frequency/channel */
@@ -90,8 +87,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 	iwe.u.freq.m = network->channel;
 	iwe.u.freq.e = 0;
 	iwe.u.freq.i = 0;
-	start = iwe_stream_add_event_rsl(info, start, stop, &iwe,
-					 IW_EV_FREQ_LEN);
+	start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_FREQ_LEN);
 
 	/* Add encryption capability */
 	iwe.cmd = SIOCGIWENCODE;
@@ -152,7 +148,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 	iwe.u.bitrate.disabled = 0;
 	iwe.u.bitrate.fixed = 0;
 	iwe.u.bitrate.value = max_rate * 500000;
-	start = iwe_stream_add_event_rsl(info, start, stop, &iwe, IW_EV_PARAM_LEN);
+	start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_PARAM_LEN);
 	iwe.cmd = IWEVCUSTOM;
 	iwe.u.data.length = p - custom;
 	if (iwe.u.data.length)
@@ -172,7 +168,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 	if (!(network->stats.mask & RTLLIB_STATMASK_SIGNAL))
 		iwe.u.qual.updated |= IW_QUAL_QUAL_INVALID;
 	iwe.u.qual.updated = 7;
-	start = iwe_stream_add_event_rsl(info, start, stop, &iwe, IW_EV_QUAL_LEN);
+	start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_QUAL_LEN);
 
 	iwe.cmd = IWEVCUSTOM;
 	p = custom;
-- 
2.39.2

