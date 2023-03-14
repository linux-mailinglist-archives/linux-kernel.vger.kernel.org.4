Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7286B9E00
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjCNSNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjCNSNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:13:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866B88ABCF;
        Tue, 14 Mar 2023 11:13:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2149761879;
        Tue, 14 Mar 2023 18:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85D46C433D2;
        Tue, 14 Mar 2023 18:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678817594;
        bh=AnGgtSPzBRKLrDam5NAp1ca6zEEeQ95nNXo4T1itm+4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j6T5MpV7zN07htIpi5I3A+7hBcCBFZPkVRVl6aRmkt8VOck3M4BSZxAYJ66r0uQAb
         N5jbtdMMz9y5wrisc0nI9uZtwrDEwpoW6yMq/2/qaJyajwqV2wsySI5erpI7ra+C5z
         xTtq+x9b0saWeaZJAlPMGXNSLt7g5o7ZixQzpjhxASRcDK7jGJ/f92cfhHK0W+9KJh
         t4LIup2ADoZxnxE4VUA+oFvTVC67JZ2qoyBKz46blPeiQgyxUOExse65+omZ8zD2Hf
         nCEJjX3+1HcsLnqhuoWfiOw4MJYzA9qMOvbyaEcM+PEZ7OhbtomfHeHfrVFtqy9qh4
         zjv7FzR9q3jBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 702CCE66CB8;
        Tue, 14 Mar 2023 18:13:14 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation fixes for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <874jqntes0.fsf@meer.lwn.net>
References: <874jqntes0.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <874jqntes0.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.3-fixes
X-PR-Tracked-Commit-Id: d7ba3657d5162bd551e5c653f67f941c94a7dc0a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4979bf8668255a67449714653314662fbc7e5bdb
Message-Id: <167881759443.21884.17446336243460735904.pr-tracker-bot@kernel.org>
Date:   Tue, 14 Mar 2023 18:13:14 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 14 Mar 2023 11:37:51 -0600:

> git://git.lwn.net/linux.git tags/docs-6.3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4979bf8668255a67449714653314662fbc7e5bdb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
