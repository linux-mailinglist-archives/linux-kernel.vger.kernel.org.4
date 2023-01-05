Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163D065E2EE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 03:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjAEC1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 21:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAEC1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 21:27:18 -0500
X-Greylist: delayed 1896 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Jan 2023 18:27:16 PST
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 362E72F9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 18:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=RR4/E
        fUJjrYgOoSS43fQfIYXTO6MBAY/SqiG+3oo4FY=; b=aRciM05/FQRogmELGiQbI
        aZZbN0NHr0aDbCGsaxIbYZiM8+Yh48UgqMRjNnPHJUIY+Ksd6/zZjX32Hg1wiXk6
        NNBm6sPwN4qhu7N5Mgrb++FNtjGNU7/J+lkvLaGB2jo/gdQvtGkMZRAMagwNc9DF
        e5r6qK6RqZexAR9hS6y+IM=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wBnUNa3LLZjFsMGAA--.18432S2;
        Thu, 05 Jan 2023 09:49:43 +0800 (CST)
From:   Bing Huang <huangbing775@126.com>
To:     dietmar.eggemann@arm.com
Cc:     rostedt@goodmis.org, brauner@kernel.org, bristot@redhat.com,
        bsegall@google.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org
Subject: [PATCH] sched/topology: Add __init for sched_init_domains
Date:   Thu,  5 Jan 2023 09:49:43 +0800
Message-Id: <20230105014943.9857-1-huangbing775@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBnUNa3LLZjFsMGAA--.18432S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWxJFWxXrWruF4kZFW7twb_yoW3Zwb_uw
        s5Wr10gr1vg34qqr1ftr4fXryFga48Kan293s8Jry5X34Utrn8ArZ8AF92vrZ3Wr17ZFZr
        Ca92gFsIk3ZFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU-J57UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xkxd0w5elqwlixv6ij2wof0z/1tbiEAHtr1pEENNmwgAAsq
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bing Huang <huangbing@kylinos.cn>

sched_init_domains is only used in initialization

Signed-off-by: Bing Huang <huangbing@kylinos.cn>
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index dea9fa39e7c0..d93c3379e901 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2451,7 +2451,7 @@ void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms)
  * Set up scheduler domains and groups.  For now this just excludes isolated
  * CPUs, but could be used to exclude other special cases in the future.
  */
-int sched_init_domains(const struct cpumask *cpu_map)
+int __init sched_init_domains(const struct cpumask *cpu_map)
 {
 	int err;
 
-- 
2.25.1

