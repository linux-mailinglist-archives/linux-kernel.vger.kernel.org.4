Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD87365E1E4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjAEAoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240708AbjAEAiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:38:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995F5C55;
        Wed,  4 Jan 2023 16:38:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91DA8B8198D;
        Thu,  5 Jan 2023 00:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C419EC4332D;
        Thu,  5 Jan 2023 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879095;
        bh=tTPpQxCe30EzZFaC8M8h6GJmnI2dQGjCQpcbnqvTzS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qv+kcb288Gibon1xC+W5aPz+TYF7FmP0Id4z1GWhP8X2I0HPBM93VkZON5J8FaI6L
         xO37MP/VyZVMaaeVVUxfY6VFsuwfqFdyd36Vjj+UMMhMPTRfn3ZaTSBSCaNyw3k0xd
         eKxooI0lPoQB1tb6g+jUcv1R7/YWT3w4KsBAMgdsqeoS9NUrhC4G1T28hBL2eSexSe
         oDwBdsa+BzjX+tr9+bpLorTjZrjr+Pom0Ohfo1ebufb9Iw7bVHXQONAeHCJARAX4qb
         jjPXsLjPWBS+GwDv9CS/Zby6oom5jQ10t0gKWrhTJzcMaYzFt/soq6bicsHgviIOr6
         xZ2FeGiIlm9dw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DC4A65C1CA0; Wed,  4 Jan 2023 16:38:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Jan Kara <jack@suse.com>
Subject: [PATCH rcu 21/27] fs/quota: Remove "select SRCU"
Date:   Wed,  4 Jan 2023 16:38:07 -0800
Message-Id: <20230105003813.1770367-21-paulmck@kernel.org>
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
Cc: Jan Kara <jack@suse.com>
---
 fs/quota/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/quota/Kconfig b/fs/quota/Kconfig
index b59cd172b5f97..d5a85a8062d05 100644
--- a/fs/quota/Kconfig
+++ b/fs/quota/Kconfig
@@ -6,7 +6,6 @@
 config QUOTA
 	bool "Quota support"
 	select QUOTACTL
-	select SRCU
 	help
 	  If you say Y here, you will be able to set per user limits for disk
 	  usage (also called disk quotas). Currently, it works for the
-- 
2.31.1.189.g2e36527f23

