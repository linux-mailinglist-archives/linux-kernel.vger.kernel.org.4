Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B4973F133
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 05:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjF0DPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 23:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjF0DO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 23:14:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F1EE58
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 20:14:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 775A560FD0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEAA3C433C8;
        Tue, 27 Jun 2023 03:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687835695;
        bh=HZyX3VGyr8HmjzkZK+EkZ6R/a20i8r5luDsdNY+AurU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cnAI4yMM4fFtupMnq9WJd8L1n5IJ4f2fm0V9y2kfEE2MKMaAkLJXM3l+JSVBBNtwP
         kUM70iApA3JEAubwvjAGf+U4UHBwX4HrWfMO1XfswVVXh4uYRNxaLEu3NH3JGbPHBu
         beLuAo255d1tVZgcBnS6CvrLDzi4OelVkt68tLutuWvtA+MdTVxZxy+Gnv2PtSthzV
         ZA8bsWPwNb84egwwOxDtOVRQeD+8RBL2bz7LZjzQqiYVcpyXGm6BtX7r8PhNZJWwD+
         y+rvotav8BiN8JeThDRfozQi4S6yXStdteWI7XZasFcmuVsr35HAAzLa+Ru27Gffyb
         UMG8EseQqyA9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC21AE537FE;
        Tue, 27 Jun 2023 03:14:55 +0000 (UTC)
Subject: Re: [GIT PULL] chrome-platform changes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZJko2ipBSy8eM/+2@google.com>
References: <ZJko2ipBSy8eM/+2@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZJko2ipBSy8eM/+2@google.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v6.5
X-PR-Tracked-Commit-Id: 2b8cc5858a07ab75ce98cae720e263e1c1b0d1d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ef6663a587ba3e57dc5065a477db1c64481eedd
Message-Id: <168783569576.18094.6541808729976898231.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 03:14:55 +0000
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     torvalds@linux-foundation.org, pmalani@chromium.org,
        bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 13:57:46 +0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ef6663a587ba3e57dc5065a477db1c64481eedd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
