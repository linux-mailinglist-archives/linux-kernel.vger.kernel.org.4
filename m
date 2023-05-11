Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131AC6FF3D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237708AbjEKOP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238464AbjEKOPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:15:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DD0106CB
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:15:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BC0864E16
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 14:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9410BC433D2;
        Thu, 11 May 2023 14:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683814440;
        bh=iTLtntyrKHslW5mtXuPtDYxS2hfFDvk0H3QzEpmOT84=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rhJTDEFr4Ekg4Ffq3/SwGzPxEajfVCJuMxJLHh6GbmvkcY8r09souB1qmmOsq1PmI
         kNLz1JbKJyCsp7yCY/VJZQXUuxVkPSPbCHFGOYvq+MGcPcMYJ2acSTqMASjqdxOVDo
         jFHjKfsTTU/BuwyieP2u0byMKLCHPQ6No3bZx9g7O0NGNEmvVyiEg4QWRije7oSnGz
         B8BZOTo0MYxEGwAhpcTZ58k411FUqrrtqkmT08VLV6NHVf1qu+cRpJgmu+BDrOfY09
         5MAPBQwokDAIBwthjID9vs/1J8YxNRNGWPDYV7BSKo8MsRvSWQwggHWj5xyeoJQEbl
         YTSx1Nvzu915A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81551E450BA;
        Thu, 11 May 2023 14:14:00 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 6.4-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230511104342.18276-1-pabeni@redhat.com>
References: <20230511104342.18276-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230511104342.18276-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.4-rc2
X-PR-Tracked-Commit-Id: cceac9267887753f3c9594f1f7b92237cb0f64fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e27831b91a0bc572902eb065b374991c1ef452a
Message-Id: <168381444052.1327.14606144770579574822.pr-tracker-bot@kernel.org>
Date:   Thu, 11 May 2023 14:14:00 +0000
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 May 2023 12:43:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.4-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e27831b91a0bc572902eb065b374991c1ef452a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
