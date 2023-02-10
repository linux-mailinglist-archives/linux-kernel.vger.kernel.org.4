Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6863B6924DB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjBJRxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbjBJRwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:52:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AC073967;
        Fri, 10 Feb 2023 09:52:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 372D3B82599;
        Fri, 10 Feb 2023 17:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F088CC433EF;
        Fri, 10 Feb 2023 17:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676051572;
        bh=aejXX2XP1RnJc4D3YEkcpf4KlWn7gAJWavb6bPxEj+s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=C26i7GNbajjnankqlO+Mdir1fv/4mwszeGqOtm0MbXnesJyHx77sthhaLgnRVKO9P
         mDf4kggzzF+1DKX+qqEa4oCnyFOEbagWd+KscQP78+DhMzE/XmXwQAXZXZPrau+kNF
         1mjhvtgTuL5QG7YByh1aZi+HkM4T3BH1/OPwQNVl25Hks3/g8YVIE50mCMvYYTKS/t
         L9W20WwiRCJwLVDbmaWyx2papGgNt1ROVFQ2IcYVt61XxTi3EjFjstnWXLAQiTnYQH
         ZJFjlQLLaGYEcSdM7+8vT8/kUdPA/PnpBG6YMFUC2g8rr95KiHt/+2Vru74SSseCG0
         X/3hnl7NFxLRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDFEFE55EFD;
        Fri, 10 Feb 2023 17:52:51 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fix for 6.2-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230210162112.534456-1-idryomov@gmail.com>
References: <20230210162112.534456-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230210162112.534456-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.2-rc8
X-PR-Tracked-Commit-Id: e7d84c6a1296d059389f7342d9b4b7defb518d3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3647d2d70640ff85be60793fa4b204bdae26ca44
Message-Id: <167605157190.13061.2206193348034712340.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Feb 2023 17:52:51 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Feb 2023 17:21:12 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.2-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3647d2d70640ff85be60793fa4b204bdae26ca44

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
