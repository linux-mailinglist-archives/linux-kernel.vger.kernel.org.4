Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA8B71F4ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjFAVlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjFAVlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:41:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78146196
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:41:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE29D64A78
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 21:40:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55A12C433D2;
        Thu,  1 Jun 2023 21:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685655640;
        bh=EmFaRNESXp24m392Z9FFvkoAt9Tu3v3zI6uBJPBkC6Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jfsjUMgrZrYffmfnH+gs5nB+jSsZWoDLwz/CmvgSpmxU/rzfT3sAamAXMrQpK3s4x
         qqG18TydL8PPvMSJ2U5xrHRSpso1p6d3cVAKenrhVJDYmPs5tjNQ8P7TKfVVuQS6vn
         s2Xvglhj4nQMQFu7JP3PZf8RskhbszOLPct8idQH/cW0MISxiVFwgmARrXDrkMS1UJ
         mLph9FQd+MU69IGlqe4eHoA4GneK+o7GYU56l9mc1ZmM0C1R7xw6Q+SrO7WL8fzQGM
         p5A70HLEw5cejh5HRElIJA/6npN+SZpTdaH0FTWXfuTkdUdI/+19Ze7jA+erUk49S6
         3uphIRA9VbCAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D8E6E52C02;
        Thu,  1 Jun 2023 21:40:40 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.4-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230601180906.238637-1-kuba@kernel.org>
References: <20230601180906.238637-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230601180906.238637-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.4-rc5
X-PR-Tracked-Commit-Id: a451b8eb96e521ebabc9c53fefa2bcfad6f80f25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 714069daa5d345483578e2ff77fb6f06f4dcba6a
Message-Id: <168565564024.17545.9325041927544084632.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Jun 2023 21:40:40 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  1 Jun 2023 11:09:06 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/714069daa5d345483578e2ff77fb6f06f4dcba6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
