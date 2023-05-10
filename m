Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E0B6FE316
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbjEJRM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbjEJRMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:12:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD9C59D7;
        Wed, 10 May 2023 10:12:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 560E364A28;
        Wed, 10 May 2023 17:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F09C4339C;
        Wed, 10 May 2023 17:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738760;
        bh=S/zDN4Mx0EE9P7/xnN22nAFFHks40rkut7M2UMqQfgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lyg4S89AMGm7ly3eW4SPJwSXoHdVV1PIZ6UL1LpVuwKRIfLgkj2wbVwl97LhEc5r9
         ze6Hoi2wwkmZqurThbCyzFO+2wTJ8N3XiHklB19rINNU0C+WReYxm9YBPMq8VlfIWl
         mXTAzLL+M+PGbYQR/qQniDktK9xNrHxq1F+lq8hwHOMjT74+7z9QqjNLDP7arv10Qn
         YxD/d8fxDPrE7g6wXE1KYFk3W6btU7Y+Ft4WpvsGJMgIg5ZP92cydyRQBVbtDuqrwh
         1kppXW2ebLyuVf2lBBdV00CiBNpLeC4QouX+EPa2eLF2pA68oOfEMoCLpMVgvuUHDy
         9ZV53i1hFv6Xw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 583A2CE1279; Wed, 10 May 2023 10:12:40 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/6] rcutorture: Correct name of use_softirq module parameter
Date:   Wed, 10 May 2023 10:12:34 -0700
Message-Id: <20230510171238.2189921-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop>
References: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BUSTED-BOOST and TREE03 scenarios specify a mythical tree.use_softirq
module parameter, which means a failure to get full test coverage.  This
commit therefore corrects the name to rcutree.use_softirq.

Fixes: e2b949d54392 ("rcutorture: Make TREE03 use real-time tree.use_softirq setting")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot  | 2 +-
 tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot
index f57720c52c0f..84f6bb98ce99 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot
@@ -5,4 +5,4 @@ rcutree.gp_init_delay=3
 rcutree.gp_cleanup_delay=3
 rcutree.kthread_prio=2
 threadirqs
-tree.use_softirq=0
+rcutree.use_softirq=0
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot
index 64f864f1f361..8e50bfd4b710 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot
@@ -4,4 +4,4 @@ rcutree.gp_init_delay=3
 rcutree.gp_cleanup_delay=3
 rcutree.kthread_prio=2
 threadirqs
-tree.use_softirq=0
+rcutree.use_softirq=0
-- 
2.40.1

