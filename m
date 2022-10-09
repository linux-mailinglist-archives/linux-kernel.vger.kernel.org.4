Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB36F5F8EEB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 23:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiJIVSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 17:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiJIVRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 17:17:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AE413EB6
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 14:17:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5F91DCE0B58
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 21:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86564C4347C;
        Sun,  9 Oct 2022 21:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665350237;
        bh=D74XGDY0AjKTNtkw0xUbEB6QSJ1u5+Xpx3ddWubXG80=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gGMq9knbUi4Ax+zO3B5ZTyymLExoMlwEdI1AU4dSszEWjPw8AedXjgqpUgaNZbPGE
         c8DHkgeKvMJ3+7znCo6K8gTvruKiVZnyA5BkC5UMHfk8LDeH7zLcC3Che1+0LMK8fw
         ZznZTYge2XFnyoCAA542bJRoS6LCbMOQMr3ZTUCs8ag5iSvoCPy4ttbMBBtwZhtFGX
         YhjD4pW4IAbxj6clavzi9fPkhZTTZFrgyiB8xbZRVhfeiJZdFM8YAc66A56VlCn5Qm
         ULWur7nfXQKyNdHiaotwYZph9RlTmq68gE6gxtpMqm11abFYB/gFNpmgmdqj/W4OPN
         h+cn9C0D7ouPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 747AFE21EC5;
        Sun,  9 Oct 2022 21:17:17 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-1 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87edvhntv0.fsf@mpe.ellerman.id.au>
References: <87edvhntv0.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87edvhntv0.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.1-1
X-PR-Tracked-Commit-Id: 376b3275c19f83d373e841e9af2d7658693190b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4899a36f91a9f9b06878471096bd143e7253006d
Message-Id: <166535023747.11566.620649606369998979.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Oct 2022 21:17:17 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, ajd@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        christophe.leroy@csgroup.eu, cuigaosheng1@huawei.com,
        david@redhat.com, farosas@linux.ibm.com, geoff@infradead.org,
        gustavoars@kernel.org, haren@linux.ibm.com, hbathini@linux.ibm.com,
        joel@jms.id.au, lihuafei1@huawei.com, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, linuxppc-dev@lists.ozlabs.org,
        lukas.bulwahn@gmail.com, mikey@neuling.org, nathan@kernel.org,
        nathanl@linux.ibm.com, nicholas@linux.ibm.com, npiggin@gmail.com,
        pali@kernel.org, paul@paul-moore.com, rmclure@linux.ibm.com,
        ruscur@russell.cc, windhl@126.com,
        wsa+renesas@sang-engineering.com, ye.xingchen@zte.com.cn,
        yuanjilin@cdjrlc.com, zhengyongjun3@huawei.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 09 Oct 2022 22:01:39 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4899a36f91a9f9b06878471096bd143e7253006d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
