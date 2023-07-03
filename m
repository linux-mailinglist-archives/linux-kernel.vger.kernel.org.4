Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17D0746410
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 22:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjGCUaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 16:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjGCUaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 16:30:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEA6AF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 13:30:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C8456103C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 20:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82934C433CA;
        Mon,  3 Jul 2023 20:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688416203;
        bh=fYGf6/P6PCwU0c5wqiJ4jgnTY8peRRZdVZc8FpDWnUE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A0FQpGAS0jemYryQxtad/7vhv53PjwFXIN3FWCaC5yMtWRMYk9I8xQkNfdY2QE0vb
         OlfXwvYRv+rWZp4JmfeFWOIyi2At0mXlWhC+AJ4VBNG2IspzYP0m9laGYplBb4b0/Y
         BuFPHYNLmg1eLFItFSvqDEx6dhH0z8RlszNjy+5MCD7QLBmVyn/lkVM8EvRdOmw0+w
         4Ytbq9rdf32lERPCJsP421x+85zbvT7xQOy86oUxe4H+LXV1kOGXpEZszc2+HURRUV
         qHA9QyhFnaooTKlfysX3srKJVeh5ZsjCQW+hVXhzsXmk4JjpjHY69d475m+l7KX+zE
         uE5t7hKOUklVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6577CC561EE;
        Mon,  3 Jul 2023 20:30:03 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver updates for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZKKeWkpCEqxHZ7qK@kroah.com>
References: <ZKKeWkpCEqxHZ7qK@kroah.com>
X-PR-Tracked-List-Id: <linux-staging.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZKKeWkpCEqxHZ7qK@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.5-rc1
X-PR-Tracked-Commit-Id: 4a22870cede374d80c5d2f9c5b79253a5a667832
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db9c6d1d7fcc6dc803f042bf3d29bbff91837f57
Message-Id: <168841620338.1331.16390344819968928844.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Jul 2023 20:30:03 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Jul 2023 12:09:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db9c6d1d7fcc6dc803f042bf3d29bbff91837f57

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
