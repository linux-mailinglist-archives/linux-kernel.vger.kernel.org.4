Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F187965E1D1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbjAEAlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240701AbjAEAit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:38:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9854FC4A;
        Wed,  4 Jan 2023 16:38:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71D7C618A9;
        Thu,  5 Jan 2023 00:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5BDC43329;
        Thu,  5 Jan 2023 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879095;
        bh=F+eE9IH0Y6vz1maiMyupWMIpzNBkwY0owmUSVTgPU/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bJASdM3AzhLsv/qlYLK/h5tDWvhjs4W09Nb9Xo7nKT+72tTVAptBqZNjZ5WGRBO62
         MPP6gTpem8itu/jvn0eooIzOTZc2wy5HtkXzpFilOXSQR5yPonmHCdMyLsBw2StRrJ
         IyXR+d1B7Rq337qkaCQUbat8YIo24BRCFKPTh/EVbff9hJQaEM3DMWmp98WHBJmdh4
         9x9GcMsVN0uTBy94xMYu72XqYKxhj/5kkr8ig942qU+FFeiynGph7RjXj5n4JdiJac
         XqLRLgdSqrtWlS/rD01rsC5Z4fvlFRykqbs/02GxYBGmvQuvm5ubSt99o17YuGYQnr
         TpMNlQDS8wRug==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D2AB85C1C9A; Wed,  4 Jan 2023 16:38:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH rcu 16/27] drivers/opp: Remove "select SRCU"
Date:   Wed,  4 Jan 2023 16:38:02 -0800
Message-Id: <20230105003813.1770367-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
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

Now that the SRCU Kconfig option is unconditionally selected, there is
no longer any point in selecting it.  Therefore, remove the "select SRCU"
Kconfig statements.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: <linux-pm@vger.kernel.org>
---
 drivers/opp/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/opp/Kconfig b/drivers/opp/Kconfig
index e8ce47b327359..d7c649a1a981c 100644
--- a/drivers/opp/Kconfig
+++ b/drivers/opp/Kconfig
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config PM_OPP
 	bool
-	select SRCU
 	help
 	  SOCs have a standard set of tuples consisting of frequency and
 	  voltage pairs that the device will support per voltage domain. This
-- 
2.31.1.189.g2e36527f23

