Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EBF612453
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 17:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJ2P6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 11:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJ2P6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 11:58:10 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA0B553D32
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 08:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=uKNIl0VCi9tiAEi3aw
        ARGiYJ39SyrDAmIGjdTHmuGxc=; b=llmvjIEErgKY7VF4jPzNWNyumToQACIfD0
        lwGEJc2ke89R0aeuQgP7jeg+FTI8i85EXcwAIQcAufct/IetyFvsmGhln3XXcNOQ
        RTdxssJYSZCN+Fq553/7Y/q6xNokyU+G0V+wrG1SYwbIIF7yNjxrtB8xwgI8jomq
        Tyk/b7otY=
Received: from localhost.localdomain (unknown [153.37.166.1])
        by smtp1 (Coremail) with SMTP id GdxpCgDHcqUlTV1jrIz4oQ--.18687S4;
        Sat, 29 Oct 2022 23:56:44 +0800 (CST)
From:   lizhe <sensor1010@163.com>
To:     tglx@linutronix.de, peterz@infradead.org, tony.luck@intel.com,
        hdegoede@redhat.com
Cc:     linux-kernel@vger.kernel.org, lizhe <sensor1010@163.com>
Subject: [PATCH v1] kernel/stop_matche.c : remove redundant global variable initialization
Date:   Sat, 29 Oct 2022 08:56:19 -0700
Message-Id: <20221029155619.12154-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GdxpCgDHcqUlTV1jrIz4oQ--.18687S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWUGF1fGr47tF47JFW7twb_yoWxuFg_uF
        10qw18Wr1Y9rW0gw12qw4rXFyDKw4Fva1IkrWxKFWUAa1kG3Z8Cw1qgr9IqF4fWrnIvF98
        AwnI9Fn8tw1UGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRN3ku7UUUUU==
X-Originating-IP: [153.37.166.1]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBdB2pq1gi4TLXKQAAs8
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	the global variable stop_machine_initialized has a default
	value of false, no need to initialize it fo false

Signed-off-by: lizhe <sensor1010@163.com>
---
 kernel/stop_machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index cedb17ba158a..d1ea5233a45e 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -47,7 +47,7 @@ struct cpu_stopper {
 };
 
 static DEFINE_PER_CPU(struct cpu_stopper, cpu_stopper);
-static bool stop_machine_initialized = false;
+static bool stop_machine_initialized;
 
 void print_stop_info(const char *log_lvl, struct task_struct *task)
 {
-- 
2.17.1

