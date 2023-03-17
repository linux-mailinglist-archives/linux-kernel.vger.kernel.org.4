Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F556BEFE5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjCQRjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjCQRjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:39:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89EEEC50
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:38:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D2956103E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 17:38:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB16AC433D2;
        Fri, 17 Mar 2023 17:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679074734;
        bh=8ZNPLMnBZnN0w7nHekx4Vp2nsiF7Cw+GbU4STxDpoJU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AXltVlDE/yOd2E4A9/crVYlwybFANV8yP+8ARmnBiIcE9kAsTHQmaBciATQOOhEpt
         ryBcc89Yfft/Mccf9zyDYLtm7LSTm3IIR0DA3SNzSYvJQvBgEbL1b3Jtk2/mmNYbVl
         1yrwY7P0Eq6taOfQZ5JuCasultgOmm00C40fBTCyp8XwBxzpUPzDBZT1yQw3gj9JEi
         k7gLjBNK06pn3NWn4/1IY7zPmAmjFJ4Vxrs5ez9o14w/aXh99T2xoh482wmCYeOYp0
         ThKAJeHWXyTFlOYoEHW6p9FWiMUoXwhZ7l+RbnEnrog8Y/cP13ZOzGQaEyApdSpH3/
         /GwRRXH/tZ78w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9AC79E66CBF;
        Fri, 17 Mar 2023 17:38:54 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.3-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <871qlnafr6.wl-tiwai@suse.de>
References: <871qlnafr6.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <871qlnafr6.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.3-rc3
X-PR-Tracked-Commit-Id: 98e5eb110095ec77cb6d775051d181edbf9cd3cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97eb2d981de3b1173ab464e3253991425728b597
Message-Id: <167907473463.9394.2228953349831861686.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Mar 2023 17:38:54 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Mar 2023 10:28:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97eb2d981de3b1173ab464e3253991425728b597

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
