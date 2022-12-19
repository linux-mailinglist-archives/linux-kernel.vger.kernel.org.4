Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377AF650D4A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbiLSOap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiLSOaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:30:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEA3FAC6;
        Mon, 19 Dec 2022 06:30:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81CBFB80E4F;
        Mon, 19 Dec 2022 14:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34D60C43398;
        Mon, 19 Dec 2022 14:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671460209;
        bh=ohgq6I+/5xcMmDdvidd9xalWzvo3j9hur3zDJB7W3jA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Kp/TrarIPzLX2oDW8cmikyMPy1zp5P0gVm9w5dWKDPozv/Ox0gwTOVXoCuUNCENXG
         MUauoy75dnSIeWqTsFYwctlhJ2XVtzUmo7mUCM+U0nP+toDxeGFtVaoI29Te3AwN7f
         q1mfvTcUU254LcCMziD8MbW7+8M/0QrapQx8epaTW5tYfydJIsIMDVOlfJKRKicMyY
         NG0J9ylgjvALxsUxBSooK9frUYJLy+JJ7zRQNEWkmRk1Y9/s8fXpRQh/IcCr/AgUbO
         S60e/0FMSx9Fmkv9YlHrm84D1PosTK17j+ragFIjXaycFBbPRb3uhzduS4XPHAjOV8
         g4T/9jbUA6GOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1BDB0E451B6;
        Mon, 19 Dec 2022 14:30:09 +0000 (UTC)
Subject: Re: [GIT PULL] Final MM updates for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221217203048.c502a0c0ba87b5be1bfb7824@linux-foundation.org>
References: <20221217203048.c502a0c0ba87b5be1bfb7824@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221217203048.c502a0c0ba87b5be1bfb7824@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2022-12-17-2
X-PR-Tracked-Commit-Id: 8b777594d2341a82f00b57c020f8af05bded1178
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ea9d333ba475041efe43d9d9bc32e64aea2ea2b
Message-Id: <167146020910.28969.17820111559319314.pr-tracker-bot@kernel.org>
Date:   Mon, 19 Dec 2022 14:30:09 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mm-commits@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 17 Dec 2022 20:30:48 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2022-12-17-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ea9d333ba475041efe43d9d9bc32e64aea2ea2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
