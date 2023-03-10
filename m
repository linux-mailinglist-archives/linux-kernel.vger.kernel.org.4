Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DDE6B4DD6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjCJRAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjCJRAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:00:13 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A688C5AD2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:58:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B2623CE29D5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1101DC4339C;
        Fri, 10 Mar 2023 16:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678467491;
        bh=kwM21xhk7G7fTmTDdea+n+uRzVWAm9irNixHTfQ7jcg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LU6L/dAQbztIk3GVxzLER4oxvbygY53X8MzneuFHzGjsBwpIEU4EzBAwI2MS+4Nwc
         gEINdUlLJ3Ysm6gnaF+3m3a7ibEE5p9rO9Mw+xg/IPkTDPAnRaDE49/e+Q8Aw7spUq
         mnGAd2GVURnW5eFV79uGA0FCqohmxkNNWu5h/oFYOuLTB1AMOPYuB1w3EanTfSOVN2
         gVg01oFiMyRjtOSoCssn5aGuQ8XZLxLEA4EMwH1mHjkvkU3pUeU9h5rrmbGrJKpz1C
         xjbldmJtDNdYVkZvsI7HH03FeRb9umjd+sCQ636nkCqOk8i+2gv3JDisaCiTnr5neP
         UZVA2l7deNnqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF0E8E21EEB;
        Fri, 10 Mar 2023 16:58:10 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.3-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZAtdbhFmLD4MCRk+@debian>
References: <ZAtdbhFmLD4MCRk+@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZAtdbhFmLD4MCRk+@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.3-rc2-fixes
X-PR-Tracked-Commit-Id: 3993f4f456309580445bb515fbc609d995b6a3ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 388a810192fd383acce6933e7f272dd6a6802bb0
Message-Id: <167846749097.19444.4560208674172683124.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Mar 2023 16:58:10 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Yangtao Li <frank.li@vivo.com>, Yue Hu <huyue2@coolpad.com>,
        Chao Yu <chao@kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 11 Mar 2023 00:40:14 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.3-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/388a810192fd383acce6933e7f272dd6a6802bb0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
