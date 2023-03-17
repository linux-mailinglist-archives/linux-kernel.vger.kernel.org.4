Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613696BF18B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjCQTOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjCQTOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:14:30 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24211E41F9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:14:04 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z21so24304265edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679080442; x=1681672442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zMLQ0SN7sIsh/JIte5hM0vfAsuLvo6gietIEQs9gOFU=;
        b=OZOgP/+Cvhi+vHyNjHTbDxAkYajhYcjB19aGGIqpKS1bUJJlumsURP8Juix2wf2n3h
         l1U6A87+cHfwAr67bIcfPObj7t39ZUVTQ0FyEPEfVr573drLmuGsNZQ5+71EsiIgMaOB
         Cx/R9CV2ZnTr13OeFN5JiPUcFW+lVNLn7qjKB6BFtCZmC4zYxOoCGJ8/Cu5079yHgERp
         CxQYDaRz7ts/iKT1Tog0mgAuXWDbWzkNUuU0S1QBQGtSanazo23X4LgdK8YjsWd77eGW
         sTj6YjQwSMX5j+YyV+6lWogs5oIfzwE2jQR5glJkLHgl4MFMmNYCrCBKWdvGdoYr5pge
         ZzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679080442; x=1681672442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMLQ0SN7sIsh/JIte5hM0vfAsuLvo6gietIEQs9gOFU=;
        b=GEHmq1/cB/+mdEmwxOxSPLn7c7SGPsAI9PLO/aA0XaI8Vg3M5Qn1ow7jZ6aUvG99hA
         Wvct0R80fGUuJQx5sVGu0IuMs6XjC8y5eYaO1+ZIbb0sx8LaWDzzt7gSIVpQ3F9qMp+J
         HRvfvXomiTqNBY2zCntaEXJG3smJ+Ac6g4KL/z/JQAmfBO+1MxE1qqt+v7AyhlRZRrWU
         DItQVUjf9dyArzrg5h7EJtC5jL9zGXb2afdvZGGwG4Xn/+vu+gkGnPnSRcExKyhZFGki
         RHwtOJERywIoGzCj4eUxgeA/JAuk3tJ8mehdv9Y+9qTe43tvMeFnOtZMbAHrCQWlswBZ
         P9vA==
X-Gm-Message-State: AO0yUKWS2tfHMaUNhjtgxmK9+x0uPEb0j7h/3mW5b5Y2d6hyCZOrz2u/
        Lxgt9nu8Bqfj2qcSZBNb5oM=
X-Google-Smtp-Source: AK7set/kFo1jGn/K8eqbTjGGFC3nPmOdpJeJ8gQrbx3xQhLJ2uQKjLizg7lEpiEmqZGgGxYQQ/Fu8w==
X-Received: by 2002:a17:906:10d7:b0:930:aa02:f9cf with SMTP id v23-20020a17090610d700b00930aa02f9cfmr5419945ejv.2.1679080442097;
        Fri, 17 Mar 2023 12:14:02 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090626c400b00924916f9c21sm1276025ejc.87.2023.03.17.12.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 12:14:01 -0700 (PDT)
Date:   Fri, 17 Mar 2023 20:13:59 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] staging: rtl8192e: Replace macro
 iwe_stream_add_event_rsl with standard f.
Message-ID: <a5263c995eb94cba5596f751e83612f37970dfae.1679077522.git.philipp.g.hortmann@gmail.com>
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

Replace macro iwe_stream_add_event_rsl with standard function
iwe_stream_add_event to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
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

