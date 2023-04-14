Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28D66E2997
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDNRlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjDNRkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:40:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1538DAF25
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:40:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8359760BBB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 17:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9E5CC433D2;
        Fri, 14 Apr 2023 17:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681494035;
        bh=kfY26+A6t+lUR2hDE7hgaotaYZSSWByBqgQAbiDjEUo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Wy5aWtEYyae4ICp1Bf05pre4AtjeEmJN/U/sVk4luVVwpsTRbN0M5JP142Iq5tloo
         /1lWBHegpiu9N22pOPbDCGM7g7oOhUeW2LyROTLD3tsz1fAoEwrmS5S8rg7sfNbHkB
         a1O45xyhEud9nCKoQa8qgcfP6JlWv/3Wz4rx8I8gwVtHhAFOhMegqwn4U0sj+21eSD
         OgvU+IOU/OyXGha0Pdn5qVo1nU1XuRewmx8oAVo+dE4V20jdvWxwjcHwyK7G9MIPjh
         Z3IHSCc3WQvUQwbPxTAAW9Qy18zzpm5AwjdCojNhycc8k6dy5orz2BEeh3BHMJ2dXQ
         YGytCb+0XvyuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D89C9E52446;
        Fri, 14 Apr 2023 17:40:34 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.3-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87v8hylkbx.wl-tiwai@suse.de>
References: <87v8hylkbx.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87v8hylkbx.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.3-rc7
X-PR-Tracked-Commit-Id: 6ab6f98fcdc9d4fbe245aa67de03542deea65322
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e251c4231834184a3a2a39b1800e983bb116ac6b
Message-Id: <168149403488.11053.6860833536167175064.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Apr 2023 17:40:34 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Apr 2023 14:28:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e251c4231834184a3a2a39b1800e983bb116ac6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
