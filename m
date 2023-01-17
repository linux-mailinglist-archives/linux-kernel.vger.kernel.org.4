Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07B566D3B2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 01:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbjAQAso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 19:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbjAQAsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 19:48:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBD823654;
        Mon, 16 Jan 2023 16:48:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B67160FCA;
        Tue, 17 Jan 2023 00:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0999C433EF;
        Tue, 17 Jan 2023 00:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673916516;
        bh=dSQbhSZpWve2kmmvx4SyYICWr1OXdSQZdyF2WveH5gI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Byk+4+mJdKrV010tjeBE9gqANeWtJdAOk/a+i0CXi/5NASBGbGGB6nd3dZN+JJCKY
         jEC9On/yGepndIs+MpHX58YpFiPHtOAXKJffh/VPl6H2ojkHHyv3sNw0yzrDXssYhN
         qfdZRUMKwWIoMHwoeAPV7CJCvhd3nu29CPH4jeLeAZfZUPGMMGaPK8E8NKX1+tuQgO
         08NiEUAPKY5/Qyg+vVZBpq5hda5UNHD98EuUMQ4CxssenS7Y+BZya0/LVoWmuY8o6A
         TtnD6s8jjmwba6cIlLfE1ifpQtD24R+CB0dweW6zRqHNheyNFr9VLu4gBA/HHoybuO
         EpRu9wYHqxLOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD810E54D26;
        Tue, 17 Jan 2023 00:48:35 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.2-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230116152712.612b60d26b497d1d5749f4dc@linux-foundation.org>
References: <20230116152712.612b60d26b497d1d5749f4dc@linux-foundation.org>
X-PR-Tracked-List-Id: <mm-commits.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230116152712.612b60d26b497d1d5749f4dc@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-01-16-15-23
X-PR-Tracked-Commit-Id: 19fa92fb72f8bc542f1673862058f3b078114004
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e50979a9c87371fdb85d16058f9b5cb40751501
Message-Id: <167391651589.32211.8951868613037546097.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Jan 2023 00:48:35 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Jan 2023 15:27:12 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-01-16-15-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e50979a9c87371fdb85d16058f9b5cb40751501

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
