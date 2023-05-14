Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3F5701E53
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 18:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbjENQ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 12:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjENQ71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 12:59:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6D23A8F;
        Sun, 14 May 2023 09:59:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32D4A60DC6;
        Sun, 14 May 2023 16:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A0D4C433D2;
        Sun, 14 May 2023 16:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684083565;
        bh=o+o2ClpY6lDZv9UOgTOZM+Vqat/l1MuYxZ/3SHhvJy0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Jrll3cDcruekSPv0ssIh2N99xCkZdvpH7+b1Cp2tcWgYkPWKyyl6Mqh+vrITtsXRp
         wy82arsLjOrCxseQbwYyIEEenDLOa2ww1l8kLtmQg1AiVXjQWKqPVOnJOYCFa1Xgsx
         y5s/UcKWbWu/b6hXkq81iJFWj8cei1q0UluFLGpfBXGSw9cKGHj/24XHAX/F5SE7PZ
         BaXHw/WQ6VL/YAe5sTJS0Z0FK+ZG8xAWVSDqErP22t0JvJq3tkw1UwYoUAC+iNFfyq
         S+J/r1cUnQzxxydtwnyvjwfTgXlMI6x8XJMI2vDr0VdEDJ+NoqMYZx570lMx5IbpFk
         mjc7+WyySYfpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86004E270C2;
        Sun, 14 May 2023 16:59:25 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for v6.4-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZGERqF1P4VlazwPG@p100>
References: <ZGERqF1P4VlazwPG@p100>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZGERqF1P4VlazwPG@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.4-2
X-PR-Tracked-Commit-Id: 6f9e98849edaa8aefc4030ff3500e41556e83ff7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 838a854820eea0d21c6910cc3ab23b78d16aa1dd
Message-Id: <168408356554.3047.9975939137270688423.pr-tracker-bot@kernel.org>
Date:   Sun, 14 May 2023 16:59:25 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 May 2023 18:51:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/838a854820eea0d21c6910cc3ab23b78d16aa1dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
