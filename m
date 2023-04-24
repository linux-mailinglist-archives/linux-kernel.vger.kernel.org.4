Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACA46ED414
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjDXSFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjDXSFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:05:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C474F8683
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:05:12 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b733fd00bso3957065b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682359512; x=1684951512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QiIVNyd08SCa9xZF0j0zmRx0TelGskNY2ufTY9xiK5M=;
        b=FtoVTIjxm1x19Xo2myP/LrNBbREUxIokQhVfkVN/WWcLnQHJbK6LNCobiSBale1+2/
         /e7VGDPbBjkACeVOB5+Pouc4RVXcBbfHE2FDE2QotgTwwE9lxLy7cqBsBdcFrJwdQSE0
         7Wjx4C+xp9cEFBA5Qy5yTnbbBzH4C2MzooslOzgC83BITnm/VVPSSHohEw6CjLXELWmE
         jmLLgN8/8kGcIFyvsP9Kik6B/JJMgePLQ1Vo1SkgfiUisN1wX07NwpOy9LSrIoiqjxov
         5cxCXh+wOEnKcHTcxBxHiPsbxXL8ssBCijXIYYw4yCf0/EHUO9lpibyfyDG7ItnbUS62
         zAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682359512; x=1684951512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiIVNyd08SCa9xZF0j0zmRx0TelGskNY2ufTY9xiK5M=;
        b=Lb7Sk05pUlj88TcHhoI42Q98M9tNCG3BpmdeGri/seE8yxnmMGeERoF7X8OdKPwkOs
         i77oJ3XOeaX0tGUyHTiRSehofItHeaA8iwzSnxkqevxyhbeX8kVJgtmkTSEfcpPjW5qX
         BDT6821wOrqn2eQYZQWoUUYkd2mcV4z63HzUHVDAsKpV4we39lJcg7pcayUzEFpHEnCg
         pjAYJzz17sDsljzPxKDawnl9Ff1RrhNhLACm0yXQzj07taa9hnOC4iUM0Tjgg9BCwaii
         BCMhJpVZspnZi1Lz/SLc6k2KM5+hAuaWxQmMXPMy/Cl3jHp+B4nmPmZv7zBXWS3S6RmS
         bzrA==
X-Gm-Message-State: AAQBX9dpsAMeBKwd5lbBaf5fzfXbkuzv6bS6uqGyu2mi/GwNANdtYqtn
        vyESFupFL/KVsxQHHXr1IoQI3Px0UIg=
X-Google-Smtp-Source: AKy350YVh2dcf+IGeOKoYh4Nxzhww75IUwgD80P3Q2Q423Ejrj/xqUOJPJKAlMGBzuxMn2EgkSMqgA==
X-Received: by 2002:a05:6a21:33a2:b0:f2:9378:814a with SMTP id yy34-20020a056a2133a200b000f29378814amr13326744pzb.49.1682359512298;
        Mon, 24 Apr 2023 11:05:12 -0700 (PDT)
Received: from pop-os.localdomain ([103.251.210.208])
        by smtp.gmail.com with ESMTPSA id s1-20020a056a00178100b00625d84a0194sm7794339pfg.107.2023.04.24.11.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 11:05:11 -0700 (PDT)
Date:   Mon, 24 Apr 2023 23:35:07 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] staging: rtl8192e: Remove unused _rtl92e_wx_set_sens
  =?ISO-8859-1?Q?=20function=1B?=
Message-ID: <439386d2940fe70ec2092e87211df5e7946aab82.1682358035.git.yogi.kernel@gmail.com>
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

After removal of rf_set_sens variable, the _rtl92e_wx_set_sens function
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
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index f0c590064def..0bb657fda06c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -803,25 +803,6 @@ static int _rtl92e_wx_get_retry(struct net_device *dev,
 	return 0;
 }
 
-static int _rtl92e_wx_set_sens(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-
-	short err = 0;
-
-	if (priv->hw_radio_off)
-		return 0;
-
-	mutex_lock(&priv->wx_mutex);
-	err = -1;
-exit:
-	mutex_unlock(&priv->wx_mutex);
-
-	return err;
-}
-
 static int _rtl92e_wx_set_encode_ext(struct net_device *dev,
 				     struct iw_request_info *info,
 				     union iwreq_data *wrqu, char *extra)
@@ -1042,7 +1023,6 @@ static iw_handler r8192_wx_handlers[] = {
 	[IW_IOCTL(SIOCGIWFREQ)] = _rtl92e_wx_get_freq,
 	[IW_IOCTL(SIOCSIWMODE)] = _rtl92e_wx_set_mode,
 	[IW_IOCTL(SIOCGIWMODE)] = _rtl92e_wx_get_mode,
-	[IW_IOCTL(SIOCSIWSENS)] = _rtl92e_wx_set_sens,
 	[IW_IOCTL(SIOCGIWRANGE)] = _rtl92e_wx_get_range,
 	[IW_IOCTL(SIOCSIWAP)] = _rtl92e_wx_set_wap,
 	[IW_IOCTL(SIOCGIWAP)] = _rtl92e_wx_get_wap,
-- 
2.34.1

