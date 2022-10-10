Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6815FA488
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJJUFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiJJUFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:05:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4EE54655
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:05:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB439B80EE4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FC6FC43142;
        Mon, 10 Oct 2022 20:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665432313;
        bh=Lp/68+armZXu3I41VHI0I6UelndnK1aRlDcA374dmcQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LZOqRUf0EIGW35FSYWU5vnhqQQHAR0tlFh1nS3+iw1JYNxHpvFHycJc+rlfB3Ywbs
         kFNI5HU2/PwkWGiwsB+6x1ntq+289nIaywXCrxGy3i9e44wPUvvAhV5gS7xiIpPsVz
         N0aj/tqdggEi8gQXJ9DuE/J+0frmpJF9NdN7mTUDqvm9vo3ihtBAETFObVliX7RLPt
         G3E4vPmwvZJGpOp13IAFYwxQ2iIVT4YMTz2SpeDn6vYulP00dGORdkL7/oGDvHfboP
         jL0g49OQ2SFJfkZZHnqq4ohnzajuyDHLyYqg1rW+f7mD5wXEouiTR5THZB67m9BWQv
         iA3qH9dF//yag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8019EE2A05F;
        Mon, 10 Oct 2022 20:05:13 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl changes for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yz9wYMDqTBeHi66p@bombadil.infradead.org>
References: <Yz9wYMDqTBeHi66p@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yz9wYMDqTBeHi66p@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.1-rc1
X-PR-Tracked-Commit-Id: c06a17fe056b84f5784b2f13753870eb65edc9ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc55342867c9cf2295f4330420461361a9c8117d
Message-Id: <166543231352.6988.1728631836611611770.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 20:05:13 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        liushixin2@huawei.com, chuanjian@nfschina.com,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Oct 2022 17:18:40 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc55342867c9cf2295f4330420461361a9c8117d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
