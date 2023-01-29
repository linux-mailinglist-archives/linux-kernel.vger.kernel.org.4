Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E29680130
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 20:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbjA2Te6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 14:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbjA2Tex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 14:34:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A811ABE0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 11:34:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00DCBB80D86
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 19:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93DD8C4339C;
        Sun, 29 Jan 2023 19:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675020890;
        bh=BNzjmljcB1+9O5Ti/ZQyQYVX1He1jbcndUoI7YJ3Xnk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y554GTluef4pyQT7KA2+i7H0Rn35MMeGDQptlJfHQpBqcSZzeP4bAw+drVIjRSjtq
         hdP0GTRV4vKeZ1nWnH+fCDS0UCRuNG+QTySW+6pBOSdFhOPqYd0T4l0HtQhY09y5D1
         8c/Ykl0EI4eZq009KN+6Y6KawpqoaFY8g+9kWRRe7vEpFIzKGkKfz3d0577365EYe0
         Uyp3B0R5JTXkrAx4IPUKvqPV3ylB3QQKXrTaZ76XFr0qv2Okm5+FVs7yMcBy2wn+vE
         fdG9uuccc2ranKlXMLRJGEPygLnX5W6bNOrjXXmZjBIeJG1+honpHaKabu1khqjkT9
         NCXasa4VBByqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7CA56F83ED2;
        Sun, 29 Jan 2023 19:34:50 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v6.2-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y9Z4QtDi7sdMlnnD@zn.tnic>
References: <Y9Z4QtDi7sdMlnnD@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y9Z4QtDi7sdMlnnD@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.2_rc6
X-PR-Tracked-Commit-Id: ac8f29aef2f1695956ff6773b33f975290437f29
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab072681eabe1ce0a9a32d4baa1a27a2d046bc4a
Message-Id: <167502089050.8980.10647135426893219778.pr-tracker-bot@kernel.org>
Date:   Sun, 29 Jan 2023 19:34:50 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Jan 2023 14:44:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.2_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab072681eabe1ce0a9a32d4baa1a27a2d046bc4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
