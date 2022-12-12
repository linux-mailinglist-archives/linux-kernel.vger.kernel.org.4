Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA6C64ABB4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiLLXpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbiLLXpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:45:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78151CB01
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:45:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5502561281
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 23:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDB57C433D2;
        Mon, 12 Dec 2022 23:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670888733;
        bh=AQI0pwcojAWt/OOsw/YxaQIYeU6I4j7vbst5RFAnvik=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JAGHv9i2HCSyQMttRAZ1lBngwshpZ0PimG7Me5R7KAY4g9afyDBcC6l2xhMYeWKIN
         LXM4pzCSr/QU7k+pRsz51rAIMf4PWtEy5qeqZIkktmucRrnFrJ0zTWt4YH9ulZUBZe
         cIM6yHabz6Bukqdm7iJqVF8jjDwIAp+jF6IrwM7FQkI5dqkzjarl+M8o8aM6yCPbBp
         nhym0WrWQo2enoopLoLSM852Dhu7KxE8QlbjNj3lI4Gbu/wqqnaW7rLpP5F3mo5jTm
         WXUE6u9DnR2dE5ARK6dhD8c1MZX4tmnOywzhraia+dW2tgloYLpPSS4aE6L78mTkrN
         naQYZ7kshtVRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABF5CC00445;
        Mon, 12 Dec 2022 23:45:33 +0000 (UTC)
Subject: Re: [GIT PULL] x86/alternatives for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5eLSzV52mf/NySl@zn.tnic>
References: <Y5eLSzV52mf/NySl@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5eLSzV52mf/NySl@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_alternatives_for_v6.2
X-PR-Tracked-Commit-Id: be84d8ed3f04e9154a3a55e29a27dcd416f05b31
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f60f830842d6c6960a0c038695f7bb4f0ef896d
Message-Id: <167088873370.9522.13792067317054234639.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 23:45:33 +0000
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

The pull request you sent on Mon, 12 Dec 2022 21:12:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_alternatives_for_v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f60f830842d6c6960a0c038695f7bb4f0ef896d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
