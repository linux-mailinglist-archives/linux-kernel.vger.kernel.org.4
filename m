Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8FE69E5E8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbjBURZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbjBURYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:24:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8C4D538
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:24:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9743C61169
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01A34C433EF;
        Tue, 21 Feb 2023 17:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677000284;
        bh=8Nw1k+hLzUDrKQM900t3gIKvPRLE5/XG4USlsyCwaCM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OTbTGKZf0+F4Y4fS05ql86eaCGxAJLnIVuIVHxZJjxMHv0Xmn/vh/jotA9hJBjrxZ
         N2js7AMY15XHYvVHdxBt2S64fliKJegTXmM94erDG/VE6Yc2GXeO0ECrJH33YJH1Jx
         /uHbA/hqK+D7hjEsWLdTucOicwyOi8PbQLx13vyXX6/r2GCsm9GhyWOuU7kMBPU+pW
         ZGih+mirRJnXKuWzUBY2k8rUl2ehPJ6aVJmHScc9AbuL9djjWRznLbFUFExJU6IhvB
         ppUwOrVlZhYzTO4jtDhEZNXp7Caz6AhnvwJ92aSmRNq812v7DFgYNKLPfQKHVVaQjq
         RNeuCUrSO/d8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3B37C43158;
        Tue, 21 Feb 2023 17:24:43 +0000 (UTC)
Subject: Re: [GIT PULL] x86/alternatives for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/OQgYnbYg0OzUMX@zn.tnic>
References: <Y/OQgYnbYg0OzUMX@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/OQgYnbYg0OzUMX@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_alternatives_for_v6.3_rc1
X-PR-Tracked-Commit-Id: 923510c88d2b7d947c4217835fd9ca6bd65cc56c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1adce1b9440cdf0c427419b99bc9db756b5ad931
Message-Id: <167700028392.32027.14678013710529147683.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 17:24:43 +0000
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

The pull request you sent on Mon, 20 Feb 2023 16:23:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_alternatives_for_v6.3_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1adce1b9440cdf0c427419b99bc9db756b5ad931

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
