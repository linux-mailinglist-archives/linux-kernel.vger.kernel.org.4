Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881406ED592
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 21:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjDXTuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 15:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjDXTtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:49:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04F76E89
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 12:49:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC42B628CE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 19:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CE28C433A8;
        Mon, 24 Apr 2023 19:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682365745;
        bh=YWSi5nrTNSvH36f3Qnm9yMuslWJF4ZzaGC9wNlX+avE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KBKZxDl+MXoygXz/tijnJoM1tCvM2kymDfCFzf22SxoJuM9Pnqrgw7UMRhFCu6CSl
         8j8pCmUg50JsHmuk3n9lqET4wngXiCMpZXeQvWBOFOEdJEHUMJSFN7xWzURgCcBlg8
         yChyL+v8Dg+vnSKvAhIha44T+7ocEg0agmbyLgZNLpbNDBhOlkb/KTNSQ82/wK8eBr
         v8/+3FksHXPYT6wUyUUhk4HmcaPZ5x7xrKvvLYIS4scm4+1EfZBatE9tTAtdvkSACY
         XrSXXt8EqbJedt4WIitvMnA/P+rRnhdlfk7YPbyBiQlmNs5QEnZ+jGLq05uxB0Xb2e
         MpEEABpzQTqyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4947AE5FFC7;
        Mon, 24 Apr 2023 19:49:05 +0000 (UTC)
Subject: Re: [GIT PULL] nolibc changes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <455d6aeb-f2cc-4967-835e-92a10edc616b@paulmck-laptop>
References: <455d6aeb-f2cc-4967-835e-92a10edc616b@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <455d6aeb-f2cc-4967-835e-92a10edc616b@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2023.04.04a
X-PR-Tracked-Commit-Id: 0d8c461adbc4a43736927f93db69ae376efbc2f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d77652fbf2318f61af2cf27779951393dd0f749
Message-Id: <168236574529.6990.6119805005529409538.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Apr 2023 19:49:05 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, w@1wt.eu, linux@weissschuh.net, v@vda.io,
        chenfeiyang@loongson.cn
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Apr 2023 16:20:19 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2023.04.04a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d77652fbf2318f61af2cf27779951393dd0f749

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
