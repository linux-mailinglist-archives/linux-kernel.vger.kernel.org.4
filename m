Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777646423AA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 08:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiLEHhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 02:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiLEHhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 02:37:48 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D4460E6
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 23:37:46 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VWP53Dt_1670225855;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VWP53Dt_1670225855)
          by smtp.aliyun-inc.com;
          Mon, 05 Dec 2022 15:37:43 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     w.d.hubbs@gmail.com
Cc:     chris@the-brannons.com, kirk@reisers.ca, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] speakup: Remove unused including <linux/version.h>
Date:   Mon,  5 Dec 2022 15:37:23 +0800
Message-Id: <20221205073723.39568-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
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

./drivers/accessibility/speakup/genmap.c: 13 linux/version.h not needed.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3347
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/accessibility/speakup/genmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/accessibility/speakup/genmap.c b/drivers/accessibility/speakup/genmap.c
index 0125000e00d9..0882bab10fb8 100644
--- a/drivers/accessibility/speakup/genmap.c
+++ b/drivers/accessibility/speakup/genmap.c
@@ -10,7 +10,6 @@
 #include <stdio.h>
 #include <libgen.h>
 #include <string.h>
-#include <linux/version.h>
 #include <ctype.h>
 #include "utils.h"
 
-- 
2.20.1.7.g153144c

