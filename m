Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EB26B3166
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjCIWvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjCIWvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:51:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9993C791;
        Thu,  9 Mar 2023 14:50:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C824C61D20;
        Thu,  9 Mar 2023 22:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FFDC433A7;
        Thu,  9 Mar 2023 22:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678402248;
        bh=B2rIHqE7234kAZRPUOTS1Nsn1bhxYVZgs/rCANZZIM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K/POFntf5lpb9LQj2VkYsSIlG8RQ3Q/A+qI5ewAi6EX3N1+cz5v5PSseS20Hef/6b
         k3vhzADdubr1dVbWfpsp+HRZTpuHY5uVtHPIq++0J3FN/jA3X0aOyjmPaoIe2EhLj2
         vDlO8Mmgo86jiUgDa/5Sw4JZH5Ks91rZrRI6c8/d02Z8jeVanxTWoll8d/QQE//rl+
         Kyn7+epqDLDNsYCmyTxnBowOpSxTqeuKne/RR7JmjNO6k66oshlh8D2nUcadV121cB
         Lnn+JToPmWnzZhF67rDlXpg5xc3+lBmYe2LCBTSPQ8Unq29Jk5bZ3BQw0q/mLmg0LK
         DVsIncTovlZyw==
Received: by mercury (Postfix, from userid 1000)
        id 6DFA51061BBE; Thu,  9 Mar 2023 23:50:43 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv1 11/11] power: supply: generic-adc-battery: update copyright info
Date:   Thu,  9 Mar 2023 23:50:41 +0100
Message-Id: <20230309225041.477440-12-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309225041.477440-1-sre@kernel.org>
References: <20230309225041.477440-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 436e75d226ed..ac72140dc136 100644
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

