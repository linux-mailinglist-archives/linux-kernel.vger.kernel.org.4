Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2782F64AE74
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 04:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiLMDuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 22:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbiLMDtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 22:49:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2490D1E3CB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 19:49:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B531160010
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26AEAC433F1;
        Tue, 13 Dec 2022 03:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670903378;
        bh=We0XaXUqQHe0tjY9zy3E7dN1dJlIbCKqvcamd3XP2bQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qYhQOXqy/9f+fFm5+wPHDUxDNLfy7I/d+SxdtXfb7PrL0qKerWWe2jTMTlVhINEk9
         wEPT05awFymAKXgk22uEN7vtA/IyqS2zjSn52fWFUF1HpDBcl+RAlmKH3UWr/IHSP3
         RBCb91s+4LKj/AbvA59NexAlqvVG49oevkDlU1nLiSYB+GHbBGtKKojOIfSyooBn2Q
         TCZrtbR1ESVNKwLKQlc6XoIwNRtsn+9QBmUsNI8sJ+f8gcOzlALaM4fgqVZsCq4svi
         TNSeljvl0kYBTAx+Azo1JChPMHsTUK3J5Y8hiwlULxdt4pIy9swp8VbAWxrIpc6pzz
         ciTQospU76Ttg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14C1BC395EE;
        Tue, 13 Dec 2022 03:49:38 +0000 (UTC)
Subject: Re: [git pull] vfs.git alpha pile
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5Z1YcCcrCGs/CIk@ZenIV>
References: <Y5Z1YcCcrCGs/CIk@ZenIV>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5Z1YcCcrCGs/CIk@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-alpha
X-PR-Tracked-Commit-Id: fa6a3bf7ff3734ff13764d1b9e36c48f93eb3677
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 268369b171ff1be6a68ae8f33d0602c6bea48d2e
Message-Id: <167090337808.3662.3036400591017363754.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 03:49:38 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 00:27:13 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-alpha

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/268369b171ff1be6a68ae8f33d0602c6bea48d2e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
