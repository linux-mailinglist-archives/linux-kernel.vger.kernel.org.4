Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A835B7F45
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 05:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiINDTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 23:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiINDTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 23:19:44 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C760910543;
        Tue, 13 Sep 2022 20:19:43 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id x1so13804297plv.5;
        Tue, 13 Sep 2022 20:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=MAYzqsNXhJ7NrfvzNWwW1ykVxjuume8Guse5S9ioDxs=;
        b=SmrNpCrkFnDYAQSAU29LQeKM97im0bfBWPdDffuj3xUT/gJhjDqV4kIUKTBsuSSZSn
         Pba8aOPnNxZbV1cUuyLRcnfzkqfZ2yqBsSmpCAdLgzfd43YqUYJp9K7YF7ozTWe0Egkq
         tL0Rh4rzpm04SwZHtBqYNsNwcHKie+BK1oo8x8tNiBb8x/cb71XwV9onbuD14ckrc7QO
         HW8qUzkEn2FKTsux+f+IuKG49J9I9sfMoEkh4usjrArWVHl405Pr3DJeOVHEO+ao5n2F
         aTHJY4tu1d7UWuKItNH3MMSh2A9UdjjyoqW/nULe8t0ErfwBIa9XLyz4xtkfcwCoUI+U
         /Qlw==
X-Gm-Message-State: ACgBeo21G2XXE9IqrFhHDt8wffsIwAJI+rXkS7xyiws2JXZu2lKN1bjy
        ZuZRulxt394adJ8V9rAEM2eXCJxc6hmhj9Ws
X-Google-Smtp-Source: AMsMyM4AQyWD1PUPunaqDoOQs7WPannJRUkYqkaJpgVRKSprbfqRMsrhj2n3o8JswxRA2sxpDCfmUg==
X-Received: by 2002:a17:90b:1810:b0:202:c6d7:98a4 with SMTP id lw16-20020a17090b181000b00202c6d798a4mr2451109pjb.16.1663125583288;
        Tue, 13 Sep 2022 20:19:43 -0700 (PDT)
Received: from sk-Yoga-14sARH-2021.lan (144.34.241.68.16clouds.com. [144.34.241.68])
        by smtp.gmail.com with ESMTPSA id t67-20020a625f46000000b0053b8ea1c4f3sm8732747pfb.135.2022.09.13.20.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 20:19:42 -0700 (PDT)
From:   Ke Sun <sunke@kylinos.cn>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     Ke Sun <sunke@kylinos.cn>, linux-kernel@vger.kernel.org,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] rtc: rv3028: Fix codestyle errors
Date:   Wed, 14 Sep 2022 11:19:36 +0800
Message-Id: <20220914031936.3493647-1-sunke@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiler warnings：

drivers/rtc/rtc-rv3028.c: In function 'rv3028_param_set':
drivers/rtc/rtc-rv3028.c:559:20: warning: statement will never be executed [-Wswitch-unreachable]
  559 |                 u8 mode;
      |                    ^~~~
drivers/rtc/rtc-rv3028.c: In function 'rv3028_param_get':
drivers/rtc/rtc-rv3028.c:526:21: warning: statement will never be executed [-Wswitch-unreachable]
  526 |                 u32 value;
      |                     ^~~~~

Fix it by moving the variable declaration to the beginning of the function.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Ke Sun <sunke@kylinos.cn>
---
 drivers/rtc/rtc-rv3028.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
index cdc623b3e365..dd170e3efd83 100644
--- a/drivers/rtc/rtc-rv3028.c
+++ b/drivers/rtc/rtc-rv3028.c
@@ -521,10 +521,9 @@ static int rv3028_param_get(struct device *dev, struct rtc_param *param)
 {
 	struct rv3028_data *rv3028 = dev_get_drvdata(dev);
 	int ret;
+	u32 value;

 	switch(param->param) {
-		u32 value;
-
 	case RTC_PARAM_BACKUP_SWITCH_MODE:
 		ret = regmap_read(rv3028->regmap, RV3028_BACKUP, &value);
 		if (ret < 0)
@@ -554,9 +553,9 @@ static int rv3028_param_get(struct device *dev, struct rtc_param *param)
 static int rv3028_param_set(struct device *dev, struct rtc_param *param)
 {
 	struct rv3028_data *rv3028 = dev_get_drvdata(dev);
+	u8 mode;

 	switch(param->param) {
-		u8 mode;
 	case RTC_PARAM_BACKUP_SWITCH_MODE:
 		switch (param->uvalue) {
 		case RTC_BSM_DISABLED:
--
2.25.1

