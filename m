Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719F265F842
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 01:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbjAFAl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 19:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235864AbjAFAlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 19:41:23 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADC15F4AD
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 16:41:18 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VYxJPik_1672965675;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VYxJPik_1672965675)
          by smtp.aliyun-inc.com;
          Fri, 06 Jan 2023 08:41:16 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     samuel.thibault@ens-lyon.org
Cc:     w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] speakup: Fix warning comparing pointer to 0
Date:   Fri,  6 Jan 2023 08:41:14 +0800
Message-Id: <20230106004114.72589-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./drivers/accessibility/speakup/utils.h:39:15-16: WARNING comparing pointer to 0

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3636
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/accessibility/speakup/utils.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accessibility/speakup/utils.h b/drivers/accessibility/speakup/utils.h
index 4ce9a12f7664..db00c962f8e2 100644
--- a/drivers/accessibility/speakup/utils.h
+++ b/drivers/accessibility/speakup/utils.h
@@ -36,7 +36,7 @@ static inline void open_input(const char *dir_name, const char *name)
 	else
 		snprintf(filename, sizeof(filename), "%s", name);
 	infile = fopen(filename, "r");
-	if (infile == 0) {
+	if (!infile) {
 		fprintf(stderr, "can't open %s\n", filename);
 		exit(1);
 	}
-- 
2.20.1.7.g153144c

