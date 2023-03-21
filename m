Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0561F6C2F43
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjCUKlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjCUKlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:41:44 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C3E22CA1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:41:27 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so15804791pjp.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679395287;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NutowQWWvA8KzD6Imc6Lpq5s6FGUF1181fRYLY+sn0c=;
        b=ElvNgyrNA3hMhZ9l2m9W7JfLg9JlIpDKzxPUaf9kMs3n+9HTAfg81J3J8deZsf/Dm5
         n6dNDL2CO8SJLpg9FLhksnhkW/wnVDIkydlCvUIX3oE7D/1KdxjfKHolXyaWG/TYNTn2
         svXM4ykgAIG+wdwbu6UighNOGC4eN812pixRXeEL/yoGIah+KuSU+baZhxlerq+fGn1B
         sM4HAhYT4c0tcHuqZyueipwfPWEGo6SGlF5fH7U3ZPMbSQ2flfGk0Is9uYSylYUqUd43
         Y488e/zurwMZ5zKtFx213mbo3ULxg0HoHHVIIv9EdodnVhHcoM5KrWFI+peMHlWz2aU0
         6E5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679395287;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NutowQWWvA8KzD6Imc6Lpq5s6FGUF1181fRYLY+sn0c=;
        b=J6btCgj5RyWydTkkaknL2w+GSLJiJNrvE76q1QKJNshv50Vxh7GBPrVkJuiz+M2OCp
         V8m8b6nUr7wYhnOOJVsKRsC9nxf+AuelYXZMekVsw88IygXXRlVkDZH8/nRdmGy6i90D
         a5wdcW3DxS2OT0fKs64kmxC66T/HMbk+XcuN4/8VzJcgUoCtuBVMDjZiUcebX8j9GCoM
         bJkvNWN+cfeZax0ksuus13VlInR4I21UQB8d45wlqpLn1MXKpSjU61z7Ta1kXfPCREk3
         4UsAQNNNd6q1ZAStnScHmMUwqh9L579Q1KC1xp6ygKHiNT3Dfr3MmWJwdDPYeVuhJ/NL
         J0Kw==
X-Gm-Message-State: AO0yUKVYCU4L4OGTygJP99286xbYnh7JtxK6puXODbilOErZKxXWNhLa
        Yk5VFXGgYFsUsZkVXYPgo9mGII1GsQ==
X-Google-Smtp-Source: AK7set/9dXpPINDmGeABMc+s359MyB2wzfm95K5K0nSmVUYdbfVnlrlykcOrFSM62PgBGVQwqcXJag==
X-Received: by 2002:a17:902:e891:b0:19e:5965:8694 with SMTP id w17-20020a170902e89100b0019e59658694mr2100517plg.60.1679395286578;
        Tue, 21 Mar 2023 03:41:26 -0700 (PDT)
Received: from mehmed-HP-Pavilion-Laptop-15-eh2xxx ([2401:4900:1c19:e99d:c9dc:9d9e:85b3:1d9e])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902a50e00b00194d2f14ef0sm8363132plq.23.2023.03.21.03.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 03:41:26 -0700 (PDT)
Date:   Tue, 21 Mar 2023 16:11:22 +0530
From:   Inshal Khan <kziaul123@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: rtl8712: Remove redundant parentheses and improve
 macro definition
Message-ID: <ZBmJ0luUeoX/uhZp@mehmed-HP-Pavilion-Laptop-15-eh2xxx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit simplifies the code in the ieee80211 and osdep_intf modules by
removing unnecessary parentheses and improving the readability and avoiding
any unexpected as well as operator preceedence side effects of RND4 macro.
These changes improve the robustness of the driver and make it easier to
maintain going forward.

Signed-off-by: Inshal Khan <kziaul123@gmail.com>
---
 drivers/staging/rtl8712/ieee80211.c  | 10 +++++-----
 drivers/staging/rtl8712/osdep_intf.h |  5 ++++-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8712/ieee80211.c b/drivers/staging/rtl8712/ieee80211.c
index 7d8f1a29d18a..85e698c2126d 100644
--- a/drivers/staging/rtl8712/ieee80211.c
+++ b/drivers/staging/rtl8712/ieee80211.c
@@ -63,8 +63,8 @@ uint r8712_is_cckrates_included(u8 *rate)
 	u32 i = 0;
 
 	while (rate[i] != 0) {
-		if ((((rate[i]) & 0x7f) == 2) || (((rate[i]) & 0x7f) == 4) ||
-		    (((rate[i]) & 0x7f) == 11) || (((rate[i]) & 0x7f) == 22))
+		if (((rate[i] & 0x7f) == 2) || ((rate[i] & 0x7f) == 4) ||
+		    ((rate[i] & 0x7f) == 11) || ((rate[i] & 0x7f) == 22))
 			return true;
 		i++;
 	}
@@ -76,8 +76,8 @@ uint r8712_is_cckratesonly_included(u8 *rate)
 	u32 i = 0;
 
 	while (rate[i] != 0) {
-		if ((((rate[i]) & 0x7f) != 2) && (((rate[i]) & 0x7f) != 4) &&
-		    (((rate[i]) & 0x7f) != 11)  && (((rate[i]) & 0x7f) != 22))
+		if (((rate[i] & 0x7f) != 2) && ((rate[i] & 0x7f) != 4) &&
+		    ((rate[i] & 0x7f) != 11)  && ((rate[i] & 0x7f) != 22))
 			return false;
 		i++;
 	}
@@ -147,7 +147,7 @@ static uint r8712_get_rateset_len(u8 *rateset)
 	uint i = 0;
 
 	while (1) {
-		if ((rateset[i]) == 0)
+		if (rateset[i] == 0)
 			break;
 		if (i > 12)
 			break;
diff --git a/drivers/staging/rtl8712/osdep_intf.h b/drivers/staging/rtl8712/osdep_intf.h
index 9e75116c987e..3d4f82cc60f9 100644
--- a/drivers/staging/rtl8712/osdep_intf.h
+++ b/drivers/staging/rtl8712/osdep_intf.h
@@ -17,7 +17,10 @@
 #include "osdep_service.h"
 #include "drv_types.h"
 
-#define RND4(x)	(((x >> 2) + ((x & 3) != 0)) << 2)
+#define RND4(x) ({ \
+		typeof(x) _x = (x); \
+		(((_x) + 3) & ~3); \
+		})
 
 struct intf_priv {
 	u8 *intf_dev;
-- 
2.34.1

