Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA7264A5FF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 18:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbiLLReP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 12:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbiLLRdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:33:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D299613E19
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 09:33:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BC2FB80DDF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 17:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E81CC433D2;
        Mon, 12 Dec 2022 17:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670866402;
        bh=oMfAzIPQfpmef/EMg5bPJQ1N84Xpef0yJz2+mKFumIM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jMgjpk6TaYhq96x9O9aL9Ixe8QyKD8hv0lczaWCuKa3H3PspkLJBX6nKXrB1b1iWr
         cnbX7HwFz66GlAqEDphLMLM1PLmF1zdAZKRDgt9RlZxFJT7u+WKFMNjzP6kby4+pT1
         TzTvF/UkWmnIgWBsC0Z77HCbjIP+LZfOugd35ermjGa+7TrtAzenr0/NLQrg3O7bXV
         0zxGxjRkDxS6853UkuidVOwpGnXylMkc0iXkBlVpwrP4iLJwckoaUA2Pe3VrPGa1/i
         x884eTPU8hMGl0QslS+UNPVF8aMrFsmWZHFglQagoc8UVNFq3rhM2nY6Cag6IIT1fo
         xKufBG3RGwevA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BA49C00448;
        Mon, 12 Dec 2022 17:33:22 +0000 (UTC)
Subject: Re: [GIT PULL] pstore updates for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202212051623.33FD7D5@keescook>
References: <202212051623.33FD7D5@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202212051623.33FD7D5@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.2-rc1
X-PR-Tracked-Commit-Id: e6b842741b4f39007215fd7e545cb55aa3d358a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 059c4a341df7dbaab0a30a8e5420b619518f8887
Message-Id: <167086640224.22610.2122318571050555106.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 17:33:22 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Colin Cross <ccross@android.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Paramjit Oberoi <pso@chromium.org>,
        Qiujun Huang <hqjagain@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        Wang Yufen <wangyufen@huawei.com>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 5 Dec 2022 16:24:44 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/059c4a341df7dbaab0a30a8e5420b619518f8887

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
