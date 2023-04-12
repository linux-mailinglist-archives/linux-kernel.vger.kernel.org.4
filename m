Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EF26DE9C9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 05:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDLDH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 23:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjDLDHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 23:07:49 -0400
Received: from out0-198.mail.aliyun.com (out0-198.mail.aliyun.com [140.205.0.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0175245
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 20:07:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047188;MF=yanyan.yan@antgroup.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---.SDVQYYp_1681268860;
Received: from localhost(mailfrom:yanyan.yan@antgroup.com fp:SMTPD_---.SDVQYYp_1681268860)
          by smtp.aliyun-inc.com;
          Wed, 12 Apr 2023 11:07:41 +0800
From:   "=?UTF-8?B?5pmP6ImzKOmHh+iLkyk=?=" <yanyan.yan@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
        "=?UTF-8?B?5pmP6ImzKOmHh+iLkyk=?=" <yanyan.yan@antgroup.com>,
        "Tiwei Bie" <tiwei.btw@antgroup.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Ben Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        "Valentin Schneider" <vschneid@redhat.com>
Subject: [PATCH v1 3/3] sched: remove duplicate included headers psi.h
Date:   Wed, 12 Apr 2023 11:07:31 +0800
Message-Id: <20230412030731.24990-4-yanyan.yan@antgroup.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230412030731.24990-1-yanyan.yan@antgroup.com>
References: <20230412030731.24990-1-yanyan.yan@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yan Yan <yanyan.yan@antgroup.com>
---
 kernel/sched/build_utility.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
index 99bdd96f454f..80a3df49ab47 100644
--- a/kernel/sched/build_utility.c
+++ b/kernel/sched/build_utility.c
@@ -34,7 +34,6 @@
 #include <linux/nospec.h>
 #include <linux/proc_fs.h>
 #include <linux/psi.h>
-#include <linux/psi.h>
 #include <linux/ptrace_api.h>
 #include <linux/sched_clock.h>
 #include <linux/security.h>
-- 
2.32.0.3.g01195cf9f

