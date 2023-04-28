Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07156F0FA2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 02:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344473AbjD1Abs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 20:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344667AbjD1Abd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:31:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97843C16
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:31:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18AA4640A9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DDC1C4339B;
        Fri, 28 Apr 2023 00:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682641891;
        bh=yQBYUeEWds65eDsZqLypvvncMG/gMCNpVIptuh3Jl/g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YxWqsX6TehvwKrSgrxe+kUpRIgAiJCIU2WhF2l4yoaJs5+7zCj5+ydh9LTP+AIm+R
         RmhxgO738sIFjNJZGStvbF497mhkm3c4qOffKLqN11TAUPv4noc3n08C9vkvQAUFOE
         SmA/f2OAaasA3WDMm3Td6p8n4dOt+JwahcGYp3Y9m/XCEbtwO3iGDqunzGrWETA3Q/
         FsxDX/qswRkps/sZYAaqT87SzsPePvSHooI2+HtoSq9PgRDSieKoAZb2YrlnzptfXy
         11EE6cuT+pf6I8PW7nls/O2v4tNbEtM3Tp+gXcXpXj2v7G0NtOHIouSBSS3Z2wPKp5
         GzKJMX6v7dxZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C499E5FFC8;
        Fri, 28 Apr 2023 00:31:31 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230427073808.12580-1-jgross@suse.com>
References: <20230427073808.12580-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230427073808.12580-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.4-rc1-tag
X-PR-Tracked-Commit-Id: cbfac7707ba16619006a4fd60faac46303fd2f3e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35fab9271b7e6d193b47005c4d07369714db4fd1
Message-Id: <168264189143.7031.13138758191360122835.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Apr 2023 00:31:31 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Apr 2023 09:38:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.4-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35fab9271b7e6d193b47005c4d07369714db4fd1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
