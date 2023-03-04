Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73E26AAC93
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 21:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCDU6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 15:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCDU62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 15:58:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921E1F944
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 12:58:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 520E3B8090B
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 20:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FE65C433D2;
        Sat,  4 Mar 2023 20:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677963505;
        bh=IR7qgg8Y7kNzEL5nIPKViygHyRn3OLo1AwAj02x6IhQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IM77freXJi4tiI/Q/raK/gMb5bUpBtRIkFZSXuo+8uBkDKJeABbl2WgvmkqUJW3jF
         FSb+Fxu+ouhfl57u3IOKpU+eJ60VDZq997ffeutiRjcEh6kXivnXNh+CfoNcNy0POo
         8xnq2biXqkXHj4RlDAsx7fHDircKnCKOHDMK7yGcT4gW/KySv9fnZwNrQ1dqxM8xb7
         bKpCvOdAWHKoK/LCAsTfyBRfqTPi9mj6M0ngPeSSfSfpysU5iVx9vu82Hz9GyDwI8a
         BbVFP4g4Vbq8XiGYs2QcXH/rhzAIALszcR1QqPCBZWp6IFno40ZH5LoCDDzuMEtPqC
         n/QDfrJZ4eh4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1455E68D22;
        Sat,  4 Mar 2023 20:58:24 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87sfelrw2n.wl-tiwai@suse.de>
References: <87sfelrw2n.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87sfelrw2n.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.3-rc1
X-PR-Tracked-Commit-Id: a8e98f3448e1a4b6848f213cf51720e29dcc774b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d172859ebff33598d80089c0bec44471872d2628
Message-Id: <167796350498.24622.11905277780156234114.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Mar 2023 20:58:24 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 04 Mar 2023 05:15:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d172859ebff33598d80089c0bec44471872d2628

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
