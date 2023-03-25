Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E76A6C898A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 01:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjCYAWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 20:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCYAWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 20:22:31 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A011BDC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 17:22:29 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p34so2002323wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 17:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679703748;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QZt+Ekeb+RCGZ+UZwPqy3x6FR0k7BKBwPHxkQw0mM8A=;
        b=iinbtO0WxroDjLVGptKUROdY+6YpkxjN8d1aBZHfZId/OS7wpHcy1DcGFZ074o0Sjh
         LNo7rlNGH1J4GpRTPM7kTgcKEi01nXpXzt5iD47oHe/Gjv1+c6ex3gB6RY+jomN68mL3
         R4VzXJsiBvP6HHnJR1E7b9hHx1vAT61ZS6KCEgoD0IWQJO9uGfhjLI61kF/YxfJetklJ
         29F7MmLjVGUO1EbeKPZcV8teAXp9PATMCo56SH7VKgcGTH806W9scd4DvBJRGi17ls1b
         royQ6zR6Cg6gwfOq+l9HoCUb66lgnJe6SEqiC0GP/iybWQrBrRrHUAz66SPTANE2Lium
         xxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679703748;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZt+Ekeb+RCGZ+UZwPqy3x6FR0k7BKBwPHxkQw0mM8A=;
        b=Jmtf2zsKum1kiGJJ6TZVm1jSJgLKvna2b4gBv267G6683yM7QT/RsEMQtj7zPt7TZk
         Jbzsk53GUpkwZhC1dV5TFS6BKyDPFfrrn40z8JtfHA8MOluIdlk2bOu2mhzBJKWIdBDd
         mcoiAa+OhX/rUIOQsi3iSWvpyaJ5xrcruipei0emr+xMXkQl9lStzHrc9/TjhFGPrpn8
         8Z9IrxDtasUganfNltatLyDY05cArWFvsu5wXnhhStQy6T1ilHdpq0xAS+1XWiwfmB38
         EEP+eWzkoMChql4ODt07GKMxO5cHYMDXevJsQ1n6nuz+o8/eIA/QS6n3YF3VvbYnuWv4
         kGhQ==
X-Gm-Message-State: AO0yUKVzMTEnmaR1U/ySYvNhD4SYLjl5eak9FyygkTW6587cU5t0FrJP
        p5YFF+APjv6kdpHnnCRX8g==
X-Google-Smtp-Source: AK7set8T1iePvuqZfLCPVXRJ0LyYL+Y8Ijn3PKzS9an2BhNdV6G9mhN5FVsLUALI1+9WrJ5Fx9o2ug==
X-Received: by 2002:a05:600c:214:b0:3ee:1084:aa79 with SMTP id 20-20020a05600c021400b003ee1084aa79mr2922839wmi.20.1679703747788;
        Fri, 24 Mar 2023 17:22:27 -0700 (PDT)
Received: from koolguy (dslb-002-205-192-117.002.205.pools.vodafone-ip.de. [2.205.192.117])
        by smtp.gmail.com with ESMTPSA id x11-20020a05600c21cb00b003ede3e54ed7sm6292472wmj.6.2023.03.24.17.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 17:22:27 -0700 (PDT)
Date:   Sat, 25 Mar 2023 01:22:25 +0100
From:   Dalvin-Ehinoma Noah Aiguobas <pharcodra@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH]: staging: wlan-ng: Remove unnecessary Parentheses
Message-ID: <20230325002225.GA109622@koolguy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up Checkpatch issues by removing unnecessary Parentheses.

Signed-off-by: Dalvin-Ehinoma Noah Aiguobas <pharcodra@gmail.com>
---
 drivers/staging/wlan-ng/cfg80211.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index 471bb310176f..0b4d40ec7456 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -247,7 +247,7 @@ static int prism2_get_station(struct wiphy *wiphy, struct net_device *dev,
 
 	memset(sinfo, 0, sizeof(*sinfo));
 
-	if (!wlandev || (wlandev->msdstate != WLAN_MSD_RUNNING))
+	if (!wlandev || wlandev->msdstate != WLAN_MSD_RUNNING)
 		return -EOPNOTSUPP;
 
 	/* build request message */
@@ -351,8 +351,8 @@ static int prism2_scan(struct wiphy *wiphy,
 		msg2->bssindex.data = i;
 
 		result = p80211req_dorequest(wlandev, (u8 *)&msg2);
-		if ((result != 0) ||
-		    (msg2->resultcode.data != P80211ENUM_resultcode_success)) {
+		if (result != 0 ||
+		    msg2->resultcode.data != P80211ENUM_resultcode_success) {
 			break;
 		}
 
@@ -459,8 +459,8 @@ static int prism2_connect(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	/* Set the authorization */
-	if ((sme->auth_type == NL80211_AUTHTYPE_OPEN_SYSTEM) ||
-	    ((sme->auth_type == NL80211_AUTHTYPE_AUTOMATIC) && !is_wep))
+	if (sme->auth_type == NL80211_AUTHTYPE_OPEN_SYSTEM ||
+	    (sme->auth_type == NL80211_AUTHTYPE_AUTOMATIC && !is_wep))
 		msg_join.authtype.data = P80211ENUM_authalg_opensystem;
 	else if ((sme->auth_type == NL80211_AUTHTYPE_SHARED_KEY) ||
 		 ((sme->auth_type == NL80211_AUTHTYPE_AUTOMATIC) && is_wep))
@@ -478,7 +478,7 @@ static int prism2_connect(struct wiphy *wiphy, struct net_device *dev,
 
 			result = prism2_domibset_uint32(wlandev,
 							DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
-				sme->key_idx);
+							sme->key_idx);
 			if (result)
 				goto exit;
 
-- 
2.25.1

