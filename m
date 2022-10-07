Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14A55F726A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 03:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiJGBBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 21:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiJGBBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 21:01:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DA1B97AC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 18:01:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64F58617A1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 01:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA8CFC433D6;
        Fri,  7 Oct 2022 01:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665104493;
        bh=y8/Z5EWFjv6b/39lwwqLkSGGqYC+ap0/foBw1cyF+7E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r+/VtCG0c6Uq+BYGlxuZ/ILapvYbbubSalPO0HtElik1vpqwuqtXHRkCPlU44T60T
         tR50gEPUljeVJuenrUzcrE7u2x630fvgbg3+lIp+ItOyKyhocfEJeme89W7W9YID6i
         m6byhsyeh97rlcSGg7mGP1yuI7MKKqaDS4ad+SqwPzARS15wmijBNf01HRVjcJVGwq
         wm6+zI0lkdbUAEj4Qu/ief+7+3sG8aE632JyS8iUpDXBeMqnRi/veIHgw3MDhl9ff5
         jAdoN1gbm9Nm5C5hAq6Af45gKqiD7Pl+rTsKkZ601JvSwOxTjZ2AE2BNHu2l90Q3b0
         IlDksBaH0zeyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B874FE2A05E;
        Fri,  7 Oct 2022 01:01:33 +0000 (UTC)
Subject: Re: [GIT PULL] AFFS update for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1664865843.git.dsterba@suse.com>
References: <cover.1664865843.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1664865843.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git affs-for-6.1-tag
X-PR-Tracked-Commit-Id: 505ffcc852401aaac4dfb57c16bec0f7838c0e00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f198ba7ae9874c64ffe8cd3aa60cf5dab78ce3a
Message-Id: <166510449375.27686.14977367782430206682.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 01:01:33 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  4 Oct 2022 08:46:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git affs-for-6.1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f198ba7ae9874c64ffe8cd3aa60cf5dab78ce3a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
