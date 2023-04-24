Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A34A6ED412
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjDXSEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjDXSEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:04:44 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57235258
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:04:43 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1a6817adde4so52731625ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682359483; x=1684951483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9W3bGp63HvrS4+xBjDVhbzlULsCiRVmQgDYYgNevJZE=;
        b=qbnnG0C4A/Rn7+VqEmuzUg9FuGwvyZaKQjdmVVbgXXZ/i2FIp8FyQM9Kxy5jHQYXLI
         47wMuUc6Y27vZE0hm8HGX3xu846ClshPJw1J3XE6qFA0gAv1zvaov8dNo9pYPEaYkt3/
         nQUwHLBb1OCcTvZLNp72G1BEtOB/4ZKHW79isgGYG5768fwgUHMgT3Ute7BTkLifI99U
         Uv4mEgXOEoby2DIrW/D+J1o1UU0S4vnqUZLrP2UZIAngc8mN2iCzrqCLluy6U7uyO+7E
         rgVmI9ODPveMDhXOxWbOFIxWaBEUKuErhWCtOz+wc8lYEWPW3IOSgJf/0Y3VkjJ/UU5m
         5GbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682359483; x=1684951483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9W3bGp63HvrS4+xBjDVhbzlULsCiRVmQgDYYgNevJZE=;
        b=jUvRZPvqWzkJ/S/jMQIGKPNbixn848FM6PhJn3OFG8kQw/hzQGZ0dzMJPbeuAHw16f
         /42VMz/Rj0cR/7awIglCvb8g3xhyBSHpqDmj2+L0E2hAzOfGn21Ht+bB7veL8hmupCaT
         iId8d/5NN3aJ9etDEv1Wu7YOWfRl5530clEQ9Ao//1Sd3738FNi1jf7YuL01GsfdGIDM
         Ppp7t+flKlyvy6hG5f3Re7MxGsYGe9/RtWs+XsNEJ96aZJvXECp9zDKXEkDIFtKcm8Gc
         csfuh6zbfuZT19IEScpqdMQlexBKXe/XRmmw0Fxytmp5risDFxXotXXriA/qb9BxZyLc
         uytg==
X-Gm-Message-State: AAQBX9e/cJ6TAbOjoZ5b+NS763PlQwHBGqskpupIFHisDXVirQw8lRa2
        PXWKAQcIoO66tTVEp4Jqd0d6j8EwBC4=
X-Google-Smtp-Source: AKy350a7iXFI5PBeNidJJ7FL3rZ7HajjHptmdyOadJtmHrwquTiXcOZKlWaN3Ub9GZwETgoGususEA==
X-Received: by 2002:a17:902:fa86:b0:1a6:9906:1eb7 with SMTP id lc6-20020a170902fa8600b001a699061eb7mr12726001plb.35.1682359483140;
        Mon, 24 Apr 2023 11:04:43 -0700 (PDT)
Received: from pop-os.localdomain ([103.251.210.208])
        by smtp.gmail.com with ESMTPSA id d1-20020a170902aa8100b001a051eb014bsm6831251plr.219.2023.04.24.11.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 11:04:42 -0700 (PDT)
Date:   Mon, 24 Apr 2023 23:34:38 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] staging: rtl8192e: Remove unused _rtl92e_wx_get_sens
 function
Message-ID: <eae80c4e2ac7f386c853cf824135b988c3666031.1682358035.git.yogi.kernel@gmail.com>
References: <cover.1682358035.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1682358035.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After removal of rf_set_sens variable, the _rtl92e_wx_get_sens function
always returns an error code.
This commit removes the unused function and the respective ioctl.

Suggested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---

Changes in v5:
    1. Rebased onto latest staging-testing branch

Changes in v4:
    1. Split changes into patch series per feedback from
       gregkh@linuxfoundation.org

Changes in v3:
    -- None

Changes in v2:
    -- None

Changes in v1:
    -- None
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index cc1af367f37d..f0c590064def 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -803,15 +803,6 @@ static int _rtl92e_wx_get_retry(struct net_device *dev,
 	return 0;
 }
 
-static int _rtl92e_wx_get_sens(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-
-	return -1;
-}
-
 static int _rtl92e_wx_set_sens(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
@@ -1052,7 +1043,6 @@ static iw_handler r8192_wx_handlers[] = {
 	[IW_IOCTL(SIOCSIWMODE)] = _rtl92e_wx_set_mode,
 	[IW_IOCTL(SIOCGIWMODE)] = _rtl92e_wx_get_mode,
 	[IW_IOCTL(SIOCSIWSENS)] = _rtl92e_wx_set_sens,
-	[IW_IOCTL(SIOCGIWSENS)] = _rtl92e_wx_get_sens,
 	[IW_IOCTL(SIOCGIWRANGE)] = _rtl92e_wx_get_range,
 	[IW_IOCTL(SIOCSIWAP)] = _rtl92e_wx_set_wap,
 	[IW_IOCTL(SIOCGIWAP)] = _rtl92e_wx_get_wap,
-- 
2.34.1

