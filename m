Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1D573EED8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjFZWyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjFZWyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:54:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD80E199
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:54:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 523F660F9D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B56E9C433C0;
        Mon, 26 Jun 2023 22:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687820049;
        bh=zVXR+eBOxe6PJ8Kj7qEJhkb4ot3liAlxH4NILLKAt6Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tMuWh0li5nQ7wmpF4+SnGc+VnglhgAEs/H5E0bXIZt3qE16gOlc6f1cZTUotFDo+l
         9dxla66UovSQPYQN7jY9sVy+vTuOLaUpUQVJCIv5kGIlxHWFVQYQqeYrMDeKS9g7dY
         mB+8VsSVl/gJ2Vo0BTKUsRs3pOyS2WCQI/9qO+Pmyv6NYGJ51IzdQSu7/vg6nbEAh8
         nAez59UmJU6tOoFN60aNoJfNokbDSo1aIIbyMk3a4rqG7+f0jlkv2f5GjVdkDI+1um
         nO0XVv/iU3S+1lDfJzUXrFD0m4ApvS90KG4MG+0ZXjjnzxMNpLvq6aYSpHrGRabNaj
         Gf5dkPPp7miQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5403C43170;
        Mon, 26 Jun 2023 22:54:09 +0000 (UTC)
Subject: Re: [GIT PULL] RAS updates for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626125103.GBZJmJtwLDs7j3GSJw@fat_crate.local>
References: <20230626125103.GBZJmJtwLDs7j3GSJw@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626125103.GBZJmJtwLDs7j3GSJw@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.5
X-PR-Tracked-Commit-Id: 4251566ebc1cf95ae26a1e5a24cdac1ac25e942f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa35a4835e4f4c113c29bc7ea64cfecb951d51b8
Message-Id: <168782004967.10634.6030337862891484847.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 22:54:09 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 14:51:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa35a4835e4f4c113c29bc7ea64cfecb951d51b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
