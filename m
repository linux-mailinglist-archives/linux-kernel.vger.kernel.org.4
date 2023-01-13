Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7F7668838
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240280AbjAMAMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240147AbjAMALm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:11:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1065D8B5;
        Thu, 12 Jan 2023 16:11:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75629621F8;
        Fri, 13 Jan 2023 00:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C1BC4333B;
        Fri, 13 Jan 2023 00:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673568695;
        bh=a+uHzF3ftrhu03vhyGE1GGZJhFSl240uKQNg7uObNq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CAgOW7vex+ciCSbrcKe8mLcxjKiLczRbAQV5b9bKwi0+OPtjYiT8btE5jC0aYRf8H
         37Psnqhjhrn1i4ztWAOkCajlguuD5eclmrk9MKvSQqeZNCLUz1z2jnS/DZ120GTo2O
         ID7wA/kR+BdRCoatdNNnnJYDQiB3GgFwgdwtzGHDgvfqhlD+kpSJelHs802rFGVoLB
         0Q5S4ljC4OYfCklgjb9YFEjTcJbRwVbTmOf6Eg4XQj6gk6m021g/dYDQ0aBCTRAYOi
         Nzy4evUPiRT3EJJByGvhpcBDHVoB5D3QcW0uQ7A7kJePdjqBcHxYa1tURasPzzHF39
         KYnCoWNWNG3CA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B9EB35C1CB0; Thu, 12 Jan 2023 16:11:34 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH rcu v2 19/20] tomoyo: Remove "select SRCU"
Date:   Thu, 12 Jan 2023 16:11:31 -0800
Message-Id: <20230113001132.3375334-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
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
Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: <linux-security-module@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
---
 security/tomoyo/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/tomoyo/Kconfig b/security/tomoyo/Kconfig
index b9f867100a9ff..a9796b4003124 100644
--- a/security/tomoyo/Kconfig
+++ b/security/tomoyo/Kconfig
@@ -6,7 +6,6 @@ config SECURITY_TOMOYO
 	select SECURITYFS
 	select SECURITY_PATH
 	select SECURITY_NETWORK
-	select SRCU
 	select BUILD_BIN2C
 	default n
 	help
-- 
2.31.1.189.g2e36527f23

