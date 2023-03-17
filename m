Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67606BF594
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjCQW5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjCQW5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:57:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B709D2FCE5;
        Fri, 17 Mar 2023 15:57:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40FDAB82711;
        Fri, 17 Mar 2023 22:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653BEC433B0;
        Fri, 17 Mar 2023 22:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679093833;
        bh=YJYG6gviCQ9ScytyBdiyC20i5BbAe56kmhR8ux24MBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ay0MJK9ii5TLx/njvgobIIYcw5U8TVQ8Fkvq7ZS3Pd8LK7SSLbnGJ6CjRMjdeiv5Q
         VWwOiSWkHo6Rt8Oveb5FzzOsr46H7uOdB+xf4thuEPG5qW96IGSeJttfhLce54W277
         vpRKbFFfF/ckr1qDnObCdqp7G3tsjNFzvn25qY//hUCOJGsPHrXLudoE+m3wokfLin
         TOl8Gdkf5RQrv0fcO5dZkXOSQhdA04TBuah9kntz6c4EZQP3kgV3Y+axJltTeHmqx4
         rtRbp+5UXFVm43lZbm+jq+UMno6ldZ7PZHTkOH1PyFo9GTlyB4+5AE5l+zFOFcP3i2
         Hh63zVSWTzekA==
Received: by mercury (Postfix, from userid 1000)
        id 9D28C1062113; Fri, 17 Mar 2023 23:57:08 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv3 12/14] power: supply: generic-adc-battery: update copyright info
Date:   Fri, 17 Mar 2023 23:57:05 +0100
Message-Id: <20230317225707.1552512-13-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317225707.1552512-1-sre@kernel.org>
References: <20230317225707.1552512-1-sre@kernel.org>
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

jz4740-battery.c and s3c_adc_battery.c have been removed
from the tree and after all of my restructuring the driver
is basically no longer based on them.

Thus update the copyright information and switch to SPDX
license identifier while being at it.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index e11ad43ab968..df1c0a1c6b52 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -1,13 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Generic battery driver code using IIO
+ * Generic battery driver using IIO
  * Copyright (C) 2012, Anish Kumar <anish198519851985@gmail.com>
- * based on jz4740-battery.c
- * based on s3c_adc_battery.c
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of this archive for
- * more details.
- *
+ * Copyright (c) 2023, Sebastian Reichel <sre@kernel.org>
  */
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
-- 
2.39.2

