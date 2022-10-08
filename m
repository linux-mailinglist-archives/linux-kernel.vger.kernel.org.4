Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26185F83D6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 08:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiJHGey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 02:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJHGes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 02:34:48 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35AA18E14;
        Fri,  7 Oct 2022 23:34:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VRZR3Dr_1665210879;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VRZR3Dr_1665210879)
          by smtp.aliyun-inc.com;
          Sat, 08 Oct 2022 14:34:42 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     john.johansen@canonical.com
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 2/3] LSM: Fix kernel-doc
Date:   Sat,  8 Oct 2022 14:34:10 +0800
Message-Id: <20221008063411.14829-2-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20221008063411.14829-1-jiapeng.chong@linux.alibaba.com>
References: <20221008063411.14829-1-jiapeng.chong@linux.alibaba.com>
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

security/apparmor/lsm.c:753: warning: expecting prototype for apparmor_bprm_committed_cred(). Prototype was for apparmor_bprm_committed_creds() instead.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2338
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 security/apparmor/lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index cc83cbf2ce20..c56afd1307c1 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -746,7 +746,7 @@ static void apparmor_bprm_committing_creds(struct linux_binprm *bprm)
 }
 
 /**
- * apparmor_bprm_committed_cred - do cleanup after new creds committed
+ * apparmor_bprm_committed_creds() - do cleanup after new creds committed
  * @bprm: binprm for the exec  (NOT NULL)
  */
 static void apparmor_bprm_committed_creds(struct linux_binprm *bprm)
-- 
2.20.1.7.g153144c

