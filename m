Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9EB65E1B4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjAEAlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240697AbjAEAis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:38:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D9AC2D;
        Wed,  4 Jan 2023 16:38:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7669B618AC;
        Thu,  5 Jan 2023 00:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D78C4332B;
        Thu,  5 Jan 2023 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879095;
        bh=CNDCwOrRVxUy3ujKbfGE7sGTvn3Vq+9DqFQxAJ7ZB+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SMaaDhhKZ0MrSTVLCvLXZQMerWIWXg9Cmx8ITsLfD7eS/7W0ZL/uYWoRg4DJoYrA2
         BSeXZ76gZTElV/Z3NAhtMpVAZbpadsQIs9o3D9EvZd9gnpTxWTjJWfVPtMNsvGydvZ
         SXWQo/mM+DQ1epJyiNoY85T6V0sAGb7Th9TKEYyR0sP9M6H/sIAGPpG/ZQqzTF/mNg
         p5tS/v/17Qd8tNkfl1GwoII/gpiTGJGH/GaQ6VM3CKRvzanZjFOPLKg08URm5NBWc5
         43zER5ex/EwPEy6+/ot1ZSkb6Pkfjzu8CrsbxJLbZt3/+BGrMvex2cC+EyHu67EpfY
         mEOr3RN5u0erA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D83965C1C9E; Wed,  4 Jan 2023 16:38:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com
Subject: [PATCH rcu 19/27] fs/dlm: Remove "select SRCU"
Date:   Wed,  4 Jan 2023 16:38:05 -0800
Message-Id: <20230105003813.1770367-19-paulmck@kernel.org>
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
Cc: Christine Caulfield <ccaulfie@redhat.com>
Cc: David Teigland <teigland@redhat.com>
Cc: <cluster-devel@redhat.com>
---
 fs/dlm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/dlm/Kconfig b/fs/dlm/Kconfig
index 1105ce3c80cbd..b3b86dbdc1878 100644
--- a/fs/dlm/Kconfig
+++ b/fs/dlm/Kconfig
@@ -4,7 +4,6 @@ menuconfig DLM
 	depends on INET
 	depends on SYSFS && CONFIGFS_FS && (IPV6 || IPV6=n)
 	select IP_SCTP
-	select SRCU
 	help
 	A general purpose distributed lock manager for kernel or userspace
 	applications.
-- 
2.31.1.189.g2e36527f23

