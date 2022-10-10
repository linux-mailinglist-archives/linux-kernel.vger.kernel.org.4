Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25765FA3E5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJJTFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJJTEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:04:50 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F7F13F4F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:04:47 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l8so7360127wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=302wWL9Nju52yip9/le9DtDHqI9VQou5E24A3jjmcwc=;
        b=BhmHsmsJZPAjxGCwvOth2dcCbbaLA79dKN7NWQ5gVgqFgZnYKedVixOtGIVI7gwFmj
         H21+v3jWgo3UdHQo7j4jCCfqHMWl5X1LZODGbIf+XzEPnUf5nZulTokI4V5g3kT9GmWi
         EXvoJ2U0d3zoSpCRFqAKx0/o0r55f2SVsPRfAzsvv5HDGKufcRRZhaRy7mGuhu8tCtVH
         sUUwJG18o9kkTLu7x/W1tRm38OJBa0SLDQLXg5+OTXfBgFXxL6+uIqrl7bZsSWt/O87R
         vutBuApoQOgC3LywUIHwFkU/H+O9DWwfm0QAqryC8lsAHCReFx8if9dTn5S+b8WCEulz
         Ul2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=302wWL9Nju52yip9/le9DtDHqI9VQou5E24A3jjmcwc=;
        b=dE/pJIDeCW62a6muUN7ewnOcp/zWnWs9tBWUWVktCpYfZIU4eUZwHjiP4bqk0dhxFx
         8d9xo/4aOsuki6psCv/ipXwu8B1GUN1u9z+YG5+Sfv6Ra6REHY7/qt37TH5lJGFiSTLI
         osEZw8FAPWPpti9/+GHHDqT0VBsq02IbbyWKSXbsNEs+ctOHoZf8NfWqEIfUnNY4KoAN
         avsBqYm5AEQ9qePW9UJfLx15JdxJYD5/JELepSlT/zYEanC79U1UjYI1rbPZDks5w4RR
         zJp/6Oc84vl6jjB2QErnSDHJn2xs1kZ3LUIohnY2Ta583V+crdVq5u8BDAb8rEzxflAI
         /B+Q==
X-Gm-Message-State: ACrzQf0qmObxHON0DoxTHpa9XlZW7FwnpoUcx6wCZFuk4lf8riUnuQyp
        1zduiuI2dF3O0JBLmOBMe0U=
X-Google-Smtp-Source: AMsMyM5K34JTf5Y2tnke3Y9qczfjOX/OIEdcsFI8oT0CF/HYf4+8hZCkggoL3BvC8bccXV8b87gsWw==
X-Received: by 2002:a05:600c:a0b:b0:3b4:f9a7:f79b with SMTP id z11-20020a05600c0a0b00b003b4f9a7f79bmr20003862wmp.99.1665428686266;
        Mon, 10 Oct 2022 12:04:46 -0700 (PDT)
Received: from localhost.localdomain ([176.61.123.135])
        by smtp.gmail.com with ESMTPSA id j38-20020a05600c1c2600b003b3365b38f9sm10753380wms.10.2022.10.10.12.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 12:04:45 -0700 (PDT)
From:   Dragan Cvetic <dragan.m.cvetic@gmail.com>
To:     philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dragan Cvetic <dragan.m.cvetic@gmail.com>
Subject: [PATCH 3/3] staging: rtl8192e: Rename WAIotTHVal, RegC38_TH
Date:   Mon, 10 Oct 2022 20:04:39 +0100
Message-Id: <20221010190439.13131-4-dragan.m.cvetic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221010190439.13131-1-dragan.m.cvetic@gmail.com>
References: <20221010190439.13131-1-dragan.m.cvetic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename macros: WAIotTHVal to WA_IOT_TH_VAL and
RegC38_TH to REG_38_TH to avoid CamelCase which is not accepted
by checkpatch.

Signed-off-by: Dragan Cvetic <dragan.m.cvetic@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 6 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index c7ce1cab619d..f4f7820ad35d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1651,7 +1651,7 @@ static void _rtl92e_dm_init_wa_broadcom_iot(struct net_device *dev)
 	struct rt_hi_throughput *pHTInfo = priv->rtllib->pHTInfo;
 
 	pHTInfo->bWAIotBroadcom = false;
-	pHTInfo->WAIotTH = WAIotTHVal;
+	pHTInfo->WAIotTH = WA_IOT_TH_VAL;
 }
 
 static void _rtl92e_dm_check_rf_ctrl_gpio(void *data)
@@ -2221,7 +2221,7 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 		if (priv->framesyncMonitor) {
 			if (priv->rtllib->state == RTLLIB_LINKED) {
 				if (priv->undecorated_smoothed_pwdb <=
-				    RegC38_TH) {
+				    REG_C38_TH) {
 					if (reg_c38_State !=
 					    RegC38_NonFsync_Other_AP) {
 						rtl92e_writeb(dev,
@@ -2232,7 +2232,7 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 						     RegC38_NonFsync_Other_AP;
 					}
 				} else if (priv->undecorated_smoothed_pwdb >=
-					   (RegC38_TH+5)) {
+					   (REG_C38_TH + 5)) {
 					if (reg_c38_State) {
 						rtl92e_writeb(dev,
 							rOFDM0_RxDetector3,
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index a643ff5ad597..9fadb1ea231c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -34,7 +34,7 @@
 #define		RATE_ADAPTIVE_TH_LOW_40M		10
 #define		VERI_LOW_RSSI				15
 
-#define		WAIotTHVal						25
+#define		WA_IOT_TH_VAL				25
 
 #define		E_FOR_TX_POWER_TRACK	       300
 #define		TX_POWER_NEAR_FIELD_THRESH_HIGH		68
@@ -45,7 +45,7 @@
 #define		CURRENT_TX_RATE_REG		0x1e0
 #define		INITIAL_TX_RATE_REG		0x1e1
 #define		TX_RETRY_COUNT_REG		0x1ac
-#define		RegC38_TH				 20
+#define		REG_C38_TH				20
 
 #define		DM_Type_ByDriver		1
 
-- 
2.25.1

