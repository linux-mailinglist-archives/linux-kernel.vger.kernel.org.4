Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB765F1DEA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 18:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiJAQwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 12:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJAQw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 12:52:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9328D356F0;
        Sat,  1 Oct 2022 09:52:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 583E360C71;
        Sat,  1 Oct 2022 16:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9D1DC433B5;
        Sat,  1 Oct 2022 16:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664643143;
        bh=irODRFp3x60NWQAwPWI+crzcJ4b5gYCuV3hJr2dInMk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NvRmZVktnoNwPebhfP4G3eg+di7LcTOex+ULhLdUQdnKdWVls62CUjZNsDll1cOZL
         i32O1pPaM6nWXa+95W14T6mxzRVvB679ICZzrzC79J9Q5PKJgrkD5tmkglePpwPPjL
         yKwhEZc9f4r0zH/DaYU5MAQmOfTmXYN+UJHObRJViMt/gSJUbvX3fW1HrYs7adiVjy
         oIi1RL6+C4QTZHWBOqZMtIXrzErO318mLzmOLtXCArQxRhPjxNY3KdOgqo3Sy237Zy
         bxf+K/AbWOjb30jWBEl5h52Be6DJNe5nN9WFaEmAKkQzgQ17Umhf3rn0SQijq2O/AP
         v8mPMUZzhnwEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3563E49FA5;
        Sat,  1 Oct 2022 16:52:23 +0000 (UTC)
Subject: Re: [GIT PULL for v6.0] media fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221001071245.6720babc@coco.lan>
References: <20221001071245.6720babc@coco.lan>
X-PR-Tracked-List-Id: <linux-media.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221001071245.6720babc@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.0-1
X-PR-Tracked-Commit-Id: 3a99c4474112f49a5459933d8758614002ca0ddc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89f2ddce78cc2a397065de8df509364d37c058da
Message-Id: <166464314366.22904.7563418232189241305.pr-tracker-bot@kernel.org>
Date:   Sat, 01 Oct 2022 16:52:23 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 1 Oct 2022 07:12:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.0-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89f2ddce78cc2a397065de8df509364d37c058da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
