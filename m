Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17C864AA97
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbiLLWrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbiLLWqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:46:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5D7F1D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:46:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C31F61237
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2474C433F1;
        Mon, 12 Dec 2022 22:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670885189;
        bh=Ye+2RENKwkgg7hE1GLnXVwfvO72YNeI+zavuEWpQhIc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=f17KBMZbgDp/FhrIxWuGyADHlysrkX9/NqdQfmnjdBMsVsOgIa3auIqnn53ybP8jq
         0xwSQn+m6jVhcsDIb5iczGgmO3sQ7SVuEM/+UHxv4vnpWZsZE95nftkzlcTEt9ej+Q
         ZDNSg8gQE5tclb+n4aVK8KkcAWvBENzG2XxySy+wt+bUNk8HhoN6fk3XjIGDXVYzrF
         kSldysmU0XuhZvQCCXuBqvGUhNA3s2mU8tIdnT9sCuqsIiU6+JTcQX8FmsGMTAmXpI
         oHvTyvDUj48ilIl2wTSeA8NNYHjr3KFlfj07nGtsbkkmam7rtzOqLIcYytyGehiGml
         MBWe4mr8Ia0lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1791C00445;
        Mon, 12 Dec 2022 22:46:28 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sgx for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221212191525.553277-1-dave.hansen@linux.intel.com>
References: <20221212191525.553277-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221212191525.553277-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_6.2
X-PR-Tracked-Commit-Id: 89e927bbcd45d507e5612ef72fda04182e544a38
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2da68a77b940722b04c2f7604a758eab46cf6cf9
Message-Id: <167088518891.6748.16079201903180604207.pr-tracker-bot@kernel.org>
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

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2da68a77b940722b04c2f7604a758eab46cf6cf9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
