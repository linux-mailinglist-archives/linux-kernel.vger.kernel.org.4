Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58EB6053AD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiJSXEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiJSXEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:04:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABD71D6384
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 16:04:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3BEEB822C8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7104AC433D7;
        Wed, 19 Oct 2022 23:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220647;
        bh=gbKGYKusa1lMx667ZRtUIdCKFZvMu4kQkc2U3mIhaJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IEzk79e3btdHpj+be6y8fiERudUYg+YIijkSzM0rnIa/6M7cHwp8uajkMjIua8BjP
         LxJPv2mKcQgHlPn8uV3q3qDZIp8+epxBI136TPF4Od4wPv/3T+ICO1qcebEhslTHSr
         uLQKA9YeDOkIq9QIPSp2htVk1LTVs8ArK/8KWW0PbK32K5TEtTYtVTKowz3/FL0v4y
         iZ/Q1AceOZmLdR5ZswSxL0z+1f6fpqb1r57pUyxHo5I5goWgUpKA8ZGjgDovLrpUvk
         GFiDAybP3mPO5yFF0jtLbZCfphVA/Ew5lCzxxQmCpWIaZgDSjJeUYFKmsvafxNHr3r
         n/YwcMy1Tefrw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2EBBD5C0890; Wed, 19 Oct 2022 16:04:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        Ryosuke Yasuoka <ryasuoka@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 3/3] kcsan: Fix trivial typo in Kconfig help comments
Date:   Wed, 19 Oct 2022 16:04:05 -0700
Message-Id: <20221019230405.2502089-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019230356.GA2501950@paulmck-ThinkPad-P17-Gen-1>
References: <20221019230356.GA2501950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryosuke Yasuoka <ryasuoka@redhat.com>

Fix trivial typo in Kconfig help comments in KCSAN_SKIP_WATCH and
KCSAN_SKIP_WATCH_RANDOMIZE

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/Kconfig.kcsan | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 47a693c458642..375575a5a0e3c 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -125,7 +125,7 @@ config KCSAN_SKIP_WATCH
 	default 4000
 	help
 	  The number of per-CPU memory operations to skip, before another
-	  watchpoint is set up, i.e. one in KCSAN_WATCH_SKIP per-CPU
+	  watchpoint is set up, i.e. one in KCSAN_SKIP_WATCH per-CPU
 	  memory operations are used to set up a watchpoint. A smaller value
 	  results in more aggressive race detection, whereas a larger value
 	  improves system performance at the cost of missing some races.
@@ -135,8 +135,8 @@ config KCSAN_SKIP_WATCH_RANDOMIZE
 	default y
 	help
 	  If instruction skip count should be randomized, where the maximum is
-	  KCSAN_WATCH_SKIP. If false, the chosen value is always
-	  KCSAN_WATCH_SKIP.
+	  KCSAN_SKIP_WATCH. If false, the chosen value is always
+	  KCSAN_SKIP_WATCH.
 
 config KCSAN_INTERRUPT_WATCHER
 	bool "Interruptible watchers" if !KCSAN_STRICT
-- 
2.31.1.189.g2e36527f23

