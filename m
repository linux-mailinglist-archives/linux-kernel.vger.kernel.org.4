Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD81164762C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 20:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiLHT0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 14:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiLHT0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 14:26:32 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B53A750B8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 11:26:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 70777CE26B8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 19:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB810C433EF;
        Thu,  8 Dec 2022 19:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670527588;
        bh=DdZqUnqbu/vwGb7Q89S/0orBvB9DweNPs8iPyoZSYzA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bFEoU8+hzNKtWtufjeEzKkbGYibH8waAj6FC4bFsxUiiIPouv8ArOR3vg98vYeAQS
         J7u9W1g5kR3copMZpz+60oRQjoEIzxpQ5ClAtdEM/6Nfpe5vSqNHq0eTYAbQPoOhF/
         5islXYGNABKcjoVpxybPKgqbPavMpa1A1oLGIKrnI98WKdZSubz3pThNYpifZ50qzN
         Z5YZlVuFNfif4Ufkp/CW7RRiy3a5UzDGwO6DoNF/dNLh7/Znt7UrqsY/wV8YxK9Vdq
         aCY3tdUi2aElcGTgsfDNloIJ+c2u5kMyH72Tn7N5pJu7cpmKlsPnUoO1KrJ0RMpaC6
         YupcxslPwxueg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 902E5C433D7;
        Thu,  8 Dec 2022 19:26:28 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.1-rc9b
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221208062404.29189-1-jgross@suse.com>
References: <20221208062404.29189-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20221208062404.29189-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-xsa-6.1-rc9b-tag
X-PR-Tracked-Commit-Id: 7dfa764e0223a324366a2a1fc056d4d9d4e95491
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4c3a07e5b9ffb525435fedd94b5082c928e56dd
Message-Id: <167052758858.15249.5126504911011614864.pr-tracker-bot@kernel.org>
Date:   Thu, 08 Dec 2022 19:26:28 +0000
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

The pull request you sent on Thu,  8 Dec 2022 07:24:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-xsa-6.1-rc9b-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4c3a07e5b9ffb525435fedd94b5082c928e56dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
