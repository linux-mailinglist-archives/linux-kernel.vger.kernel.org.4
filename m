Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF21C727A00
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjFHIb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbjFHIbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:31:55 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC1E2722;
        Thu,  8 Jun 2023 01:31:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VkdViiB_1686213109;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VkdViiB_1686213109)
          by smtp.aliyun-inc.com;
          Thu, 08 Jun 2023 16:31:50 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     davem@davemloft.net
Cc:     edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] tools: ynl: Remove duplicated include in handshake-user.c
Date:   Thu,  8 Jun 2023 16:31:48 +0800
Message-Id: <20230608083148.5514-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./tools/net/ynl/generated/handshake-user.c: stdlib.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5464
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 tools/net/ynl/generated/handshake-user.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/net/ynl/generated/handshake-user.c b/tools/net/ynl/generated/handshake-user.c
index fe99c4ef7373..7a1f0364b88f 100644
--- a/tools/net/ynl/generated/handshake-user.c
+++ b/tools/net/ynl/generated/handshake-user.c
@@ -8,7 +8,6 @@
 #include "ynl.h"
 #include <linux/handshake.h>
 
-#include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
 #include <libmnl/libmnl.h>
-- 
2.20.1.7.g153144c

