Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F0164AEEB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 06:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbiLMFBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 00:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiLMFAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 00:00:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5D31DF06
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:00:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B204B80E04
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 05:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3680FC433EF;
        Tue, 13 Dec 2022 05:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670907611;
        bh=tgquSFO3EMDZ6wt5lb3LFjKaGzBC0H9z3whmK4epp20=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NFiP/3iHpGLqsb7kyxqUlXft9/H9srYeazSJDe9WRCAmzgc5IwUaSmmgUx2GfvL94
         GFfypG9p+lg6EJIj5CGakR+SVL3NK4Kip9JYbJEky3ivkKd7PHRcrRNnVepIybAJvR
         DbYZpXX71ZisL2VMbPKN1RJNTWF4mKX+ZHz0/bnW865aBEOtwsvGL2L1rlms/XMSd1
         4CRhdxSA1KGqJv2tU9l+he9ZRA5to52Oa1EUjQDIsCV2tSjsXspPTjNU8OQV0ECQCt
         UTEqGsNFWQPd4xVAwOgdxKX0QhPKlNJXn9dgVyUdNTil8TR0DQh9pwGk8RUbLR7Sgw
         gL5fXL/UxpvSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FF4FC395EE;
        Tue, 13 Dec 2022 05:00:11 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.2-rc1 (fscache part inclusive)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5TB6E77vbpRMhIk@debian>
References: <Y5TB6E77vbpRMhIk@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5TB6E77vbpRMhIk@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.2-rc1
X-PR-Tracked-Commit-Id: c505feba4c0d76084e56ec498ce819f02a7043ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a6bff1187409f2c2ba1b17234541d314f0680fc
Message-Id: <167090761112.4886.12716661902911748332.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 05:00:11 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Hou Tao <houtao1@huawei.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 11 Dec 2022 01:29:12 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a6bff1187409f2c2ba1b17234541d314f0680fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
