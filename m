Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F51D638FA3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 19:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiKYSWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 13:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiKYSWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 13:22:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F65611177
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 10:22:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94222B82BDD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 18:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59B51C43470;
        Fri, 25 Nov 2022 18:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669400562;
        bh=R/wCbvqr9gxtFosZM/gnPJvoKfaUmwwKTLR0YyarEmA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NIWJVWeKvksRGZ1yCnSHYK6PekNXdaCLnH+ibg7gkVfP+tNVkSAQe0EheqxQb317X
         q69tPJR78bdm7DNzqSDvlLpPug47ULH/AMu7TY1lXnk9X+Oz1OhSHAxxg9SGEfcO3H
         yy53HeIAK869U1auzVrQEdatfPYAZSIM1vwMPF88eMoMLzl4XDDrN+26A2FjUxFB3C
         6CcoogWfR0pT004sSbzW2O7M/pNxP3Xb7/K4I96iwIWSwvA3yAIHnzz8pgOc57/kCu
         VZSOmL4eOw4Deg7uiq6WBToVSCvSDGYS3RWKgNRhBZosM/fJZPyE5oOI0RqWPYS+Wm
         nKpfLzIDktF/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 499BCE270C7;
        Fri, 25 Nov 2022 18:22:42 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.1-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <878rjz2wg9.wl-tiwai@suse.de>
References: <878rjz2wg9.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <878rjz2wg9.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.1-rc7
X-PR-Tracked-Commit-Id: ecae4c8954a1faba6fcc4fe6ec1680b3c4e393d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca66e58001ad9418e937ceb56bce8b1fe183c62e
Message-Id: <166940056229.17840.14744397744946691792.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Nov 2022 18:22:42 +0000
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

The pull request you sent on Fri, 25 Nov 2022 10:51:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.1-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca66e58001ad9418e937ceb56bce8b1fe183c62e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
