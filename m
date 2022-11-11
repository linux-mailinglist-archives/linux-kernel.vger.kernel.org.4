Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3146253EF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 07:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbiKKGlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 01:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbiKKGlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:41:17 -0500
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 791F54AF2B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 22:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=nJm5P
        MOfiSBTD3N/acZGjKO2aLOW9Z0vK1+TUQyrmQI=; b=UA4BWyXBYlCcIQvTJlf6J
        f3L2tUdruUReYdEMUqYVNdiMR/oppVRgrqXrf5PzQ1nSw18nrrRfCYhROeR1n3ZA
        nVByg95zqTzFe71IveJmsuSCaMuMFDYsoEuqCtpWD8Uf2R/pngYJIrdVw8BrtP4p
        /sfoHPPhp1zW6ESFwY2Zfw=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp10 (Coremail) with SMTP id NuRpCgDHBUYp7m1j6P9NFg--.51418S2;
        Fri, 11 Nov 2022 14:39:39 +0800 (CST)
From:   Bing Huang <huangbing775@126.com>
To:     rostedt@goodmis.org, dietmar.eggemann@arm.com
Cc:     brauner@kernel.org, bristot@redhat.com, bsegall@google.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org
Subject: [RESEND PATCH v3] sched/topology: Add __init for init_defrootdomain
Date:   Fri, 11 Nov 2022 14:39:37 +0800
Message-Id: <20221111063937.48910-1-huangbing775@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgDHBUYp7m1j6P9NFg--.51418S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF13Gr13Cr43Kr47Ary8uFg_yoWDGFg_Jw
        18KrWFgr48Ww1jqr1rKr4fXFyFqa4DKFZ29r9rK345G3y8twn5ArZxZFWIqrn7GryjkFZr
        CrnIgF4qyrnrZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU6VbPUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xkxd0w5elqwlixv6ij2wof0z/1tbiEAu2r1pEDsiijwAAs3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bing Huang <huangbing@kylinos.cn>

init_defrootdomain is only used in initialization

Signed-off-by: Bing Huang <huangbing@kylinos.cn>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
---
 v1->v2:
   Remove __init in function prototype
 v2->v3:
   Update the "Reviewed-by" tag

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

