Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A66C63B8B2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 04:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbiK2DVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 22:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbiK2DVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 22:21:34 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF43C4A040
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 19:21:33 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VVym3zR_1669692086;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VVym3zR_1669692086)
          by smtp.aliyun-inc.com;
          Tue, 29 Nov 2022 11:21:31 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jiucheng.xu@amlogic.com
Cc:     will@kernel.org, mark.rutland@arm.com, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 1/2] perf/amlogic: Remove unused including <linux/version.h>
Date:   Tue, 29 Nov 2022 11:21:08 +0800
Message-Id: <20221129032108.119661-2-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20221129032108.119661-1-jiapeng.chong@linux.alibaba.com>
References: <20221129032108.119661-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./drivers/perf/amlogic/meson_g12_ddr_pmu.c:15 linux/version.h not needed.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3280
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/perf/amlogic/meson_g12_ddr_pmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/perf/amlogic/meson_g12_ddr_pmu.c b/drivers/perf/amlogic/meson_g12_ddr_pmu.c
index 932802abd18c..a78fdb15e26c 100644
--- a/drivers/perf/amlogic/meson_g12_ddr_pmu.c
+++ b/drivers/perf/amlogic/meson_g12_ddr_pmu.c
@@ -12,7 +12,6 @@
 #include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/types.h>
-#include <linux/version.h>
 
 #include <soc/amlogic/meson_ddr_pmu.h>
 
-- 
2.20.1.7.g153144c

