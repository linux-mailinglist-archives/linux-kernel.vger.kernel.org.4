Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092A366883A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240147AbjAMAMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240210AbjAMALm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:11:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA075D8BC;
        Thu, 12 Jan 2023 16:11:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFF456220E;
        Fri, 13 Jan 2023 00:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C5CC4333D;
        Fri, 13 Jan 2023 00:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673568695;
        bh=ARE5BFVaVppRxywGryZ74nx46BxsePEDvEb629mD45A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rRHB9Y4dHFj2Ms0T2fEPrTN5McPyZ45mFflZLvAChrb127N7SYaj2rXjg/s7uae9t
         NnifRlR8Wc/js9l1qa4WDOXyU673M9PQ/xh326FAYJGRKRKJ4//D1N9tq2lt6HVaTE
         pZLTbWD0MX/CEf22Eox27KzHxL22Aod75GefyLjdSpMCaJoRYnKtYE8CzIiBA9L0iq
         xvB3ZjifpFOjBHJyXbnxfOkcxB3Hjf8h6sYwOnFxf2OeWRq3MrWXLko0f3+LXNCe7Q
         TFdlBwfDCMOCXM3G0kaXkpAoBif2fhsM280fSqrlnaVZAL0U7Prm7y8wf5x8aOGz0x
         ovgVMtpwt9RKg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B81CF5C1C9F; Thu, 12 Jan 2023 16:11:34 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        linux-mm@kvack.org, John Ogness <john.ogness@linutronix.de>
Subject: [PATCH rcu v2 18/20] mm: Remove "select SRCU"
Date:   Thu, 12 Jan 2023 16:11:30 -0800
Message-Id: <20230113001132.3375334-18-paulmck@kernel.org>
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
Cc: Andrew Morton
Cc: <linux-mm@kvack.org>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 mm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index ff7b209dec055..dc660775b7d3f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -667,7 +667,6 @@ config BOUNCE
 
 config MMU_NOTIFIER
 	bool
-	select SRCU
 	select INTERVAL_TREE
 
 config KSM
-- 
2.31.1.189.g2e36527f23

