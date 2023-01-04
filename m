Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FCB65DD89
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240139AbjADURs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbjADURm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:17:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033811007
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:17:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 976EA61826
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 20:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C549C433D2;
        Wed,  4 Jan 2023 20:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672863461;
        bh=V/h2BGMSlFlP8mJJwcYSUkI5kKvoGSa/rxCqiwWC9Rw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KcofHTeV6n2TWsRXHlGRg/3w7e3QraZA0Ko42wD3BPq5Ty94iEzAjjQGubX9M/TN8
         1sTh4ul5/KNJgmPke9ZBuOz9jdUU/3G16zpBkOp7iB74ye92NAZRdzJ2zUUbm4ZVRd
         AmqoDQ1tUZbUCQNWn0PlZOGKROX11wBQA4D9xQAqDL6Y7FL6P5XHgZZrnFa9NEBKI4
         lFzUkoFc5hysu/I8Q3w/2xl0VYqoFZklwcCFKGZWV4tNHNp4KcBQeHQ+nvk2V8qVL7
         8RnkTCcmBpax3Q4l+wR2+mNnw+QmJ9GU4xdgBwZEGhzvZ13UYt+Kr7+D/Y0yxt5++R
         o6GUyani4MH1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DEDFEC395DF;
        Wed,  4 Jan 2023 20:17:40 +0000 (UTC)
Subject: Re: [GIT PULL] f2fs fix for 6.2-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y7XH7fSoURcqoUQW@google.com>
References: <Y7XH7fSoURcqoUQW@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y7XH7fSoURcqoUQW@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-fix-6.2-rc3
X-PR-Tracked-Commit-Id: df9d44b645b83fffccfb4e28c1f93376585fdec8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ac44821a81612317f4451b765986d8b9695d5d5
Message-Id: <167286346090.24547.11166270720309340106.pr-tracker-bot@kernel.org>
Date:   Wed, 04 Jan 2023 20:17:40 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 4 Jan 2023 10:39:41 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-fix-6.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ac44821a81612317f4451b765986d8b9695d5d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
