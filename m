Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D5A6D39AC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 20:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjDBSCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 14:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjDBSCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 14:02:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6E2CDC4
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 11:02:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 157C361003
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 18:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B0E2C433D2;
        Sun,  2 Apr 2023 18:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680458528;
        bh=wAg3w4X/WDS9TfqXZTgyvqDJaBlzM+2w5prgTB5zz7o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hMCqAznjkfI9TRfbqeTAI5zXHVRU0icpsauy5k3MvogkX228X+fqzwXb2769iz4zY
         vvt31R5jVpEvh0aKhv6XZhINlhaet/4n7uy0E4v0QUBnKamJpPW9jxYd/RtSgMQ+2f
         2c66PSd22D2AcZ2aM1LqPdCZ0dW97nKS0k7YwmUVt71X79AnnufH+wu5cmw03Kcf9l
         W8LNjoekkdkxyd1inaAWQ4tqKKWo5s+/xArd7P2QqwK/OXq7pdLC0Exbw6T4TdTNI6
         cbm+SoV3YykVAiV6xOVOIhEyIJ6JzOdyAiOpRDgr2RPQSdcgXiB+Y9ijeWe/jfeAuI
         IeCWDff9kuQ4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 692B1C73FE2;
        Sun,  2 Apr 2023 18:02:08 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fixes for 6.3-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZCmWJ_E1FKCf3aEW@kroah.com>
References: <ZCmWJ_E1FKCf3aEW@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZCmWJ_E1FKCf3aEW@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.3-rc5
X-PR-Tracked-Commit-Id: 5c2712387d4850e0b64121d5fd3e6c4e84ea3266
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a10ca0950afe36fa5a20e8fc3e843beef8808fc1
Message-Id: <168045852842.9845.5294957815778865862.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Apr 2023 18:02:08 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 2 Apr 2023 16:50:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a10ca0950afe36fa5a20e8fc3e843beef8808fc1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
