Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF7D6F8217
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjEELe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjEELe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:34:26 -0400
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E66B61BF
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 04:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1683286460;
        bh=e1B3ZJs6WeNbgJ43CpgJVwVD/1QBe0zgZMQ0M50X2Wk=;
        h=From:To:Cc:Subject:Date;
        b=AtSsxyEmYpqnXc08C+p29GBJQKbqWwUSIkLphN8wtlsCapXcpioYWRy+EG3GxDOFn
         wMMRgleZRzJLLj5KQaCNyn+Q2ugpdjMDpmO60GSPakdDKKK1pds5HeZWF+sej/ygVp
         2aEHmdzBdLUWEL9UAqqEDm6A0TnTvxKScdfROg6o=
Received: from wen-VirtualBox.. ([123.147.252.101])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id 8912D2FE; Fri, 05 May 2023 19:34:17 +0800
X-QQ-mid: xmsmtpt1683286457tc551bnh6
Message-ID: <tencent_5AAA3EEAB42095C9B7740BE62FBF9A67E007@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCD8qUrFIvWgCJ4XJNKyBbN/UZqxLXX6XOC6/anI5fUQbZBpOU77
         JMVdr88CtNENgRsOL/B6CY3v/c/sb+vEAGGwNBCy3cETtkuoJa0zs+5sZx3un7K62vQ2YAryr/g4
         rK6xsQleVc64dyk29Q3ZND6lZWtCj66vKItTYpSBXHgMnkNbZmMXg2DECoiHyB1jzBDyomU5zJW6
         GzmlQoIGyzGkoaKMx1XdKuP9/u27egQkeuTo6pG3ltjbLiN8kqIxKV8mXJV+vPY3VzS0v75D82K0
         GCFTnmi/Pkr+eLUZWerakrM/l6tF6iBMj1KIMRJUEJjgXz8f3p1H2rP9uJAge+jhbQcLt6ygGNLs
         7sNeZkkyXH7K2S7vOdx3cxuMDX/NlI9Y2OAgpJVPA+doXxOKrOE58dPRnevtn4ydlWcfR107tL1D
         nMY7/MgJAyGt2dENYtyHoHJiJ7V7wGcj32WafCpZFu5j5ZEtFMZcL0jqw721eO8YdUnRrXAj1c2g
         yFxTVhE7lP6H4fz6r7fOfU82NY3qgCH/RQTo9VbS6+YYx7AwRF6ii3f3b/l/9DBRijDy1lSmuO+O
         dPLqJv3UsD3BhsUFe/2b0LNLYhJb73/SgWO87vvzTLPBd2NLTn3l1+pr+pDQSSQkStRwZzSUA4nU
         Rg1cQSmy3H/a/iBUDstsYMb1MN6BHVukhCe4XbPw5VbMJJsDZmYRB5Mx5kQDdkKeVUuRXMI+sezT
         RfMTiJPM/ceGcz3ImQu5PJm+aJj/n+r/S7hgBVm/xP7KBfWhmOk3G4xa+ZSfHOiAiMQ7jTFL7NcM
         +qi4xIkWkrTKO5VxEcwA0eXvSBY6UJWZVz2AAP0929kh2VrhhVEbOev6aaoJALR2foJd/2mQXKj/
         0vqUj5s/g4L0oNrjp+HW0+nBaOX1vu1LHg1wYO5jLum25OC/A+MnDsicciR/7uCDeh+CL69ZwTXP
         t24jcthE4M3CsDQe+nqMmtzv8RMwyg9/Xcqv6G6joY/amrATi2wanfeItea2giTV0cQA/yHgoo0A
         w5WQKtF0JpQsx4LoEfbNl65G0CLmj9tSul64fvHQ==
From:   wenyang.linux@foxmail.com
To:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tick/rcu: fix an issue in the report_idle_softirq function
Date:   Fri,  5 May 2023 00:12:53 +0800
X-OQ-MSGID: <20230504161253.7246-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wenyang.linux@foxmail.com>

Commit 0345691b24c0 ("tick/rcu: Stop allowing RCU_SOFTIRQ in idle")
introduced the function report_idle_softirq, but the ratelimit logic
was broken because it is a static variable that returned before being
incremented, as follows:

	static int ratelimit;
...

	if (ratelimit < 10)
		return false;  ---> always return here
...
	ratelimit++;           ---> no chance to run

We need to adjust  the original "< 10" logic to ">= 10".

Fixes: 0345691b24c0 ("tick/rcu: Stop allowing RCU_SOFTIRQ in idle")
Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/time/tick-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index a46506f7ec6d..8891ad1d9a11 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1035,7 +1035,7 @@ static bool report_idle_softirq(void)
 			return false;
 	}
 
-	if (ratelimit < 10)
+	if (ratelimit >= 10)
 		return false;
 
 	/* On RT, softirqs handling may be waiting on some lock */
-- 
2.25.1

