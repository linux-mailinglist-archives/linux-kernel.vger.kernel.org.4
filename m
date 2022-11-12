Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C8E626AEE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 18:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbiKLRmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 12:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKLRml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 12:42:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A51511C06
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 09:42:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D11760D2F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 17:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8150BC433D6;
        Sat, 12 Nov 2022 17:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668274959;
        bh=v/mMioXqOoAOb4CWHK4l63LsvmPKp/xZM++xW+bd3AE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ONZ2nGD7aXKv0fq+BJhxT5vsChONMoMbmbp4/V2o2uOc+U/lQtJGmED2Vjru2t4Iw
         alZBr0JMjkQW2xXj57PTa7uGt0NiYg9Sgc1Pd4YO35e1Ffo1hPN38Be0PuriEp8c2l
         sxF38hUMConEu23aK8KPNezXAO5A9EGLEvv8frKhXt6r5yg5Nv1b3KuIfzrfN2jR+Y
         EBJmHWjf5j3bneqGtZRN02bqPI/mPVQ9EccHbCVgaBwsQRQiJ7cePMzpaRG0ocFEkN
         H79dXfSgnZXA6FD1Rje1YEIuRL4EVOWxBZxQPdbT4Qkd1/oglOvHWI2/fjvoyi2ubZ
         s9bzD5+f4h21A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6DD6CE270C3;
        Sat, 12 Nov 2022 17:42:39 +0000 (UTC)
Subject: Re: [GIT PULL] Another sound fix for 6.1-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87sfio33zb.wl-tiwai@suse.de>
References: <87sfio33zb.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87sfio33zb.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.1-rc5
X-PR-Tracked-Commit-Id: 9d8e536d36e75e76614fe09ffab9a1df95b8b666
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f95077acac6d3235735a41cc5f25a024777399dd
Message-Id: <166827495944.17539.5933080545843364349.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Nov 2022 17:42:39 +0000
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

The pull request you sent on Sat, 12 Nov 2022 10:40:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.1-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f95077acac6d3235735a41cc5f25a024777399dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
