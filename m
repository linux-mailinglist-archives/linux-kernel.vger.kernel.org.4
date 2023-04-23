Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC486EC05A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjDWOWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjDWOWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:22:48 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199CBEC
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:22:42 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b5fca48bcso3130901b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682259762; x=1684851762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MWqry1uK5LVCjEgXH9L4PAjElN6F5sdZSqjhQcA8nBE=;
        b=UzK09Cs3ortJKHuj70LOoVCm3lfOLhP1UUQ5PW4J3q4xjiunCyUh/c4aPtJ+VpScCa
         vSmMiu4S01S3OPdXu+z/4ddXQ7D5mjT6SBJWixri3jOEPwmj2FSugmr0ppGo1Diu7scd
         7fAIvHiSEtPuaSWWMtppqVXloxrg+UcpNdL4mAZ1GCAl7kaXDQd4powXAPs5K/iR278y
         4CuPhvENPi4kzuc31Q5g7f4BboeT0s/2eaHu70ciiBA+G7vlYajp/J91xomoVCXdYrL7
         XbXfI3lr4+s7kb8qmkh0vSm3PbCZ2wow3pX0l1CT/3RIYJ3oGVMfw3p3uwF1bRyYyYtg
         FUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682259762; x=1684851762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWqry1uK5LVCjEgXH9L4PAjElN6F5sdZSqjhQcA8nBE=;
        b=RdkzedrrSh9iiQXu1sWnVNE2Y7dX22dh5OejtFoA1oiW02P9lGBvwonHFfWdRswzjY
         0YQmslQKz5tqBZuwqIrPeza3wzkY0wif3agjy1xhySYDuxXp9R2dMvK8gQI8yIlboNNK
         ooL7yz/JJacjCIqudp7gMnZkL8VtKIRcN+iAyg/Y7EKVucUgglVAG9Kbw6c+VqglgaNY
         3fOOEsISOoslJ+C5Gr0i+S7+K0RL02zv6vrms4avci4XUBiIe1JT07VmLfSEIcz7ec8k
         4E7lHNH8bzrSUfWKF66aQxy8ii2SEPzaarVCoI32polt4Sh5P9GLbsHRebSEpxpMu63S
         82/A==
X-Gm-Message-State: AAQBX9f3+yfJtwePL6pAqpNR1maF7jvp32yztMxau8IP2dgph7DXi+73
        wEUvDFRAxYK5SbU4kkFEg6k=
X-Google-Smtp-Source: AKy350aEvIF94VC8cLH+ksIt8qfZ186NI+2IntZEk4EM6cTlNfuw/z1jV3fiprjq8I+sKfLeuXUSng==
X-Received: by 2002:a17:902:d2cf:b0:1a8:1798:11d0 with SMTP id n15-20020a170902d2cf00b001a8179811d0mr13622915plc.18.1682259762294;
        Sun, 23 Apr 2023 07:22:42 -0700 (PDT)
Received: from pop-os.localdomain ([103.251.210.208])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709026b8400b001a51f75ed5fsm5154307plk.242.2023.04.23.07.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 07:22:42 -0700 (PDT)
Date:   Sun, 23 Apr 2023 19:52:37 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] staging: rtl8192e: Remove unused _rtl92e_wx_get_sens
 function
Message-ID: <095f311454f36622211293d862c8c7391b09f476.1682257566.git.yogi.kernel@gmail.com>
References: <cover.1682257566.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1682257566.git.yogi.kernel@gmail.com>
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
index 06730d3ca6bb..e4a726cd0b31 100644
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

