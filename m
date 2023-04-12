Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0FF6DE9C8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 05:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjDLDHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 23:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDLDHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 23:07:46 -0400
Received: from out0-210.mail.aliyun.com (out0-210.mail.aliyun.com [140.205.0.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6231558F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 20:07:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047201;MF=yanyan.yan@antgroup.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---.SDT3N8A_1681268858;
Received: from localhost(mailfrom:yanyan.yan@antgroup.com fp:SMTPD_---.SDT3N8A_1681268858)
          by smtp.aliyun-inc.com;
          Wed, 12 Apr 2023 11:07:38 +0800
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
Subject: [PATCH v1 2/3] sched/debug: update description of print
Date:   Wed, 12 Apr 2023 11:07:30 +0800
Message-Id: <20230412030731.24990-3-yanyan.yan@antgroup.com>
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

commit d27e9ae2f244 ("sched: Move /proc/sched_debug to debugfs")
moved /proc/sched_debug to /sys/kernel/debug/sched/debug without
updating the description. Here update it.

Signed-off-by: Yan Yan <yanyan.yan@antgroup.com>
---
 kernel/sched/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1637b65ba07a..c484c02f740b 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -8,8 +8,8 @@
  */
 
 /*
- * This allows printing both to /proc/sched_debug and
- * to the console
+ * This allows printing both to /sys/kernel/debug/sched/debug
+ * and to the console
  */
 #define SEQ_printf(m, x...)			\
  do {						\
-- 
2.32.0.3.g01195cf9f

