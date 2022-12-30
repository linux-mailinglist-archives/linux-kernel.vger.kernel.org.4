Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53800659B87
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiL3SvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbiL3SvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:51:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98934D6A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 10:51:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 351FF61B83
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 18:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98EB8C433D2;
        Fri, 30 Dec 2022 18:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672426261;
        bh=IGB1sUXmHttcEFY/InKGulnv3QEmD5zWGTRr1TvpGTc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tNpD1DpD02Y+nK0qv6pr/chk8zSOMOt10jWUd/Jr7YPtdUGMwQI653pbkJMx9caGB
         hFphNw6njl/GkM9RneA3ru9jhVGWyeO/gUajYoSZtdwLfnGJ5MFX7kP8UO6GpoZL7g
         pf57iyToQdbQl6COKOljHZNV2N3uDCmUNRnundVXfOkZZg1idtW6+CP4GMWUijEZVx
         4jNq6e/bzAdpWhkAqTeDWu3MafxQtckAnu3U+ZikWnSe3xrAXLLNtfPV20onFnRNsI
         O/38m+1osGhSY7N+ZKBIwoB9BXdkJO8MKA8QcPtyFojbruNwmL2QRoO8QQ3SgTyVA6
         TLaXEjFHWvfgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87AE9C43141;
        Fri, 30 Dec 2022 18:51:01 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 6.2-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <877cy9x8l8.wl-tiwai@suse.de>
References: <877cy9x8l8.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <877cy9x8l8.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.2-rc2
X-PR-Tracked-Commit-Id: 090ddad4c7a9fefd647c762093a555870a19c8b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 262eef26e350181f8067072571f4918cad3c5e87
Message-Id: <167242626155.31406.4515460550003020319.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Dec 2022 18:51:01 +0000
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

The pull request you sent on Fri, 30 Dec 2022 15:35:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.2-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/262eef26e350181f8067072571f4918cad3c5e87

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
