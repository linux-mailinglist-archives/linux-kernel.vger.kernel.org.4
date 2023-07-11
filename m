Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745D774C9DB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 04:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjGJCXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 22:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGJCXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 22:23:38 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 47256103;
        Sun,  9 Jul 2023 19:23:37 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 1DE22602824AF;
        Mon, 10 Jul 2023 10:23:16 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li zeming <zeming@nfschina.com>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?kernel:=20kprobes:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=980=E2=80=99=20values?=
Date:   Wed, 12 Jul 2023 02:53:53 +0800
Message-Id: <20230711185353.3218-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

it is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 kernel/kprobes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 00e177de91cc..83e6f76fca04 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1072,7 +1072,7 @@ static int kprobe_ftrace_enabled;
 static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 			       int *cnt)
 {
-	int ret = 0;
+	int ret;
 
 	lockdep_assert_held(&kprobe_mutex);
 
@@ -1110,7 +1110,7 @@ static int arm_kprobe_ftrace(struct kprobe *p)
 static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 				  int *cnt)
 {
-	int ret = 0;
+	int ret;
 
 	lockdep_assert_held(&kprobe_mutex);
 
@@ -2692,7 +2692,7 @@ void kprobe_free_init_mem(void)
 
 static int __init init_kprobes(void)
 {
-	int i, err = 0;
+	int i, err;
 
 	/* FIXME allocate the probe table, currently defined statically */
 	/* initialize all list heads */
-- 
2.18.2

