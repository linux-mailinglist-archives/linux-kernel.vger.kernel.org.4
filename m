Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CDE69D59C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 22:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjBTVMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 16:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjBTVMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 16:12:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD87C1D92D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 13:12:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A369260EFE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 21:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DCD9C433D2;
        Mon, 20 Feb 2023 21:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676927504;
        bh=2rLYfRCcCLPopVZzced5ClDRYrFbfbCWJPitYY2V3Ec=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IlCSkZ26i3+T3k9vBQ6snswDqq3+ZVr7ipO0diVrBtIF1BAPt5xXiBZkUdXgttICE
         HJQu16J+FljA0L2AziHDFXRy9MT+60qlGEUaUNhaEHXCN3twyqH6K6uwWrd0VNRqpk
         hok4H1M9Xm+vhCEh/UPFby1yq/mYhkZpTfrqjKJbTW0l68ZYBxc9Tfj8m7fb1QSQYP
         qkdRVOAdyU6bNnHxEQkvlHNTptEf4CtjMbhGSZkHOZ6kx5Cy4v+0iMC9DdxsUJS5I8
         ud/kEsxyUsIAHMQXoAvgh1Atu1hCt5hMLMix9E0FUrGgyjiU0Kq1We6bq48+PdzuuF
         W0GH5oMX9yiwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0D3BC43161;
        Mon, 20 Feb 2023 21:11:43 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/Li4s7qPOArhcSm@debian>
References: <Y/Li4s7qPOArhcSm@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/Li4s7qPOArhcSm@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.3-rc1
X-PR-Tracked-Commit-Id: 8d1b80a79452630f157bf634ae9cfcd9f4eed161
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc483c851ff9a3505069cb326221dc0242d44015
Message-Id: <167692750398.16986.2751628578621415778.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Feb 2023 21:11:43 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Yue Hu <huyue2@coolpad.com>, Yangtao Li <frank.li@vivo.com>,
        Dan Carpenter <error27@gmail.com>, Chao Yu <chao@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 11:02:58 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc483c851ff9a3505069cb326221dc0242d44015

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
