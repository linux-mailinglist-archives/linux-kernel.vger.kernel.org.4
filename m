Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799D569D4F2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjBTUYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjBTUYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:24:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF3C22796
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:23:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50EA460F4F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 20:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22679C433AC;
        Mon, 20 Feb 2023 20:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676924406;
        bh=oibygxzQyT/KnJMIJDx0nX+0Z8B7xfkzHi3tnGdatLM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dV2f1oUdZiBKi9gzMPApX3/Q7ki8mj4FCg+Ed1bstd7exgJwjlPaEOb6EFDsABZLl
         02Knjw3Vj75Pbki1QyZdwvRELzh56stN41e/z9e3GW1rQL8n4FkOM6JoaCa/8+dJV7
         lfKpiOyD5Y/rLZNP3Wd0RpiEiw72fTNe8qMO+SADoTUCTlJTIL5MFSVsM+59lzIvHi
         ZW6cYQm+UP3P8asg50e+ZJ9dRGgDk+I9NiJz9mS3UqaI/xa45uEsr+uqplIuQT9K+0
         8kHjUvKYTvr6G6d801sDXkg5jedOcQeygdR2Gnqs71FeAiKDt4uLY5AzXv7+ZDiNzI
         tHAbRj+Iu7fng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0FB72E68D20;
        Mon, 20 Feb 2023 20:20:06 +0000 (UTC)
Subject: Re: [GIT PULL] Remove get_kernel_pages() for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/KIBDu3BiHdIsX7@rayden>
References: <Y/KIBDu3BiHdIsX7@rayden>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/KIBDu3BiHdIsX7@rayden>
X-PR-Tracked-Remote: https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/remove-get_kernel_pages-for-6.3
X-PR-Tracked-Commit-Id: 816477edfba6e7ab9411acec5f07cfa00e0882f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d644c670ef24189a93945528720ed545d77dc514
Message-Id: <167692440605.19824.6360259117626334805.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Feb 2023 20:20:06 +0000
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Feb 2023 21:35:16 +0100:

> https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/remove-get_kernel_pages-for-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d644c670ef24189a93945528720ed545d77dc514

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
