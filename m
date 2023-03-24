Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A046C8715
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjCXUw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjCXUwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:52:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AB91F917;
        Fri, 24 Mar 2023 13:52:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64D2162C59;
        Fri, 24 Mar 2023 20:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C270AC4339E;
        Fri, 24 Mar 2023 20:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679691170;
        bh=gVZf2H+pPP8Z48bMWRqaLr70/kxKUljxkLuxY26wyqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ni1eJN+7kNaWmtKsvVQiiGH6hdHlnW/dT0dspJSWO9nRs0nzMfxmZ6DViaCH8OApe
         iZJQf+kd/LQSdkHscBbFFCfqlj7NVOkGtdeoV6bGlgV4B7VX/OnrJbc47mip8NCtD2
         zP+U0piMIZ4OqbQxukFUqD+oKgAbNw7jZaOcgyQHyRRl7cBlkGiIb52ibIq4ktIinY
         t3MgsH5IgCMYBs0KAaLYHFcHXP/wPbDvrGz6uTf1tCNl1oDt1YktvcowZOUCZkS/KH
         Mikw9PsuTr8gryfE0UiHNDffUtcyq+KtCdC+QEJnj+Yo8kEF09OBYP/KnStBKZhNnE
         mIq55gq2CfyDg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 55A291540436; Fri, 24 Mar 2023 13:52:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH rcu v3 3/4] mm: Remove "select SRCU"
Date:   Fri, 24 Mar 2023 13:52:48 -0700
Message-Id: <20230324205249.3700408-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <8ae81b0e-2e03-4f83-aa3d-c7a0b96c8045@paulmck-laptop>
References: <8ae81b0e-2e03-4f83-aa3d-c7a0b96c8045@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the SRCU Kconfig option is unconditionally selected, there is
no longer any point in selecting it.  Therefore, remove the "select SRCU"
Kconfig statements.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 mm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 4751031f3f05..ebfe5796adf8 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -686,7 +686,6 @@ config BOUNCE
 
 config MMU_NOTIFIER
 	bool
-	select SRCU
 	select INTERVAL_TREE
 
 config KSM
-- 
2.40.0.rc2

