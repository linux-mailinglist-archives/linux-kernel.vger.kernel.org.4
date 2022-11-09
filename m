Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154796236B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 23:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiKIWnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 17:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKIWm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 17:42:58 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6827D13D;
        Wed,  9 Nov 2022 14:42:55 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d20so30560plr.10;
        Wed, 09 Nov 2022 14:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ssYymsxkXdmTSFU0hvcEkwkIoh7xAypCTM5P5Govko=;
        b=Gnns+h8o5AhIOXBqLaKWICAXOgSZMznymYnrEBDzfZviX7IPTd82rZRJap6bkYZ65Q
         nf7zqCUUYfKYgb8vUHJ1SE4HYKUtGTYttvHkM4Uv4Tc+WQN3hJWTE4UyzQ8hCR7jFPvN
         AYWmjq1oQWfKCK4dhHu0xypt5weHNbO6m0O8yz8BkAxv6Yzt2+8winicehFZLNYw05En
         oIFA/LFH4a2keePJIVF0oOOYZYYGLcwFXHeMLozOxOmhy+ozzosYisx24NouFVVXb+Ro
         yorzilL0AouMTZlrbzQToS56O+cH9/dQv8mbv23td9kWJqNkw8u7EQ3WTeqyeJgENyn4
         1Qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ssYymsxkXdmTSFU0hvcEkwkIoh7xAypCTM5P5Govko=;
        b=R5O2ZI5XQkCR9SR375uzpPwcV5AXTvRMtzmePzEzxrUGY8lkyI6czVqDT8pLSzTHVh
         tMUHl3hNgOE85bMKraT+gTn/+z6c4ZFsvmkVY2FhD6GcFeKBrGC9Obp4xRtllH+4AyZY
         qUTQmq9jb8OSdc3qVogY1UBMnRNoOVI2Y0tH/Ro/9wayS1V7D2lBsRu+Wg8k7uHPf0QN
         q05O4gSgs1ZBY82h3wOZII/M6QpDywheKhDhpMB8h4OxgLXmPUs1XeQUy15nhG4+YzFH
         VZEUXh7S5bT6xprYdWKyb6UDkToC0KWfIWIZSPtcueZTQ5xOkz6tb9oIStuaBKNY9VxP
         PILw==
X-Gm-Message-State: ACrzQf0o9mdBjYGE0IBsFaYwbIBQAX9Eq3+Sg9nLW0VIcqXy63WIGwW4
        Lvx++1fCM2uOa0qLmbpS5fA=
X-Google-Smtp-Source: AMsMyM4lnjqdKeMAabw8PP9V3uvyuKnpItq35VaTgS9zjxq/kTTRw3EEUlakeQXrm3m+QjSq8LwjyA==
X-Received: by 2002:a17:902:cf42:b0:182:bccf:619f with SMTP id e2-20020a170902cf4200b00182bccf619fmr1272698plg.9.1668033775073;
        Wed, 09 Nov 2022 14:42:55 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:6af4:9e55:5482:c0de])
        by smtp.gmail.com with ESMTPSA id k17-20020a63ff11000000b0046f9f4a2de6sm7995042pgi.74.2022.11.09.14.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:42:54 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v2 1/3] ARM: OMAP2+: pdata-quirks: stop including wl12xx.h
Date:   Wed,  9 Nov 2022 14:42:48 -0800
Message-Id: <20221109224250.2885119-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
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

As of commit 2398c41d6432 ("omap: pdata-quirks: remove openpandora
quirks for mmc3 and wl1251") the code no longer creates an instance of
wl1251_platform_data, so there is no need for including this header.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Changes in v2: added fix to arch/arm/mach-omap2/pdata-quirks.c
Note this series was only compile-tested.

 arch/arm/mach-omap2/pdata-quirks.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 9deba798cc91..baba73fd6f11 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -10,7 +10,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
-#include <linux/wl12xx.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 #include <linux/power/smartreflex.h>
-- 
2.38.1.431.g37b22c650d-goog

