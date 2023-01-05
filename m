Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693C065E1DB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240703AbjAEAnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240692AbjAEAis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:38:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974BBC25;
        Wed,  4 Jan 2023 16:38:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8289E618A2;
        Thu,  5 Jan 2023 00:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0887C43330;
        Thu,  5 Jan 2023 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879095;
        bh=gga//6dn2CIxYDjd4uFuwFdmdAYgvyqFrWt6xDOyEao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=muaya0j7eLdCrveK++V8rYMeNoBFu+tZoUI/MPGQjjsqfFzZL2EkWp0cFvT9f4mxs
         E+ZAPUeno25HNWkHOpZMgZYAM1It5Kzys+JHw/dymgJ3AecWNjpcsKjyExR+57SeiG
         kMHbtGBXQUtc5E48W0VjdLbayGgpQP6FyXZU1WJicBzPPlaORiXwbqBQbSfsd/d987
         nrR+3FerRuKC7M7fn9kV5rnjLMyCtIMZpOoKGduC+emL0ob4UyZpq+XJu6kVCbegLe
         hXgfe581uSK9qVnopyz/odYTfBUdLdgth2D9AXUyo0KNATqksL0QC1Lg+Pst9dZfYf
         viP4SHZm0GsnQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E05CF5C1CAF; Wed,  4 Jan 2023 16:38:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org
Subject: [PATCH rcu 23/27] kernel/power: Remove "select SRCU"
Date:   Wed,  4 Jan 2023 16:38:09 -0800
Message-Id: <20230105003813.1770367-23-paulmck@kernel.org>
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: <linux-pm@vger.kernel.org>
---
 kernel/power/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 60a1d3051cc79..4b31629c5be4b 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -118,7 +118,6 @@ config PM_SLEEP
 	def_bool y
 	depends on SUSPEND || HIBERNATE_CALLBACKS
 	select PM
-	select SRCU
 
 config PM_SLEEP_SMP
 	def_bool y
-- 
2.31.1.189.g2e36527f23

