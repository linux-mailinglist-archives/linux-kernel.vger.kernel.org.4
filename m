Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6BD61E563
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 19:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiKFSuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 13:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiKFStr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 13:49:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FC8FCDD
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 10:49:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3D0CB80CCA
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 18:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DF6DC433D7;
        Sun,  6 Nov 2022 18:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667760584;
        bh=MfPHo+0mPM8JcO0sg8ivk7lLZLBFpDVM1b+O/kblazs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ohp/yTocx7u1uzQa0yyMrpBNC1FK7RCjeYuQmjnbILPxo9+1LRnC1r3EvqbcidyGs
         3S7tjxBg+tEt/ei8bpFgA3OHEFemc+Imu5GoP2R7Cj7Ey8MMM6vNSITSLVnl7xDw1h
         NUZEfTy/iNQP+e/vvMACL7DOkiZUSZpAWJSI5YazkS6VVyab7sjrF3vqBrrT5p7sc8
         T4u4txOqg4VhuSm+Hzz/q4W7yIz1PhLft+81HpeyRhKRsrIhcRxTZUDUY9qIWCvE/x
         3RnFJ0h+2dza19lTZJrjr/ie3mn/qRvfPeWdJJTp2Sovn3b0lf2JT4qYkCX8aZrwrV
         tCqQXhqJAe4bQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C5F3E270DD;
        Sun,  6 Nov 2022 18:49:44 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.1-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221106055958.14139-1-jgross@suse.com>
References: <20221106055958.14139-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221106055958.14139-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.1-rc4-tag
X-PR-Tracked-Commit-Id: 4bff677b30156435afa2cc4c3601b542b4ddd439
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e8c78d32b5c60737bcd71346130f0bf91d6e066
Message-Id: <166776058430.6751.15098264634464095841.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Nov 2022 18:49:44 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  6 Nov 2022 06:59:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.1-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e8c78d32b5c60737bcd71346130f0bf91d6e066

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
