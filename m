Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58045680131
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 20:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbjA2TfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 14:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbjA2Tex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 14:34:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5F913DCE
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 11:34:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E71E3B80D87
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 19:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8376EC4339B;
        Sun, 29 Jan 2023 19:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675020890;
        bh=4ymDmYS8OVbN7PsiSJmaO/NXfHrenCAaTsnXvkR/9QI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qudXjCwGrOseaJxzxr9KAXr0WJ8XP/wpS6C/n4zOLJN6z5qw32VBqwJ9++ib/HJ9s
         XS0X41x9wEMPYthRTqHsxwWyWXwFtVLfe59BgS5D4RzZ3UHa+ygvHWfz5K37epCEbD
         zTL65oiqIiKCMw9bOmzM0rCe4HKtzW7CRHdCZPsVduplxev6V2ucbx0EkjDTV+tZf6
         It+0gYvMu5S0mhBRr0WkhKSSJ+8H5LFTnNr0/TiNUUH0iCULeLQRCVHwg1iev4NHNy
         vZ+G2cIOtq7dOoT8Ao5jTCkITrc7vuPd1g1rS9/OQyJTbWC/2/luGzGI43zLaNpXdH
         kNbguIuNM+Mtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F429E54D28;
        Sun, 29 Jan 2023 19:34:50 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.2-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y9Z3FMceYzCQ1IXA@zn.tnic>
References: <Y9Z3FMceYzCQ1IXA@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y9Z3FMceYzCQ1IXA@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.2_rc6
X-PR-Tracked-Commit-Id: 27b5de622ea3fe0ad5a31a0ebd9f7a0a276932d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc6bc34b1095b64840308fa0fc325c028bd9b89a
Message-Id: <167502089045.8980.10773911567522623374.pr-tracker-bot@kernel.org>
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

The pull request you sent on Sun, 29 Jan 2023 14:39:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.2_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc6bc34b1095b64840308fa0fc325c028bd9b89a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
