Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C1F6F5F1E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjECT2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjECT2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:28:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0817083FA;
        Wed,  3 May 2023 12:28:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DBAA62EE1;
        Wed,  3 May 2023 19:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1018C433EF;
        Wed,  3 May 2023 19:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683142119;
        bh=2+6//41UnsZ0NRb+M6VfjLkslk9hY8QGID7aNF7/OwM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FjY4H3uv8iF4SbIoXgEVfsfN4fbrrf2OlUUKmdfrwEg1H022EDnaswgn0d/UF/890
         BNmKWHK2N/xc8jEoY7/+ZtDLq2uGAtrCry7v7XaeTlt8Ri8Qccqs8M8IHb5DxZKhW+
         I6WQ26IsS1R3B1U6Mi5tojwav6IreiPyC1IaTbyyaenlSUQJrLz8Uttjtvxpg7jV9s
         caXMnUAQRCJ4EmlamCD6fNhOKJUCjEsxbqIFXU3STy9NXJyYsjnMHOBJb8V4qLt8v8
         mIvAOiG//rF1GS9IBzk2d7pOhk/377Su2+gLQ4W8TCbSTDYJSEtx8E19Jjom04hkAe
         1jTCid9W8hjSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2BA5E5FFC9;
        Wed,  3 May 2023 19:28:39 +0000 (UTC)
Subject: Re: [GIT PULL] More power management updates for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jVsrTH6=-YaXfqy3T8Q_mdZ_bDKHigtPXQqLFag8JBug@mail.gmail.com>
References: <CAJZ5v0jVsrTH6=-YaXfqy3T8Q_mdZ_bDKHigtPXQqLFag8JBug@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jVsrTH6=-YaXfqy3T8Q_mdZ_bDKHigtPXQqLFag8JBug@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.4-rc1-2
X-PR-Tracked-Commit-Id: 57ea3ab21c14e6f04db2b0878e8a5be644fa3769
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa31fc82fb775445c176e576304c4098222f47f2
Message-Id: <168314211979.24310.16231360508944159172.pr-tracker-bot@kernel.org>
Date:   Wed, 03 May 2023 19:28:39 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 May 2023 16:27:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.4-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa31fc82fb775445c176e576304c4098222f47f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
