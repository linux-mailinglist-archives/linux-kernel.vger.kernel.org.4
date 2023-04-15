Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051206E311E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 13:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjDOL2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 07:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDOL2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 07:28:53 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EF14239
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 04:28:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5068e99960fso567501a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 04:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681558130; x=1684150130;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D2SXCABXMJw2Utfpn8E3EkbXRW2aNrcQgn0l3F4VNnc=;
        b=sHIZCNtJ9y16xrCG/zBUef83xsgyhnRB/sMpU48toIUQYQOH8dWA4qnuEkuRTs+UGH
         Cd/BJjzY+EOpdV5KwUfGPR4jCzIOcvff3mFPoEhOFvfakA/Len1R0jBSpp4U6TuEvwGL
         XH7mOiEqJv73Bxe1HLe5tHoZxv1j8ed0D5S9Ij/fm1F/xiSUyNl+lBzDyQwjP0j0nVn0
         nXPdgSGCC9mEKfrABw2N52i5J5ZVR9x82WOIsC8Oq4ib4Y6fHn/ytB/A+3RpdDHXDMy4
         sW6tHUBz/2ToRDYS2C/N+uwnV/OM8gxI51iY8ZkvOKLoX3epsH7HWvdEd0okqhQH/qTU
         VnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681558130; x=1684150130;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2SXCABXMJw2Utfpn8E3EkbXRW2aNrcQgn0l3F4VNnc=;
        b=fEt6qVsUFpX9ha68owHt6kbHi1OGXYcwbHeuTb4Fyyczj76SFMcRziwdrorV5aVzEI
         X6zYarwyrOqceAyu+7X22bS4KVCWLbf4fZTcW3hSpUy90svE35O/ADR0bI/hEGWN50jx
         cq2f6+4gb7A4f6YiF/h4JhclWtXECEqcdmRs8nUp7rUsMT2K6sNrdx5FAjUrzTrZNyY8
         vAeC1NWLhWcIptsPwqzAe4xO+akCMXuKxjVnSxraRJETd+58a0VVCXC0FyJXJF+tpjHv
         PQ6vvmU5cMYxi5lVcCN2kxuNZ0yb0CoT0iRiokGhK9X4+tYlnq7f4/p0us/BK7116Ny+
         7+ZA==
X-Gm-Message-State: AAQBX9fzvjocyGydScOKgVKxN6+DKEZvfATGqcTkViEtiUpfwkRnR1z6
        6GFOzip65SeR3y01/9fq7lRQtbLgPF4=
X-Google-Smtp-Source: AKy350aTvg6wS6wHuMYvaQNE+YmQBme33Tb/AgUkYfc79YyLwhvlRM6h/VcmBcA5+baEnQ0Op7vQLw==
X-Received: by 2002:a05:6402:b27:b0:502:20f0:3ee1 with SMTP id bo7-20020a0564020b2700b0050220f03ee1mr8801268edb.31.1681558129831;
        Sat, 15 Apr 2023 04:28:49 -0700 (PDT)
Received: from kernelhacking.kernelhacking.example.com (dslb-088-067-245-126.088.067.pools.vodafone-ip.de. [88.67.245.126])
        by smtp.gmail.com with ESMTPSA id u11-20020aa7d98b000000b004ad601533a3sm3221121eds.55.2023.04.15.04.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 04:28:49 -0700 (PDT)
Date:   Sat, 15 Apr 2023 13:28:47 +0200
From:   Luke Koch <lu.ale.koch@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wlan-ng: replace rate macros
Message-ID: <ZDqKb1iuoSQTYXJM@kernelhacking.kernelhacking.example.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change p80211msg_dot11req_scan_results rate members to struct arrays
instead of individually numbered member structs.
Replace macros to set rates with loops to avoid checkpatch warning
and adhere to linux coding style.

Reported by checkpatch:

CHECK: Macro argument reuse 'N' - possible side-effects?

Signed off by: Luke Koch <lu.ale.koch@gmail.com>
---
 drivers/staging/wlan-ng/p80211metastruct.h | 18 +-------
 drivers/staging/wlan-ng/prism2mgmt.c       | 52 +++++++---------------
 2 files changed, 18 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211metastruct.h b/drivers/staging/wlan-ng/p80211metastruct.h
