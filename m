Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFA86F0C7F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245288AbjD0TU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244759AbjD0TU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:20:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31554524A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 12:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2740563F72
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 19:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A24EC433D2;
        Thu, 27 Apr 2023 19:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682623219;
        bh=hkk1y+NpDtu2xDLL9VCHyebusx+EH2fOwY4kEB5i1tM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PPWjxjcp/3JJX3H+7O2aOa5dtn2Q+qApcSq63/usncxU4o8+nPy47yaI8LTL3tO6M
         gT4gVQx9oNmYQOnUDfYtsl3wFKgkpsSCv/cTE6RkBkYIwQxsVnIoNlO/LOXAShGK4j
         eOxjsflLYxQ3+BQ4fyx4pcI/rqTpVkxtKyb32bbL88H5tpnnJPSU8b/UtcnOYjALvg
         WQlO3YrX7YLxh/6ChONzDlkJj1vIk6pANL/ZfdnujpBzty3YHszbkEovZHLubmyYXu
         JjTc18x/LQkj9jT5SLepq0Di8evnJTYh6ISl6mHXMkzg2yR9ovmgRbgxp3LtKEZ/9c
         urmYIvBt3ilAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78BE8C39562;
        Thu, 27 Apr 2023 19:20:19 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87bkjaonra.wl-tiwai@suse.de>
References: <87bkjaonra.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87bkjaonra.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.4-rc1
X-PR-Tracked-Commit-Id: baa6584a24494fbbd2862270d39e61b86987cc91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c15ca4e4efaddb78f83eed31eeee34c522c3ae2
Message-Id: <168262321949.21394.4413604512805220832.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Apr 2023 19:20:19 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 Apr 2023 14:02:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c15ca4e4efaddb78f83eed31eeee34c522c3ae2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
