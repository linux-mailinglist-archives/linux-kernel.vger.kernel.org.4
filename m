Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C46C6EB03E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjDURIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjDURIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:08:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D985B13C32
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:08:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 419896525E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 17:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F587C433EF;
        Fri, 21 Apr 2023 17:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682096883;
        bh=P7AtTxrUuQRWCLQCX9w2HQk/HuLKjYQXIL6CiNpN1jI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UrmB5T9cT62vIh117rdfMCo31OpBOxv5RAamCqS5YDqzMue2hPTmRaWlV27oj1vf3
         y4LMZ8NFfrK6BLxhLwaZWSlntR02rPuHz1fCbxyqc6Q//V2/P7r6HY3AA75PcXVQ9R
         AehOs7DmegRDhfM3Nv1eAdzZTMYSmVKqU7ImRR4lKoyG207SQxDOAlWksbBwxE1Vvi
         Sxq3pIJsvQKq7YMg3e9l3uCYuArfz8383olbxnCNcrlRcc58/ux6i+qkfr4OQijO+X
         xQKrdx+CiLfRB4bz019yURnLKWw4h/efqgJu6Ryc7UmaYhsPdIIR7sWlHW8/3+Trj0
         PkSNDJpSad8VA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F44AC395EA;
        Fri, 21 Apr 2023 17:08:03 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87pm7xsjzx.wl-tiwai@suse.de>
References: <87pm7xsjzx.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87pm7xsjzx.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.3
X-PR-Tracked-Commit-Id: 2ae147d643d326f74d93ba4f72a405f25f2677ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a14e151910dd967311dbdfe6d95dcd04e777db84
Message-Id: <168209688358.21086.9367664292987414615.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Apr 2023 17:08:03 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Apr 2023 10:43:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a14e151910dd967311dbdfe6d95dcd04e777db84

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
