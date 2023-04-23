Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC636EC058
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjDWOWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjDWOW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:22:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35DEB9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:22:23 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-246eebbde1cso3100229a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682259743; x=1684851743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SzOu+Yuals4xOY+oHNYGjX4zD/G3dXcRaRKK7UhEW+4=;
        b=qgToE19+ZDmzMwnxB74VMCCo/QzL9mKrHmvnXsR7h/QctR3dqgRN/94YCa5p177iPw
         p+skWGZiMkHNAwZamvf6i7WCRb8TMMp1Vey92470KVGqrlvi8W44Qh4wCSBqbLbQau0W
         e1sYXFSLjLf/33lAAtXg3PD0QRNDFIPHiPUIEpYGs8iIy1yFI5GN35lvu+qIKTckcru/
         Bm4I75UcIEwLM4fg0KPuC2fWURQITSuE8uKt7xUUu+sPWq8teJ5Wax805emBAQCgZc/8
         xJEsx48r8KEEWCSC2ksZNop17Nv6eTsEfQlo61xhy1AMZoCesCW25Xb4Vr9k8/TmkOnF
         jymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682259743; x=1684851743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzOu+Yuals4xOY+oHNYGjX4zD/G3dXcRaRKK7UhEW+4=;
        b=WxErN12SCykjz2Z5Amw3TApA+OSEMDKGMVDNAbJffhuhcQFSwFRbvLoePJEvoZArzS
         rlMSYExw5VVFKa3E5plTwHtpd6c85DKLY2XUgu3J2KfLEYd+XqX6WGpuJE5BeVO0nR1K
         BgBQJRHEFDv8AeKaDSICJQC6v2BIjy30m9f4hJ0H5u4nQwZG1y1IQfUs4cFidjYxbca+
         UXnA84oB5prBtlD4FndUTMoT0yLYjiC+r0ZadPYMJzc7jNbmEB0NsEfdUFmgAzrNr9Ry
         WCJeehZm3+SgtRkiNN+ZevOO4gKjVUcU0TU6yB1hJRwSD9i02EuUCqFJJdWbyqC3abGf
         R4QA==
X-Gm-Message-State: AAQBX9et2IE9NaGMrwk0NIWtcfcoA0OfmqcXI4pGdn8m6RqcpZtKHhqj
        0Da8TWbputlJST6hQZfVyOA=
X-Google-Smtp-Source: AKy350bQkd79axEqnU0lZ18XD63JuZer1trKSoQmlwofymsSzcYhhyr/sST+A4QkuPOy3XWhlZr7qA==
X-Received: by 2002:a17:90b:238f:b0:246:c223:14ab with SMTP id mr15-20020a17090b238f00b00246c22314abmr10900361pjb.41.1682259743383;
        Sun, 23 Apr 2023 07:22:23 -0700 (PDT)
Received: from pop-os.localdomain ([103.251.210.208])
        by smtp.gmail.com with ESMTPSA id k14-20020a170902760e00b001a972e9d4f4sm667337pll.102.2023.04.23.07.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 07:22:23 -0700 (PDT)
Date:   Sun, 23 Apr 2023 19:52:18 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] staging: rtl8192e: Remove unused rf_set_sens variable
Message-ID: <ab3604dff9c7defd400e394f8fbf07e5867cffef.1682257566.git.yogi.kernel@gmail.com>
References: <cover.1682257566.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1682257566.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rf_set_sens variable is declared but never set, so it is always NULL.
This commit cleans up the unused rf_set_sens variable and removes the
associated code that relied on it.

Specifically, the following changes have been made:
- Removed the `range->sensitivity` assignment, which was never used.
- Removed the sensitivity level get implementation, which always returns
  an error code.
- Removed the sensitivity level set implementation, which always returns
  an error code.
- Removed the `rf_set_sens` variable.

Suggested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---

Changes in v4:
    1. Split changes into patch series per feedback from
       gregkh@linuxfoundation.org

Changes in v3:
    1. Fixed description to fit within 75 chars
    2. Added suggested tags
    per feedback from philipp.g.hortmann@gmail.com

Changes in v2:
    1. Removed function definition rf_set_sens
    2. Removed usage of variable priv->rf_set_sens
    3. Removed functions _rtl92e_wx_get_sens and _rtl92e_wx_set_sens
    4. Cleaned up the variables sens and max_sens used in these functions

Changes in v1:
    1. Fix comparison to NULL of variable rf_set_sens
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   | 19 ++-----------------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 285dac32c074..08145e1f814c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -231,7 +231,6 @@ struct r8192_priv {
 	struct rt_stats stats;
 	struct iw_statistics			wstats;
 
-	short (*rf_set_sens)(struct net_device *dev, short sens);
 	u8 (*rf_set_chan)(struct net_device *dev, u8 ch);
 
 	struct rx_desc *rx_ring[MAX_RX_QUEUE];
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index cb28288a618b..06730d3ca6bb 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -311,10 +311,6 @@ static int _rtl92e_wx_get_range(struct net_device *dev,
 	/* ~130 Mb/s real (802.11n) */
 	range->throughput = 130 * 1000 * 1000;
 
-	if (priv->rf_set_sens != NULL)
-		/* signal level threshold range */
-		range->sensitivity = priv->max_sens;
-
 	range->max_qual.qual = 100;
 	range->max_qual.level = 0;
 	range->max_qual.noise = 0;
@@ -813,10 +809,7 @@ static int _rtl92e_wx_get_sens(struct net_device *dev,
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->rf_set_sens == NULL)
-		return -1; /* we have not this support for this radio */
-	wrqu->sens.value = priv->sens;
-	return 0;
+	return -1;
 }
 
 static int _rtl92e_wx_set_sens(struct net_device *dev,
@@ -831,15 +824,7 @@ static int _rtl92e_wx_set_sens(struct net_device *dev,
 		return 0;
 
 	mutex_lock(&priv->wx_mutex);
-	if (priv->rf_set_sens == NULL) {
-		err = -1; /* we have not this support for this radio */
-		goto exit;
-	}
-	if (priv->rf_set_sens(dev, wrqu->sens.value) == 0)
-		priv->sens = wrqu->sens.value;
-	else
-		err = -EINVAL;
-
+	err = -1;
 exit:
 	mutex_unlock(&priv->wx_mutex);
 
-- 
2.34.1

