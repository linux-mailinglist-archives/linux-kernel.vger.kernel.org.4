Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9E7735577
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjFSLGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjFSLFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:05:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AA41BC0;
        Mon, 19 Jun 2023 04:04:54 -0700 (PDT)
Date:   Mon, 19 Jun 2023 11:04:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687172692;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VjEioIM+Zyvtme47DXVE1NS8L2pAnlF2IpyaCJ+fnlE=;
        b=OLRQaklI5B3yZ7n9dEL3VNvnmKhqbA5elFdCm6+XpBvb5f7afDVcEOqggxfy3KGz5eXXGm
        BCbT0JSawDcvET8IrKMxhzISboHtv2fO+l7jUmu6GVrLGeTnWNlYrIEZr6TenDoCbeqoEp
        /TVvS3QqEwDD+gAsMNl+XsSIsK0k4Ah8oTOJ4vMkvtdLGpGOGEwhd6vxAn08capdVafxcq
        2G2KTiyFMUbIMhUqaTI3JbubrJ7pZphXE9KBtO0HkGzPv4/Ng4uQ9uWLUd4/sKwPoVGXVI
        XLsmw1Hy/NONKIrSzw5zwGauwZyKbxp9m/VHuDndT8Eu8UFnlVs7BRKpIPPMSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687172692;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VjEioIM+Zyvtme47DXVE1NS8L2pAnlF2IpyaCJ+fnlE=;
        b=VG165vYuTSAmCt3nIJL4NUJXqU6i9p01Cn1jHjf70poLpec2LbHZ50YNu+NOIBgnsjITE4
        OBPwFJ+IzsX/KmCg==
From:   "tip-bot2 for Vineeth Pillai" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Update GRUB description in the
 documentation
Cc:     "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230530135526.2385378-2-vineeth@bitbyteword.org>
References: <20230530135526.2385378-2-vineeth@bitbyteword.org>
MIME-Version: 1.0
Message-ID: <168717269226.404.4412261506840976360.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e20f204c88d595c04fc9197794bb68c0fbabd902
Gitweb:        https://git.kernel.org/tip/e20f204c88d595c04fc9197794bb68c0fbabd902
Author:        Vineeth Pillai <vineeth@bitbyteword.org>
AuthorDate:    Tue, 30 May 2023 09:55:26 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Jun 2023 22:08:12 +02:00

sched/deadline: Update GRUB description in the documentation

Update the details of GRUB to reflect the updated logic.

Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/20230530135526.2385378-2-vineeth@bitbyteword.org
---
 Documentation/scheduler/sched-deadline.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/scheduler/sched-deadline.rst b/Documentation/scheduler/sched-deadline.rst
index 9d9be52..9fe4846 100644
--- a/Documentation/scheduler/sched-deadline.rst
+++ b/Documentation/scheduler/sched-deadline.rst
@@ -203,12 +203,15 @@ Deadline Task Scheduling
   - Total bandwidth (this_bw): this is the sum of all tasks "belonging" to the
     runqueue, including the tasks in Inactive state.
 
+  - Maximum usable bandwidth (max_bw): This is the maximum bandwidth usable by
+    deadline tasks and is currently set to the RT capacity.
+
 
  The algorithm reclaims the bandwidth of the tasks in Inactive state.
  It does so by decrementing the runtime of the executing task Ti at a pace equal
  to
 
-           dq = -max{ Ui / Umax, (1 - Uinact - Uextra) } dt
+           dq = -(max{ Ui, (Umax - Uinact - Uextra) } / Umax) dt
 
  where:
 
