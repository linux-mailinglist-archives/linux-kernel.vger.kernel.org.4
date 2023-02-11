Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7926669334C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 20:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBKTYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 14:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBKTYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 14:24:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B064EF9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 11:24:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1789160B9A
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 19:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F49DC433D2;
        Sat, 11 Feb 2023 19:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676143477;
        bh=f1/MCAEk3UT9rygPRWm8Noqdz34TrNJb9N9hXLor+kE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MqBcQ1v9HYqD1eujbb7jDTzRg7OKZMzrIoM8krv+7Uovd+NC9jOUuJ3/ogFUTh5+y
         2/NPlNra9tqVApyQNSGEjcIJo9EnISvBw8ZTyJeflypfku1wDvxlJ8ZE/aC8WSFxTY
         jHTk/zpyjFzWIN889XXqfVHEJKwyKcYgbGkv/jP4J/YCXc9FeRP7ngY/CTYpHQSDdM
         0+q5VJ4pNtQN8nS657NnNhJwK2qNNNIcFgr4/2qo5+iYFT/tt6D6Zw1/buqFrgPlpz
         5+t5J99jpYfBu18AyIt9jgqVsc28CHQwz/jWROQJ7Mngl6YzfPhS8s77O5azb2Onqg
         tZRO2jaQU1qFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59237E55EFD;
        Sat, 11 Feb 2023 19:24:37 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y+dY6DLyJsOMyf87@gmail.com>
References: <Y+dY6DLyJsOMyf87@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y+dY6DLyJsOMyf87@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-02-11
X-PR-Tracked-Commit-Id: f545e8831e70065e127f903fc7aca09aa50422c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47e9aa14ce5abca70d6584a8d8213707d197c38e
Message-Id: <167614347735.24193.5253001457377259542.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Feb 2023 19:24:37 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 11 Feb 2023 09:59:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-02-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47e9aa14ce5abca70d6584a8d8213707d197c38e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
