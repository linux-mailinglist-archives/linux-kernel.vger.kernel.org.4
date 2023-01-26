Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78B467CDF7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjAZOYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjAZOXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:23:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F5A37B47;
        Thu, 26 Jan 2023 06:23:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31A84B81DFB;
        Thu, 26 Jan 2023 14:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957B2C4323F;
        Thu, 26 Jan 2023 14:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674742978;
        bh=TZt8tg0f5EGEIjmtonuFfOLla/KhReUiEwgCPwUl7Y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dqZDgQlYoS0ADYsAw5Kl0tc/vASEnUJdOEncA27mTb7vK50h1WKMrrKDllY3j0XaU
         8UaxP2YrZklcHOWS3/G0Hq71+supY2z/20fhny7fAwTmHhY6wn5wBa5NpzjK32zBd4
         YQeEVSs6ga/yysJoFRCCfet14xThts1Iq8F37IUAx6xc7ayF6ozTXWWofWrWwmXMEV
         5/TcymIWe/XyBqRFrsiuIFJ68iRAk6nSzKGS5SG7jxt+b2nbi/T9sXlTE38QBSBxZJ
         ZAxtigb0Wi0gqMKQHM11ECa0qd915d9EfLRe/XZ2a7ozCmOSbWnVhKeCmz5LPt5n5x
         MTi9wkZyHbCfg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pL39d-0006iy-FO; Thu, 26 Jan 2023 15:23:05 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 17/24] rtc: pm8xxx: add copyright notice
Date:   Thu, 26 Jan 2023 15:20:50 +0100
Message-Id: <20230126142057.25715-18-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126142057.25715-1-johan+linaro@kernel.org>
References: <20230126142057.25715-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a copyright notice for Linaro and add myself as a (primary) author
of this driver.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/rtc/rtc-pm8xxx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index 09816b9f6282..25bdd804b4d2 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -1,5 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
+/*
+ * pm8xxx RTC driver
+ *
+ * Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
  */
 #include <linux/of.h>
 #include <linux/module.h>
@@ -551,3 +555,4 @@ MODULE_ALIAS("platform:rtc-pm8xxx");
 MODULE_DESCRIPTION("PMIC8xxx RTC driver");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Anirudh Ghayal <aghayal@codeaurora.org>");
+MODULE_AUTHOR("Johan Hovold <johan@kernel.org>");
-- 
2.39.1

