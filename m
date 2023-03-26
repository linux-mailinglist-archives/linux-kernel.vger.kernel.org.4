Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342D56C96C5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjCZQVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjCZQVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:21:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BCD46AA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:21:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B736460F21
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 16:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14256C4339C;
        Sun, 26 Mar 2023 16:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679847667;
        bh=TRMDNNVamVKy6VlUNohbWf/eShW1TQ0GfYsKfj+qpcA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=M8eGVqaBIv7w+HIfqg9iRMFRNWpsF3IZ8ZTYkR4VT35Ji/JrOkbW3/O+4vea71F+b
         WzxiJCjc+JMC8+lzGcwvMTHsGRv6RECpovsRg/dDKfNQgw6DOdQYi0KZYKx7GLJRYO
         mAUxWrp97p/sI6idGrgRJi+UfOCJf9XzuXT7qXpRTzTIOnAq81KbqwSjxWyJh4b/xf
         dB7hvvcLGPZyJDhycG7xBMlRG3alWrRRmb3DcTpAooYRRab5TcrPdtF3mjisn0j79m
         oHKUZK6oEwcSRPcQ4AnRSvUuV0NmvxAkdREXbkPoRuIYm3hGkAl4IZ/2SJbeQP0Qwe
         9f63wYpLYZxCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 011B1C41671;
        Sun, 26 Mar 2023 16:21:07 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v6.3-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230326125508.GCZCBArK0pT7CwrpRt@fat_crate.local>
References: <20230326125508.GCZCBArK0pT7CwrpRt@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230326125508.GCZCBArK0pT7CwrpRt@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.3_rc4
X-PR-Tracked-Commit-Id: 263f5ecaf7080513efc248ec739b6d9e00f4129f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 974fc94336df81137b3b3502e73f89282a743607
Message-Id: <167984766700.13454.11108109895247797806.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Mar 2023 16:21:07 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Mar 2023 14:55:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.3_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/974fc94336df81137b3b3502e73f89282a743607

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
