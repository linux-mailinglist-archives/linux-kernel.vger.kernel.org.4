Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC90D702207
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbjEODN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjEODNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:13:49 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AF5172C;
        Sun, 14 May 2023 20:13:47 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-250252e4113so8231306a91.0;
        Sun, 14 May 2023 20:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684120427; x=1686712427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiiaLoe2FHTpcejFRmixK8pQOtJa58cAbjMGJsmgl/s=;
        b=J1BfnOlcIOIhgtjq+rMKJpJhtUDWEYN1i5pZ9WI5qw7lQuiyE9W5ziwS9tHiXxr0j8
         kHM6HMERPCSvGOdHc+OjUornJZDjV9AYJgg0tiPvQvdzlf0jgyzuUOHg7IFdOuLf4MO0
         DR6nLPR0awPaWx9lkWZXsRH1s0dXeaGY5lnKKCu5/49ULoRSChhv75hW/SUQafxI1mo4
         b7sJT1eqK/UnkuwQoVFZUrZ3NUZcpbqZw5fxtjodfvEyoQ3WIwl2BG51jz9Jk1G7o45g
         3Kv7palxqk2ajwcWYsxS2aG2HGmEKuTUsaxz3QTAGjlYGnSynojEFf8XshUnSyqea3VR
         Zgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684120427; x=1686712427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiiaLoe2FHTpcejFRmixK8pQOtJa58cAbjMGJsmgl/s=;
        b=PW4fF3u5NJyBxcUfMOE+O1PhZ+5pgd5iksIJB8S/d3RiEDLFZevsUrFcX9QDmyMfVl
         dm/vA0hmrUqB9qPzZXp+ARiDnxS294y/x5/wIX93ii+hfSxC70gv6iz6uGFtTlO+Ef8B
         YpJvzm9Yyc2sBv9CC93Dnzkg/ByvMTJD0LkMV11SjGxnJ6m20o3JnAxFa7seOb6UQtIt
         HAeq9XD/BTlyyyTpv+gDe8CiBaGMC2JINW24aTN4AM/H9iE5hory4xl3LTr2TC7bNYjl
         J29360Vx4cmGJ+rVr9gfjVTZmqDGbbR/vJd/T0oAcmgfT2FA4kjzrbbY6ssapJfSQk/k
         J++Q==
X-Gm-Message-State: AC+VfDy5xqOh9JZnMGa9JFMNx5YaIko5jq7MK0sYBJQmcIGNTcwia83f
        rAtBs8XaE+jcE5Vzo2qmKWU=
X-Google-Smtp-Source: ACHHUZ5ruCKwfe6U8C2AKKw9tpVRDEUA4a390gZz73QzUUpvYW+k1zeIApPMsUIVEGkl6MnV/nly1A==
X-Received: by 2002:a17:90a:6a8e:b0:234:ba34:71bf with SMTP id u14-20020a17090a6a8e00b00234ba3471bfmr33197027pjj.1.1684120426786;
        Sun, 14 May 2023 20:13:46 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.42])
        by smtp.googlemail.com with ESMTPSA id o4-20020a17090a744400b00252b3328ad8sm4943577pjk.0.2023.05.14.20.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 20:13:46 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ze Gao <zegao@tencent.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/4] fprobe: make fprobe_kprobe_handler recursion free
Date:   Mon, 15 May 2023 11:13:11 +0800
Message-Id: <20230515031314.7836-3-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515031314.7836-1-zegao@tencent.com>
References: <20230515031314.7836-1-zegao@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation calls kprobe related functions before doing
ftrace recursion check in fprobe_kprobe_handler, which opens door
to kernel crash due to stack recursion if preempt_count_{add, sub}
is traceable.

Refactor the common part out of fprobe_kprobe_handler and fprobe_
handler and call ftrace recursion detection at the very beginning,
and also mark these functions notrace so that the whole fprobe_k-
probe_handler is free from recusion. And

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 kernel/trace/fprobe.c | 61 +++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 9abb3905bc8e..ad9a36c87ad9 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -20,30 +20,22 @@ struct fprobe_rethook_node {
 	char data[];
 };
 
-static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
-			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
+static inline notrace void __fprobe_handler(unsigned long ip, unsigned long
+		parent_ip, struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
 	struct fprobe_rethook_node *fpr;
 	struct rethook_node *rh = NULL;
 	struct fprobe *fp;
 	void *entry_data = NULL;
-	int bit, ret;
+	int ret;
 
 	fp = container_of(ops, struct fprobe, ops);
-	if (fprobe_disabled(fp))
-		return;
-
-	bit = ftrace_test_recursion_trylock(ip, parent_ip);
-	if (bit < 0) {
-		fp->nmissed++;
-		return;
-	}
 
 	if (fp->exit_handler) {
 		rh = rethook_try_get(fp->rethook);
 		if (!rh) {
 			fp->nmissed++;
-			goto out;
+			return;
 		}
 		fpr = container_of(rh, struct fprobe_rethook_node, node);
 		fpr->entry_ip = ip;
@@ -61,23 +53,60 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
 		else
 			rethook_hook(rh, ftrace_get_regs(fregs), true);
 	}
-out:
+}
+
+static void notrace fprobe_handler(unsigned long ip, unsigned long parent_ip,
+			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
+{
+	struct fprobe *fp;
+	int bit;
+
+	fp = container_of(ops, struct fprobe, ops);
+	if (fprobe_disabled(fp))
+		return;
+
+	/* recursion detection has to go before any traceable function and
+	 * all functions before this point should be marked as notrace
+	 */
+	bit = ftrace_test_recursion_trylock(ip, parent_ip);
+	if (bit < 0) {
+		fp->nmissed++;
+		return;
+	}
+	__fprobe_handler(ip, parent_ip, ops, fregs);
 	ftrace_test_recursion_unlock(bit);
+
 }
 NOKPROBE_SYMBOL(fprobe_handler);
 
-static void fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
+static void notrace fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
 				  struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
-	struct fprobe *fp = container_of(ops, struct fprobe, ops);
+	struct fprobe *fp;
+	int bit;
+
+	fp = container_of(ops, struct fprobe, ops);
+	if (fprobe_disabled(fp))
+		return;
+
+	/* recursion detection has to go before any traceable function and
+	 * all functions called before this point should be marked as notrace
+	 */
+	bit = ftrace_test_recursion_trylock(ip, parent_ip);
+	if (bit < 0) {
+		fp->nmissed++;
+		return;
+	}
 
 	if (unlikely(kprobe_running())) {
 		fp->nmissed++;
 		return;
 	}
+
 	kprobe_busy_begin();
-	fprobe_handler(ip, parent_ip, ops, fregs);
+	__fprobe_handler(ip, parent_ip, ops, fregs);
 	kprobe_busy_end();
+	ftrace_test_recursion_unlock(bit);
 }
 
 static void fprobe_exit_handler(struct rethook_node *rh, void *data,
-- 
2.40.1

