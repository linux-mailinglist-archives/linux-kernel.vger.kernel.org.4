Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5458B6F92D9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 17:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjEFPq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 11:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbjEFPqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 11:46:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622E91A63B
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 08:46:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1E5F610A7
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 15:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C16FC4339C;
        Sat,  6 May 2023 15:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683387976;
        bh=gxxp5YP/LNmUFFA9kbWb7iZv5tW4/CQIT9J0LNnIO3M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SY5fgPGyVjdBj+AhW6gLSTLk+7mOJ2s4AfjHPHNMnhZWay39IiBMV0lGvx1T5zlE5
         aLup2JtotEOjWdcPpyq0u1Mg5Ynebbd5dHJQBnalpFttW34ePP8M3CI2kO2LUWRp/G
         NRpqg7zkSnk98A9Jh6mWOf7bHyMrSQUMx3FahwcI6odq/VmmUaHqbWhQHcWq4ZRfk8
         sMoW1GbhDjHepCIfbsqzEL1XMrqx1lXW7lr1NAlD6AvJOcQwRFyhX8iTm5xEQsfmHz
         tU2l+7fzcD9XKbR5lj2qBXruEnygpqsMZQ9GkhYo02MiygHDCDf+YiYXFNEvqWXs95
         fytraqMwQChyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47F98C395FD;
        Sat,  6 May 2023 15:46:16 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87o7mxhpoy.wl-tiwai@suse.de>
References: <87o7mxhpoy.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87o7mxhpoy.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.4-rc1
X-PR-Tracked-Commit-Id: ee2dd703470242f1672403e83f827391afeca808
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0021b532b2fdd6b82cf3ff758191f00d8edd235d
Message-Id: <168338797628.28822.17847844238288436729.pr-tracker-bot@kernel.org>
Date:   Sat, 06 May 2023 15:46:16 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 06 May 2023 09:41:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0021b532b2fdd6b82cf3ff758191f00d8edd235d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
