Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE50870222B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbjEOD1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjEOD1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:27:11 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E898819BE;
        Sun, 14 May 2023 20:27:09 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-24dea6d5ce8so11363511a91.2;
        Sun, 14 May 2023 20:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684121229; x=1686713229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzkH4lQfb5ZOUjwqO+AdNbxgdgLDuSyyuCXzioTUQhE=;
        b=aq2446TsX1Ld9+p66vC4YJ1ME7o1BG1TAYj2c/1PsW+2SjkODlqrO+giTcyvd1epTe
         KogHvLh033R2cIiXHqpGnJ9IltV/aXGYGkO0v1lc6aai2yysg/1r3sYX0tftiNlYKQja
         KFxC1LbVFDp6Q/K3rZovzXTg5P+fS4iI7ilPipDoid9MLdSQn5Ux8RJJZ/CpiN1mLQNW
         py4pZ++8XB7NDzxEPxHocZCz3Opi59bIo6w/gEf3KVUMRdYk+zSgkmFMX9RRpvDnocmv
         Mcib1fWSXc04nH6Qt8+3kF0chdPUsJI4uwOf5LEApurHqKMViXvQmHu4izxq5xutVvAN
         /kxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684121229; x=1686713229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzkH4lQfb5ZOUjwqO+AdNbxgdgLDuSyyuCXzioTUQhE=;
        b=Z1jO0nZr8M1gkmzm2DV+D+BKbqMMO0sMtLnXtR9Z+DHzDQ8UHRfq5owJWfGcod67Qy
         5rNbXoYtsRRZ0IOd+o6SnRXJ2uS8hCptfC7dBZi/yddxmCaQk76aNpcYde9GgBZTkjp1
         0ZyfUjoead1Kes6CH/Aw+lrVaFvzVjlp7Hu/BA9W1teN6q6r0mwM1buPcada/f+OF6X9
         sRHP0xLP2pWr1syYQJ38s7uMSx+PR1K1ee4DnK4gvvRUKuCDUZA37FsbO8a3zHj42GnJ
         hsrDlwwAlkrMAP3yeS0htC4pTtXO3CSgJ5s6wkHiyn5wVMBG09SxYGz0RZxhBSyYPlcH
         vdkA==
X-Gm-Message-State: AC+VfDzOt8G+CD3jPvhLbDBIGUpWlxzuvGLOezVzhLAF0JNBRIi+SxKs
        FR2ZajioY/uKrqDmAYNklbM=
X-Google-Smtp-Source: ACHHUZ6sPQOns44VlU3S6B1qUBTWF6HNG+lEV9neNo1qApRxYqY6+osv+YsgAeovrycoYoiA5b6aOA==
X-Received: by 2002:a17:90a:ea82:b0:22b:b832:d32 with SMTP id h2-20020a17090aea8200b0022bb8320d32mr33674815pjz.9.1684121229377;
        Sun, 14 May 2023 20:27:09 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.42])
        by smtp.googlemail.com with ESMTPSA id s6-20020a632146000000b0051416609fb7sm10363825pgm.61.2023.05.14.20.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 20:27:09 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ze Gao <zegao@tencent.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH 3/4] fprobe: add recursion detection in fprobe_exit_handler
Date:   Mon, 15 May 2023 11:26:40 +0800
Message-Id: <5f8081030f6f5d5af56c93fff95f0a7fadde04ad.1684120990.git.zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684120990.git.zegao@tencent.com>
References: <cover.1684120990.git.zegao@tencent.com>
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

fprobe_hander and fprobe_kprobe_handler has guarded ftrace recusion
detection but fprobe_exit_handler has not, which possibly introduce
recurive calls if the fprobe exit callback calls any traceable
functions. Checking in fprobe_hander or fprobe_kprobe_handler
is not enough and misses this case.

So add recusion free guard the same way as fprobe_hander and also
mark fprobe_exit_handler notrace. Since ftrace recursion check does
not employ ips, so here use entry_ip and entry_parent_ip the same as
fprobe_handler.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 kernel/trace/fprobe.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index ad9a36c87ad9..cf982d4ab142 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -17,6 +17,7 @@
 struct fprobe_rethook_node {
 	struct rethook_node node;
 	unsigned long entry_ip;
+	unsigned long entry_parent_ip;
 	char data[];
 };
 
@@ -39,6 +40,7 @@ static inline notrace void __fprobe_handler(unsigned long ip, unsigned long
 		}
 		fpr = container_of(rh, struct fprobe_rethook_node, node);
 		fpr->entry_ip = ip;
+		fpr->entry_parent_ip = parent_ip;
 		if (fp->entry_data_size)
 			entry_data = fpr->data;
 	}
@@ -109,19 +111,30 @@ static void notrace fprobe_kprobe_handler(unsigned long ip, unsigned long parent
 	ftrace_test_recursion_unlock(bit);
 }
 
-static void fprobe_exit_handler(struct rethook_node *rh, void *data,
+static void notrace fprobe_exit_handler(struct rethook_node *rh, void *data,
 				struct pt_regs *regs)
 {
 	struct fprobe *fp = (struct fprobe *)data;
 	struct fprobe_rethook_node *fpr;
+	int bit;
 
 	if (!fp || fprobe_disabled(fp))
 		return;
 
 	fpr = container_of(rh, struct fprobe_rethook_node, node);
 
+	/* we need to assure no calls to traceable functions in-between the
+	 * end of fprobe_handler and the beginning of fprobe_exit_handler.
+	 */
+	bit = ftrace_test_recursion_trylock(fpr->entry_ip, fpr->entry_parent_ip);
+	if (bit < 0) {
+		fp->nmissed++;
+		return;
+	}
+
 	fp->exit_handler(fp, fpr->entry_ip, regs,
 			 fp->entry_data_size ? (void *)fpr->data : NULL);
+	ftrace_test_recursion_unlock(bit);
 }
 NOKPROBE_SYMBOL(fprobe_exit_handler);
 
-- 
2.40.1

