Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADAE6534F5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbiLURTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiLURTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:19:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4582B264B5;
        Wed, 21 Dec 2022 09:18:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D687F61871;
        Wed, 21 Dec 2022 17:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CDF8C433EF;
        Wed, 21 Dec 2022 17:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671643107;
        bh=vgtePbIt1Yp7RasEd6oI91vjprm/wps3RcyTr9l+lJY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RjTqSGqeTq52/fB5yaUvRKKY3Oc3PpIoqZ8D+r8hVKHZyJ3YFmsrLXWQCpL6yrbuF
         DDQr9N5WanjtD8pH0sp1Jmf8ES+cl5w17GxN+STh8Iw0FkVfHwpfcDUmHxIn21U5ze
         enw27ZK9KjUrTlu/rKAh0wVtartTWBjNngC5PEuY1muUUrCdufx34OA/W8rP/7bx8s
         HcVCbxGJr3fVc2HYEzpwT3k2h3oU2SgQmif9woyPtxPOvJMbqvdlJ7/3WtP1dTYFLw
         cR4ejxaOu/6sqBc9YwqQfrukADx99XrfUfdJoUnpPssacBxl6OA73hyu5tfTMvJZBN
         BOsPbhtG1RW6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A85EC395DF;
        Wed, 21 Dec 2022 17:18:27 +0000 (UTC)
Subject: Re: [GIT PULL] Avoid synchronize_rcu() false positives in semi-early boot
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221220012906.GA3102709@paulmck-ThinkPad-P17-Gen-1>
References: <20221220012906.GA3102709@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <rcu.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221220012906.GA3102709@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu-urgent.2022.12.17a
X-PR-Tracked-Commit-Id: 3f6c3d29df58f391cf487b50a24ebd24045ba569
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 19822e3ee4c891e1e8434e290fbca0af52490240
Message-Id: <167164310717.3046.7874278338213977672.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Dec 2022 17:18:27 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, kernel-team@fb.com, rostedt@goodmis.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 19 Dec 2022 17:29:06 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu-urgent.2022.12.17a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/19822e3ee4c891e1e8434e290fbca0af52490240

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
