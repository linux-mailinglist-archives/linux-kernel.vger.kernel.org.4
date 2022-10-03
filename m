Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C4A5F3495
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJCRdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiJCRcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:32:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C2339BB7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 10:32:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D01CF61121
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 17:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F38FC4347C;
        Mon,  3 Oct 2022 17:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664818324;
        bh=+6A04JyYxz/ylUPH7egvnQOnbovy9HfLqz6ELLwELqc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gUwfoFbHHcs2tbsJsdon4o7Ryypxs1lCVJ0Lnj1wlCoW8AIMml9wKYLA2Kvq4v58z
         7IcGIRUdspGdsKli0JMVac3tQNm50durNolBHM1zWN+rqhz+xFCPtEFfD+dDqzYPEY
         Z1kXtf8Uayi9J+9fY8NbMbjBLnksjmPDsk3+cM0yMeg4ya9/1qwn9Njh58vie8erwu
         eLli6UGWE10SuSzK56JS1R2fF06A87rNxbp5hvSQ0RQS3f21pW4CBYQL5WE0UoQ1qp
         djTI22I2GAT7WxWisum5ePb6AS/hE7hPH6e/LvSQdID6FpgKt9rBM5ohbpy+n7k3i2
         dnKQdQyM8QojQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F6DCE49FA3;
        Mon,  3 Oct 2022 17:32:04 +0000 (UTC)
Subject: Re: [GIT PULL] nolibc changes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221002032342.GA3512899@paulmck-ThinkPad-P17-Gen-1>
References: <20221002032342.GA3512899@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221002032342.GA3512899@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2022.09.30a
X-PR-Tracked-Commit-Id: 43cf168fa99992ee70ff041a61f866f56aa47f3b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dda0ba40da68255cea24474e69bcf14499408e2b
Message-Id: <166481832418.20277.13069778912876020763.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Oct 2022 17:32:04 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, w@1wt.eu
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 1 Oct 2022 20:23:42 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2022.09.30a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dda0ba40da68255cea24474e69bcf14499408e2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
