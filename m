Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B32688054
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjBBOqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjBBOqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:46:34 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2BE86630
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 06:46:33 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso1567803wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 06:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J0fzJnEdJhZs6pzCO3QQHXezw8AwzK62aFAVJcTyA3k=;
        b=CoyyTK621tmUL/qz7HY01Buj71zKbLt+AinKrr+uU+lAXFAvi5OVelGgJiZGH+MlOp
         RB4PeDCSowhaROxovbzinvAreugeFJ8bF1fXqgZi1E2no2eG6WOePy5LiWwNrSyes1Dn
         gdh0Rc06thZopl0gFcX1RtktfPBjdYMFl1Kxqgz26ajbye0vg3WqVt9FQssUTrg2s7Bl
         c/wavxv2GlztcpGOyAgEKz6/ezfuPCZx3R4cxLtqaY4KhiIwffZQ1ee/YN76E8bNlXcP
         eywJqHChG1HYyFGGPe+sdIdZN8hiU+BqhhTEEuaod1ihARy3dLeXyl6bNSaBNf9x/7P3
         as/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0fzJnEdJhZs6pzCO3QQHXezw8AwzK62aFAVJcTyA3k=;
        b=5/+l+lrbHN8a+1BfcWwciSG+WE1D+3BY+adEtEhHRlOXdf1mszdEd3lIzjY1rvCBlp
         XMRR4bCJJfb/1KSFP3alWkx99vRDn0+dTxdUNbtoxZP/InlC4bGoFDSB1443nYN/f4o1
         F7lzIeOyOs6CQb5cpn7ZjSfJaZxqS+3tdNsaex02RRREw1p5yZg9r1KaIQ9fgWg9udEs
         /YjAdmKE7/UUny59jt8J1aUs9w58ZXwR92viPApLFg8J+xpoDpsVqASC3ASvNv1xaKWR
         k4VqgErpWM9PzklYhfnXJ8eyNy4qiQVwQRPf/djfMGzqmuoMvh2H9xFLT0jA8BMm88ju
         LXiQ==
X-Gm-Message-State: AO0yUKVuV9WRbT1CZ+QWNmQQrvlOO9NYeDOg/YSF0mVWUjAOFi9an88V
        Kc2xJbjqwdNTnaOhbS4Nwtz5ZW4oFUkVxZefjbc=
X-Google-Smtp-Source: AK7set91pbKUq+jVvKK+Ei04Wn4aADYjb1vFONXliCGvfx+8s37To2li9nAhPaiWD6IOzxBHg0VuJw==
X-Received: by 2002:a05:600c:46ca:b0:3de:1588:bcee with SMTP id q10-20020a05600c46ca00b003de1588bceemr6347743wmo.13.1675349191766;
        Thu, 02 Feb 2023 06:46:31 -0800 (PST)
Received: from 1.. ([79.115.63.122])
        by smtp.gmail.com with ESMTPSA id i40-20020a05600c4b2800b003dc42d48defsm4687337wmp.6.2023.02.02.06.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 06:46:31 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     pratyush@kernel.org, michael@walle.cc
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH] mtd: spi-nor: Sort headers alphabetically
Date:   Thu,  2 Feb 2023 16:46:28 +0200
Message-Id: <20230202144628.14443-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2115; i=tudor.ambarus@linaro.org; h=from:subject; bh=0gGH7H0BhjnUjMUAb0C6utVrv4qHVqzlIDWKnNiDBLE=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBj28zE7R1LDrqHWCEpy8gJcsplwB0YFOUhAGW8t fMAyEFs3raJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCY9vMxAAKCRBLVU9HpY0U 6blPB/9faYjcDUu2AALLFjO6bnmDq6+ip+Bx1SnP+D0W8kwb6zvWT0O0UljDgIjkpfyXTNLYogK 9I1pFo6ef7Xtta3xhOQ7ZarQb/pYxRx4Q4mmg8yEHkJduxeiDnhsWDHD13MXnkKpGV4AUz283SO bUhkQPaXPMAxTSaaxWWk+a8V1sBhtn13A2OEjSs7PMolkBSiun0EklKsXakoVMGn1hblHmDHvzm dTjhwDWLZd2WotTf13PkimCVRFHAKdKTaYT66XzWcAqyvxPGV83eox5IUK8++wBx0pBXc2byxlz DPBcv9q3HBv21yZxNlMjIbXcRd7SE5yGWd1vrbAr8wCB2Dqq
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort headers alphabetically - it helps locating duplicates, and makes it
easier to figure out where to insert new headers. Alphabetic order should
also prove that each header is self-contained, i.e. can be included without
prerequisites.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.c    | 13 ++++++-------
 drivers/mtd/spi-nor/debugfs.c |  2 +-
 drivers/mtd/spi-nor/sfdp.c    |  2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index b500655f7937..247d1014879a 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -9,19 +9,18 @@
 
 #include <linux/err.h>
 #include <linux/errno.h>
-#include <linux/module.h>
+#include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/mutex.h>
 #include <linux/math64.h>
-#include <linux/sizes.h>
-#include <linux/slab.h>
-#include <linux/delay.h>
-
+#include <linux/module.h>
 #include <linux/mtd/mtd.h>
+#include <linux/mtd/spi-nor.h>
+#include <linux/mutex.h>
 #include <linux/of_platform.h>
 #include <linux/sched/task_stack.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
 #include <linux/spi/flash.h>
-#include <linux/mtd/spi-nor.h>
 
 #include "core.h"
 
diff --git a/drivers/mtd/spi-nor/debugfs.c b/drivers/mtd/spi-nor/debugfs.c
index ff895f6758ea..845b78c7ecc7 100644
--- a/drivers/mtd/spi-nor/debugfs.c
+++ b/drivers/mtd/spi-nor/debugfs.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/debugfs.h>
 #include <linux/mtd/spi-nor.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
-#include <linux/debugfs.h>
 
 #include "core.h"
 
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 3acc01c3a900..fd4daf8fa5df 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -5,9 +5,9 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/mtd/spi-nor.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
-#include <linux/mtd/spi-nor.h>
 
 #include "core.h"
 
-- 
2.34.1