index 4adc64580185..e963227f797c 100644
--- a/drivers/staging/wlan-ng/p80211metastruct.h
+++ b/drivers/staging/wlan-ng/p80211metastruct.h
@@ -114,22 +114,8 @@ struct p80211msg_dot11req_scan_results {
 	struct p80211item_uint32 cfpollreq;
 	struct p80211item_uint32 privacy;
 	struct p80211item_uint32 capinfo;
-	struct p80211item_uint32 basicrate1;
-	struct p80211item_uint32 basicrate2;
-	struct p80211item_uint32 basicrate3;
-	struct p80211item_uint32 basicrate4;
-	struct p80211item_uint32 basicrate5;
-	struct p80211item_uint32 basicrate6;
-	struct p80211item_uint32 basicrate7;
-	struct p80211item_uint32 basicrate8;
-	struct p80211item_uint32 supprate1;
-	struct p80211item_uint32 supprate2;
-	struct p80211item_uint32 supprate3;
-	struct p80211item_uint32 supprate4;
-	struct p80211item_uint32 supprate5;
-	struct p80211item_uint32 supprate6;
-	struct p80211item_uint32 supprate7;
-	struct p80211item_uint32 supprate8;
+	struct p80211item_uint32 basicrate[8];
+	struct p80211item_uint32 supprate[8];
 } __packed;

 struct p80211msg_dot11req_start {
diff --git a/drivers/staging/wlan-ng/prism2mgmt.c b/drivers/staging/wlan-ng/prism2mgmt.c
index 9030a8939a9b..069c39c36753 100644
--- a/drivers/staging/wlan-ng/prism2mgmt.c
+++ b/drivers/staging/wlan-ng/prism2mgmt.c
@@ -437,42 +437,22 @@ int prism2mgmt_scan_results(struct wlandevice *wlandev, void *msgp)
 		if (item->supprates[count] == 0)
 			break;

-#define REQBASICRATE(N) \
-	do { \
-		if ((count >= (N)) && DOT11_RATE5_ISBASIC_GET(	\
-			item->supprates[(N) - 1])) { \
-			req->basicrate ## N .data = item->supprates[(N) - 1]; \
-			req->basicrate ## N .status = \
-				P80211ENUM_msgitem_status_data_ok; \
-		} \
-	} while (0)
-
-	REQBASICRATE(1);
-	REQBASICRATE(2);
-	REQBASICRATE(3);
-	REQBASICRATE(4);
-	REQBASICRATE(5);
-	REQBASICRATE(6);
-	REQBASICRATE(7);
-	REQBASICRATE(8);
-
-#define REQSUPPRATE(N) \
-	do { \
-		if (count >= (N)) {					\
-			req->supprate ## N .data = item->supprates[(N) - 1]; \
-			req->supprate ## N .status = \
-				P80211ENUM_msgitem_status_data_ok; \
-		} \
-	} while (0)
-
-	REQSUPPRATE(1);
-	REQSUPPRATE(2);
-	REQSUPPRATE(3);
-	REQSUPPRATE(4);
-	REQSUPPRATE(5);
-	REQSUPPRATE(6);
-	REQSUPPRATE(7);
-	REQSUPPRATE(8);
+	for (int i = 0; i < 8; i++) {
+		if (count >= i &&
+		    DOT11_RATE5_ISBASIC_GET(item->supprates[i - 1])) {
+			req->basicrate[i] .data = item->supprates[i - 1];
+			req->basicrate[i] .status =
+				P80211ENUM_msgitem_status_data_ok;
+		}
+	}
+
+	for (int i = 0; i < 8; i++) {
+		if (count >= i) {
+			req->supprate[i] .data = item->supprates[i - 1];
+			req->supprate[i] .status =
+				P80211ENUM_msgitem_status_data_ok;
+		}
+	}
 
 	/* beacon period */
 	req->beaconperiod.status = P80211ENUM_msgitem_status_data_ok;
-- 
2.34.1

