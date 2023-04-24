Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BBF6ED58C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 21:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjDXTt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 15:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjDXTtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:49:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B056589;
        Mon, 24 Apr 2023 12:49:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 751C2628C8;
        Mon, 24 Apr 2023 19:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD0BBC433EF;
        Mon, 24 Apr 2023 19:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682365742;
        bh=lKKVpKhUbM6Hgwfd2VivsiOonwGFlzaXjY3kicfqv7c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=C3mToSZU88p5vtWHOswm13tSIrWuET+daWO6x14H/7ZWJiWlwD6W8jYiBTHTG8+Mt
         OylcEoV4CgZYbUJZQOA75HsSTdWpeC7HulRD6S+mMlj72KjXsfVKuwemwT5KnqgWqV
         +/3e8HQ4DJIiIvHHQKA+oXxtOL7/RAKMRuwtaGZ5Cj6aynli8MmjW4TYZN4V11koaI
         fxIrA4ZIWw21RiOSKCg/ikpR7q6G5uqwdNkDZzX/aBJlIwom295snPh2do1FvLHDKG
         SQILv471rovZCbC8yZFmvo1SWZo6jtnYxbDmJWEDiTMNUvnzd54pfmdW62NxJoGYZG
         iistHHibq8eTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C93CEE5FFC7;
        Mon, 24 Apr 2023 19:49:02 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87edo9m82m.fsf@meer.lwn.net>
References: <87edo9m82m.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <87edo9m82m.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.4
X-PR-Tracked-Commit-Id: 7e8472c820f04517ae5d5a27c1aecfa2263a0aa5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c23f28975abc2eb02cecc8bc1f2c95473a59ed2e
Message-Id: <168236574281.6990.4645097250893085809.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Apr 2023 19:49:02 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 12:46:57 -0600:

> git://git.lwn.net/linux.git tags/docs-6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c23f28975abc2eb02cecc8bc1f2c95473a59ed2e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
