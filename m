Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AF05FAB55
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 05:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJKDne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 23:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJKDnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 23:43:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADE87C754
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:43:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4F2161093
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 03:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46139C433D6;
        Tue, 11 Oct 2022 03:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665459794;
        bh=V0Gw5eFHwWhdruihaitv8HhwZs38DRG6OiqYy/mi/y8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BuU7y0qhw5XwCtOFBiZDqVfxsJ0Jcvrr0Sfx5B1i3tQbbj5JLrYCkaoKvvKuOeTpA
         HImopIM49h8rYpzB3xkFz7WC95Q4fBGqdqtXuzKQl6e4ExnGKw+Chxxjaa2ClD1XUh
         VwDL89Ae+AiQbJnmSwKGsOqSOdzoyIVKPMgy2oqltoHye5pHA8sOkzJGyqNDjt8quI
         PZYj28ha1tDCnwDz/WmP2eqlAobT5Q02FpagTi6zvx7gUR8rsdFz42NW2+On9NHBbR
         hyrhutSpKPAMT13+yjqLvfCOntcZNFpKyiHFxhrx49XOwEYWXMtESW7two82X42FEI
         j56YkQEI6dsIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3090AE270E4;
        Tue, 11 Oct 2022 03:43:14 +0000 (UTC)
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0RV6kXCyXtqYuS4@google.com>
References: <Y0RV6kXCyXtqYuS4@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <Y0RV6kXCyXtqYuS4@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.1-rc1
X-PR-Tracked-Commit-Id: b4dac1203f39821c6119033cdeebcea83cf45786
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d170fe435e54cafa599a21521ea65fe9535f537
Message-Id: <166545979419.4678.7423127526476737144.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Oct 2022 03:43:14 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Oct 2022 10:27:06 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d170fe435e54cafa599a21521ea65fe9535f537

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
