Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C9B678CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 01:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjAXArM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 19:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjAXArL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 19:47:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED02B2ED4C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:47:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B0C9B80E99
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281E8C433D2;
        Tue, 24 Jan 2023 00:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674521228;
        bh=TwEEJ6BKO130ehEx2hhnhostX+GgOKcWcy+KnFJIDCM=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=oCBLZWsRy2ErOMcMdyGkMrML347nAThHkajjVfFEEsIg2VoTBnUKb8950Y75NC4yB
         pbcBECVq1wCng1cnGJX2P6O3iLh82+EMHk46ZTz09tkAY0Qa7bUvNNCXH92gg7C79K
         sE5Hsh4DOo5kl1tk7ztCS8ZiBvXeuRnpQudNmlx1sq90EZisu6J+stk9GjexplgMlG
         2Z3n7j7YwrZOL55sAt8otPL7hizWVjwai0VOKFcFw3cjGKEQftBulNVNMYAXg0zt+O
         w+sdXWrK4VGPvfo1WJ3C15YIfdiTutGUZeJdp0QWPgHQgu41AFQClyf8rOHXqp463J
         l4iHUo1gk3BqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BC7295C0865; Mon, 23 Jan 2023 16:47:07 -0800 (PST)
Date:   Mon, 23 Jan 2023 16:47:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     w@1wt.eu, ammarfaizi2@gnuweeb.org, svens@linux.ibm.com
Subject: [PATCH RFC] tools/nolibc: Add gitignore to avoid git complaints
 about sysroot
Message-ID: <20230124004707.GA318943@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing of nolibc can produce a tools/include/nolibc/sysroot file, which
is not known to git.  Because it is automatically generated, there is no
reason for it to be known to git.  Therefore, add a .gitignore to remove
it from git's field of view.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Sven Schnelle <svens@linux.ibm.com>

diff --git a/tools/include/nolibc/.gitignore b/tools/include/nolibc/.gitignore
new file mode 100644
index 0000000000000..dea22eaaed2ba
--- /dev/null
+++ b/tools/include/nolibc/.gitignore
@@ -0,0 +1 @@
+sysroot
