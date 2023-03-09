Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F24E6B2BB1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 18:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCIRK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 12:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjCIRKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 12:10:02 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAAB469D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 09:08:06 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id ec29so9785246edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 09:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678381684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBuKepBSNeui5B6FhWjCNCNf/8wtioatAM9zTb92L/k=;
        b=DWQnHIVggPRC4AMq5D2NHxoXXd86XqeZtMfb45iyddGQpsTxvtQiMIrsqFLXM7hB4B
         oR1iwPUseQ3YhpcGhCEoDUbW34yxZhdLlXi5keCAtZY8YHe8Z8CCAsrzo/XkfQOoHHl4
         xTz6NRdfe1rRvNZRGUZRVx4Ny0nh2PSSxRLTZ5e2Ao0zbI5hkJto/28SzTe3i4VIotdd
         RHJh28lzS+NFZpqrqmyxK3x8GICkUZThCFj4d+Swo1yCl5uRoVXNka3HipXTUjUeuXTI
         USjY/jTKRxF65MTEHEq9rj/pAjV5XBFYGISOuJqPqYJunWWTWuWYIAWK5bW7dgHJVxwG
         Cp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678381684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBuKepBSNeui5B6FhWjCNCNf/8wtioatAM9zTb92L/k=;
        b=n2hjyyTcoORprOKaqF6Svn0kROaAJNSbQdsHwdxwARhjJqN/fUljyY1a8X6BgkezG3
         8WoffgXDOlNveVyqurcFGZAohNkLfXSMiMIAhRO1EvRWAQNZaKy5+Qk55Ds5L/YGCANB
         q5EMOR+1JmOYfKrBtp6pFWckWTw+RgMkSZ2Gps61sJgbNz6VkILcquURGPuvucqs2eIO
         MYMFfTesgZ2NcQUD1Q/HNpdGsY3aEJCQOQ1eBpeowywOQTSOZ64gToWxPW1VS0icbbQD
         mj70bdSI6SnaITRxtMJDfUEeDFw53+Alhlj8KUTPXfMD0bwcSuH+R33x2JfnV9SZP/rA
         euSA==
X-Gm-Message-State: AO0yUKW7mhVWm3fRt6yy1bNg/fkjldOe1uHtkHIUCkMwcLN6FxWvdc/w
        KqsTX3AwXYJBcoKK3nftmN2wHQ9JJh8qiQ==
X-Google-Smtp-Source: AK7set8ldr+qFkxD9s43mAHuswHbNsbDaIcBjuvlxfJ9+qFvv7TyC78nDfnjdHmwvGcioV9WphweBw==
X-Received: by 2002:a17:907:320a:b0:87a:ee05:f7b with SMTP id xg10-20020a170907320a00b0087aee050f7bmr26717111ejb.24.1678381684279;
        Thu, 09 Mar 2023 09:08:04 -0800 (PST)
Received: from lelloman-5950.. (host-79-22-154-28.retail.telecomitalia.it. [79.22.154.28])
        by smtp.gmail.com with ESMTPSA id bj8-20020a170906b04800b008d85435f914sm9154867ejb.98.2023.03.09.09.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 09:08:03 -0800 (PST)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, surenb@google.com, brauner@kernel.org,
        chris@chrisdown.name, hannes@cmpxchg.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH 3/4] sched/psi: extract update_triggers side effect
Date:   Thu,  9 Mar 2023 18:07:55 +0100
Message-Id: <20230309170756.52927-4-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309170756.52927-1-cerasuolodomenico@gmail.com>
References: <20230309170756.52927-1-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The update of rtpoll_total inside update_triggers can be moved out of
the function since changed_states has the same information as the
update_total flag used in the function. Besides the simplification of
the function, with the next patch it would become an unwanted side
effect needed only for PSI_POLL.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 kernel/sched/psi.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index a3d0b5cf797a..476941c1cbea 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -433,7 +433,6 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
 static u64 update_triggers(struct psi_group *group, u64 now)
 {
 	struct psi_trigger *t;
-	bool update_total = false;
 	u64 *total = group->total[PSI_POLL];
 
 	/*
@@ -456,14 +455,6 @@ static u64 update_triggers(struct psi_group *group, u64 now)
 		 * events without dropping any).
 		 */
 		if (new_stall) {
-			/*
-			 * Multiple triggers might be looking at the same state,
-			 * remember to update group->polling_total[] once we've
-			 * been through all of them. Also remember to extend the
-			 * polling time if we see new stall activity.
-			 */
-			update_total = true;
-
 			/* Calculate growth since last update */
 			growth = window_update(&t->win, now, total[t->state]);
 			if (!t->pending_event) {
@@ -484,11 +475,6 @@ static u64 update_triggers(struct psi_group *group, u64 now)
 		/* Reset threshold breach flag once event got generated */
 		t->pending_event = false;
 	}
-
-	if (update_total)
-		memcpy(group->rtpoll_total, total,
-				sizeof(group->rtpoll_total));
-
 	return now + group->rtpoll_min_period;
 }
 
@@ -686,8 +672,12 @@ static void psi_rtpoll_work(struct psi_group *group)
 		goto out;
 	}
 
-	if (now >= group->rtpoll_next_update)
+	if (now >= group->rtpoll_next_update) {
 		group->rtpoll_next_update = update_triggers(group, now);
+		if (changed_states & group->rtpoll_states)
+			memcpy(group->rtpoll_total, group->total[PSI_POLL],
+				   sizeof(group->rtpoll_total));
+	}
 
 	psi_schedule_rtpoll_work(group,
 		nsecs_to_jiffies(group->rtpoll_next_update - now) + 1,
-- 
2.34.1

