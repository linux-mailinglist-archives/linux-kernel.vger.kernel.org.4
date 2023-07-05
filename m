Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5E4748F9F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjGEVUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjGEVUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:20:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2613D19AB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 14:20:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B37AF61765
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 21:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C24BC433C8;
        Wed,  5 Jul 2023 21:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688592049;
        bh=KSgiO/w/Gi5NXxonRZeCrybTrwdp5GTmPjCEaLZp9uw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dM3sLTv5xiLxTWcS8VUHfw0GBXWGMhuZwtbHZPF0LNejko01hMWu8XEso0/Sjl1BL
         N39Hi6D6kwI+pD1ooVa6yBYqHAI7+UbAEZ1aPH5X6rqsxc0i/ZkUKviolAAKy4VoFH
         hPmZxY/dFyCyX/cJWHr8qjRoAqlt/EhhMKCSDYy+5U6Hddjs06TtqYKrf5u+Gekjfc
         0Sb9cyCgz74gBQjVpxK2++VP1O0jNG8flksONK9z6h/x42Oga56dBiyp/QxwAH/Efj
         USCyYQMJGSY7JW5AhvjvkVAHdeDOvlo6RPHFj6WRLkTDPVKFJXi0ojFIYhDUheJCLU
         ZFfHeimlMmbiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0247AC395C5;
        Wed,  5 Jul 2023 21:20:49 +0000 (UTC)
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZKWuP6+mGdW/W0/P@google.com>
References: <ZKWuP6+mGdW/W0/P@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <ZKWuP6+mGdW/W0/P@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.5-rc1
X-PR-Tracked-Commit-Id: a6ec83786ab9f13f25fb18166dee908845713a95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 73a3fcdaa73200e38e38f7e8a32c9b901c5b95b5
Message-Id: <168859204900.795.16142238222271277169.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Jul 2023 21:20:49 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Jul 2023 10:54:07 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/73a3fcdaa73200e38e38f7e8a32c9b901c5b95b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
