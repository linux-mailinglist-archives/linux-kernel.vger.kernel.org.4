Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6CC5F7253
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 02:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiJGAhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 20:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbiJGAgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 20:36:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82636A2AB3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 17:36:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC12261B36
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50EF7C433D6;
        Fri,  7 Oct 2022 00:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665103006;
        bh=/TUV4JsrlmmLeaNhTQcmFIv59TzuNN7ewdC9IGppXCE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gVIjIifl9unHFYQWSXRo/ODsaOUHCX1QBUmy0MauGQViwGfGt1zk+OjhmZcYZ0NMZ
         UkuzZHTx0l/1+Z9lUlNQ5SAAkqf4mM1X+n1RouaRY8vz7OgtS8GrBEDbt7mVYJSUsx
         xB96cYT5ttJ9LucO51Bw+18Q+UHA4sZgRy7yhnxYLCWyHSAflNSGe9pZoL2utrEkfH
         AvOsD1OzbZHnlqwQoniXrzBVw1F4fcyTPTaCvsdh4q82AEBL+exs2YBU5v7uR8aVAd
         fsMgzcet6tovoe93Kcbs1tdLOhYHFdHE9DgIaIpouiL8UYBpIr5neynLW8AtZKsUOK
         BSfDwxekOzZiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3DE5FE2A05E;
        Fri,  7 Oct 2022 00:36:46 +0000 (UTC)
Subject: Re: [git pull] vfs.git pile 5 (misc tomoyo)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzxmAydeCAIquyut@ZenIV>
References: <YzxmAydeCAIquyut@ZenIV>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzxmAydeCAIquyut@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-tomoyo
X-PR-Tracked-Commit-Id: 467cf8ef88d3124c189e2ff4726fe5247a88fe46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1586a7036d3f0e7dd29a3090b9dfa4eb2c15f12c
Message-Id: <166510300624.12004.7449857185480777082.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 00:36:46 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 Oct 2022 17:57:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-tomoyo

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1586a7036d3f0e7dd29a3090b9dfa4eb2c15f12c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
