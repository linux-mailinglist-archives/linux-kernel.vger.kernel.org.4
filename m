Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575AC65353F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbiLURcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbiLURcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:32:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60686264B4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:32:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F18B161772
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 17:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 626F2C433F0;
        Wed, 21 Dec 2022 17:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671643930;
        bh=14FupXfI7BNqlyqYd+i2UtwHTDaU8B8LnURP70/rexc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XR/cgGikvB3tajCvkQV8G6mOlSVOD8diSaj9c+KNJOmdocoB0BPfb9UjOq/exWjv7
         M5p0bGIOZpwbXvt+F9mk3NEuFwj8x7Pdd1+QKNtNzn3H8dT4iNuAGk7exe3eoilPKZ
         bYRD+tXHr3hV8KcAuUHraHgHsBSWwmEGzxQnZQQ4qKHvJ0YdZ8MdM+eq0cR6i2zNKE
         7kR1SP9lR0o6xSodmIyUl717U6Nmot0/GI2wK89d6BGmBkBA7czSPMHnd3pnPCJOyY
         v3BCcET6fMBZwc0BQavShGN1ekMAFyNllNfy2xoVM27knSPBeFl0xLtk4yzuaBwsA0
         7L1tF3oFmpt+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C0D3C395DF;
        Wed, 21 Dec 2022 17:32:10 +0000 (UTC)
Subject: Re: [GIT PULL] Backlight for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y6GbxUZ2weD7PxoN@google.com>
References: <Y6GbxUZ2weD7PxoN@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y6GbxUZ2weD7PxoN@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-6.2
X-PR-Tracked-Commit-Id: 0de796b6047d1ccc29d03fcd0a93dca52691ec21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec34c2b4ec383766a42ffd9206dc6605be3c6f6c
Message-Id: <167164393030.13641.908505737032086933.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Dec 2022 17:32:10 +0000
To:     Lee Jones <lee@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 20 Dec 2022 11:25:57 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec34c2b4ec383766a42ffd9206dc6605be3c6f6c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
