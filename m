Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555906C276C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 02:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjCUBZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 21:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjCUBZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:25:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247291A97C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 18:24:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F64DB81193
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36366C433D2;
        Tue, 21 Mar 2023 01:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679361099;
        bh=lUIoRgu7u8AVYczSe4iE5SbypLoTY7zfMu5B7qh6z9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E93DxFEBEbwJNzCqr0N2ssfljAmbsiRWfeg7u79DiIqpyO90jiIaP39qwQZPWgpo3
         B3EMyY73nB+Khhlwvg4365YWqxwjKjdM0IHdRWSXfTPkBsUldzAAUiPoFP+Y03C9KO
         FP0g/CSET+5MTef5j+cxbabkuzoBk0602qaH4V5HBGNZRlx9TMvAv4ngHuZ9BT2BUY
         dm3SKoHNdyUTBbwINx2L0xGODQxunNKNHBL0gqJuHKml6Y4gbiqN1h+DllqgfcSzeS
         g6y2jA03blQUCpAidNzQHzuG2qslaoCwY/D+YKgwAHY0/0LwvP2abyUeM9cJPl9m5b
         NeOjb7HAyv4GQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D6E7A154039A; Mon, 20 Mar 2023 18:11:38 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        "Paul E. McKenney" <paulmck@kernel.org>, Willy Tarreau <w@1wt.eu>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH nolibc 02/14] tools/nolibc: Add gitignore to avoid git complaints about sysroot
Date:   Mon, 20 Mar 2023 18:11:25 -0700
Message-Id: <20230321011137.51837-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <6a3206d0-e5cd-4990-9604-444a24a8207c@paulmck-laptop>
References: <6a3206d0-e5cd-4990-9604-444a24a8207c@paulmck-laptop>
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

Testing of nolibc can produce a tools/include/nolibc/sysroot file, which
is not known to git.  Because it is automatically generated, there is no
reason for it to be known to git.  Therefore, add a .gitignore to remove
it from git's field of view.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Sven Schnelle <svens@linux.ibm.com>
---
 tools/include/nolibc/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/include/nolibc/.gitignore

diff --git a/tools/include/nolibc/.gitignore b/tools/include/nolibc/.gitignore
new file mode 100644
index 000000000000..dea22eaaed2b
--- /dev/null
+++ b/tools/include/nolibc/.gitignore
@@ -0,0 +1 @@
+sysroot
-- 
2.40.0.rc2

