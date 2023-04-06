Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0776DA03E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240457AbjDFSqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240306AbjDFSqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:46:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAF986A5;
        Thu,  6 Apr 2023 11:46:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 211CC64B0D;
        Thu,  6 Apr 2023 18:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83486C433AA;
        Thu,  6 Apr 2023 18:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680806773;
        bh=xJB1cCNnC16/79FNuxDsvllEtGycNn6SPCwLEzBeK3E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=B2AgzZ4t7G3mWFBYihaFxY0sB6ZQaXJSNdg3zPej+t6tawlwnR3x9ta/mySaoLTCp
         B0fgJEia8VIwiwc3CFjvCkfvcTB+Qdd1smVeeCwKt4PKjr/smp2smjdlxcShBeTYjL
         6DjfDqy5+r9iSKTk4+IuyhDJyV83sOzE0x/cbgB3FHfn7i2n5jCKJ0CCPebbJ+myVb
         6LqvIN95A3pzwDA37w4Ybm8Ta7ULyPwUERgPjRtteAZRtualv7KueGWghu7nvBjN1J
         Fv4atVT2n8CVsb2QAKHCwW00VDY1VY36ROQkPX3W03+lrtWY9lGvf3YF/B7Obc16Oa
         mwps6Df8GD1/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64B5EE4F14C;
        Thu,  6 Apr 2023 18:46:13 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Fixes for v6.3-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230406130055.1244344-1-thierry.reding@gmail.com>
References: <20230406130055.1244344-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230406130055.1244344-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.3-rc6
X-PR-Tracked-Commit-Id: 1271a7b98e7989ba6bb978e14403fc84efe16e13
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae52f797904ef0e98951e43d15a274fa8e80bbe5
Message-Id: <168080677340.24406.13255641265047564185.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Apr 2023 18:46:13 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  6 Apr 2023 15:00:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.3-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae52f797904ef0e98951e43d15a274fa8e80bbe5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
