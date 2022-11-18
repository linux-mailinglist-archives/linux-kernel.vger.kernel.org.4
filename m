Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A110A62FEAF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiKRUVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiKRUVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:21:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BD74FFBB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:21:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C117CB8251E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 20:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D347C433D6;
        Fri, 18 Nov 2022 20:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668802864;
        bh=BMN/Td5nx9Zdvvo49S6vGEBVIauYq9d/xRYif9tKz1U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sVXjmVS+SOQr3i9Z6T9kU+EdIxiH9MJ+eR0VzD9GzNkax8M61XHIF1BemiJF1v3NS
         z2YvOyR9g4D8KHZ2qhzqLGE76dfkwCDY0BKcnAbN7Gc+YrAy+ZdKYq+0fy4O2wo6ZT
         LtLOoJVBZqAzMKBO7LkVhL36yGTE3f2bXlo8meu93CWzxz8pUvl2eR6EvT6fV/YyN6
         HD9z9WQjfEGrgwdPnIQhLJoONFhbAq2bJB2ZN9/qOYgH1YA9tYZD4kN/43kE9s0x11
         WUFd6EU5EYghvFvApsQ5i7X13TcPR2Bs4O5L//50cTgFLsBpmR9Ke/6CS8zEsN3sCt
         YnMgAJT2J5taQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CF87E270F6;
        Fri, 18 Nov 2022 20:21:04 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <874juwzjgv.wl-tiwai@suse.de>
References: <874juwzjgv.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <874juwzjgv.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.1-rc6
X-PR-Tracked-Commit-Id: 1abfd71ee8f3ed99c5d0df5d9843a360541d6808
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae558268371bb94da6d885430b910abd4d22eeda
Message-Id: <166880286437.9331.481197964157747294.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Nov 2022 20:21:04 +0000
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

The pull request you sent on Fri, 18 Nov 2022 10:43:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae558268371bb94da6d885430b910abd4d22eeda

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
