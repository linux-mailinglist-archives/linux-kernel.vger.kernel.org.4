Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465455FF7EE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 03:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJOBow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 21:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJOBop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 21:44:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EFB62ED
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 18:44:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8019E61C3D
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 01:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA9FFC4347C;
        Sat, 15 Oct 2022 01:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665798281;
        bh=fgzdQIDPiFvTuau5qI9wDAqdA/uq4AEb5GhK7Mkx0rY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MEDxATz/SEAUaZlTwMzj4xsN7WE5I0iGXmiI7hp7pM2nWD//HleMYVd6/964LDuUf
         /dcWcJjB0MV0pgQXYRpOA3L0Oxvl5ySyZjpGdrB/QOHRmiaGsaczeacNWya3oJQA9r
         cuOFORcrUd7gqIqpZqKS1KMmEa82Z0mh+MpTfayPfUXZ6Nwd1iM3U34KeZPAAmuqj4
         C74zFAVeCnInXpiK3bj9M+UbdTcaPtpOLbJotGlVaFd8yvCG/hCyk94YVpeASiQ9Xd
         FYDpn04jTQfB/p2/K9fGVvVVG64GlWhITkKqtbYPGsnuq330nSxnAJFDmL3IEuEZF2
         hAmn1XzLd0NqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8450E4D00A;
        Sat, 15 Oct 2022 01:44:41 +0000 (UTC)
Subject: Re: [GIT PULL] I3C changes for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0nRNcKLvFzqVZeP@mail.local>
References: <Y0nRNcKLvFzqVZeP@mail.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y0nRNcKLvFzqVZeP@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.1
X-PR-Tracked-Commit-Id: 90f4a09a15239f4a819b2e90a7a0b92a75060655
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ce1b97949cbf46e847722461386170e0f709c59
Message-Id: <166579828181.8004.3952722302215133008.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Oct 2022 01:44:41 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Oct 2022 23:14:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ce1b97949cbf46e847722461386170e0f709c59

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
