Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC9D64AA99
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbiLLWrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiLLWqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:46:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E679FF0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:46:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FE06B80E7A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFE09C433D2;
        Mon, 12 Dec 2022 22:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670885188;
        bh=oXJVo3B2sikli3oDZrI84bQmynC9lyXfPYM7wuF2kfY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HrYYXVCiAA87u/UlzuUO0RDRWJ+ADB78KgObsIc6FYGRIDqUVldN6pPMFDEg9xYGU
         nh9mmrVvaw2XvQvfZZ9rQyBLGy10C+MmShNkm/a0AKLcCvNcNGMDMq3vEAQcLDccxq
         j0DT4ay99rQZXOig8c+ZadYJV58nKf9CBwObialYD7zpRVwdc4MhMyPu1E4MZ542v0
         zmKjDDoJWe4F6TbB5v8NU7GBUzkwLwoveiyfc+AUOWwz/kCjnwA6qMXkAtw8wCZw4U
         kMNMlylQHjmdjzrkDYb23Vtix+4IGH2FgsEBkL1F76YK6OHu2WzpJvfjrxVq4ylVMT
         ygRr9JrBQNn7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1BE5C00448;
        Mon, 12 Dec 2022 22:46:28 +0000 (UTC)
Subject: Re: [GIT PULL] x86/tdx for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221212191525.553266-1-dave.hansen@linux.intel.com>
References: <20221212191525.553266-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221212191525.553266-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_6.2
X-PR-Tracked-Commit-Id: 00e07cfbdf0b232f7553f0175f8f4e8d792f7e90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a89ef2aa552db985e0ee8cb458846298c007704c
Message-Id: <167088518865.6748.13846338653479098778.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 22:46:28 +0000
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

The pull request you sent on Mon, 12 Dec 2022 11:15:25 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a89ef2aa552db985e0ee8cb458846298c007704c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
