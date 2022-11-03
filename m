Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE0B618C81
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 00:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiKCXHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 19:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiKCXGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 19:06:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3051821269
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 16:06:35 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a14so4853038wru.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 16:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p9Q2dSV4L0Tjtbvalzz5hvMPh+oAlCituvBm6uR0r5s=;
        b=Z11ALqkkYEWvhV7TO8nkEEN8rCG4vj3TrXcwxzCqpckqWW7mv5ToRkvdMi4L1f+xgK
         CKaoXoQ4OmyVgAQ3HRSmsM3GUr/8mR9vruOoIItCb8zjLGGTTn6LzTt2sD1hI5osbilO
         8MxHABO3ThjRZkc3AV2QhkQu/PdbOeHdkP6mQM9HsaY4fbmsLQ6aHq+p3+xx/mL53iCa
         xrPEL9bGaeTYhr7mgCzu8RnU62ztFB0VqDJreqWCHvd6iUU5wy8i5oRSyE1K2izH7vh0
         aQMbVbspbl/QYJvciCCCzLKHVkmTJ2XxQmnvzldlm8EysYVsZUvr17Nq2l7WS1JeEWGl
         v3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9Q2dSV4L0Tjtbvalzz5hvMPh+oAlCituvBm6uR0r5s=;
        b=ae5tAacX+c+65O0HOQ4JlUirOuNiZExdaLOCe0HSSBx7XJ54xztRbdgNqVNaB3o3aJ
         q/KXSQ8Ydvteao6bE+QfLtCdC7Y/PSk9KLKkAEYaS92FpSLtv99ZEnhj4yZyzGTJp6cp
         syL4nG9qiK8FHi+Y/jxeszXK7lT4Xza15QhcOAcYsdxaM00uC+8BV1Cp0Ht9Kr3OUahO
         GT2L+HjSz/UXGusBG3R/lsAffunV98vxDS+/WQZVFDsIMvJtjk2KjLtQYftu8qXV6rmM
         nXoYTMImi49vb1oILIiSELD5XL32M9U2jFSHnsvMVt4uPs2Sg5KUckRuETH9QgwSIWTe
         lPHw==
X-Gm-Message-State: ACrzQf2KZ31eVF75YVpnuYCgkhS79agm0u4Tpo+CuLztcbWORY/mKNIU
        1xoNlWuhWpil833BRKTB0edhTw==
X-Google-Smtp-Source: AMsMyM5oABOdY5IFGf8rGbauuBZYc8mnnDlL/y+Eq7c5P0Fne8B0z9mIZPjpNXTaHOm3xQgHjW9rVg==
X-Received: by 2002:adf:f5c4:0:b0:236:c419:710f with SMTP id k4-20020adff5c4000000b00236c419710fmr17031608wrp.56.1667516793638;
        Thu, 03 Nov 2022 16:06:33 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id m3-20020a05600c4f4300b003b47b80cec3sm1082545wmq.42.2022.11.03.16.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 16:06:33 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, paskripkin@gmail.com,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: r8188eu: change return type of rtw_set_802_11_disassociate to void
Date:   Thu,  3 Nov 2022 23:06:32 +0000
Message-Id: <20221103230632.6946-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change return type of rtw_set_802_11_disassociate to void. This function
always returns 'true' no matter what, so there is no need to return a
value, and no need to check for it in the two call sites within
rtw_wx_set_mlme. Also, as we are no longer using ret in rtw_wx_set_mlme
except as the return value, just remove it and return 0 directly.

Suggested-by: Michael Straube <straube.linux@gmail.com>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---

Changes from V1: Act on feedback from Michael Straube:
* Remove ret variable from rtw_wx_set_mlme and return 0 directly in
  success case.

---
 drivers/staging/r8188eu/core/rtw_ioctl_set.c    | 4 +---
 drivers/staging/r8188eu/include/rtw_ioctl_set.h | 2 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c    | 9 +++------
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 786431826659..785c0dba508f 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -314,7 +314,7 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 	return true;
 }
 
-u8 rtw_set_802_11_disassociate(struct adapter *padapter)
+void rtw_set_802_11_disassociate(struct adapter *padapter)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
@@ -328,8 +328,6 @@ u8 rtw_set_802_11_disassociate(struct adapter *padapter)
 	}
 
 	spin_unlock_bh(&pmlmepriv->lock);
-
-	return true;
 }
 
 u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_ssid *pssid, int ssid_max_num)
diff --git a/drivers/staging/r8188eu/include/rtw_ioctl_set.h b/drivers/staging/r8188eu/include/rtw_ioctl_set.h
index abe460d6504d..c3eb2479f27b 100644
--- a/drivers/staging/r8188eu/include/rtw_ioctl_set.h
+++ b/drivers/staging/r8188eu/include/rtw_ioctl_set.h
@@ -12,7 +12,7 @@ u8 rtw_set_802_11_authentication_mode(struct adapter *adapt,
 				      enum ndis_802_11_auth_mode authmode);
 u8 rtw_set_802_11_bssid(struct adapter *adapter, u8 *bssid);
 u8 rtw_set_802_11_add_wep(struct adapter *adapter, struct ndis_802_11_wep *wep);
-u8 rtw_set_802_11_disassociate(struct adapter *adapter);
+void rtw_set_802_11_disassociate(struct adapter *adapter);
 u8 rtw_set_802_11_bssid_list_scan(struct adapter *adapter,
 				  struct ndis_802_11_ssid *pssid,
 				  int ssid_max_num);
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index dda48a2a6d0c..8e9b7b0664bc 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -1011,7 +1011,6 @@ static int rtw_wx_set_mlme(struct net_device *dev,
 			     struct iw_request_info *info,
 			     union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct iw_mlme *mlme = (struct iw_mlme *)extra;
 
@@ -1020,17 +1019,15 @@ static int rtw_wx_set_mlme(struct net_device *dev,
 
 	switch (mlme->cmd) {
 	case IW_MLME_DEAUTH:
-		if (!rtw_set_802_11_disassociate(padapter))
-			ret = -1;
+		rtw_set_802_11_disassociate(padapter);
 		break;
 	case IW_MLME_DISASSOC:
-		if (!rtw_set_802_11_disassociate(padapter))
-			ret = -1;
+		rtw_set_802_11_disassociate(padapter);
 		break;
 	default:
 		return -EOPNOTSUPP;
 	}
-	return ret;
+	return 0;
 }
 
 static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
-- 
2.38.1

