Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFE3672B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjARWrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjARWrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:47:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B6F5F395
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:47:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2777DB81F83
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 22:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3FA3C433D2;
        Wed, 18 Jan 2023 22:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674082024;
        bh=nIl9sSo4GTkpmGJJnKmrU0lojQLRNTxIRKzjL5q9Y0k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qsdkKqI24JPKCPq8X/FgYhYZPvtV7cUigROIIkwF4A3wJ2FLBvHDEGg531qA0Ir6d
         Lor4iqqwWKPDN/uN/iBp+bFH5eRa5aHmtmKKw1fTv6tVg1YRLhhXkgnDArVg/ySHNG
         /EgBDAprpXNoV+PEUXJK9LeSOQyVOCGR55/qEK6CeT4Lgou5fap9URX9Lm1FGHKZy9
         f+RyoXCqV45HY6GRoA84ahGu6hJvON1vXcHpVll2mpkVGLgfjf43kkx2pJWZBQQBpz
         Wn7R4pQnXfe/+Bgv6mDLb6IOK8keidZ3fec16JDqDtVQ3nfEai9Bk52vYFqkUIWzwq
         6/UR1ft85H4IQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD2C1E54D2B;
        Wed, 18 Jan 2023 22:47:04 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.2-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y8fxnV7ol9OP6JSz@debian>
References: <Y8fxnV7ol9OP6JSz@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <Y8fxnV7ol9OP6JSz@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.2-rc5
X-PR-Tracked-Commit-Id: e02ac3e7329f76c5de40cba2746cbe165f571dff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5fbad44dddf560ba03e247352e8040992c7e95e8
Message-Id: <167408202476.14684.4740220252510854276.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Jan 2023 22:47:04 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Siddh Raman Pant <code@siddh.me>,
        LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>,
        linux-erofs@lists.ozlabs.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 18 Jan 2023 21:18:21 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5fbad44dddf560ba03e247352e8040992c7e95e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
