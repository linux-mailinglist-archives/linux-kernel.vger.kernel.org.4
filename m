Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E27365E155
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbjAEAKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbjAEAKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:10:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF2644348;
        Wed,  4 Jan 2023 16:10:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B3CEB8198A;
        Thu,  5 Jan 2023 00:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E14C43444;
        Thu,  5 Jan 2023 00:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672877397;
        bh=50t2JhGfBuLq9wZOJgcb1sE9TNLXRw/1jZ3BmOlQGeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dSIC4AuizxrG9CF/+aE7ID2IVaxuhXgCIZuFAtDsNyVoU01fkkRdq0HUAIecpB4rk
         49hyTHjAt+PgZMWw+qNNmW3IjJcV81xFKQaIWvHsP46Pnm4ucgJ5a00UjVjZ1VObm8
         71wkNt179WJOfZCVnZXEmOOvFKupbGSHQpOe+wHyr0rgh+A/J3uzMbc/kX6gt+O3QI
         vL3JW5wdZAI5+feEl/iqoTsHPJovFRgevkG7lNN05d0bzOnrUycf1jRF1rFF2rrhsA
         1+y01t1yvhIDm0Rpelz7UC+LSI4aD4MQlhDivcBKK/Cgetxnpkn6k0PZetx5/beG5O
         2VFCIonb04ooA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DDE215C1C99; Wed,  4 Jan 2023 16:09:56 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Zhen Lei <thunder.leizhen@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Akira Yokosawa <akiyks@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 15/15] doc: Fix htmldocs build warnings of stallwarn.rst
Date:   Wed,  4 Jan 2023 16:09:55 -0800
Message-Id: <20230105000955.1767218-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
References: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Documentation/RCU/stallwarn.rst:
401: WARNING: Literal block expected; none found.
428: WARNING: Literal block expected; none found.
445: WARNING: Literal block expected; none found.
459: WARNING: Literal block expected; none found.
468: WARNING: Literal block expected; none found.

The literal block needs to be indented, so this commit adds two spaces
to each line.

In addition, ':', which is used as a boundary in the literal block, is
replaced by '|'.

Link: https://lore.kernel.org/linux-next/20221123163255.48653674@canb.auug.org.au/
Fixes: 3d2788ba4573 ("doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Tested-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/stallwarn.rst | 56 ++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index c1e92dfef40d5..ca7b7cd806a16 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -398,9 +398,9 @@ In kernels built with CONFIG_RCU_CPU_STALL_CPUTIME=y or booted with
 rcupdate.rcu_cpu_stall_cputime=1, the following additional information
 is supplied with each RCU CPU stall warning::
 
-rcu:          hardirqs   softirqs   csw/system
-rcu:  number:      624         45            0
-rcu: cputime:       69          1         2425   ==> 2500(ms)
+  rcu:          hardirqs   softirqs   csw/system
+  rcu:  number:      624         45            0
+  rcu: cputime:       69          1         2425   ==> 2500(ms)
 
 These statistics are collected during the sampling period. The values
 in row "number:" are the number of hard interrupts, number of soft
@@ -412,22 +412,24 @@ in milliseconds.  Because user-mode tasks normally do not cause RCU CPU
 stalls, these tasks are typically kernel tasks, which is why only the
 system CPU time are considered.
 
-The sampling period is shown as follows:
-:<------------first timeout---------->:<-----second timeout----->:
-:<--half timeout-->:<--half timeout-->:                          :
-:                  :<--first period-->:                          :
-:                  :<-----------second sampling period---------->:
-:                  :                  :                          :
-:          snapshot time point    1st-stall                  2nd-stall
+The sampling period is shown as follows::
 
+  |<------------first timeout---------->|<-----second timeout----->|
+  |<--half timeout-->|<--half timeout-->|                          |
+  |                  |<--first period-->|                          |
+  |                  |<-----------second sampling period---------->|
+  |                  |                  |                          |
+             snapshot time point    1st-stall                  2nd-stall
 
 The following describes four typical scenarios:
 
-1. A CPU looping with interrupts disabled.::
+1. A CPU looping with interrupts disabled.
 
-   rcu:          hardirqs   softirqs   csw/system
-   rcu:  number:        0          0            0
-   rcu: cputime:        0          0            0   ==> 2500(ms)
+   ::
+
+     rcu:          hardirqs   softirqs   csw/system
+     rcu:  number:        0          0            0
+     rcu: cputime:        0          0            0   ==> 2500(ms)
 
    Because interrupts have been disabled throughout the measurement
    interval, there are no interrupts and no context switches.
@@ -440,11 +442,11 @@ The following describes four typical scenarios:
 
    This is similar to the previous example, but with non-zero number of
    and CPU time consumed by hard interrupts, along with non-zero CPU
-   time consumed by in-kernel execution.::
+   time consumed by in-kernel execution::
 
-   rcu:          hardirqs   softirqs   csw/system
-   rcu:  number:      624          0            0
-   rcu: cputime:       49          0         2446   ==> 2500(ms)
+     rcu:          hardirqs   softirqs   csw/system
+     rcu:  number:      624          0            0
+     rcu: cputime:       49          0         2446   ==> 2500(ms)
 
    The fact that there are zero softirqs gives a hint that these were
    disabled, perhaps via local_bh_disable().  It is of course possible
@@ -454,20 +456,22 @@ The following describes four typical scenarios:
 
 3. A CPU looping with preemption disabled.
 
-   Here, only the number of context switches is zero.::
+   Here, only the number of context switches is zero::
 
-   rcu:          hardirqs   softirqs   csw/system
-   rcu:  number:      624         45            0
-   rcu: cputime:       69          1         2425   ==> 2500(ms)
+     rcu:          hardirqs   softirqs   csw/system
+     rcu:  number:      624         45            0
+     rcu: cputime:       69          1         2425   ==> 2500(ms)
 
    This situation hints that the stalled CPU was looping with preemption
    disabled.
 
-4. No looping, but massive hard and soft interrupts.::
+4. No looping, but massive hard and soft interrupts.
+
+   ::
 
-   rcu:          hardirqs   softirqs   csw/system
-   rcu:  number:       xx         xx            0
-   rcu: cputime:       xx         xx            0   ==> 2500(ms)
+     rcu:          hardirqs   softirqs   csw/system
+     rcu:  number:       xx         xx            0
+     rcu: cputime:       xx         xx            0   ==> 2500(ms)
 
    Here, the number and CPU time of hard interrupts are all non-zero,
    but the number of context switches and the in-kernel CPU time consumed
-- 
2.31.1.189.g2e36527f23

