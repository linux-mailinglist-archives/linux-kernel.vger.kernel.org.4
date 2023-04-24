Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE9C6ED58E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 21:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjDXTuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 15:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjDXTtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:49:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259936185
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 12:49:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3CC9628C6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 19:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 249D2C4339C;
        Mon, 24 Apr 2023 19:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682365745;
        bh=etKACYtou8lE52XkH+H2xXXf8GfNT5ht0WZpRgrwznQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=auUNv8U8B/s+pXv7GZpsgfPWpLrFzH/8sOFPFIWpKCNX0aNwZyApRHOVdF3yIq2cn
         gXyG6+wozBq+AUSePPQ3+DON9tfL6hpp6iAru8m6dSjC59SXa0FNk9gE4mDJDrApcU
         7ofgvfyZUKheUv4Pe6UAtgH4RyTQ059PMd5lZ3bG+hnjlTx9pG5mxMzyUqgvA5+itG
         hxali6viMyV9tmOihHSgCWA+2vXy4qv4EnIBR1MZEWl39m3HD9KfMEMrJVJnBulWRP
         Xy/irpZ0B1djtMH499i1FD9NYYuiNAgklsSA1GI22iRJjzhRFS4aXkk1H4arGg0TmT
         W/iOPgttpjXcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1374EE5FFC7;
        Mon, 24 Apr 2023 19:49:05 +0000 (UTC)
Subject: Re: [GIT PULL] LKMM scripting changes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d5f5cb7e-312e-49d5-b6f7-ebbcec1e4d13@paulmck-laptop>
References: <d5f5cb7e-312e-49d5-b6f7-ebbcec1e4d13@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d5f5cb7e-312e-49d5-b6f7-ebbcec1e4d13@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm-scripting.2023.04.07a
X-PR-Tracked-Commit-Id: cc4a29819b0df9f3a2e7e0d5dee0830a3072d5aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 60eb45074234b90333b6241b4fd8d196aa2dfd98
Message-Id: <168236574507.6990.6030543374497291222.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Apr 2023 19:49:05 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, stern@rowland.harvard.edu,
        yangtiezhu@loongson.cn, parri.andrea@gmail.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Apr 2023 16:12:26 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm-scripting.2023.04.07a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/60eb45074234b90333b6241b4fd8d196aa2dfd98

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
