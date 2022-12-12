Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECAA64AA95
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbiLLWqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbiLLWqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:46:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BE610F0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:46:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E83B561257
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59709C43392;
        Mon, 12 Dec 2022 22:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670885189;
        bh=v4+mLi5Eu4CKnzC72rEvZRJCIcOIM7NvYMggB3juDZg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gzZjVy7nS5u1VWixDRl8uO3LtJlc0txlykjmpExYia9gdAaxl+oT5t9T/WcHWc6eZ
         fiLKuqdk+9R4ipif2KJchKrs/aS7T4A5xHCuiJT3b0EsoYXYoiSs/Vt31DfLQkMMu0
         MDWpFYef12qIGIHnjT7NGpzVdR0WSkmjGozZV8hU7qD8MJvSFGh30X22r1xDFn4MoL
         xjLV+m4HWEhKhCQrGuS92Y69Z/hh0Lx4tQpojs3YCCTedoburBi5FozlnF0XCp3dIW
         tXKzxIhaMbgfUU/ZVB9NkbktHxRdH7qlxHmKDKLWC7iU9Undl+95OjMjaoB10jVkQ9
         PDiupa2Oub/wA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E609C00448;
        Mon, 12 Dec 2022 22:46:29 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cache for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221212191523.553233-1-dave.hansen@linux.intel.com>
References: <20221212191523.553233-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221212191523.553233-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_6.2
X-PR-Tracked-Commit-Id: 97fa21f65c3eb5bbab9b4734bed37fd624cddd86
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 287f037db5b46de5a86e4bdfbf02e0206ca877bf
Message-Id: <167088518924.6748.13026392646317500217.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 22:46:29 +0000
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 11:15:23 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/287f037db5b46de5a86e4bdfbf02e0206ca877bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
