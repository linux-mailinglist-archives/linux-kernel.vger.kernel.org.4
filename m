Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349495F8428
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 09:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiJHHyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 03:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJHHyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 03:54:19 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3D91704F;
        Sat,  8 Oct 2022 00:54:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VRbCdPJ_1665215644;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VRbCdPJ_1665215644)
          by smtp.aliyun-inc.com;
          Sat, 08 Oct 2022 15:54:14 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     dhowells@redhat.com
Cc:     dwmw2@infradead.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] KEYS: Fix kernel-doc
Date:   Sat,  8 Oct 2022 15:50:25 +0800
Message-Id: <20221008075025.107906-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

certs/system_keyring.c:45: warning: expecting prototype for restrict_link_to_builtin_trusted(). Prototype was for restrict_link_by_builtin_trusted() instead.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2342
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 certs/system_keyring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 5042cc54fa5e..659f1881d0e3 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -33,7 +33,7 @@ extern __initconst const unsigned long system_certificate_list_size;
 extern __initconst const unsigned long module_cert_size;
 
 /**
- * restrict_link_to_builtin_trusted - Restrict keyring addition by built in CA
+ * restrict_link_by_builtin_trusted() - Restrict keyring addition by built in CA
  *
  * Restrict the addition of keys into a keyring based on the key-to-be-added
  * being vouched for by a key in the built in system keyring.
-- 
2.20.1.7.g153144c

