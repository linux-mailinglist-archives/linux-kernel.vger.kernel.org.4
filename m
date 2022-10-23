Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4901A609510
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 19:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiJWRSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 13:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiJWRSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 13:18:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CB55DF37
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 10:18:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 962F060F16
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 17:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08927C433D7;
        Sun, 23 Oct 2022 17:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666545525;
        bh=PH569NcgjYi9GnBvRa7zm637z4o6YxZIhmUi3+aDeFw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p98Ubc+LeMb6cD8QyXbYg5y/VxmB/kiZN41Iog2PXaGOiSztXEKjhqUkNjUsPiT7o
         mVaBTnKQWd6ecHA4N6kslFFvExTGBcrPsBN4p5sxH5GjB9itHs4Hs2tLuli40AEirg
         lwpvSvhiefupAIkVxn5yqF75Nf5U5zv4lEYjfqTNLpE/AIEL9rrp0pcGXSTJpc+wcL
         0+0UNlx7w/tApcUNSr1bsVLQRGGsaAg9zVVz0W42a/TWIFeAhYYfmCak/vphXU+7F0
         z4InEG28i9clKy255wE7ft4DJBu+eY+fnzoUaXjZ+AkpQI0FlC7RREwakzIBrXGPNm
         AYmetcLM97y2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC8DDC4166D;
        Sun, 23 Oct 2022 17:18:44 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y1ULKYsASLRoVb7N@zn.tnic>
References: <Y1ULKYsASLRoVb7N@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y1ULKYsASLRoVb7N@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.0_rc2
X-PR-Tracked-Commit-Id: 471f0aa7fa64e23766a1473b32d9ec3f0718895a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 295dad10bfb5bc35ef0d051aec61299ebeb88855
Message-Id: <166654552489.1521.3536145621729526418.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Oct 2022 17:18:44 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Oct 2022 11:36:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.0_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/295dad10bfb5bc35ef0d051aec61299ebeb88855

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
