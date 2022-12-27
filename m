Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC7E656AD7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiL0MQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiL0MOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:14:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20D26436;
        Tue, 27 Dec 2022 04:13:56 -0800 (PST)
Date:   Tue, 27 Dec 2022 12:13:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672143233;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TnhN/HCcJst3hMGSmQ8AiFw8otDLpSKdPIp7s6dkc8Y=;
        b=WwHfULBgXA2qCsdz8aonDYZ7LMjvTzQlRRf5W5yxkVCEmBSVje3ZioJk9NV6ZVRKXsH25M
        WOpUfZF9006eL84UvhA75zTs98YO51PPB6fZ2cVqLMpYQHnQQXd/uiYT3WcGuHseIyuXVr
        pNaTzy79ysUJcMUjS4GQc3ZyC10BkHgBbZegPpMEGxjDFbRJzEx+nmXhUoRFZorVMp4a8N
        RJq3Busf6rme1NKDIoLNti7lk72Gc2K0M2Zj7ioaR+x2Vm/vp+jH1k8JHQYLzIkxz1BTF0
        6SnEDj0+EV+MqCm1SKmDGVDokeAVvSluyBE5DVIJX2iGm/5n+pHabMkXoD2whQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672143233;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TnhN/HCcJst3hMGSmQ8AiFw8otDLpSKdPIp7s6dkc8Y=;
        b=hwoTp/YoTxnoSv4y2bUfsFonWlEsvXliRcTR7A2vEmTT5iVsZkh0nP8CW4kH+SzfrlCate
        DzZyIKz3qZ9cQJBg==
From:   "tip-bot2 for Bing Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Add __init for init_defrootdomain
Cc:     Bing Huang <huangbing@kylinos.cn>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221118034208.267330-1-huangbing775@126.com>
References: <20221118034208.267330-1-huangbing775@126.com>
MIME-Version: 1.0
Message-ID: <167214323322.4906.9348067063536351217.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9a5322db46332a4ce42369e86f031b5e963d841c
Gitweb:        https://git.kernel.org/tip/9a5322db46332a4ce42369e86f031b5e963d841c
Author:        Bing Huang <huangbing@kylinos.cn>
AuthorDate:    Fri, 18 Nov 2022 11:42:08 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:52:09 +01:00

sched/topology: Add __init for init_defrootdomain

init_defrootdomain is only used in initialization

Signed-off-by: Bing Huang <huangbing@kylinos.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/20221118034208.267330-1-huangbing775@126.com
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8739c2a..dea9fa3 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -578,7 +578,7 @@ out:
  */
 struct root_domain def_root_domain;
 
-void init_defrootdomain(void)
+void __init init_defrootdomain(void)
 {
 	init_rootdomain(&def_root_domain);
 
