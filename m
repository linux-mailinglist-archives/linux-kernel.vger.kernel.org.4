Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4878974AC7D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjGGIHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjGGIHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:07:44 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D447D19BD;
        Fri,  7 Jul 2023 01:07:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vmnlo8x_1688717258;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vmnlo8x_1688717258)
          by smtp.aliyun-inc.com;
          Fri, 07 Jul 2023 16:07:39 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     john.johansen@canonical.com
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] apparmor: Fix some kernel-doc comments
Date:   Fri,  7 Jul 2023 16:07:37 +0800
Message-Id: <20230707080737.49899-1-yang.lee@linux.alibaba.com>
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

Use colons to separate parameter names from their specific meanings.
silencethe warnings:

security/apparmor/resource.c:111: warning: Function parameter or member 'label' not described in 'aa_task_setrlimit'
security/apparmor/resource.c:111: warning: Function parameter or member 'task' not described in 'aa_task_setrlimit'
security/apparmor/resource.c:111: warning: Function parameter or member 'resource' not described in 'aa_task_setrlimit'
security/apparmor/resource.c:111: warning: Function parameter or member 'new_rlim' not described in 'aa_task_setrlimit'

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 security/apparmor/resource.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/apparmor/resource.c b/security/apparmor/resource.c
index e85948164896..2bebc5d9e741 100644
--- a/security/apparmor/resource.c
+++ b/security/apparmor/resource.c
@@ -97,10 +97,10 @@ static int profile_setrlimit(struct aa_profile *profile, unsigned int resource,
 
 /**
  * aa_task_setrlimit - test permission to set an rlimit
- * @label - label confining the task  (NOT NULL)
- * @task - task the resource is being set on
- * @resource - the resource being set
- * @new_rlim - the new resource limit  (NOT NULL)
+ * @label: label confining the task  (NOT NULL)
+ * @task: task the resource is being set on
+ * @resource: the resource being set
+ * @new_rlim: the new resource limit  (NOT NULL)
  *
  * Control raising the processes hard limit.
  *
-- 
2.20.1.7.g153144c

