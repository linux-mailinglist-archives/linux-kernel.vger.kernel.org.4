Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD18770A301
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjESW5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjESW5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:57:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3186099;
        Fri, 19 May 2023 15:57:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAC4965B4D;
        Fri, 19 May 2023 22:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A154C433D2;
        Fri, 19 May 2023 22:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684537050;
        bh=b1VXzCYjqb7tUyQrcWZVf1YOrL3eUyI/NGqoNJmQHFk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qW5/dCEh7/R1LQMafi3FaGYL3OVuthqLS5qKtaaLNkk4F7aSGYR3IwrXqM+U85C3g
         KaiowDvrquMCu2GMe+1OApKPManbK7K+fyBRgIp5Lks9b6zoHVKK12MlwYj+vC+7Z/
         I2NdWFfqVj9nSXvd1MVAm3y1U09TjkhS6xjolrm0lA3fgorJmTBGSxw8Ynt4oqfF+g
         0StqaPSH6M67xxZp/qeAMsS8JKss4qVpldno9SjbAQc5n0DAH14J7DD0PbuJ06IFIR
         wij7IjKmY04IP8rcvIS78Xp8N0iqyHUBF38bMtcYICXlmxZ4zUaRjVHQUHtXNPXL7H
         dygWBjKGc7Kxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19119C73FE0;
        Fri, 19 May 2023 22:57:30 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.4-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2238c5b07fdbaca34f4fdba4ad6c79ee3d214c7c.camel@HansenPartnership.com>
References: <2238c5b07fdbaca34f4fdba4ad6c79ee3d214c7c.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2238c5b07fdbaca34f4fdba4ad6c79ee3d214c7c.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 09e797c8641f6ad435c33ae24c223351197ea29a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5565ec4ef4f0d676fc8518556e239ac6945b5186
Message-Id: <168453705009.17720.1755453612238725125.pr-tracker-bot@kernel.org>
Date:   Fri, 19 May 2023 22:57:30 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 May 2023 17:25:27 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5565ec4ef4f0d676fc8518556e239ac6945b5186

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
