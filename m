Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E421650E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiLSPH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbiLSPGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:06:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BF6EE06
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:06:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3F1B60FE9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 15:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64457C433F0;
        Mon, 19 Dec 2022 15:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671462379;
        bh=4pztdHh+os+uqcUC/XII9avFxmSs9hTbYcRHUa62z6k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gy9pEiLp7X+JX1ELMaldGfdxZe8Yry1/OOMa2jgWgKmUVnLpa8r5zHtCvMJAqQ1Rm
         3DuKYgcBNvxnjawY5qR8sgu0I0zEknoQE8dS4CaBdaz5NOJMTiIKt4CiUcj60MvxGm
         VHxIXuemsMHwHwOYKMkjilK1gKEQNWfxtvYQE14BQbGE6i24saV+lSwfMLGfaoOz0D
         iKwP95aoYKoMPML1rfxV1v0SFdNylf5AY0mcLhjR+/9UXiF5I9UWVqPH4H5nUX3+VK
         Vm9P7F/pXtlLtk0wUI924SW0wwzc7LA0lGFvf69jjM28EbpSsU5iGO3raQws6zznVH
         Ysvjz/MqbWF6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 484AFC00445;
        Mon, 19 Dec 2022 15:06:19 +0000 (UTC)
Subject: Re: [GIT PULL]: Soundwire updates for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y58fOznGkV+MjdQR@matsya>
References: <Y58fOznGkV+MjdQR@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y58fOznGkV+MjdQR@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.2-rc1
X-PR-Tracked-Commit-Id: 7cbf00bd4142cd88ac7ecbc4ea7b917a220cb721
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b6a349a40b9dc5fc510c856080e468e3782e5a9
Message-Id: <167146237929.24644.1554135529937130755.pr-tracker-bot@kernel.org>
Date:   Mon, 19 Dec 2022 15:06:19 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 18 Dec 2022 19:40:03 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b6a349a40b9dc5fc510c856080e468e3782e5a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
