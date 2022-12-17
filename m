Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6FC64F965
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 15:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiLQOba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 09:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiLQObW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 09:31:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99294CD6;
        Sat, 17 Dec 2022 06:31:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D392B80E3B;
        Sat, 17 Dec 2022 14:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBE0CC433D2;
        Sat, 17 Dec 2022 14:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671287478;
        bh=zuY4Z3A09N7iywF7L5TqR3KcfB/GD4XTce6j8hhBTzk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ML7v2JX98m6GGM/prArhzhQ8ykWebOecyS2d+KiK04GINphDMqasu5aDu5cRSmmuR
         DBoG1UANu2UrkZfxNcLlM56pY27i6vS301E4q2i8nTngTJ7x32D+98Sii18spUVZwe
         PP1b3T5UZNB/HRsjDpC4cLm7SiQI+0VzN5wRNE/runfep2moeoImbtQkzeoay7h5Wf
         66wTYELL7fe0EftCIYn4qM9sZ4WMvJjOVfKHWiLzlimBO1NcEPvLuzSSMQMrARAlSj
         dEUiXN5faRiY/83adYys6574lrbP8HSe5LSfv7JVD6z4WeT2NZMbV2w27duwTBOs2l
         wCSxGB2CvoClw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C925CE21EFC;
        Sat, 17 Dec 2022 14:31:18 +0000 (UTC)
Subject: Re: [GIT PULL] LEDs changes for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5xIuL2XfobFm9U1@duo.ucw.cz>
References: <Y5xIuL2XfobFm9U1@duo.ucw.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5xIuL2XfobFm9U1@duo.ucw.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/ tags/leds-6.2-rc1
X-PR-Tracked-Commit-Id: 7cb092a0336c5770656c6742e7a7ce3042c8c44e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75caf5940899a33165fb3d521492f3cd6b20c9a7
Message-Id: <167128747881.22169.5100672320704103141.pr-tracker-bot@kernel.org>
Date:   Sat, 17 Dec 2022 14:31:18 +0000
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        lee@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Dec 2022 11:30:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/ tags/leds-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75caf5940899a33165fb3d521492f3cd6b20c9a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
