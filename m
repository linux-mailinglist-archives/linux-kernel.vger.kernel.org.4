Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A816A65357D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiLURor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbiLURon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:44:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B568623318;
        Wed, 21 Dec 2022 09:44:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50728618A0;
        Wed, 21 Dec 2022 17:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4FDEC433F0;
        Wed, 21 Dec 2022 17:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671644681;
        bh=1iFBY3oPj6s1c08dj0BkjtAfIH8ml+5ngtszWIQJ69U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UYE7AAEY6Dic+QvbFKLAcw8r9LyWvttXi6CyYA3iBm4P6HxY4JomO4G8yAEwGT4PR
         TV5SOxDDKW0l5hskH1ckNrPtUyFrYlmZtuWE/4P8GKQ5zNoLtOGHUPdkm+AKAecl2q
         2l/5yxc+qugY33FTOQCaLa0kGKPYhy5A/tOvV37HYjCqIHhNM2nGRLB7S96pIFESkv
         XJEMMDibtdHVsINAjfBXEhgtV53JKMwQQUvp9k+dJazdsOAG0es5VOU8IzNjY9qa6T
         3gcyCct01v9wYplSYRfdZiCQ+e3p7FCkFTFAb7a3JEOOXLuFXXzSlD3nhZ2naozmM7
         mFC9sNSPwo6Eg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A448DC43141;
        Wed, 21 Dec 2022 17:44:41 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221221095258.952766-1-thierry.reding@gmail.com>
References: <20221221095258.952766-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221221095258.952766-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.2-rc1
X-PR-Tracked-Commit-Id: 8fa22f4b88e877c0811d2a0e506cf56755add554
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a693ea78e3c48605a2d849fd241ff15561f10d5
Message-Id: <167164468166.23021.13537099911842436572.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Dec 2022 17:44:41 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 21 Dec 2022 10:52:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a693ea78e3c48605a2d849fd241ff15561f10d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
