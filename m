Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1414A669A43
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjAMOcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAMObY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:31:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0F38791F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:24:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27F6CB820C9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 14:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3F83C433EF;
        Fri, 13 Jan 2023 14:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673619856;
        bh=esY90j133c2/BjnmYrVu1kDOvkaZ0f6/VQ0Je9LIcBc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eiODnWa0NzpFAyWtL1QohU2GZ/9ggSS/XadmZ20qkBdpVnsDv9Tk9bfcRCCTKGoin
         Zwjut9Fx4oX8Gr0FzZYm+rClUFTNX8w9SPxdoubgNqW6T4YwVYOD2Pmz8SUroy5BbC
         TLM9WyDdzykteAykEZK7k/YUb/qL4ldGAV1/yFKRW/tlPH4vkdrRTNRhnWfiqICS8x
         u/Q7s9IVlebTl84X8WxVpUNxnTbfzObxbQ+q/S5Q8Ss9wyuJQD5tl5hMTXjjq0pv44
         tUZCxCMW1I/WFw8m8T3UlDRK4PwN/FHNdiJcVnsVrqs/jVgbsLIfm/emMheG3XuRlZ
         ZXnjijdhA7CZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2965C395C7;
        Fri, 13 Jan 2023 14:24:16 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 6.2-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87fsce34re.wl-tiwai@suse.de>
References: <87fsce34re.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87fsce34re.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.2-rc4
X-PR-Tracked-Commit-Id: 56b88b50565cd8b946a2d00b0c83927b7ebb055e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 689968db7b6145b2e4beb8b472d31162ffa5ad7d
Message-Id: <167361985665.31975.10008034822169763452.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Jan 2023 14:24:16 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Jan 2023 15:09:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/689968db7b6145b2e4beb8b472d31162ffa5ad7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
