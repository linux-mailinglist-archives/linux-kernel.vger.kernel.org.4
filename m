Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C486E5F83D4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 08:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJHGes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 02:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJHGeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 02:34:44 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A345012A9E;
        Fri,  7 Oct 2022 23:34:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VRZ.ife_1665210853;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VRZ.ife_1665210853)
          by smtp.aliyun-inc.com;
          Sat, 08 Oct 2022 14:34:38 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     john.johansen@canonical.com
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 1/3] AppArmor: Fix kernel-doc
Date:   Sat,  8 Oct 2022 14:34:09 +0800
Message-Id: <20221008063411.14829-1-jiapeng.chong@linux.alibaba.com>
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

security/apparmor/audit.c:93: warning: expecting prototype for audit_base(). Prototype was for audit_pre() instead.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2339
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 security/apparmor/audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
index 8dfdda98fbf1..5a7978aa4b19 100644
--- a/security/apparmor/audit.c
+++ b/security/apparmor/audit.c
@@ -83,7 +83,7 @@ static const char *const aa_class_names[] = {
  */
 
 /**
- * audit_base - core AppArmor function.
+ * audit_pre() - core AppArmor function.
  * @ab: audit buffer to fill (NOT NULL)
  * @ca: audit structure containing data to audit (NOT NULL)
  *
-- 
2.20.1.7.g153144c

