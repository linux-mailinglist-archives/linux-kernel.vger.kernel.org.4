Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AF56DA03D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240291AbjDFSqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240386AbjDFSqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:46:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6262783F2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 11:46:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE6C864B1D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 18:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56102C433A7;
        Thu,  6 Apr 2023 18:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680806773;
        bh=Vit6a90WPzOnoW3bRCV8NmpSeVX41fQIvTlOJNsUYB0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QjEPf9xjh7SgNqmKli6QEomwSTd6rCl0WeHIxX4oUPUwrI6m9dSKokWi2cRT3LyEg
         F06dboVPQrxdArm/ZaLu855uaQ5HeYcuMIOZVY5o+v/zufXXzWjOdCvKG1jcpXa+7i
         vlR+BYDsc9hxXmXy0cbPrlMDP0JGaeXZT3SMbJKbJzIi5G0jPNpnZ3GK8xS72YSIa1
         vOgU30/64Xgi/d3KDvrwK7oQOEySvjAAxw6R0NoPDvnRadoIRaVwA+NPvKgrEE/lG0
         HSiTBF39VpW6QdyrHFEE1jQhfhmHdOlBBeexiNqdc3NvOKqxbafPNQ5yytLjoLGlf9
         W7I8ggJXaCCag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C3B2E4F153;
        Thu,  6 Apr 2023 18:46:13 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.3-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87pm8htcak.wl-tiwai@suse.de>
References: <87pm8htcak.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87pm8htcak.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.3-rc6
X-PR-Tracked-Commit-Id: f785f5ee968f7045268b8be6b0abc850c4a4277c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a28a8b3659cff2dd2042baacd7cca53badca9d6
Message-Id: <168080677324.24406.18403489268751180202.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Apr 2023 18:46:13 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 06 Apr 2023 14:39:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.3-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a28a8b3659cff2dd2042baacd7cca53badca9d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
