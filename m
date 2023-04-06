Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85C36DA1A5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbjDFTlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbjDFTlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:41:05 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06CFFF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:41:04 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso43916818pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20210929; t=1680810063; x=1683402063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6vWC6AJ//IxSwIQf8O6+PjY3Dp1mTZWgaZ/SxxUU1zY=;
        b=CLMJn3htcToUWLckjyxljgF8oTkNZN4ZalMVzNHdOaTn4PLq5HyvpgxTZLHdEvfkwO
         NSPwtyKWv0bbJOA5kIPYkRB7agG8ItC0zqRPiHJutsR2DBzKIJ+SmskRSdGBBfw3lKwQ
         0qLo4Hfgt4VJd0jXoKAxzWk+fP/XD+dbNJXaVIuBa7O0ZrAUFt3/UrGu9YYN+vYoXRpp
         wDyvS6YdP8WrHQHvddYa60bxrOFjUfZTAAs95W3dLHaRrhJe1gj2Kwpg+z57PavN4GT/
         dunrGzOmAJQgBPO5eYVu4lqzr/SiDCNkEEYXqHWDMymyd3IPDkR7Z8G8AQhMQbHwu8mb
         TZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680810063; x=1683402063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vWC6AJ//IxSwIQf8O6+PjY3Dp1mTZWgaZ/SxxUU1zY=;
        b=YRSwcPZMbED+cgrcmHwgJy5uJwOPntqJdvwqcyuGnZE7wcDK+MUGhjBiJIi/L1jyv2
         OymwLhUxwQRVIIDSfpyR3svUnvdgNQw9glqU5B4lm6ziz0NMM1c4rdsBOeBWhN1C3XQY
         ytN/8n5clUkBJX0K8vJZsW363kIoTN4geWPz/EBjdYGD1wM/A3R+iwyhiVwq7KFeYEPq
         LJxhgb/f7VDqM7+sX/jq4iK23Bxmj7tMtB4AAbBseCZkNNO2sUnQDchvmls3ZCKvBvcd
         WHZXJc24ll9tY6MQ1GDIoyi4a2v3troJBOwIuOLAidjXCzS5hR307i1L+bRVPyamcRSu
         CTzA==
X-Gm-Message-State: AAQBX9fNMU/rCLPZAEo7lA1YeF22XMA80ID79Ryaz4S/3rQO/syuHzDb
        35SFP5Z8+HQP2/k0PcBRfXz/xcLY1zNa5fyQSHE=
X-Google-Smtp-Source: AKy350YQKkheFoDIBWQPzABLmizPgkbyio2Em5liDf11XvH8Myi7vhQyvDtDOeYd4oS4IZ0qfnyATw==
X-Received: by 2002:a05:6a20:4d9b:b0:d5:b3d1:bff9 with SMTP id gj27-20020a056a204d9b00b000d5b3d1bff9mr529529pzb.52.1680810063411;
        Thu, 06 Apr 2023 12:41:03 -0700 (PDT)
Received: from arve.c.googlers.com.com (139.60.82.34.bc.googleusercontent.com. [34.82.60.139])
        by smtp.gmail.com with ESMTPSA id z25-20020aa791d9000000b0062bc045bf4fsm1790385pfa.19.2023.04.06.12.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 12:41:02 -0700 (PDT)
From:   =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH] sched/wait: Fix a kthread_park race with wait_woken()
Date:   Thu,  6 Apr 2023 12:40:53 -0700
Message-Id: <20230406194053.876844-1-arve@android.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kthread_park and wait_woken have a similar race that kthread_stop and
wait_woken used to have before it was fixed in
cb6538e740d7543cd989128625cf8cac4b471e0a. Extend that fix to also cover
kthread_park.

Signed-off-by: Arve Hjønnevåg <arve@android.com>
---
 kernel/sched/wait.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 133b74730738..a9cf49da884b 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -425,9 +425,9 @@ int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, i
 }
 EXPORT_SYMBOL(autoremove_wake_function);
 
-static inline bool is_kthread_should_stop(void)
+static inline bool is_kthread_should_stop_or_park(void)
 {
-	return (current->flags & PF_KTHREAD) && kthread_should_stop();
+	return (current->flags & PF_KTHREAD) && (kthread_should_stop() || kthread_should_park());
 }
 
 /*
@@ -459,7 +459,7 @@ long wait_woken(struct wait_queue_entry *wq_entry, unsigned mode, long timeout)
 	 * or woken_wake_function() sees our store to current->state.
 	 */
 	set_current_state(mode); /* A */
-	if (!(wq_entry->flags & WQ_FLAG_WOKEN) && !is_kthread_should_stop())
+	if (!(wq_entry->flags & WQ_FLAG_WOKEN) && !is_kthread_should_stop_or_park())
 		timeout = schedule_timeout(timeout);
 	__set_current_state(TASK_RUNNING);
 
-- 
2.40.0.577.gac1e443424-goog

