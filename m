Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E04C713951
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 13:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjE1Lqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 07:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjE1Lqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 07:46:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB201BB
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 04:46:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FE19614AD
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 11:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B83E2C433D2;
        Sun, 28 May 2023 11:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685274402;
        bh=wn+8Q9pJrAI3tu+D1o8V+yHBs+pXtK/kYamBN1aLhoI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EqCsMzjEZkEI/IPLPMkNHKCiHGO40lS/h1pmR0sul9V774ZZF4DOD+oChbuitsDed
         jvxxn5Ule/oRTi7BVqJkDh+1cYX9lrjqBgXhTy1kv69mBCY1w4/mK/q8iaO8w2E/xq
         DGHkaJWs3bhTdQcOtiKy/Y+1I9CeyEF42Dd0zWVzQt/FUwJympD/eWKRIfdMKIReq3
         Lb8s5eYEHyptaB4xL7mFw8vof1Pc6qXfz1xBGBj9uJbJLIa2JDPl5RMBAkxCJZ9NjA
         QkHTjOZ0vkZf//Du6tjZwd9LnrW6hHFKVOzYiOjOgOTDFNV/CVk56qggQaeb7ks02S
         WVsYu2N1CiRAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97B28E26D20;
        Sun, 28 May 2023 11:46:42 +0000 (UTC)
Subject: Re: [GIT pull] objtool/urgent for 6.4-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <168526035832.3457722.15229575761840032304.tglx@xen13>
References: <168526035526.3457722.14103350194452732675.tglx@xen13> <168526035832.3457722.15229575761840032304.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <168526035832.3457722.15229575761840032304.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2023-05-28
X-PR-Tracked-Commit-Id: 2e4be0d011f21593c6b316806779ba1eba2cd7e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abbf7fa15b7c140da7893f9c910b4762ac99ae7a
Message-Id: <168527440261.32373.9578391715666672432.pr-tracker-bot@kernel.org>
Date:   Sun, 28 May 2023 11:46:42 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 May 2023 09:52:59 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2023-05-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abbf7fa15b7c140da7893f9c910b4762ac99ae7a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
