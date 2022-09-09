Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4B35B2EDC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiIIG2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIIG2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:28:06 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84C45127559
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 23:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pj+pO
        Vn/Ga1N4UYA+InOm3QbDx5plIfIpY2Fr6IKuHk=; b=FcJYgBcyiLdYaqFW3YAlm
        OF8pRr0ImknCNnWq+xLibQP4AdUySdDpveMz5WT1bqaL363aV8475996GV3gBXOu
        Ahou6vsp4LFKBcEJjZk9KGHTsZ0UVj3+l3+HbQ3pFRuMBCxoxEf7J7XptijvAnpq
        dv5UMIaD7FO/J7Pvhtwveo=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp8 (Coremail) with SMTP id NORpCgCXxLkG3Bpjqae1BQ--.8153S2;
        Fri, 09 Sep 2022 14:24:07 +0800 (CST)
From:   Bing Huang <huangbing775@126.com>
To:     rostedt@goodmis.org, dietmar.eggemann@arm.com
Cc:     brauner@kernel.org, bristot@redhat.com, bsegall@google.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org
Subject: [PATCH v2] sched/topology: Add __init for init_defrootdomain
Date:   Fri,  9 Sep 2022 14:24:06 +0800
Message-Id: <20220909062406.99435-1-huangbing775@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgCXxLkG3Bpjqae1BQ--.8153S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF13Gr13CryDJw13ArWrXwb_yoWfuFg_Aw
        18KrWFgr48Ww1jqr1rKr4fXryFqa4UKFZ2k3srK345G3y8twn5ArZxZFWIqrn7GryjkFZr
        CrnIgF4qyrnrZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU38n5UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xkxd0w5elqwlixv6ij2wof0z/1tbijAd3r1pEJRy9LgAAsn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bing Huang <huangbing@kylinos.cn>

init_defrootdomain is only used in initialization

Signed-off-by: Bing Huang <huangbing@kylinos.cn>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
---
 v1->v2:
   Remove __init in function prototype

 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8739c2a5a54e..dea9fa39e7c0 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -578,7 +578,7 @@ static int init_rootdomain(struct root_domain *rd)
  */
 struct root_domain def_root_domain;
 
-void init_defrootdomain(void)
+void __init init_defrootdomain(void)
 {
 	init_rootdomain(&def_root_domain);
 
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

