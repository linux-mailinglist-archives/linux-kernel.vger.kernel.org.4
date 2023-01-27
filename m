Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5D367F034
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjA0VOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjA0VOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:14:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF9888CF6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:14:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA72D61DBC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 21:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 114C5C433D2;
        Fri, 27 Jan 2023 21:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674854082;
        bh=wFeusC3IMb2Wll7gAFnHcO5tVCIs0rWlA4H5hZ666yw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=s2ttlgLtGPjcDYijtdGPtIrx+0aQcPxgp3nEbxgUd2OzZuAenhInk/YJy+NY5qIE7
         Ju87wT072mAaRia52RZtwXIYTPNLslzzqjViaPArgUu/p8rcJvJtVKRXwn7Jhtqt+F
         lotahkEQn7V0+rfoE+Jj7quWetubHr44xP0p7EGKSI5YY7WpFR6mwU6gySIhQlCbLD
         ReKH9JQh3mh3WZn51nlQtaYYQlTDdS9vzEhWuefhp3rZulwYPTGfJQCPMXmKHBPHb6
         rrLPdVD7AkQOYLgaqQ1O3SN/9PXcqZjRu6iqe9p+5FqQqYDlbIkdJBKxXHxD5de0n6
         Jbay6a2OpcULg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F30BBC39564;
        Fri, 27 Jan 2023 21:14:41 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fix for -rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230127174044.GA31044@willie-the-truck>
References: <20230127174044.GA31044@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20230127174044.GA31044@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: a428eb4b99ab80454f06ad256b25e930fe8a4954
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d1e013fd9246fcf73a078999487ba47d1dd1bb9
Message-Id: <167485408199.14056.12030326463121484986.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Jan 2023 21:14:41 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Jan 2023 17:40:45 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d1e013fd9246fcf73a078999487ba47d1dd1bb9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
