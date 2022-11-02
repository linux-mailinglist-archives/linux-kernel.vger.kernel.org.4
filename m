Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406656172EB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 00:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKBXlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 19:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiKBXkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 19:40:36 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E293660FF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 16:36:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso3068655wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 16:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6GuXLQ6vhVDG4TgPBv/5Wsey/201XSbJAndndtIsyw0=;
        b=bc6bpRmE6lctskpzg/AXlU4FdXZrTU55tsvvapbtRbQPXozNNZV1gLPl+skgOfh1+J
         bGGQiRlB/J4BI31QhEXBwa7hHEy3/oGF8SRSqdvVyfoyRjr82+Y8vvDccRIdRBqPQixR
         8NuMiRGQ2us8OUnx2isGDAqzdZpxZGyhNiW86pPtiTKxmj+XhT0q3JSRMbMKR1hVKfPy
         A0ppjmldCrQj1dpv9G4Jc1nI9C20czMcSuQcEW8PK1zZw8KPPYjtrhVixUdqVoT6lnzn
         jzyk/cBdHiyb34OzSoeuLSjkka8AXo9QBnDr/Ib7/uLlIOVSmlsv8j/9DfjWvWS1flqb
         kNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6GuXLQ6vhVDG4TgPBv/5Wsey/201XSbJAndndtIsyw0=;
        b=6ZSuD0pkzgNMVsw2F5NvT3uL32XofHLI9TACXshPfo3keVq1ZzpdhRhMyTDxZ3eTug
         zGKU6hsJhKCQn9E1mi6LQ9Bg3uzAJfbN/+2QhNxH2KERIrFIVQC5ikZYDcAZhBMzQ+Yu
         RusvQZZodSEiKyks9NljwAujJ8+6hBYh47esVVRf2r4+YsnqGbPUvm/1lEQSh84zf/rS
         46W/B/dPKH3EEzUZnsVDSatG4XgaSHa6PQeAqbTVFHz2C2iLzaaPtU41k6DCYf8EJHbL
         zIGTPvzAwWedb2zbDEIbQVkSaMYmN3bdG3BOw4S+EBFT3TZIBWyMnm7U0nQPlhUR382v
         n9Ow==
X-Gm-Message-State: ACrzQf0hr2PTrN0mVgbNbREldYzzNEqt9SR287Z2DHNxHqJPYxDfvhgi
        JAJRr5Xgf4r3KpC3wcknqoLpag==
X-Google-Smtp-Source: AMsMyM7Qlrm740hSv4WADLaEG+xM3c17GxpMIfi2d2PRLdlsIKOw3KOye2lCX3jQnYsdvtUfIhRImA==
X-Received: by 2002:a05:600c:5407:b0:3be:d303:d352 with SMTP id he7-20020a05600c540700b003bed303d352mr27141904wmb.94.1667432199495;
        Wed, 02 Nov 2022 16:36:39 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c1d0e00b003cf71b1f66csm4617231wms.0.2022.11.02.16.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 16:36:39 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, paskripkin@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: change return type of rtw_set_802_11_disassociate to void
Date:   Wed,  2 Nov 2022 23:36:37 +0000
Message-Id: <20221102233637.6648-1-phil@philpotter.co.uk>
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
rtw_wx_set_mlme.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_ioctl_set.c    | 4 +---
 drivers/staging/r8188eu/include/rtw_ioctl_set.h | 2 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c    | 6 ++----
 3 files changed, 4 insertions(+), 8 deletions(-)

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
index dda48a2a6d0c..04d9384d239a 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -1020,12 +1020,10 @@ static int rtw_wx_set_mlme(struct net_device *dev,
 
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
-- 
2.38.1

