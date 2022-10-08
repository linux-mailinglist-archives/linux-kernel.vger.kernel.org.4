Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B6D5F83F5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 09:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJHHNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 03:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJHHN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 03:13:29 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF3CD2CC6;
        Sat,  8 Oct 2022 00:13:28 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id v186so6673342pfv.11;
        Sat, 08 Oct 2022 00:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+klTj2/mlx7Mga/ycT4nkAx+qlxuiGFXHdfKazDA2Y=;
        b=hlv47i7NtlVK5jy5c4tlQgKRi8BJDrtNlFukhSrR8o5dexC3Vuh7cdQtM05UQDXHYk
         KGK/F15FEG+urkjsmAX3LYqi9cxWokRz4tPPby2pMGNslJphp4jwl2lCSikSTL0dUt+8
         a+ywNJfQbPuwEqTevW6DxA6FxI5rgZLlxdvH/ca8X8bYKBQcb9wdOc04UQH5Drb70sui
         Vlk9gSqULh7BHI7rqQUGGvhLPtrcd30NT4BUPqSI4fzYtiACglb66O/j7O7dYBqrl35A
         myFZjbZmnjWgG5mh2tB2lmZVOzkevBbm5Dr7mggVi68Zm/qpS+OJN3ypakJIsMYL6Oyd
         OSqg==
X-Gm-Message-State: ACrzQf3ixlGTQvszZz5NaBg2Oq1GYjZQz28SjwnZVYN+9Jwr1NnDC8vL
        Bcs1VruE+4u5qipshzwso2i2W/9iWdE=
X-Google-Smtp-Source: AMsMyM4tMN7CS8DohNeQAXQC8BN9Z65QJyb7vvSjI/ItPcvHePllqanpoul1+t6U9sxSANShVr1NIA==
X-Received: by 2002:a62:1a8d:0:b0:544:1309:19f3 with SMTP id a135-20020a621a8d000000b00544130919f3mr8975776pfa.37.1665213208313;
        Sat, 08 Oct 2022 00:13:28 -0700 (PDT)
Received: from sk-Yoga-14sARH-2021.lan (144.34.241.68.16clouds.com. [144.34.241.68])
        by smtp.gmail.com with ESMTPSA id pc14-20020a17090b3b8e00b0020a28156e11sm4292101pjb.26.2022.10.08.00.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 00:13:27 -0700 (PDT)
From:   Ke Sun <sunke@kylinos.cn>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     Ke Sun <sunke@kylinos.cn>, linux-kernel@vger.kernel.org,
        k2ci <kernel-bot@kylinos.cn>
Subject: [RESEND] rtc: rv3028: Fix codestyle errors
Date:   Sat,  8 Oct 2022 15:13:21 +0800
Message-Id: <20221008071321.1799971-1-sunke@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
index cdc623b3e365b..dd170e3efd83e 100644
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

